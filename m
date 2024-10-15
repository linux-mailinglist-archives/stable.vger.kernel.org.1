Return-Path: <stable+bounces-85895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449A99EAB6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DFAB22CC4
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BB1C07F5;
	Tue, 15 Oct 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJmbXEwY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A21C07C2;
	Tue, 15 Oct 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997061; cv=none; b=DVCs+4/fcuht6bFf+3CbhFPa5X7dZ6zYm2/GEacLAFWoBQkQsNUZ/SBAK4bQD2oGatDBroCBDmrfNZihYsHeuy9xvepvlXMjWb9lB8Ja5OcApCreU8xOC8sXcYT0P+Gg0miBhQd3VsZT18N1R7I7erl94Tmjp6UFfZCk/PVgKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997061; c=relaxed/simple;
	bh=yyJ+uASLC4zdws/2vZPBPaHS+ZQD6lOlXnQ8ZHv8xZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqMOjo+2TpjB36eGWj9kq/ENCe7kIBTJlv81f33d2dmpk0PflY2GOqav9opkzZhqlvnpzZEY55eMgQXtOGqzMfUOioGL8SDxPbjCngQJ98ZF29f3xRQwr2aSibIz8WGLTSAGagiIUABenfznZWW2bFVP9J1Zw2ibIKm+08B4AkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJmbXEwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DADC4CEC6;
	Tue, 15 Oct 2024 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997061;
	bh=yyJ+uASLC4zdws/2vZPBPaHS+ZQD6lOlXnQ8ZHv8xZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJmbXEwY/j6IdkA1ooDda3NNfr3QtCJ/Df+1M9rwjEL1bLPvKelPAvnrP6jMiXpZ2
	 q90ZhL4IwWJIOwzO55/3LvTs0nbj+S5B3Bn5W8ODXTaZjxO02qDWwS1jEizQNWa75H
	 Ukp7Y1CmQuYEPpyl4TRaqr96dloYaLYEXc7UFcP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/518] can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
Date: Tue, 15 Oct 2024 14:39:41 +0200
Message-ID: <20241015123919.973292518@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 94b0818fa63555a65f6ba107080659ea6bcca63e ]

syzbot reported a warning in bcm_release(). [0]

The blamed change fixed another warning that is triggered when
connect() is issued again for a socket whose connect()ed device has
been unregistered.

However, if the socket is just close()d without the 2nd connect(), the
remaining bo->bcm_proc_read triggers unnecessary remove_proc_entry()
in bcm_release().

Let's clear bo->bcm_proc_read after remove_proc_entry() in bcm_notify().

[0]
name '4986'
WARNING: CPU: 0 PID: 5234 at fs/proc/generic.c:711 remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
Modules linked in:
CPU: 0 UID: 0 PID: 5234 Comm: syz-executor606 Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
Code: ff eb 05 e8 cb 1e 5e ff 48 8b 5c 24 10 48 c7 c7 e0 f7 aa 8e e8 2a 38 8e 09 90 48 c7 c7 60 3a 1b 8c 48 89 de e8 da 42 20 ff 90 <0f> 0b 90 90 48 8b 44 24 18 48 c7 44 24 40 0e 36 e0 45 49 c7 04 07
RSP: 0018:ffffc9000345fa20 EFLAGS: 00010246
RAX: 2a2d0aee2eb64600 RBX: ffff888032f1f548 RCX: ffff888029431e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000345fb08 R08: ffffffff8155b2f2 R09: 1ffff1101710519a
R10: dffffc0000000000 R11: ffffed101710519b R12: ffff888011d38640
R13: 0000000000000004 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcfb52722f0 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bcm_release+0x250/0x880 net/can/bcm.c:1578
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfb51ee969
Code: Unable to access opcode bytes at 0x7fcfb51ee93f.
RSP: 002b:00007ffce0109ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcfb51ee969
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007fcfb526f3b0 R08: ffffffffffffffb8 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007fcfb526f3b0
R13: 0000000000000000 R14: 00007fcfb5271ee0 R15: 00007fcfb51bf160
 </TASK>

Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20240905012237.79683-1-kuniyu@amazon.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/bcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index b2b1bd6727871..cb849b5a8c14d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1424,8 +1424,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
 #if IS_ENABLED(CONFIG_PROC_FS)
-			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+				bo->bcm_proc_read = NULL;
+			}
 #endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
-- 
2.43.0




