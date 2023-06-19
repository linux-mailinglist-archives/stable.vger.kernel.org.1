Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4F735356
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFSKo0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjFSKnw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD60BE60
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55AB560B85
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F7DC433C8;
        Mon, 19 Jun 2023 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171417;
        bh=LuRqj0u4fFuHWOXOvde4zWNX4JzHeWFDWX4s7L7Nz70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKrrFfpKIgQM+e+AowrZ8CA3d3fFpWWDyVRaIUXM4Hqsw6Zv7GvPj+DAWw1jtHBuc
         VE17BOaoyPimlhI48eImP2kClhfVnMXtnP3LMc5yz6MlD4HYkjlQ6Xj/HPNmReXZpw
         iVo/wwBO301l/BpM/hyS0z2fjtRPX5sg1pOhDJKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/166] cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
Date:   Mon, 19 Jun 2023 12:28:01 +0200
Message-ID: <20230619102154.851520230@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kamalesh Babulal <kamalesh.babulal@oracle.com>

[ Upstream commit 4cdb91b0dea7d7f59fa84a13c7753cd434fdedcf ]

Replace mutex_[un]lock() with cgroup_[un]lock() wrappers to stay
consistent across cgroup core and other subsystem code, while
operating on the cgroup_mutex.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 2bd110339288 ("cgroup: always put cset in cgroup_css_set_put_fork")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cgroup.c        | 38 ++++++++++++------------
 kernel/bpf/cgroup_iter.c   |  4 +--
 kernel/bpf/local_storage.c |  4 +--
 kernel/cgroup/cgroup-v1.c  | 16 +++++-----
 kernel/cgroup/cgroup.c     | 60 +++++++++++++++++++-------------------
 5 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 819f011f0a9cd..b86b907e566ca 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -173,11 +173,11 @@ void bpf_cgroup_atype_put(int cgroup_atype)
 {
 	int i = cgroup_atype - CGROUP_LSM_START;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (--cgroup_lsm_atype[i].refcnt <= 0)
 		cgroup_lsm_atype[i].attach_btf_id = 0;
 	WARN_ON_ONCE(cgroup_lsm_atype[i].refcnt < 0);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 #else
 static enum cgroup_bpf_attach_type
@@ -282,7 +282,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 
 	unsigned int atype;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
 		struct hlist_head *progs = &cgrp->bpf.progs[atype];
@@ -315,7 +315,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_cgroup_storage_free(storage);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -729,9 +729,9 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -831,7 +831,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 
 	cg_link = container_of(link, struct bpf_cgroup_link, link);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	/* link might have been auto-released by dying cgroup, so fail */
 	if (!cg_link->cgroup) {
 		ret = -ENOLINK;
@@ -843,7 +843,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	}
 	ret = __cgroup_bpf_replace(cg_link->cgroup, cg_link, new_prog);
 out_unlock:
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1009,9 +1009,9 @@ static int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_detach(cgrp, prog, NULL, type);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1120,9 +1120,9 @@ static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1189,11 +1189,11 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	if (!cg_link->cgroup)
 		return;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/* re-check cgroup under lock again */
 	if (!cg_link->cgroup) {
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 		return;
 	}
 
@@ -1205,7 +1205,7 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	cg = cg_link->cgroup;
 	cg_link->cgroup = NULL;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	cgroup_put(cg);
 }
