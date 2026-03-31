Return-Path: <stable+bounces-232573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MlWD7YtzGkmQgYAu9opvQ
	(envelope-from <stable+bounces-232573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C317E371249
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B70C3047AD4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4D44E046;
	Tue, 31 Mar 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaTNlEKL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096B44E02A
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988639; cv=none; b=RLaTJzKB8PEDsBeOvCrI6iRIgBFKGu88m4B4TjFULNYJvyR9wffaz6Xb2lAAF0FTD7JAok3bp0Zt1SbrwwlaWDMVHysKQukAJSVS7/0LIrJq54V08B1RUpOoGScyoTmdtVYrcXuR6zBsmzjlzWQNtUZWhOWflVNMo23OPyAdxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988639; c=relaxed/simple;
	bh=+t8ikSPRD7DfscZ218WtPN+EojX0PBKH28/1MfyKklk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwUZo0yOiPtPcCDlijjbzfcxZ5KOEEkN9VBnqG320MO++qgdKm/up9W75+uC5lKe/8zTJOjUN7/Bo3W60saoKs5MlXiIE9dayN9hOZYsvF5EGgNdeuO648qYKAG0jogE/a6Fg5NHjG5O0U9222lOHw39oV1jTB69Oy5+Qvk7iH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaTNlEKL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38bd60d7a2cso58084681fa.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774988635; x=1775593435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gp8MmgexMa9kZc3iHEPrKAW8s9Qb4eG8gKB+d4t8Qx0=;
        b=VaTNlEKLnjwgivCe5NJq5TBgpbOPGyXu0oPOD3aJIeuNkP2wl626AcHc4XO2UJhyNV
         HF3KA2mOgnRfN3jTUxUji9dbYq6/CBPFQ+1v+xyBEsJjnP5m+7TtAiFBfYZIPV40ZCDm
         V6d240KUTif+UCw/al083cdw9tbDxcYDeONM4kmcGqV5cgTYSCueMC//Suyim8+CotKY
         lshW3N5JkRd7sC1cwlec4MgpkmMZLpXb256+pI/AZnGlx6pR3ZQmaQidFp+tGEFcKWEg
         HESkQKE+mO2jK+pf31yf43cpzf4zmopN3Nef7TEh1zW5eaJpNtTzinusDJ9Ts7Rfq1YI
         vJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774988635; x=1775593435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp8MmgexMa9kZc3iHEPrKAW8s9Qb4eG8gKB+d4t8Qx0=;
        b=exgabaT87qOo+ASj7Be/VbBvVg2OwqQo3VU66dxyWL5Et6Yfsn+AES59TWE2HP7R4L
         faywDnwyDyZsMv/yaZtbf/bXG7u2MPIwgLMsnF/BdhD5dTm6sZ89Fpii9ezf3fOa+3Tl
         g241ffoRvGbzeKUhs6L15Y4z/qdWd6lzE2/rjXVmeqbkmeq8blpsBVxttz4rg7YIL24D
         992Wkj8qMRvoB4+x7wf3rczZpVE3rqzVqcopo1K0jgakGsRUJaq4P6hRbHRlIQFiShhp
         i20h6zndj2meUrZlzaDc+Eo49CVsZQBNzrLVZZRX0saaHlBCrLgjsJQK88LbSfBW2ehr
         uU1w==
X-Forwarded-Encrypted: i=1; AJvYcCWdpMIcIuG+uj9zSEndq3+bQtaFJIZmZ+JTgsV9+Y4AJoM3L0ciFf/Im2t4pZFskdZ3UBtH8Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4HZHIL5TdbL89i6NAjYvx4UXx7N8H2POqkB/8lDLYn6oKbX6
	bcGSFfCXZkI9pAWB5z15fzIqsur52vdA9NQ/g4toRXCrU2a7ajCF2H2T
X-Gm-Gg: ATEYQzwOlt7myf2LlRO1e7DyEkUdg6IQTW5T8f0MRX4FI133ovar0wuJyS7bcSkEGlF
	pHZnKVtlyyQvk8RQzIb2J9fgpA+H06UWlgGEjPYJe1UF8X8S5VlYfKBBvhz110I3omCyXbu8CLs
	LnNYltAXltfrnImcuPsL0pVi/EhdCXCyp0az4QSLvCXZ0fES/b27mJS1I3MFry3Mk2jlgc0Rmnt
	pyupkRESPJ8/0/PQHGn36IH681h74Hck3brF+h/qrL4fqr4CekWlHgdu6HVmfpOk264L5U9S3lY
	Qg7XTtzw/eggPTuXnue4xSXUPrfVezVjAXclomNGqZi0y9sAnp6kb9jvz+VqH+Gk2G/giwbtGhL
	vmjCU+7+AIx2MOJXBoABQqbWVJOakbo9UFA043STMzrs4dVpQ2i2hZ9u2CsmjBTPjqyTGPV6Sgi
	+kNYRdCVehcs3qMA8=
X-Received: by 2002:a05:6512:1291:b0:5a2:7a31:9194 with SMTP id 2adb3069b0e04-5a2c1ef9aa4mr263563e87.19.1774988634449;
        Tue, 31 Mar 2026 13:23:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f4329sm2681171e87.3.2026.03.31.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:23:54 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	stable@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Subject: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for vmap drain
Date: Tue, 31 Mar 2026 22:23:52 +0200
Message-ID: <20260331202352.879718-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,baidu.com];
	TAGGED_FROM(0.00)[bounces-232573-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C317E371249
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

drain_vmap_area_work() function can take >10ms to complete
when there are many accumulated vmap areas in a system with
high CPU count, causing workqueue watchdog warnings when run
via schedule_work():

  workqueue: drain_vmap_area_work hogged CPU for >10000us

Move the top-level drain work to a dedicated WQ_UNBOUND
workqueue so the scheduler can run this background work
on any available CPU, improving responsiveness. Use the
WQ_MEM_RECLAIM to ensure forward progress under memory
pressure.

Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
workqueue. This allows drain_vmap_work to wait for helpers
completion without creating dependency on the same rescuer
thread and avoid a potential parent/child deadlock.

Simplify purge helper scheduling by removing cpumask-based
iteration to iterating directly over vmap nodes checking
work_queued state.

Cc: stable@vger.kernel.org
Cc: lirongqing <lirongqing@baidu.com>
Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
Link: https://lore.kernel.org/all/20260319074307.2325-1-lirongqing@baidu.com/
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 79 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61caa55a4402..0fa1208a910b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -949,6 +949,7 @@ static struct vmap_node {
 	struct list_head purge_list;
 	struct work_struct purge_work;
 	unsigned long nr_purged;
+	bool work_queued;
 } single;
 
 /*
@@ -1067,6 +1068,8 @@ static void reclaim_and_purge_vmap_areas(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static void drain_vmap_area_work(struct work_struct *work);
 static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
+static struct workqueue_struct *drain_vmap_helpers_wq;
+static struct workqueue_struct *drain_vmap_wq;
 
 static __cacheline_aligned_in_smp atomic_long_t nr_vmalloc_pages;
 static __cacheline_aligned_in_smp atomic_long_t vmap_lazy_nr;
@@ -2335,6 +2338,16 @@ static void purge_vmap_node(struct work_struct *work)
 	reclaim_list_global(&local_list);
 }
 
+static bool
+schedule_drain_vmap_work(struct workqueue_struct *wq,
+		struct work_struct *work)
+{
+	if (wq)
+		return queue_work(wq, work);
+
+	return false;
+}
+
 /*
  * Purges all lazily-freed vmap areas.
  */
@@ -2342,19 +2355,12 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
 		bool full_pool_decay)
 {
 	unsigned long nr_purged_areas = 0;
+	unsigned int nr_purge_nodes = 0;
 	unsigned int nr_purge_helpers;
-	static cpumask_t purge_nodes;
-	unsigned int nr_purge_nodes;
 	struct vmap_node *vn;
-	int i;
 
 	lockdep_assert_held(&vmap_purge_lock);
 
-	/*
-	 * Use cpumask to mark which node has to be processed.
-	 */
-	purge_nodes = CPU_MASK_NONE;
-
 	for_each_vmap_node(vn) {
 		INIT_LIST_HEAD(&vn->purge_list);
 		vn->skip_populate = full_pool_decay;
@@ -2374,10 +2380,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
 		end = max(end, list_last_entry(&vn->purge_list,
 			struct vmap_area, list)->va_end);
 
-		cpumask_set_cpu(node_to_id(vn), &purge_nodes);
+		nr_purge_nodes++;
 	}
 
-	nr_purge_nodes = cpumask_weight(&purge_nodes);
 	if (nr_purge_nodes > 0) {
 		flush_tlb_kernel_range(start, end);
 
@@ -2385,29 +2390,31 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
 		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
 		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
 
-		for_each_cpu(i, &purge_nodes) {
-			vn = &vmap_nodes[i];
+		for_each_vmap_node(vn) {
+			vn->work_queued = false;
+
+			if (list_empty(&vn->purge_list))
+				continue;
 
 			if (nr_purge_helpers > 0) {
 				INIT_WORK(&vn->purge_work, purge_vmap_node);
+				vn->work_queued = schedule_drain_vmap_work(
+					READ_ONCE(drain_vmap_helpers_wq), &vn->purge_work);
 
-				if (cpumask_test_cpu(i, cpu_online_mask))
-					schedule_work_on(i, &vn->purge_work);
-				else
-					schedule_work(&vn->purge_work);
-
-				nr_purge_helpers--;
-			} else {
-				vn->purge_work.func = NULL;
-				purge_vmap_node(&vn->purge_work);
-				nr_purged_areas += vn->nr_purged;
+				if (vn->work_queued) {
+					nr_purge_helpers--;
+					continue;
+				}
 			}
-		}
 
-		for_each_cpu(i, &purge_nodes) {
-			vn = &vmap_nodes[i];
+			/* Sync path. Process locally. */
+			purge_vmap_node(&vn->purge_work);
+			nr_purged_areas += vn->nr_purged;
+		}
 
-			if (vn->purge_work.func) {
+		/* Wait for completion if queued any. */
+		for_each_vmap_node(vn) {
+			if (vn->work_queued) {
 				flush_work(&vn->purge_work);
 				nr_purged_areas += vn->nr_purged;
 			}
@@ -2471,7 +2478,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 
 	/* After this point, we may free va at any time */
 	if (unlikely(nr_lazy > nr_lazy_max))
-		schedule_work(&drain_vmap_work);
+		schedule_drain_vmap_work(READ_ONCE(drain_vmap_wq),
+			&drain_vmap_work);
 }
 
 /*
@@ -5483,3 +5491,20 @@ void __init vmalloc_init(void)
 	vmap_node_shrinker->scan_objects = vmap_node_shrink_scan;
 	shrinker_register(vmap_node_shrinker);
 }
+
+static int __init vmalloc_init_workqueue(void)
+{
+	struct workqueue_struct *drain_wq, *helpers_wq;
+	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM;
+
+	drain_wq = alloc_workqueue("vmap_drain", flags, 0);
+	WARN_ON_ONCE(drain_wq == NULL);
+	WRITE_ONCE(drain_vmap_wq, drain_wq);
+
+	helpers_wq = alloc_workqueue("vmap_drain_helpers", flags, 0);
+	WARN_ON_ONCE(helpers_wq == NULL);
+	WRITE_ONCE(drain_vmap_helpers_wq, helpers_wq);
+
+	return 0;
+}
+early_initcall(vmalloc_init_workqueue);
-- 
2.47.3


