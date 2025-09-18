Return-Path: <stable+bounces-169822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA6B2875E
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC43F3A7615
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993952253E9;
	Fri, 15 Aug 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+Whb4ZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046E21FF2D
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290857; cv=none; b=neW6Fa0YttdTfX7dHd/4ZBDF77P+b8SyimJFeMCDwH22bRpXYObEgyN2s2FLBl5luDqSOFdMdxjipsTDMgnBU95V94SlvaZ+tObFu2aKYWXIqIs479/LXHfa2gK0k26wzNLAJ1E/u+KRIHhC10Pzf9GxfrmWGJO0L994tfae1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290857; c=relaxed/simple;
	bh=gA+N1wd4958ejihNndhycis/0UKTGfmD9BXYSKgLPTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr4IK5iNM0a2B+NuXJvbWD99i8oBSPecETAsBoI3noCbB11QTfZt7xW/+Gjp2fvRja+WWBEGcvuAm2d+Ys62ZMrnBb6BaB6iHOnsXfdde6a0ZWELboSuKjebDeDtAAgAYUxyG054RcANMGGHYdS2mWUCXiYdA3wFE36xHp1se9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+Whb4ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22E0C4CEF6;
	Fri, 15 Aug 2025 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755290856;
	bh=gA+N1wd4958ejihNndhycis/0UKTGfmD9BXYSKgLPTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+Whb4ZKf6AnYmMGeb3MP7EkTlilJjD+lkRFzdfkBhfgyDNYuqY9Y+mDo8Fn6FoiR
	 xm36I6uZ19HQeatXjZHw8wshDKnZ+TBRUw4ZfmLp2gs0AFzABNYbBBm0U2TYA3p6jF
	 CS/Fyz7CZJgHY/8dRHDd4vcdDteria0o5cyL0C88AneiTgDLnEGhNh/3EMF9sVajKA
	 mz9wiZRwyGOD40sPZwY+S+t/eOY45Fa+b71nLX9bb6jIbGbKFcxVJ7+ZLNOVHCB9ec
	 4zimK8irOuq23shLz9fwqa6XYHwiz+2J7NH9QBT0vZ48PGDX6mY+BX0J3MooaOFG/8
	 lPqRFwUR89HRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] NFSv4: Fix nfs4_bitmap_copy_adjust()
Date: Fri, 15 Aug 2025 16:47:29 -0400
Message-ID: <20250815204731.220441-2-sashal@kernel.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit a71029b86752e8d40301af235a6bbf4896cc1402 ]

Don't remove flags from the set retrieved from the cache_validity.
We do want to retrieve all attributes that are listed as being
invalid, whether or not there is a delegation set.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6d68c11ce411..ee584aac9e0c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -292,7 +292,7 @@ const u32 nfs4_fs_locations_bitmap[3] = {
 };
 
 static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
-		struct inode *inode)
+				    struct inode *inode, unsigned long flags)
 {
 	unsigned long cache_validity;
 
@@ -300,22 +300,19 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!inode || !nfs4_have_delegation(inode, FMODE_READ))
 		return;
 
-	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
-	if (!(cache_validity & NFS_INO_REVAL_FORCED))
-		cache_validity &= ~(NFS_INO_INVALID_CHANGE
-				| NFS_INO_INVALID_SIZE);
+	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity) | flags;
 
+	/* Remove the attributes over which we have full control */
+	dst[1] &= ~FATTR4_WORD1_RAWDEV;
 	if (!(cache_validity & NFS_INO_INVALID_SIZE))
 		dst[0] &= ~FATTR4_WORD0_SIZE;
 
 	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
 		dst[0] &= ~FATTR4_WORD0_CHANGE;
-}
 
-static void nfs4_bitmap_copy_adjust_setattr(__u32 *dst,
-		const __u32 *src, struct inode *inode)
-{
-	nfs4_bitmap_copy_adjust(dst, src, inode);
+	if (!(cache_validity & NFS_INO_INVALID_OTHER))
+		dst[1] &= ~(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
+			    FATTR4_WORD1_OWNER_GROUP);
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -3379,12 +3376,15 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		.inode = inode,
 		.stateid = &arg.stateid,
 	};
+	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE;
 	int err;
 
+	if (sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID))
+		adjust_flags |= NFS_INO_INVALID_OTHER;
+
 	do {
-		nfs4_bitmap_copy_adjust_setattr(bitmask,
-				nfs4_bitmask(server, olabel),
-				inode);
+		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, olabel),
+					inode, adjust_flags);
 
 		err = _nfs4_do_setattr(inode, &arg, &res, cred, ctx);
 		switch (err) {
@@ -4192,8 +4192,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
 		task_flags |= RPC_TASK_TIMEOUT;
 
-	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode);
-
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode, 0);
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
 	return nfs4_do_call_sync(server->client, server, &msg,
@@ -4795,8 +4794,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 	}
 
 	nfs4_inode_make_writeable(inode);
-	nfs4_bitmap_copy_adjust_setattr(bitmask, nfs4_bitmask(server, res.label), inode);
-
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.label), inode,
+				NFS_INO_INVALID_CHANGE);
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
 		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
-- 
2.50.1


