Return-Path: <stable+bounces-162263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74421B05CCA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB5E7BE75D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E42E7BD1;
	Tue, 15 Jul 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fNaeeoc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09BD2E4244;
	Tue, 15 Jul 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586095; cv=none; b=SGRPo8Wx/93b8N17q0JWO7C6CASc6WfZj/6N/L+aPDTBWOAxQUnqXf8OP+CcrMk3zqwUNqfCdqOtgGtEIRNIMs+MkTxmHtXztSU473lNT7S4gvE8ACdBaGoeCkC8MS5P/xEBu/jhiJV+PwSWSQXyeoQPE0tvWRkkHv6IX+vrM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586095; c=relaxed/simple;
	bh=KjscxVlNtXh524Cqo22dVBKt9K0vKF/F719qPcqPcdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVQA3qX1KRuEmMfCnkF0DYPxUhzdH5in+2JH1xvxMNsMgDGt7I2oEM0wncGjG6KjRgT+n/jmJ4zAzcF8mttnA5EFjI+IAMb58Zg1IDhAIw2CV+cpAffANUm9Lrw7vxbrVaqb3nXBMmAJ7+Pd7DZMXwbPn7djTfBrZ7dJYDZBPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fNaeeoc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D070C4CEE3;
	Tue, 15 Jul 2025 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586094;
	bh=KjscxVlNtXh524Cqo22dVBKt9K0vKF/F719qPcqPcdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNaeeoc3dYtXEq/jKWHLZEVHjCZsome1tkpuAqhQoLE/nTDOCZWdSUJrwKXzxd6Mr
	 ui1fuEVDvAop2lEp+qA4RQGynqutgv8eE4dxzcjBWFy0x9A972LsprLJiR+2OM/Th8
	 gWt39W5w/uLGrPehdDb4IgI52QuYrMROfB9pY9gY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 14/77] atm: clip: Fix infinite recursive call of clip_push().
Date: Tue, 15 Jul 2025 15:13:13 +0200
Message-ID: <20250715130752.266091930@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130751.668489382@linuxfoundation.org>
References: <20250715130751.668489382@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c489f3283dbfc0f3c00c312149cae90d27552c45 ]

syzbot reported the splat below. [0]

This happens if we call ioctl(ATMARP_MKIP) more than once.

During the first call, clip_mkip() sets clip_push() to vcc->push(),
and the second call copies it to clip_vcc->old_push().

Later, when the socket is close()d, vcc_destroy_socket() passes
NULL skb to clip_push(), which calls clip_vcc->old_push(),
triggering the infinite recursion.

Let's prevent the second ioctl(ATMARP_MKIP) by checking
vcc->user_back, which is allocated by the first call as clip_vcc.

Note also that we use lock_sock() to prevent racy calls.

[0]:
BUG: TASK stack guard page was hit at ffffc9000d66fff8 (stack is ffffc9000d670000..ffffc9000d678000)
Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5322 Comm: syz.0.0 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:clip_push+0x5/0x720 net/atm/clip.c:191
Code: e0 8f aa 8c e8 1c ad 5b fa eb ae 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 20 48 89 f3 49 89 fd 48 bd 00
RSP: 0018:ffffc9000d670000 EFLAGS: 00010246
RAX: 1ffff1100235a4a5 RBX: ffff888011ad2508 RCX: ffff8880003c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888037f01000
RBP: dffffc0000000000 R08: ffffffff8fa104f7 R09: 1ffffffff1f4209e
R10: dffffc0000000000 R11: ffffffff8a99b300 R12: ffffffff8a99b300
R13: ffff888037f01000 R14: ffff888011ad2500 R15: ffff888037f01578
FS:  000055557ab6d500(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d66fff8 CR3: 0000000043172000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
...
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 clip_push+0x6dc/0x720 net/atm/clip.c:200
 vcc_destroy_socket net/atm/common.c:183 [inline]
 vcc_release+0x157/0x460 net/atm/common.c:205
 __sock_release net/socket.c:647 [inline]
 sock_close+0xc0/0x240 net/socket.c:1391
 __fput+0x449/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff31c98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb5aa1f78 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000012747 RCX: 00007ff31c98e929
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ff31cbb7ba0 R08: 0000000000000001 R09: 0000000db5aa226f
R10: 00007ff31c7ff030 R11: 0000000000000246 R12: 00007ff31cbb608c
R13: 00007ff31cbb6080 R14: ffffffffffffffff R15: 00007fffb5aa2090
 </TASK>
Modules linked in:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2371d94d248d126c1eb1
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250704062416.1613927-4-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/clip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index 14b485f725d0c..936b9558be4b9 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -429,6 +429,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
-- 
2.39.5




