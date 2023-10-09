Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6F17BDF47
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376704AbjJIN2R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjJIN2Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:28:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6658CF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:28:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36790C433C8;
        Mon,  9 Oct 2023 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858093;
        bh=p61anFBvsPWfFcP7ceyxg+XpqJva4Z3biqLFmmq6Td4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySwKoU0XW2btdroiHt5MmYIqsI9HgIn3U9Nv9BZVbtLqYqXSaPTU0TVZ1SW1X6XrR
         QUc9bq/MLcZI3hQKxlw1FaFqXSqjvKlOPpCpYrFECdBMelW0+SqpCXqBcB4WhbE+qZ
         8fvYIAFizqugDveWQIJ2OHLN3Q/u9quEpIGdVdyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/131] tracing: Increase trace array ref count on enable and filter files
Date:   Mon,  9 Oct 2023 15:00:43 +0200
Message-ID: <20231009130116.434248907@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit f5ca233e2e66dc1c249bf07eefa37e34a6c9346a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c        | 27 +++++++++++++++++++++++++++
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_events.c |  6 ++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9c64329ec154..85ad403006a20 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4244,6 +4244,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
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
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 21f85c0bd66ec..f1f54111b8561 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -680,6 +680,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0c21da12b650c..51adf0817ef3a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1699,9 +1699,10 @@ static const struct file_operations ftrace_set_event_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -1718,9 +1719,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
-- 
2.40.1



