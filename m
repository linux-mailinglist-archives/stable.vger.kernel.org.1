Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611D870C852
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjEVTiG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjEVThv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2310F0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F1C629A1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D770AC433D2;
        Mon, 22 May 2023 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784258;
        bh=Hol0rAntS+d5ucD7W6E78n239wZrwXho6S+6apuiXE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKaXTYhnFG5/FANBe0J630SdqqDQkkVgvSFeupAzfgV+WllPajGAsHioRsXw6ii4b
         TmtbdIpZVv9m3vz8aoejR9JkM3pLyDi8MmrsrYNO66sE80aj5rOBtzgjieJoPaSx89
         tSVz2rrVrNmR8j9t/dMFe3+iP3MerLVhOmytj4eQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 022/364] net: add vlan_get_protocol_and_depth() helper
Date:   Mon, 22 May 2023 20:05:27 +0100
Message-Id: <20230522190413.386022356@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4063384ef762cc5946fc7a3f89879e76c6ec51e2 ]

Before blamed commit, pskb_may_pull() was used instead
of skb_header_pointer() in __vlan_get_protocol() and friends.

Few callers depended on skb->head being populated with MAC header,
syzbot caught one of them (skb_mac_gso_segment())

Add vlan_get_protocol_and_depth() to make the intent clearer
and use it where sensible.

This is a more generic fix than commit e9d3f80935b6
("net/af_packet: make sure to pull mac header") which was
dealing with a similar issue.

kernel BUG at include/linux/skbuff.h:2655 !
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 1441 Comm: syz-executor199 Not tainted 6.1.24-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:__skb_pull include/linux/skbuff.h:2655 [inline]
RIP: 0010:skb_mac_gso_segment+0x68f/0x6a0 net/core/gro.c:136
Code: fd 48 8b 5c 24 10 44 89 6b 70 48 c7 c7 c0 ae 0d 86 44 89 e6 e8 a1 91 d0 00 48 c7 c7 00 af 0d 86 48 89 de 31 d2 e8 d1 4a e9 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90001bd7520 EFLAGS: 00010286
RAX: ffffffff8469736a RBX: ffff88810f31dac0 RCX: ffff888115a18b00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90001bd75e8 R08: ffffffff84697183 R09: fffff5200037adf9
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000012
R13: 000000000000fee5 R14: 0000000000005865 R15: 000000000000fed7
FS: 000055555633f300(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000116fea000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
[<ffffffff847018dd>] __skb_gso_segment+0x32d/0x4c0 net/core/dev.c:3419
[<ffffffff8470398a>] skb_gso_segment include/linux/netdevice.h:4819 [inline]
[<ffffffff8470398a>] validate_xmit_skb+0x3aa/0xee0 net/core/dev.c:3725
[<ffffffff84707042>] __dev_queue_xmit+0x1332/0x3300 net/core/dev.c:4313
[<ffffffff851a9ec7>] dev_queue_xmit+0x17/0x20 include/linux/netdevice.h:3029
[<ffffffff851b4a82>] packet_snd net/packet/af_packet.c:3111 [inline]
[<ffffffff851b4a82>] packet_sendmsg+0x49d2/0x6470 net/packet/af_packet.c:3142
[<ffffffff84669a12>] sock_sendmsg_nosec net/socket.c:716 [inline]
[<ffffffff84669a12>] sock_sendmsg net/socket.c:736 [inline]
[<ffffffff84669a12>] __sys_sendto+0x472/0x5f0 net/socket.c:2139
[<ffffffff84669c75>] __do_sys_sendto net/socket.c:2151 [inline]
[<ffffffff84669c75>] __se_sys_sendto net/socket.c:2147 [inline]
[<ffffffff84669c75>] __x64_sys_sendto+0xe5/0x100 net/socket.c:2147
[<ffffffff8551d40f>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
[<ffffffff8551d40f>] do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
[<ffffffff85600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 469aceddfa3e ("vlan: consolidate VLAN parsing code and limit max parsing depth")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c       |  4 ++--
 include/linux/if_vlan.h | 17 +++++++++++++++++
 net/bridge/br_forward.c |  2 +-
 net/core/dev.c          |  2 +-
 net/packet/af_packet.c  |  6 ++----
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 8941aa199ea33..456de9c3ea169 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -739,7 +739,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
 	/* copy skb_ubuf_info for callback when skb has no error */
@@ -1186,7 +1186,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
 	rcu_read_lock();
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 6864b89ef8681..7ad09082f56c3 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -628,6 +628,23 @@ static inline __be16 vlan_get_protocol(const struct sk_buff *skb)
 	return __vlan_get_protocol(skb, skb->protocol, NULL);
 }
 
+/* This version of __vlan_get_protocol() also pulls mac header in skb->head */
+static inline __be16 vlan_get_protocol_and_depth(struct sk_buff *skb,
+						 __be16 type, int *depth)
+{
+	int maclen;
+
+	type = __vlan_get_protocol(skb, type, &maclen);
+
+	if (type) {
+		if (!pskb_may_pull(skb, maclen))
+			type = 0;
+		else if (depth)
+			*depth = maclen;
+	}
+	return type;
+}
+
 /* A getter for the SKB protocol field which will handle VLAN tags consistently
  * whether VLAN acceleration is enabled or not.
  */
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 02bb620d3b8da..bd54f17e3c3d8 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -42,7 +42,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 	    eth_type_vlan(skb->protocol)) {
 		int depth;
 
-		if (!__vlan_get_protocol(skb, skb->protocol, &depth))
+		if (!vlan_get_protocol_and_depth(skb, skb->protocol, &depth))
 			goto drop;
 
 		skb_set_network_header(skb, depth);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1488f700bf819..8fbd241849c01 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3338,7 +3338,7 @@ __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 		type = eth->h_proto;
 	}
 
-	return __vlan_get_protocol(skb, type, depth);
+	return vlan_get_protocol_and_depth(skb, type, depth);
 }
 
 /* openvswitch calls this on rx path, so we need a different check.
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b8c62d88567ba..db9c2fa71c50c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1935,10 +1935,8 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
 	    eth_type_vlan(skb->protocol) &&
-	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0) {
-		if (pskb_may_pull(skb, depth))
-			skb_set_network_header(skb, depth);
-	}
+	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
+		skb_set_network_header(skb, depth);
 
 	skb_probe_transport_header(skb);
 }
-- 
2.39.2



