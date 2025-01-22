Return-Path: <stable+bounces-110134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51FA18E69
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24F73AA2DD
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2371B87CD;
	Wed, 22 Jan 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="J9YmACum"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382F196
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538331; cv=none; b=cLW7H/eGXsO5zBSe7W88a8YXPwfSIaEWNyc9A7mZHq1XDpa7e0do1+53BUeml390UyPX9QIhTevEIw+vwYSjpCavKJM4MNsKutZV/imNbQw5zD/In6YMxWBDBUo47qB5rAK9rJGugwwY4Sl6ANhqvxt7d48m4Y2NYTCgI8l5Nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538331; c=relaxed/simple;
	bh=XcPy8ya67eOlOaa4rPIZDhNGpo+2wQn8uMQoWSAFMXs=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=pzd7J1V3F7tYbTmq0pOjikvXuIWfZMdS61HasFc8xAhXGVJDze2TZPcbZsbBPEk7KC8zM/jMRRDm8/viLILjgglRRsN0YrCg/v5ZR+2aolKT82W+IGAROUCBZTuZhnjVtj4h7iF7du9GUNoBAHNxbCqqBh7N1vOnlV1DFM8Xtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=J9YmACum; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737538326; x=1738143126;
	i=rajanikantha@engineer.com;
	bh=Pty/kfPXiKVMqgj6jMk/GgxcqMNvsN/4OOGs2g9wXU8=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J9YmACum04/nIFrZSfLr4hNetqlyw5/Q5hFcsebF4xan2YUfDKuuzjvSmvV8tdGz
	 2JbzJgczCoh73lbM4srCI+/kN3JnRyyB1uAKX8IKl5pNwauEXYWcpSnhMW1RjoYaK
	 19o0S8Nfx5alL4Zjoh6R0VTsuSBlP5Q0SCjRgt4aPU7ClfDYwY0JdJyF0aiy7QiZi
	 zLydaPU/voUADyzc4rfXHnVArkCkR8po7LhOgqfB7PflO4Djcdlc4nEn/4bdBTT6S
	 4St8pgT3WSWLc1pOCRH8LfZQcZSNSycJ8TuKdgfww39ggHwuwsJokas4Yf5sRLFID
	 vov4bn+6K0v77v+zHA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [147.11.252.42] ([147.11.252.42]) by web-mail.mail.com
 (3c-app-mailcom-lxa12.server.lan [10.76.45.13]) (via HTTP); Wed, 22 Jan
 2025 10:32:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-180b6d3e-b093-4995-a9cc-fe14098ee9a0-1737538325744@3c-app-mailcom-lxa12>
From: Rajani kantha <rajanikantha@engineer.com>
To: omid.ehtemamhaghighi@menlosecurity.com, kernel@aoliver.ca,
 stable@vger.kernel.org
