Return-Path: <stable+bounces-77081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A4985346
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEA61C236FF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E31155C98;
	Wed, 25 Sep 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bsNqwnPC"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E59155C9E
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247229; cv=none; b=BZWc8lVq7jiH2EvWSYvqpdgnaCRuIC7qU5ftd2sI/ZwMrzu6TZUXmuUqnGoHxSuhKO/0LiRhhytV8kcqx+F47a52jHHI8QUqU8LKCgJj5aL+aio+ccQy9svfxud9a/s8dvCwozEabF4ARPCE368jkkCvyUQhm0Vt+6V4roRUBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247229; c=relaxed/simple;
	bh=csK1+3FQxeqwT+kWCan2aSo2Vhaq89PesCbCgsxJviw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgpXgnAAGUuRpHslnuXw9ZdLNfExWUEpAmxSFV1m5/OGBD6x8jtJbLYeYJviLKELu5du/OxSosLvSrIqju+tqi/c5Cqg99YkttouDnKF5/zd81W36ZjAhA/OLKyrBcBxTOhNQChUXC0zgBcEsT67FbTlKF29kQcwO4gNiTaYSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bsNqwnPC; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e04801bb65so3307801b6e.0
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727247226; x=1727852026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP99Ku+a6IJXsn+8AEBbbuYDfnHxeFpoLL1XUmm2vQA=;
        b=bsNqwnPC5wCeafLP1QfKNCiA+VD36NVrJvc3xNaoo9mnrjJAg9CUvQVTAXWzJ74S/+
         vLAj/Ry4hjD7PlGPtl2SudtmN31UQi930fihcDkaLFSMHlCI5VwE4HwDqtW/8eoMNmKR
         0uF6W1CoDtKrsI3CIngWqq+H4DR9vuaP3taAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247226; x=1727852026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP99Ku+a6IJXsn+8AEBbbuYDfnHxeFpoLL1XUmm2vQA=;
        b=wEJ3NGVuw8Wns8K3YuikZEl3wmoq961M/7W6xvBE2NNd0eL744rN9WRXkUJYzyx12G
         mDkS7aQeJlv+1OQDZAMg14K6NTLStScmIIQn481QrUqWygz+HOHczUbMGzSOvYXt0wQy
         HSJbLYJLycJspK6Y2VGctkc3PhJwBnVAqfK+TqvDLHqKFo2gem45IqFNO8qi6xD7ReK+
         ONSJykG5IUPUqBp0yMWZkzcaIKAI5S7514kERjBC8AuIW+z/PipdnKfaeX5YOH/ip6LZ
         vEqGZ7jiovlZ9BpQZYed6dRYrT7YacuQ/NgA+rj3E8YcVPmLFlXJyTVCTe7mTzMcBR4K
         IxlQ==
X-Gm-Message-State: AOJu0YxcMjs6Ltsu+hZvQ3t26+8kEpSiruD2HsVTNn6OxfmJAK6zC5ad
	T2R07EntaVvZwn3KnRIdI9eUTkHGVSgEG9a7B8FfcELeTMUImcwP4YPYZoKd6lo9/igWiqCK5O5
	5IUEvnejbu789PYB0QpC9X8Uy470ITbnJhdYi3uxEwyYhugg5JaAjv58/Nr2ZtzAqQGhTwpQIGx
	1iJ/I/kd+1KMBjOeOjuANellbkM/qrxm4DI57vAYx9a5vAAWY=
X-Google-Smtp-Source: AGHT+IHoWUqsTosHKyrA0jfFvpKkB148Mv/L1s6g06uFRkgf7hEk4lI7klp+SGwtK/lNUD8ehoE7Mg==
X-Received: by 2002:a05:6808:3a10:b0:3e0:1299:4dc with SMTP id 5614622812f47-3e29b7a0d21mr1308604b6e.25.1727247226229;
        Tue, 24 Sep 2024 23:53:46 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97b623sm2147203b3a.169.2024.09.24.23.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:53:45 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	jpoimboe@redhat.com,
	sashal@kernel.org,
	Zheng Yejian <zhengyejian1@huawei.com>,
	mark.rutland@arm.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2 v5.10] ftrace: Fix possible use-after-free issue in  ftrace_location()
Date: Tue, 24 Sep 2024 23:53:24 -0700
Message-Id: <20240925065324.121176-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
References: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit e60b613df8b6253def41215402f72986fee3fc8d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 kernel/trace/ftrace.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a781733b2a01..36182e7e0cd7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1566,12 +1566,15 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
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
@@ -1584,25 +1587,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
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
@@ -6331,6 +6331,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6513,6 +6515,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -6835,6 +6840,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -6878,12 +6884,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
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
@@ -6900,6 +6902,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
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
-- 
2.39.4


