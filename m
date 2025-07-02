Return-Path: <stable+bounces-159255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF51AF5D51
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F22483C9F
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99BA2DCF6A;
	Wed,  2 Jul 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du41MWGD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297842E7BAF;
	Wed,  2 Jul 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470403; cv=none; b=BECb2XRFnkudC/UfzFdWfs6RpG4O/D0+VlSI6PHnLHrQAWvwd94/7AS8T2CbLtoEad4x3j7u1EDO6L2bD1gPm+jJIXcGlwV3AUKCJtLawzSEiVTPzuy6t+lcYhNR2iX9lTrx6OQBhhhtVQ1gD1hJPudvIRjC6dLOJDPHsmfYVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470403; c=relaxed/simple;
	bh=Aj62Fd0EdJ+ratg/xny/rQ3QaLZYtIjr8G4b56xNw/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOdHBfSs1Y3g3W2dVG7UEDaFsEEn+ZXgi68/5IizD/3Vlvp08nLmQKV/ggRn0rg8Qa6fpUqkry3EW/ZzNB5I58fN/ranl2t45OBjm9RtlvGwGTuFZzbmdeDMJMvgSCfBqDu82sPYttkAyMkBVXZTVyvxOVHMlucSkyySPj4UIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du41MWGD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235d6de331fso59551595ad.3;
        Wed, 02 Jul 2025 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751470401; x=1752075201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1EH/x0hqLVEztTMm5hLeKJHePzrbb36LWWaQlCSnz8=;
        b=Du41MWGDH9RTAEtojXKV6tFAqFjvAwX5BpcmZyM+1M+0qtiYYRTpXsyoQ15mbzkhfu
         DKjBGLx/0j8vHOMMD8DRZbda5FzxFkbkPZXyywJbddeXMZfAcPZ1ece8PseAg0fY8Zi5
         zSXF0llBupGqIXTkZFgt54nry/PRoa798hj8uO2j9sx7mGZLnPfhtImacnZc5vydQ7wg
         C61geQ4WwRo9fGTpTR+hw5hK7f5rz0/M/TnDYBfh5Sk3KRgl6vGaUMp8vpOv49IcByiI
         7G6+D425e9uEFD6lKkmVxf60hBz5aVFFCYfankLyilADUbUHMnt8u2yZ57kI3OTLXIqW
         0DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470401; x=1752075201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1EH/x0hqLVEztTMm5hLeKJHePzrbb36LWWaQlCSnz8=;
        b=SKVzcgBbdxn9IeRkHy6S5BuwiP0irr/29Uk3lAN65a7C1z03VzAErx6QeCQhXVPooK
         w6zSjjYH+AegW2zUq5PDatlx86HVS1n0lEIg4DIpwBTyh3YV0/hbeunXMC2WLxqolab2
         HloTax+AQAp7Nc1rtUmTpo1MM6bQTulZOkLT7rQ/ciTQUKFcaf2F2fecfHQzVCIYYTCd
         6e++XQ/yE+RkzBEeN9yl6rtjY0+SkCEIqu/TXLvWa6LkxPESy2h0UTll+fyZjWohur/P
         XVanHchpCqPkOPP8NfPL3DOCW6wmC2jDyrPLDcOOv7CtXCkqsPg7cp11HCSidO8ldrOR
         HIlw==
X-Forwarded-Encrypted: i=1; AJvYcCXKTwnvc6XKGmW7wJpJAkz097S5yeDhmaZ6kbke8elGRCj0FEBuxroD2QrCMuNw+Yh/Y83pSA5vdWo3/i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOG3QXYUHEZq7RXzamf+NwL19q4GhfrTUTORDRZq0Lbp/e72us
	vHUgQs8m7c4ePyg9/SXulQeNy44yXa34xqi4xGowiLLefb65X/D8iqxgwIohRIcXsEs=
X-Gm-Gg: ASbGncsr+dveuZhn9IuR4NjL6NQVUpdHfCJ4gY2TU/oFZ/2FiGOCfaOoq1Yt5WGRyf9
	kFFJyIzRLV/9dVZu0uCUR9MYOOhRWT112X4v+yhzHxL+YBH2ZS9Lzi1QMEiR7LOwzexJVdOJseJ
	LkPfrTpX0AxRNSNb05YefXPsAls4ZDhJFXP08k05s5UOwqA0DN6KtqM95df275NRTqy1VLglxmT
	wagrGvQ1qxO+aNuFlY37mC/V2PTwg6rKVobB0JbOMYPdyVjSqxAj+3nvhzSu2ex9Blp1NggKPof
	c1kU+85OJtqxpvdADeKRyosbIQl+VlXUNiWCFlfeL6k5W+wT+ZWpRdb9Q4QqSTo3OySJ+CgmmDI
	V
X-Google-Smtp-Source: AGHT+IGeKN0mY3ixdNXqrHP5b6d6Qr4CNStUVGGtIlA+/rTKBFeorHdTl8pqiv+lDFmFNXENyUADrQ==
X-Received: by 2002:a17:903:40cf:b0:234:f4da:7eef with SMTP id d9443c01a7336-23c6e5826e1mr59257965ad.52.1751470400941;
        Wed, 02 Jul 2025 08:33:20 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf5fsm140889545ad.115.2025.07.02.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:33:20 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: urezki@gmail.com,
	akpm@linux-foundation.org,
	edumazet@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.15.y] mm/vmalloc: fix data race in show_numa_info()
Date: Thu,  3 Jul 2025 00:33:12 +0900
Message-ID: <20250702153312.351080-1-aha310510@gmail.com>
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
Fixes: 8e1d743 ("mm: vmalloc: support multiple nodes in vmallocinfo")
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

