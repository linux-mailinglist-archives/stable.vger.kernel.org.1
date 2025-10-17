Return-Path: <stable+bounces-187501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D4BEA4D0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B501AE5A50
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BB330B2D;
	Fri, 17 Oct 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSuQES1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE5330B0C;
	Fri, 17 Oct 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716253; cv=none; b=YU+CR8p4h7rc4RUKJe0s/h7kwEvX5lHcgl65tr96RoDFrvH8Hwm5Cw8lUaF/ccfOqzl5H+uCLTyTJPYaN30rq+haI4/7XwE4TtaEmD+H8a4Z24KgqeODW8uBLCV2g+FD5g5jWHr/XLaRVqJNStVpVZrodPISvlWMp2h6E4DmYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716253; c=relaxed/simple;
	bh=81R5L6WD3deupGjV5E4/iOlw/VUk+GBaTmxDxWLnp80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCG1Ksbs/nd8ZQR/LNvIyI2beEGLfOfQ2UCSJPeUHHMAy4wbAaWEpfe4JEbBTzlE/qGeuNbKfv6skZCZl3z7hyPBpaFRo17hBK2ee1N5dL04WUjJsLfLcoSHYrbgshsdmSvngmYpDMaR6PTTApXLabcwv+eYp5P3UnCtUAKaHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSuQES1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850D2C4CEE7;
	Fri, 17 Oct 2025 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716252;
	bh=81R5L6WD3deupGjV5E4/iOlw/VUk+GBaTmxDxWLnp80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSuQES1NumGfvskK0cJaVnTHju20VUxnjY5Zlo7MNIPOczCy6TEGYi3hrLMQ/zCWb
	 LdQNw4tsWzpOjrx9nt2A5x77V2LjjCrNooINS4C+aWFJrQyaEaR6ol8MVLx4aXnXAF
	 4LGlK21cdmgoSOMFzqHfidszrLahf1RkrD/u9Nu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com,
	Larshin Sergey <Sergey.Larshin@kaspersky.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 109/276] fs: udf: fix OOB read in lengthAllocDescs handling
Date: Fri, 17 Oct 2025 16:53:22 +0200
Message-ID: <20251017145146.459286365@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larshin Sergey <Sergey.Larshin@kaspersky.com>

commit 3bd5e45c2ce30e239d596becd5db720f7eb83c99 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2109,6 +2109,9 @@ int8_t udf_current_aext(struct inode *in
 		if (check_add_overflow(sizeof(struct allocExtDesc),
 				le32_to_cpu(header->lengthAllocDescs), &alen))
 			return -1;
+
+		if (alen > epos->bh->b_size)
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {



