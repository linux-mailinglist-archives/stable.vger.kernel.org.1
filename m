Return-Path: <stable+bounces-204247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1925CEA297
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B4530275F9
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D3320A0A;
	Tue, 30 Dec 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhlnWd1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CD248883
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111779; cv=none; b=negcr7xGxjHPiGTvtMZ1zvUKQ7l1+X9RAOF+Quil9llZWWLfuoxZh1KzdoXfnGwUasveO4z74f5q7MG8hbiwEBsH+xez9fmzixQRfqEhHAu47fsejLGDrmyMWDLcKJlK5snYF0zouOb02ym0E1Vkbis8QEoYpMG+iXzEQbdOiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111779; c=relaxed/simple;
	bh=ZG1yDZlsYYB+mugHd5kuVUikc7nQsJULWTiq3MA3NEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssv60lNvful6VwLRfCtNxgoirwh81afuiCgxglgBt63fzVOTdx3y+gICc/Yegu4U6ljtJ1tVnFU2xCD50rT66mUmK4yDE+dxeCegmMVAnkebHhL3FZyP9ow3KAkGTt+RF5n0Inq8T31hw0nXHn1E+HWqn6HZE0IhvvH3u9kc8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhlnWd1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796D5C116C6;
	Tue, 30 Dec 2025 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111778;
	bh=ZG1yDZlsYYB+mugHd5kuVUikc7nQsJULWTiq3MA3NEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhlnWd1ZIfZ4OFPHTBCpE1ORkz6cBpxNkgRPVeP05m5fqrN4sQPU1N6DAuVl3+/BT
	 BcrGRR4VEk22J2iecvFXB24YGDi9WmkxffiFrvLtZpleX5ngfI/FhTlpyVzCwmtiVu
	 V9SLYRZsX6KqOOz3J1CdypraRCd7/Or1DN7Phs2GNauwZOVsOJrrTdkV0EaWhRu2ww
	 oB9LC1BGxpvXbtfiG/S+MVZLM3qcH/b1dIT18jGTABtGWzTNgnWUcEHz6frLQxcxWM
	 nQdB824i5xyayipDB24ZN4C4HjMubowjCDvSFxxQq15Jx/4vZFpJ+vQw8nTXPssb2w
	 UPcT6MD1S/xjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] f2fs: dump more information for f2fs_{enable,disable}_checkpoint()
Date: Tue, 30 Dec 2025 11:22:53 -0500
Message-ID: <20251230162254.2306864-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230162254.2306864-1-sashal@kernel.org>
References: <2025122946-opponent-boozy-7af8@gregkh>
 <20251230162254.2306864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 80b6d1d2535a343e43d658777a46f1ebce8f3413 ]

Changes as below:
- print more logs for f2fs_{enable,disable}_checkpoint()
- account and dump time stats for f2fs_enable_checkpoint()

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: be112e7449a6 ("f2fs: fix to propagate error from f2fs_enable_checkpoint()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3f2aa031ef3b..04957c14b97c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2276,15 +2276,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 restore_flag:
 	sbi->gc_mode = gc_mode;
 	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
+	f2fs_info(sbi, "f2fs_disable_checkpoint() finish, err:%d", err);
 	return err;
 }
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
+	long long start, writeback, end;
+
+	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
+					get_pages(sbi, F2FS_DIRTY_META),
+					get_pages(sbi, F2FS_DIRTY_NODES),
+					get_pages(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_update_time(sbi, ENABLE_TIME);
 
+	start = ktime_get();
+
 	/* we should flush all the data to keep data consistency */
 	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
 		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
@@ -2293,6 +2302,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 		if (f2fs_time_over(sbi, ENABLE_TIME))
 			break;
 	}
+	writeback = ktime_get();
 
 	sync_inodes_sb(sbi->sb);
 
@@ -2311,6 +2321,12 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
+
+	end = ktime_get();
+
+	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
+					ktime_ms_delta(writeback, start),
+					ktime_ms_delta(end, writeback));
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
-- 
2.51.0