Cc: shuah@kernel.org, idosch@idosch.org, kuniyu@amazon.com, horms@kernel.org
Subject: [PATCH 6.1.y] ipv6: Fix soft lockups in fib6_select_path under high
 next hop churn
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 10:32:05 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:nTZ0MUKvILbemQ0U/ovp+0z4znF4c8v/sryklscuI2+yPnr3j5eRNZQLuPa/2DS11cC5v
 5FkhIAq04WyysMJi7DoknUGRp0Th6zo1ABbSPhrcFU5p8A3aPM7wl4lY47ZxUTKvuop0zamQg1m0
 Al2D4Lq6Njt/LkdUdSzGh2MK/lbMa4GLBnNfkwaEGwZm+Y4qqyUxh/N95zsDS612nZYoyGoxM1BS
 z6Is8/YDYx4XwmbjKdD141UyevEtlqnGUVoJ8WuvkiH0mVl7cr22IhIHn6nqnUomrEwlZdVkRJX5
 6Q=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EyOa/3BmcVQ=;Rf6XlFnfyeEBdudbVcCOmBNOgQW
 Abq7XzFVVr2udZvBezEbNJ7dP8szssxLTKVAYBwdGIXFgFdSPFXaLVR/mduy484fkQmNsYLmU
 ZOiCJwWyD7WEsoL0EnPxgFQtdsgSRINSKRje5OplwlFk4FWjME8itk/iMP8eXXC9u71pOY1rh
 AAMbWwXp2t4SvM9jj+6CF7hw0QFy5mGlNuaOzUdD2/2FRISeBs0WD8hMZ9ZFXuQQQkKvsLGO7
 W6Yz7NQ4AfWjgws4vMeNqs9usE2sZvhj4ZL+5f5ohen4OYXHOv+/sOV+k+zEH7/b2v8boOAF7
 TIaP/Hb6WhJVnYDyruY27TcMBZSN0VQfYgeMqrM1XPZ5GeLqdgzjkkakRm6hPY/60CeHvTeHB
 tiUbEDj/uoco9JlnNdJD4dbsL5yTRu+udjbQInUEDSbBP6/YRCxD++Q60qJqQ8KWfQvdvN/pQ
 nyT0JWZfKyqEkpEaSJL1e4JSOGfUwNsWu4bCQWqt6NYpm9RtchRQJnpoVCm4pAbuilh8Ag5C1
 K21eVsdXp9Zx54kKOMxTJhOMzemHptmoxUDazdUiQsc/iK/BwUaPytw8pXEkIbbm/4ivDjrxf
 GnAPIjmVN29C86LVflQBcFUCXBG7MKomO9g0KlHzAE3ZBTQwkDveprCzdHkRumiY3nBIya3hx
 n5biVIC9tgO9JaXfOxjKqLAGW2aLjBbh69uFX/+LERk8v6hqGAx4lpCh9Bw1WZX+7IyKHgimv
 ZVuwhKNFE4ho1WaWf+ErIpz8mM0A8xV7GNxcZ6+FIfm/VMCCY3J8NN0QHCXkCSYmsOCZ2FLeb
 V10CMEippl8W2aAqwD03emCa6cBgnSnsnkaBZrvgVOpOkmzk3aeKePMzD0jjs+Covlj15eGjJ
 WYQeNPhv8eX+R8OEK2CrM9EVDWOfU7f3H/Men02fejAhOQgRvA9VHVNz1OX1aq6oJT+VsDNf4
 0r7Jl16AhTKdQJkbL9fITy5JI+DgiO2OgZL/RCT8EVOzdUqtK1VAAff92IA7xiADJYcHO8wQk
 rPIA0e8RmdDaCjn4D1whXoFsTYhGLknKYqGzMFGN5iu+KUQceN6+q1jmnGAgBNBYEFPOvAr/J
 yLH1VFSVh2PooHpAFIhu6XZcmIeSLRBWqWxcpYQpbputdehM6GoXcsbC5ycn8oyNTScLiUovU
 =

From: Omid Ehtemam-Haghighi <omid=2Eehtemamhaghighi@menlosecurity=2Ecom>

[ Upstream commit d9ccb18f83ea2bb654289b6ecf014fd267cc988b ]

Soft lockups have been observed on a cluster of Linux-based edge routers
located in a highly dynamic environment=2E Using the `bird` service, these
routers continuously update BGP-advertised routes due to frequently
changing nexthop destinations, while also managing significant IPv6
traffic=2E The lockups occur during the traversal of the multipath
circular linked-list in the `fib6_select_path` function, particularly
while iterating through the siblings in the list=2E The issue typically
arises when the nodes of the linked list are unexpectedly deleted
concurrently on a different core=E2=80=94indicated by their 'next' and
'previous' elements pointing back to the node itself and their reference
count dropping to zero=2E This results in an infinite loop, leading to a
soft lockup that triggers a system panic via the watchdog timer=2E

Apply RCU primitives in the problematic code sections to resolve the
issue=2E Where necessary, update the references to fib6_siblings to
annotate or use the RCU APIs=2E

Include a test script that reproduces the issue=2E The script
periodically updates the routing table while generating a heavy load
of outgoing IPv6 traffic through multiple iperf3 clients=2E It
consistently induces infinite soft lockups within a couple of minutes=2E

Kernel log:

 0 [ffffbd13003e8d30] machine_kexec at ffffffff8ceaf3eb
 1 [ffffbd13003e8d90] __crash_kexec at ffffffff8d0120e3
 2 [ffffbd13003e8e58] panic at ffffffff8cef65d4
 3 [ffffbd13003e8ed8] watchdog_timer_fn at ffffffff8d05cb03
 4 [ffffbd13003e8f08] __hrtimer_run_queues at ffffffff8cfec62f
 5 [ffffbd13003e8f70] hrtimer_interrupt at ffffffff8cfed756
 6 [ffffbd13003e8fd0] __sysvec_apic_timer_interrupt at ffffffff8cea01af
 7 [ffffbd13003e8ff0] sysvec_apic_timer_interrupt at ffffffff8df1b83d
