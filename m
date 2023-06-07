Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689E5726C30
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFGUbR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjFGUbQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB770FC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F4FB644F8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84086C433D2;
        Wed,  7 Jun 2023 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169873;
        bh=idbYBb7zBKSjJP8nvtJsCJqiIzRtKUunuEwsZECJIPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKkeAkMSCW/SiZG/NspfUhrXWpwUc0n5HvCPyBk2D3l5he4wZfqosc97EzG5reiBY
         OVSljphW6gQ5AzWfAL7m1VAvI8ldhgU7gvPNsgDychlxGY3k8pt1LIGYUdH/9P63+H
         /GlaruPmSsGh1VbcEc+gpgMNgcQJz4NGQE4heMJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.3 246/286] tracing/timerlat: Always wakeup the timerlat thread
Date:   Wed,  7 Jun 2023 22:15:45 +0200
Message-ID: <20230607200931.338456010@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

commit 632478a05821bc1c9b55c3a1dd0fb1be7bfa1acc upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_osnoise.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1652,6 +1652,8 @@ static enum hrtimer_restart timerlat_irq
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 
+			wake_up_process(tlat->kthread);
+
 			return HRTIMER_NORESTART;
 		}
 	}


