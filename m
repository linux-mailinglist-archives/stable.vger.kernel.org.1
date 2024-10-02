Return-Path: <stable+bounces-80074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE598DBAF
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711591C23C61
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAB1D0DF4;
	Wed,  2 Oct 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtAIdyOj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C821D0954;
	Wed,  2 Oct 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879308; cv=none; b=R94vFl8AJhOqSgFDJ/gB1e1bz1fPcIhX0bQnCYr65yBI/w7U/xtLZnnWDYwxyxJTM1qbouNK286E83xIAUFOQtag9um74C2l8mw8FTNKusWV+AG/Kjg1CLqgN8Vs9ZK1N8f9rPF9UxvhbRYErSn1Gefljvf/LdXrmoHPaHwRLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879308; c=relaxed/simple;
	bh=3vToIOs6AemgeCuxA3vtJFq3i4e7/fRhDGxbqKfC/rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDlU/gdEggTqZCsDKrW35WeJY/7s/VcwrkokLH73nX6QoRGvp/yZRmoaYVDrt37Nj9/yu49SRdV83Zj4KCxo0TAq7TPvH/M16YRzV1dE2B+TWH43Cr1nA4rMWMkVGDNKXs0H0kogmOLBqP6rJ+WdWnhYlc+Vt1RGvT7Kvkmtabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtAIdyOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA85C4CEC2;
	Wed,  2 Oct 2024 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879308;
	bh=3vToIOs6AemgeCuxA3vtJFq3i4e7/fRhDGxbqKfC/rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtAIdyOj029wDjiWsuOCZQGn8RlWqvkkLwiirbKH6oqtJyDL1rxju2XDlEwe/gdh/
	 JB3n0vyIog7GrS8k9Eis9XrhXlzRBcdIIMcNROZoxhQdsggEUlSoYI6Q1JAMVERHHr
	 PRQ1rYtxmOh2jtC0ylH30kiV2zT7Ce9YDD/SLImw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 075/538] ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
Date: Wed,  2 Oct 2024 14:55:14 +0200
Message-ID: <20241002125755.174893402@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 04ccecfa959d3b9ae7348780d8e379c6486176ac ]

Blamed commit accidentally removed a check for rt->rt6i_idev being NULL,
as spotted by syzbot:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 10998 Comm: syz-executor Not tainted 6.11.0-rc6-syzkaller-00208-g625403177711 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
 RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
 RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
 addrconf_notify+0x3cb/0x1020
  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
  call_netdevice_notifiers net/core/dev.c:2046 [inline]
  unregister_netdevice_many_notify+0xd81/0x1c40 net/core/dev.c:11352
  unregister_netdevice_many net/core/dev.c:11414 [inline]
  unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11289
  unregister_netdevice include/linux/netdevice.h:3129 [inline]
  __tun_detach+0x6b9/0x1600 drivers/net/tun.c:685
  tun_detach drivers/net/tun.c:701 [inline]
  tun_chr_close+0x108/0x1b0 drivers/net/tun.c:3510
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
RIP: 0033:0x7f1acc77def9
Code: Unable to access opcode bytes at 0x7f1acc77decf.
RSP: 002b:00007ffeb26fa738 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1acc77def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f1acc7dd508 R08: 00007ffeb26f84d7 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000003 R14: 00000000ffffffff R15: 00007ffeb26fa8e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
 RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
 RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: e332bc67cf5e ("ipv6: Don't call with rt6_uncached_list_flush_dev")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20240913083147.3095442-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0299886dbeb91..a9104c4c1c02d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -175,7 +175,7 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 			struct net_device *rt_dev = rt->dst.dev;
 			bool handled = false;
 
-			if (rt_idev->dev == dev) {
+			if (rt_idev && rt_idev->dev == dev) {
 				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
 				in6_dev_put(rt_idev);
 				handled = true;
-- 
2.43.0