-- <IRQ stack> --
 8 [ffffbd13003d3708] asm_sysvec_apic_timer_interrupt at ffffffff8e000ecb
    [exception RIP: fib6_select_path+299]
    RIP: ffffffff8ddafe7b  RSP: ffffbd13003d37b8  RFLAGS: 00000287
    RAX: ffff975850b43600  RBX: ffff975850b40200  RCX: 0000000000000000
    RDX: 000000003fffffff  RSI: 0000000051d383e4  RDI: ffff975850b43618
    RBP: ffffbd13003d3800   R8: 0000000000000000   R9: ffff975850b40200
    R10: 0000000000000000  R11: 0000000000000000  R12: ffffbd13003d3830
    R13: ffff975850b436a8  R14: ffff975850b43600  R15: 0000000000000007
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 9 [ffffbd13003d3808] ip6_pol_route at ffffffff8ddb030c
10 [ffffbd13003d3888] ip6_pol_route_input at ffffffff8ddb068c
11 [ffffbd13003d3898] fib6_rule_lookup at ffffffff8ddf02b5
12 [ffffbd13003d3928] ip6_route_input at ffffffff8ddb0f47
13 [ffffbd13003d3a18] ip6_rcv_finish_core=2Econstprop=2E0 at ffffffff8dd95=
0d0
14 [ffffbd13003d3a30] ip6_list_rcv_finish=2Econstprop=2E0 at ffffffff8dd96=
274
15 [ffffbd13003d3a98] ip6_sublist_rcv at ffffffff8dd96474
16 [ffffbd13003d3af8] ipv6_list_rcv at ffffffff8dd96615
17 [ffffbd13003d3b60] __netif_receive_skb_list_core at ffffffff8dc16fec
18 [ffffbd13003d3be0] netif_receive_skb_list_internal at ffffffff8dc176b3
19 [ffffbd13003d3c50] napi_gro_receive at ffffffff8dc565b9
20 [ffffbd13003d3c80] ice_receive_skb at ffffffffc087e4f5 [ice]
21 [ffffbd13003d3c90] ice_clean_rx_irq at ffffffffc0881b80 [ice]
22 [ffffbd13003d3d20] ice_napi_poll at ffffffffc088232f [ice]
23 [ffffbd13003d3d80] __napi_poll at ffffffff8dc18000
24 [ffffbd13003d3db8] net_rx_action at ffffffff8dc18581
25 [ffffbd13003d3e40] __do_softirq at ffffffff8df352e9
26 [ffffbd13003d3eb0] run_ksoftirqd at ffffffff8ceffe47
27 [ffffbd13003d3ec0] smpboot_thread_fn at ffffffff8cf36a30
28 [ffffbd13003d3ee8] kthread at ffffffff8cf2b39f
29 [ffffbd13003d3f28] ret_from_fork at ffffffff8ce5fa64
30 [ffffbd13003d3f50] ret_from_fork_asm at ffffffff8ce03cbb

