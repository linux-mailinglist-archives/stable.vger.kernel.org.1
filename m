Return-Path: <stable+bounces-52867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0990790D14C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81834B20D4D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278FB132494;
	Tue, 18 Jun 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BO9M4XB1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631113DDD2;
	Tue, 18 Jun 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714645; cv=none; b=HfvrEdITobz5J6BepX1MBEE2MKcbtlXkYSuS8PBxMecloyS34zoUM24sz5DVc4GIJMJFANFlTgcDyM8H694h18wJN9D2yPD40DTcs+3E6hJYxdzg2Us5VuDW8uWM0TgkI95TYPCrwJf803ydFr1dJp08DZfioyfySXQ3jS36a7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714645; c=relaxed/simple;
	bh=slrwLamuZ+poelCsRR5MrkcTGQb88JuRoIUYtU4tAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF+wodvBUob/Zrgv4sJhVCkT6p8a/CRZiZ4Y6jJO8OdNTtuGLeLLFh+J/vCurjDxxi0J0t2qr7aNX7bUBSJd6ksmunNxTnYSl4hH9zLkWc4qUqIXhWWuZWuL6TCG3sNvGNmpPcUSS2CgMFgPkf9YgJ/HonUiWAtQ4qof3UklxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BO9M4XB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CA0C3277B;
	Tue, 18 Jun 2024 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714645;
	bh=slrwLamuZ+poelCsRR5MrkcTGQb88JuRoIUYtU4tAU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BO9M4XB1IyIb9n4Owh+ViMPfER5UWoWIYN1SgHf278vM9gDKtnjHnPUFzfggJAxqN
	 WZ+0Y+og/fuWcb34OFKtKNYdTFx6hus65IKpDlzNL0TaNnj466W578bpWmhOfhsPXq
	 B5zITqBM5/6FQBkS6OLKfyII2LL4oFiE52K0tUks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 011/770] NFSD: Add common helpers to decode void args and encode void results
Date: Tue, 18 Jun 2024 14:27:44 +0200
Message-ID: <20240618123407.727694111@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 788f7183fba86b46074c16e7d57ea09302badff4 ]

Start off the conversion to xdr_stream by de-duplicating the functions
that decode void arguments and encode void results.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c  | 21 ++++-----------------
 fs/nfsd/nfs3acl.c  |  8 ++++----
 fs/nfsd/nfs3proc.c | 10 ++++------
 fs/nfsd/nfs3xdr.c  | 11 -----------
 fs/nfsd/nfs4proc.c | 11 ++++-------
 fs/nfsd/nfs4xdr.c  | 12 ------------
 fs/nfsd/nfsd.h     |  8 ++++++++
 fs/nfsd/nfsproc.c  | 25 ++++++++++++-------------
 fs/nfsd/nfssvc.c   | 28 ++++++++++++++++++++++++++++
 fs/nfsd/nfsxdr.c   | 10 ----------
 fs/nfsd/xdr.h      |  2 --
 fs/nfsd/xdr3.h     |  2 --
 fs/nfsd/xdr4.h     |  2 --
 13 files changed, 64 insertions(+), 86 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 6a900f770dd23..b0f66604532a5 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -185,10 +185,6 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 /*
  * XDR decode functions
  */
-static int nfsaclsvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
-{
-	return 1;
-}
 
 static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -255,15 +251,6 @@ static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
  * XDR encode functions
  */
 
-/*
- * There must be an encoding function for void results so svc_process
- * will work properly.
- */
-static int nfsaclsvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}
-
 /* GETACL */
 static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -378,10 +365,10 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	[ACLPROC2_NULL] = {
 		.pc_func = nfsacld_proc_null,
-		.pc_decode = nfsaclsvc_decode_voidarg,
-		.pc_encode = nfsaclsvc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd3_voidargs),
-		.pc_ressize = sizeof(struct nfsd3_voidargs),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 34a394e50e1d1..7c30876a31a1b 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -245,10 +245,10 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_acl_procedures3[3] = {
 	[ACLPROC3_NULL] = {
 		.pc_func = nfsd3_proc_null,
-		.pc_decode = nfs3svc_decode_voidarg,
-		.pc_encode = nfs3svc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd3_voidargs),
-		.pc_ressize = sizeof(struct nfsd3_voidargs),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index eba84417406ca..3257233d1a655 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -697,8 +697,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 #define nfsd3_attrstatres		nfsd3_attrstat
 #define nfsd3_wccstatres		nfsd3_attrstat
 #define nfsd3_createres			nfsd3_diropres
-#define nfsd3_voidres			nfsd3_voidargs
-struct nfsd3_voidargs { int dummy; };
 
 #define ST 1		/* status*/
 #define FH 17		/* filehandle with length */
@@ -709,10 +707,10 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_procedures3[22] = {
 	[NFS3PROC_NULL] = {
 		.pc_func = nfsd3_proc_null,
-		.pc_decode = nfs3svc_decode_voidarg,
-		.pc_encode = nfs3svc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd3_voidargs),
-		.pc_ressize = sizeof(struct nfsd3_voidres),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 27b24823f7c42..0d75d201db1b3 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -304,11 +304,6 @@ void fill_post_wcc(struct svc_fh *fhp)
 /*
  * XDR decode functions
  */
-int
-nfs3svc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
-{
-	return 1;
-}
 
 int
 nfs3svc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
@@ -642,12 +637,6 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
  * XDR encode functions
  */
 
-int
-nfs3svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}
-
 /* GETATTR */
 int
 nfs3svc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c01b6f7462fcb..55a46e7c152b9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3285,16 +3285,13 @@ static const char *nfsd4_op_name(unsigned opnum)
 	return "unknown_operation";
 }
 
