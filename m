Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FCC7A7810
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjITJzJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjITJzC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:55:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F5C9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:54:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769AFC433C7;
        Wed, 20 Sep 2023 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203696;
        bh=FXbB/eeT2ITnbTWxWggCp4sEoOE9WjWBKlvsYgJ3iNE=;
        h=Subject:To:Cc:From:Date:From;
        b=oKgBPNRxzoH6UW7OcLwCqHQzJNh/XRHfziblHS3aSVtuIoKe0zRGK79K61eYYtOL+
         1rsE1qa6WeieYwlPyxmnh+o0Grvfb2Zh2h6z93Kvt1S99Cn4XRxZPnWKcug9B2o460
         s08QV7oiyW83ZNOx/8iJeD7FsSSKAZWM23POXRII=
Subject: FAILED: patch "[PATCH] tracing: Increase trace array ref count on enable and filter" failed to apply to 5.15-stable tree
To:     rostedt@goodmis.org, akpm@linux-foundation.org, lkft@linaro.org,
        mark.rutland@arm.com, mhiramat@kernel.org,
        naresh.kamboju@linaro.org, zhengyejian1@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:54:53 +0200
Message-ID: <2023092053-morphine-popcorn-8bb6@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f5ca233e2e66dc1c249bf07eefa37e34a6c9346a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092053-morphine-popcorn-8bb6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f5ca233e2e66 ("tracing: Increase trace array ref count on enable and filter files")
2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5ca233e2e66dc1c249bf07eefa37e34a6c9346a Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 6 Sep 2023 22:47:12 -0400
Subject: [PATCH] tracing: Increase trace array ref count on enable and filter
 files

When the trace event enable and filter files are opened, increment the
trace array ref counter, otherwise they can be accessed when the trace
array is being deleted. The ref counter keeps the trace array from being
deleted while those files are opened.

Link: https://lkml.kernel.org/r/20230907024803.456187066@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 8530dec63e7b4 ("tracing: Add tracing_check_open_get_tr()")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 35783a7baf15..0827037ee3b8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4973,6 +4973,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5669dd1f90d9..77debe53f07c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -610,6 +610,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed367d713be0..2af92177b765 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2103,9 +2103,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -2122,9 +2123,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 