Fixes: 66f5d6ce53e6 ("ipv6: replace rwlock with rcu and spinlock in fib6_t=
able")
Reported-by: Adrian Oliver <kernel@aoliver=2Eca>
Signed-off-by: Omid Ehtemam-Haghighi <omid=2Eehtemamhaghighi@menlosecurity=
=2Ecom>
Cc: Shuah Khan <shuah@kernel=2Eorg>
Cc: Ido Schimmel <idosch@idosch=2Eorg>
Cc: Kuniyuki Iwashima <kuniyu@amazon=2Ecom>
Cc: Simon Horman <horms@kernel=2Eorg>
Reviewed-by: David Ahern <dsahern@kernel=2Eorg>
Link: https://patch=2Emsgid=2Elink/20241106010236=2E1239299-1-omid=2Eehtem=
amhaghighi@menlosecurity=2Ecom
Signed-off-by: Jakub Kicinski <kuba@kernel=2Eorg>
Signed-off-by: Rajani Kantha <rajanikantha@engineer=2Ecom>
---
 net/ipv6/ip6_fib=2Ec                            |   8 +-
 net/ipv6/route=2Ec                              |  45 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 =2E=2E=2E/net/ipv6_route_update_soft_lockup=2Esh      | 262 +++++++++++++=
+++++
 4 files changed, 297 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_loc=
kup=2Esh

diff --git a/net/ipv6/ip6_fib=2Ec b/net/ipv6/ip6_fib=2Ec
index 0b45ef8b7ee2=2E=2Eb6a7cbd6bee0 100644
--- a/net/ipv6/ip6_fib=2Ec
+++ b/net/ipv6/ip6_fib=2Ec
@@ -1180,8 +1180,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, st=
ruct fib6_info *rt,
 		while (sibling) {
 			if (sibling->fib6_metric =3D=3D rt->fib6_metric &&
 			    rt6_qualify_for_ecmp(sibling)) {
-				list_add_tail(&rt->fib6_siblings,
-					      &sibling->fib6_siblings);
+				list_add_tail_rcu(&rt->fib6_siblings,
+						  &sibling->fib6_siblings);
 				break;
 			}
 			sibling =3D rcu_dereference_protected(sibling->fib6_next,
@@ -1242,7 +1242,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, st=
ruct fib6_info *rt,
 							 fib6_siblings)
 					sibling->fib6_nsiblings--;
 				rt->fib6_nsiblings =3D 0;
-				list_del_init(&rt->fib6_siblings);
+				list_del_rcu(&rt->fib6_siblings);
 				rt6_multipath_rebalance(next_sibling);
 				return err;
 			}
@@ -1955,7 +1955,7 @@ static void fib6_del_route(struct fib6_table *table,=
 struct fib6_node *fn,
 					 &rt->fib6_siblings, fib6_siblings)
 			sibling->fib6_nsiblings--;
 		rt->fib6_nsiblings =3D 0;
-		list_del_init(&rt->fib6_siblings);
+		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
 	}
=20
diff --git a/net/ipv6/route=2Ec b/net/ipv6/route=2Ec
index 5ae3ff6ffb7e=2E=2Ef3268bac9f19 100644
--- a/net/ipv6/route=2Ec
+++ b/net/ipv6/route=2Ec
@@ -420,8 +420,8 @@ void fib6_select_path(const struct net *net, struct fi=
b6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *sibling, *next_sibling;
 	struct fib6_info *match =3D res->f6i;
+	struct fib6_info *sibling;
=20
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
 		goto out;
@@ -447,8 +447,8 @@ void fib6_select_path(const struct net *net, struct fi=
b6_result *res,
 	if (fl6->mp_hash <=3D atomic_read(&match->fib6_nh->fib_nh_upper_bound))
 		goto out;
=20
-	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
-				 fib6_siblings) {
+	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+				fib6_siblings) {
 		const struct fib6_nh *nh =3D sibling->fib6_nh;
 		int nh_upper_bound;
=20
@@ -5189,14 +5189,18 @@ static void ip6_route_mpath_notify(struct fib6_inf=
o *rt,
 	 * nexthop=2E Since sibling routes are always added at the end of
 	 * the list, find the first sibling of the last route appended
 	 */
+	rcu_read_lock();
+
 	if ((nlflags & NLM_F_APPEND) && rt_last && rt_last->fib6_nsiblings) {
-		rt =3D list_first_entry(&rt_last->fib6_siblings,
-				      struct fib6_info,
-				      fib6_siblings);
+		rt =3D list_first_or_null_rcu(&rt_last->fib6_siblings,
+					    struct fib6_info,
+					    fib6_siblings);
 	}
=20
 	if (rt)
 		inet6_rt_notify(RTM_NEWROUTE, rt, info, nlflags);
+
+	rcu_read_unlock();
 }
=20
 static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
@@ -5541,17 +5545,21 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i=
)
 		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
 					 &nexthop_len);
 	} else {
-		struct fib6_info *sibling, *next_sibling;
 		struct fib6_nh *nh =3D f6i->fib6_nh;
+		struct fib6_info *sibling;
=20
 		nexthop_len =3D 0;
 		if (f6i->fib6_nsiblings) {
 			rt6_nh_nlmsg_size(nh, &nexthop_len);
=20
-			list_for_each_entry_safe(sibling, next_sibling,
-						 &f6i->fib6_siblings, fib6_siblings) {
+			rcu_read_lock();
+
+			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+						fib6_siblings) {
 				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
 			}
+
+			rcu_read_unlock();
 		}
 		nexthop_len +=3D lwtunnel_get_encap_size(nh->fib_nh_lws);
 	}
@@ -5715,7 +5723,7 @@ static int rt6_fill_node(struct net *net, struct sk_=
buff *skb,
 		    lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) =
