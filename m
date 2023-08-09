Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8B775C8D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjHIL2a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjHIL23 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B01ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E1C632E6
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E2C433C7;
        Wed,  9 Aug 2023 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580508;
        bh=NRva10ZIBShEAi5TSu4+xKSXNmMVX7YncrUkNc/VV8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2K+FHNUs/LBmxKRz6OclRY0njgq3n0kQ+OBLq+uQhoQwYtJcc8ntGDTvhMYMEa/qX
         pupDBZnPpdL6U3HhjNOiOwm2L+kalu0yG5CMETcbyaWge3MthEH/VceIEYHAAkBse4
         zcqhm/Bao+Y+Jgw3O+3gWYXKSCGlGHUnC2SNcjdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 020/154] ftrace: Add information on number of page groups allocated
Date:   Wed,  9 Aug 2023 12:40:51 +0200
Message-ID: <20230809103637.613281653@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit da537f0aef1372c5204356a7df06be8769467b7b ]

Looking for ways to shrink the size of the dyn_ftrace structure, knowing the
information about how many pages and the number of groups of those pages, is
useful in working out the best ways to save on memory.

This adds one info print on how many groups of pages were used to allocate
the ftrace dyn_ftrace structures, and also shows the number of pages and
groups in the dyn_ftrace_total_info (which is used for debugging).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 26efd79c4624 ("ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 14 ++++++++++++++
 kernel/trace/trace.c  | 21 +++++++++++++++------
 kernel/trace/trace.h  |  2 ++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8e3c76dcc0ffe..97d615988ea35 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2899,6 +2899,8 @@ static void ftrace_shutdown_sysctl(void)
 
 static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
+unsigned long		ftrace_number_of_pages;
+unsigned long		ftrace_number_of_groups;
 
 static inline int ops_traces_mod(struct ftrace_ops *ops)
 {
@@ -3023,6 +3025,9 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		goto again;
 	}
 
+	ftrace_number_of_pages += 1 << order;
+	ftrace_number_of_groups++;
+
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
 	pg->size = cnt;
 
@@ -3078,6 +3083,8 @@ ftrace_allocate_pages(unsigned long num_to_init)
 		start_pg = pg->next;
 		kfree(pg);
 		pg = start_pg;
+		ftrace_number_of_pages -= 1 << order;
+		ftrace_number_of_groups--;
 	}
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
@@ -5873,6 +5880,8 @@ void ftrace_release_mod(struct module *mod)
 		free_pages((unsigned long)pg->records, order);
 		tmp_page = pg->next;
 		kfree(pg);
+		ftrace_number_of_pages -= 1 << order;
+		ftrace_number_of_groups--;
 	}
 }
 
@@ -6214,6 +6223,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 			*last_pg = pg->next;
 			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
 			free_pages((unsigned long)pg->records, order);
+			ftrace_number_of_pages -= 1 << order;
+			ftrace_number_of_groups--;
 			kfree(pg);
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
@@ -6269,6 +6280,9 @@ void __init ftrace_init(void)
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
 
+	pr_info("ftrace: allocated %ld pages with %ld groups\n",
+		ftrace_number_of_pages, ftrace_number_of_groups);
+
 	set_ftrace_early_filters();
 
 	return;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7f7c700a61560..8006592803e1c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7662,14 +7662,23 @@ static ssize_t
 tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		  size_t cnt, loff_t *ppos)
 {
-	unsigned long *p = filp->private_data;
-	char buf[64]; /* Not too big for a shallow stack */
+	ssize_t ret;
+	char *buf;
 	int r;
 
-	r = scnprintf(buf, 63, "%ld", *p);
-	buf[r++] = '\n';
+	/* 256 should be plenty to hold the amount needed */
+	buf = kmalloc(256, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
+		      ftrace_update_tot_cnt,
+		      ftrace_number_of_pages,
+		      ftrace_number_of_groups);
+
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	kfree(buf);
+	return ret;
 }
 
 static const struct file_operations tracing_dyn_info_fops = {
@@ -8889,7 +8898,7 @@ static __init int tracer_init_tracefs(void)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	trace_create_file("dyn_ftrace_total_info", 0444, d_tracer,
-			&ftrace_update_tot_cnt, &tracing_dyn_info_fops);
+			NULL, &tracing_dyn_info_fops);
 #endif
 
 	create_trace_instances(d_tracer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index edc17a640ab34..21f85c0bd66ec 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -801,6 +801,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_update_tot_cnt;
+extern unsigned long ftrace_number_of_pages;
+extern unsigned long ftrace_number_of_groups;
 void ftrace_init_trace_array(struct trace_array *tr);
 #else
 static inline void ftrace_init_trace_array(struct trace_array *tr) { }
-- 
2.39.2



