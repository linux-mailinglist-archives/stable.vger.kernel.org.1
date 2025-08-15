Return-Path: <stable+bounces-169821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F6B28757
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02005E0AE8
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4841EDA3C;
	Fri, 15 Aug 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA4lum7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C626AF3
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290855; cv=none; b=ptAHThHagGHodRwf0dY+pY8lYMJTCT3c3wuyvCGy+OHqCbQgLncqUVYbAV2fNWSem4uXlwI++3kSaVOb6xgS/VgZ3BU8nSsUrirQzldsJecuPo0mGb7aJZKRFmYv601imsD8aIRMucXvy9P/FcHzx3bKaH/sF/TWe1Yd6npvmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290855; c=relaxed/simple;
	bh=XsKgwwAW5ikpjk4PUGMdoQ9jEVu8EGlNy1r58gT0Q3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf7fexllUtOBS8OIbJjLMok2Rz2gwM1nwlflOQSj2wIuHlkVG+NhrkAPP03GSMGk7XH62/9g0fv5LMukNPt5aKfTVtSKkRMrqByTFewnvissOQnp5yq/GSlCxfN17LdqYwMs9tq60HUM1oBbbb96r4wEb2FzcdbJ4uxKafT7Jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA4lum7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B8BC4CEEB;
	Fri, 15 Aug 2025 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755290855;
	bh=XsKgwwAW5ikpjk4PUGMdoQ9jEVu8EGlNy1r58gT0Q3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YA4lum7OPk+omERrvn2xPpmUqhCxeNqVeb4N4FSgQZqylFl5TvnIp2R21FmIs6CSF
	 0ChgFKqVNaNzPZZEr3+PWU4pgFtUnVswDhrllZ7tQoTZaNBE05KtcJlQZeGyZVKgNk
	 TNtRUZiBQxdKZB7oEL8FQdlQ/CyHvXv7a5BDah/BRck+Kua/gFkB9LBAdZPl5FxMFV
	 QeopkW2UGGWC01tJSm5pzHqZXZltL+GEyYKawwsvWb4oRHuBrjQx8T+vqD5oOD/Fbf
	 8fC8/D9wu7dQ8AE+CgMUMAiTPGreOoXVgHEoSwoBRjb2ENYlngIkzzbdCL4yI3jEhj
	 PO0FZ7Pr9wKqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity
Date: Fri, 15 Aug 2025 16:47:28 -0400
Message-ID: <20250815204731.220441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081556-disprove-clumsy-91a1@gregkh>
References: <2025081556-disprove-clumsy-91a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 36a9346c225270262d9f34e66c91aa1723fa903f ]

It is no longer necessary to preserve the NFS_INO_REVAL_PAGECACHE flag.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/inode.c    | 6 ++----
 fs/nfs/nfs4proc.c | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 3e3114a9d193..da8d727eb09d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -217,11 +217,12 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~NFS_INO_INVALID_OTHER;
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_INVALID_XATTR);
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
 		flags |= NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
 
+	flags &= ~NFS_INO_REVAL_PAGECACHE;
+
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (inode->i_mapping->nrpages == 0)
@@ -1900,7 +1901,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
 			| NFS_INO_REVAL_FORCED
-			| NFS_INO_REVAL_PAGECACHE
 			| NFS_INO_INVALID_BLOCKS);
 
 	/* Do atomic weak cache consistency updates */
@@ -1942,7 +1942,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_CHANGE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
@@ -1988,7 +1987,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 77cc1c4219e1..6d68c11ce411 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1213,7 +1213,6 @@ nfs4_update_changeattr_locked(struct inode *inode,
 		| cache_validity;
 
 	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(inode)) {
-		nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
 		if (S_ISDIR(inode->i_mode)) {
-- 
2.50.1