< 0)
 			goto nla_put_failure;
 	} else if (rt->fib6_nsiblings) {
-		struct fib6_info *sibling, *next_sibling;
+		struct fib6_info *sibling;
 		struct nlattr *mp;
=20
 		mp =3D nla_nest_start_noflag(skb, RTA_MULTIPATH);
@@ -5727,14 +5735,21 @@ static int rt6_fill_node(struct net *net, struct s=
k_buff *skb,
 				    0) < 0)
 			goto nla_put_failure;
=20
-		list_for_each_entry_safe(sibling, next_sibling,
-					 &rt->fib6_siblings, fib6_siblings) {
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
+					fib6_siblings) {
 			if (fib_add_nexthop(skb, &sibling->fib6_nh->nh_common,
 					    sibling->fib6_nh->fib_nh_weight,
-					    AF_INET6, 0) < 0)
+					    AF_INET6, 0) < 0) {
+				rcu_read_unlock();
+
 				goto nla_put_failure;
+			}
 		}
=20
+		rcu_read_unlock();
+
 		nla_nest_end(skb, mp);
 	} else if (rt->nh) {
 		if (nla_put_u32(skb, RTA_NH_ID, rt->nh->id))
@@ -6171,7 +6186,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt=
, struct nl_info *info,
 	err =3D -ENOBUFS;
 	seq =3D info->nlh ? info->nlh->nlmsg_seq : 0;
=20
-	skb =3D nlmsg_new(rt6_nlmsg_size(rt), gfp_any());
+	skb =3D nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
=20
@@ -6184,7 +6199,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt=
, struct nl_info *info,
 		goto errout;
 	}
 	rtnl_notify(skb, net, info->portid, RTNLGRP_IPV6_ROUTE,
-		    info->nlh, gfp_any());
+		    info->nlh, GFP_ATOMIC);
 	return;
 errout:
 	if (err < 0)
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftest=
s/net/Makefile
index 48d1a68be1d5=2E=2E080860a8826b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -72,6 +72,7 @@ TEST_GEN_PROGS +=3D sk_bind_sendto_listen
 TEST_GEN_PROGS +=3D sk_connect_zero_addr
 TEST_PROGS +=3D test_ingress_egress_chaining=2Esh
 TEST_GEN_FILES +=3D nat6to4=2Eo
+TEST_PROGS +=3D ipv6_route_update_soft_lockup=2Esh
=20
 TEST_FILES :=3D settings
=20
diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup=2Es=
h b/tools/testing/selftests/net/ipv6_route_update_soft_lockup=2Esh
new file mode 100755
index 000000000000=2E=2Ea6b2b1f9c641
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup=2Esh
@@ -0,0 +1,262 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2=2E0
+#
+# Testing for potential kernel soft lockup during IPv6 routing table
+# refresh under heavy outgoing IPv6 traffic=2E If a kernel soft lockup
+# occurs, a kernel panic will be triggered to prevent associated issues=
=2E
+#
+#
+#                            Test Environment Layout
+#
+# =E2=94=8C----------------=E2=94=90                                     =
    =E2=94=8C----------------=E2=94=90
+# |     SOURCE_NS  |                                         |     SINK_N=
S    |
+# |    NAMESPACE   |                                         |    NAMESPA=
CE   |
+# |(iperf3 clients)|                                         |(iperf3 ser=
vers)|
+# |                |                                         |           =
     |
+# |                |                                         |           =
     |
+# |    =E2=94=8C-----------|                             nexthops    |---=
------=E2=94=90      |
+# |    |veth_source|<--------------------------------------->|veth_sink|<=
=E2=94=90    |
+# |    =E2=94=94-----------|2001:0DB8:1::0:1/96  2001:0DB8:1::1:1/96 |---=
------=E2=94=98 |    |
+# |                |         ^           2001:0DB8:1::1:2/96 |           =
|    |
+# |                |         =2E                   =2E           |       =
fwd |    |
+# |  =E2=94=8C---------=E2=94=90   |         =2E                   =2E   =
        |           |    |
+# |  |   IPv6  |   |         =2E                   =2E           |       =
    V    |
+# |  | routing |   |         =2E           2001:0DB8:1::1:80/96|        =
=E2=94=8C-----=E2=94=90 |
+# |  |  table  |   |         =2E                               |        |=
 lo  | |
