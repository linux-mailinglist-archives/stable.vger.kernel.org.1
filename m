Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B67A2591
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjIOSXT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjIOSWp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 14:22:45 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013013.outbound.protection.outlook.com [52.101.54.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45961FF5;
        Fri, 15 Sep 2023 11:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4SwpO6+bn7iTi1hpljoHsFr0joWdCJZL9npAK1M2d/96bT2Ii6q33ozm0YmZUNMH9+bWs/zol6Y08MWbxu4zH4oJJab0MaAVIoMELiX/UXlzUlAPVDciknsgnximuoAnMovuMl+AiQ+tZ9jlyOxkW7kzMysdYf7IFu0sxIEg9tSnLG3EqIN7KPNVhbYAcLyLz4VWd+GhHJr42uMcLxh6YKwcvR16aZP07O5eDiRQu74ILM13k4nOopGEWL7zdSKJwk1ORaq0wqpPrfYlKXw5zqs+xLJ0n16FigX0a9UUz3fs0aD9W9RE+Uf4GHKdkdxkVR9GgFntwl15qNsBzAXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbp3IUXsrQZVNeLMsyzH4BrFajG7k9Y9psteKCOtjpA=;
 b=T+D+2rwIUxG2zcKw+AO9kBEZJdMNDK3DbShSlvNaV/SBYOuQOTjs8uQuuFSVEaiH+6LWnjnC5oB/RlGnNsuH15SA04RjRSUl/upvjszmD3nS58HKIU/JKEi0p9THKxzH5bFxry1962D8D/2N/LvjAxmFglqPu6sdAn0l7kp1Cx2YaNUh8zcakUOpqXT0rOqGaAdxtovcVF0nyz0phPeHsjrueeZdcdmyUIkNETKKz09MnGOi+r+fNKtj09necoMyySRUJ437qtkoJOfQLCZBUA+W+o5aGwyeTe2RdLqlt5Ijl/ThXuj+TcSH/6ujPsByRdzS5Vqz+nCmsq4m4XapcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbp3IUXsrQZVNeLMsyzH4BrFajG7k9Y9psteKCOtjpA=;
 b=NeV9kAUjTqHAH4oVHSocusaDR/ZVJOD8Vic0HzWn6LWkcQvVoPxLey5a4gUcsu2FqpgwyJdVdVeOJ+PxNVHYk38gRlREiWqa2YTxj/afDVobbv+wth+938T91OHcdvttcsGw+wmUU8LpHENN3qas2+ZMwOCTcAOfANEfeqz9OtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8524.namprd05.prod.outlook.com (2603:10b6:303:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 18:22:32 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c%5]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 18:22:32 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     stable@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexanderduyck@fb.com, soheil@google.com,
        netdev@vger.kernel.org, namit@vmware.com, amakhalov@vmware.com,
        vsirnapalli@vmware.com, er.ajay.kaher@gmail.com, akaher@vmware.com,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6.1.y 4/4] net: deal with integer overflows in kmalloc_reserve()