@@ -1232,10 +1232,10 @@ static void bpf_cgroup_link_show_fdinfo(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (cg_link->cgroup)
 		cg_id = cgroup_id(cg_link->cgroup);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	seq_printf(seq,
 		   "cgroup_id:\t%llu\n"
@@ -1251,10 +1251,10 @@ static int bpf_cgroup_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (cg_link->cgroup)
 		cg_id = cgroup_id(cg_link->cgroup);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	info->cgroup.cgroup_id = cg_id;
 	info->cgroup.attach_type = cg_link->type;
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index c187a9e62bdbb..d57ccb02477f8 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -58,7 +58,7 @@ static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct cgroup_iter_priv *p = seq->private;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/* cgroup_iter doesn't support read across multiple sessions. */
 	if (*pos > 0) {
@@ -89,7 +89,7 @@ static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
 {
 	struct cgroup_iter_priv *p = seq->private;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	/* pass NULL to the prog for post-processing */
 	if (!v) {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 098cf336fae6e..f01ca6f1ee031 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -333,14 +333,14 @@ static void cgroup_storage_map_free(struct bpf_map *_map)
 	struct list_head *storages = &map->list;
 	struct bpf_cgroup_storage *storage, *stmp;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	list_for_each_entry_safe(storage, stmp, storages, list_map) {
 		bpf_cgroup_storage_unlink(storage);
 		bpf_cgroup_storage_free(storage);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	WARN_ON(!RB_EMPTY_ROOT(&map->root));
 	WARN_ON(!list_empty(&map->list));
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 52bb5a74a23b9..aeef06c465ef1 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -58,7 +58,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	struct cgroup_root *root;
 	int retval = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	cgroup_attach_lock(true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
@@ -72,7 +72,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 			break;
 	}
 	cgroup_attach_unlock(true);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	return retval;
 }
@@ -106,7 +106,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	if (ret)
 		return ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	percpu_down_write(&cgroup_threadgroup_rwsem);
 
@@ -145,7 +145,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 out_err:
 	cgroup_migrate_finish(&mgctx);
 	percpu_up_write(&cgroup_threadgroup_rwsem);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -847,13 +847,13 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 	kernfs_break_active_protection(new_parent);
 	kernfs_break_active_protection(kn);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
 		TRACE_CGROUP_PATH(rename, cgrp);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	kernfs_unbreak_active_protection(kn);
 	kernfs_unbreak_active_protection(new_parent);
@@ -1119,7 +1119,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	trace_cgroup_remount(root);
 
  out_unlock:
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1246,7 +1246,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	if (!ret && !percpu_ref_tryget_live(&ctx->root->cgrp.self.refcnt))
 		ret = 1;	/* restart */
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	if (!ret)
 		ret = cgroup_do_get_tree(fc);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2319946715e0c..002e563ec2ac8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1385,7 +1385,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	cgroup_favor_dynmods(root, false);
 	cgroup_exit_root_id(root);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	cgroup_rstat_exit(cgrp);
 	kernfs_destroy_root(root->kf_root);
@@ -1619,7 +1619,7 @@ void cgroup_kn_unlock(struct kernfs_node *kn)
 	else
 		cgrp = kn->parent->priv;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	kernfs_unbreak_active_protection(kn);
 	cgroup_put(cgrp);
@@ -1664,7 +1664,7 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	if (drain_offline)
 		cgroup_lock_and_drain_offline(cgrp);
 	else
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 
 	if (!cgroup_is_dead(cgrp))
 		return cgrp;
@@ -2161,13 +2161,13 @@ int cgroup_do_get_tree(struct fs_context *fc)
 		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
 
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 		spin_lock_irq(&css_set_lock);
 
 		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
 
 		spin_unlock_irq(&css_set_lock);
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(fc->root);
@@ -2350,13 +2350,13 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	return ret;
 }
@@ -2382,7 +2382,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 	int hierarchy_id = 1;
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	root = idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
@@ -2396,7 +2396,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 	}
 
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(task_cgroup_path);
@@ -3107,7 +3107,7 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 	int ssid;
 
 restart:
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
 		for_each_subsys(ss, ssid) {
@@ -3121,7 +3121,7 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 			prepare_to_wait(&dsct->offline_waitq, &wait,
 					TASK_UNINTERRUPTIBLE);
 
-			mutex_unlock(&cgroup_mutex);
+			cgroup_unlock();
 			schedule();
 			finish_wait(&dsct->offline_waitq, &wait);
 
@@ -4370,9 +4370,9 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	if (!(cfts[0].flags & __CFTYPE_ADDED))
 		return -ENOENT;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = cgroup_rm_cftypes_locked(cfts);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -4404,14 +4404,14 @@ static int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 	if (ret)
 		return ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	list_add_tail(&cfts->node, &ss->cfts);
 	ret = cgroup_apply_cftypes(cfts, true);
 	if (ret)
 		cgroup_rm_cftypes_locked(cfts);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -5380,7 +5380,7 @@ static void css_release_work_fn(struct work_struct *work)
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
@@ -5421,7 +5421,7 @@ static void css_release_work_fn(struct work_struct *work)
 					 NULL);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
@@ -5769,7 +5769,7 @@ static void css_killed_work_fn(struct work_struct *work)
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	do {
 		offline_css(css);
@@ -5778,7 +5778,7 @@ static void css_killed_work_fn(struct work_struct *work)
 		css = css->parent;
 	} while (css && atomic_dec_and_test(&css->online_cnt));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 
 /* css kill confirmation processing requires process context, bounce */
@@ -5962,7 +5962,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	pr_debug("Initializing cgroup subsys %s\n", ss->name);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	idr_init(&ss->css_idr);
 	INIT_LIST_HEAD(&ss->cfts);
@@ -6006,7 +6006,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	BUG_ON(online_css(css));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 
 /**
@@ -6066,7 +6066,7 @@ int __init cgroup_init(void)
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/*
 	 * Add init_css_set to the hash table so that dfl_root can link to
@@ -6077,7 +6077,7 @@ int __init cgroup_init(void)
 
 	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	for_each_subsys(ss, ssid) {
 		if (ss->early_init) {
@@ -6129,9 +6129,9 @@ int __init cgroup_init(void)
 		if (ss->bind)
 			ss->bind(init_css_set.subsys[ssid]);
 
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 		css_populate_dir(init_css_set.subsys[ssid]);
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 	}
 
 	/* init_css_set.subsys[] has been updated, re-hash */
@@ -6236,7 +6236,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	for_each_root(root) {
@@ -6291,7 +6291,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	retval = 0;
 out_unlock:
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	kfree(buf);
 out:
 	return retval;
@@ -6375,7 +6375,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct file *f;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 
 	cgroup_threadgroup_change_begin(current);
 
@@ -6450,7 +6450,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 err:
 	cgroup_threadgroup_change_end(current);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	if (f)
 		fput(f);
 	if (dst_cgrp)
@@ -6477,7 +6477,7 @@ static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 		struct cgroup *cgrp = kargs->cgrp;
 		struct css_set *cset = kargs->cset;
 
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 
 		if (cset) {
 			put_css_set(cset);
-- 
2.39.2



