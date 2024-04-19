Return-Path: <stable+bounces-40266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D9A8AACEF
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7937DB211E9
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190DF7E582;
	Fri, 19 Apr 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6SGQVOM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65493D961
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523034; cv=none; b=rGUbYzbgqMQqp1d8Vm6X8iAJ8pWsOEI8vB9r1GrQzwFHFyWNYKJPK1390febyKGN4A4asjcEqBpMSIm4J0a7WB4ptQFEfqqebd5o8ALtjWMHAAjLi4wqn5dC4fu3xIxJ0IBCzlm54Vs36mOuyn9ecHSpa9Hqs6rsJ8I+xqboq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523034; c=relaxed/simple;
	bh=i8wB85ziZmS4dHhAjrFvLI6hL1a3MPU1ATy86/otpKk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SVtUWKfq1RsmOUjPATItPoXZdXp+JsCZyYflWQTZRSCKuDQbh26bdWJoTRkjaRT8sRQOvNzEl2qNdV1EGSFNnr6K9RC5AQdvlNN1Gajx32FM6V/tOHfSsAI8qrxZXCN7nXPje5fSbAyRm91UDOWIg+U4Kn7SvUZ4dskNPYNc3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6SGQVOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DF7C072AA;
	Fri, 19 Apr 2024 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523034;
	bh=i8wB85ziZmS4dHhAjrFvLI6hL1a3MPU1ATy86/otpKk=;
	h=Subject:To:Cc:From:Date:From;
	b=c6SGQVOM1mrFbZJpk80JXHUYb/TPyvQI2FB3NrWD6mAByYvnAdCdA9SOeu1LKmzBm
	 5TZC+aqRH18fModkQdJqEa8UKu5krAFk0ItOy+ZcWkTZYff2F5qo8sgUgInODiCtKL
	 /13A3mYWgOMUeOQuW8qn0gtxrt/ZqohhF2gtNWa8=
Subject: FAILED: patch "[PATCH] NFSD: fix endianness issue in nfsd4_encode_fattr4" failed to apply to 6.8-stable tree
To: gor@linux.ibm.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Apr 2024 12:37:09 +0200
Message-ID: <2024041908-sandblast-sullen-2eed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x f488138b526715c6d2568d7329c4477911be4210
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041908-sandblast-sullen-2eed@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

f488138b5267 ("NFSD: fix endianness issue in nfsd4_encode_fattr4")
c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
6487a13b5c6b ("NFSD: add support for CB_GETATTR callback")
4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
d98416cc2154 ("nfsd: rename NFSD_NET_* to NFSD_STATS_*")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f488138b526715c6d2568d7329c4477911be4210 Mon Sep 17 00:00:00 2001
From: Vasily Gorbik <gor@linux.ibm.com>
Date: Thu, 11 Apr 2024 11:45:57 +0200
Subject: [PATCH] NFSD: fix endianness issue in nfsd4_encode_fattr4

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fac938f563ad..1955481832e0 100644
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
 	bool file_modified = false;
 	u64 size = 0;
@@ -3521,20 +3519,19 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
 		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
 					&file_modified, &size);
 		if (status)
@@ -3553,16 +3550,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
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
@@ -3577,10 +3574,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -3592,17 +3589,17 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
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
@@ -3610,8 +3607,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 
 	/* attrmask */
-	status = nfsd4_encode_bitmap4(xdr, u.attrmask[0],
-				      u.attrmask[1], u.attrmask[2]);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
+				      attrmask[2]);
 	if (status)
 		goto out;
 
@@ -3620,7 +3617,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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


