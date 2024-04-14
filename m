Return-Path: <stable+bounces-37617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8872889C5B5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1261C2178A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790877EF14;
	Mon,  8 Apr 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yachh4Qr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767B7C6C9;
	Mon,  8 Apr 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584759; cv=none; b=el+4F2N8S+aZxJZuzsXRUhkPHa5Caz0d4OFFWWaW2Kvnz2daA5wLWCnhD/Do30Ylxyr55sjbV+IvJ4187LjDpXjW+6mvD0QHFvrCzDODkG6Trlrjg1/nNKVP3pU+JGo4xI9JmwCv+XZIK+OLcRLvAX0lTeP2eibUbrb2H0rhhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584759; c=relaxed/simple;
	bh=goQu6Fwmm03WHdwy6mr4rWZYPwSvZw306hI7H47pSUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9lLAhnZjj+RmP1lIb0MEM5ZZU50kGIOPlSdNF+uBElvjj/v1bIJAIz/VK+WnibLNV8gUVaX9VM8Lq801cV+kUAMdsqNn9FGP/Fm61w/5StPzzlKTXfmjitjrk1NHOA90UV3GkhRj+8ddwV7jcsYSqXZ+qWc0+5bMW+5+pJ3UWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yachh4Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3220C433C7;
	Mon,  8 Apr 2024 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584759;
	bh=goQu6Fwmm03WHdwy6mr4rWZYPwSvZw306hI7H47pSUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yachh4QrKTUy0Wosgk4Wu799FobEyqpkVLX593JHd23pRtoA0qCsxR3SWxz8jtJln
	 PHL7pJIId5w8xR6/NMeggv0RMXuaCbvXYHVubVk2gmSds+nyUk9M4NuxnGUmvm7nxb
	 fVh/wkwLj4fEhoI5wbZFk4mibXAYLncS4qpc1xzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH 5.15 517/690] NFSD: enhance inter-server copy cleanup
Date: Mon,  8 Apr 2024 14:56:23 +0200
Message-ID: <20240408125418.368504213@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit df24ac7a2e3a9d0bc68f1756a880e50bfe4b4522 ]

Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
server's export when the mount completes. After the copy is done
nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
server and it searches nfsd_ssc_mount_list for a matching entry
to do the clean up.

The problems with this approach are (1) the need to search the
nfsd_ssc_mount_list and (2) the code has to handle the case where
the matching entry is not found which looks ugly.

The enhancement is instead of nfsd4_setup_inter_ssc returning the
vfsmount, it returns the nfsd4_ssc_umount_item which has the
vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
it's passed with the nfsd4_ssc_umount_item directly to do the
clean up so no searching is needed and there is no need to handle
the 'not found' case.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ cel: adjusted whitespace and variable/function names ]
Reviewed-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c      | 111 ++++++++++++++++------------------------
 fs/nfsd/xdr4.h          |   2 +-
 include/linux/nfs_ssc.h |   2 +-
 3 files changed, 46 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ea71af276c7b..6fb5f10602233 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
  * setup a work entry in the ssc delayed unmount list.
  */
 static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
-		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
+				  struct nfsd4_ssc_umount_item **nsui)
 {
 	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *work = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 	DEFINE_WAIT(wait);
+	__be32 status = 0;
 
-	*ss_mnt = NULL;
-	*retwork = NULL;
+	*nsui = NULL;
 	work = kzalloc(sizeof(*work), GFP_KERNEL);
 try_again:
 	spin_lock(&nn->nfsd_ssc_lock);
@@ -1327,12 +1327,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
 			goto try_again;
 		}
-		*ss_mnt = ni->nsui_vfsmount;
+		*nsui = ni;
 		refcount_inc(&ni->nsui_refcnt);
 		spin_unlock(&nn->nfsd_ssc_lock);
 		kfree(work);
 
-		/* return vfsmount in ss_mnt */
+		/* return vfsmount in (*nsui)->nsui_vfsmount */
 		return 0;
 	}
 	if (work) {
@@ -1340,31 +1340,32 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
-		*retwork = work;
-	}
+		*nsui = work;
+	} else
+		status = nfserr_resource;
 	spin_unlock(&nn->nfsd_ssc_lock);
-	return 0;
+	return status;
 }
 
-static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
-		struct nfsd4_ssc_umount_item *work, struct vfsmount *ss_mnt)
+static void nfsd4_ssc_update_dul(struct nfsd_net *nn,
+				 struct nfsd4_ssc_umount_item *nsui,
+				 struct vfsmount *ss_mnt)
 {
-	/* set nsui_vfsmount, clear busy flag and wakeup waiters */
 	spin_lock(&nn->nfsd_ssc_lock);
-	work->nsui_vfsmount = ss_mnt;
-	work->nsui_busy = false;
+	nsui->nsui_vfsmount = ss_mnt;
+	nsui->nsui_busy = false;
 	wake_up_all(&nn->nfsd_ssc_waitq);
 	spin_unlock(&nn->nfsd_ssc_lock);
 }
 
-static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
-		struct nfsd4_ssc_umount_item *work)
+static void nfsd4_ssc_cancel_dul(struct nfsd_net *nn,
+				 struct nfsd4_ssc_umount_item *nsui)
 {
 	spin_lock(&nn->nfsd_ssc_lock);
-	list_del(&work->nsui_list);
+	list_del(&nsui->nsui_list);
 	wake_up_all(&nn->nfsd_ssc_waitq);
 	spin_unlock(&nn->nfsd_ssc_lock);
-	kfree(work);
+	kfree(nsui);
 }
 
 /*
@@ -1372,7 +1373,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
  */
 static __be32
 nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
