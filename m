Return-Path: <stable+bounces-106898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9AA02938
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72053A5578
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E33136E09;
	Mon,  6 Jan 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQFEFSBC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2786345;
	Mon,  6 Jan 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176841; cv=none; b=Z7bC75qA8++qEGMwXuoWjWpZb2PM2lNAuCuMfU88RKk6nlC1vfWg2Pe4xUu3mexgJnfMsOByr5xlZday6lBOUnurCAns+EsaovK+7T5Z2tdQjSkns/cpoOhrsogZOWh3TOKckkuz2JQZKEfw37+R5Zac1JSRhV9UJhQP9LMzhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176841; c=relaxed/simple;
	bh=5hVqgcYNlceCZhBj9k5BQ3sador5afMg51inNLztv+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmIvP9Nlq7mtt8q+odDTCa4S28xM2IYGgqsCJ86pYNd1BhQD88ALVkLZNBoKEE1bpqw9AztEJHCzmdlRXo8ACQACz6HsPqQNXwoJrUFCMpzG+HAvxY8b2w7JsLN3BNTV/Wqd2VLCvVmOviCnEjQI8dRJJ0w4v4jTuqOg2xxcd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQFEFSBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A8C4CED2;
	Mon,  6 Jan 2025 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176841;
	bh=5hVqgcYNlceCZhBj9k5BQ3sador5afMg51inNLztv+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQFEFSBCVzXRUg/nAmV4VaVjBp6TROTTHXxqhJksXjqWAmJYDaz9J6VQLVPRsr9gI
	 kbsJsgR9IS2iMYIi+NIqz4bna8H/on+URM++MpNKKd9iUILrnI9R4wsz64/sPk9Pww
	 VSWjaN+ZqB+e4wd7X4SbN2h/P+N73Vrho6veFVc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Chengen Du <chengen.du@canonical.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 48/81] af_packet: fix vlan_get_tci() vs MSG_PEEK
Date: Mon,  6 Jan 2025 16:16:20 +0100
Message-ID: <20250106151131.248144560@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 77ee7a6d16b6ec07b5c3ae2b6b60a24c1afbed09 ]

Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
by syzbot.

Rework vlan_get_tci() to not touch skb at all,
so that it can be used from many cpus on the same skb.

Add a const qualifier to skb argument.

[1]
skbuff: skb_under_panic: text:ffffffff8a8da482 len:32 put:14 head:ffff88807a1d5800 data:ffff88807a1d5810 tail:0x14 end:0x140 dev:<NULL>
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5880 Comm: syz-executor172 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 9e 6c 26 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 3a 5a 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90003baf5b8 EFLAGS: 00010286
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 8565c1eec37aa000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88802616fb50 R08: ffffffff817f0a4c R09: 1ffff92000775e50
R10: dffffc0000000000 R11: fffff52000775e51 R12: 0000000000000140
R13: ffff88807a1d5800 R14: ffff88807a1d5810 R15: 0000000000000014
FS:  00007fa03261f6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd65753000 CR3: 0000000031720000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  vlan_get_tci+0x272/0x550 net/packet/af_packet.c:565
  packet_recvmsg+0x13c9/0x1ef0 net/packet/af_packet.c:3616
  sock_recvmsg_nosec net/socket.c:1044 [inline]
  sock_recvmsg+0x22f/0x280 net/socket.c:1066
  ____sys_recvmsg+0x1c6/0x480 net/socket.c:2814
  ___sys_recvmsg net/socket.c:2856 [inline]
  do_recvmmsg+0x426/0xab0 net/socket.c:2951
  __sys_recvmmsg net/socket.c:3025 [inline]
  __do_sys_recvmmsg net/socket.c:3048 [inline]
  __se_sys_recvmmsg net/socket.c:3041 [inline]
  __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3041
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")
Reported-by: syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772c485.050a0220.2f3838.04c6.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chengen Du <chengen.du@canonical.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20241230161004.2681892-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 9da9e41899c6..224ac9a3482c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -541,10 +541,8 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
-static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *skb_orig_data = skb->data;
-	int skb_orig_len = skb->len;
 	struct vlan_hdr vhdr, *vh;
 	unsigned int header_len;
 
@@ -565,12 +563,8 @@ static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
 	else
 		return 0;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
-	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
-	if (skb_orig_data != skb->data) {
-		skb->data = skb_orig_data;
-		skb->len = skb_orig_len;
-	}
+	vh = skb_header_pointer(skb, skb_mac_offset(skb) + header_len,
+				sizeof(vhdr), &vhdr);
 	if (unlikely(!vh))
 		return 0;
 
-- 
2.39.5




