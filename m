Return-Path: <stable+bounces-188080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66258BF15E8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE33E52F7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F571624E9;
	Mon, 20 Oct 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbPAwN3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF73FFD
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964968; cv=none; b=c7e0Kcy9JUYauGbVG2VspmH8tyXNFGlUuVzyO7LOQ1tpfFXBZnLPPj8hvV+bhlfmtcwuYWYkfW4sFA3zEtrxTh0mqeYqi3RcPf2QDrUW+mjCgrmcoJVGl3dDFAX2msnLlEPSLv276FmLMpK0QYccrb0hHrcpxtqaW4zgSFkDiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964968; c=relaxed/simple;
	bh=SxkKOD2V1ciOBVeu71w/QJZLGW0Hn6vbzFGCFzDaxv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXwA5awns56mQrHQKdRh26dnstNTzbW7kczy78CMQiKJuKpA7HJ3Twe95wU8LqV0dWjMxzv+CgbCtUQ7rC5/WoKj9NMDaqJ4V4cIgua1YHumNevo96Wht4GR2b7EoPD7tfCW0jH7fU2sfFgvrMRfV0HnAJRsziAWX1DrazKnpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbPAwN3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBC3C4CEF9;
	Mon, 20 Oct 2025 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964968;
	bh=SxkKOD2V1ciOBVeu71w/QJZLGW0Hn6vbzFGCFzDaxv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbPAwN3co8GyKz6BzvbW3Hvx71MYNMix0gOVK29TYKpnIv8cf+yZzQHciV6toByPM
	 8imfTyZhDQJ7zN3AhD+CN9gsqFasXf5HvQS56BJzDM2EOiWRHHLnw5pNpQPx7yBloW
	 LOzSXPWPrTVlr+Phrzo8vvur5TucQCbEKCehNJUrPBansNz2H4pNE+kwQcnq0hha0U
	 voWRvzxTPUja5mszpdZX0pXmryuvxuDgHuL/HmsQpcL1MtvGm1vJ9EtIyecGX/LO8t
	 IqLdSo7sN+wOrpYCpiV9thvcL+iWoNSrRoV1DIs9QVtulPrFMRDpFZNfFn0VRwkzgq
	 tWernrm5rrJFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Christoph Hellwig <hch@lst.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] NFSD: Fix last write offset handling in layoutcommit
Date: Mon, 20 Oct 2025 08:56:02 -0400
Message-ID: <20251020125602.1761375-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125602.1761375-1-sashal@kernel.org>
References: <2025101659-tightly-grandma-7323@gregkh>
 <20251020125602.1761375-1-sashal@kernel.org>
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
[ adapted for direct inode->i_mtime access and 2-parameter proc_layoutcommit callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayout.c |  5 ++---
 fs/nfsd/nfs4proc.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 0ddd20cb68064..ba8961e72feaa 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -121,7 +121,6 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -131,9 +130,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
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
index 35b9888aee51a..1d1091be9f615 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2262,7 +2262,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2277,13 +2276,21 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
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
@@ -2299,13 +2306,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = 1;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = 0;
-	}
-
 	nfserr = ops->proc_layoutcommit(inode, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
-- 
2.51.0


