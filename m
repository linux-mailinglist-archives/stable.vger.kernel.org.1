Return-Path: <stable+bounces-124139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABFA5DA6C
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C661882E62
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB123C8C9;
	Wed, 12 Mar 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMC0ztDX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B44238D34
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775371; cv=none; b=iINIAL9USYa+1LAuLib8DCKeRNNA2QV3ipskeSWey1PD/dZ0yiQSLL7UmurErk3tLnph4cgIq+jz2dPkBA8/njp50ZU8h9WFs7Zswu2pKHbWQmY7dp37g76eAvsePuXOXFWmoH1YJ8ACa+sZFed7lS0xUkQuGz7NvD/W8CVjzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775371; c=relaxed/simple;
	bh=7XDC3XUsFUb3OvFFjw+XGIUSCyN7dv4m+tq7GtM6H00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LvTp2pLe4c0EZZbyfd60pCeyX1eFtdhCFSaJvHQTyu3cfAQUwlOs16ij5eoMWwRLpbCWXhsu+XZkpvQfm0HFtgoHrqM2zdBcnVPGOByX8bRzXBF5xeFNQ9KWbIjmBZpjePJS0y69vGXY1533FV9XhZZY6LCRClFG6jjySptMW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMC0ztDX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf251025aso51353431fa.1
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775367; x=1742380167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtIKzf1AYQYJxPgBXn2A2UD0WsXsukJsLv2YBV2DX/s=;
        b=CMC0ztDXkqnAXDJHKI/ADx0K4QP3gr7zhiq9ehkwE99dCPw5UW+qigZGTOl5HqvIyJ
         IeqO7DAErabMtQc5rGjukyk3FmyfTy53khjpBUY/zdKIYWreHYYjZcKBGAJr/7bSoVFB
         r/iHE0AywLVFrj+3Cw1QLE87AhaVedIQXWsJvYhOoWHx5jgOMV6iyfLNoWIaMFxtqLb5
         vktyw2A9QDrWKwCjsxuzg6oACaXxWFjOM4mtHvhtDggxR4Fj/SS0RLW4KWofpX7zDinW
         gcFp+mpDaxXPS+0XvWpKupueh4wKf9LLEqqGGJDCdD0he32RGm1HqFGew5j25kcxPwtB
         do8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775367; x=1742380167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtIKzf1AYQYJxPgBXn2A2UD0WsXsukJsLv2YBV2DX/s=;
        b=lpw1LHfH99U2FMiZsPFw0PJIQ3ZSNvFHA7gMicb51v3QZrVsPKMZ+d/zPFFXbc+Qtn
         hd6qF8zmapgPwfT+fEh0jtXDTTCP9MIRb3w3DI7euz9nFc9ORsbEkkhw4l/MmKbR0sw5
         LybkNCcdNDtoN+gpOCCifymt077kf366nyoAZlUooR0SEDYUyxFzcQhODa29kCAwSOCq
         vQhY1Xb8cqBCbshN4mI7UwdJlkhNBqs1xe3QOdsxPiovYhhIRHKVI0u6qKJZAczNQY5N
         fK/OVM2TAqn/6yYLcSF2pmZnxpXDfpAbPt1B2iraJRJgxv5hieTQJiI/DRJYzMBaCJ9r
         kVGw==
X-Gm-Message-State: AOJu0YylR4s6aDjdQnY1UGfk1Ku5OOihCtJKJATF/qUtDhma660vhpkp
	YXKNncMIb1PNpVJcq6LQWPqx9r1WjGlmyMVJA5n1T3JgM/+NiZBiBfeKIw==
X-Gm-Gg: ASbGncuSUiGJMzQRjeOdBpWEZ63xxzL8ibF73s0LkNFdCuFw396fdDK/geuKELga+nG
	DljvSQmFh/rjqdSOF/dn1mV1dYfbkG708LJCLzEQfnL17l6pvGfOGD9WQqDgKq+kjjjcRYu7qeM
	/MwU/RYBllFkujbk030OUz0tGApIE4BzBwe8i17ksgJ5qODZ0g73UNF61lX3VeVhXrApG9C1L3o
	mq+PBRh2RAYslhFYiKnIURveUIjaQkL5IsL9HQOe7ILiS0bZ/R0rec0j8h9h6Ienjr/hHhG2z7i
	DcZM5mjUH4LHn4L6jrJ/UkhZte4shN/3OJe+FSCS
