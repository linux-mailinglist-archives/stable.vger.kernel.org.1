Return-Path: <stable+bounces-159311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E5AF74E3
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A735627DF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56C57C9F;
	Thu,  3 Jul 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+cch1ye"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFDB652;
	Thu,  3 Jul 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547729; cv=none; b=pudsvk1jMixCy/YeL2/Atfeh2wnFYTzj83vxANXNviGCHO0ab5mG7EneVppecaMpLDP7+JpZ8VgJKp3HSXpnEF3oZmiNecCQHDSGd8Co5J95Pg5z5YJWb+fm5BPzIIv5XFa0pCjdJCCbR/uSsG2NCA0cxcR2tuQzbIwhTDFH9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547729; c=relaxed/simple;
	bh=TrGYughrHDhywCZQzuv7f57ns1JdlSyF4/JJubTYWo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhiJFlwH8xsXQfBcgPxeQnS2c8pKBbcjsTmMfFX9aDtSq0YtsCu8ZubqHAdiAt5L1G0aI9mTVsOQH9FjZ2IZFE1TzU2bYL+zAGMFbimjEjyurt9a0bFtCZFU8Q6PAE2a1sRHXG4ASags8/QQvELsyPvEh6zWI+fYRwTkTJHaBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+cch1ye; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23508d30142so66508445ad.0;
        Thu, 03 Jul 2025 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751547726; x=1752152526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suqxcEDNBCLHVH6MEYrG4k9pSxU63uJSQ0xDlxOIj8M=;
        b=Y+cch1yeiKHQsgW2vPTgX4MDe3wLS+bE3dwLTids92A5cQGKH+Yo4IJzX6AM//V/WO
         w+ZVPEvXAqs185QeQsT1Oz0RBVjsOMsBXBXLoPpodMdUYj9ChtBOvXap7+F1Ln2a8x2h
         RJigi1jJ9GSYOpxvyP1JFAQTnW94zWUhW7VtyN/d/y/TpwN+IcYjS2fFC4uNDUvKBxAc
         ZSrIFjILImYBHIxvAw2t+6B1poNVqLGAav7Lye0uHtxTt9MhUyHFRO5URgXcIx+lnFgT
         iAjsPcd3ri2sNiSKSEqNqGL7kgfz2rF7aEt91nbxn/z5u8GxE+cC5G2tdp6oWh5TDur1
         rh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751547726; x=1752152526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suqxcEDNBCLHVH6MEYrG4k9pSxU63uJSQ0xDlxOIj8M=;
        b=EhFlgYtF9MbEqu5BF4LQvqvJG2vdMaVvIOj4Am7PWQVQh5fFx2D6z4aD4yuh2Wwtrj
         ocrLl9kNW5I9ZHYaAAC3f6ZS1qsYJKh82J4k6dL26VE4ntbzbMqiyDgUUGHkwOWi9XDZ
         ZRTJGgj1k+zqNXmmlpGvvYzpwQoWmrCL7qL8MRbR/yg7PF1xZ+AdS9/MzPfvGzItCKR7
         jXeIiiJfH10g+IN7DkTxCNl5Vbluw+fqCURZoffD6g3ru4nmWMgpK8cD2UM04W/u/CLb
         GtiB8KXm/vPrOr9iA/Zzd8bj5iYNpV8ST+nLDqmPMSiRf9GBj0zPr/1uAR9TVOZsHedP
         8f9g==
X-Forwarded-Encrypted: i=1; AJvYcCVdwsW+g1MXZyrbIQmp0dUAsDbdPCMMCi5BjKL8IebzXkBza4Q+VRwjKmh9py+lP47uLb0W2tjuJuDOgXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlJKc5Dg2DcNQlJGdAwhC86mTZ8FJwwu/jNqofYeMEdQ5116A
	ye+nO7fwxrjJrTGZbm2VT7Sw+4z/cfPvg1znOPs9/JKQPKHreHFd1wumsATwne2im9s=
X-Gm-Gg: ASbGncv/nVabL+irCu4+xaJVnFc/UTgkvFnLPLa8qYlC2UWupOZy6mQMdqNxbqrCe8H
	Irtoc3pKTy5K+irUT3FSfCmcq64dUmqxLUgG1xPTfC1O4mvOlMV7+ZQZrxJhorEhHMg4Ww8yYpn
	V7Tw14nYI5wglN3or+UcaV5akWO5UGGnmokpq6Wie9pFlPldD0gDKNny0Q1B8IomIJGBToN3E/U
	uxu2bmtNCuPMYlvgN3lsgEjY++YCwJR+plwiJz+4C4S2NfO2VAL8BtEwZ5WRasbJjhjOIrK4cUL
	xC83T3D33TWfw+rsBxECiaCkNyIpdE8ORGhNAy0lwKS7MHnaf22kudrKYfZEHlVnVjcRsOXqNJV
	K2TDcTxTRs2E=
X-Google-Smtp-Source: AGHT+IFN3jK2lulyfvEhbh3K9++N3V/25lbHMvU2+TI6rKDdiedwACpF7X62+K8yahmFiIa6kkFmCA==
X-Received: by 2002:a17:903:1aa7:b0:234:de0a:b36e with SMTP id d9443c01a7336-23c797b288emr46884075ad.49.1751547725660;
        Thu, 03 Jul 2025 06:02:05 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ad9f5sm161942995ad.151.2025.07.03.06.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:02:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: urezki@gmail.com,
	akpm@linux-foundation.org,
	edumazet@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.12.y v2] mm/vmalloc: fix data race in show_numa_info()
Date: Thu,  3 Jul 2025 22:01:48 +0900
Message-ID: <20250703130148.18096-1-aha310510@gmail.com>
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
index cc04e501b1c5..7888600b6a79 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3095,7 +3095,7 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 	/*
 	 * Before removing VM_UNINITIALIZED,
 	 * we should make sure that vm has proper values.
-	 * Pair with smp_rmb() in show_numa_info().
+	 * Pair with smp_rmb() in vread_iter() and vmalloc_info_show().
 	 */
 	smp_wmb();
 	vm->flags &= ~VM_UNINITIALIZED;
@@ -4938,28 +4938,29 @@ bool vmalloc_dump_obj(void *object)
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
@@ -4987,6 +4988,10 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	struct vmap_area *va;
 	struct vm_struct *v;
 	int i;
+	unsigned int *counters;
+
+	if (IS_ENABLED(CONFIG_NUMA))
+		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
 
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
@@ -5003,6 +5008,11 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			}
 
 			v = va->vm;
+			if (v->flags & VM_UNINITIALIZED)
+				continue;
+
+			/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
+			smp_rmb();
 
 			seq_printf(m, "0x%pK-0x%pK %7ld",
 				v->addr, v->addr + v->size, v->size);
@@ -5037,7 +5047,9 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			if (is_vmalloc_addr(v->pages))
 				seq_puts(m, " vpages");
 
-			show_numa_info(m, v);
+			if (IS_ENABLED(CONFIG_NUMA))
+				show_numa_info(m, v, counters);
+
 			seq_putc(m, '\n');
 		}
 		spin_unlock(&vn->busy.lock);
@@ -5047,19 +5059,14 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
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

