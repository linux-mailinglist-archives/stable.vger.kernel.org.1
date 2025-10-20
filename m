Return-Path: <stable+bounces-188064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A19BF158B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60DD234CE9B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F12836A0;
	Mon, 20 Oct 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnncI5n/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F931355F
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964753; cv=none; b=ZxeGiqeuZo1sTA9QHy1jr7qdriaWB5rq3ZRG6k405Jk/1NDHxdQUSfNJWwiYS9GeR6wmnqSbqlPTrT/d8XW3Bm9BR8ZJCaPyAIgT+mGYTDPcrxB/mnT/eXUrPaJciU+8le+caYXB5tnWPyrpMY6sMSQ4VMbR4cbfenOLxfpqvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964753; c=relaxed/simple;
	bh=nPAw7JEwW7sm+FuDgOvNp/mJVXQ4zJkDFeHM8JKdl9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOvJ4mAjmRkqF0uYPl/B0kRKq6kJMv/ybctZfvQhCzDH/C98sF3VtUzZ6vItaRCloqEh7ANoGtHEbwr4+J2Iq6WSGjBxD5yxK80j7MS4ZwodWWxbJSzZuWSGhszE4g4P7HRCU+Ke6beuqPUtsT7BMpTGSOSww3I4wQqkGTngt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnncI5n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62876C4CEF9;
	Mon, 20 Oct 2025 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964752;
	bh=nPAw7JEwW7sm+FuDgOvNp/mJVXQ4zJkDFeHM8JKdl9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnncI5n/vfwbrMDPeYaS/VOmt+7ru3tynbZrlzR+19zNS1JDxeVAPEE+ykO2X7vaV
	 iAFXOqSJGZa86j1DJCJT9c02FtttSncofP8FGQLtSF+Rwi8SMSMuWPaMod6pOmSojM
	 1uqp2BMyUHLNin+qcGtmU57fVHiQsQkxHMkBgWxOAJZXOfgV3Ca0zWszDT8DUDGklC
	 UP+0BVsi3XHaHt20FMeSLqW9gQnk8hSgBI6P9Ii97pLgjSOzROr/hbrkhIIC/PbKGS
	 VhES5vcNrE6JdzdXex4Y+HwWgZgTnpA6P7kkGZDSjn6yqyuqNppokfZ9cjdY1rbTUJ
	 tYODLJlLSBCaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Christoph Hellwig <hch@lst.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 4/4] NFSD: Fix last write offset handling in layoutcommit
Date: Mon, 20 Oct 2025 08:52:25 -0400
Message-ID: <20251020125226.1759978-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125226.1759978-1-sashal@kernel.org>
References: <2025101656-unfrosted-rasping-f7dc@gregkh>
 <20251020125226.1759978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit d68886bae76a4b9b3484d23e5b7df086f940fa38 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayout.c |  5 ++---
 fs/nfsd/nfs4proc.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 4c936132eb440..0822d8a119c6f 100644
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
index 76b2703a23b28..7ae8e885d7530 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2504,7 +2504,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2520,13 +2519,21 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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
@@ -2542,13 +2549,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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
-- 
2.51.0


