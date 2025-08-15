Return-Path: <stable+bounces-169817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B7B286D8
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA61CC0F6F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC22853EB;
	Fri, 15 Aug 2025 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuD+ohs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1762264C5
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288213; cv=none; b=kqntPbIZ5BZDSh4W0pAle6jNLUf76B2VUhUm204iztEYaGSjF0cnSftiBUYxyaqDWKFVHHLFwNus1QMSnMv0QOrMVCNpV9ur5zjFSD5PEWhHeNjim+Jm4Pw5UOSraXZtZ3zJcPXvtHLCCGoHgsHAHjNNR4vQUL3Ll4TFToSQeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288213; c=relaxed/simple;
	bh=z0obnKzdcRhp7umcxux1uFyDyNej3ogU3ORcI86Lfxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr56Y2lqBJO62qxHiZs8+y3kLH9zTFRoY15VjqfDIXQbA+NhdBUGYFa3nyuiFcOxEPYVHizojZzDjqmm9yH9zHqPNovwnMLANTrhWmBjd5UC3SK/EYf+E7Q8h94kNMiLammO8XdoeUkNk22nxwma6ldq+1PMaQ923rrxPjXQeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuD+ohs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A36C4CEEB;
	Fri, 15 Aug 2025 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755288213;
	bh=z0obnKzdcRhp7umcxux1uFyDyNej3ogU3ORcI86Lfxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuD+ohs1kHiIUpaN2gW0cohYSyOx3AWSYjcG1fq65d/dYevQN84Yby0tAg6vXpUuU
	 msSbmdds5fgFTK6cSc/eAv88eqhnrBbMVTbbT6rm6Pa4hNsjL7N9q7mGnyWYk/b1Rk
	 0/iQCpVhjXGxC6djiSV0EqN4fyos613gfkWArCvPkx33LALTvRUz6td7TKeLWKwwBv
	 NhMLHN7PCoB9Ub8eY7iFjAjp2tIw9zi7EfXnjSK4kZKA9UL5RNoEnxNbigppMVeUw8
	 AI9aLcKzIj5OmckyJE9aMGTU8s241+mdMBM127fONHod1A2QFKbnqBywyZjoJjNmVq
	 zmGBq2IHAnsPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] NFS: Create an nfs4_server_set_init_caps() function
Date: Fri, 15 Aug 2025 16:03:29 -0400
Message-ID: <20250815200330.201734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081556-hazard-eccentric-fcb9@gregkh>
References: <2025081556-hazard-eccentric-fcb9@gregkh>
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
index a6d0b64dda36..04f4b198bab3 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -219,6 +219,7 @@ extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct fs_context *);
+extern void nfs4_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 8557b2218aa1..aa78428b40cc 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1065,6 +1065,24 @@ static void nfs4_session_limit_xasize(struct nfs_server *server)
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
@@ -1084,20 +1102,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
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
index 9d4e4146efef..e93da9a03729 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3968,6 +3968,8 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
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


