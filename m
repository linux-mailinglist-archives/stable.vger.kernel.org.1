Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE667ECCD4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjKOTct (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjKOTcs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C2130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D513DC433C9;
        Wed, 15 Nov 2023 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076765;
        bh=W3gt3aucpAbcI5jm7RDWqf8Tkt76lgDLkHQYXJii6GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9nE09lTUIw8+VkeeQ+pJFsrx8b170SLWVK8gr4rLH0oC/uT7zcrfPbJoARgAqzSp
         eLLejmVVlHn4JB6of6Fvxei/xUoh1GIhOlNLhnaY6TNBGELHCIV4bIbt7wG0Tkl0+7
         RMc1h3bbBoRikDwClftt9NWG3fbqirwM2kgVmNVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/603] nfsd: Handle EOPENSTALE correctly in the filecache
Date:   Wed, 15 Nov 2023 14:09:16 -0500
Message-ID: <20231115191613.928068185@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit d59b3515ab021e010fdc58a8f445ea62dd2f7f4c ]

The nfsd_open code handles EOPENSTALE correctly, by retrying the call to
fh_verify() and __nfsd_open(). However the filecache just drops the
error on the floor, and immediately returns nfserr_stale to the caller.

This patch ensures that we propagate the EOPENSTALE code back to
nfsd_file_do_acquire, and that we handle it correctly.

Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Message-Id: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 27 +++++++++++++++++++--------
 fs/nfsd/vfs.c       | 28 +++++++++++++---------------
 fs/nfsd/vfs.h       |  4 ++--
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e08..07bf219f9ae48 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -989,22 +989,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_file *new, *nf;
-	const struct cred *cred;
+	bool stale_retry = true;
 	bool open_retry = true;
 	struct inode *inode;
 	__be32 status;
 	int ret;
 
+retry:
 	status = fh_verify(rqstp, fhp, S_IFREG,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
 	if (status != nfs_ok)
 		return status;
 	inode = d_inode(fhp->fh_dentry);
-	cred = get_current_cred();
 
-retry:
 	rcu_read_lock();
-	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
 	rcu_read_unlock();
 
 	if (nf) {
@@ -1026,7 +1025,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	rcu_read_lock();
 	spin_lock(&inode->i_lock);
-	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
 	if (unlikely(nf)) {
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
@@ -1058,6 +1057,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto construction_err;
 		}
 		open_retry = false;
+		fh_put(fhp);
 		goto retry;
 	}
 	this_cpu_inc(nfsd_file_cache_hits);
@@ -1074,7 +1074,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_file_check_write_error(nf);
 		*pnf = nf;
 	}
-	put_cred(cred);
 	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
 	return status;
 
@@ -1088,8 +1087,20 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfs_ok;
 			trace_nfsd_file_opened(nf, status);
 		} else {
-			status = nfsd_open_verified(rqstp, fhp, may_flags,
-						    &nf->nf_file);
+			ret = nfsd_open_verified(rqstp, fhp, may_flags,
+						 &nf->nf_file);
+			if (ret == -EOPENSTALE && stale_retry) {
+				stale_retry = false;
+				nfsd_file_unhash(nf);
+				clear_and_wake_up_bit(NFSD_FILE_PENDING,
+						      &nf->nf_flags);
+				if (refcount_dec_and_test(&nf->nf_ref))
+					nfsd_file_free(nf);
+				nf = NULL;
+				fh_put(fhp);
+				goto retry;
+			}
+			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
 		}
 	} else
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 02f5fcaad03f3..b24462efa1781 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -823,7 +823,7 @@ int nfsd_open_break_lease(struct inode *inode, int access)
  * and additional flags.
  * N.B. After this call fhp needs an fh_put
  */
-static __be32
+static int
 __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 			int may_flags, struct file **filp)
 {
@@ -831,14 +831,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	struct inode	*inode;
 	struct file	*file;
 	int		flags = O_RDONLY|O_LARGEFILE;
-	__be32		err;
-	int		host_err = 0;
+	int		host_err = -EPERM;
 
 	path.mnt = fhp->fh_export->ex_path.mnt;
 	path.dentry = fhp->fh_dentry;
 	inode = d_inode(path.dentry);
 
-	err = nfserr_perm;
 	if (IS_APPEND(inode) && (may_flags & NFSD_MAY_WRITE))
 		goto out;
 
@@ -847,7 +845,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 
 	host_err = nfsd_open_break_lease(inode, may_flags);
 	if (host_err) /* NOMEM or WOULDBLOCK */
-		goto out_nfserr;
+		goto out;
 
 	if (may_flags & NFSD_MAY_WRITE) {
 		if (may_flags & NFSD_MAY_READ)
@@ -859,13 +857,13 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	file = dentry_open(&path, flags, current_cred());
 	if (IS_ERR(file)) {
 		host_err = PTR_ERR(file);
-		goto out_nfserr;
+		goto out;
 	}
 
 	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
 		fput(file);
-		goto out_nfserr;
+		goto out;
 	}
 
 	if (may_flags & NFSD_MAY_64BIT_COOKIE)
@@ -874,10 +872,8 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		file->f_mode |= FMODE_32BITHASH;
 
 	*filp = file;
-out_nfserr:
-	err = nfserrno(host_err);
 out:
-	return err;
+	return host_err;
 }
 
 __be32
@@ -885,6 +881,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		int may_flags, struct file **filp)
 {
 	__be32 err;
+	int host_err;
 	bool retried = false;
 
 	validate_process_creds();
@@ -904,12 +901,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 retry:
 	err = fh_verify(rqstp, fhp, type, may_flags);
 	if (!err) {
-		err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
-		if (err == nfserr_stale && !retried) {
+		host_err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
+		if (host_err == -EOPENSTALE && !retried) {
 			retried = true;
 			fh_put(fhp);
 			goto retry;
 		}
+		err = nfserrno(host_err);
 	}
 	validate_process_creds();
 	return err;
@@ -922,13 +920,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
  * @may_flags: internal permission flags
  * @filp: OUT: open "struct file *"
  *
- * Returns an nfsstat value in network byte order.
+ * Returns zero on success, or a negative errno value.
  */
-__be32
+int
 nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
 		   struct file **filp)
 {
-	__be32 err;
+	int err;
 
 	validate_process_creds();
 	err = __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a6890ea7b765b..e3c29596f4df1 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -104,8 +104,8 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
-				int, struct file **);
+int		nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				   int may_flags, struct file **filp);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count,
-- 
2.42.0