Date:   Fri, 15 Sep 2023 23:51:05 +0530
Message-Id: <1694802065-1821-5-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694802065-1821-1-git-send-email-akaher@vmware.com>
References: <1694802065-1821-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: e670f593-d95a-495b-f6a5-08dbb618ba02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bdqXqSC9maJ+5u5b5/IClTDsWsFFO38UU8c9xhWIVpYOdiJPQDA+Pn16BIPc02XhRDK+ExVLEArYNAcNx9CI77gppXPyvMztysO80dnxwSrkfUaFr7PWSFvJmLKSu2P5f2l7OGbxZNzJeeO16/LSlRe94fpgNCZ/duaycfLxqiBmwqCmGuFlyMpClolwK20GQMiFX4W4SFC4zacjRtZE0xcO3KSqpNVi+EB8atuNbEZBgKaMhzyf1gQBvYMaUrVRBXsrPek4nburbLVqN4w19/tbD0EPzuKnj6K5eVOAZfWRicUuqs6ag0ntn2SIdnHRUkBB/RIFKNoGgmYYOVMw5zKFFZ5jdYdNMaoSXvGAvsCvtBfGOr/pLLY3zOLsDlnx2LazjB9zE/mC6/u+5jOArsTeUYPuU6OG+70NtXLgwE/5O2LoDidx3+pnV3kAL7b1wt//yWw9vIIskF1p9y02EhuGjf1OIZIXsOJXF3Y5dZclVk27bfrzbzMS1ipYbl0ahyOwKGbuLYeZAbgjchQ8prIHO8pZQfGaQKGNkVDVAkeyIRPRJnQLz8JOfRywWGcAzIuSd2sVWgNyG4npX8kCjAAEtUHJzApfCpPbffJLXozD0JdiW9jU+d3m4Wl1vyieSR9Wrfhd86fK/fbWqr3Tik9WvrHwWNgqiw5qaTIdRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(36756003)(86362001)(38350700002)(38100700002)(7416002)(6486002)(478600001)(5660300002)(52116002)(6506007)(66556008)(6666004)(8936002)(4326008)(2906002)(66946007)(8676002)(66476007)(54906003)(6512007)(83380400001)(316002)(26005)(6916009)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1YKHP9Sy7FofHMVyBLxMly8OWideOLeTbUbYG5phnyI3lHgzLlMU7J70mzu?=
 =?us-ascii?Q?lsy2pBLJD2XauruiFM19aFXg7PS+P4tsbo37CIMoL2IjpC6NGcdDM4gyqpYB?=
 =?us-ascii?Q?UZsGbJF7JFg3csTZp+GhWUp9svrRhU3VsSvr5lW9ig3QiiwZsP6CT1/O3QEx?=
 =?us-ascii?Q?TGdQQun+wjgCXlU9lq77ICP67BQeosB/SIx/NGFx8WJt4Qfrc04C/K8iPBV3?=
 =?us-ascii?Q?77/eYX5aJ9XF3Ga2D8At8bpGWixXbaeXX1sNyzLBRkq37hi6B4YkP/cAmX0F?=
 =?us-ascii?Q?k/edk8uZX0pka+FHJXOyylWnPVFwT+2YLLCG6x8uqptsoeTT0+OakVH7wItu?=
 =?us-ascii?Q?Uppg7qoCcCGZp20yMVpr6dKkFL5AYSKmKA1sY0k1NiAahlC3AZNpXVBcqfeG?=
 =?us-ascii?Q?LK2H2lvhI+4LweDxJBab0UIACoCFGYXYW4DcC30uEPSUUymCqLJPOnNR8ccC?=
 =?us-ascii?Q?QbU5BjXNSm0OdfCaAZttDiIJHztYJuDpwMlCKbO0zpY24lf+uND40QNMk/Rc?=
 =?us-ascii?Q?MJ7LpLk1jRydBLlnw1IlvQzyKtAVy0Rhj9xsz7VJ3BSUIFrM+rm/vZsixeHK?=
 =?us-ascii?Q?49kCEE9jgKptIRfDDerpAa1nl2NwPU1MU0QI+ZlFW/6tkzxsC+LmK1Wt9wVW?=
 =?us-ascii?Q?S92Vz+IN73KElcBhmsjYVni1l+o4SEiL7DdMhoYdRlUaQ7m+/a/erTrk5o7X?=
 =?us-ascii?Q?ssvXiKumDqtlJiP6ImnJKHFMM+2suNN0JJSTId6M3NEko1TBXtS02VjsJQif?=
 =?us-ascii?Q?VAlFLER3TcWr00J68IvRFZHbqKs+rtb0raMmTmElxT1QhVAeajc75YVeMewN?=
 =?us-ascii?Q?7RyHZowSIdNuYigKbnPAI8T1WJD1mDUadIXKaGQDHXENWbceAuvzpoKVQcso?=
 =?us-ascii?Q?yezyVOChmuHF3nb2e2uppsglArg5DKt3RqsOQlh8p/GCvobqF7Tzr7Z2gr/d?=
 =?us-ascii?Q?jKEv6JcXTS4OZeVkbUbu+SU8ktCEp1As9txroDEAXonoXPZTxxXtkNeaWvC/?=
 =?us-ascii?Q?0dQQ9svI9uPJ4mkLBHJcsZAFsNSpSRnuTFTGEGFiAZW0fcvPLSyo+2nPXlgO?=
 =?us-ascii?Q?LRe0JBk6gDCoQERU70MErOkb+/ByNMmO6M7orIjJ41xx9tEw6wmEvO6uHAEY?=
 =?us-ascii?Q?1mPOGXFax6c+7hFoMjX323ZFnFphyGqw0N56IbS2W8e11bjGAWEU9gBCG2a2?=
 =?us-ascii?Q?p3iPnKg8HkOYnAOsgQLv/vORfliH+dT9g81s/8ul2PK/dESMmITmSzjNxqu6?=
 =?us-ascii?Q?0JyqD+KgveZ6k00D73YIojp0nm+53hJfrT0p8pQlSDKoEutc6eFmQHA9suAa?=
 =?us-ascii?Q?O3Z014BF6typHPk9kh/3y5IrIVoHAUhNIDrWL2aey8UwKIjkkgWtbLnDQMo3?=
 =?us-ascii?Q?qcfCPAKjMzDsClbHPa5GO4UYfhR7xUv50vcAk6R7Ig+U16vthssTfaqiaKi4?=
 =?us-ascii?Q?+qQK+mbmu1uzK5SgT0Tyh7YAAVQDotfgU40gtcMryJLk+LKj3VmDhkdA6+OL?=
 =?us-ascii?Q?+m8ShGAnFQbl2Lit40zshpkSh3Hg2kFpFfYdYaift3aYFwoOtd/q7oN31SFX?=
 =?us-ascii?Q?+lxq536PAljAXVweCUbrVF07hPvsfhh4M91nm+rK?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e670f593-d95a-495b-f6a5-08dbb618ba02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:22:32.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av+cpBq1Nd7r9W8G5VpQ9U2DRM/pqh3b/lmxk7qZrXBPCurmqdvh0SXMhiwTHID5esrM32MsFArw+xOc91jb8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 915d975b2ffa58a14bfcf16fafe00c41315949ff upstream.

