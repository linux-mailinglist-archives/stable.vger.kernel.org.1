Return-Path: <stable+bounces-90141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B490B9BE6E6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D5B2477A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C81DF266;
	Wed,  6 Nov 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/RLKBkV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DD1D2784;
	Wed,  6 Nov 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894894; cv=none; b=si9mxpT/ZdN7bI5Rk4RUnANP/jT7GoyLgXhenRGk+pjRjlm2Y/inlZqq+ZfZJtl5cJpSQKuxryI58NrN4FbcKLzKZx2oQURUbxK3HlcNhGmc868jhv2sLhTLGiXTDYz/T13LIA8XwLRAFmo0qb02MYzA0rhgtV5UFPTd5sZmvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894894; c=relaxed/simple;
	bh=skyEyyt8y6orTMTKKusm8KCmcxSc2a6BKdiAw9Wwbok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3McrTHWk8RVCTCJ376T+2vAN/IYJmv6GpsQVV0e2JRKZM1TpqPOxq8nF5f4rUuHpAFrn/5II5YnXeKXqutK9YHTlioyHBCrMoxxPSDBrcAP3KJtyz6B0jXGaW9M+KFN7iSyfNU9fHbyypHdi7FnuNyd0BvCdKbqX5JRmPTpJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/RLKBkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0A7C4CECD;
	Wed,  6 Nov 2024 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894894;
	bh=skyEyyt8y6orTMTKKusm8KCmcxSc2a6BKdiAw9Wwbok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/RLKBkVY/MPbxmEa99yXD9fAomCHi6++84hfxUDKg9FHsSUu1GVI6N/kqB8s5JGi
	 ENupNJhmqPea/VSNS3Ge4Jqc/Fj4Oii5sMVSZN0zp4I31nZkaA145oaN9XDmgwvpI+
	 yyc69PoI7M/pEwhwp9Np/2XmlNm/apPMwQHn9BF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/350] can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
Date: Wed,  6 Nov 2024 12:59:23 +0100
Message-ID: <20241106120321.749334454@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 095f68536c147..07c0634b32f73 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1423,8 +1423,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
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




