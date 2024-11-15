Return-Path: <stable+bounces-93208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CD9CD7ED
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA57B258D7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30B153800;
	Fri, 15 Nov 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oLe0i7WY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950F29A9;
	Fri, 15 Nov 2024 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653151; cv=none; b=h5GWEo/RTOzWddEgIFwc/V10c/gamoQnJCoanlq73WkBYbg/DkUqz1MtgXotQB16ioekMOtySYYb3MYypTRlbtm2FJVtJG5jnqhaX5Jf2W+qWwDQv84VG6mASmlcDaa2Riy0dpOKW4qHp8yYWmxBTxZw6ibebt7PXr2HHQMBAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653151; c=relaxed/simple;
	bh=5XodOKaLVCr94qH/ZD89pJjco8QeVhdOHMQSP6+0MzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcuq2OHWFWdGuvNhs5XZcOAnJIFlY5M0wBz7SaxcYX6gHAgGi3bkOCKgU6jH0r6lvNvOcxFTzgs8QZKqQg57l7cuHW/t9aL7igYdP5jZ2eIsiI6bHX1RcgVLbqSNPIaTpS/pqB9zmS9Rx7rPpptcfWiQKjw/0T0oIJnazOrrdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oLe0i7WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F5C4CECF;
	Fri, 15 Nov 2024 06:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653151;
	bh=5XodOKaLVCr94qH/ZD89pJjco8QeVhdOHMQSP6+0MzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLe0i7WY6YM0fWORJSvYKrPjKzY4XGzCw0b0aHIsN+ZePor4i4l70eE0X1M/WBHky
	 BSW9M0t9D4urx2gZb0zt+D30gMkwSLxqy9DPiTzLhIgGjKROtITkGjdqEyhelhHKqA
	 bS6CXxK7ke4TF1gAL3CcV/lZZORFHiVSCrfr49Fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Hagar Hemdan <hagarhem@amazon.com>
Subject: [PATCH 5.4 50/66] ftrace: Fix possible use-after-free issue in ftrace_location()
Date: Fri, 15 Nov 2024 07:37:59 +0100
Message-ID: <20241115063724.648039829@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

commit e60b613df8b6253def41215402f72986fee3fc8d upstream.

KASAN reports a bug:

  BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
  Read of size 8 at addr ffff888141d40010 by task insmod/424
  CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+
  [...]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x68/0xa0
   print_report+0xcf/0x610
   kasan_report+0xb5/0xe0
   ftrace_location+0x90/0x120
   register_kprobe+0x14b/0xa40
   kprobe_init+0x2d/0xff0 [kprobe_example]
   do_one_initcall+0x8f/0x2d0
   do_init_module+0x13a/0x3c0
   load_module+0x3082/0x33d0
   init_module_from_file+0xd2/0x130
   __x64_sys_finit_module+0x306/0x440
   do_syscall_64+0x68/0x140
   entry_SYSCALL_64_after_hwframe+0x71/0x79

The root cause is that, in lookup_rec(), ftrace record of some address
is being searched in ftrace pages of some module, but those ftrace pages
at the same time is being freed in ftrace_release_mod() as the
corresponding module is being deleted:

           CPU1                       |      CPU2
  register_kprobes() {                | delete_module() {
    check_kprobe_address_safe() {     |
      arch_check_ftrace_location() {  |
        ftrace_location() {           |
          lookup_rec() // USE!        |   ftrace_release_mod() // Free!

To fix this issue:
  1. Hold rcu lock as accessing ftrace pages in ftrace_location_range();
  2. Use ftrace_location_range() instead of lookup_rec() in
     ftrace_location();
  3. Call synchronize_rcu() before freeing any ftrace pages both in
     ftrace_process_locs()/ftrace_release_mod()/ftrace_free_mem().

Link: https://lore.kernel.org/linux-trace-kernel/20240509192859.1273558-1-zhengyejian1@huawei.com

Cc: stable@vger.kernel.org
Cc: <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>
Cc: <mathieu.desnoyers@efficios.com>
Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[Hagar: Modified to apply on v5.4.y]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ftrace.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1552,7 +1552,9 @@ unsigned long ftrace_location_range(unsi
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
@@ -1565,10 +1567,13 @@ unsigned long ftrace_location_range(unsi
 			      sizeof(struct dyn_ftrace),
 			      ftrace_cmp_recs);
 		if (rec)
-			return rec->ip;
+		{
+			ip = rec->ip;
+			break;
+		}
 	}
-
-	return 0;
+	rcu_read_unlock();
+	return ip;
 }
 
 /**
@@ -5736,6 +5741,8 @@ static int ftrace_process_locs(struct mo
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -5889,6 +5896,9 @@ void ftrace_release_mod(struct module *m
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -6196,6 +6206,7 @@ void ftrace_free_mem(struct module *mod,
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -6239,12 +6250,8 @@ void ftrace_free_mem(struct module *mod,
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -6261,6 +6268,11 @@ void ftrace_free_mem(struct module *mod,
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)



