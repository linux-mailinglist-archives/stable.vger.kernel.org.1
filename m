Return-Path: <stable+bounces-170542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0BB2A515
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A7468328B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4D31E10D;
	Mon, 18 Aug 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/KbEWV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366322156C;
	Mon, 18 Aug 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522976; cv=none; b=gRPQAlcEdRsbzylgFymOU5mdk6XeCYeUtJq2f++kyXN3v7/OKHkmziTK6z2Xes3Bl1WAuwGeDKFLiu9YZRS8ShZ/aMlC6hjkyKIu96Q0ODPUl8lcONulB6woSUYEVTUPwN2Tkf8lfM6Po5++rzB3oh5DMIwNHovUCbO4LDG2gM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522976; c=relaxed/simple;
	bh=IJ54ATFTEe8KKHi6d5rvnqV4LNjnz1xcsBvkcIKiZB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0aiv5oR7pzlZAZn+jqr/6mh1Oqr9ZRibVohx4WJVWhgKMpIBd23imtexP9Q1PcoCCVIRqe52KZ1+U6JmxL+pOFdYRsEPZ8+sSPH8G0WanGiP2uNz21J5C5TNapznqPh2UpRZqBQiTels6UWxFD5nP8K18bmATSITeg7BcfEKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/KbEWV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB45AC4CEEB;
	Mon, 18 Aug 2025 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522976;
	bh=IJ54ATFTEe8KKHi6d5rvnqV4LNjnz1xcsBvkcIKiZB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/KbEWV+gnK8HmgWzL4hmoVoQgahnflatqfpqVg56CuPwplqTPSo8W+Gn7woqYD2N
	 ngbg+HnenITFq04nsD/shwlVbKxhWkcbX+CgOc2BIID+v6C32VT9edEuzYdrT2qfYH
	 GcgWCgeRO7tDacNOMn2lD/wYed2tWAu2T/So7Ito=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 6.15 032/515] NFS: Fix the setting of capabilities when automounting a new filesystem
Date: Mon, 18 Aug 2025 14:40:18 +0200
Message-ID: <20250818124459.689868339@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -682,6 +682,44 @@ struct nfs_client *nfs_init_client(struc
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
@@ -726,7 +764,6 @@ static int nfs_init_server(struct nfs_se
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
 	server->options = ctx->options;
-	server->caps |= NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
 
 	switch (clp->rpc_ops->version) {
 	case 2:
@@ -762,6 +799,8 @@ static int nfs_init_server(struct nfs_se
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (ctx->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &ctx->mount_server.address,
@@ -936,7 +975,6 @@ void nfs_server_copy_userdata(struct nfs
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1170,6 +1208,8 @@ struct nfs_server *nfs_clone_server(stru
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_server(server, fh);
 	if (error < 0)
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -232,7 +232,7 @@ extern struct nfs_client *
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
@@ -1088,24 +1088,6 @@ static void nfs4_session_limit_xasize(st
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
@@ -1120,7 +1102,7 @@ static int nfs4_server_common_setup(stru
 	if (error < 0)
 		goto out;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4083,7 +4083,7 @@ int nfs4_server_capabilities(struct nfs_
 	};
 	int err;
 
-	nfs4_server_set_init_caps(server);
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),



