Return-Path: <stable+bounces-46575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4108D09D1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DA41C22005
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9D61FD2;
	Mon, 27 May 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snWMoT16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE51DA23
	for <stable@vger.kernel.org>; Mon, 27 May 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833814; cv=none; b=Jq0cirUJoGY9qe0MAeAGFm3kJKPixTm259I2LAT+9GRXg6JeZZOqBCHBhn5W3r2fWyEQPPytzmwg6DlUIWIzZvkrIFCrIDnt90vGHLJrE0lZkOrpDIErSQA6X7Q4nvHJJyvf7+vnC2PjhacKzIsQGECeM+RwxicZkfuUTM4ij44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833814; c=relaxed/simple;
	bh=2OWXwaPp+vMwImyFlyU9QQCmPMScI8OYwSyGO571Xr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hk5hrIJWLZISNkOlLOmolggPI3Zv/Cb9U3ruAACptEqe5Y2MLnNe1B+oVBmCxAOHnPxgw6+goUHloFyP/SiPDJgd5zlPUT6A9+BYF44LS1DY0VpbaB7B/iA7en5JfU5v9Y8sDEuY2GtIsZmYFfApJQaKbJeDFeCVs81+wpwwtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snWMoT16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE69C2BBFC;
	Mon, 27 May 2024 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716833814;
	bh=2OWXwaPp+vMwImyFlyU9QQCmPMScI8OYwSyGO571Xr0=;
	h=Subject:To:Cc:From:Date:From;
	b=snWMoT165/d5JVky7Xd1Ihs7COXHNknntC9l1l0Bx8WiufgjysXg0BTNQb/dM+gBN
	 wPH7k5eLrOzEECXQqI2AvFysIdgogtLXzTlc7i1SgmcLYOX5guQhBYaQjXZ73Yl1SM
	 w4OiQO86DMEhMabBkRGHnbdORCvPqI8CaSogpQEQ=
Subject: FAILED: patch "[PATCH] ftrace: Fix possible use-after-free issue in" failed to apply to 5.15-stable tree
To: zhengyejian1@huawei.com,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 May 2024 20:16:57 +0200
Message-ID: <2024052757-fantasy-resent-77c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e60b613df8b6253def41215402f72986fee3fc8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052757-fantasy-resent-77c6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e60b613df8b6253def41215402f72986fee3fc8d Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian1@huawei.com>
Date: Fri, 10 May 2024 03:28:59 +0800
Subject: [PATCH] ftrace: Fix possible use-after-free issue in
 ftrace_location()

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

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5a01d72f66db..2308c0a2fd29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1595,12 +1595,15 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	rec = lookup_rec(start, end);
 	if (rec)
-		return rec->ip;
+		ip = rec->ip;
+	rcu_read_unlock();
 
-	return 0;
+	return ip;
 }
 
 /**
@@ -1614,25 +1617,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	struct dyn_ftrace *rec;
+	unsigned long loc;
 	unsigned long offset;
 	unsigned long size;
 
-	rec = lookup_rec(ip, ip);
-	if (!rec) {
+	loc = ftrace_location_range(ip, ip);
+	if (!loc) {
 		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
 			goto out;
 
 		/* map sym+0 to __fentry__ */
 		if (!offset)
-			rec = lookup_rec(ip, ip + size - 1);
+			loc = ftrace_location_range(ip, ip + size - 1);
 	}
 
-	if (rec)
-		return rec->ip;
-
 out:
-	return 0;
+	return loc;
 }
 
 /**
@@ -6591,6 +6591,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6804,6 +6806,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -7137,6 +7142,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -7178,12 +7184,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
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
@@ -7200,6 +7202,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
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


