Return-Path: <stable+bounces-169876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49CB29128
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 04:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9FE196464B
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7F1D88D7;
	Sun, 17 Aug 2025 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWQD7dlH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC515E96
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755397697; cv=none; b=m0FnsaejediFrHWMyq5AaIEcLQrgb8RzY1OaRMGCoRlZn9O4pUKHdhd5KFWZuBUr6EO9ElPapsSZCGxT2Kfw+u96pGph8juo8HyftgyPTOpIQXJZv9h+u/pE1CyOCGd366lWEM3PMe/mXx3mC83MUKYOSLQOJuXwLx0bAxStsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755397697; c=relaxed/simple;
	bh=uUXtbSSNvWOiQ8Acy8ydM2wE6j+KYoHxrpW8DAIN1dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4SmSOoygYM8lhzulxeL2u6dmW9U+0gmFCceq3n/nk1Ad50Sle2ZzO8v4lj+AZCAOaPHxHL4v7oMaFNFxPgZIEpvtnE6COu58ZsoIhJsYZ+hSq+S0of6dXOPN28ZJez0Uc8jaZSpwbsem8UpwGHg11GX27MOCwLQpSnDC3Eia80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWQD7dlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335BBC4CEF5;
	Sun, 17 Aug 2025 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755397696;
	bh=uUXtbSSNvWOiQ8Acy8ydM2wE6j+KYoHxrpW8DAIN1dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWQD7dlH1OzMrHvCepmwarcH8fEUoDdMLRWKsZoaZsgxh+5RWAC1p60HyZDiKEyja
	 csaH6l1eDpYcgoeFZR5zzx/IKZuNbnVCMWhVYak8D5wQj3IciCURkOeb8L4AaI6YpO
	 I6TqtAfm5QgG+lL48hbgW4gvzGQ9qierL2LJktt0nB6oMOQXIFQj2OuEDEvZxP254g
	 vQ7eKXHCZCbFHdMg6yUKFOdm9e/7rkWAlk2ACJUI1heyy035J3T4kK3vWOgKtEUAX6
	 LggbG/Yuovy9Pv5LFhrepiDFiYOOlbB5ODtcoeN0zMF0tzyV92TQIBNkZjXtRtZyAn
	 eNaWm6I8QmN2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 3/3] NFS: Fix the setting of capabilities when automounting a new filesystem
Date: Sat, 16 Aug 2025 22:28:12 -0400
Message-ID: <20250817022812.1338100-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250817022812.1338100-1-sashal@kernel.org>
References: <2025081556-illusive-crawlers-8c0e@gregkh>
 <20250817022812.1338100-1-sashal@kernel.org>
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
[ adapted to older fs_context-less API structures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/client.c     | 44 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfs/internal.h   |  1 +
 fs/nfs/nfs4client.c | 13 +------------
 fs/nfs/nfs4proc.c   |  2 ++
 4 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 323cef064f2a..bdece12af53e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -646,6 +646,42 @@ struct nfs_client *nfs_init_client(struct nfs_client *clp,
 }
 EXPORT_SYMBOL_GPL(nfs_init_client);
 
+static void nfs4_server_set_init_caps(struct nfs_server *server)
+{
+#if IS_ENABLED(CONFIG_NFS_V4)
+	/* Set the basic capabilities */
+	server->caps = server->nfs_client->cl_mvops->init_caps;
+	if (server->flags & NFS_MOUNT_NORDIRPLUS)
+		server->caps &= ~NFS_CAP_READDIRPLUS;
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
@@ -683,9 +719,6 @@ static int nfs_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = data->flags;
 	server->options = data->options;
-	server->caps |= NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
-		NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
-		NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
 
 	if (data->rsize)
 		server->rsize = nfs_block_size(data->rsize, NULL);
@@ -710,6 +743,8 @@ static int nfs_init_server(struct nfs_server *server,
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (data->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &data->mount_server.address,
@@ -834,7 +869,6 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1042,6 +1076,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_fsinfo(server, fh, fattr_fsinfo);
 	if (error < 0)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index bfb53756654d..46fc42d575ce 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -172,6 +172,7 @@ nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct nfs_mount_info *,
 					struct nfs_subversion *);
+extern void nfs_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(
 					struct nfs_mount_info *,
 					struct nfs_subversion *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 1f4bdcda3fda..eeab44727a76 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1011,18 +1011,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (error < 0)
 		goto out;
 
-	/* Set the basic capabilities */
-	server->caps |= server->nfs_client->cl_mvops->init_caps;
-	if (server->flags & NFS_MOUNT_NORDIRPLUS)
-			server->caps &= ~NFS_CAP_READDIRPLUS;
-	/*
-	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
-	 * authentication.
-	 */
-	if (nfs4_disable_idmapping &&
-			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
-		server->caps |= NFS_CAP_UIDGID_NOMAP;
-
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2145360d81ac..5f8de86b2798 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3884,6 +3884,8 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 		.interruptible = true,
 	};
 	int err;
+
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.50.1


