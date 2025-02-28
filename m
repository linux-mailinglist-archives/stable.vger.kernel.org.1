Return-Path: <stable+bounces-119936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C4A498F4
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2783BD957
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9C26B2C0;
	Fri, 28 Feb 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5j0GbqO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CC2512E4;
	Fri, 28 Feb 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744845; cv=none; b=tX7aetiEBVWZuQImFLTHmVccoUFITG55spGirp+51rfG8Y1Tj2kiDMpnEoEqoHFVH7e5X53z0szkOFOsKr38vONH0+/dzlLe8jSpYeqsdY3n9MCeTJqCds4kn2UKCsR/y76Gr9speH8ER3UyMRkYvMDCrRw6WLAr6Q4ko56eDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744845; c=relaxed/simple;
	bh=sPI0/4VZGmNNeeEBTgM25yhUxGKq5I/M70bt5OBJzNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4fPA1eZOwDna6XTzkysZk1eFbG8P2Z9BXY5UmwDyNWZW7yhthbcbByv1L74F+ldBAUKVEWwOMD+1aF6FFxjHi/+z+S3MTNfoSVEjS1lZgGeQbLW/0PUp7cgMCoMVk+P6vwo6m0ltrEyuOG4L/uZ265Xml5MudwCbNayk7NRqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5j0GbqO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54843052bcdso1832338e87.1;
        Fri, 28 Feb 2025 04:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740744840; x=1741349640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmfLoEbURepgZnFJrXzUMOPeijT6w0Yd6T6cBLnYL24=;
        b=e5j0GbqOBoNxm871MjDC5g277t8zTyuYzfKrJ5LbH3Ni45d2T8lhxwsxgLsfGoVQvw
         wBXlLhxWeYp0STxpAHrkbSsMiC5ZgWlvL1KbqrRJmfkrauJfitaiLq6ZhIkyrVmUCcE0
         5fIROe3RG372WjRsnfJs1SoTgbK86HJ+0+kzw8c5CAKSx3+ijh1iM2wfKjlQJoc1yML9
         Go0h39yjWiSRHWWod2KEi2ejsobUUw+obuTkKwNVtORDz32ayB8cmUQYKnGh0mstCWBh
         15C5HL1ycwaS86FQRB6uUqNHMendjDAWZNNn0ya6Wd4Nij+ei4NLXfiXV7mvtaWDUf5w
         U5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740744840; x=1741349640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmfLoEbURepgZnFJrXzUMOPeijT6w0Yd6T6cBLnYL24=;
        b=DeiEeVjRcyDVyKSQIrXPPJb6GMFQEHP3WU5fdRH2iWrDIFz49qBu4k02Z12qsiqN6b
         lCcrqb6gWTsyEuHtkAYWNrI5JhZY4iYEHMM4dVLYk86DJIVbEXNhZ6TaGinDzbFfS/7S
         DPG6eJ2ooTk8QECm6vV/JG1AnsOpJ6hHiXLdWhFyMVikwZXxhYUuAmtl7qowvHJ1d+4n
         YJV40xNeeSVPqVhwga4/UJYcENqWXhbzqtdeaP1zc+5k2VdTcB4Fhft3XJXeQvuqVr09
         D1TMxjjMLMtzqAp3RhdvhNWd+xBPVhokcvj3A569WaXq5jeKxZKDBZDvpThtREWvgFba
         dzrg==
X-Forwarded-Encrypted: i=1; AJvYcCUCFdKbgGlnpeu02o6UEZlN/5jFvzsGtp8ZM6bbw9r+M/jze+cMEfhEsXvlwlgwYKsufgtX3buFVD/pjLo=@vger.kernel.org, AJvYcCVHo1BHBVacwwGcs9Hk95iJGHoRQYfwHm+3y9BQCccqgs/TMU2zmPuz/8MAmZXt+k4U8YSep+xS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2cFM38lHcLAW+ytvYdy2NOnxMBPvPHPFqZ9S8k3wxs4hOSdvv
	71MprPDS8mYe/JdWzGEQqZlIPXIlzW3OVVKO4lwRUhhvph8uh+5Q
X-Gm-Gg: ASbGncsWcyA5lL2mjbLIm8kPMnTnfMQ2WX1afP0bKxAVjfFW/ihdq0mADxTlDiu7cCj
	jP55nLabap+qfXAthmkDMH3XyG5hpz+VyUGz/9wa24RryMbF3ogocBbB5kmEdhWRSlbSnnWM3s+
	k3n+18nKfP4T1tP+VGAS5h3Lk/C7K8Mk7zK9F96sh32a5wUUwYKMPl4Dbaw2izMvTXdQgH1H+dA
	qZ3ApD5h7s7T1sLaBFgsV5DzGZoyfcCLs4mMOe7xGSE4aDLhTgGdByETLMmmTFuRKvAVJ2uiN8s
	hy1Tp62JiJahxJnzn1D+mw==
X-Google-Smtp-Source: AGHT+IEXGMGMYueYdcrpqWDZP3Db10Z+3IUdwOgX1zq1vhWUt4E/pPLBdUzUf2huoovEztV/l2vIig==
X-Received: by 2002:a05:6512:1108:b0:549:3adf:89d8 with SMTP id 2adb3069b0e04-5494c368cb8mr1014440e87.53.1740744839988;
        Fri, 28 Feb 2025 04:13:59 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccfb7sm466768e87.230.2025.02.28.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:13:59 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v1 2/2] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Date: Fri, 28 Feb 2025 13:13:56 +0100
Message-Id: <20250228121356.336871-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228121356.336871-1-urezki@gmail.com>
References: <20250228121356.336871-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Cc: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Keith Busch <kbusch@kernel.org>
Closes: https://www.spinics.net/lists/kernel/msg5563270.html
Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/slab_common.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d..4c9f0a87f733 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
 static int rcu_delay_page_cache_fill_msec = 5000;
 module_param(rcu_delay_page_cache_fill_msec, int, 0444);
 
+static struct workqueue_struct *rcu_reclaim_wq;
+
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
 #define KFREE_N_BATCHES 2
@@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
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
@@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 			// "free channels", the batch can handle. Break
 			// the loop since it is done with this CPU thus
 			// queuing an RCU work is _always_ success here.
-			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
+			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
 			WARN_ON_ONCE(!queued);
 			break;
 		}
@@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_unbound_wq,
+			queue_delayed_work(rcu_reclaim_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
@@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
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


