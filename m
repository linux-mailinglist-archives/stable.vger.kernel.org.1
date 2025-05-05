Return-Path: <stable+bounces-140513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C369AAA983
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D503818905E7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3A35ABC0;
	Mon,  5 May 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfSL2NyX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC262299AB1;
	Mon,  5 May 2025 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485018; cv=none; b=MM+rD3P1Bko6eZi4a+DqlTFdyoc6c4S84kr8PQDm/uvywBlboWbxONLoDXsHwh7ZQULI7gPmymkKA6fp8tGhLJ4o6PPjI2agJVhp8f+E6VgTRM3ydssM5pTX5+jenmi0NXSnO/mQ2wsZvqit/9JDVI174C0mCqgrE6uPxchhFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485018; c=relaxed/simple;
	bh=pKZWDRkvVRBjTimgpV36FBBnP2eXPkS+7OxJHRyIvrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRFB2VJ0uKWdWLchQkRLMD10xKkocFEoYP8xZgbuejKfxalvW/6hlw8ReJlLqbhdAwLrZSef6CVtATuGog771q2LdS4AydfqpxfCsp6bzu+43GlPdCzchXV+TpuiyJ4nuK42IwyjCRGDxkBgmyBUNHbfF7sO9M5I1g3XQq/e6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfSL2NyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A40C4CEED;
	Mon,  5 May 2025 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485017;
	bh=pKZWDRkvVRBjTimgpV36FBBnP2eXPkS+7OxJHRyIvrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfSL2NyXXJJVsq5pbHKxuzPYk2rzviLVYChGswDI8qJguALSiF70fUFW7VOtAXRC7
	 kZhST4adGaslYqAL6CCr9mdYs2vmWqPtzJVqJv2nglWphQx19uPj6DeQQo29PCq4EU
	 hAmwCbMtXc0cnkrOqZnBs6E0u/ptcl9H5TGWpBT75+1dY5QA8qfWczqO/ZOO4eWbQ9
	 v0qLxG5tdc+F6ERw5BNBu/lfCFYN+B9Xn2kMe5poxb0I9PQumE0OVLSZQgkQJa68cb
	 2gSmrUTWxaQ1a50P1NzI8+PVL///DWT3Mgo1YDPi7bWNymr9H6jSGqgjXSowBeSl5S
	 9V7QpoNrMRJmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 125/486] f2fs: defer readonly check vs norecovery
Date: Mon,  5 May 2025 18:33:21 -0400
Message-Id: <20250505223922.2682012-125-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 9cca49875997a1a7e92800a828a62bacb0f577b9 ]

Defer the readonly-vs-norecovery check until after option parsing is done
so that option parsing does not require an active superblock for the test.
Add a helpful message, while we're at it.

(I think could be moved back into parsing after we switch to the new mount
API if desired, as the fs context will have RO state available.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 573cc4725e2e8..280debf2df4f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -728,10 +728,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			set_opt(sbi, DISABLE_ROLL_FORWARD);
 			break;
 		case Opt_norecovery:
-			/* this option mounts f2fs with ro */
+			/* requires ro mount, checked in f2fs_default_check */
 			set_opt(sbi, NORECOVERY);
-			if (!f2fs_readonly(sb))
-				return -EINVAL;
 			break;
 		case Opt_discard:
 			if (!f2fs_hw_support_discard(sbi)) {
@@ -1406,6 +1404,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
+
+	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
+		f2fs_err(sbi, "norecovery requires readonly mount");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.39.5


