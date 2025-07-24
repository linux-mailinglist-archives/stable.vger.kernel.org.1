Return-Path: <stable+bounces-164693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E270B111A7
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C521CE6AAA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD12ECD3F;
	Thu, 24 Jul 2025 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="CV/uJYJf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88822ECD17
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385248; cv=none; b=IcNXSXR9UvRJCs8mdG9FfbfcdnWLVT6loL1WHDPOSq1fnuU1P+MyPm6B2xQ8HI6RVGylIfVxXJ3dpAbHkK1sQA8wAj61cxmo1+ZRswB1tu54WYO7KcFiLnqgcDP4UQ0Ssh1OhommrRjbIi6hZr4XVnKLgyerSPlYIdSMb3flGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385248; c=relaxed/simple;
	bh=hNcQ6KKqjjOTeABklTnnC9bQ8L6VL4tpAET0KOPLJtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ke9RELmAi7uSQBJqC2piEubge3Jl3RJGq8hTlS1q8LzN0rOb/3O+XvwHt9SjaMg1iG+DOgjdJ2SmvWT+C7r0sn/KQguLB4TrGcMHUsNPmuIDHebSDgad3oPjDPYWD3QLVw6aK7nv1hvISptiYw23/ORhzvbWGPU31aPvSRJ4fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=CV/uJYJf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312f53d0609so38084a91.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385246; x=1753990046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpbHNnvgD/aUf8NdauErmsCRyfZ4UFIj+8EYCSThuys=;
        b=CV/uJYJfGT+6CdlgvYdLGi5c3rn9MfOMdvLbzoMnPaq9tCVIw8s5QqdN0a/IXphjmP
         I83HG6RDoLr/1BnHwYPZcGY7KgJWf6UmJSjInd2oBnyV7P5QgkA/yCePh8Jtgk7W8gbE
         +NZ6A3R5G0gJQuFVpGNYuS1RhZfPSnKr/U9k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385246; x=1753990046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpbHNnvgD/aUf8NdauErmsCRyfZ4UFIj+8EYCSThuys=;
        b=rBWJlKa8QdkBoKB6eK8v7rIwdIWsROevj0yErqeKEA0MLfkxSt2MZXCh6ESSSdDNTj
         n07EwIOd00L3unuS0EvFkvC3jlm0fbDh4OXcK/mE2mnvXIjsxeHR8l+XP80nTebVRtIh
         DgAoJFUyhJKC8yB5GiL1wgTws4FOO5B5l7mfQuCs/W7MIaqmQgI7tk3c70fqv5YVoLkO
         Ji2i5NlDN99tLhwJbsAr7JQHXGoqXFbJ/9mozqoiV7LatX+Myja8+xKe8IPHYIeYx2/m
         iiG35xaN+B3oqsTSTNeMVcH4JyZp5lql+uc8iLqLu2R+YXcDRrIe2thtbnxhyxZGI+/D
         8mtQ==
X-Gm-Message-State: AOJu0YzO5ynlG/h6BXkfVEy2z41emAapyHxvk0VzpKc4nLtsaGnSyO1p
	RFvqHCMM4krc30+5+lLg0phvI3rYchQJ2QIsZkRw0CyznmxAgnXow7QrFZzadS+/51DhJS4F4gL
	G38hCWKGSnQ==
X-Gm-Gg: ASbGnct/g7a4qrzyx+XfxoGOArSJD0QR06LCtpz4glT4bpcQnBCyux1V9SLp1+8DzQH
	VjUJZrYo8AQ56ZsdWs2ioOJKDGvc/exs4BCP3BTewNV2f1hLXr4HEm6IScPsUjkHaTjdQeXJkqO
	1v8MRPPBqFvc24vrEf2FRqNA/uIx91zXx0Huy1pqzbC+SfI2XuvjCSkcX1LHiqI067eSvrQB8MH
	FQRWUEyh633AdAhwuYLr9Vdwpj3YNlU5D5XUf8IsB5t73XEHt5/H4+8BSPGQlKUBNGgQvi0OOVT
	9D9atAo4QBQX+IPu3ulBP95zaMwxcsbY9rjCFUgewyWeNF6rkOHEGGeMWfQmSSc7Krf3Now85i4
	rCXpi1DfQ5zc3Cb1+UxMhSdfOk5IqvLbPFMgb38gYIZuS
X-Google-Smtp-Source: AGHT+IHbtLKWRqh9mvgZxP0kkcW+cggbS4HZRYHtje4zSzkC114FjzeYeQOM4gN5L5WwqOPVTW7iJA==
X-Received: by 2002:a17:90b:4d0e:b0:312:e987:11b0 with SMTP id 98e67ed59e1d1-31e507e5473mr4311938a91.6.1753385245745;
        Thu, 24 Jul 2025 12:27:25 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:27:25 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Davide Caratti <dcaratti@redhat.com>,
	William Zhao <wizhao@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 8/8] act_mirred: use the backlog for nested calls to mirred ingress
Date: Fri, 25 Jul 2025 00:56:19 +0530
Message-Id: <20250724192619.217203-9-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724192619.217203-1-skulkarni@mvista.com>
References: <20250724192619.217203-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/sched/act_mirred.c                        |  7 +++
 .../selftests/net/forwarding/tc_actions.sh    | 48 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5181eac5860e..f1392de686ba 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -206,12 +206,19 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
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
 
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index d9eca227136b..1e27031288c8 100755
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
-- 
2.25.1


