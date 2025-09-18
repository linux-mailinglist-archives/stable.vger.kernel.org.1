Return-Path: <stable+bounces-176378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C95B36BA7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BC4E0FE5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070434A332;
	Tue, 26 Aug 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkdFQPjR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341134DCC3;
	Tue, 26 Aug 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219503; cv=none; b=T2bcbiUreMU38F1fRT5s1xaBNbD1ulOOv7VtLqwFThQXdyYX71hUYe4WnlT1cq1yflKnUfkTHCLI5PTcYJIDUCqv6cWf3t1vvVxC+xaIlG/MeMvS51Abp+OO4SHv8SPoMJvpVz8ww2cxbQTnvqsFSMtQnu7YqOxV0njb3HWWVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219503; c=relaxed/simple;
	bh=h/tFv+elLsPdrrRntdoLHF1Vsb6H427WZCML2LYRxLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJsCcgQDsaA31U8OJVDm4fZ3lr2E87Xxu+cocf55rqEpyhPgl/VeFIkbvLYbv1nvhzbSkJWJ+6vWdRw9I0n0NwQZLyx94ylnKv34ODgdKDTbXsNDxO8+3mW+sK9oe4RTKpXPO8Tq0HT/tkGmsJem0c1ap2IEftnwatgSzOoLMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkdFQPjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400DFC4CEF1;
	Tue, 26 Aug 2025 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219502;
	bh=h/tFv+elLsPdrrRntdoLHF1Vsb6H427WZCML2LYRxLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vkdFQPjRu3cfa70qRorh/kVKuVtfTnF4TXaOeyCnR9y16kFlsrK/ruKpFN+IT+EFl
	 7xGRp1iT90UC3i0wuChG2TSfgYeRRePWQ+HmCfaTmeTnY/h6o/909SckwdbeqGEr29
	 MQxTpcGVDZ70prIxJU4cG0DrPBWv35+z7/LJBbvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Zhao <wizhao@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4 389/403] act_mirred: use the backlog for nested calls to mirred ingress
Date: Tue, 26 Aug 2025 13:11:55 +0200
Message-ID: <20250826110917.779832377@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit ca22da2fbd693b54dc8e3b7b54ccc9f7e9ba3640 ]

William reports kernel soft-lockups on some OVS topologies when TC mirred
egress->ingress action is hit by local TCP traffic [1].
The same can also be reproduced with SCTP (thanks Xin for verifying), when
client and server reach themselves through mirred egress to ingress, and
one of the two peers sends a "heartbeat" packet (from within a timer).

Enqueueing to backlog proved to fix this soft lockup; however, as Cong
noticed [2], we should preserve - when possible - the current mirred
behavior that counts as "overlimits" any eventual packet drop subsequent to
the mirred forwarding action [3]. A compromise solution might use the
backlog only when tcf_mirred_act() has a nest level greater than one:
change tcf_mirred_forward() accordingly.

Also, add a kselftest that can reproduce the lockup and verifies TC mirred
ability to account for further packet drops after TC mirred egress->ingress
(when the nest level is 1).

 [1] https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aae226.1663945716.git.dcaratti@redhat.com/
 [2] https://lore.kernel.org/netdev/Y0w%2FWWY60gqrtGLp@pop-os.localdomain/
 [3] such behavior is not guaranteed: for example, if RPS or skb RX
     timestamping is enabled on the mirred target device, the kernel
     can defer receiving the skb and return NET_RX_SUCCESS inside
     tcf_mirred_forward().

Reported-by: William Zhao <wizhao@redhat.com>
CC: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ skulkarni: Adjusted patch for file 'tc_actions.sh' wrt the mainline commit ]
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_mirred.c                               |    7 ++
 tools/testing/selftests/net/forwarding/tc_actions.sh |   48 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -206,12 +206,19 @@ release_idr:
 	return err;
 }
 
+static bool is_mirred_nested(void)
+{
+	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
+}
+
 static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
 {
 	int err;
 
 	if (!want_ingress)
 		err = dev_queue_xmit(skb);
+	else if (is_mirred_nested())
+		err = netif_rx(skb);
 	else
 		err = netif_receive_skb(skb);
 
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -3,7 +3,7 @@
 
 ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
 	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
-	gact_trap_test"
+	gact_trap_test mirred_egress_to_ingress_tcp_test"
 NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
@@ -153,6 +153,52 @@ gact_trap_test()
 	log_test "trap ($tcflags)"
 }
 
+mirred_egress_to_ingress_tcp_test()
+{
+	local tmpfile=$(mktemp) tmpfile1=$(mktemp)
+
+	RET=0
+	dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$tmpfile
+	tc filter add dev $h1 protocol ip pref 100 handle 100 egress flower \
+		$tcflags ip_proto tcp src_ip 192.0.2.1 dst_ip 192.0.2.2 \
+			action ct commit nat src addr 192.0.2.2 pipe \
+			action ct clear pipe \
+			action ct commit nat dst addr 192.0.2.1 pipe \
+			action ct clear pipe \
+			action skbedit ptype host pipe \
+			action mirred ingress redirect dev $h1
+	tc filter add dev $h1 protocol ip pref 101 handle 101 egress flower \
+		$tcflags ip_proto icmp \
+			action mirred ingress redirect dev $h1
+	tc filter add dev $h1 protocol ip pref 102 handle 102 ingress flower \
+		ip_proto icmp \
+			action drop
+
+	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $tmpfile1  &
+	local rpid=$!
+	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$tmpfile
+	wait -n $rpid
+	cmp -s $tmpfile $tmpfile1
+	check_err $? "server output check failed"
+
+	$MZ $h1 -c 10 -p 64 -a $h1mac -b $h1mac -A 192.0.2.1 -B 192.0.2.1 \
+		-t icmp "ping,id=42,seq=5" -q
+	tc_check_packets "dev $h1 egress" 101 10
+	check_err $? "didn't mirred redirect ICMP"
+	tc_check_packets "dev $h1 ingress" 102 10
+	check_err $? "didn't drop mirred ICMP"
+	local overlimits=$(tc_rule_stats_get ${h1} 101 egress .overlimits)
+	test ${overlimits} = 10
+	check_err $? "wrong overlimits, expected 10 got ${overlimits}"
+
+	tc filter del dev $h1 egress protocol ip pref 100 handle 100 flower
+	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
+	tc filter del dev $h1 ingress protocol ip pref 102 handle 102 flower
+
+	rm -f $tmpfile $tmpfile1
+	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}



