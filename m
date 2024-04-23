Return-Path: <stable+bounces-40736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766358AF455
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9191F23E23
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3E13D290;
	Tue, 23 Apr 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMBSjNuf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC551C2A1
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890234; cv=none; b=X9m0gAoRqyV4hzFc59BreNNwCtWwII3WdUTU0jpptjPkvkWjOWpfz+aSvy/RL2JA0AnnnPa7nhJKqmf7Zis65AfJBvJ9+TdGOY5QNZP8gH0f/9V51gI5myveJka0c/VvtjYNg3uGrDDzziGPirTJFqT4wCocI9Sy4RiGjuyBasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890234; c=relaxed/simple;
	bh=MWHPU2rYveny7F3fXwebnCtQcWYKSYZP7WcQOuHysQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntmG4FxnqcqIfKf41qU3ZKrEszzNecWzVdO9AP4fVRXucWpx/dRcSDoOYKpzxPNLdMgl1XCNS99Qc7IvOJKWtHsaSVa+2tc+9FTglAelbWDMKUG9D5vzF5geo5UVUZDsTljvzELVjrg+R2bVMxIpGBeUCpZ5v7H7FmpW2dYrCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMBSjNuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82606C116B1;
	Tue, 23 Apr 2024 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713890233;
	bh=MWHPU2rYveny7F3fXwebnCtQcWYKSYZP7WcQOuHysQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMBSjNufL70m0Gkl6RAevxmeanynLfr+nj6Xg78T4refXkmzjdgTshu5hyK1Jy0vT
	 fc48s7KIhyl4/kS5o/McsOdel0v2XwOcgpXyQjgf9//L1gyZXmO8377+NC6C298WCe
	 yibOivBOsPEl2GT6UXlJLFyTcoLVF+ut7H8A5U83OfkUaQJ3PXWfauNYUNABoGQpU7
	 gUA5TWKC8uBXW7o35uAVLjEAEHfXCEO8tfLBdEBlRNEk8HWTreEIlqeGYqnejI0rA4
	 NKRt3YSMv5GKH1BmfNfAQ8mrYn4niuiF2C+sOSUhi4h0t2oUiGbikhDFW3ZKQsDZqT
	 bfBlKJJL0AO8A==
From: cel@kernel.org
To: stable@kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	stable@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.8.y] NFSD: fix endianness issue in nfsd4_encode_fattr4
Date: Tue, 23 Apr 2024 12:37:02 -0400
Message-ID: <20240423163702.11681-1-cel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024041908-sandblast-sullen-2eed@gregkh>
References: <2024041908-sandblast-sullen-2eed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit f488138b526715c6d2568d7329c4477911be4210 ]

The nfs4 mount fails with EIO on 64-bit big endian architectures since
v6.7. The issue arises from employing a union in the nfsd4_encode_fattr4()
function to overlay a 32-bit array with a 64-bit values based bitmap,
which does not function as intended. Address the endianness issue by
utilizing bitmap_from_arr32() to copy 32-bit attribute masks into a
bitmap in an endianness-agnostic manner.

Cc: stable@vger.kernel.org
Fixes: fce7913b13d0 ("NFSD: Use a bitmask loop to encode FATTR4 results")
Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2060217
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply on 6.8.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c719c475a068..c17bdf973c18 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3490,11 +3490,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct dentry *dentry, const u32 *bmval,
 		    int ignore_crossmnt)
 {
+	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
 	__be32 *attrlen_p, status;
 	int attrlen_offset;
+	u32 attrmask[3];
 	int err;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
@@ -3502,10 +3504,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	union {
-		u32		attrmask[3];
-		unsigned long	mask[2];
-	} u;
 	unsigned long bit;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
@@ -3519,20 +3517,19 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	/*
 	 * Make a local copy of the attribute bitmap that can be modified.
 	 */
-	memset(&u, 0, sizeof(u));
-	u.attrmask[0] = bmval[0];
-	u.attrmask[1] = bmval[1];
-	u.attrmask[2] = bmval[2];
+	attrmask[0] = bmval[0];
+	attrmask[1] = bmval[1];
+	attrmask[2] = bmval[2];
 
 	args.rdattr_err = 0;
 	if (exp->ex_fslocs.migrated) {
-		status = fattr_handle_absent_fs(&u.attrmask[0], &u.attrmask[1],
-						&u.attrmask[2], &args.rdattr_err);
+		status = fattr_handle_absent_fs(&attrmask[0], &attrmask[1],
+						&attrmask[2], &args.rdattr_err);
 		if (status)
 			goto out;
 	}
 	args.size = 0;
-	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
 		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
 		if (status)
 			goto out;
@@ -3547,16 +3544,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 	if (!(args.stat.result_mask & STATX_BTIME))
 		/* underlying FS does not offer btime so we can't share it */
-		u.attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
-	if ((u.attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	if ((attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
-	    (u.attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
+	    (attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
 		err = vfs_statfs(&path, &args.statfs);
 		if (err)
 			goto out_nfserr;
 	}
-	if ((u.attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
 	    !fhp) {
 		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
 		status = nfserr_jukebox;
@@ -3571,10 +3568,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = fhp;
 
 	args.acl = NULL;
-	if (u.attrmask[0] & FATTR4_WORD0_ACL) {
+	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
 		if (err == -EOPNOTSUPP)
-			u.attrmask[0] &= ~FATTR4_WORD0_ACL;
+			attrmask[0] &= ~FATTR4_WORD0_ACL;
 		else if (err == -EINVAL) {
 			status = nfserr_attrnotsupp;
 			goto out;
@@ -3586,17 +3583,17 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	args.context = NULL;
-	if ((u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
-	     u.attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
+	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
+	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
 						&args.context, &args.contextlen);
 		else
 			err = -EOPNOTSUPP;
 		args.contextsupport = (err == 0);
-		if (u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
+		if (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
 			if (err == -EOPNOTSUPP)
-				u.attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+				attrmask[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 			else if (err)
 				goto out_nfserr;
 		}
@@ -3604,8 +3601,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
 	/* attrmask */
-	status = nfsd4_encode_bitmap4(xdr, u.attrmask[0],
-				      u.attrmask[1], u.attrmask[2]);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
+				      attrmask[2]);
 	if (status)
 		goto out;
 
@@ -3614,7 +3611,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
 	if (!attrlen_p)
 		goto out_resource;
-	for_each_set_bit(bit, (const unsigned long *)&u.mask,
+	bitmap_from_arr32(attr_bitmap, attrmask,
+			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	for_each_set_bit(bit, attr_bitmap,
 			 ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
 		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
 		if (status != nfs_ok)
-- 
2.43.0


