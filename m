Return-Path: <stable+bounces-53307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBF90D10A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02611C240D5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39B219D094;
	Tue, 18 Jun 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHOJnvqO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A28157E99;
	Tue, 18 Jun 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715941; cv=none; b=sQiM4V3oqHOsT67R0z5AzwAvMu2PYvUrhKU2hJIZxjGfEgJM+i7rVtiMde//I+auzw1JdQV+EeV5gQ5ceKMlF02OEqxSIBZHJK6PhYsG9tBuYJ6aO7lgS0dY5IidA598/9sHgU7SSDopjUSOgSrIFX8pJdBexnax2gKdUa6tNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715941; c=relaxed/simple;
	bh=z9VazQlGb6tDWyUQdPPLW4XNxGxBijYtqfF6p5iBC/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctV/jKxiwiaYY8IdHn/zDuuA9sHtRfoxLiZG2fCzQnDgo5IDHJ4AWU/Nl5NJRVv+7dVMURlh3WjU3LLJua3K8uLPAACdjhJmXKLO+AiLFGRtoyHsDw09MNvg25tKveSeWQoBRJzAjir4tU9o/Aj3lI6tI1rmOP1jcg2GMY/opd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHOJnvqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14495C3277B;
	Tue, 18 Jun 2024 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715941;
	bh=z9VazQlGb6tDWyUQdPPLW4XNxGxBijYtqfF6p5iBC/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHOJnvqO7zdKThFkQi0ExjDVg5eLOEZS4Oa2hXACoOn8pLF0WVxAnE19MDbWjDJ1+
	 iF2FO1NtQ6pQ6rsJGzpTs/AR+DhwfPEpesInoSxuEgVEcVtu1kF98kW//BJzrtK4wp
	 9j1AfWLS/h4GJrbtpMP5hyQTcLRzxh5GIqleiSls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 477/770] SUNRPC: Rename svc_create_xprt()
Date: Tue, 18 Jun 2024 14:35:30 +0200
Message-ID: <20240618123425.727516763@linuxfoundation.org>
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

[ Upstream commit 352ad31448fecc78a2e9b78da64eea5d63b8d0ce ]

Clean up: Use the "svc_xprt_<task>" function naming convention as
is used for other external APIs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc.c                  |  4 ++--
 fs/nfs/callback.c               | 12 ++++++------
 fs/nfsd/nfsctl.c                |  8 ++++----
 fs/nfsd/nfssvc.c                |  8 ++++----
 include/linux/sunrpc/svc_xprt.h |  7 ++++---
 net/sunrpc/svc_xprt.c           | 24 +++++++++++++++++++-----
 6 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index f5b688a844aa5..bba6f2b45b64a 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -197,8 +197,8 @@ static int create_lockd_listener(struct svc_serv *serv, const char *name,
 
 	xprt = svc_find_xprt(serv, name, net, family, 0);
 	if (xprt == NULL)
-		return svc_create_xprt(serv, name, net, family, port,
-						SVC_SOCK_DEFAULTS, cred);
+		return svc_xprt_create(serv, name, net, family, port,
+				       SVC_SOCK_DEFAULTS, cred);
 	svc_xprt_put(xprt);
 	return 0;
 }
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 7a810f8850632..c1a8767100ae9 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -45,18 +45,18 @@ static int nfs4_callback_up_net(struct svc_serv *serv, struct net *net)
 	int ret;
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
 
-	ret = svc_create_xprt(serv, "tcp", net, PF_INET,
-				nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
-				cred);
+	ret = svc_xprt_create(serv, "tcp", net, PF_INET,
+			      nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
+			      cred);
 	if (ret <= 0)
 		goto out_err;
 	nn->nfs_callback_tcpport = ret;
 	dprintk("NFS: Callback listener port = %u (af %u, net %x)\n",
 		nn->nfs_callback_tcpport, PF_INET, net->ns.inum);
 
-	ret = svc_create_xprt(serv, "tcp", net, PF_INET6,
-				nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
-				cred);
+	ret = svc_xprt_create(serv, "tcp", net, PF_INET6,
+			      nfs_callback_set_tcpport, SVC_SOCK_ANONYMOUS,
+			      cred);
 	if (ret > 0) {
 		nn->nfs_callback_tcpport6 = ret;
 		dprintk("NFS: Callback listener port = %u (af %u, net %x)\n",
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 68b020f2002b7..8fec779994f7b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -772,13 +772,13 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err != 0)
 		return err;
 
-	err = svc_create_xprt(nn->nfsd_serv, transport, net,
-				PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
+	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0)
 		goto out_err;
 
-	err = svc_create_xprt(nn->nfsd_serv, transport, net,
-				PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
+	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a1765e751b739..5790b1eaff72b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -293,13 +293,13 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
 		return 0;
 
-	error = svc_create_xprt(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
-					SVC_SOCK_DEFAULTS, cred);
+	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
+				SVC_SOCK_DEFAULTS, cred);
 	if (error < 0)
 		return error;
 
-	error = svc_create_xprt(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
-					SVC_SOCK_DEFAULTS, cred);
+	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
+				SVC_SOCK_DEFAULTS, cred);
 	if (error < 0)
 		return error;
 
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 1311425ddab7f..cba9559bba6ff 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -127,9 +127,10 @@ int	svc_reg_xprt_class(struct svc_xprt_class *);
 void	svc_unreg_xprt_class(struct svc_xprt_class *);
 void	svc_xprt_init(struct net *, struct svc_xprt_class *, struct svc_xprt *,
 		      struct svc_serv *);
-int	svc_create_xprt(struct svc_serv *, const char *, struct net *,
-			const int, const unsigned short, int,
-			const struct cred *);
+int	svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
+			struct net *net, const int family,
+			const unsigned short port, int flags,
+			const struct cred *cred);
 void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b5e80817b02f5..20baa0de70174 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -272,7 +272,7 @@ void svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *new)
 	svc_xprt_received(new);
 }
 
-static int _svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
+static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 			    struct net *net, const int family,
 			    const unsigned short port, int flags,
 			    const struct cred *cred)
@@ -308,21 +308,35 @@ static int _svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
 	return -EPROTONOSUPPORT;
 }
 
-int svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
+/**
+ * svc_xprt_create - Add a new listener to @serv
+ * @serv: target RPC service
+ * @xprt_name: transport class name
+ * @net: network namespace
+ * @family: network address family
+ * @port: listener port
+ * @flags: SVC_SOCK flags
+ * @cred: credential to bind to this transport
+ *
+ * Return values:
+ *   %0: New listener added successfully
+ *   %-EPROTONOSUPPORT: Requested transport type not supported
+ */
+int svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 		    struct net *net, const int family,
 		    const unsigned short port, int flags,
 		    const struct cred *cred)
 {
 	int err;
 
-	err = _svc_create_xprt(serv, xprt_name, net, family, port, flags, cred);
+	err = _svc_xprt_create(serv, xprt_name, net, family, port, flags, cred);
 	if (err == -EPROTONOSUPPORT) {
 		request_module("svc%s", xprt_name);
-		err = _svc_create_xprt(serv, xprt_name, net, family, port, flags, cred);
+		err = _svc_xprt_create(serv, xprt_name, net, family, port, flags, cred);
 	}
 	return err;
 }
-EXPORT_SYMBOL_GPL(svc_create_xprt);
+EXPORT_SYMBOL_GPL(svc_xprt_create);
 
 /*
  * Copy the local and remote xprt addresses to the rqstp structure
-- 
2.43.0




