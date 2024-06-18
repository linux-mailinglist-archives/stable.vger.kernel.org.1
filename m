Return-Path: <stable+bounces-53121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C4A90D047
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1001F24167
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22D155301;
	Tue, 18 Jun 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bk4tKO1I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828B13A245;
	Tue, 18 Jun 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715390; cv=none; b=fgaeBxwm5UuKzdPHdpnKWlonykj1VJSGv6Yu0BBUQ+5uG0E7xkyMqhBXJPwvu5xfH/VJVp/tDLI31bRODRj5qlCJIrREmw1yIHxttRpC4w48pQkm8Jh8O3StgychscZ/00HXcXn9LGW7PuPTGOoXCJaLHh6GkoPPaNdfNmnOrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715390; c=relaxed/simple;
	bh=+iM6Ec5IpuJhUBDmpXuaEKLLn6SHqWKXDrK/G8qVUnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqz8PULp9lQOgEk+lB4yAOLWyAFGDDToYp1EhNxuSxnhir18yykfFK8djKkJkx4WhUCSBNEZHrIu9wyyxlNwhCWE06yMDEdDBFVjjjjZOjUKKNDtQ8cLX5r7W+i5BiBtDgfIoL1p9kXzJFAOjQLONJ9zawvhFClcyCXQsSrsqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bk4tKO1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28BBC32786;
	Tue, 18 Jun 2024 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715390;
	bh=+iM6Ec5IpuJhUBDmpXuaEKLLn6SHqWKXDrK/G8qVUnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bk4tKO1IksdIL/xzP1lyDrijSvtteuXa28Y4Y9TPXq64uo+0e41Njq+KPn5d1aleD
	 +yi8LksAumsREfeR4pWdL5iQEKytWioq7GNtvmcVvd+jwo/UL7EmXQ5cK1Z4NeI36x
	 TXE6x2IVel7E8hGvxyvq0hxzLwD/5u0XLEvyxyqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 293/770] NFSD: delay unmount sources export after inter-server copy completed.
Date: Tue, 18 Jun 2024 14:32:26 +0200
Message-ID: <20240618123418.572699468@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit f4e44b393389c77958f7c58bf4415032b4cda15b ]

Currently the source's export is mounted and unmounted on every
inter-server copy operation. This patch is an enhancement to delay
the unmount of the source export for a certain period of time to
eliminate the mount and unmount overhead on subsequent copy operations.

After a copy operation completes, a work entry is added to the
delayed unmount list with an expiration time. This list is serviced
by the laundromat thread to unmount the export of the expired entries.
Each time the export is being used again, its expiration time is
extended and the entry is re-inserted to the tail of the list.

The unmount task and the mount operation of the copy request are
synced to make sure the export is not unmounted while it's being
used.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h         |   6 ++
 fs/nfsd/nfs4proc.c      | 135 ++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c     |  71 +++++++++++++++++++++
 fs/nfsd/nfsd.h          |   4 ++
 fs/nfsd/nfssvc.c        |   3 +
 include/linux/nfs_ssc.h |  14 +++++
 6 files changed, 229 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index a75abeb1e6988..935c1028c2175 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -176,6 +176,12 @@ struct nfsd_net {
 	unsigned int             longest_chain_cachesize;
 
 	struct shrinker		nfsd_reply_cache_shrinker;
+
+	/* tracking server-to-server copy mounts */
+	spinlock_t              nfsd_ssc_lock;
+	struct list_head        nfsd_ssc_mount_list;
+	wait_queue_head_t       nfsd_ssc_waitq;
+
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 };
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index aa0da0737a3ff..573c550e7aceb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -55,6 +55,13 @@ module_param(inter_copy_offload_enable, bool, 0644);
 MODULE_PARM_DESC(inter_copy_offload_enable,
 		 "Enable inter server to server copy offload. Default: false");
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
+module_param(nfsd4_ssc_umount_timeout, int, 0644);
+MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
+		"idle msecs before unmount export from source server");
+#endif
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
 
