Return-Path: <stable+bounces-185862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CFBE0E73
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719B81A21104
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB03305064;
	Wed, 15 Oct 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOx+6T5C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE02652A4
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566129; cv=none; b=uWAWEdiiFaSbbFyFYp0tFk6K8Rs+LEiAQlAuU/l8OLy3k0xF6/3egVmtAYleOpX83i8pxh+AThq8w1twFILeaES+dKPFBhM8QYZNeMkRMpZin+HQkVVAlHfMUbqMQmNx1EYROOlV8qSUYtWPG+OGksurDis/pN23VNHQ4CHvmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566129; c=relaxed/simple;
	bh=vj8qPiSUkrR3+FsKOjWLRaaOIl4/JqMD09PJ+fIb2qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yu33fkKSOv32pwgCg8CK/xnNAshkzEUuBh0RDpNVdzpD5rVA7BO4pmal2Pl5Q8OVWrEd3yK7Y9cJhNbPtYw5xMLa4emTfKQzTK0LseEJpUPetGgSwv7AWLYNLvel0y2kCSPJUATNSlmo4SQIBLWAcINE//qdT56Dcs0WcanY0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOx+6T5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20628C4CEF8;
	Wed, 15 Oct 2025 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760566128;
	bh=vj8qPiSUkrR3+FsKOjWLRaaOIl4/JqMD09PJ+fIb2qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOx+6T5ClShQPoMtCthoWwEGONfxb05o85kidKnphOGurIKLoBqObFwCd0cKwjRvO
	 BPbIzY7ysWzD9U10i87b2hBrzL2PkCp1t/nn63w0ER052XlYlbI/EKUNpEU6le/fKr
	 bwpu8KIskIj5RCSdqNHxHxEihSxcHDrxPdnPW8cr1TSsp7iCvsOsnN3uuRyHuDkDDn
	 6GBsCPB9CQcgV10UVFjMoXyDaA5/XzCfiKkckMOphFn/++KP3Ctt7aoDzUrVGSGWUB
	 w9jAs2pNNWx4zqrTGF7g454zKVnTKDDrQfOCK3VWfBE6PvjI1HSRg9j6+D5D87LcM8
	 lBF0cllHcOSPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
Date: Wed, 15 Oct 2025 18:08:42 -0400
Message-ID: <20251015220846.1531878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101547-demeanor-rectify-27be@gregkh>
References: <2025101547-demeanor-rectify-27be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

[ Upstream commit bb4f07f2409c26c01e97e6f9b432545f353e3b66 ]

Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
only GSS, but bypass any method. This is a problem specially for NFS3
AUTH_NULL-only exports.

The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
section 2.3.2, to allow mounting NFS2/3 GSS-only export without
authentication. So few procedures which do not expose security risk used
during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
client mount operation to finish successfully.

The problem with current implementation is that for AUTH_NULL-only exports,
the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
AUTH_NONE on active mount, which makes the mount inaccessible.

Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
and really allow to bypass only exports which have enabled some real
authentication (GSS, TLS, or any other).

The result would be: For AUTH_NULL-only export if client attempts to do
mount with AUTH_UNIX flavor then it will receive access errors, which
instruct client that AUTH_UNIX flavor is not usable and will either try
other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
Similarly if client attempt to do mount with AUTH_NULL flavor and only
AUTH_UNIX flavor is enabled then the client will receive access error.

This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 898374fdd7f0 ("nfsd: unregister with rpcbind when deleting a transport")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/export.c   | 21 ++++++++++++++++++++-
 fs/nfsd/export.h   |  3 ++-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  |  2 +-
 fs/nfsd/nfsfh.c    |  9 ++++++---
 fs/nfsd/vfs.c      |  2 +-
 6 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 49aede376d866..aa4712362b3b3 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1078,12 +1078,14 @@ static struct svc_export *exp_find(struct cache_detail *cd,
  * check_nfsd_access - check if access to export is allowed.
  * @exp: svc_export that is being accessed.
  * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
+ * @may_bypass_gss: reduce strictness of authorization check
  *
  * Return values:
  *   %nfs_ok if access is granted, or
  *   %nfserr_wrongsec if access is denied
  */
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
+			 bool may_bypass_gss)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 	struct svc_xprt *xprt;
@@ -1140,6 +1142,23 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return nfs_ok;
 
+	/* Some calls may be processed without authentication
+	 * on GSS exports. For example NFS2/3 calls on root
+	 * directory, see section 2.3.2 of rfc 2623.
+	 * For "may_bypass_gss" check that export has really
+	 * enabled some flavor with authentication (GSS or any
+	 * other) and also check that the used auth flavor is
+	 * without authentication (none or sys).
+	 */
+	if (may_bypass_gss && (
+	     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
+	     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
+		for (f = exp->ex_flavors; f < end; f++) {
+			if (f->pseudoflavor >= RPC_AUTH_DES)
+				return 0;
+		}
+	}
+
 denied:
 	return nfserr_wrongsec;
 }
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 3794ae253a701..4d92b99c1ffdd 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -101,7 +101,8 @@ struct svc_expkey {
 
 struct svc_cred;
 int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
+			 bool may_bypass_gss);
 
 /*
  * Function declarations
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 02c9f3b312a0e..7de04dc294cd9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2799,7 +2799,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
-				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
+				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
 		}
 encode_op:
 		if (op->status == nfserr_replay_me) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6edeb3bdf81b5..90db900b346ce 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3784,7 +3784,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 			nfserr = nfserrno(err);
 			goto out_put;
 		}
-		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
+		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
 		if (nfserr)
 			goto out_put;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 96e19c50a5d7e..cbb046f88eec6 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -320,6 +320,7 @@ __fh_verify(struct svc_rqst *rqstp,
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_export *exp = NULL;
+	bool may_bypass_gss = false;
 	struct dentry	*dentry;
 	__be32		error;
 
@@ -367,8 +368,10 @@ __fh_verify(struct svc_rqst *rqstp,
 	 * which clients virtually always use auth_sys for,
 	 * even while using RPCSEC_GSS for NFS.
 	 */
-	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
+	if (access & NFSD_MAY_LOCK)
 		goto skip_pseudoflavor_check;
+	if (access & NFSD_MAY_BYPASS_GSS)
+		may_bypass_gss = true;
 	/*
 	 * Clients may expect to be able to use auth_sys during mount,
 	 * even if they use gss for everything else; see section 2.3.2
@@ -376,9 +379,9 @@ __fh_verify(struct svc_rqst *rqstp,
 	 */
 	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
 			&& exp->ex_path.dentry == dentry)
-		goto skip_pseudoflavor_check;
+		may_bypass_gss = true;
 
-	error = check_nfsd_access(exp, rqstp);
+	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
 	if (error)
 		goto out;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ca29a5e1600fd..4b9ab32173105 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -321,7 +321,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
 	if (err)
 		return err;
-	err = check_nfsd_access(exp, rqstp);
+	err = check_nfsd_access(exp, rqstp, false);
 	if (err)
 		goto out;
 	/*
-- 
2.51.0


