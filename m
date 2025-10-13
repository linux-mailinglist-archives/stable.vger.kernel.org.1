Return-Path: <stable+bounces-185519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1ABD6662
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631424065DF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0982EFD88;
	Mon, 13 Oct 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="conTmLY3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08292F0671
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391905; cv=none; b=kB71Ua+O2e0c5p4kRGD2cGS2qGZZiyYolXQr0fV5L6NG+Zstb0KNxBR+NLnAx/NKiVUevZ6/9pcBbv91cTA1+Kx+MZUKLDkpXVcdVzc6l73hhzDu5KVFM8RI08Ry0lQz8OF+rqW+Mg17HeOYlo03V2QmhhiMNjwOoWvq+8TIpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391905; c=relaxed/simple;
	bh=CPQTmLIkTvZeTlHSFr+x5ZghiwFQCG/vL72WJWpb+PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUUpQ4FFTFdlwbcV6VWIFN3nXHGUmueG6IOLlnqNP1NvREBF/OuQis4q6Vyu5wUV0jqKkh6a5/xvBZumwUM/bM29PIvUDGxr94MCdXEijROVcv6uXB1bQ/2gXtsAq1cZQonFlA9Hg4krnwGaPm8pwb4DQ6sO6yQ6cA+yngc6Nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=conTmLY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D72CC4CEE7;
	Mon, 13 Oct 2025 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391904;
	bh=CPQTmLIkTvZeTlHSFr+x5ZghiwFQCG/vL72WJWpb+PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=conTmLY3hc1zzcvzzCUnMHTEZ3mY1TZUAu+DDixyRsRbTtVbAher7oUUA6pZ/0mY5
	 zyfIZ+EsnQfQDOrpTT64jRbotnRv99pSuUghMOto2TqfmWwlxucv9++kjWL01SdrNG
	 MxgmeTLZ7lCv9lQKE8kc8u4TYWTcUDqBcCX8RtMbk/LD7tN5IjmB6wI/6tlkaVVC7M
	 rIRU2Hft+N+GTL8Ln/gn5rCkoVNtgFxdTOlW0U2vpV6K3HPTGQmTv4FtuQGxySVZDi
	 duY7NNMF38jMEbOKGY1Z8CNu2tnyDfMcMltNwwnO874wmT9cSAwVbeUAUM5TZhtGj7
	 dYSe6A1Y7fxhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Larshin Sergey <Sergey.Larshin@kaspersky.com>,
	syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] fs: udf: fix OOB read in lengthAllocDescs handling
Date: Mon, 13 Oct 2025 17:45:00 -0400
Message-ID: <20251013214501.3637100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101311-karate-spur-a795@gregkh>
References: <2025101311-karate-spur-a795@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larshin Sergey <Sergey.Larshin@kaspersky.com>

[ Upstream commit 3bd5e45c2ce30e239d596becd5db720f7eb83c99 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7d878e36759b2..e3fa86bb8021e 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2202,6 +2202,9 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 		if (check_add_overflow(sizeof(struct allocExtDesc),
 				le32_to_cpu(header->lengthAllocDescs), &alen))
 			return -1;
+
+		if (alen > epos->bh->b_size)
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
-- 
2.51.0


