Return-Path: <stable+bounces-184154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C0BD207E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 154E04EDE32
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223BC2EB5C9;
	Mon, 13 Oct 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/ga0tEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36912D9EF9
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343852; cv=none; b=eujgKS0nb/P4RCnWFbeHYfQCpqFs0ymtFYeDk3ynLuovTLQBUtjT81f4O0gJmNDfI8nOmgGqSzUKMyRMt7Z6W1E6RC4T1tPv7N7mBb8YUwyQz8vyV835ml9Shp/kYum6a0uPnvnlCYzgVAt5P9ybe0VInL1jaFproDJFkhiTrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343852; c=relaxed/simple;
	bh=0+aPmQvP5U0qIRoAp1lv+oixENT1rYW2aSGSXxmh4iA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HDLHWj1R9taZOyUpNUj4m4HQdoiiN2pQUglfnex76gdFVJJGGIwtlrQfQx0VegBPoJg9NsfQLk+kXiHza/WbFoEDsEV87xvhJWramKjrRl4xzQ4gSgPpLxPvFU45vLH9i0oJ1WNoQAmvVBXB+XpGvBdbWf+JK8jZdn1lyvrsfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/ga0tEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB5CC4CEFE;
	Mon, 13 Oct 2025 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343852;
	bh=0+aPmQvP5U0qIRoAp1lv+oixENT1rYW2aSGSXxmh4iA=;
	h=Subject:To:Cc:From:Date:From;
	b=l/ga0tEwny/KbUdq0H+FhU3hS4I0YIia47FbyDKEQwOf4mYndZVPzOpTh/fqcgkg8
	 TiwIzlmF/3t5nF4ileG7F3umrgodPtAa1fckC2vjilTHOMM+VxtVB7yIX9KdNTJ3lG
	 Svo9QRGVS8JtyaugY1zi4wBugrZLz1Ug2dR4t6eY=
Subject: FAILED: patch "[PATCH] fs: udf: fix OOB read in lengthAllocDescs handling" failed to apply to 5.10-stable tree
To: Sergey.Larshin@kaspersky.com,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:24:09 +0200
Message-ID: <2025101309-prescribe-imprison-4896@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3bd5e45c2ce30e239d596becd5db720f7eb83c99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101309-prescribe-imprison-4896@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3bd5e45c2ce30e239d596becd5db720f7eb83c99 Mon Sep 17 00:00:00 2001
From: Larshin Sergey <Sergey.Larshin@kaspersky.com>
Date: Mon, 22 Sep 2025 16:13:58 +0300
Subject: [PATCH] fs: udf: fix OOB read in lengthAllocDescs handling

When parsing Allocation Extent Descriptor, lengthAllocDescs comes from
on-disk data and must be validated against the block size. Crafted or
corrupted images may set lengthAllocDescs so that the total descriptor
length (sizeof(allocExtDesc) + lengthAllocDescs) exceeds the buffer,
leading udf_update_tag() to call crc_itu_t() on out-of-bounds memory and
trigger a KASAN use-after-free read.

BUG: KASAN: use-after-free in crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
Read of size 1 at addr ffff888041e7d000 by task syz-executor317/5309

CPU: 0 UID: 0 PID: 5309 Comm: syz-executor317 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
 udf_update_tag+0x70/0x6a0 fs/udf/misc.c:261
 udf_write_aext+0x4d8/0x7b0 fs/udf/inode.c:2179
 extent_trunc+0x2f7/0x4a0 fs/udf/truncate.c:46
 udf_truncate_tail_extent+0x527/0x7e0 fs/udf/truncate.c:106
 udf_release_file+0xc1/0x120 fs/udf/file.c:185
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Validate the computed total length against epos->bh->b_size.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org

Signed-off-by: Larshin Sergey <Sergey.Larshin@kaspersky.com>
Link: https://patch.msgid.link/20250922131358.745579-1-Sergey.Larshin@kaspersky.com
Signed-off-by: Jan Kara <jack@suse.cz>

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index f24aa98e6869..a79d73f28aa7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2272,6 +2272,9 @@ int udf_current_aext(struct inode *inode, struct extent_position *epos,
 		if (check_add_overflow(sizeof(struct allocExtDesc),
 				le32_to_cpu(header->lengthAllocDescs), &alen))
 			return -1;
+
+		if (alen > epos->bh->b_size)
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {


