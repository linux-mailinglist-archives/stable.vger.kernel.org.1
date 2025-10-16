Return-Path: <stable+bounces-186142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38193BE3AED
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D261A65AA6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A71E5B73;
	Thu, 16 Oct 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgZ5X7DQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72A3168F6
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621002; cv=none; b=DFhxRFWHu+CG9PQgOp5XpQeZD0dja+NmV+qZa/uWpN+3aAZv+LcbrCkP7d87ForGtjATQ9BheSmfO39EaZjRUX8PPa8cQ0PxBslSjillUx9DKLJPuVqO4EdZddgk50r6mtwlSnyWGn72FML3Fep56DQx7NvLSYMd/ObFbeekNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621002; c=relaxed/simple;
	bh=jsG2vo+4s7jOyOJlTjjtqJO1YQQ9zvqItOOaydF1I/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mqMgTtV0cPc13GrFfqcD2sS87VZECOKtjVcLVBKh+x0ZrDwVpqLugplBA2YZTH8tMxFCq6GenSXTTQu/pV3CNagk3bGV/W4+YO2iA7zempec71IfIflpumUwYrTkkcKKvwwNHwxDUI8Fh9kwRn1g2mX6/Wk11qEbwZLiE22yw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgZ5X7DQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F6EC4CEF1;
	Thu, 16 Oct 2025 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760621002;
	bh=jsG2vo+4s7jOyOJlTjjtqJO1YQQ9zvqItOOaydF1I/k=;
	h=Subject:To:Cc:From:Date:From;
	b=dgZ5X7DQ4RGtbKRGfglgQ/X7p+YJqP1Kf9Y0XSWmPywTumgdsLhH2ml/NVU5MXBmP
	 B8HMSJJfor0fDk1lxkifhd1axICH0/7EPIoHhdCKmiSpN0YaHl7baDfKk04H8y12hU
	 LoWfoJPs8EVOOpfzZxkIyMb0cAMF4l1efXQJTHJ4=
Subject: FAILED: patch "[PATCH] nfsd: decouple the xprtsec policy check from" failed to apply to 6.6-stable tree
To: smayhew@redhat.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:23:11 +0200
Message-ID: <2025101611-revisit-ranging-52d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e4f574ca9c6dfa66695bb054ff5df43ecea873ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101611-revisit-ranging-52d6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4f574ca9c6dfa66695bb054ff5df43ecea873ec Mon Sep 17 00:00:00 2001
From: Scott Mayhew <smayhew@redhat.com>
Date: Wed, 6 Aug 2025 15:15:43 -0400
Subject: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()

A while back I had reported that an NFSv3 client could successfully
mount using '-o xprtsec=none' an export that had been exported with
'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
would succeed and the mount would show up in /proc/mount.  Attempting
to do anything futher with the mount would be met with NFS3ERR_ACCES.

This was fixed (albeit accidentally) by commit bb4f07f2409c ("nfsd:
Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
subsequently re-broken by commit 0813c5f01249 ("nfsd: fix access
checking for NLM under XPRTSEC policies").

Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
so we shouldn't be conflating them when determining whether the access
checks can be bypassed.  Split check_nfsd_access() into two helpers, and
have __fh_verify() call the helpers directly since __fh_verify() has
logic that allows one or both of the checks to be skipped.  All other
sites will continue to call check_nfsd_access().

Link: https://lore.kernel.org/linux-nfs/ZjO3Qwf_G87yNXb2@aion/
Fixes: 9280c5774314 ("NFSD: Handle new xprtsec= export option")
Cc: stable@vger.kernel.org
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index cadfc2bae60e..95b5681152c4 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1082,50 +1082,62 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 }
 
 /**
- * check_nfsd_access - check if access to export is allowed.
+ * check_xprtsec_policy - check if access to export is allowed by the
+ *			  xprtsec policy
  * @exp: svc_export that is being accessed.
- * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
- * @may_bypass_gss: reduce strictness of authorization check
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is __fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
  *
  * Return values:
  *   %nfs_ok if access is granted, or
  *   %nfserr_wrongsec if access is denied
  */
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
-			 bool may_bypass_gss)
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 {
-	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt;
-
-	/*
-	 * If rqstp is NULL, this is a LOCALIO request which will only
-	 * ever use a filehandle/credential pair for which access has
-	 * been affirmed (by ACCESS or OPEN NFS requests) over the
-	 * wire. So there is no need for further checks here.
-	 */
-	if (!rqstp)
-		return nfs_ok;
-
-	xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
 
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
-	if (!may_bypass_gss)
-		goto denied;
+	return nfserr_wrongsec;
+}
+
+/**
+ * check_security_flavor - check if access to export is allowed by the
+ *			   security flavor
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ * @may_bypass_gss: reduce strictness of authorization check
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is __fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp,
+			     bool may_bypass_gss)
+{
+	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 
-ok:
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
 		return nfs_ok;
@@ -1167,10 +1179,30 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 		}
 	}
 
-denied:
 	return nfserr_wrongsec;
 }
 
+/**
+ * check_nfsd_access - check if access to export is allowed.
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ * @may_bypass_gss: reduce strictness of authorization check
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
+			 bool may_bypass_gss)
+{
+	__be32 status;
+
+	status = check_xprtsec_policy(exp, rqstp);
+	if (status != nfs_ok)
+		return status;
+	return check_security_flavor(exp, rqstp, may_bypass_gss);
+}
+
 /*
  * Uses rq_client and rq_gssclient to find an export; uses rq_client (an
  * auth_unix client) if it's available and has secinfo information;
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index b9c0adb3ce09..ef5581911d5b 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -101,6 +101,9 @@ struct svc_expkey {
 
 struct svc_cred;
 int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp,
+			     bool may_bypass_gss);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 			 bool may_bypass_gss);
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index f4c2fb3dd5d0..062cfc18d8c6 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -364,10 +364,30 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
+	/*
+	 * If rqstp is NULL, this is a LOCALIO request which will only
+	 * ever use a filehandle/credential pair for which access has
+	 * been affirmed (by ACCESS or OPEN NFS requests) over the
+	 * wire.  Skip both the xprtsec policy and the security flavor
+	 * checks.
+	 */
+	if (!rqstp)
+		goto check_permissions;
+
 	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
 		/* NLM is allowed to fully bypass authentication */
 		goto out;
 
+	/*
+	 * NLM is allowed to bypass the xprtsec policy check because lockd
+	 * doesn't support xprtsec.
+	 */
+	if (!(access & NFSD_MAY_NLM)) {
+		error = check_xprtsec_policy(exp, rqstp);
+		if (error)
+			goto out;
+	}
+
 	if (access & NFSD_MAY_BYPASS_GSS)
 		may_bypass_gss = true;
 	/*
@@ -379,13 +399,15 @@ __fh_verify(struct svc_rqst *rqstp,
 			&& exp->ex_path.dentry == dentry)
 		may_bypass_gss = true;
 
-	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
+	error = check_security_flavor(exp, rqstp, may_bypass_gss);
 	if (error)
 		goto out;
+
 	/* During LOCALIO call to fh_verify will be called with a NULL rqstp */
 	if (rqstp)
 		svc_xprt_set_valid(rqstp->rq_xprt);
 
+check_permissions:
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:


