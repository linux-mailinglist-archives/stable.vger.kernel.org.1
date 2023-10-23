Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F687D33E7
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJWLfL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjJWLfK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:35:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80CFD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:35:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1270C433C7;
        Mon, 23 Oct 2023 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060907;
        bh=D8t52LdpfQS9WbNpla/qgjU5Y8XdQ5S4fQDF0czsqx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYf8Z5/OlqycIXL0y6nXVUVJL2IunRFSFBCTzgM8edrgrkaHjalCLIVuv/qKdnvh6
         APt1yEOwcha0geDRfDGYs80PoBDTqMKStfCzx+U2Mcdt+teaUUyvAXgl6J5rPwmkPL
         VUpx//c2DL9q7/pBDIBggEB6p1CZSLZOzDr4d74o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ben Segall <bsegall@google.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATCH 5.15 001/137] lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default
Date:   Mon, 23 Oct 2023 12:55:58 +0200
Message-ID: <20231023104820.904026390@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

commit cc6003916ed46d7a67d91ee32de0f9138047d55f upstream.

In workloads where this_cpu operations are frequently performed,
enabling DEBUG_PREEMPT may result in significant increase in
runtime overhead due to frequent invocation of
__this_cpu_preempt_check() function.

This can be demonstrated through benchmarks such as hackbench where this
configuration results in a 10% reduction in performance, primarily due to
the added overhead within memcg charging path.

Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
of its potential impact on performance in some workloads.

hackbench-process-sockets
		      debug_preempt	 no_debug_preempt
Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*

Link: https://lkml.kernel.org/r/20230121033942.350387-1-42.hyeyoo@gmail.com
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ben Segall <bsegall@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Luiz Capitulino <luizcap@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/Kconfig.debug |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1226,13 +1226,16 @@ config DEBUG_TIMEKEEPING
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
-	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+	  This option has potential to introduce high runtime overhead,
+	  depending on workload as it triggers debugging routines for each
+	  this_cpu operation. It should only be used for debugging purposes.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT


