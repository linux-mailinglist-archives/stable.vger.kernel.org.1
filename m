Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4B713C38
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjE1TNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE1TNO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C55A0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A13618F5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B96C433EF;
        Sun, 28 May 2023 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301192;
        bh=BIy+edq2XVvUduQjxjkgZSoIp/xMl+PJzABG6hrPSh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuGu17Eo9iKYRIuroJnruKubLIBKmdD2K5A7TvOtsQl+UvsBZ16PAGY19YIN2hLKs
         EvZ86lbKR4jSgSj6aFCvag9/u79UjZpv6jMg20mKx8v1CAW5TEwu0XOM/5ruQHouzK
         HUMekRHR5ENHFwP5oeSZjOZcLegXWl5MuFSuPSKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "t.feng" <fengtao40@huawei.com>,
        Florian Westphal <fw@strlen.de>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/86] ipvlan:Fix out-of-bounds caused by unclear skb->cb
Date:   Sun, 28 May 2023 20:09:38 +0100
Message-Id: <20230528190828.721719852@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: t.feng <fengtao40@huawei.com>

[ Upstream commit 90cbed5247439a966b645b34eb0a2e037836ea8e ]

If skb enqueue the qdisc, fq_skb_cb(skb)->time_to_send is changed which
is actually skb->cb, and IPCB(skb_in)->opt will be used in
__ip_options_echo. It is possible that memcpy is out of bounds and lead
to stack overflow.
We should clear skb->cb before ip_local_out or ip6_local_out.

v2:
1. clean the stack info
2. use IPCB/IP6CB instead of skb->cb

crash on stable-5.10(reproduce in kasan kernel).
Stack info:
[ 2203.651571] BUG: KASAN: stack-out-of-bounds in
__ip_options_echo+0x589/0x800
[ 2203.653327] Write of size 4 at addr ffff88811a388f27 by task
swapper/3/0
[ 2203.655460] CPU: 3 PID: 0 Comm: swapper/3 Kdump: loaded Not tainted
5.10.0-60.18.0.50.h856.kasan.eulerosv2r11.x86_64 #1
[ 2203.655466] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.10.2-0-g5f4c7b1-20181220_000000-szxrtosci10000 04/01/2014
[ 2203.655475] Call Trace:
[ 2203.655481]  <IRQ>
[ 2203.655501]  dump_stack+0x9c/0xd3
[ 2203.655514]  print_address_description.constprop.0+0x19/0x170
[ 2203.655530]  __kasan_report.cold+0x6c/0x84
[ 2203.655586]  kasan_report+0x3a/0x50
[ 2203.655594]  check_memory_region+0xfd/0x1f0
[ 2203.655601]  memcpy+0x39/0x60
[ 2203.655608]  __ip_options_echo+0x589/0x800
[ 2203.655654]  __icmp_send+0x59a/0x960
[ 2203.655755]  nf_send_unreach+0x129/0x3d0 [nf_reject_ipv4]
[ 2203.655763]  reject_tg+0x77/0x1bf [ipt_REJECT]
[ 2203.655772]  ipt_do_table+0x691/0xa40 [ip_tables]
[ 2203.655821]  nf_hook_slow+0x69/0x100
[ 2203.655828]  __ip_local_out+0x21e/0x2b0
[ 2203.655857]  ip_local_out+0x28/0x90
[ 2203.655868]  ipvlan_process_v4_outbound+0x21e/0x260 [ipvlan]
[ 2203.655931]  ipvlan_xmit_mode_l3+0x3bd/0x400 [ipvlan]
[ 2203.655967]  ipvlan_queue_xmit+0xb3/0x190 [ipvlan]
[ 2203.655977]  ipvlan_start_xmit+0x2e/0xb0 [ipvlan]
[ 2203.655984]  xmit_one.constprop.0+0xe1/0x280
[ 2203.655992]  dev_hard_start_xmit+0x62/0x100
[ 2203.656000]  sch_direct_xmit+0x215/0x640
[ 2203.656028]  __qdisc_run+0x153/0x1f0
[ 2203.656069]  __dev_queue_xmit+0x77f/0x1030
[ 2203.656173]  ip_finish_output2+0x59b/0xc20
[ 2203.656244]  __ip_finish_output.part.0+0x318/0x3d0
[ 2203.656312]  ip_finish_output+0x168/0x190
[ 2203.656320]  ip_output+0x12d/0x220
[ 2203.656357]  __ip_queue_xmit+0x392/0x880
[ 2203.656380]  __tcp_transmit_skb+0x1088/0x11c0
[ 2203.656436]  __tcp_retransmit_skb+0x475/0xa30
[ 2203.656505]  tcp_retransmit_skb+0x2d/0x190
[ 2203.656512]  tcp_retransmit_timer+0x3af/0x9a0
[ 2203.656519]  tcp_write_timer_handler+0x3ba/0x510
[ 2203.656529]  tcp_write_timer+0x55/0x180
[ 2203.656542]  call_timer_fn+0x3f/0x1d0
[ 2203.656555]  expire_timers+0x160/0x200
[ 2203.656562]  run_timer_softirq+0x1f4/0x480
[ 2203.656606]  __do_softirq+0xfd/0x402
[ 2203.656613]  asm_call_irq_on_stack+0x12/0x20
[ 2203.656617]  </IRQ>
[ 2203.656623]  do_softirq_own_stack+0x37/0x50
[ 2203.656631]  irq_exit_rcu+0x134/0x1a0
[ 2203.656639]  sysvec_apic_timer_interrupt+0x36/0x80
[ 2203.656646]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 2203.656654] RIP: 0010:default_idle+0x13/0x20
[ 2203.656663] Code: 89 f0 5d 41 5c 41 5d 41 5e c3 cc cc cc cc cc cc cc
cc cc cc cc cc cc 0f 1f 44 00 00 0f 1f 44 00 00 0f 00 2d 9f 32 57 00 fb
f4 <c3> cc cc cc cc 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 be 08
[ 2203.656668] RSP: 0018:ffff88810036fe78 EFLAGS: 00000256
[ 2203.656676] RAX: ffffffffaf2a87f0 RBX: ffff888100360000 RCX:
ffffffffaf290191
[ 2203.656681] RDX: 0000000000098b5e RSI: 0000000000000004 RDI:
ffff88811a3c4f60
[ 2203.656686] RBP: 0000000000000000 R08: 0000000000000001 R09:
ffff88811a3c4f63
[ 2203.656690] R10: ffffed10234789ec R11: 0000000000000001 R12:
0000000000000003
[ 2203.656695] R13: ffff888100360000 R14: 0000000000000000 R15:
0000000000000000
[ 2203.656729]  default_idle_call+0x5a/0x150
[ 2203.656735]  cpuidle_idle_call+0x1c6/0x220
[ 2203.656780]  do_idle+0xab/0x100
[ 2203.656786]  cpu_startup_entry+0x19/0x20
[ 2203.656793]  secondary_startup_64_no_verify+0xc2/0xcb

