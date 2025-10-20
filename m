Return-Path: <stable+bounces-188250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A5BF37F3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CED234FAAEF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C32E090C;
	Mon, 20 Oct 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZM/45ag"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB241F37A1
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993412; cv=none; b=Ey4ovplmOuT+dyxFLDlbMjxjPH00Rvo2xmn51DJFtHahSpu8EMFMI4I59Gq+DCl7qdhXT/JMVmnwCtrIkhMz+cpG5i/R22eZCmNfibDkMU8KhglsjOmws0aVcJnXc4NZmyj4du5z2k4oBoArva+VHACc5Uk7sb9nW+uycNXdL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993412; c=relaxed/simple;
	bh=p2I2NYraTlQqi+AeaDGhG+re8GepK8LJIIQuJhcf0p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d49QMq4L2Xk9WGd7/xR425Rq95OXCORBI0DQcXswgRwDf46/CfJEAwFCF2xPIfjtR6rKWmPbP2tCfJbnjM8YacB1xzfxfNhGW7gVSdZinT3AUTXlaD0xQ1nQBf9nUWKkxN9rzyuHTFHXzWQZxDTiWpeBG4rzM0BLPWS0EMZN828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZM/45ag; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760993409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2BFBY39nNCt7qi+TDHA1Cukyk0M3YbxIYmbZtnwCRk=;
	b=cZM/45agLD3R+660NK08hiRmd7Ow+prBRlrCZMLsBgu9AJ0WVqP1xksZn/a9AE45cdm1xV
	+zae6PgVQND191mHAkchCTh20N3i+w9677X1pR27K9XUj1KbhlM6avoKmMRIiW/Qa9ykWL
	V9xlEBq6g8kutwwLHpn3Gr1rxh/lGmU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-sAFXLznQMXSUiwknhLtwiw-1; Mon,
 20 Oct 2025 16:50:07 -0400
X-MC-Unique: sAFXLznQMXSUiwknhLtwiw-1
X-Mimecast-MFC-AGG-ID: sAFXLznQMXSUiwknhLtwiw_1760993407
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECF6F18007EB;
	Mon, 20 Oct 2025 20:50:06 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 916E319560A2;
	Mon, 20 Oct 2025 20:50:06 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id CF6F94C0FA9;
	Mon, 20 Oct 2025 16:50:04 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: stable@vger.kernel.org
Cc: chuck.lever@oracle.com
Subject: [PATCH 6.6.y] nfsd: decouple the xprtsec policy check from check_nfsd_access()
Date: Mon, 20 Oct 2025 16:50:04 -0400
Message-ID: <20251020205004.1034718-1-smayhew@redhat.com>
In-Reply-To: <2025101611-revisit-ranging-52d6@gregkh>
References: <2025101611-revisit-ranging-52d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

[ Upstream commit e4f574ca9c6dfa66695bb054ff5df43ecea873ec ]

This is a backport of e4f574ca9c6d specifically for the 6.6-stable
kernel.  It differs from the upstream version mainly in that it's
working around the absence of some 6.12-era commits:
- 1459ad57673b nfsd: Move error code mapping to per-version proc code.
- 0a183f24a7ae NFSD: Handle @rqstp == NULL in check_nfsd_access()
- 5e66d2d92a1c nfsd: factor out __fh_verify to allow NULL rqstp to be
  passed

A while back I had reported that an NFSv3 client could successfully
mount using '-o xprtsec=none' an export that had been exported with
'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
would succeed and the mount would show up in /proc/mount.  Attempting
to do anything futher with the mount would be met with NFS3ERR_ACCES.

Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
so we shouldn't be conflating them when determining whether the access
checks can be bypassed.  Split check_nfsd_access() into two helpers, and
have fh_verify() call the helpers directly since fh_verify() has
logic that allows one or both of the checks to be skipped.  All other
sites will continue to call check_nfsd_access().

Link: https://lore.kernel.org/linux-nfs/ZjO3Qwf_G87yNXb2@aion/
Fixes: 9280c5774314 ("NFSD: Handle new xprtsec= export option")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/export.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/export.h |  2 ++
 fs/nfsd/nfsfh.c  | 12 +++++++++-
 3 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 4b5d998cbc2f..f4e77859aa85 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1071,28 +1071,62 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 	return exp;
 }
 
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+/**
+ * check_xprtsec_policy - check if access to export is allowed by the
+ * 			  xprtsec policy
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_acces or %nfserr_wrongsec if access is denied
+ */
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 {
-	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 	struct svc_xprt *xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
-	goto denied;
 
-ok:
+	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+}
+
+/**
+ * check_security_flavor - check if access to export is allowed by the
+ * 			  xprtsec policy
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_acces or %nfserr_wrongsec if access is denied
+ */
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp)
+{
+	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
+
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
 		return 0;
@@ -1117,10 +1151,20 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
-denied:
 	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
 }
 
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+{
+	__be32 status;
+
+	status = check_xprtsec_policy(exp, rqstp);
+	if (status != nfs_ok)
+		return status;
+
+	return check_security_flavor(exp, rqstp);
+}
+
 /*
  * Uses rq_client and rq_gssclient to find an export; uses rq_client (an
  * auth_unix client) if it's available and has secinfo information;
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ca9dc230ae3d..4a48b2ad5606 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -100,6 +100,8 @@ struct svc_expkey {
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 
 int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
 
 /*
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c2495d98c189..283c1a60c846 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -370,6 +370,16 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
+	/*
+	 * NLM is allowed to bypass the xprtsec policy check because lockd
+	 * doesn't support xprtsec.
+	 */
+	if (!(access & NFSD_MAY_LOCK)) {
+		error = check_xprtsec_policy(exp, rqstp);
+		if (error)
+			goto out;
+	}
+
 	/*
 	 * pseudoflavor restrictions are not enforced on NLM,
 	 * which clients virtually always use auth_sys for,
@@ -386,7 +396,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 			&& exp->ex_path.dentry == dentry)
 		goto skip_pseudoflavor_check;
 
-	error = check_nfsd_access(exp, rqstp);
+	error = check_security_flavor(exp, rqstp);
 	if (error)
 		goto out;
 
-- 
2.47.3


