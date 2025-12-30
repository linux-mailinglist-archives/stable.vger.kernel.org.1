Return-Path: <stable+bounces-204161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084ECE8756
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E677D300EE40
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49C157A5A;
	Tue, 30 Dec 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdliz15r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C083A14
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056463; cv=none; b=cqQIHvgVlSc2iycssSTUFxbAEPioSANDkiNpDkt29zJdWuBgoT2Rh5ZnlrfDekHmdD9k0s5Yd+X5anSFM1fl37feWQUkD3OkPKt/UBehnD7BWPQMLHvjG/1fB1Vwf+vYhMt1vYkOyK3X9Iah2C+zJLLe2ZwLTbbYA2/Tgg9DxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056463; c=relaxed/simple;
	bh=qllGSfld8fYKulBVJZLAqjJHFTVl3BLJDMxzkT2X/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7dLFdx3U9N7v4BII8l6BqN/qZ13DIfYJcNLPyhJS0zLRSdD3t+fBxPTxzqOtA1b/WN+kRBW7XzP7vm+ZU3KF6kV+UKsZ1cIRgIP2crxXmV9YGTO60OA5NW4ZJHhx9F+BpDU5qJcRwK7KRHYqF/NxecX7UHeeErSWjmb5N1Jnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdliz15r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA34C4CEF7;
	Tue, 30 Dec 2025 01:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767056462;
	bh=qllGSfld8fYKulBVJZLAqjJHFTVl3BLJDMxzkT2X/SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdliz15rPT+Fed2fEFJScMSkftEcaKnzv7ZTMxezhTEZRs2+f5bsBtVHgH2uxbUb3
	 jLKhXecEZExcTEsxRRby0F6jj2ue117uAzAVl6rfQtcMk2qymdkbUCjJj2Na8G3pRj
	 kcM8E15TorQr/aWsHxb5COaYgP7PUYId20oVizHhmLkNnBQ9yva9DWS1CqlIoAZs8d
	 iFY43SQbptkwbnhYFdDvdhwHNiStgzjqxVrQfG6vp7k5NUtuvfe3UXOFF81wWw+9Bz
	 xl+FJpPrUWz66So+EOVUs3rFe2CEpT18lmGy4Ap8s+pCAe4w7JnREDHvo3xdr3Bt4m
	 +VM29D+UvaZeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: fix string copying in parse_apply_sb_mount_options()
Date: Mon, 29 Dec 2025 20:00:59 -0500
Message-ID: <20251230010059.1899363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122957-crevice-busily-7e0e@gregkh>
References: <2025122957-crevice-busily-7e0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit ee5a977b4e771cc181f39d504426dbd31ed701cc ]

strscpy_pad() can't be used to copy a non-NUL-term string into a NUL-term
string of possibly bigger size.  Commit 0efc5990bca5 ("string.h: Introduce
memtostr() and memtostr_pad()") provides additional information in that
regard.  So if this happens, the following warning is observed:

strnlen: detected buffer overflow: 65 byte read of buffer size 64
WARNING: CPU: 0 PID: 28655 at lib/string_helpers.c:1032 __fortify_report+0x96/0xc0 lib/string_helpers.c:1032
Modules linked in:
CPU: 0 UID: 0 PID: 28655 Comm: syz-executor.3 Not tainted 6.12.54-syzkaller-00144-g5f0270f1ba00 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__fortify_report+0x96/0xc0 lib/string_helpers.c:1032
Call Trace:
 <TASK>
 __fortify_panic+0x1f/0x30 lib/string_helpers.c:1039
 strnlen include/linux/fortify-string.h:235 [inline]
 sized_strscpy include/linux/fortify-string.h:309 [inline]
 parse_apply_sb_mount_options fs/ext4/super.c:2504 [inline]
 __ext4_fill_super fs/ext4/super.c:5261 [inline]
 ext4_fill_super+0x3c35/0xad00 fs/ext4/super.c:5706
 get_tree_bdev_flags+0x387/0x620 fs/super.c:1636
 vfs_get_tree+0x93/0x380 fs/super.c:1814
 do_new_mount fs/namespace.c:3553 [inline]
 path_mount+0x6ae/0x1f70 fs/namespace.c:3880
 do_mount fs/namespace.c:3893 [inline]
 __do_sys_mount fs/namespace.c:4103 [inline]
 __se_sys_mount fs/namespace.c:4080 [inline]
 __x64_sys_mount+0x280/0x300 fs/namespace.c:4080
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Since userspace is expected to provide s_mount_opts field to be at most 63
characters long with the ending byte being NUL-term, use a 64-byte buffer
which matches the size of s_mount_opts, so that strscpy_pad() does its job
properly.  Return with error if the user still managed to provide a
non-NUL-term string here.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Message-ID: <20251101160430.222297-1-pchelkin@ispras.ru>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ adapted 2-argument strscpy_pad() call to 3-argument form with explicit sizeof() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b563c2e59227..77ac2f32f400 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2415,7 +2415,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char s_mount_opts[65];
+	char s_mount_opts[64];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2423,7 +2423,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts, sizeof(s_mount_opts));
+	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts, sizeof(s_mount_opts)) < 0)
+		return -E2BIG;
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-- 
2.51.0


