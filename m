Return-Path: <stable+bounces-270897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5Ke1JnGgRmr0aQsAu9opvQ
	(envelope-from <stable+bounces-270897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:31:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB36FB685
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:31:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=QP6jGRhK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270897-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270897-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B6E33219C6
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD273603EF;
	Thu,  2 Jul 2026 16:35:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B325330B29;
	Thu,  2 Jul 2026 16:35:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010136; cv=none; b=YuBYQSCKZyTA3QY4VWvPf4fntOwria5SwmXEnZpsdctLKNfnC6yjJWJYOOoyrZxhdcnb4ysWXKskQJbGJrBl/CRHkvWGY5Y0bqOK/znV/nFXhb3CLVD1+K57G68QAITB3BWhU4tzQTU0ULPG1gMD+RmWcfEYaicdu9xp44sitOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010136; c=relaxed/simple;
	bh=C6q5jS3PvZREplQksMh7h6AEvyita6d9ANBUZdxXuZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb4/dPLBK+7gj4x+L8Om3MPhBKU6A6aAzbZHzZ1VlYSLQHz4oH/qr59mbMK32csGzprM/nJKsbHRRvd2UMgUk0n2QrhnSkxF8KsQ7DVRtrHMk/aKQtzHnLgMupO9uquPru+b1iPqno5QXWLep4csEa2wJXGDQ7350u1dgjyuwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QP6jGRhK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04C91F000E9;
	Thu,  2 Jul 2026 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010135;
	bh=VGJMVnHBvKbD/w286EIIjKuPC8C//Ccde8N48fZN5zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QP6jGRhKgI9Akdf+KyFuAqLnkhxQoQB4dCnqI2EsAHlOA2+zke5E9SaNjbo5l1VOb
	 DcvN6Z2nLvLubxOodkG7XeaEaNNpY6GjSMQfjkpd/uI4HWV3ASkbzfRpshiT+LPW67
	 3QH0bDyCoTxoH0hnN+yp6izTqC9NVBV5thY9ReP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 107/129] nfsd: fix posix_acl leak on SETACL decode failure
Date: Thu,  2 Jul 2026 18:20:26 +0200
Message-ID: <20260702155114.358613189@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00EB36FB685

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit 0853ac544c590880d797b04daa33fcb72b6be0e1 upstream.

nfsaclsvc_decode_setaclargs() and nfs3svc_decode_setaclargs() each
call nfs_stream_decode_acl() twice, first for NFS_ACL and then for
NFS_DFACL.  Each successful call transfers ownership of a freshly
allocated posix_acl into argp->acl_access or argp->acl_default.  If
the first call succeeds but the second fails, the decoder returns
false and argp->acl_access is left dangling.

ACLPROC2_SETACL.pc_release was wired to nfssvc_release_attrstat and
ACLPROC3_SETACL.pc_release was wired to nfs3svc_release_fhandle.
Both only call fh_put() and have no knowledge of the ACL fields on
argp.  The posix_acl_release() pairs sat at the out: labels inside
nfsacld_proc_setacl() and nfsd3_proc_setacl(), but svc_process()
skips pc_func when pc_decode returns false, so that cleanup is
unreachable on decode failure:

    svc_process_common()
      pc_decode()                  /* decode_setaclargs: false */
      /* pc_func skipped */
      pc_release()                 /* fh_put only -- ACLs leaked */

The orphaned posix_acl is leaked for the lifetime of the server.

Fix by adding nfsaclsvc_release_setacl() and nfs3svc_release_setacl(),
which release both argp->acl_access and argp->acl_default in addition
to fh_put(), and wiring them as pc_release for their respective SETACL
procedures.  pc_release runs on every path svc_process() takes after
decode, including decode failure, so the posix_acl_release() pairs are
removed from the proc functions' out: labels to keep ownership in one
place.  This matches the existing release_getacl() pattern used by
the sibling GETACL procedures.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs2acl.c |   17 ++++++++++++-----
 fs/nfsd/nfs3acl.c |   17 ++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -131,10 +131,7 @@ static __be32 nfsacld_proc_setacl(struct
 	resp->status = fh_getattr(fh, &resp->stat);
 
 out:
-	/* argp->acl_{access,default} may have been allocated in
-	   nfssvc_decode_setaclargs. */
-	posix_acl_release(argp->acl_access);
-	posix_acl_release(argp->acl_default);
+	/* argp->acl_{access,default} are released in nfsaclsvc_release_setacl. */
 	return rpc_success;
 
 out_drop_lock:
@@ -312,6 +309,16 @@ static void nfsaclsvc_release_access(str
 
 struct nfsd3_voidargs { int dummy; };
 
+static void nfsaclsvc_release_setacl(struct svc_rqst *rqstp)
+{
+	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
+	struct nfsd_attrstat *resp = rqstp->rq_resp;
+
+	fh_put(&resp->fh);
+	posix_acl_release(argp->acl_access);
+	posix_acl_release(argp->acl_default);
+}
+
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
@@ -345,7 +352,7 @@ static const struct svc_procedure nfsd_a
 		.pc_func = nfsacld_proc_setacl,
 		.pc_decode = nfsaclsvc_decode_setaclargs,
 		.pc_encode = nfssvc_encode_attrstatres,
-		.pc_release = nfssvc_release_attrstat,
+		.pc_release = nfsaclsvc_release_setacl,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
 		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -118,10 +118,7 @@ out_drop_lock:
 out_errno:
 	resp->status = nfserrno(error);
 out:
-	/* argp->acl_{access,default} may have been allocated in
-	   nfs3svc_decode_setaclargs. */
-	posix_acl_release(argp->acl_access);
-	posix_acl_release(argp->acl_default);
+	/* argp->acl_{access,default} are released in nfs3svc_release_setacl. */
 	return rpc_success;
 }
 
@@ -225,6 +222,16 @@ static void nfs3svc_release_getacl(struc
 
 struct nfsd3_voidargs { int dummy; };
 
+static void nfs3svc_release_setacl(struct svc_rqst *rqstp)
+{
+	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
+	struct nfsd3_attrstat *resp = rqstp->rq_resp;
+
+	fh_put(&resp->fh);
+	posix_acl_release(argp->acl_access);
+	posix_acl_release(argp->acl_default);
+}
+
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
@@ -258,7 +265,7 @@ static const struct svc_procedure nfsd_a
 		.pc_func = nfsd3_proc_setacl,
 		.pc_decode = nfs3svc_decode_setaclargs,
 		.pc_encode = nfs3svc_encode_setaclres,
-		.pc_release = nfs3svc_release_fhandle,
+		.pc_release = nfs3svc_release_setacl,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
 		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd3_attrstat),



