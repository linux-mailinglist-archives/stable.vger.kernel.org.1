Return-Path: <stable+bounces-186145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA2BE3B0B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 056BC5046B1
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726432C319;
	Thu, 16 Oct 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCkkjl/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574333191AB
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621045; cv=none; b=TA1GiE8TEqr067vvm+NPHS+9Xw2UxXr5KGK5Z3/y8RjPNde1DXukiZQNGvs47WD8GSiz8r/FlAO8wZBftW20RZdhzKsGkAIkOeiV67Ao63EKXLY0qMG4zwfci9a446vfapQ9YnQjVuGHofPAmFFY2XdbelDMQaGbKn2RW+Rycvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621045; c=relaxed/simple;
	bh=kaNX3AM7Yio2WSKYAnJhROncC6k6Xku2qQwpytpWQjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DQn0bol1AIvwIZmSFqUoUQlHtxAKGEr9e28hvWCEfwzlTJGyrHX4ismXM7T+2KeSaKsmvLeO7YR1s9mtLsj4udZXC6hgfyijtet6Dl2JUyICh4OAWpZoHQgzs0OyUr+deBmsRh9X3gGaX/P1Yvg1cqn9vdAi7WQrnD3lsXDSYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCkkjl/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7D6C4CEF1;
	Thu, 16 Oct 2025 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760621045;
	bh=kaNX3AM7Yio2WSKYAnJhROncC6k6Xku2qQwpytpWQjY=;
	h=Subject:To:Cc:From:Date:From;
	b=QCkkjl/ti1Wu3RIZs9fiL/CXewnL0SDOx2eTaXQqrNNEEmnx4SZnq146sALlS+96G
	 oGVPfDbSO739takb3s5M4LWtzxDW5R69me8eL4dDoqPXCOR97cUFgelz8p7T3PMkLa
	 YOx335ux6CntDKviJfg2PDIxhLewmQKSaSYY8eLI=
Subject: FAILED: patch "[PATCH] NFSD: Fix last write offset handling in layoutcommit" failed to apply to 6.1-stable tree
To: sergeybashirov@gmail.com,chuck.lever@oracle.com,hch@lst.de,jlayton@kernel.org,koevtushenko@yandex.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:23:58 +0200
Message-ID: <2025101658-county-probation-13a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d68886bae76a4b9b3484d23e5b7df086f940fa38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101658-county-probation-13a9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d68886bae76a4b9b3484d23e5b7df086f940fa38 Mon Sep 17 00:00:00 2001
From: Sergey Bashirov <sergeybashirov@gmail.com>
Date: Mon, 21 Jul 2025 21:40:56 +0300
Subject: [PATCH] NFSD: Fix last write offset handling in layoutcommit

The data type of loca_last_write_offset is newoffset4 and is switched
on a boolean value, no_newoffset, that indicates if a previous write
occurred or not. If no_newoffset is FALSE, an offset is not given.
This means that client does not try to update the file size. Thus,
server should not try to calculate new file size and check if it fits
into the segment range. See RFC 8881, section 12.5.4.2.

Sometimes the current incorrect logic may cause clients to hang when
trying to sync an inode. If layoutcommit fails, the client marks the
inode as dirty again.

Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")
Cc: stable@vger.kernel.org
Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 4c936132eb44..0822d8a119c6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -118,7 +118,6 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
 	struct timespec64 mtime = inode_get_mtime(inode);
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -128,9 +127,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
-	if (new_size > i_size_read(inode)) {
+	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = new_size;
+		iattr.ia_size = lcp->lc_newsize;
 	}
 
 	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 656b2e7d8840..7043fc475458 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2475,7 +2475,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2491,13 +2490,21 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset)
-		goto out;
-	if (new_size > seg->offset + seg->length)
-		goto out;
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
-		goto out;
+	lcp->lc_size_chg = false;
+	if (lcp->lc_newoffset) {
+		loff_t new_size = lcp->lc_last_wr + 1;
+
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+
+		if (new_size > i_size_read(inode)) {
+			lcp->lc_size_chg = true;
+			lcp->lc_newsize = new_size;
+		}
+	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
@@ -2513,13 +2520,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = true;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = false;
-	}
-
 	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:


