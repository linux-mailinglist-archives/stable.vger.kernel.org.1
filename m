Return-Path: <stable+bounces-139903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A42AAA202
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F09A1882D97
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E332D3F89;
	Mon,  5 May 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsXCqT2P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60E27FD54;
	Mon,  5 May 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483643; cv=none; b=X92Uj1Q9EQVFAeUFL7gD3XU73ddRsfbVRHtEmQ4PiYetGy9kV1UXUcxRHy7rHx642wdUa0i3QqWqy6IHWs2St5b4t/nyZHYp+Pu7kYEYZT1P2pbbEbMl72s/lEJziCCkrHm5hHaNiKfv3QLenNbjnXgRz+h0BT0wY4FZJvRcPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483643; c=relaxed/simple;
	bh=NRSQ/yrP1aoPk+wgBoKMeHyK9ZjvBs7hqvi2I5KYFRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qebjWXBwX9iZLZng4q+bmE3K9ESj2Em9FHrhuJuzqWHbEqLxmUCzeOYFoAHJi0r0c4CtCr8165WLH7+7z/dFXKcvyYtxPFaiSzt1mfZCQZRmWxxGYc6djQEdFNgl125qHBvhCmLmP6I2L4qBT+G785+ZjYN3ND928YKrXBJRG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsXCqT2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD384C4CEED;
	Mon,  5 May 2025 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483643;
	bh=NRSQ/yrP1aoPk+wgBoKMeHyK9ZjvBs7hqvi2I5KYFRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsXCqT2PA7StRDKMGYBHIpqwACXr3iYlcBKvWJ48kA1WP0ZUbNfkkngsko69lqigS
	 Yyw0ghgPncukC/yriHZ3rnzZ7zKYUi0rE9+ciX7QxOv3X5F7kv+Yivp12Up6MRRT6i
	 JSiErQ30CpNJgxpu/HrKdFfMZBvhep87m24wVTNUCqe6xIVBnKSN3QDAbjwo6/JkFy
	 6pQ3Q3ESMwBPzd8+mMn7lTJ+ZqAiLRMA/o/B3/L6EYjq3Zfoov6KJBdi6ELZprS9kx
	 sgyd9uvJlbkDcdkg/6CYhgWoUIeUV3aAncUrRhl03iDBOOuwFj3/xZcXetvtc0P2zL
	 Qzd81OT2IuTdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.14 156/642] f2fs: defer readonly check vs norecovery
Date: Mon,  5 May 2025 18:06:12 -0400
Message-Id: <20250505221419.2672473-156-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index b8a0e925a4011..d3b04a589b525 100644
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
@@ -1418,6 +1416,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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


