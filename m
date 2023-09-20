Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFD7A7809
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjITJyi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjITJyi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F387A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:54:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB46C433CA;
        Wed, 20 Sep 2023 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203671;
        bh=vm5X99nzEcOT3YSA0GNbP6svbuAjR7udzo0+gwUxjRg=;
        h=Subject:To:Cc:From:Date:From;
        b=xXj+wUrnXPbwllMyv6m0oKWp+SLd8PtvKEjqn4gZ4ggr1HFBf5CTwMbxIxFo4xues
         iqoyh2C962GDYfRJXbT2ohn3LvkxpyhhQfaHkF1pCDemhO2/Pr1SAdn5vdjkCLja+K
         YiWm5joF6TX90WBfnxmGpwXTLQydEaB2OA/nS0No=
Subject: FAILED: patch "[PATCH] tracing: Have tracing_max_latency inc the trace array ref" failed to apply to 5.4-stable tree
To:     rostedt@goodmis.org, akpm@linux-foundation.org, lkft@linaro.org,
        mark.rutland@arm.com, mhiramat@kernel.org,
        naresh.kamboju@linaro.org, zhengyejian1@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:54:20 +0200
Message-ID: <2023092020-recreate-account-e563@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7d660c9b2bc95107f90a9f4c4759be85309a6550
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092020-recreate-account-e563@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

7d660c9b2bc9 ("tracing: Have tracing_max_latency inc the trace array ref count")
21ccc9cd7211 ("tracing: Disable "other" permission bits in the tracefs files")
a955d7eac177 ("trace: Add timerlat tracer")
bce29ac9ce0b ("trace: Add osnoise tracer")
6880c987e451 ("tracing: Add LATENCY_FS_NOTIFY to define if latency_fsnotify() is defined")
8fa826b7344d ("trace/hwlat: Implement the mode config option")
f689e4f280b6 ("tracing: Define new ftrace event "func_repeats"")
f2cc020d7876 ("tracing: Fix various typos in comments")
2d396cb3b126 ("tracing: Do not create "enable" or "filter" files for ftrace event subsystem")
0c02006e6f5b ("tracing: Inline tracing_gen_ctx_flags()")
36590c50b2d0 ("tracing: Merge irqflags + preempt counter.")
09c0796adf0c ("Merge tag 'trace-v5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d660c9b2bc95107f90a9f4c4759be85309a6550 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 6 Sep 2023 22:47:13 -0400
Subject: [PATCH] tracing: Have tracing_max_latency inc the trace array ref
 count

The tracing_max_latency file points to the trace_array max_latency field.
For an instance, if the file is opened and the instance is deleted,
reading or writing to the file will cause a use after free.

Up the ref count of the trace_array when tracing_max_latency is opened.

Link: https://lkml.kernel.org/r/20230907024803.666889383@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Fixes: 8530dec63e7b4 ("tracing: Add tracing_check_open_get_tr()")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0827037ee3b8..c8b8b4c6feaf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1772,7 +1772,7 @@ static void trace_create_maxlat_file(struct trace_array *tr,
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 	tr->d_max_latency = trace_create_file("tracing_max_latency",
 					      TRACE_MODE_WRITE,
-					      d_tracer, &tr->max_latency,
+					      d_tracer, tr,
 					      &tracing_max_lat_fops);
 }
 
@@ -1805,7 +1805,7 @@ void latency_fsnotify(struct trace_array *tr)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
+			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
 
@@ -6717,14 +6717,18 @@ static ssize_t
 tracing_max_lat_read(struct file *filp, char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_read(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 static ssize_t
 tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 		      size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 #endif
@@ -7778,10 +7782,11 @@ static const struct file_operations tracing_thresh_fops = {
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_max_lat_read,
 	.write		= tracing_max_lat_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
 #endif
 

