Return-Path: <stable+bounces-159310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DC8AF74E1
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C307AF4E2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443D292B25;
	Thu,  3 Jul 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htTeRnzZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C557C9F;
	Thu,  3 Jul 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547639; cv=none; b=lrvfeLS6LNjHB2tGIcakBsu7fFKg/JerLb6h8gKKomF6PON6RvZm+0ceHk1pMRRJyC1qeRQDGVBhDKQYiODGT9eekgZEprFJiT+Dt0UryVqyV2Q6vp4aqyr0TpAnemTGfiH4guF0jl/stVNQNclk4bLI4YJP9Vt4mmk6snCNk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547639; c=relaxed/simple;
	bh=WZkAFyjn/O80qVQ7Sb4assuy2vAO2IP9Wi6bKPzORVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkeVX/QS+QgZVTFWlxTllhfkDFuU3dR7ayORPQe95C1p/xkdoV+ewf8f/KXtWxC53dO38qCbCImlvW9OEWf8hDmipN5GqMcN7p4b7ojNtyzfLnfr7fSc8bVNqhlzqdhTFXdD2h/hqIyLQYuuS99xxu8Y6UQItu6h4RL06UwoEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htTeRnzZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00easo67884365ad.1;
        Thu, 03 Jul 2025 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751547637; x=1752152437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+V9/b+CRzGm0ij32xv/mNYvSmebJP/k00QdwusN4ULA=;
        b=htTeRnzZZJY5SH48G3XeuvToGDkJMapkGOSQjvrfkDqFvPqUJKPow+0Vo8AInKV3h6
         nDV1QVwWUSBHVaJIaeD44yR/r2KAqyQqjeCF4mbGA7u/U+TA+KdrscIVazzYIxBAWOyC
         f++vhQgbVSn5Vc9dbQed3Eb45sRbBEfpL5JHIir4rc2GKiP7rhFhJBBToVvGIKZYLBgr
         q13qDj2Rb7jMx0m+KPaNTA5sVw2eHQMYzijv7fW51tDTyZmfO0b/ZQWSQANCZ0ujf2T+
         zAKcGw6gd/DnZFk74KNdTTjyhWjdOyKBa6/ebA+8dTvOn0RptZB7yrQ/5EMeKdcjWwfW
         +Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751547637; x=1752152437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+V9/b+CRzGm0ij32xv/mNYvSmebJP/k00QdwusN4ULA=;
        b=trMf+ozpmc0cZW/hph6FOg+znk//Ciuj7oqVVURmxBGsnJcAwvABsTtI410vccDcjL
         UyYIUKlwzYcS4RQFae5pJMOYPizoyCMHsRIq2Lm9DDoyEH0AIXr3dumknqkWojWEUg9A
         14r/daNNYi8Vh71rZLISNhnRH6Z4L7LcXAT/Kyx+iFaXthXtPVoEperW7bMcM1trPv1A
         vk+3D/b944dHVb2LpPDuqv83y4HKLyqBAwXUfXqsxetfG8HCD1F7dtb4mcPiflFC8DsS
         Go09rGkuUObnMxm1GVrV+CHcX/MFLJzpmwbtjIDen5SQiL9ArvNqMhWPDnX35kL/udpq
         Uweg==
X-Forwarded-Encrypted: i=1; AJvYcCXkMlchJIqaODm3K81VefWwomgEGurbUI5a5tUX9+NB9KvRC0lsL+el6z5RKRQrOv94rj819fPMC3OTtaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+8Ncu9l+KKak7veFxFB4LH6V21rU2N5AnOg6D6Y/mpmrabYO
	UacnAMg3FpOvKoO/qLbwCWQj2b7zyIVmpBvi8ECPXF4nMzJXh1gukMMyQiP3T9yS2pU=
X-Gm-Gg: ASbGncsvBMZ7SruLWJl/ce2OJs90TRoG8Pw/MzIFITR1ga8G+MJcd2hDuFEmhj/B/hQ
	1SyZWGw+bXlJ8HdMver5e+n5o7n+vpOEIhQOuN7ny6nW3fjg7X5mxIhNZvSyBNmXXu0MBKZJ2PJ
	9/rCKMbr3BfRIc+tP3ZoXOU1Sv/x8tndVF8nckZ1hVdtDx9ChpeDPTem3rWCBCxJqVR9oxv0grg
	GyGEUTKyv/Dvqf8dMbjhxhYVyXUNoHDiJBpxasR0y+wSscj+n2nfeMeaJ5G1BZ+cavKpyamrV4m
	cyWFsTSCNPIerVGxLlMx4P1p6Q9IDYwcoysPIl3YSXeAfBj+WmkOgJ7kvfz/Xldvld3hdYY4nu/
	b
X-Google-Smtp-Source: AGHT+IFnS4sUDe612i/mziOiSd8eMOHyas6kczjurdDjVmc8V2M7FS1CkSHh17LwoanozUJYLQIDPg==
X-Received: by 2002:a17:903:1a67:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23c795742fbmr52192025ad.0.1751547636725;
        Thu, 03 Jul 2025 06:00:36 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c71c3e272sm34161445ad.215.2025.07.03.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:00:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: urezki@gmail.com,
	akpm@linux-foundation.org,
	edumazet@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.15.y v2] mm/vmalloc: fix data race in show_numa_info()
