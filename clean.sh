K8S_CLUSTER_PROJECT=~/github.com/sasadangelo/k8s-cluster
declare -a CLUSTER_MACHINES=("k8s-master" "k8s-worker-1" "k8s-worker-2")

clean_host_folders()
{
    cd $K8S_CLUSTER_PROJECT
    for machine in "${CLUSTER_MACHINES[@]}"
    do
        echo "Cleanup files in $machine:/pgdata"
        PORT=$(vagrant ssh-config $machine | grep Port | grep -o '[0-9]\+')
        ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $K8S_CLUSTER_PROJECT/.vagrant/machines/$machine/virtualbox/private_key vagrant@localhost -p $PORT "sudo rm -rf /mnt/pgdata"
    done
    cd -
}

clean_host_folders
