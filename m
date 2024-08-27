Return-Path: <stable+bounces-70583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DE960EE2
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A161C233A0
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9ED1BFE04;
	Tue, 27 Aug 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL+No3Dp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997373466;
	Tue, 27 Aug 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770389; cv=none; b=ohqXH2PZIOcFs6ctmfqLU7D13TsbQQjIt8f3xlsmLV3+Ee6YkGKYibE1bfhg4UdQTrp21c4gqIAzuYUT1y3dt0SsC4PF14puMcpU1ViHsDakTWE1O1Y4SJGtt+22XLqIoJCbCpzUEleBRqRhh8AzVAW5qX+hDeG3ZECK7BSrdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770389; c=relaxed/simple;
	bh=vP4e8yuV2WJxTKkzP95ZfZ5Tq6MuKuSBlYncqfh0Qi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAMwBoqywdyyNTsQUB38k9Q12NILDs0Q8poBQus3+vF+dfxbJxQ4nenk6dmItVjvSoMg8p/rmVLfe4OQDbnHiTA5Y+YCfNWm+puVmiuXy4kM7DIQskESEPcVzVij83GEEX4JbtqSCL8STYFTCLDUUAlCo/ghtsqJOw7rncGEV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL+No3Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065EBC61042;
	Tue, 27 Aug 2024 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770389;
	bh=vP4e8yuV2WJxTKkzP95ZfZ5Tq6MuKuSBlYncqfh0Qi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HL+No3Dpuo6nvoEQkcCXfY1yRSDnKfJN0eu5iR432GzNpvGrKHj4g+lqMtMcZb0Nw
	 4LF9RAsDtlkEY/aMRchp/wBsd5Jnf4K7EnTuyVhDKvWMTcHaPBj9X8UwvrJMVbrzY2
	 CxiiafTFYCd3ecileQHiy1RWQqX031TnzlODVS2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 214/341] nvme: use srcu for iterating namespace list
Date: Tue, 27 Aug 2024 16:37:25 +0200
Message-ID: <20240827143851.554561049@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit be647e2c76b27f409cdd520f66c95be888b553a3 ]

The nvme pci driver synchronizes with all the namespace queues during a
reset to ensure that there's no pending timeout work.

Meanwhile the timeout work potentially iterates those same namespaces to
freeze their queues.

Each of those namespace iterations use the same read lock. If a write
lock should somehow get between the synchronize and freeze steps, then
forward progress is deadlocked.

We had been relying on the nvme controller state machine to ensure the
reset work wouldn't conflict with timeout work. That guarantee may be a
bit fragile to rely on, so iterate the namespace lists without taking
potentially circular locks, as reported by lockdep.

Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev/
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      | 99 +++++++++++++++++++++--------------
 drivers/nvme/host/ioctl.c     | 15 +++---
 drivers/nvme/host/multipath.c | 21 ++++----
 drivers/nvme/host/nvme.h      |  4 +-
 4 files changed, 83 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e39a58a00458..2a1b555406dff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -632,7 +632,7 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static inline bool nvme_get_ns(struct nvme_ns *ns)
+bool nvme_get_ns(struct nvme_ns *ns)
 {
 	return kref_get_unless_zero(&ns->kref);
 }
@@ -3542,9 +3542,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
 			if (!nvme_get_ns(ns))
 				continue;
@@ -3554,7 +3555,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
@@ -3568,7 +3569,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 
 	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
 		if (tmp->head->ns_id < ns->head->ns_id) {
-			list_add(&ns->list, &tmp->list);
+			list_add_rcu(&ns->list, &tmp->list);
 			return;
 		}
 	}
@@ -3634,17 +3635,18 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_update_ns_info(ns, info))
 		goto out_unlink_ns;
 
-	down_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
 	/*
 	 * Ensure that no namespaces are added to the ctrl list after the queues
 	 * are frozen, thereby avoiding a deadlock between scan and reset.
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
-		up_write(&ctrl->namespaces_rwsem);
+		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
 	nvme_ns_add_to_ctrl_list(ns);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
 	nvme_get_ctrl(ctrl);
 
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
@@ -3660,9 +3662,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
-	down_write(&ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -3712,9 +3715,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	mutex_lock(&ns->ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_lock);
+	synchronize_srcu(&ns->ctrl->srcu);
 
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
@@ -3804,16 +3808,17 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	down_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid)
-			list_move_tail(&ns->list, &rm_list);
+			list_splice_init_rcu(&ns->list, &rm_list,
+					     synchronize_rcu);
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
-
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
@@ -3983,9 +3988,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
+	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -4418,6 +4424,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
+	cleanup_srcu_struct(&ctrl->srcu);
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4449,10 +4456,15 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
+	mutex_init(&ctrl->namespaces_lock);
+
+	ret = init_srcu_struct(&ctrl->srcu);
+	if (ret)
+		return ret;
+
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
-	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -4531,6 +4543,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
+	cleanup_srcu_struct(&ctrl->srcu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
@@ -4539,22 +4552,24 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mark_disk_dead(ns->disk);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
 
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
@@ -4562,14 +4577,15 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
@@ -4577,23 +4593,25 @@ EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mq_freeze_queue_wait(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
@@ -4636,11 +4654,12 @@ EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 4939ed35638f1..875dee6ecd408 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -921,15 +921,15 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 		bool open_for_write)
 {
 	struct nvme_ns *ns;
-	int ret;
+	int ret, srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	if (list_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
 		goto out_unlock;
 	}
 
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+	ns = list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
 	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
 		dev_warn(ctrl->device,
 			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
@@ -939,15 +939,18 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
-	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	if (!nvme_get_ns(ns)) {
+		ret = -ENXIO;
+		goto out_unlock;
+	}
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 
 	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
 
 out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return ret;
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6515fa537ee53..645a6b1322205 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -151,16 +151,17 @@ void nvme_mpath_end_request(struct request *rq)
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
 		if (ctrl->state == NVME_CTRL_LIVE)
 			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
 static const char *nvme_ana_state_names[] = {
@@ -194,13 +195,14 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		nvme_mpath_clear_current_path(ns);
 		kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
@@ -679,6 +681,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	int srcu_idx;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -690,8 +693,8 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		unsigned nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
@@ -704,7 +707,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (ns->head->ns_id > nsid)
 			goto again;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 21c24cd8b1e8a..d2b6975e71fbc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -280,7 +280,8 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct mutex namespaces_lock;
+	struct srcu_struct srcu;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 #ifdef CONFIG_NVME_HWMON
@@ -1126,6 +1127,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
+bool nvme_get_ns(struct nvme_ns *ns);
 void nvme_put_ns(struct nvme_ns *ns);
 
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
-- 
2.43.0




