Return-Path: <stable+bounces-106900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27CA0293A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B3818865B1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCE70813;
	Mon,  6 Jan 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSSidn2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7B4D8C8;
	Mon,  6 Jan 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176848; cv=none; b=JPbv7SeE1P8bicAvdfKb7PrZVGEnumeuSpwC85s4qcC5Znlga0xXPiPO6rvKY93aU9fAe7AWHiskb52a0vOMOy/UHuwbTgYWeeOJI1jqrGGgtMC0CZyri2li1VAz2TKDmoauFj4/IIeQIpyNiZvB9nC+4zQS1LIsSNQZptDaQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176848; c=relaxed/simple;
	bh=1T5CyOFyEHxSEXll727Bp15ZZ8Fef/Xhu+gHkcpJFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXRtoJpK94Logjnj+o51BlxaEAc0kcUhIYTjZpM9m6b38ByCVGJylubA6ET6zq7kvrqaYYw+y6B+rllDtaNb2YXKXWQQCoEgqQCfQr/Hc1vbbMtyDjXHQ2yALguEwp9D+hSZhXYIuGDXkQBkYvJtdj2BGhGxJDH75IZak0L2V7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSSidn2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C07C4CED6;
	Mon,  6 Jan 2025 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176847;
	bh=1T5CyOFyEHxSEXll727Bp15ZZ8Fef/Xhu+gHkcpJFYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSSidn2Ac9G0y3M4TvQweswCJudY79zje28/mhgPwKFC/wAYXpyrf9+sAt74h1+QV
	 Ih/vnlj5wm/mRuxdRVIWk0B2vU57C0ggdb4RdFsyj/BwRXBnflL/mGDEabh0FgN/xS
	 MXn1RtT8qNM9fUH+2NlZFSKIt7KKNReWDE4SCdKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Chengen Du <chengen.du@canonical.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 49/81] af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
Date: Mon,  6 Jan 2025 16:16:21 +0100
Message-ID: <20250106151131.285532304@linuxfoundation.org>
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

[ Upstream commit f91a5b8089389eb408501af2762f168c3aaa7b79 ]

Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
by syzbot.

Rework vlan_get_protocol_dgram() to not touch skb at all,
so that it can be used from many cpus on the same skb.

Add a const qualifier to skb argument.

[1]
skbuff: skb_under_panic: text:ffffffff8a8ccd05 len:29 put:14 head:ffff88807fc8e400 data:ffff88807fc8e3f4 tail:0x11 end:0x140 dev:<NULL>
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5892 Comm: syz-executor883 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 86 d5 25 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 5a 69 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900038d7638 EFLAGS: 00010282
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 609ffd18ea660600
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88802483c8d0 R08: ffffffff817f0a8c R09: 1ffff9200071ae60
R10: dffffc0000000000 R11: fffff5200071ae61 R12: 0000000000000140
R13: ffff88807fc8e400 R14: ffff88807fc8e3f4 R15: 0000000000000011
FS:  00007fbac5e006c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbac5e00d58 CR3: 000000001238e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  vlan_get_protocol_dgram+0x165/0x290 net/packet/af_packet.c:585
  packet_recvmsg+0x948/0x1ef0 net/packet/af_packet.c:3552
  sock_recvmsg_nosec net/socket.c:1033 [inline]
  sock_recvmsg+0x22f/0x280 net/socket.c:1055
  ____sys_recvmsg+0x1c6/0x480 net/socket.c:2803
  ___sys_recvmsg net/socket.c:2845 [inline]
  do_recvmmsg+0x426/0xab0 net/socket.c:2940
  __sys_recvmmsg net/socket.c:3014 [inline]
  __do_sys_recvmmsg net/socket.c:3037 [inline]
  __se_sys_recvmmsg net/socket.c:3030 [inline]
  __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3030
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")
Reported-by: syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772c485.050a0220.2f3838.04c5.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chengen Du <chengen.du@canonical.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20241230161004.2681892-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/if_vlan.h | 16 +++++++++++++---
 net/packet/af_packet.c  | 16 ++++------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 83266201746c..9f7dbbb34094 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -587,13 +587,16 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
+ * @mac_offset: MAC offset
  * @depth: buffer to store length of eth and vlan tags in bytes
  *
  * Returns the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
-					 int *depth)
+static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
+						__be16 type,
+						int mac_offset,
+						int *depth)
 {
 	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
 
@@ -612,7 +615,8 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 		do {
 			struct vlan_hdr vhdr, *vh;
 
-			vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+			vh = skb_header_pointer(skb, mac_offset + vlan_depth,
+						sizeof(vhdr), &vhdr);
 			if (unlikely(!vh || !--parse_depth))
 				return 0;
 
@@ -627,6 +631,12 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 	return type;
 }
 
+static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
+					 int *depth)
+{
+	return __vlan_get_protocol_offset(skb, type, 0, depth);
+}
+
 /**
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 224ac9a3482c..f3bd3e126703 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -571,21 +571,13 @@ static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 	return ntohs(vh->h_vlan_TCI);
 }
 
-static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 {
 	__be16 proto = skb->protocol;
 
-	if (unlikely(eth_type_vlan(proto))) {
-		u8 *skb_orig_data = skb->data;
-		int skb_orig_len = skb->len;
-
-		skb_push(skb, skb->data - skb_mac_header(skb));
-		proto = __vlan_get_protocol(skb, proto, NULL);
-		if (skb_orig_data != skb->data) {
-			skb->data = skb_orig_data;
-			skb->len = skb_orig_len;
-		}
-	}
+	if (unlikely(eth_type_vlan(proto)))
+		proto = __vlan_get_protocol_offset(skb, proto,
+						   skb_mac_offset(skb), NULL);
 
 	return proto;
 }
-- 
2.39.5




