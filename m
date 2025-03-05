Return-Path: <stable+bounces-120953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5797A50942
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A932188841E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC62517AE;
	Wed,  5 Mar 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ne4Yvcaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655224C07D;
	Wed,  5 Mar 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198454; cv=none; b=s1w3b5OLLy+8Kw3KtX5bOdwtDPIBHS/fGBfA/pmcwn39lkM+5zU/Mgb9OSwsDIM2taJe8bkioibLenQy2jEDwwofV+CwTS6zAR+djr4sR5Zur7NSGdHjFuD47WFjNB8OTIBTQa1sq/plfYCe75YndmAkECIYnb3zCx/MWRHAroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198454; c=relaxed/simple;
	bh=SI6/UUHgcpld0X/H0GZyXoC4zdz9ND7Ns63a+tplkKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAe58uB3Pd/9YI7XnqJKTkBEWQkIIcyDkQiXHQ7Ctm4+syJAC9cn46sy3Txsr2G6b9L6nUhxD8HMpYuobqxmYOttlTpEFwVDxYVB5fH70Wt7ds6w8nW6CQJtkyPHipuXR5VTuNxi8VIobt5/k94bc+YbduL2N5B4B6mco7Jv0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ne4Yvcaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA42C4CED1;
	Wed,  5 Mar 2025 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198454;
	bh=SI6/UUHgcpld0X/H0GZyXoC4zdz9ND7Ns63a+tplkKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ne4YvcaqPj+NrbLLPM7uhdHLBhGoDgFQvQ3yowrWDyNNhC0uw68iWn97mjLuSB9Hj
	 MQMFIKwIJuCGn3oZnyxA7S7WheoGEB8nldpQtEqvkdHYGWI8GGHczFVrsEfxZdV8f0
	 9fS+8T8JE5jojHVnMFWhgwRfC45+oP0QjTvWCKUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 034/157] ipvlan: ensure network headers are in skb linear part
Date: Wed,  5 Mar 2025 18:47:50 +0100
Message-ID: <20250305174506.666028657@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 27843ce6ba3d3122b65066550fe33fb8839f8aef ]

syzbot found that ipvlan_process_v6_outbound() was assuming
the IPv6 network header isis present in skb->head [1]

Add the needed pskb_network_may_pull() calls for both
IPv4 and IPv6 handlers.

[1]
BUG: KMSAN: uninit-value in __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
  __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
  ipv6_addr_type include/net/ipv6.h:555 [inline]
  ip6_route_output_flags_noref net/ipv6/route.c:2616 [inline]
  ip6_route_output_flags+0x51/0x720 net/ipv6/route.c:2651
  ip6_route_output include/net/ip6_route.h:93 [inline]
  ipvlan_route_v6_outbound+0x24e/0x520 drivers/net/ipvlan/ipvlan_core.c:476
  ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:491 [inline]
  ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:541 [inline]
  ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:605 [inline]
  ipvlan_queue_xmit+0xd72/0x1780 drivers/net/ipvlan/ipvlan_core.c:671
  ipvlan_start_xmit+0x5b/0x210 drivers/net/ipvlan/ipvlan_main.c:223
  __netdev_start_xmit include/linux/netdevice.h:5150 [inline]
  netdev_start_xmit include/linux/netdevice.h:5159 [inline]
  xmit_one net/core/dev.c:3735 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3751
  sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
  qdisc_restart net/sched/sch_generic.c:408 [inline]
  __qdisc_run+0x14da/0x35d0 net/sched/sch_generic.c:416
  qdisc_run+0x141/0x4d0 include/net/pkt_sched.h:127
  net_tx_action+0x78b/0x940 net/core/dev.c:5484
  handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
  __do_softirq+0x14/0x1a kernel/softirq.c:595
  do_softirq+0x9a/0x100 kernel/softirq.c:462
  __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
  __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4611
  dev_queue_xmit include/linux/netdevice.h:3311 [inline]
  packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3132 [inline]
  packet_sendmsg+0x93e0/0xa7e0 net/packet/af_packet.c:3164
  sock_sendmsg_nosec net/socket.c:718 [inline]

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Reported-by: syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67b74f01.050a0220.14d86d.02d8.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
Link: https://patch.msgid.link/20250220155336.61884-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipvlan/ipvlan_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index fd591ddb3884d..ca62188a317ad 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -416,20 +416,25 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net_device *dev = skb->dev;
 	struct net *net = dev_net(dev);
-	struct rtable *rt;
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+	struct rtable *rt;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
-		.daddr = ip4h->daddr,
-		.saddr = ip4h->saddr,
 	};
 
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		goto err;
+
+	ip4h = ip_hdr(skb);
+	fl4.daddr = ip4h->daddr;
+	fl4.saddr = ip4h->saddr;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
+
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
 		goto err;
@@ -488,6 +493,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int err, ret = NET_XMIT_DROP;
 
+	if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return ret;
+	}
+
 	err = ipvlan_route_v6_outbound(dev, skb);
 	if (unlikely(err)) {
 		DEV_STATS_INC(dev, tx_errors);
-- 
2.39.5