-		       struct vfsmount **mount)
+		       struct nfsd4_ssc_umount_item **nsui)
 {
 	struct file_system_type *type;
 	struct vfsmount *ss_mnt;
@@ -1383,7 +1384,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	char *ipaddr, *dev_name, *raw_data;
 	int len, raw_len;
 	__be32 status = nfserr_inval;
-	struct nfsd4_ssc_umount_item *work = NULL;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	naddr = &nss->u.nl4_addr;
@@ -1391,6 +1391,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 					 naddr->addr_len,
 					 (struct sockaddr *)&tmp_addr,
 					 sizeof(tmp_addr));
+	*nsui = NULL;
 	if (tmp_addrlen == 0)
 		goto out_err;
 
@@ -1433,10 +1434,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 		goto out_free_rawdata;
 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
 
-	status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
+	status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
 	if (status)
 		goto out_free_devname;
-	if (ss_mnt)
+	if ((*nsui)->nsui_vfsmount)
 		goto out_done;
 
 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
@@ -1444,15 +1445,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	module_put(type->owner);
 	if (IS_ERR(ss_mnt)) {
 		status = nfserr_nodev;
-		if (work)
-			nfsd4_ssc_cancel_dul_work(nn, work);
+		nfsd4_ssc_cancel_dul(nn, *nsui);
 		goto out_free_devname;
 	}
-	if (work)
-		nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
+	nfsd4_ssc_update_dul(nn, *nsui, ss_mnt);
 out_done:
 	status = 0;
-	*mount = ss_mnt;
 
 out_free_devname:
 	kfree(dev_name);
@@ -1476,7 +1474,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 static __be32
 nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 		      struct nfsd4_compound_state *cstate,
-		      struct nfsd4_copy *copy, struct vfsmount **mount)
+		      struct nfsd4_copy *copy)
 {
 	struct svc_fh *s_fh = NULL;
 	stateid_t *s_stid = &copy->cp_src_stateid;
@@ -1489,7 +1487,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 	if (status)
 		goto out;
 
-	status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
+	status = nfsd4_interssc_connect(copy->cp_src, rqstp, &copy->ss_nsui);
 	if (status)
 		goto out;
 
@@ -1507,45 +1505,27 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 }
 
 static void
-nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
+nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
 			struct nfsd_file *dst)
 {
-	bool found = false;
-	long timeout;
-	struct nfsd4_ssc_umount_item *tmp;
-	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
+	long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
 
 	nfs42_ssc_close(filp);
 	nfsd_file_put(dst);
 	fput(filp);
 
-	if (!nn) {
-		mntput(ss_mnt);
-		return;
-	}
 	spin_lock(&nn->nfsd_ssc_lock);
-	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
-	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
-		if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
-			list_del(&ni->nsui_list);
-			/*
-			 * vfsmount can be shared by multiple exports,
-			 * decrement refcnt. If the count drops to 1 it
-			 * will be unmounted when nsui_expire expires.
-			 */
-			refcount_dec(&ni->nsui_refcnt);
-			ni->nsui_expire = jiffies + timeout;
-			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
-			found = true;
-			break;
-		}
-	}
+	list_del(&nsui->nsui_list);
+	/*
+	 * vfsmount can be shared by multiple exports,
+	 * decrement refcnt. If the count drops to 1 it
+	 * will be unmounted when nsui_expire expires.
+	 */
+	refcount_dec(&nsui->nsui_refcnt);
+	nsui->nsui_expire = jiffies + timeout;
+	list_add_tail(&nsui->nsui_list, &nn->nfsd_ssc_mount_list);
 	spin_unlock(&nn->nfsd_ssc_lock);
-	if (!found) {
-		mntput(ss_mnt);
-		return;
-	}
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
@@ -1553,15 +1533,13 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
 static __be32
 nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 		      struct nfsd4_compound_state *cstate,
-		      struct nfsd4_copy *copy,
-		      struct vfsmount **mount)
+		      struct nfsd4_copy *copy)
 {
-	*mount = NULL;
 	return nfserr_inval;
 }
 
 static void
-nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
+nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
 			struct nfsd_file *dst)
 {
 }
@@ -1702,7 +1680,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
-	dst->ss_mnt = src->ss_mnt;
+	dst->ss_nsui = src->ss_nsui;
 }
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
@@ -1751,8 +1729,8 @@ static int nfsd4_do_async_copy(void *data)
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
 
-		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
-				      &copy->stateid);
+		filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
+				      &copy->c_fh, &copy->stateid);
 		if (IS_ERR(filp)) {
 			switch (PTR_ERR(filp)) {
 			case -EBADF:
@@ -1766,7 +1744,7 @@ static int nfsd4_do_async_copy(void *data)
 		}
 		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
 				       false);
-		nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
+		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
 	} else {
 		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
 				       copy->nf_dst->nf_file, false);
@@ -1792,8 +1770,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			status = nfserr_notsupp;
 			goto out;
 		}
-		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
-				&copy->ss_mnt);
+		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
 		if (status)
 			return nfserr_offload_denied;
 	} else {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 4fd2cf6d1d2dc..510978e602da6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -571,7 +571,7 @@ struct nfsd4_copy {
 	struct task_struct	*copy_task;
 	refcount_t		refcount;
 
-	struct vfsmount		*ss_mnt;
+	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
 };
diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
index 75843c00f326a..22265b1ff0800 100644
--- a/include/linux/nfs_ssc.h
+++ b/include/linux/nfs_ssc.h
@@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
 }
+#endif
 
 struct nfsd4_ssc_umount_item {
 	struct list_head nsui_list;
@@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
 	struct vfsmount *nsui_vfsmount;
 	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
 };
-#endif
 
 /*
  * NFS_FS
-- 
2.43.0




