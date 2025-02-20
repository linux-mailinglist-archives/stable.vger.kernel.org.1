Return-Path: <stable+bounces-118394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA1A3D378
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7DC7A2FAE
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EE01E9B36;
	Thu, 20 Feb 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="vObxMYH8"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87C1EA7EA;
	Thu, 20 Feb 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040882; cv=none; b=ifoEElAYp9FHgJoUf/TLzK3kqYpsc74pd5320bcEsHzZHvhvMkqLuCtJ+aYDYE2n6OqShbeTUbcxBlKJP2TCwWbmJNAr4G5Djj9m6/PlnoMpvXTht6R76UL1HRmyzQiND7drh4eYXwueks8bclov8rLV5M+WrImkE2lRzu3nzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040882; c=relaxed/simple;
	bh=+P/f3Pco0SV3HiLvIs4PGt/+Zb6gJaq5XpDW/83iFvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RH+CSa3gYXNgy8zgPb2PLQJ8kPy08ygDcocu/56r8Fud9V4Rg9TGe4f4k2oIIAy0FsqK++8le6G+fSzcKQvDa0h227e9hcbwVxh9TxBmCvaNJGwcD/j1XCGaaahAXtlwTBbVBSObH1hnY2vpfI1lC+87sMsuYvnS5kZNL9EiU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=vObxMYH8; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1740040368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e8y4xFmSdR7Yn+mCHwZfTZJE3tGNbtGvx49bSepz6m8=;
	b=vObxMYH8RhMNuj+KEcQVwBJRXX5K7yY9OPbJdvgVeVIWQ2OqH++iGHToYJ3fXvWb5xhx+C
	FR5txUKKEH7/2A2Lc2FgE2BNdGcsyyfebAFf/xNotZh65hydnfCvYTEQ+NvLqkaJevMmDW
	9L/mBWcmcUi4E0BZR3g0m00L7CL0XRA=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] f2fs: fix shift-out-of-bounds in parse_options()
Date: Thu, 20 Feb 2025 11:32:45 +0300
Message-ID: <20250220083248.5887-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this commit.

Using an arbitrary value that does not fall into the required range as an 
argument of the shift operator when outputting an error is wrong in itself.

Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3bf/0x420 lib/ubsan.c:321
 parse_options+0x4ad6/0x4ae0 fs/f2fs/super.c:919
 f2fs_fill_super+0x321b/0x7c40 fs/f2fs/super.c:4214
 mount_bdev+0x2c9/0x3f0 fs/super.c:1443
 legacy_get_tree+0xeb/0x180 fs/fs_context.c:632
 vfs_get_tree+0x88/0x270 fs/super.c:1573
 do_new_mount+0x2ba/0xb40 fs/namespace.c:3051
 do_mount fs/namespace.c:3394 [inline]
 __do_sys_mount fs/namespace.c:3602 [inline]
 __se_sys_mount+0x2d5/0x3c0 fs/namespace.c:3579
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3b/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x68/0xd2

There is a commit 87161a2b0aed ("f2fs: deprecate io_bits") that completely 
removes these strings, but it's not practical to backport it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Link: syzbot+410500002694f3ff65b1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=410500002694f3ff65b1
Fixes: ec91538dccd4 ("f2fs: get io size bit from mount option")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 72160b906f4b..7d7766761fe4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -916,8 +916,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_VECS)) {
-				f2fs_warn(sbi, "Not support %ld, larger than %d",
-					BIT(arg), BIO_MAX_VECS);
+				f2fs_warn(sbi, "Not support 2^%d, invalid argument %d",
+					arg, BIO_MAX_VECS);
 				return -EINVAL;
 			}
 			F2FS_OPTION(sbi).write_io_size_bits = arg;
-- 
2.43.0


