Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA4E7A3AE4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbjIQUKl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbjIQUKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:10:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF018E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:09:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5B2C433C8;
        Sun, 17 Sep 2023 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981391;
        bh=y1YLGwzjPaAU/g0LGvp+moHpiAowWfTz35z3U4WIVI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttklBqih7DIAikSieDFcl9HiYUE5R0sVCYnqVjmxlYAnZ1SColsmUmd/yaXSW+JyQ
         hEOPS8RLcAaBC8plBHdKvtlQWHNOz1piKLEmtydYK9f2kP6IPAvF+H1xoBqE6GQb+U
         qmSTfll+ORqYEUkg8mPLR+SCa2/w+kJ3BVX2sdBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 047/511] tracing: Introduce pipe_cpumask to avoid race on trace_pipes
Date:   Sun, 17 Sep 2023 21:07:54 +0200
Message-ID: <20230917191115.007309549@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit c2489bb7e6be2e8cdced12c16c42fa128403ac03 ]

There is race issue when concurrently splice_read main trace_pipe and
per_cpu trace_pipes which will result in data read out being different
from what actually writen.

As suggested by Steven:
  > I believe we should add a ref count to trace_pipe and the per_cpu
  > trace_pipes, where if they are opened, nothing else can read it.
  >
  > Opening trace_pipe locks all per_cpu ref counts, if any of them are
  > open, then the trace_pipe open will fail (and releases any ref counts
  > it had taken).
  >
  > Opening a per_cpu trace_pipe will up the ref count for just that
  > CPU buffer. This will allow multiple tasks to read different per_cpu
  > trace_pipe files, but will prevent the main trace_pipe file from
  > being opened.

But because we only need to know whether per_cpu trace_pipe is open or
not, using a cpumask instead of using ref count may be easier.

After this patch, users will find that:
 - Main trace_pipe can be opened by only one user, and if it is
   opened, all per_cpu trace_pipes cannot be opened;
 - Per_cpu trace_pipes can be opened by multiple users, but each per_cpu
   trace_pipe can only be opened by one user. And if one of them is
   opened, main trace_pipe cannot be opened.

Link: https://lore.kernel.org/linux-trace-kernel/20230818022645.1948314-1-zhengyejian1@huawei.com

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 55 ++++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.h |  2 ++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8769cd18f622f..92b381aab8f2b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6587,10 +6587,36 @@ tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 
 #endif
 
+static int open_pipe_on_cpu(struct trace_array *tr, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		if (cpumask_empty(tr->pipe_cpumask)) {
+			cpumask_setall(tr->pipe_cpumask);
+			return 0;
+		}
+	} else if (!cpumask_test_cpu(cpu, tr->pipe_cpumask)) {
+		cpumask_set_cpu(cpu, tr->pipe_cpumask);
+		return 0;
+	}
+	return -EBUSY;
+}
+
+static void close_pipe_on_cpu(struct trace_array *tr, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		WARN_ON(!cpumask_full(tr->pipe_cpumask));
+		cpumask_clear(tr->pipe_cpumask);
+	} else {
+		WARN_ON(!cpumask_test_cpu(cpu, tr->pipe_cpumask));
+		cpumask_clear_cpu(cpu, tr->pipe_cpumask);
+	}
+}
+
 static int tracing_open_pipe(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
+	int cpu;
 	int ret;
 
 	ret = tracing_check_open_get_tr(tr);
@@ -6598,13 +6624,16 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 		return ret;
 
 	mutex_lock(&trace_types_lock);
+	cpu = tracing_get_cpu(inode);
+	ret = open_pipe_on_cpu(tr, cpu);
+	if (ret)
+		goto fail_pipe_on_cpu;
 
 	/* create a buffer to store the information to pass to userspace */
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter) {
 		ret = -ENOMEM;
-		__trace_array_put(tr);
-		goto out;
+		goto fail_alloc_iter;
 	}
 
 	trace_seq_init(&iter->seq);
@@ -6627,7 +6656,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 
 	iter->tr = tr;
 	iter->array_buffer = &tr->array_buffer;
-	iter->cpu_file = tracing_get_cpu(inode);
+	iter->cpu_file = cpu;
 	mutex_init(&iter->mutex);
 	filp->private_data = iter;
 
@@ -6637,12 +6666,15 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 
 	tr->trace_ref++;
-out:
+
 	mutex_unlock(&trace_types_lock);
 	return ret;
 
 fail:
 	kfree(iter);
+fail_alloc_iter:
+	close_pipe_on_cpu(tr, cpu);
+fail_pipe_on_cpu:
 	__trace_array_put(tr);
 	mutex_unlock(&trace_types_lock);
 	return ret;
@@ -6659,7 +6691,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	if (iter->trace->pipe_close)
 		iter->trace->pipe_close(iter);
-
+	close_pipe_on_cpu(tr, iter->cpu_file);
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(iter->started);
@@ -9311,6 +9343,9 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
+	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+		goto out_free_tr;
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9352,6 +9387,7 @@ static struct trace_array *trace_array_create(const char *name)
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
+	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
@@ -9454,6 +9490,7 @@ static int __remove_instance(struct trace_array *tr)
 	}
 	kfree(tr->topts);
 
+	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
@@ -10164,12 +10201,14 @@ __init static int tracer_alloc_buffers(void)
 	if (trace_create_savedcmd() < 0)
 		goto out_free_temp_buffer;
 
+	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
+		goto out_free_savedcmd;
+
 	/* TODO: make the number of buffers hot pluggable with CPUS */
 	if (allocate_trace_buffers(&global_trace, ring_buf_size) < 0) {
 		MEM_FAIL(1, "tracer: failed to allocate ring buffer!\n");
-		goto out_free_savedcmd;
+		goto out_free_pipe_cpumask;
 	}
-
 	if (global_trace.buffer_disabled)
 		tracing_off();
 
@@ -10222,6 +10261,8 @@ __init static int tracer_alloc_buffers(void)
 
 	return 0;
 
+out_free_pipe_cpumask:
+	free_cpumask_var(global_trace.pipe_cpumask);
 out_free_savedcmd:
 	free_saved_cmdlines_buffer(savedcmd);
 out_free_temp_buffer:
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 43058077a4def..90ab921884b10 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -367,6 +367,8 @@ struct trace_array {
 	struct list_head	events;
 	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
+	/* one per_cpu trace_pipe can be opened by only one user */
+	cpumask_var_t		pipe_cpumask;
 	int			ref;
 	int			trace_ref;
 #ifdef CONFIG_FUNCTION_TRACER
-- 
2.40.1



