Return-Path: <stable+bounces-170082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B6CB2A28B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0183D178B74
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696C31E0F7;
	Mon, 18 Aug 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQGl/4iF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D530DD0F;
	Mon, 18 Aug 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521456; cv=none; b=CurdKiUvRQwsq41tQq68A/ZdAkvju1xH9A4Y805lcKFVvwULZ28NNMv9UOyw20XODgBlnpSSav3YgHWdzWH7peJU9Ay57hMYaqg2zqg5AS+2Pht8u5lG2S7pWn3YTgvFZqzoFR/hy7sVhsAsD7Z0QMkwGGKmfn+UhmuTB70cXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521456; c=relaxed/simple;
	bh=WpZHaYHRS2dlsfI25FBAho8MJU810PL0OruKd8tZvTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN4PUSfkJEQ5tMPUTNEZvtcIy6Wf2xbBIjnNmbXBVlUpJhWUtcQu/ppKhwvvleFUrsa1NtG5mocE9zWIAnt4MeQ4C1MRQtUAmfonkfkf9euYTfWODwRyFijjFE/vwz8Sn4XxWkrYU/T+QfS5KnY0L4w8JD/MvlJ01KGGvXpSPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQGl/4iF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A69C4CEEB;
	Mon, 18 Aug 2025 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521456;
	bh=WpZHaYHRS2dlsfI25FBAho8MJU810PL0OruKd8tZvTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQGl/4iFGSv+z/7qmF2QqUfMqXYB2aZCeXORccYKXHQ0GF+z9U7z078Z1JYXMucgC
	 VQlD/XBQYtxnfVKAey4eaLlXbFHvywZn4xv+p4BV2p9zxAutUM1b4E+NnRjEy/v9+C
	 +EX1sAJf7DMt+Qv1Cx42RChHUbjXlKTJnDmEK0pA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 6.12 025/444] NFS: Fix the setting of capabilities when automounting a new filesystem
Date: Mon, 18 Aug 2025 14:40:51 +0200
Message-ID: <20250818124449.878944622@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit b01f21cacde9f2878492cf318fee61bf4ccad323 upstream.

Capabilities cannot be inherited when we cross into a new filesystem.
They need to be reset to the minimal defaults, and then probed for
again.

Fixes: 54ceac451598 ("NFS: Share NFS superblocks per-protocol per-server per-FSID")
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/client.c     |   44 ++++++++++++++++++++++++++++++++++++++++++--
 fs/nfs/internal.h   |    2 +-
 fs/nfs/nfs4client.c |   20 +-------------------
 fs/nfs/nfs4proc.c   |    2 +-
 4 files changed, 45 insertions(+), 23 deletions(-)

--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -676,6 +676,44 @@ struct nfs_client *nfs_init_client(struc
 }
 EXPORT_SYMBOL_GPL(nfs_init_client);
 
+static void nfs4_server_set_init_caps(struct nfs_server *server)
+{
+#if IS_ENABLED(CONFIG_NFS_V4)
+	/* Set the basic capabilities */
+	server->caps = server->nfs_client->cl_mvops->init_caps;
+	if (server->flags & NFS_MOUNT_NORDIRPLUS)
+		server->caps &= ~NFS_CAP_READDIRPLUS;
+	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
+		server->caps &= ~NFS_CAP_READ_PLUS;
+
+	/*
+	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
+	 * authentication.
+	 */
+	if (nfs4_disable_idmapping &&
+	    server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
+		server->caps |= NFS_CAP_UIDGID_NOMAP;
+#endif
+}
+
+void nfs_server_set_init_caps(struct nfs_server *server)
+{
+	switch (server->nfs_client->rpc_ops->version) {
+	case 2:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		break;
+	case 3:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		if (!(server->flags & NFS_MOUNT_NORDIRPLUS))
+			server->caps |= NFS_CAP_READDIRPLUS;
+		break;
+	default:
+		nfs4_server_set_init_caps(server);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
+
 /*
  * Create a version 2 or 3 client
  */
@@ -717,7 +755,6 @@ static int nfs_init_server(struct nfs_se
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
 	server->options = ctx->options;
-	server->caps |= NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
 
 	switch (clp->rpc_ops->version) {
 	case 2:
@@ -753,6 +790,8 @@ static int nfs_init_server(struct nfs_se
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (ctx->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &ctx->mount_server.address,
@@ -927,7 +966,6 @@ void nfs_server_copy_userdata(struct nfs
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1161,6 +1199,8 @@ struct nfs_server *nfs_clone_server(stru
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_server(server, fh);
 	if (error < 0)
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -231,7 +231,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
-extern void nfs4_server_set_init_caps(struct nfs_server *);
+extern void nfs_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1081,24 +1081,6 @@ static void nfs4_session_limit_xasize(st
 #endif
 }
 
-void nfs4_server_set_init_caps(struct nfs_server *server)
-{
-	/* Set the basic capabilities */
-	server->caps |= server->nfs_client->cl_mvops->init_caps;
-	if (server->flags & NFS_MOUNT_NORDIRPLUS)
-			server->caps &= ~NFS_CAP_READDIRPLUS;
-	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
-		server->caps &= ~NFS_CAP_READ_PLUS;
-
-	/*
-	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
-	 * authentication.
-	 */
-	if (nfs4_disable_idmapping &&
-			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
-		server->caps |= NFS_CAP_UIDGID_NOMAP;
-}
-
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
@@ -1113,7 +1095,7 @@ static int nfs4_server_common_setup(stru
 	if (error < 0)
 		goto out;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4064,7 +4064,7 @@ int nfs4_server_capabilities(struct nfs_
 	};
 	int err;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),



