Return-Path: <stable+bounces-171710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56FB2B647
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917C4527760
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295E1F3D58;
	Tue, 19 Aug 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a50p/OLa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F61F2BAB
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567279; cv=none; b=PxRf0yaxF3qu/z1O/6OM2k3v/ApOXXxUm/mDqAnFl17uq35ScYjwsuZIJ+vgbLl/iyIhUmpDijg34b2u0oclHAmwdIY4KNghHm2NyfK4+rBmQyVSOfppQfsS5+ybF3gp5H45os5ACu9YIF/sEomBA2VDC4diM8FH8oQ1x7CKzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567279; c=relaxed/simple;
	bh=kzjNlH+JEVoIUspt3y+GweTwre6W7vuYLDFKu47uhNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZcLz3pkad+fAL9zXVmHzqlb2DI7pNu7DVg3MsKzHjDjqJPtrewRmvhe+7vyI3WOk3GPN4yrIR2uHQGrZL7ixNdq120y/mWcIMLKBXIhk/ck+dfEiFhZTtpuoUngyF6kRG0EbYflKRdupQd84RnB3s1YCRaN4BMrlDOp6CHxwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a50p/OLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD56C116D0;
	Tue, 19 Aug 2025 01:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567279;
	bh=kzjNlH+JEVoIUspt3y+GweTwre6W7vuYLDFKu47uhNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a50p/OLaeA7ZKCb/BTxiOlfxr9HaOPhG4CP0GBehUXJwR3tZlZjd3fkn1muhN8ylJ
	 jgQugrG7WmdjrE8a0YJhkq26nfd9ucO3I1fThOCJ1bQiDGj8mA6N01nB9inttZCFbi
	 nNUCJShtpgmapTrqMxdplJ/KuLrBZbuk+1YiooqkoIlIq0pwn1+kGf0gt38u/CrIf4
	 2wfTXPZvz3oGKv4zDVLFjjNfPfqG5xGrxFnpwyN7sRKnJP22P3+MQAiEOrBojPptIw
	 ao8NF3Jryrl9SUWau4FkfB5pI+yUAgvWDApsYu/cNAj/ghCkPf6Khn/MveZrEbbnso
	 TOECymn5masZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 3/5] xfs: improve the comments in xfs_select_zone_nowait
Date: Mon, 18 Aug 2025 21:34:32 -0400
Message-ID: <20250819013434.249383-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819013434.249383-1-sashal@kernel.org>
References: <2025081857-glitter-hummus-4836@gregkh>
 <20250819013434.249383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 60e02f956d77af31b85ed4e73abf85d5f12d0a98 ]

The top of the function comment is outdated, and the parts still correct
duplicate information in comment inside the function.  Remove the top of
the function comment and instead improve a comment inside the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: d2845519b072 ("xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_zone_alloc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index d509e49b2aaa..e4db7f85f3c7 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -653,13 +653,6 @@ static inline bool xfs_zoned_pack_tight(struct xfs_inode *ip)
 		!(ip->i_diflags & XFS_DIFLAG_APPEND);
 }
 
-/*
- * Pick a new zone for writes.
- *
- * If we aren't using up our budget of open zones just open a new one from the
- * freelist.  Else try to find one that matches the expected data lifetime.  If
- * we don't find one that is good pick any zone that is available.
- */
 static struct xfs_open_zone *
 xfs_select_zone_nowait(
 	struct xfs_mount	*mp,
@@ -687,7 +680,8 @@ xfs_select_zone_nowait(
 		goto out_unlock;
 
 	/*
-	 * See if we can open a new zone and use that.
+	 * See if we can open a new zone and use that so that data for different
+	 * files is mixed as little as possible.
 	 */
 	oz = xfs_try_open_zone(mp, write_hint);
 	if (oz)
-- 
2.50.1