+# |  | nexthop |   |         =2E                               =E2=94=94-=
-------=E2=94=B4-----=E2=94=B4-=E2=94=98
+# |  | update  |   |         =2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E> 2001:0DB8:2::1:1/128
+# |  =E2=94=94-------- =E2=94=98   |
+# =E2=94=94----------------=E2=94=98
+#
+# The test script sets up two network namespaces, source_ns and sink_ns,
+# connected via a veth link=2E Within source_ns, it continuously updates =
the
+# IPv6 routing table by flushing and inserting IPV6_NEXTHOP_ADDR_COUNT ne=
xthop
+# IPs destined for SINK_LOOPBACK_IP_ADDR in sink_ns=2E This refresh occur=
s at a
+# rate of 1/ROUTING_TABLE_REFRESH_PERIOD per second for TEST_DURATION sec=
onds=2E
+#
+# Simultaneously, multiple iperf3 clients within source_ns generate heavy
+# outgoing IPv6 traffic=2E Each client is assigned a unique port number s=
tarting
+# at 5000 and incrementing sequentially=2E Each client targets a unique i=
perf3
+# server running in sink_ns, connected to the SINK_LOOPBACK_IFACE interfa=
ce
+# using the same port number=2E
+#
+# The number of iperf3 servers and clients is set to half of the total
+# available cores on each machine=2E
+#
+# NOTE: We have tested this script on machines with various CPU specifica=
tions,
+# ranging from lower to higher performance as listed below=2E The test sc=
ript
+# effectively triggered a kernel soft lockup on machines running an unpat=
ched
+# kernel in under a minute:
+#
+# - 1x Intel Xeon E-2278G 8-Core Processor @ 3=2E40GHz
+# - 1x Intel Xeon E-2378G Processor 8-Core @ 2=2E80GHz
+# - 1x AMD EPYC 7401P 24-Core Processor @ 2=2E00GHz
+# - 1x AMD EPYC 7402P 24-Core Processor @ 2=2E80GHz
+# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2=2E20GHz
+# - 1x Ampere Altra Q80-30 80-Core Processor @ 3=2E00GHz
+# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2=2E20GHz
+# - 2x Intel Xeon Silver 4214 24-Core Processor @ 2=2E20GHz
+# - 1x AMD EPYC 7502P 32-Core @ 2=2E50GHz
+# - 1x Intel Xeon Gold 6314U 32-Core Processor @ 2=2E30GHz
+# - 2x Intel Xeon Gold 6338 32-Core Processor @ 2=2E00GHz
+#
+# On less performant machines, you may need to increase the TEST_DURATION
+# parameter to enhance the likelihood of encountering a race condition le=
ading
+# to a kernel soft lockup and avoid a false negative result=2E
+#
+# NOTE: The test may not produce the expected result in virtualized
+# environments (e=2Eg=2E, qemu) due to differences in timing and CPU hand=
ling,
+# which can affect the conditions needed to trigger a soft lockup=2E
+
+source lib=2Esh
+source net_helper=2Esh
+
+TEST_DURATION=3D300
+ROUTING_TABLE_REFRESH_PERIOD=3D0=2E01
+
+IPERF3_BITRATE=3D"300m"
+
+
+IPV6_NEXTHOP_ADDR_COUNT=3D"128"
+IPV6_NEXTHOP_ADDR_MASK=3D"96"
+IPV6_NEXTHOP_PREFIX=3D"2001:0DB8:1"
+
+
+SOURCE_TEST_IFACE=3D"veth_source"
+SOURCE_TEST_IP_ADDR=3D"2001:0DB8:1::0:1/96"
+
+SINK_TEST_IFACE=3D"veth_sink"
+# ${SINK_TEST_IFACE} is populated with the following range of IPv6 addres=
ses:
+# 2001:0DB8:1::1:1  to 2001:0DB8:1::1:${IPV6_NEXTHOP_ADDR_COUNT}
+SINK_LOOPBACK_IFACE=3D"lo"
+SINK_LOOPBACK_IP_MASK=3D"128"
+SINK_LOOPBACK_IP_ADDR=3D"2001:0DB8:2::1:1"
+
+nexthop_ip_list=3D""
+termination_signal=3D""
+kernel_softlokup_panic_prev_val=3D""
+
+terminate_ns_processes_by_pattern() {
+	local ns=3D$1
+	local pattern=3D$2
+
+	for pid in $(ip netns pids ${ns}); do
+		[ -e /proc/$pid/cmdline ] && grep -qe "${pattern}" /proc/$pid/cmdline &=
& kill -9 $pid
+	done
+}
+
+cleanup() {
+	echo "info: cleaning up namespaces and terminating all processes within =
them=2E=2E=2E"
+
+
+	# Terminate iperf3 instances running in the source_ns=2E To avoid race
+	# conditions, first iterate over the PIDs and terminate those
+	# associated with the bash shells running the
+	# `while true; do iperf3 -c =2E=2E=2E; done` loops=2E In a second iterat=
ion,
+	# terminate the individual `iperf3 -c =2E=2E=2E` instances=2E
+	terminate_ns_processes_by_pattern ${source_ns} while
+	terminate_ns_processes_by_pattern ${source_ns} iperf3
+
+	# Repeat the same process for sink_ns
+	terminate_ns_processes_by_pattern ${sink_ns} while
+	terminate_ns_processes_by_pattern ${sink_ns} iperf3
+
+	# Check if any iperf3 instances are still running=2E This could happen
+	# if a core has entered an infinite loop and the timeout for detecting
+	# the soft lockup has not expired, but either the test interval has
+	# already elapsed or the test was terminated manually (e=2Eg=2E, with ^C=
)
+	for pid in $(ip netns pids ${source_ns}); do
+		if [ -e /proc/$pid/cmdline ] && grep -qe 'iperf3' /proc/$pid/cmdline; t=
hen
+			echo "FAIL: unable to terminate some iperf3 instances=2E Soft lockup i=
s underway=2E A kernel panic is on the way!"
+			exit ${ksft_fail}
+		fi
+	done
+
+	if [ "$termination_signal" =3D=3D "SIGINT" ]; then
+		echo "SKIP: Termination due to ^C (SIGINT)"
+	elif [ "$termination_signal" =3D=3D "SIGALRM" ]; then
+		echo "PASS: No kernel soft lockup occurred during this ${TEST_DURATION}=
 second test"
