Return-Path: <stable+bounces-162441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C2B05DF8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538D74A789C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8742E62B9;
	Tue, 15 Jul 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQDb9J8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FF192D8A;
	Tue, 15 Jul 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586563; cv=none; b=B4k+0wKp5Ohj7DFyqKZZlXJemdCcMQ4tp6sgVmxpcVoGWWI69yZtpoiRx2V0zZ42Q0igx0Dfd62sh1nOUUHyOib7pflOzvbAkJ7XIeHREndmNgdfAJpHCVQSxR7PBrjwMO6P9TuwCvdfqiXmIEWJV6PMu3Sr9YnZAlf5uvJmEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586563; c=relaxed/simple;
	bh=vVX496US6mp+y4AQEMP1cyBZSyFqo+dwbjTJNpDbDFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLYlMcOnknmZpj/ZGD/6xFucG9hkpmzcjQGCECqV17phwgk/3KWyc2c2IH7If2x3taFX61by9pKjDp17WUFNi1nlBwXwrRvhPFObLqlTVBrm+seK8a77/IF6WTinIqV15bNZvGpLU0D2mMSSxXFqjqD/8J/FtPT8gRZ8cEtn5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQDb9J8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2880C4CEE3;
	Tue, 15 Jul 2025 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586563;
	bh=vVX496US6mp+y4AQEMP1cyBZSyFqo+dwbjTJNpDbDFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQDb9J8bgdPNT1i512/QUdJc/BRcc1tvwVlVUeZLrxrwFOpwQqvl9YERtcVBR+HUN
	 5r8H8de3TCI8NCrvX5jOlYRJwKw3OleWzOmfQnd+Vgm8AiBV+S6jYx4SzIg3p2l1s9
	 +S1sYQ0j/o+Su0D1Jn09TiPP3tzTaEGmwBA8/H18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/148] atm: clip: Fix infinite recursive call of clip_push().
Date: Tue, 15 Jul 2025 15:13:55 +0200
Message-ID: <20250715130804.832794664@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 8415ac2805474..bf62d94554d9f 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -430,6 +430,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
-- 
2.39.5