[ 2203.657409] The buggy address belongs to the page:
[ 2203.658648] page:0000000027a9842f refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x11a388
[ 2203.658665] flags:
0x17ffffc0001000(reserved|node=0|zone=2|lastcpupid=0x1fffff)
[ 2203.658675] raw: 0017ffffc0001000 ffffea000468e208 ffffea000468e208
0000000000000000
[ 2203.658682] raw: 0000000000000000 0000000000000000 00000001ffffffff
0000000000000000
[ 2203.658686] page dumped because: kasan: bad access detected

To reproduce(ipvlan with IPVLAN_MODE_L3):
Env setting:
=======================================================
modprobe ipvlan ipvlan_default_mode=1
sysctl net.ipv4.conf.eth0.forwarding=1
iptables -t nat -A POSTROUTING -s 20.0.0.0/255.255.255.0 -o eth0 -j
MASQUERADE
ip link add gw link eth0 type ipvlan
ip -4 addr add 20.0.0.254/24 dev gw
ip netns add net1
ip link add ipv1 link eth0 type ipvlan
ip link set ipv1 netns net1
ip netns exec net1 ip link set ipv1 up
ip netns exec net1 ip -4 addr add 20.0.0.4/24 dev ipv1
ip netns exec net1 route add default gw 20.0.0.254
ip netns exec net1 tc qdisc add dev ipv1 root netem loss 10%
ifconfig gw up
iptables -t filter -A OUTPUT -p tcp --dport 8888 -j REJECT --reject-with
icmp-port-unreachable
=======================================================
And then excute the shell(curl any address of eth0 can reach):

for((i=1;i<=100000;i++))
do
        ip netns exec net1 curl x.x.x.x:8888
done
=======================================================

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: "t.feng" <fengtao40@huawei.com>
Suggested-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipvlan/ipvlan_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 71fd45137ee44..6283cbc9f6ed1 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -394,6 +394,9 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, &rt->dst);
+
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
@@ -431,6 +434,9 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 		goto err;
 	}
 	skb_dst_set(skb, dst);
+
+	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		dev->stats.tx_errors++;
-- 
2.39.2