X-Google-Smtp-Source: AGHT+IE1N02BobWmztaix4Q/+TUxontbZQ20W4MmbuM5LuK9Z37dHVXpAEYhNxFmFK6jd4v2eN2aSQ==
X-Received: by 2002:a05:6512:1112:b0:549:5850:f275 with SMTP id 2adb3069b0e04-54990ec8e60mr7192816e87.50.1741775366988;
        Wed, 12 Mar 2025 03:29:26 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae593besm2072747e87.97.2025.03.12.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:29:26 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Keith Busch <kbusch@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 6.12.y 6.13.y] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Date: Wed, 12 Mar 2025 11:29:24 +0100
Message-Id: <20250312102924.16247-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit dfd3df31c9db752234d7d2e09bef2aeabb643ce4 upstream.

Currently kvfree_rcu() APIs use a system workqueue which is
"system_unbound_wq" to driver RCU machinery to reclaim a memory.

Recently, it has been noted that the following kernel warning can
be observed:

<snip>
workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
  WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
  Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
  CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
  Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
  Workqueue: nvme-wq nvme_scan_work
  RIP: 0010:check_flush_dependency+0x112/0x120
  Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
  RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
  RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
  RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
  RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
  R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
  R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
  CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __warn+0xa4/0x140
   ? check_flush_dependency+0x112/0x120
   ? report_bug+0xe1/0x140
   ? check_flush_dependency+0x112/0x120
   ? handle_bug+0x5e/0x90
   ? exc_invalid_op+0x16/0x40
   ? asm_exc_invalid_op+0x16/0x20
   ? timer_recalc_next_expiry+0x190/0x190
   ? check_flush_dependency+0x112/0x120
   ? check_flush_dependency+0x112/0x120
   __flush_work.llvm.1643880146586177030+0x174/0x2c0
   flush_rcu_work+0x28/0x30
   kvfree_rcu_barrier+0x12f/0x160
   kmem_cache_destroy+0x18/0x120
   bioset_exit+0x10c/0x150
   disk_release.llvm.6740012984264378178+0x61/0xd0
   device_release+0x4f/0x90
   kobject_put+0x95/0x180
   nvme_put_ns+0x23/0xc0
   nvme_remove_invalid_namespaces+0xb3/0xd0
   nvme_scan_work+0x342/0x490
   process_scheduled_works+0x1a2/0x370
   worker_thread+0x2ff/0x390
   ? pwq_release_workfn+0x1e0/0x1e0
   kthread+0xb1/0xe0
   ? __kthread_parkme+0x70/0x70
   ret_from_fork+0x30/0x40
   ? __kthread_parkme+0x70/0x70
   ret_from_fork_asm+0x11/0x20
   </TASK>
  ---[ end trace 0000000000000000 ]---
<snip>

To address this switch to use of independent WQ_MEM_RECLAIM
workqueue, so the rules are not violated from workqueue framework
point of view.

Apart of that, since kvfree_rcu() does reclaim memory it is worth
to go with WQ_MEM_RECLAIM type of wq because it is designed for
this purpose.

Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
Reported-by: Keith Busch <kbusch@kernel.org>
Closes: https://lore.kernel.org/all/Z7iqJtCjHKfo8Kho@kbusch-mbp/
Cc: stable@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3e486ccaa4ca..8e52c1dd0628 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3191,6 +3191,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+static struct workqueue_struct *rcu_reclaim_wq;
+
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
 #define KFREE_N_BATCHES 2
@@ -3519,10 +3521,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	if (delayed_work_pending(&krcp->monitor_work)) {
 		delay_left = krcp->monitor_work.timer.expires - jiffies;
 		if (delay < delay_left)
-			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+			mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
 		return;
 	}
-	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+	queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
 }
 
 static void
@@ -3620,7 +3622,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 			// "free channels", the batch can handle. Break
 			// the loop since it is done with this CPU thus
 			// queuing an RCU work is _always_ success here.
-			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
+			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
 			WARN_ON_ONCE(!queued);
 			break;
 		}
@@ -3708,7 +3710,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_unbound_wq,
+			queue_delayed_work(rcu_reclaim_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
@@ -5662,6 +5664,10 @@ static void __init kfree_rcu_batch_init(void)
 	int i, j;
 	struct shrinker *kfree_rcu_shrinker;
 
+	rcu_reclaim_wq = alloc_workqueue("kvfree_rcu_reclaim",
+			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_reclaim_wq);
+
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
 		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
-- 
2.39.5