Blamed commit changed:
    ptr = kmalloc(size);
    if (ptr)
      size = ksize(ptr);

to:
    size = kmalloc_size_roundup(size);
    ptr = kmalloc(size);

This allowed various crash as reported by syzbot [1]
and Kyle Zeng.

Problem is that if @size is bigger than 0x80000001,
kmalloc_size_roundup(size) returns 2^32.

kmalloc_reserve() uses a 32bit variable (obj_size),
so 2^32 is truncated to 0.

kmalloc(0) returns ZERO_SIZE_PTR which is not handled by
skb allocations.

Following trace can be triggered if a netdev->mtu is set
close to 0x7fffffff

We might in the future limit netdev->mtu to more sensible
limit (like KMALLOC_MAX_SIZE).

This patch is based on a syzbot report, and also a report
and tentative fix from Kyle Zeng.

[1]
BUG: KASAN: user-memory-access in __build_skb_around net/core/skbuff.c:294 [inline]
BUG: KASAN: user-memory-access in __alloc_skb+0x3c4/0x6e8 net/core/skbuff.c:527
Write of size 32 at addr 00000000fffffd10 by task syz-executor.4/22554

CPU: 1 PID: 22554 Comm: syz-executor.4 Not tainted 6.1.39-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call trace:
dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:279
show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:286
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x120/0x1a0 lib/dump_stack.c:106
print_report+0xe4/0x4b4 mm/kasan/report.c:398
kasan_report+0x150/0x1ac mm/kasan/report.c:495
kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
memset+0x40/0x70 mm/kasan/shadow.c:44
__build_skb_around net/core/skbuff.c:294 [inline]
__alloc_skb+0x3c4/0x6e8 net/core/skbuff.c:527
alloc_skb include/linux/skbuff.h:1316 [inline]
igmpv3_newpack+0x104/0x1088 net/ipv4/igmp.c:359
add_grec+0x81c/0x1124 net/ipv4/igmp.c:534
igmpv3_send_cr net/ipv4/igmp.c:667 [inline]
igmp_ifc_timer_expire+0x1b0/0x1008 net/ipv4/igmp.c:810
call_timer_fn+0x1c0/0x9f0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers+0x54c/0x710 kernel/time/timer.c:1790
run_timer_softirq+0x28/0x4c kernel/time/timer.c:1803
_stext+0x380/0xfbc
____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:84
invoke_softirq kernel/softirq.c:437 [inline]
__irq_exit_rcu+0x1c0/0x4cc kernel/softirq.c:683
irq_exit_rcu+0x14/0x78 kernel/softirq.c:695
el0_interrupt+0x7c/0x2e0 arch/arm64/kernel/entry-common.c:717
__el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:724
el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:729
el0t_64_irq+0x1a0/0x1a4 arch/arm64/kernel/entry.S:584

Fixes: 12d6c1d3a2ad ("skbuff: Proactively round up to kmalloc bucket size")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Ajay: Regenerated the patch for v6.1.y]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 net/core/skbuff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fb8d100..8dca4a7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -428,11 +428,17 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 			     bool *pfmemalloc)
 {
 	bool ret_pfmemalloc = false;
-	unsigned int obj_size;
+	size_t obj_size;
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
-	*size = obj_size = kmalloc_size_roundup(obj_size);
+
+	obj_size = kmalloc_size_roundup(obj_size);
+	/* The following cast might truncate high-order bits of obj_size, this
+	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
+	 */
+	*size = (unsigned int)obj_size;
+
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
-- 
2.7.4

