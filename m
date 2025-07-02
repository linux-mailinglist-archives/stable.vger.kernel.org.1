Return-Path: <stable+bounces-159256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C799CAF5D49
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D7817D061
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A462D77E4;
	Wed,  2 Jul 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XELZYIND"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B42D94A2;
	Wed,  2 Jul 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470488; cv=none; b=o8o6E3WfspZFvKIvuaDTUGVWx6sY2122i/ryYJwhYdBX07aN28foIlBdFxBJ1z/ijytDpvrTJdQFnhRuYFzNmTayNUaEKoDc67pYi/xCrlRNbpLJ1VqaD0o/3tV5sMi7ieCc98nK6UZcHPQJY7ICe7u4VZcVUP5ENQ1t+1D+sBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470488; c=relaxed/simple;
	bh=yqP3EEyGVMEVWhd2I5rcQM9AIsrSnuFOcRNbmAICYh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7Rz7hHRXOXXwe3IHKfMJcsM+DRmc0fiKIhIWkbJdUzCYZGJFfZT0e+/P2QILgFisgRqUa1cqfboFc7kHzTmB/X2GhFJILLabFSoqHVOX7tZZcMR+NHwKnnWpK2U/7pj0i0xsoCNYfnbE22i3gsTm0XUBMQA1ALbzcRwNzUybrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XELZYIND; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so4734185a91.3;
        Wed, 02 Jul 2025 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751470486; x=1752075286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2o4feWgTKo5vc2LOyHiVPm12DjOu6huEv/DJKPXUXkI=;
        b=XELZYINDoGXqwLQjPiNEm0ErtgtzznM2EOpGWr4WdMbF/7wGMG17V0wDhXY06LkjJB
         41ORtEyehBrbGxP65bqLxgfCY4WY7CUEgGdg4R+ICMtRTUstpJVyFaj/NinG29RHClXc
         zqnl2O9ZLV2ovJ5GzcOEYFu1pQmvtVxSgDTMFcH5jof9C9KCh7gNHzNRFcHavYvtaR1O
         vF1ZZzrd6+Qn4vrpua8O225E+LyzWABPu2DyG6j9jpV0QhtAxRvWd0BHC9U538Q1baWy
         FgR6XRQc6Ul5cBD+Rsk7aiG6cbFy9+IUIfW8JE4Z/Bpm1h0NYzS35SQQkH+yMr/6sFB/
         LVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470486; x=1752075286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o4feWgTKo5vc2LOyHiVPm12DjOu6huEv/DJKPXUXkI=;
        b=K6Raf6dDd3jTeHSF27+WpTxCfQnJEFeMpLf1N6oPtm3bIDqEUyvpVbAaA6xPR4CIZ1
         SlFiXNPTmeMeggo0wXkmldAkW4Ufu7LWRWvfLwnHEJfl4Aj6eDvYOgYl0b4vsM5K5FP4
         AO+mR66S4+HwvqFtDUdkVvSAIPo7Ek2cTH4/Gxb84ww3VyuqZH5+q7y5ycllSqovWzpX
         7ltD/OhPKG5LcgBqSNANjfrTlwr9n+mQq86FHJhcU6xsUeA2CX97wQu1WjX/+RzIV5HC
         MRekzf6/5fWLwHFbBwEm4PGQ8Oz2Wpad+rVkQnHg0KPwzytaEqeZZOEfwGzBu+RMEtbA
         coow==
X-Forwarded-Encrypted: i=1; AJvYcCWMXAqz3ACpOv5VzrbRTYu+BTotyjlf/PkZ0ATsCo+alE5DlOMiZrDAktldi+iZkwCyDSbhoq/TvbyH9cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrppD86BKNxBrWIp2vknw7GHS9BLUmcITqKgy3RZMPZ0TyKlK1
	x2zkx1IrsX6MJipQie94pB+M39JKn43fyBzR2Gt7lkoUemsc7pTf55K7kYxm1ln4ujg=
X-Gm-Gg: ASbGnctxr6JuaiVlSYBeiiY/xoJeRgljkVec21bfePH04IhdRL0YeTs6trI6izv9a/p
	C8PVfe+brClxI/fdVmWfXQocC7/m5VJEXoA2hMv679egRz07iKHMmhOZsOLK0sUQ1SWh9R84E2k
	OYzeUoSSwICA7UdbrdEiFNurA9Rdmjk+n8ZabhysyWusfpt9IPUlJK+0krggdw2wF43m9UobDIF
	K2A1YXZAZkWl1cCIvICyt7hyVro/aGDZTcvWCMZl4qqVKBen4O9643fDl1rw0W7jrCkycNmBoSv
	7Y1w2ChtDDJoC4Hi5+G3r8v/5LVQVAEUQGhL86Daz494WV2AqdUcF/MA6zEnZkdjnf8pv+1BZNN
	f
X-Google-Smtp-Source: AGHT+IGlRXeyXScn43VoC7Ft1mt5ftrgmmxSJWUI7GcKIoaJVqk/2AnZ3tYGH/R9T28vOp/8NPCPcQ==
X-Received: by 2002:a17:90b:5787:b0:311:9c1f:8522 with SMTP id 98e67ed59e1d1-31a90b2a07amr5529477a91.10.1751470485579;
        Wed, 02 Jul 2025 08:34:45 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc72255sm110682a91.21.2025.07.02.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:34:44 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: urezki@gmail.com,
	akpm@linux-foundation.org,
	edumazet@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.12.y] mm/vmalloc: fix data race in show_numa_info()
Date: Thu,  3 Jul 2025 00:34:28 +0900
Message-ID: <20250702153428.352047-1-aha310510@gmail.com>
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