@@ -1168,6 +1175,81 @@ extern void nfs_sb_deactive(struct super_block *sb);
 
 #define NFSD42_INTERSSC_MOUNTOPS "vers=4.2,addr=%s,sec=sys"
 
+/*
+ * setup a work entry in the ssc delayed unmount list.
+ */
+static int nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
+		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *work = NULL;
+	struct nfsd4_ssc_umount_item *tmp;
+	DEFINE_WAIT(wait);
+
+	*ss_mnt = NULL;
+	*retwork = NULL;
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+try_again:
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
+			continue;
+		/* found a match */
+		if (ni->nsui_busy) {
+			/*  wait - and try again */
+			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
+				TASK_INTERRUPTIBLE);
+			spin_unlock(&nn->nfsd_ssc_lock);
+
+			/* allow 20secs for mount/unmount for now - revisit */
+			if (signal_pending(current) ||
+					(schedule_timeout(20*HZ) == 0)) {
+				kfree(work);
+				return nfserr_eagain;
+			}
+			finish_wait(&nn->nfsd_ssc_waitq, &wait);
+			goto try_again;
+		}
+		*ss_mnt = ni->nsui_vfsmount;
+		refcount_inc(&ni->nsui_refcnt);
+		spin_unlock(&nn->nfsd_ssc_lock);
+		kfree(work);
+
+		/* return vfsmount in ss_mnt */
+		return 0;
+	}
+	if (work) {
+		strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
+		refcount_set(&work->nsui_refcnt, 2);
+		work->nsui_busy = true;
+		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
+		*retwork = work;
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+	return 0;
+}
+
+static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
+		struct nfsd4_ssc_umount_item *work, struct vfsmount *ss_mnt)
+{
+	/* set nsui_vfsmount, clear busy flag and wakeup waiters */
+	spin_lock(&nn->nfsd_ssc_lock);
+	work->nsui_vfsmount = ss_mnt;
+	work->nsui_busy = false;
+	wake_up_all(&nn->nfsd_ssc_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+
+static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
+		struct nfsd4_ssc_umount_item *work)
+{
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_del(&work->nsui_list);
+	wake_up_all(&nn->nfsd_ssc_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+	kfree(work);
+}
+
 /*
  * Support one copy source server for now.
  */
@@ -1184,6 +1266,8 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	char *ipaddr, *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
+	struct nfsd4_ssc_umount_item *work = NULL;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	naddr = &nss->u.nl4_addr;
 	tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
@@ -1232,12 +1316,23 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
+	status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
+	if (status)
+		goto out_free_devname;
+	if (ss_mnt)
+		goto out_done;
+
 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
 	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
 	module_put(type->owner);
-	if (IS_ERR(ss_mnt))
+	if (IS_ERR(ss_mnt)) {
+		if (work)
+			nfsd4_ssc_cancel_dul_work(nn, work);
 		goto out_free_devname;
-
+	}
+	if (work)
+		nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
+out_done:
 	status = 0;
 	*mount = ss_mnt;
 
@@ -1297,10 +1392,42 @@ static void
 nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 			struct nfsd_file *dst)
 {
+	bool found = false;
+	long timeout;
+	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
+
 	nfs42_ssc_close(src->nf_file);
-	fput(src->nf_file);
 	nfsd_file_put(dst);
-	mntput(ss_mnt);
+	fput(src->nf_file);
+
+	if (!nn) {
+		mntput(ss_mnt);
+		return;
+	}
+	spin_lock(&nn->nfsd_ssc_lock);
+	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
+			list_del(&ni->nsui_list);
+			/*
+			 * vfsmount can be shared by multiple exports,
+			 * decrement refcnt. If the count drops to 1 it
+			 * will be unmounted when nsui_expire expires.
+			 */
+			refcount_dec(&ni->nsui_refcnt);
+			ni->nsui_expire = jiffies + timeout;
+			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
+			found = true;
+			break;
+		}
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+	if (!found) {
+		mntput(ss_mnt);
+		return;
+	}
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 09967037eb1a3..3dd6e25d5d90f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -44,6 +44,7 @@
 #include <linux/jhash.h>
 #include <linux/string_helpers.h>
 #include <linux/fsnotify.h>
+#include <linux/nfs_ssc.h>
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -5522,6 +5523,69 @@ static bool state_expired(struct laundry_time *lt, time64_t last_refresh)
 	return false;
 }
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
+{
+	spin_lock_init(&nn->nfsd_ssc_lock);
+	INIT_LIST_HEAD(&nn->nfsd_ssc_mount_list);
+	init_waitqueue_head(&nn->nfsd_ssc_waitq);
+}
+EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
+
+/*
+ * This is called when nfsd is being shutdown, after all inter_ssc
+ * cleanup were done, to destroy the ssc delayed unmount list.
+ */
+static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
+{
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		list_del(&ni->nsui_list);
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ni->nsui_vfsmount);
+		kfree(ni);
+		spin_lock(&nn->nfsd_ssc_lock);
+	}
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+
+static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
+{
+	bool do_wakeup = false;
+	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *tmp;
+
+	spin_lock(&nn->nfsd_ssc_lock);
+	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (time_after(jiffies, ni->nsui_expire)) {
+			if (refcount_read(&ni->nsui_refcnt) > 1)
+				continue;
+
+			/* mark being unmount */
+			ni->nsui_busy = true;
+			spin_unlock(&nn->nfsd_ssc_lock);
+			mntput(ni->nsui_vfsmount);
+			spin_lock(&nn->nfsd_ssc_lock);
+
+			/* waiters need to start from begin of list */
+			list_del(&ni->nsui_list);
+			kfree(ni);
+
+			/* wakeup ssc_connect waiters */
+			do_wakeup = true;
+			continue;
+		}
+		break;
+	}
+	if (do_wakeup)
+		wake_up_all(&nn->nfsd_ssc_waitq);
+	spin_unlock(&nn->nfsd_ssc_lock);
+}
+#endif
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5631,6 +5695,10 @@ nfs4_laundromat(struct nfsd_net *nn)
 		list_del_init(&nbl->nbl_lru);
 		free_blocked_lock(nbl);
 	}
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	/* service the server-to-server copy delayed unmount list */
+	nfsd4_ssc_expire_umount(nn);
+#endif
 out:
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
@@ -7546,6 +7614,9 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_shutdown_umount(nn);
+#endif
 }
 
 void
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 14dbfa75059d5..9664303afdaf3 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -484,6 +484,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 extern int nfsd4_is_junction(struct dentry *dentry);
 extern int register_cld_notifier(void);
 extern void unregister_cld_notifier(void);
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
+#endif
+
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 731d89898903a..373695cc62a7a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -403,6 +403,9 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_filecache;
 
+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
+	nfsd4_ssc_init_umount_work(nn);
+#endif
 	nn->nfsd_net_up = true;
 	return 0;
 
diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
index f5ba0fbff72fe..222ae8883e854 100644
--- a/include/linux/nfs_ssc.h
+++ b/include/linux/nfs_ssc.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/nfs_fs.h>
+#include <linux/sunrpc/svc.h>
 
 extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
 
@@ -52,6 +53,19 @@ static inline void nfs42_ssc_close(struct file *filep)
 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
 }
+
+struct nfsd4_ssc_umount_item {
+	struct list_head nsui_list;
+	bool nsui_busy;
+	/*
+	 * nsui_refcnt inited to 2, 1 on list and 1 for consumer. Entry
+	 * is removed when refcnt drops to 1 and nsui_expire expires.
+	 */
+	refcount_t nsui_refcnt;
+	unsigned long nsui_expire;
+	struct vfsmount *nsui_vfsmount;
+	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
+};
 #endif
 
 /*
-- 
2.43.0




