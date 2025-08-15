Return-Path: <stable+bounces-169823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9DB2875F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ADBA25DE6
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F9242D6C;
	Fri, 15 Aug 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tonijYQ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECB23C4EA
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290859; cv=none; b=itPy4f6oLFozL9qahMMVF56BJsulQVvQPI93no/DlAPLnyFYVbVXDF8JK0VYY5vrfHPoVph+wj/wZS0rv6GoG2otxaS0KKvPOLVMo3+05+83O93Xgdzq+V2bnHj4QY+GOKDnyZXhMx+OaqE6smXQgl2OtDr+9NNdaZCJRHN/6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290859; c=relaxed/simple;
	bh=JvRg9tppw8by77zyPdCMlnk1QjTuwnXG5jVRNf/eDjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siMlFhruZUZ2pnqcKVXiR9AO8q5LXc1X2ltnDcFNxaiZ5Swd54LqN4NRDWv6gIrho7nsYljRpsVHPM1zG0fmy1zy14VbRDoYF5dBZzH8OYvAc8oDL98GV6pOrR02s15XVjRSZhYhOppIc6CZZFeh9yePm6Xqrd4jGZnyV9DA0Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tonijYQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4256CC4CEEB;
	Fri, 15 Aug 2025 20:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755290858;
	bh=JvRg9tppw8by77zyPdCMlnk1QjTuwnXG5jVRNf/eDjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tonijYQ72W1uKIIlMhqVSKHFuQj78L8sCqPI32+s5XaNK1s6nU/+agFFsJqK5PRtG
	 jNCRou5PVUvBoXRVUNhpKZDn4hAyVtIQcI2d5tNBGNKVBww3PJO7/tON80zq0VJVzI
	 ptmoWNGu/pdTictSlOhGjUdlTeaq2lYkhP6OAkDxvCv7Oci09hZJW7kn6FvIBaGb1C
	 xveQGoSwExuOloWLETfxJ7X/L64dXRtW84olwVqjmVIx5kEbYpXazbgp+AwHn6+4AP
	 gSLJT+trH9soE0Buu3Hsla2ImpMqbid9wrfBK1l5U4pN7sqatDLpBqo6ZPAe7m9siv
	 TbHU946zJewJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] NFS: Create an nfs4_server_set_init_caps() function
Date: Fri, 15 Aug 2025 16:47:30 -0400
Message-ID: <20250815204731.220441-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815204731.220441-1-sashal@kernel.org>
References: <2025081556-disprove-clumsy-91a1@gregkh>
 <20250815204731.220441-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

[ Upstream commit 01dde76e471229e3437a2686c572f4980b2c483e ]

And call it before doing an FSINFO probe to reset to the baseline
capabilities before probing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/internal.h   |  1 +
 fs/nfs/nfs4client.c | 33 +++++++++++++++++++--------------
 fs/nfs/nfs4proc.c   |  2 ++
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2fdc7c2a17fe..52a6512dab4d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -222,6 +222,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
+extern void nfs4_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 252c99c76a42..e12a902e02c2 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1025,6 +1025,24 @@ static void nfs4_session_limit_xasize(struct nfs_server *server)
 #endif
 }
 
+void nfs4_server_set_init_caps(struct nfs_server *server)
+{
+	/* Set the basic capabilities */
+	server->caps |= server->nfs_client->cl_mvops->init_caps;
+	if (server->flags & NFS_MOUNT_NORDIRPLUS)
+			server->caps &= ~NFS_CAP_READDIRPLUS;
+	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
+		server->caps &= ~NFS_CAP_READ_PLUS;
+
+	/*
+	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
+	 * authentication.
+	 */
+	if (nfs4_disable_idmapping &&
+			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
+		server->caps |= NFS_CAP_UIDGID_NOMAP;
+}
+
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
@@ -1044,20 +1062,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (error < 0)
 		goto out;
 
-	/* Set the basic capabilities */
-	server->caps |= server->nfs_client->cl_mvops->init_caps;
-	if (server->flags & NFS_MOUNT_NORDIRPLUS)
-			server->caps &= ~NFS_CAP_READDIRPLUS;
-	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
-		server->caps &= ~NFS_CAP_READ_PLUS;
-	/*
-	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
-	 * authentication.
-	 */
-	if (nfs4_disable_idmapping &&
-			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
-		server->caps |= NFS_CAP_UIDGID_NOMAP;
-
+	nfs4_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ee584aac9e0c..150b49a749f2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3934,6 +3934,8 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 		.interruptible = true,
 	};
 	int err;
+
+	nfs4_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.50.1


