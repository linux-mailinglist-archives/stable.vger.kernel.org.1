Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4E7A81B6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjITMr5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjITMrv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:47:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A191E5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:47:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F5C433CC;
        Wed, 20 Sep 2023 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214058;
        bh=SwlSIIf+48C1vGt0mvrqDecbcwuNBHQ5Nly46iX+Q5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4lVjzNrk+AG4uISLzUkJYWX7QCGUb4Pe9dsa0QEB4w9Ul2WQyCksM/p1p3ZH4eWv
         I4SY4Uapq8PX7psEh/EzP4OcsxwhNiqMzQ7SJQfZwnJdiT0PCXLBsW/Yx5zkvRDrLj
         VjMWbhm6dvVu/7XiLQd8+nfRgTauvLqzTrwQqQsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 097/110] tracing: Have tracing_max_latency inc the trace array ref count
Date:   Wed, 20 Sep 2023 13:32:35 +0200
Message-ID: <20230920112834.065899289@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 7d660c9b2bc95107f90a9f4c4759be85309a6550 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1716,7 +1716,7 @@ static void trace_create_maxlat_file(str
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 	tr->d_max_latency = trace_create_file("tracing_max_latency",
 					      TRACE_MODE_WRITE,
-					      d_tracer, &tr->max_latency,
+					      d_tracer, tr,
 					      &tracing_max_lat_fops);
 }
 
@@ -1749,7 +1749,7 @@ void latency_fsnotify(struct trace_array
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
+			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
 
@@ -6575,14 +6575,18 @@ static ssize_t
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
@@ -7648,10 +7652,11 @@ static const struct file_operations trac
 
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
 