Date: Thu,  3 Jul 2025 22:00:07 +0900
Message-ID: <20250703130007.16755-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5c5f0468d172ddec2e333d738d2a1f85402cf0bc upstream.

The following data-race was found in show_numa_info():

==================================================================
BUG: KCSAN: data-race in vmalloc_info_show / vmalloc_info_show

read to 0xffff88800971fe30 of 4 bytes by task 8289 on cpu 0:
 show_numa_info mm/vmalloc.c:4936 [inline]
 vmalloc_info_show+0x5a8/0x7e0 mm/vmalloc.c:5016
 seq_read_iter+0x373/0xb40 fs/seq_file.c:230
 proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
....

write to 0xffff88800971fe30 of 4 bytes by task 8287 on cpu 1:
 show_numa_info mm/vmalloc.c:4934 [inline]
 vmalloc_info_show+0x38f/0x7e0 mm/vmalloc.c:5016
 seq_read_iter+0x373/0xb40 fs/seq_file.c:230
 proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
....

value changed: 0x0000008f -> 0x00000000
==================================================================

According to this report,there is a read/write data-race because
m->private is accessible to multiple CPUs.  To fix this, instead of
allocating the heap in proc_vmalloc_init() and passing the heap address to
m->private, vmalloc_info_show() should allocate the heap.

Link: https://lkml.kernel.org/r/20250508165620.15321-1-aha310510@gmail.com
Fixes: 8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmalloc.c | 63 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 00cf1b575c89..3fb534dcf14d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3100,7 +3100,7 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 	/*
 	 * Before removing VM_UNINITIALIZED,
 	 * we should make sure that vm has proper values.
-	 * Pair with smp_rmb() in show_numa_info().
+	 * Pair with smp_rmb() in vread_iter() and vmalloc_info_show().
 	 */
 	smp_wmb();
 	vm->flags &= ~VM_UNINITIALIZED;
@@ -4934,28 +4934,29 @@ bool vmalloc_dump_obj(void *object)
 #endif
 
 #ifdef CONFIG_PROC_FS
-static void show_numa_info(struct seq_file *m, struct vm_struct *v)
-{
-	if (IS_ENABLED(CONFIG_NUMA)) {
-		unsigned int nr, *counters = m->private;
-		unsigned int step = 1U << vm_area_page_order(v);
 
-		if (!counters)
-			return;
+/*
+ * Print number of pages allocated on each memory node.
+ *
+ * This function can only be called if CONFIG_NUMA is enabled
+ * and VM_UNINITIALIZED bit in v->flags is disabled.
+ */
+static void show_numa_info(struct seq_file *m, struct vm_struct *v,
+				 unsigned int *counters)
+{
+	unsigned int nr;
+	unsigned int step = 1U << vm_area_page_order(v);
 
-		if (v->flags & VM_UNINITIALIZED)
-			return;
-		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
-		smp_rmb();
+	if (!counters)
+		return;
 
-		memset(counters, 0, nr_node_ids * sizeof(unsigned int));
+	memset(counters, 0, nr_node_ids * sizeof(unsigned int));
 
-		for (nr = 0; nr < v->nr_pages; nr += step)
-			counters[page_to_nid(v->pages[nr])] += step;
-		for_each_node_state(nr, N_HIGH_MEMORY)
-			if (counters[nr])
-				seq_printf(m, " N%u=%u", nr, counters[nr]);
-	}
+	for (nr = 0; nr < v->nr_pages; nr += step)
+		counters[page_to_nid(v->pages[nr])] += step;
+	for_each_node_state(nr, N_HIGH_MEMORY)
+		if (counters[nr])
+			seq_printf(m, " N%u=%u", nr, counters[nr]);
 }
 
 static void show_purge_info(struct seq_file *m)
@@ -4983,6 +4984,10 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	struct vmap_area *va;
 	struct vm_struct *v;
 	int i;
+	unsigned int *counters;
+
+	if (IS_ENABLED(CONFIG_NUMA))
+		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
 
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
@@ -4999,6 +5004,11 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			}
 
 			v = va->vm;
+			if (v->flags & VM_UNINITIALIZED)
+				continue;
+
+			/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
+			smp_rmb();
 
 			seq_printf(m, "0x%pK-0x%pK %7ld",
 				v->addr, v->addr + v->size, v->size);
@@ -5033,7 +5043,9 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			if (is_vmalloc_addr(v->pages))
 				seq_puts(m, " vpages");
 
-			show_numa_info(m, v);
+			if (IS_ENABLED(CONFIG_NUMA))
+				show_numa_info(m, v, counters);
+
 			seq_putc(m, '\n');
 		}
 		spin_unlock(&vn->busy.lock);
@@ -5043,19 +5055,14 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	 * As a final step, dump "unpurged" areas.
 	 */
 	show_purge_info(m);
+	if (IS_ENABLED(CONFIG_NUMA))
+		kfree(counters);
 	return 0;
 }
 
 static int __init proc_vmalloc_init(void)
 {
-	void *priv_data = NULL;
-
-	if (IS_ENABLED(CONFIG_NUMA))
-		priv_data = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
-
-	proc_create_single_data("vmallocinfo",
-		0400, NULL, vmalloc_info_show, priv_data);
-
+	proc_create_single("vmallocinfo", 0400, NULL, vmalloc_info_show);
 	return 0;
 }
 module_init(proc_vmalloc_init);
--

