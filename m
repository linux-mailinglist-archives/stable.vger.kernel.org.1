Return-Path: <stable+bounces-104573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F629F51E4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D68188D1EB
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A71F75BC;
	Tue, 17 Dec 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjq2cza8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807A1F755F;
	Tue, 17 Dec 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455462; cv=none; b=cEocP6nYSeZU821a1XxbvIizJOqvbNfxI2cLh/rjQtSc+0r1yI2FsySAnywTmP1dRYQB+akeXbJflKSRugOE66buBq3OrlHZ1C8+x0SbB1/CCVqOwgTlKK63HKiBEiSsy9foCDjvtDsGMtpOc1AoBSiczlXCGkb1S+z7CLTUSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455462; c=relaxed/simple;
	bh=6SiCvu6jaJThQIw2xXnP/UdvcU8lWBvY+oy32eVvRSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orWpTFrhJFrgiA4siQ3KysyCnhILaT3hTaBHFcxHKwLaZVo+RvpjOlSa4QwZnVvKmiDCxj/cy+lyNGDmZVBKspa6TrRy5tRurR848NhYsnykZnyYTII/qohY+Usf0waSkHMMDr1nr1tm08L6SNAIbXH72iGHoEuV7EcH7hQNb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjq2cza8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E262C4CED3;
	Tue, 17 Dec 2024 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455462;
	bh=6SiCvu6jaJThQIw2xXnP/UdvcU8lWBvY+oy32eVvRSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjq2cza80v37g1bidhALKrW6B9dSGr/WH2KL5fpNmeJVBSmxSka1thHDFeCkT/R/l
	 94HB0E8My0ft9nyPGIBngnGCA+vSUWSWGQFy3PU0GEdi92ZG8L/VNTornaMejbfrnH
	 gBJ32EDF1P0/Mgg2YOJPPs4XJmlOX6tSyPc+NVzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+fb99d1b0c0f81d94a5e2@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 19/43] net: lapb: increase LAPB_HEADER_LEN
Date: Tue, 17 Dec 2024 18:07:10 +0100
Message-ID: <20241217170521.232315843@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
References: <20241217170520.459491270@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a6d75ecee2bf828ac6a1b52724aba0a977e4eaf4 ]

It is unclear if net/lapb code is supposed to be ready for 8021q.

We can at least avoid crashes like the following :

skbuff: skb_under_panic: text:ffffffff8aabe1f6 len:24 put:20 head:ffff88802824a400 data:ffff88802824a3fe tail:0x16 end:0x140 dev:nr0.2
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5508 Comm: dhcpcd Not tainted 6.12.0-rc7-syzkaller-00144-g66418447d27b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0d 8d 48 c7 c6 2e 9e 29 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 1a 6f 37 02 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90002ddf638 EFLAGS: 00010282
RAX: 0000000000000086 RBX: dffffc0000000000 RCX: 7a24750e538ff600
RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000000
RBP: ffff888034a86650 R08: ffffffff8174b13c R09: 1ffff920005bbe60
R10: dffffc0000000000 R11: fffff520005bbe61 R12: 0000000000000140
R13: ffff88802824a400 R14: ffff88802824a3fe R15: 0000000000000016
FS:  00007f2a5990d740(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2631fd CR3: 0000000029504000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  nr_header+0x36/0x320 net/netrom/nr_dev.c:69
  dev_hard_header include/linux/netdevice.h:3148 [inline]
  vlan_dev_hard_header+0x359/0x480 net/8021q/vlan_dev.c:83
  dev_hard_header include/linux/netdevice.h:3148 [inline]
  lapbeth_data_transmit+0x1f6/0x2a0 drivers/net/wan/lapbether.c:257
  lapb_data_transmit+0x91/0xb0 net/lapb/lapb_iface.c:447
  lapb_transmit_buffer+0x168/0x1f0 net/lapb/lapb_out.c:149
 lapb_establish_data_link+0x84/0xd0
 lapb_device_event+0x4e0/0x670
  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 __dev_notify_flags+0x207/0x400
  dev_change_flags+0xf0/0x1a0 net/core/dev.c:8922
  devinet_ioctl+0xa4e/0x1aa0 net/ipv4/devinet.c:1188
  inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1003
  sock_do_ioctl+0x158/0x460 net/socket.c:1227
  sock_ioctl+0x626/0x8e0 net/socket.c:1346
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+fb99d1b0c0f81d94a5e2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67506220.050a0220.17bd51.006c.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241204141031.4030267-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/lapb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/lapb.h b/include/net/lapb.h
index ccc3d1f020b0..c4417a631013 100644
--- a/include/net/lapb.h
+++ b/include/net/lapb.h
@@ -4,7 +4,7 @@
 #include <linux/lapb.h>
 #include <linux/refcount.h>
 
-#define	LAPB_HEADER_LEN	20		/* LAPB over Ethernet + a bit more */
+#define	LAPB_HEADER_LEN MAX_HEADER		/* LAPB over Ethernet + a bit more */
 
 #define	LAPB_ACK_PENDING_CONDITION	0x01
 #define	LAPB_REJECT_CONDITION		0x02
-- 
2.39.5




