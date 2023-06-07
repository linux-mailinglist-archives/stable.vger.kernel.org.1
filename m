Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21E4725E6E
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjFGMQO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240343AbjFGMQH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA2E1FED
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2BA763E5B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E6C433D2;
        Wed,  7 Jun 2023 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686140161;
        bh=v/+YMbpr1kL7eOWX5DVuAFQOWCkNZZxMuxjDm8p5CWE=;
        h=Subject:To:Cc:From:Date:From;
        b=w/ag2PKGd8ZI6hQGHCWYDdQvWitijQixvlSvDPJ1MGLeqkpL4+DOVlVOAcaMMXYHc
         1WYLzTcz5BN8TPtC8DQVDmos4Iq3bg/SOf2XF2L5zG9QMbUHoZEC5Q5Ft1WM58VZQx
         FkQ+cb3WztB6eJBhrUctgfwansNUA7aLwPZfjS3I=
Subject: FAILED: patch "[PATCH] tracing/timerlat: Always wakeup the timerlat thread" failed to apply to 5.15-stable tree
To:     bristot@kernel.org, juri.lelli@redhat.com, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 07 Jun 2023 14:15:53 +0200
Message-ID: <2023060753-buggy-thirty-f85b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 632478a05821bc1c9b55c3a1dd0fb1be7bfa1acc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060753-buggy-thirty-f85b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

632478a05821 ("tracing/timerlat: Always wakeup the timerlat thread")
9c556e5a4dd5 ("tracing/timerlat: Do not wakeup the thread if the trace stops at the IRQ")
aa748949b4e6 ("tracing/timerlat: Notify IRQ new max latency only if stop tracing is set")
dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
15ca4bdb0327 ("tracing/osnoise: Split workload start from the tracer start")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 632478a05821bc1c9b55c3a1dd0fb1be7bfa1acc Mon Sep 17 00:00:00 2001
From: Daniel Bristot de Oliveira <bristot@kernel.org>
Date: Thu, 11 May 2023 18:32:01 +0200
Subject: [PATCH] tracing/timerlat: Always wakeup the timerlat thread

While testing rtla timerlat auto analysis, I reach a condition where
the interface was not receiving tracing data. I was able to manually
reproduce the problem with these steps:

  # echo 0 > tracing_on                 # disable trace
  # echo 1 > osnoise/stop_tracing_us    # stop trace if timerlat irq > 1 us
  # echo timerlat > current_tracer      # enable timerlat tracer
  # sleep 1                             # wait... that is the time when rtla
                                        # apply configs like prio or cgroup
  # echo 1 > tracing_on                 # start tracing
  # cat trace
  # tracer: timerlat
  #
  #                                _-----=> irqs-off
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| / _-=> migrate-disable
  #                              |||| /     delay
  #                              |||||            ACTIVATION
  #           TASK-PID      CPU# |||||   TIMESTAMP   ID            CONTEXT                 LATENCY
  #              | |         |   |||||      |         |                  |                       |
        NOTHING!

Then, trying to enable tracing again with echo 1 > tracing_on resulted
in no change: the trace was still not tracing.

This problem happens because the timerlat IRQ hits the stop tracing
condition while tracing is off, and do not wake up the timerlat thread,
so the timerlat threads are kept sleeping forever, resulting in no
trace, even after re-enabling the tracer.

Avoid this condition by always waking up the threads, even after stopping
tracing, allowing the tracer to return to its normal operating after
a new tracing on.

Link: https://lore.kernel.org/linux-trace-kernel/1ed8f830638b20a39d535d27d908e319a9a3c4e2.1683822622.git.bristot@kernel.org

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index efbbec2caff8..e97e3fa5cbed 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1652,6 +1652,8 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 
+			wake_up_process(tlat->kthread);
+
 			return HRTIMER_NORESTART;
 		}
 	}

