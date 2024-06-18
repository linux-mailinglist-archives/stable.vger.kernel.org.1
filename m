Return-Path: <stable+bounces-53182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4590D092
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E81C23EFC
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272B1849C0;
	Tue, 18 Jun 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kM4xgdd3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9915689A;
	Tue, 18 Jun 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715571; cv=none; b=SdNAGuK2bMHTlvDtJuycqy3otrwuiOYZ+7z8e02J+y4pLl+0fU/VxywUtSsJSH87PU8JkVf7zRvBLl9t+jIVuGu2ZSY95JIgGru5cI47f4pVl1YcmPEePPGvpnazcY1Ev+JO2SfDIhLfr8qVHgJRxjKU2rdhmRBt2N4JoGSKQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715571; c=relaxed/simple;
	bh=ZIqiWbzoWViWilrGVYk9bi601Lz/PO+G8btS35aHpfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs5rjMW+Grn8OcNlZFyu0zoHnBh7XKYOftaHOntE2bUrsBLSPMAo9rjt07z1lC+MPr55l4seUyihgK7rTC3PKZNoKkJZMMi02PKvce4e8dgR3gQQUmLxXsgxZnRl/vOVOjWki4y8uMtEneROEOdyWdmTpDtiILQ9Um9U8aN6F1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kM4xgdd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDEFC3277B;
	Tue, 18 Jun 2024 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715571;
	bh=ZIqiWbzoWViWilrGVYk9bi601Lz/PO+G8btS35aHpfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM4xgdd37CZz6Z9J7f+MpuA7hdaeZs2kInYSGpA/OwKCiCo117AEEarpbVULM+LCv
	 vD8mg/pF0WIvYttCQD5JNo5QDJsrbyK5o3m8u4yBbt+54jKIO5LN1ox+x6G21hj845
	 AeTbQZJXwgezetgQz63nE3liS/+b3y3PDXsVdpYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 354/770] SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
Date: Tue, 18 Jun 2024 14:33:27 +0200
Message-ID: <20240618123420.933683356@linuxfoundation.org>
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

[ Upstream commit 5c2465dfd457f3015eebcc3ace50570e1d896aeb ]

In a few moments, rq_auth_stat will need to be explicitly set to
rpc_auth_ok before execution gets to the dispatcher.

svc_authenticate() already sets it, but it often gets reset to
rpc_autherr_badcred right after that call, even when authentication
is successful. Let's ensure that the pg_authenticate callout and
svc_set_client() set it properly in every case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc.c                    | 2 ++
 fs/nfs/callback.c                 | 4 ++++
 net/sunrpc/auth_gss/svcauth_gss.c | 4 ++++
 net/sunrpc/svc.c                  | 4 +---
 net/sunrpc/svcauth_unix.c         | 6 +++++-
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 0ab9756ed2359..b632be3ad57b2 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -649,6 +649,7 @@ static int lockd_authenticate(struct svc_rqst *rqstp)
 	switch (rqstp->rq_authop->flavour) {
 		case RPC_AUTH_NULL:
 		case RPC_AUTH_UNIX:
+			rqstp->rq_auth_stat = rpc_auth_ok;
 			if (rqstp->rq_proc == 0)
 				return SVC_OK;
 			if (is_callback(rqstp->rq_proc)) {
@@ -659,6 +660,7 @@ static int lockd_authenticate(struct svc_rqst *rqstp)
 			}
 			return svc_set_client(rqstp);
 	}
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	return SVC_DENIED;
 }
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 7817ad94a6bae..86d856de1389b 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -429,6 +429,8 @@ check_gss_callback_principal(struct nfs_client *clp, struct svc_rqst *rqstp)
  */
 static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 {
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
+
 	switch (rqstp->rq_authop->flavour) {
 	case RPC_AUTH_NULL:
 		if (rqstp->rq_proc != CB_NULL)
@@ -439,6 +441,8 @@ static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 		 if (svc_is_backchannel(rqstp))
 			return SVC_DENIED;
 	}
+
+	rqstp->rq_auth_stat = rpc_auth_ok;
 	return SVC_OK;
 }
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 54303b7efde76..329eac782cc5e 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1038,6 +1038,8 @@ svcauth_gss_set_client(struct svc_rqst *rqstp)
 	struct rpc_gss_wire_cred *gc = &svcdata->clcred;
 	int stat;
 
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
+
 	/*
 	 * A gss export can be specified either by:
 	 * 	export	*(sec=krb5,rw)
@@ -1053,6 +1055,8 @@ svcauth_gss_set_client(struct svc_rqst *rqstp)
 	stat = svcauth_unix_set_client(rqstp);
 	if (stat == SVC_DROP || stat == SVC_CLOSE)
 		return stat;
+
+	rqstp->rq_auth_stat = rpc_auth_ok;
 	return SVC_OK;
 }
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index cbcc951639ad5..f036507275338 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1350,10 +1350,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	 */
 	auth_res = svc_authenticate(rqstp);
 	/* Also give the program a chance to reject this call: */
-	if (auth_res == SVC_OK && progp) {
-		rqstp->rq_auth_stat = rpc_autherr_badcred;
+	if (auth_res == SVC_OK && progp)
 		auth_res = progp->pg_authenticate(rqstp);
-	}
 	if (auth_res != SVC_OK)
 		trace_svc_authenticate(rqstp, auth_res);
 	switch (auth_res) {
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index c20c63d651a9c..1868596259af5 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -699,8 +699,9 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 
 	rqstp->rq_client = NULL;
 	if (rqstp->rq_proc == 0)
-		return SVC_OK;
+		goto out;
 
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	ipm = ip_map_cached_get(xprt);
 	if (ipm == NULL)
 		ipm = __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program->pg_class,
@@ -737,6 +738,9 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 		put_group_info(cred->cr_group_info);
 		cred->cr_group_info = gi;
 	}
+
+out:
+	rqstp->rq_auth_stat = rpc_auth_ok;
 	return SVC_OK;
 }
 
-- 
2.43.0




