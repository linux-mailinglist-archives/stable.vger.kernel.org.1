Return-Path: <stable+bounces-169818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3BB286D9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C577A1F57
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58E28CF75;
	Fri, 15 Aug 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFa7EL80"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801592264C5
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288214; cv=none; b=J9T3v+OUtZG9v2aWfyExGuLT4MuX/OT7o2X5nh88Nh6JvXj46wXRO3f3YCxI9CVwGuHy5akDdSeIXO4vUUhL6srAg2YW9cKyDCjFuCoU4MZ+gQ0THI3RRYyBZ/XUGkmnrmI0Xa4ZpSP/CiVGis1IcE7zWFqtvr/FYHW5T4jFEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288214; c=relaxed/simple;
	bh=5Bf8g4RvfJIElIbOUeQFpaUwIHwJIQpofwQgLpa0jow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lij+RsjyBX4jO5svqhflcLVCxyTBbuIBOPWhyeN6AnOAxBh8psppPWaObd5Ch0Kv9HTF3h24SSlWhEXO3Z4D5LFVtM4Xywm+1OVdyz/21ZVeQx1F6GKu3vcIGOvvDVrOmdI255JN00LdBcSDMw6UnDdj4clanWGEhQOvoL732Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFa7EL80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B32BC4CEF6;
	Fri, 15 Aug 2025 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755288214;
	bh=5Bf8g4RvfJIElIbOUeQFpaUwIHwJIQpofwQgLpa0jow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFa7EL80NmY6q/u3ng+TTCKGKbl/02GZMjYVMZCFQGKmOlOAejMAytqLdponCXouo
	 /71OlHEj/0q4Vbke36cL4/p7AKhmiAq1vkcCGODLDnLEdU8ZdPrpS6lODF6zoqsK9d
	 P3BGV2A/xSigd7ZclKEJDEzkCWeI8FejqRRbs8k5F1fSn4mjucl3C/K3Aup6pG5mmK
	 8vqIWvQiKGdPkLy8iMWdv1tJeX3fC2Mfi0/31YVp1kPq+W6Gdko12Eqg+XdO7cCykZ
	 6nPrqbIW7dbudwKlSZFEUQ2kzm+DM/eEwQ0vZAAdkviR8e3mCCeFQx3mPWUo/rHf+F
	 ZE/SeyIDb1PWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] NFS: Fix the setting of capabilities when automounting a new filesystem
Date: Fri, 15 Aug 2025 16:03:30 -0400
Message-ID: <20250815200330.201734-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815200330.201734-1-sashal@kernel.org>
References: <2025081556-hazard-eccentric-fcb9@gregkh>
 <20250815200330.201734-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit b01f21cacde9f2878492cf318fee61bf4ccad323 ]

Capabilities cannot be inherited when we cross into a new filesystem.
They need to be reset to the minimal defaults, and then probed for
again.

Fixes: 54ceac451598 ("NFS: Share NFS superblocks per-protocol per-server per-FSID")
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/client.c     | 44 ++++++++++++++++++++++++++++++++++++++++++--
 fs/nfs/internal.h   |  2 +-
 fs/nfs/nfs4client.c | 20 +-------------------
 fs/nfs/nfs4proc.c   |  2 +-
 4 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 10eef1368114..443b67beec37 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -661,6 +661,44 @@ struct nfs_client *nfs_init_client(struct nfs_client *clp,
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
@@ -699,7 +737,6 @@ static int nfs_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
 	server->options = ctx->options;
-	server->caps |= NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
 
 	switch (clp->rpc_ops->version) {
 	case 2:
@@ -735,6 +772,8 @@ static int nfs_init_server(struct nfs_server *server,
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (ctx->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &ctx->mount_server.address,
@@ -884,7 +923,6 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1095,6 +1133,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_fsinfo(server, fh, fattr_fsinfo);
 	if (error < 0)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 04f4b198bab3..5c81015fe9d4 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -219,7 +219,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
-extern void nfs4_server_set_init_caps(struct nfs_server *);
+extern void nfs_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index aa78428b40cc..7e4b126e3061 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1065,24 +1065,6 @@ static void nfs4_session_limit_xasize(struct nfs_server *server)
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
@@ -1102,7 +1084,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (error < 0)
 		goto out;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e93da9a03729..5a1d8ce5e4c4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3969,7 +3969,7 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.50.1


