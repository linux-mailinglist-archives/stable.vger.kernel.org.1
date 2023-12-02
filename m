Return-Path: <stable+bounces-3694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85234801B0F
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 07:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293A51F21164
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183F8C0B;
	Sat,  2 Dec 2023 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOtGTS2E"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA110F4
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 22:56:29 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fab887fab8so935692fac.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 22:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701500188; x=1702104988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plhJ6YHK8cj47+ydus8zBUtduES+Y83+LisP9zrOjQU=;
        b=JOtGTS2EnARlqDOTPkWWpzghQ8PgcyxtKT5uItz7Xnz3zVBsC53iEhN+b8RPyXrDNG
         o0Ie/bnE0ZChwq51+9vEvaTqFi026vGvh0pWrZaldgQbsS8Z0G2hRDjH8RVjKISNHN3Z
         y126Ezvr5jHta+knbB4DvM4BO4nQ8aPySf6J05VlfoQ0iqIjjoo0oyNhgyHPzVUXJ56P
         rOVTynReQ2lLi2dRS5Yf7VPmj6esoRk2hoNOLn+k96T03Qe7dF+Q6oAa4/QBoCjq7+Nf
         x1NVMFL9Vy7gAhogOOqCa+mx95dhg8gNP4ZF1VimB3BptWjjkHFo51in9CX9m9Nuc81c
         HPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701500188; x=1702104988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plhJ6YHK8cj47+ydus8zBUtduES+Y83+LisP9zrOjQU=;
        b=bY+vIGFUjq6xbBYwXCtJjqsXxvnr7yKVlX2wYoJNjzN+WPl/ZS5ylvRV9smunLf5Z6
         s97PadcYsnT1vNYG5wv5JxX7KyY6iCrZSqZydEML6Xf/VJgP1fq9WZhVNSuN57U22t/p
         FKOrSGqQQpUlUC0G6pmbYkHpyruOVRaBvqJ6n1H69tOGpZGVOjAyrKeS680oajKmZ4UW
         EOmlMP7MOKULDUbz1UcCSCjGTgJVJYtRtCoGdsV83lr1BP/a9+h5p3dm8H4cSyMNSpp6
         XQo21J0hCn6g/LfrJlqSF8M5+sW4iw0GkMVqLh1YbZMkU2QW5jgardvVuh/fz7bwhHlz
         OyOA==
X-Gm-Message-State: AOJu0YxGCaQ/qrX7kYfzxy+BfQcDkMSxyaQq+3dguYc/kgv/jfp2ACRn
	xrKL9j5PhaZN3lE5hexZX+Cc/RdInotHUQ==
X-Google-Smtp-Source: AGHT+IHYjtgjx2YzmTW+LRDTliVs+/6IdKaPL4F9dqmuwdw4U1lR9nlL/EGYvkWQKdk/9YtZcZEyfA==
X-Received: by 2002:a05:6870:63a5:b0:1fb:75c:3fef with SMTP id t37-20020a05687063a500b001fb075c3fefmr1035810oap.79.1701500188138;
        Fri, 01 Dec 2023 22:56:28 -0800 (PST)
Received: from localhost.localdomain ([149.167.148.189])
        by smtp.gmail.com with ESMTPSA id r10-20020a63ce4a000000b00588e8421fa8sm4145120pgi.84.2023.12.01.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 22:56:27 -0800 (PST)
From: Ronald Monthero <debug.penguin32@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Ronald Monthero <debug.penguin32@gmail.com>
Subject: [PATCH] rcu: Avoid tracing a few functions executed in stop machine
Date: Sat,  2 Dec 2023 16:56:16 +1000
Message-Id: <20231202065616.710903-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023112431-matching-imperfect-1b76@gregkh>
References: <2023112431-matching-imperfect-1b76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[upstream commit 48f8070f5dd8]
This backport patch for kernel 5.15v is derived from upstream
48f8070f5dd8. On 5.15 kernel it fixes recurring oops in context of rcu
detected stalls, indicated below.

log :
root@ls1021atwr:~# uname -r
5.15.93-rt58+ge0f69a158d5b
oops dump stack

** ID_531 main/smp_fsm.c:1884 <inrcu: INFO: rcu_preempt detected
stalls on CPUs/tasks:   <<< [1]
rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
        (detected by 1, t=2102 jiffies, g=12741, q=1154)
task:irq/31-arm-irq1 state:D stack: 0 pid:116 ppid:2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
[<8064bb01>] (schedule) from [<8064fa65>] (schedule_timeout+0x6d/0xa0)
[<8064fa65>] (schedule_timeout) from [<804ba353>]
(fsl_ifc_run_command+0x6f/0x178)
[<804ba353>] (fsl_ifc_run_command) from [<804ba72f>]
(fsl_ifc_cmdfunc+0x203/0x2b8)
[<804ba72f>] (fsl_ifc_cmdfunc) from [<804b135f>]
....
< snipped >

rcu: rcu_preempt kthread timer wakeup didn't happen for 764 jiffies!
g12741 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x1000
rcu:    Possible timer handling issue on cpu=0 timer-softirq=1095
rcu: rcu_preempt kthread starved for 765 jiffies! g12741 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x1000 ->cpu=0    <<< [2]
rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is
now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:D stack: 0 pid: 13 ppid:     2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064ba03>] (schedule_rtlock+0x1b/0x2e)
[<8064ba03>] (schedule_rtlock) from [<8064ea6f>]
(rtlock_slowlock_locked+0x93/0x108)
[<8064ea6f>] (rtlock_slowlock_locked) from [<8064eb1b>]
[<8064eb1b>] (rt_spin_lock) from [<8021b723>] (__local_bh_disable_ip+0x6b/0x110)
[<8021b723>] (__local_bh_disable_ip) from [<8025a90f>]
(del_timer_sync+0x7f/0xe0)
[<8025a90f>] (del_timer_sync) from [<8064fa6b>] (schedule_timeout+0x73/0xa0)
Exception stack(0x820fffb0 to 0x820ffff8)
rcu: Stack dump where RCU GP kthread last ran:
...
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
<  .. >

Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 kernel/rcu/tree_plugin.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d070059163d7..36ca6bacd430 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -458,7 +458,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * be quite short, for example, in the case of the call from
  * rcu_read_unlock_special().
  */
-static void
+static notrace void
 rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 {
 	bool empty_exp;
@@ -578,7 +578,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  * is disabled.  This function cannot be expected to understand these
  * nuances, so the caller must handle them.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
@@ -592,7 +592,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
  * evaluate safety in terms of interrupt, softirq, and preemption
  * disabling.
  */
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+static notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
 
@@ -922,7 +922,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * Because there is no preemptible RCU, there can be no deferred quiescent
  * states.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return false;
 }
-- 
2.34.1


