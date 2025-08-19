Return-Path: <stable+bounces-171704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D72B2B5D8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC043526F59
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DE2110;
	Tue, 19 Aug 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJaQG8+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D919F121
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566405; cv=none; b=RlsTHddNw+ZxyIQuDjEdundi2E9+qa/fc0XlHZ3FF4YfDSTni2fdnHJiV3vBM6/4C39d9wZ+JkC8ncMGYrW8aM/DcVW6ftmQn0vHsZ3iCnUt2i5obm9iipYX1d5yLYPBltccY/PEz2LmPnZwupB/MU6GtpBmVg5zfIENi8MVAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566405; c=relaxed/simple;
	bh=O+Knz/MgMBsnGJVBiqoKGTzojYOTRKeeQu5e+ODfjDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2AeIEbV5YNJo5c3vj96HM3kQezOvw2AtdPPicwhURF3ZWEpZe6Zshvz1XYK9h3ybo65VAy1HtNEQ63NFUdnlxpvBeYbbhWRUdyTlUrnIS1/dNSwnGj14eyMKko/IJBUv2ImIT5at7n/3tdCfmPhX0bZKI8owotf/m9qacdqOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJaQG8+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EC3C116C6;
	Tue, 19 Aug 2025 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566404;
	bh=O+Knz/MgMBsnGJVBiqoKGTzojYOTRKeeQu5e+ODfjDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJaQG8+UZQ2eTaCp5I0dojCFadQqA+cgqfkQwxVGTjODgopmUqI8tQg4ku3Yyu2Am
	 aLd3M/YnO2jOAXLPLJ8/3jgjTJPEs7ndIN3wmlfWCtEJD8FgOC+kgGMAPnYOKImUW9
	 elPmq/MCpHpJjUuXi1dJ6AynubStBN0NUlA1d6WwEOrVgyM33XfRc0a8xoM3J2MPfg
	 Gzi4x2BHD830F6gKgy8smUAJAw1jpVobx2xD221+c1NapPkBRBUyOVbBxItpy8SGGx
	 9oIzdMtt5ZuAmT2KLMAAZczD1v0FMoUgKs7OcO4F7r6ZtzQgl/AAT5jOrTQXyWc5xi
	 58WI84y9b0AyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/5] xfs: improve the comments in xfs_select_zone_nowait
Date: Mon, 18 Aug 2025 21:19:57 -0400
Message-ID: <20250819011959.244870-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819011959.244870-1-sashal@kernel.org>
References: <2025081857-swerve-preschool-2c2c@gregkh>
 <20250819011959.244870-1-sashal@kernel.org>
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
index 01315ed75502..417895f8a24c 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -654,13 +654,6 @@ static inline bool xfs_zoned_pack_tight(struct xfs_inode *ip)
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
@@ -688,7 +681,8 @@ xfs_select_zone_nowait(
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


