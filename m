Return-Path: <stable+bounces-203534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97127CE6AFC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D7B301463F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF3D30FC37;
	Mon, 29 Dec 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+DLJvBx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3493101A9
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011408; cv=none; b=r8EGQu2wiKA8/q5B4Yhfr9wo1HTcihIopwgb5S300VOpwrD9a04Pih42fzD5HJuH7kXuAB5iDmwFQEHXzy8EYrp5cs2mIcypY5L45Tt7quZUDIyyi25FQgnDjy2WcXNjyZpjohGG1jmXEEuN1aZwyDKdlpSUP9HtmdsYeqIsP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011408; c=relaxed/simple;
	bh=4mW3MyDpdQn56Zc/FaaEHfgmuPT1N46tKp9RYhheI9s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GsCIaG0u9RGPvw0XlzmxFztiiDatOzWDp/sD9JCxfdq5lz/zqf9qvBtPvT+W6YB7ZZIOPO2phBujXt3lPU/y7vSi+XFgJWfTp2pglSRd+0XngqJ+UOwHS914fNhRbBi/7UzHQc7ktdNY2wr2pwDS9VrkxVHvIkeHtrdzHtKdgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+DLJvBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0103C4CEF7;
	Mon, 29 Dec 2025 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767011408;
	bh=4mW3MyDpdQn56Zc/FaaEHfgmuPT1N46tKp9RYhheI9s=;
	h=Subject:To:Cc:From:Date:From;
	b=m+DLJvBxpW5pqF7S+74PAn+9TJb8M6GMygfFTrDo11q6vB6xylwAJtZso9BWqb2Jb
	 4qrCkB7FEQWT3w+HLInl0Jk/x7hL7CFwJn9LdRo6FuXjkLPsCP3NDZ3Frb4c/xdIh5
	 UjiL3z5aYGTzRxYqO4F/utBQGwAuGHysX8aQox+o=
Subject: FAILED: patch "[PATCH] ext4: fix string copying in parse_apply_sb_mount_options()" failed to apply to 6.1-stable tree
To: pchelkin@ispras.ru,jack@suse.cz,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 13:29:57 +0100
Message-ID: <2025122957-crevice-busily-7e0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ee5a977b4e771cc181f39d504426dbd31ed701cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122957-crevice-busily-7e0e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee5a977b4e771cc181f39d504426dbd31ed701cc Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Sat, 1 Nov 2025 19:04:28 +0300
Subject: [PATCH] ext4: fix string copying in parse_apply_sb_mount_options()

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

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7de15249e826..d1ba894c0e0a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2476,7 +2476,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char s_mount_opts[65];
+	char s_mount_opts[64];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2484,7 +2484,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
+	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
+		return -E2BIG;
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)


