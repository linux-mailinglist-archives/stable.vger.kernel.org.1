Return-Path: <stable+bounces-102302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF659EF28E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E440D189EBE2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5B23A1BF;
	Thu, 12 Dec 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+2yaol3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9922968B;
	Thu, 12 Dec 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020733; cv=none; b=HIgKikIP3XbPmI5uP8iowWP7Z2jT3XccLOCchavYqsyN8inhXQ3ZyqvGB8B0KzOW29q/0PZuI8KllwCEhTvbAlgtH8/wifIJaCIbQsZS7ymAGIjFJ26KTwHlXxfS6nRvm/5ac/sHQtzVbTqwYhK4c0kB2cMzMEWrLUk8/LRBz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020733; c=relaxed/simple;
	bh=jX4Q4d8Aig2T/I4PNkjA7/77aa4+DocUqqJfqTGA+gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+dyyDMTY7n6meQJym192omg9D3seexHPkWKSkSEL+UO5finsKSSA+5FPvggWm4Yc+wuWCnobD8tl/lZXckUVQHzXmIyJ/XJImRZIHCFx7BxBrsZxkhMkpcQQY7/1OmyVnV1vQcNd2oBXScgSmnzj0jAAlHPxiV5Qz2M1kLfudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+2yaol3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17DBC4CEF6;
	Thu, 12 Dec 2024 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020733;
	bh=jX4Q4d8Aig2T/I4PNkjA7/77aa4+DocUqqJfqTGA+gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+2yaol3h5S8jy0gzwoM3rfFJE0+adfpfddhzIdibXL052Us07zuKhgOf2NyhTtVF
	 1oZ7ACHnswAHfldRIyiGzwEFibFYC8eS0RXtkwtEmdJ/6LJmDWwChn5u2Bijl3nhYI
	 eoL+g3VawZbrBEY3olczd1Qk4TCIKFHYDozTAS98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 545/772] geneve: do not assume mac header is set in geneve_xmit_skb()
Date: Thu, 12 Dec 2024 15:58:10 +0100
Message-ID: <20241212144412.489139663@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8588c99c7d47448fcae39e3227d6e2bb97aad86d ]

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue.

sysbot reported the following :

 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 skb_mac_header include/linux/skbuff.h:3052 [inline]
 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 eth_hdr include/linux/if_ether.h:24 [inline]
 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit_skb drivers/net/geneve.c:898 [inline]
 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
Modules linked in:
CPU: 0 UID: 0 PID: 11635 Comm: syz.4.1423 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_mac_header include/linux/skbuff.h:3052 [inline]
 RIP: 0010:eth_hdr include/linux/if_ether.h:24 [inline]
 RIP: 0010:geneve_xmit_skb drivers/net/geneve.c:898 [inline]
 RIP: 0010:geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
Code: 21 c6 02 e9 35 d4 ff ff e8 a5 48 4c fb 90 0f 0b 90 e9 fd f5 ff ff e8 97 48 4c fb 90 0f 0b 90 e9 d8 f5 ff ff e8 89 48 4c fb 90 <0f> 0b 90 e9 41 e4 ff ff e8 7b 48 4c fb 90 0f 0b 90 e9 cd e7 ff ff
RSP: 0018:ffffc90003b2f870 EFLAGS: 00010283
RAX: 000000000000037a RBX: 000000000000ffff RCX: ffffc9000dc3d000
RDX: 0000000000080000 RSI: ffffffff86428417 RDI: 0000000000000003
RBP: ffffc90003b2f9f0 R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000002 R12: ffff88806603c000
R13: 0000000000000000 R14: ffff8880685b2780 R15: 0000000000000e23
FS:  00007fdc2deed6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a1dff8 CR3: 0000000056b8c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
  netdev_start_xmit include/linux/netdevice.h:5011 [inline]
  __dev_direct_xmit+0x58a/0x720 net/core/dev.c:4490
  dev_direct_xmit include/linux/netdevice.h:3181 [inline]
  packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
  packet_snd net/packet/af_packet.c:3146 [inline]
  packet_sendmsg+0x2700/0x5660 net/packet/af_packet.c:3178
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg net/socket.c:726 [inline]
  __sys_sendto+0x488/0x4f0 net/socket.c:2197
  __do_sys_sendto net/socket.c:2204 [inline]
  __se_sys_sendto net/socket.c:2200 [inline]
  __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
Reported-by: syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/674f4b72.050a0220.17bd51.004a.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Link: https://patch.msgid.link/20241203182122.2725517-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c4a49a75250e3..27b570678c9fc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -990,7 +990,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		if (geneve->cfg.df == GENEVE_DF_SET) {
 			df = htons(IP_DF);
 		} else if (geneve->cfg.df == GENEVE_DF_INHERIT) {
-			struct ethhdr *eth = eth_hdr(skb);
+			struct ethhdr *eth = skb_eth_hdr(skb);
 
 			if (ntohs(eth->h_proto) == ETH_P_IPV6) {
 				df = htons(IP_DF);
-- 
2.43.0