-#define nfsd4_voidres			nfsd4_voidargs
-struct nfsd4_voidargs { int dummy; };
-
 static const struct svc_procedure nfsd_procedures4[2] = {
 	[NFSPROC4_NULL] = {
 		.pc_func = nfsd4_proc_null,
-		.pc_decode = nfs4svc_decode_voidarg,
-		.pc_encode = nfs4svc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd4_voidargs),
-		.pc_ressize = sizeof(struct nfsd4_voidres),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
 	},
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fd9107332a20f..c176d0090f7c8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5288,12 +5288,6 @@ nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
 	p = xdr_encode_opaque_fixed(p, rp->rp_buf, rp->rp_buflen);
 }
 
-int
-nfs4svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
-{
-        return xdr_ressize_check(rqstp, p);
-}
-
 void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
@@ -5311,12 +5305,6 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	}
 }
 
-int
-nfs4svc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
-{
-	return 1;
-}
-
 int
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4362d295ed340..3eaa81e001f9c 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -73,6 +73,14 @@ extern unsigned long		nfsd_drc_mem_used;
 
 extern const struct seq_operations nfs_exports_op;
 
+/*
+ * Common void argument and result helpers
+ */
+struct nfsd_voidargs { };
+struct nfsd_voidres { };
+int		nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p);
+int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
+
 /*
  * Function prototypes.
  */
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index bbd01e8397f6e..dbd8d36046539 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -609,7 +609,6 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
  * NFSv2 Server procedures.
  * Only the results of non-idempotent operations are cached.
  */
-struct nfsd_void { int dummy; };
 
 #define ST 1		/* status */
 #define FH 8		/* filehandle */
@@ -618,10 +617,10 @@ struct nfsd_void { int dummy; };
 static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_NULL] = {
 		.pc_func = nfsd_proc_null,
-		.pc_decode = nfssvc_decode_void,
-		.pc_encode = nfssvc_encode_void,
-		.pc_argsize = sizeof(struct nfsd_void),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
 	},
@@ -647,10 +646,10 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_ROOT] = {
 		.pc_func = nfsd_proc_root,
-		.pc_decode = nfssvc_decode_void,
-		.pc_encode = nfssvc_encode_void,
-		.pc_argsize = sizeof(struct nfsd_void),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
 	},
@@ -685,10 +684,10 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_WRITECACHE] = {
 		.pc_func = nfsd_proc_writecache,
-		.pc_decode = nfssvc_decode_void,
-		.pc_encode = nfssvc_encode_void,
-		.pc_argsize = sizeof(struct nfsd_void),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
 	},
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 311b287c5024f..c81d49b07971c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1107,6 +1107,34 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	return 1;
 }
 
+/**
+ * nfssvc_decode_voidarg - Decode void arguments
+ * @rqstp: Server RPC transaction context
+ * @p: buffer containing arguments to decode
+ *
+ * Return values:
+ *   %0: Arguments were not valid
+ *   %1: Decoding was successful
+ */
+int nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
+/**
+ * nfssvc_encode_voidres - Encode void results
+ * @rqstp: Server RPC transaction context
+ * @p: buffer in which to encode results
+ *
+ * Return values:
+ *   %0: Local error while encoding
+ *   %1: Encoding was successful
+ */
+int nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
+{
+        return xdr_ressize_check(rqstp, p);
+}
+
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 {
 	int ret;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 9e00a902113e3..7aa6e8aca2c1a 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -192,11 +192,6 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 /*
  * XDR decode functions
  */
-int
-nfssvc_decode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_argsize_check(rqstp, p);
-}
 
 int
 nfssvc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
@@ -423,11 +418,6 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 /*
  * XDR encode functions
  */
-int
-nfssvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}
 
 int
 nfssvc_encode_stat(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index b8cc6a4b2e0ec..edd87688ff863 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -144,7 +144,6 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_void(struct svc_rqst *, __be32 *);
 int nfssvc_decode_fhandle(struct svc_rqst *, __be32 *);
 int nfssvc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_diropargs(struct svc_rqst *, __be32 *);
@@ -156,7 +155,6 @@ int nfssvc_decode_readlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
-int nfssvc_encode_void(struct svc_rqst *, __be32 *);
 int nfssvc_encode_stat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index ae6fa6c9cb467..456fcd7a10383 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -273,7 +273,6 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_voidarg(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_fhandle(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *);
@@ -290,7 +289,6 @@ int nfs3svc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirplusargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_commitargs(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_voidres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_attrstat(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_diropres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 679d40af1bbb1..37f89ad5e9923 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -781,8 +781,6 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
-int nfs4svc_decode_voidarg(struct svc_rqst *, __be32 *);
-int nfs4svc_encode_voidres(struct svc_rqst *, __be32 *);
 int nfs4svc_decode_compoundargs(struct svc_rqst *, __be32 *);
 int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
-- 
2.43.0




