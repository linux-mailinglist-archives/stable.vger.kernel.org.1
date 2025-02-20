Return-Path: <stable+bounces-118389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94860A3D34C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E19E3BCBBA
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B81E7C27;
	Thu, 20 Feb 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="fNn9OBnE"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF811BD517;
	Thu, 20 Feb 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040398; cv=none; b=IYaMW5hWl5x90ck4WQ4fdyUT3pVLEx+TWmA3qlKeihjlj2JQXd/5NyRPzIbi9Yl8nMAxxOqym/tBGFPqnoQLnFaYamUBk1wV5ZlV1YfjjSRMuu2Rx26y7lnJGgYR9FFcsvxiOukKkN7TzXM3kiMktYNTpKTUVNDIM2SY6byVIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040398; c=relaxed/simple;
	bh=X6xisC5gfqmvJ1du7q0Gw/uKjhSJESRDV6+PYdPM/+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cr0lj4pc83ybiWHakZLm25M3oRfmWGKJFCjOcsbnoIlbhbzUZ2I71+nqb6JwiolDNIJHEB8Ku8JN6gEVuK1Vmsjw2fk++TaOIgnZ+TSpt6vfj+CnpGSfk6CzdSPoLJUKuJYQMAdpBIK3g3jKY3UREMFcSkZvFGpok4l2WiwNsXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=fNn9OBnE; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1740040393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d8GxD/nSg4QuXrGtxNLMlKR9bIHa3KWtotKGTok0/mA=;
	b=fNn9OBnEuMjVle3FsNoiA6nIPNk86bfhvQN8qzyIvyFOo8+lGKt2OkCMvJTWvSSrNm6RNl
	0A2sz9j3MfbNH81CuWl+HMKCsI0AwkNnqy4QHKovG/Cw5MOAm7kVjZ01UFoHtqnQyR8FPU
	hl6UlfwQIWGUK15bP8K/FM2KbaaW9ao=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] f2fs: fix shift-out-of-bounds in parse_options()
Date: Thu, 20 Feb 2025 11:33:11 +0300
Message-ID: <20250220083313.5918-1-arefev@swemel.ru>
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
index 9afbb51bd678..5fd64bc35f31 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -722,8 +722,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
-				f2fs_warn(sbi, "Not support %d, larger than %d",
-					  1 << arg, BIO_MAX_PAGES);
+				f2fs_warn(sbi, "Not support 2^%d, invalid argument %d",
+					arg, BIO_MAX_PAGES);
 				return -EINVAL;
 			}
 			F2FS_OPTION(sbi).write_io_size_bits = arg;
-- 
2.43.0


