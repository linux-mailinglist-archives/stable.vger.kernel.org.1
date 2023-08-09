Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE3775777
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHIKqV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjHIKqV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F251702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF64B63120
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F3BC433C8;
        Wed,  9 Aug 2023 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577979;
        bh=A9fiAZf1GKr3yM3jKMASsu/H1mXQAcTLQlCQokl2hkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7pWoInqTdGJAYGHijwBzguPVJDmhfO3bkdtmvKKFw47yeJWfDem1SgziBiuYm1uv
         hR4DeO7VI1+ASrQVv92CB2wn19lPU/bmHoA+nZAlivrVc0bPzJyUTL0vFDtv2S67lW
         Yv8MW/DysmsyTmazQSk3fvCyDUu6amvu32NPEY0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH 6.4 061/165] net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
Date:   Wed,  9 Aug 2023 12:39:52 +0200
Message-ID: <20230809103644.812421061@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e739718444f7bf2fa3d70d101761ad83056ca628 ]

syzkaller found zero division error [0] in div_s64_rem() called from
get_cycle_time_elapsed(), where sched->cycle_time is the divisor.

We have tests in parse_taprio_schedule() so that cycle_time will never
be 0, and actually cycle_time is not 0 in get_cycle_time_elapsed().

The problem is that the types of divisor are different; cycle_time is
s64, but the argument of div_s64_rem() is s32.

syzkaller fed this input and 0x100000000 is cast to s32 to be 0.

  @TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME={0xc, 0x8, 0x100000000}

We use s64 for cycle_time to cast it to ktime_t, so let's keep it and
set max for cycle_time.

While at it, we prevent overflow in setup_txtime() and add another
test in parse_taprio_schedule() to check if cycle_time overflows.

Also, we add a new tdc test case for this issue.

[0]:
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 103 Comm: kworker/1:3 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:div_s64_rem include/linux/math64.h:42 [inline]
RIP: 0010:get_cycle_time_elapsed net/sched/sch_taprio.c:223 [inline]
RIP: 0010:find_entry_to_transmit+0x252/0x7e0 net/sched/sch_taprio.c:344
Code: 3c 02 00 0f 85 5e 05 00 00 48 8b 4c 24 08 4d 8b bd 40 01 00 00 48 8b 7c 24 48 48 89 c8 4c 29 f8 48 63 f7 48 99 48 89 74 24 70 <48> f7 fe 48 29 d1 48 8d 04 0f 49 89 cc 48 89 44 24 20 49 8d 85 10
RSP: 0018:ffffc90000acf260 EFLAGS: 00010206
RAX: 177450e0347560cf RBX: 0000000000000000 RCX: 177450e0347560cf
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000100000000
RBP: 0000000000000056 R08: 0000000000000000 R09: ffffed10020a0934
R10: ffff8880105049a7 R11: ffff88806cf3a520 R12: ffff888010504800
R13: ffff88800c00d800 R14: ffff8880105049a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0edf84f0e8 CR3: 000000000d73c002 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 <TASK>
 get_packet_txtime net/sched/sch_taprio.c:508 [inline]
 taprio_enqueue_one+0x900/0xff0 net/sched/sch_taprio.c:577
 taprio_enqueue+0x378/0xae0 net/sched/sch_taprio.c:658
 dev_qdisc_enqueue+0x46/0x170 net/core/dev.c:3732
 __dev_xmit_skb net/core/dev.c:3821 [inline]
 __dev_queue_xmit+0x1b2f/0x3000 net/core/dev.c:4169
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 neigh_resolve_output net/core/neighbour.c:1552 [inline]
 neigh_resolve_output+0x4a7/0x780 net/core/neighbour.c:1532
 neigh_output include/net/neighbour.h:544 [inline]
 ip6_finish_output2+0x924/0x17d0 net/ipv6/ip6_output.c:135
 __ip6_finish_output+0x620/0xaa0 net/ipv6/ip6_output.c:196
 ip6_finish_output net/ipv6/ip6_output.c:207 [inline]
 NF_HOOK_COND include/linux/netfilter.h:292 [inline]
 ip6_output+0x206/0x410 net/ipv6/ip6_output.c:228
 dst_output include/net/dst.h:458 [inline]
 NF_HOOK.constprop.0+0xea/0x260 include/linux/netfilter.h:303
 ndisc_send_skb+0x872/0xe80 net/ipv6/ndisc.c:508
 ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
 addrconf_dad_work+0xc14/0x13f0 net/ipv6/addrconf.c:4175
 process_one_work+0x92c/0x13a0 kernel/workqueue.c:2597
 worker_thread+0x60f/0x1240 kernel/workqueue.c:2748
 kthread+0x2fe/0x3f0 kernel/kthread.c:389
 ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:

Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Co-developed-by: Eric Dumazet <edumazet@google.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c                        | 15 +++++++++--
 .../tc-testing/tc-tests/qdiscs/taprio.json    | 25 +++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f681af138179c..97afa244e54f5 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1013,6 +1013,11 @@ static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
 							      TC_FP_PREEMPTIBLE),
 };
 
+static struct netlink_range_validation_signed taprio_cycle_time_range = {
+	.min = 0,
+	.max = INT_MAX,
+};
+
 static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] = {
 	[TCA_TAPRIO_ATTR_PRIOMAP]	       = {
 		.len = sizeof(struct tc_mqprio_qopt)
@@ -1021,7 +1026,8 @@ static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] = {
 	[TCA_TAPRIO_ATTR_SCHED_BASE_TIME]            = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_SCHED_SINGLE_ENTRY]         = { .type = NLA_NESTED },
 	[TCA_TAPRIO_ATTR_SCHED_CLOCKID]              = { .type = NLA_S32 },
-	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           = { .type = NLA_S64 },
+	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           =
+		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &taprio_cycle_time_range),
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_FLAGS]                      = { .type = NLA_U32 },
 	[TCA_TAPRIO_ATTR_TXTIME_DELAY]		     = { .type = NLA_U32 },
@@ -1157,6 +1163,11 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 			return -EINVAL;
 		}
 
+		if (cycle < 0 || cycle > INT_MAX) {
+			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
+			return -EINVAL;
+		}
+
 		new->cycle_time = cycle;
 	}
 
@@ -1345,7 +1356,7 @@ static void setup_txtime(struct taprio_sched *q,
 			 struct sched_gate_list *sched, ktime_t base)
 {
 	struct sched_entry *entry;
-	u32 interval = 0;
+	u64 interval = 0;
 
 	list_for_each_entry(entry, &sched->entries, list) {
 		entry->next_txtime = ktime_add_ns(base, interval);
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index a44455372646a..08d4861c2e782 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -131,5 +131,30 @@
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "3e1e",
+        "name": "Add taprio Qdisc with an invalid cycle-time",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@0 1@0 base-time 1000000000 sched-entry S 01 300000 flags 0x1 clockid CLOCK_TAI cycle-time 4294967296 || /bin/true",
+            "$IP link set dev $ETH up",
+            "$IP addr add 10.10.10.10/24 dev $ETH"
+        ],
+        "cmdUnderTest": "/bin/true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc taprio 1: root refcnt",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
-- 
2.40.1



