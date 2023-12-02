Return-Path: <stable+bounces-3701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CAD801B67
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 09:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B04B20DF9
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB250C2FE;
	Sat,  2 Dec 2023 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9XM8KFj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AE2194
	for <stable@vger.kernel.org>; Sat,  2 Dec 2023 00:11:31 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b88f2a37deso1150191b6e.0
        for <stable@vger.kernel.org>; Sat, 02 Dec 2023 00:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701504690; x=1702109490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yIRlDxIAqwT+nu1uhAc0NB/BVaLKyGkWcHeEAbVGU4=;
        b=b9XM8KFj3AJDWPSs6aMjFsNa3gG6TKdipoB4vL8H1oofPrHOyFXe9lIh35gsi9tWsZ
         oAwBXW7QcqMbk/5AjmU82Ngs4nTw+DplskPwvcPbDBm+npr9hqyGeJSXc5Leau0I6xb+
         L2qM+unnE+8jxSSzjGdr/zQ9btrHx0+H1sgGrga4Dno/xT5PuaNB5jnfS27jpJIuIi4k
         Jd16K038kqYf/Kxa00TW6AIj4/WDn5bBlhZwnaxjF89O6SWGzNX6PkBSfVYnd2hSkVSm
         v+9b+hbOS577Ox3jEO4X9uPuar4UUO/xaIfACD10a5Sp6H/7StCm5I3OBFZSYZWlIhMX
         5RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701504690; x=1702109490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yIRlDxIAqwT+nu1uhAc0NB/BVaLKyGkWcHeEAbVGU4=;
        b=NGJITstwnsTMUTNNj2jHVNooJaKUV5ElHLUr9b0bzeqhg9moRtyJD2KSjirP3cDLOr
         9+OHF8cQrHBOgVs0RvvU1a2r+Y0oJ1OrnFq92vXcFHhNVv1Z4Oq7xpo+NOYKL/W2OIBZ
         FVvEfJdkEp1Jww+3Ujlur8JmP18PwA3q/huO4xrA1OMw3Te1A3k43D6FThPaj6uotia/
         yYEK6ajrAKwpDvH5Omyh5d8tBn8rGJetZH1LkBqRKMqjGF99FY29pXdgpa+4RG7xVN2L
         5u21hTLepItt+FmcmRG5nxFnzOPyJJZkwQK8SWp8NBChYO8AMoiV9SM+O24ImTBR3SAw
         i/cg==
X-Gm-Message-State: AOJu0YzdvTJEmNMd/zzDRCJ1JdV+qLa93b8hCuU9DFkNtcuM0j2d9a/n
	A9LanatG4xc3EU0sMUrqHCKQS/oklohI8g==
X-Google-Smtp-Source: AGHT+IHdnNgxNO4GfWsl2CYvb32/c1pPV/ulxrXwcca/EySS/BMr+WrIYtP2s0V1iKPFKSnrYMQgWw==
X-Received: by 2002:a05:6359:291:b0:170:17ea:f4f0 with SMTP id ek17-20020a056359029100b0017017eaf4f0mr737822rwb.61.1701504689885;
        Sat, 02 Dec 2023 00:11:29 -0800 (PST)
Received: from localhost.localdomain ([149.167.148.189])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001cc52ca2dfbsm4572949plc.120.2023.12.02.00.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 00:11:29 -0800 (PST)
From: Ronald Monthero <debug.penguin32@gmail.com>
To: stable@vger.kernel.org
Cc: patrick.wang.shcn@gmail.com,
	rostedt@goodmis.org,
	quic_neeraju@quicinc.com,
	paulmck@kernel.org,
	gregkh@linuxfoundation.org,
	Ronald Monthero <debug.penguin32@gmail.com>
Subject: [PATCH] rcu: Avoid tracing a few functions executed in stop machine
Date: Sat,  2 Dec 2023 18:11:13 +1000
Message-Id: <20231202081113.712803-1-debug.penguin32@gmail.com>
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

[upstream commit 48f8070f5dd8e13148ae4647780a452d53c457a2]
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

upstream commit:
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

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