+	fi
+
+	cleanup_ns ${source_ns} ${sink_ns}
+
+	sysctl -qw kernel=2Esoftlockup_panic=3D${kernel_softlokup_panic_prev_val=
}
+}
+
+setup_prepare() {
+	setup_ns source_ns sink_ns
+
+	ip -n ${source_ns} link add name ${SOURCE_TEST_IFACE} type veth peer nam=
e ${SINK_TEST_IFACE} netns ${sink_ns}
+
+	# Setting up the Source namespace
+	ip -n ${source_ns} addr add ${SOURCE_TEST_IP_ADDR} dev ${SOURCE_TEST_IFA=
CE}
+	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} qlen 10000
+	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} up
+	ip netns exec ${source_ns} sysctl -qw net=2Eipv6=2Efib_multipath_hash_po=
licy=3D1
+
+	# Setting up the Sink namespace
+	ip -n ${sink_ns} addr add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MA=
SK} dev ${SINK_LOOPBACK_IFACE}
+	ip -n ${sink_ns} link set dev ${SINK_LOOPBACK_IFACE} up
+	ip netns exec ${sink_ns} sysctl -qw net=2Eipv6=2Econf=2E${SINK_LOOPBACK_=
IFACE}=2Eforwarding=3D1
+
+	ip -n ${sink_ns} link set ${SINK_TEST_IFACE} up
+	ip netns exec ${sink_ns} sysctl -qw net=2Eipv6=2Econf=2E${SINK_TEST_IFAC=
E}=2Eforwarding=3D1
+
+
+	# Populate nexthop IPv6 addresses on the test interface in the sink_ns
+	echo "info: populating ${IPV6_NEXTHOP_ADDR_COUNT} IPv6 addresses on the =
${SINK_TEST_IFACE} interface =2E=2E=2E"
+	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
+		ip -n ${sink_ns} addr add ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" "${IP=
}")/${IPV6_NEXTHOP_ADDR_MASK} dev ${SINK_TEST_IFACE};
+	done
+
+	# Preparing list of nexthops
+	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
+		nexthop_ip_list=3D$nexthop_ip_list" nexthop via ${IPV6_NEXTHOP_PREFIX}:=
:$(printf "1:%x" $IP) dev ${SOURCE_TEST_IFACE} weight 1"
+	done
+}
+
+
+test_soft_lockup_during_routing_table_refresh() {
+	# Start num_of_iperf_servers iperf3 servers in the sink_ns namespace,
+	# each listening on ports starting at 5001 and incrementing
+	# sequentially=2E Since iperf3 instances may terminate unexpectedly, a
+	# while loop is used to automatically restart them in such cases=2E
+	echo "info: starting ${num_of_iperf_servers} iperf3 servers in the sink_=
ns namespace =2E=2E=2E"
+	for i in $(seq 1 ${num_of_iperf_servers}); do
+		cmd=3D"iperf3 --bind ${SINK_LOOPBACK_IP_ADDR} -s -p $(printf '5%03d' ${=
i}) --rcv-timeout 200 &>/dev/null"
+		ip netns exec ${sink_ns} bash -c "while true; do ${cmd}; done &" &>/dev=
/null
+	done
+
+	# Wait for the iperf3 servers to be ready
+	for i in $(seq ${num_of_iperf_servers}); do
+		port=3D$(printf '5%03d' ${i});
+		wait_local_port_listen ${sink_ns} ${port} tcp
+	done
+
+	# Continuously refresh the routing table in the background within
+	# the source_ns namespace
+	ip netns exec ${source_ns} bash -c "
+		while \$(ip netns list | grep -q ${source_ns}); do
+			ip -6 route add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} ${ne=
xthop_ip_list};
+			sleep ${ROUTING_TABLE_REFRESH_PERIOD};
+			ip -6 route delete ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK};
+		done &"
+
+	# Start num_of_iperf_servers iperf3 clients in the source_ns namespace,
+	# each sending TCP traffic on sequential ports starting at 5001=2E
+	# Since iperf3 instances may terminate unexpectedly (e=2Eg=2E, if the ro=
ute
+	# to the server is deleted in the background during a route refresh), a
+	# while loop is used to automatically restart them in such cases=2E
+	echo "info: starting ${num_of_iperf_servers} iperf3 clients in the sourc=
e_ns namespace =2E=2E=2E"
+	for i in $(seq 1 ${num_of_iperf_servers}); do
+		cmd=3D"iperf3 -c ${SINK_LOOPBACK_IP_ADDR} -p $(printf '5%03d' ${i}) --l=
ength 64 --bitrate ${IPERF3_BITRATE} -t 0 --connect-timeout 150 &>/dev/null=
"
+		ip netns exec ${source_ns} bash -c "while true; do ${cmd}; done &" &>/d=
ev/null
+	done
+
+	echo "info: IPv6 routing table is being updated at the rate of $(echo "1=
/${ROUTING_TABLE_REFRESH_PERIOD}" | bc)/s for ${TEST_DURATION} seconds =2E=
=2E=2E"
+	echo "info: A kernel soft lockup, if detected, results in a kernel panic=
!"
+
+	wait
+}
+
+# Make sure 'iperf3' is installed, skip the test otherwise
+if [ ! -x "$(command -v "iperf3")" ]; then
+	echo "SKIP: 'iperf3' is not installed=2E Skipping the test=2E"
+	exit ${ksft_skip}
+fi
+
+# Determine the number of cores on the machine
+num_of_iperf_servers=3D$(( $(nproc)/2 ))
+
+# Check if we are running on a multi-core machine, skip the test otherwis=
e
+if [ "${num_of_iperf_servers}" -eq 0 ]; then
+	echo "SKIP: This test is not valid on a single core machine!"
+	exit ${ksft_skip}
+fi
+
+# Since the kernel soft lockup we're testing causes at least one core to =
enter
+# an infinite loop, destabilizing the host and likely affecting subsequen=
t
+# tests, we trigger a kernel panic instead of reporting a failure and
+# continuing
+kernel_softlokup_panic_prev_val=3D$(sysctl -n kernel=2Esoftlockup_panic)
+sysctl -qw kernel=2Esoftlockup_panic=3D1
+
+handle_sigint() {
+	termination_signal=3D"SIGINT"
+	cleanup
+	exit ${ksft_skip}
+}
+
+handle_sigalrm() {
+	termination_signal=3D"SIGALRM"
+	cleanup
+	exit ${ksft_pass}
+}
+
+trap handle_sigint SIGINT
+trap handle_sigalrm SIGALRM
+
+(sleep ${TEST_DURATION} && kill -s SIGALRM $$)&
+
+setup_prepare
+test_soft_lockup_during_routing_table_refresh
--=20
2=2E35=2E3

