Return-Path: <stable+bounces-199957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82176CA260A
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 06:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8F6E30434D6
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 05:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19234306B01;
	Thu,  4 Dec 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibqba481"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AD304BB3
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824474; cv=none; b=FblE3tt4ux2og4eYDOFbZkAKxefc5Q68oadOp1kRkYs3mPg8ViI8xcsE0G510BNhTbSeRpPNx3fvPblOFc0X3x3SwC5QYLssn1RBgrTSH2+3hN7z1RDINQrvqZLK0jw8w/2VzuvJNnkbbGRTG+WDz3r0BfFBeU72j79FZ24yF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824474; c=relaxed/simple;
	bh=h+SsofwZUC6HHHUEGGsDwWbigfLFJlyhD5zXfZWg7WU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkVPXeG4P+BreClyWIv1LMh8sF2HMhivjLfs8WmWVfboSJbOJZmNN4bBwHIsEVVRXz+sWMH4MZIAmamzp1WwLNAQrLcZWJsJN/AE8NfXbNP67EEMKOc2vXjsSHdoxj/6NGgUfBxqkEh4V5c5Datmm6yqBVv/XNazPEugcYpBt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibqba481; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3410c86070dso374564a91.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 21:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764824471; x=1765429271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzubs5IauHk/nAj1ysw/i0kR+ISPkcjNfWdKzDf2z5U=;
        b=Ibqba4816Pl5xrZ2ULx/j8rOYP0jTMs3LrlLH2xMVnairWjwdJTV9InGDCcdc7zHAK
         4HAMFz14mbyUfIACe+EJw9hkBiwiV17xdpgehSlJDkEhLH/qcH5cXhKGSxzneqmF3i5B
         /+Xk6+IHKkPEzYJfFVOgPeyIixoOXWMlP5rGf3yhAuosE/7d08CDQRAKYnwPp3OqXbSA
         c2H/sJsJ8pH7d4e7l4TPUkzZFRQUFLfrcDiWmsgZNF/3PHLtRQaDGD48hmBaUfK+9NOR
         8TW/2311eSPyGyBOUNI4jxWyrKgHhGAx5+wZsVAU5uzMXXlu4oUFCEQYFcsgdRuBlUVy
         btvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764824471; x=1765429271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzubs5IauHk/nAj1ysw/i0kR+ISPkcjNfWdKzDf2z5U=;
        b=VEjIkU0iDewcKZqf1YaP1O6M+R4fRc1c28CtGVs3/wJU9BYskuZQtG4fcwiPAake1Y
         0EGRnMdYLqSbA2Q4mDqSzR9lCk+8gGatP+jacoNtfDTI8P8M7rXN+eAzsv9FPRJfE327
         IoMIHC+jZ8WURR81MOaJr0798doDwq8zv4YOs1MTJiXGdcHRF2gOPTdurXKe2Q8i37+b
         VlW8Pt7Mm654sS2gPR0zqku5KoKhcdsmKdVvnafyTCAFrpYg2wBfNW9PjVTRCIkZTwDl
         trkTbHhDvG0Yt1/s0aCVN7wKhMwbsRO0juJ5wC0hBkh3MBntmR1Ei64xFbAM8Bo4O/cA
         404Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD3R9UqkFYCuedvq+bUxhPkuFdIDQkF/6ZmGIVQ5qxfi+b/VwOXLfHNPd5pUfzJOVEy41u8v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wvzwsqb9KUJ/n5EuOahnD4SolC9L791v6cqEEcIwj+NY93kP
	46gxtRxwFWQ4oG5PFlZqZV/0jL3x6NBjnqMUlOXSznb4NwQHREUYMLkA
X-Gm-Gg: ASbGncv1eKXw4EabwpjQnabkPrb6X7Bzhmq/b0N/OQWknvuzTC3CaMd+Y27vejsFA5S
	fOBMYzcZMgwGdigB/Fo40aOcHdklDv0qPpJQZrf1A/lLpzDco+5rscFLBvwpREqkhzMoqMrJiRq
	1yESqDG+YxzKSKi35sKqA+V7BuoCpitzhLIADsUM1wu9DL0LaXyjLk5EoR7Vk75dDaAYWkOt7el
	L2KUE8u+tPkQmTMaJb8nRNWIRIi8ozFK1dyyba2YUTsKuHB4wL1dgwFi/VMgWcu0i8cZ+doPZLy
	owBAhuW4LT00Da/6WUFdJO1+DE9MIYxg22cjT3WYjZ7zjedn54xaA5J8XE5mUGkiDOZUJ6vne7w
	h3cS87hZr4fl0ImHV4ZJEyC+ha14I5Gr8O7NraGrtL2s6wkRl1xxsUULa68Q52HoNq4jmXcinvN
	bLsQRKteN8y0eYaN5bARNkGH1RS2blbg==
X-Google-Smtp-Source: AGHT+IHvVa2gOEpNGRYSdHAlmeic8g/wSjxYvPRnhd0qjegdQdGaQ4vVcVURP/2X1RJ9nm+or3BF0w==
X-Received: by 2002:a17:90b:2f03:b0:343:6108:1706 with SMTP id 98e67ed59e1d1-349126895a7mr5846558a91.17.1764824470864;
        Wed, 03 Dec 2025 21:01:10 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681738a34sm419440a12.4.2025.12.03.21.01.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 21:01:10 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/1] atm: mpoa: Fix UAF on qos_head list in procfs
Date: Thu,  4 Dec 2025 14:00:39 +0900
Message-Id: <20251204050039.93278-2-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251204050039.93278-1-ii4gsp@gmail.com>
References: <20251204050039.93278-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global QoS list 'qos_head' in net/atm/mpc.c is accessed from the
/proc/net/atm/mpc procfs interface without proper synchronization.
The read-side seq_file show path (mpc_show() -> atm_mpoa_disp_qos())
walks qos_head without any lock, while the write-side path
(proc_mpc_write() -> parse_qos() -> atm_mpoa_delete_qos()) can unlink
and kfree() entries immediately. Concurrent read/write therefore
leads to a use-after-free.

This risk is already called out in-tree:
  /* this is buggered - we need locking for qos_head */

Fix this by adding a mutex to protect all qos_head list operations.
A mutex is used (instead of a spinlock) because atm_mpoa_disp_qos()
invokes seq_printf(), which may sleep.

KASAN report:

==================================================================
[   15.911538] BUG: KASAN: slab-use-after-free in atm_mpoa_disp_qos+0x202/0x380
[   15.911988] Read of size 8 at addr ffff888007517380 by task mpoa_uaf_poc/89
[   15.912123]
[   15.912717] CPU: 0 UID: 0 PID: 89 Comm: mpoa_uaf_poc Not tainted 6.17.8 #1 PREEMPT(voluntary)
[   15.912950] Hardware name: QEMU Ubuntu 25.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.913110] Call Trace:
[   15.913167]  <TASK>
[   15.913247]  dump_stack_lvl+0x4e/0x70
[   15.913343]  ? atm_mpoa_disp_qos+0x202/0x380
[   15.913364]  print_report+0x174/0x4f6
[   15.913386]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   15.913412]  ? atm_mpoa_disp_qos+0x202/0x380
[   15.913430]  kasan_report+0xce/0x100
[   15.913453]  ? atm_mpoa_disp_qos+0x202/0x380
[   15.913475]  atm_mpoa_disp_qos+0x202/0x380
[   15.913496]  mpc_show+0x575/0x700
[   15.913515]  ? kasan_save_track+0x14/0x30
[   15.913532]  ? __pfx_mpc_show+0x10/0x10
[   15.913550]  ? __pfx_mutex_lock+0x10/0x10
[   15.913565]  ? seq_read_iter+0x697/0x1110
[   15.913584]  seq_read_iter+0x2bc/0x1110
[   15.913607]  seq_read+0x267/0x3d0
[   15.913623]  ? __pfx_seq_read+0x10/0x10
[   15.913650]  proc_reg_read+0x1ab/0x270
[   15.913669]  vfs_read+0x175/0xa10
[   15.913687]  ? do_sys_openat2+0x103/0x170
[   15.913701]  ? kmem_cache_free+0xc4/0x360
[   15.913718]  ? getname_flags.part.0+0xf3/0x470
[   15.913734]  ? __pfx_vfs_read+0x10/0x10
[   15.913751]  ? mutex_lock+0x81/0xe0
[   15.913766]  ? __pfx_mutex_lock+0x10/0x10
[   15.913782]  ? __rseq_handle_notify_resume+0x4c4/0xac0
[   15.913802]  ? fdget_pos+0x24d/0x4b0
[   15.913829]  ksys_read+0xf7/0x1c0
[   15.913850]  ? __pfx_ksys_read+0x10/0x10
[   15.913877]  do_syscall_64+0xa4/0x290
[   15.913917]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   15.913981] RIP: 0033:0x45c982
[   15.914171] Code: 08 0f 85 71 ea ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 48 89 e5
[   15.914239] RSP: 002b:00007f4b2b2cb0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   15.914315] RAX: ffffffffffffffda RBX: 00007f4b2b2cc6c0 RCX: 000000000045c982
[   15.914352] RDX: 0000000000000fff RSI: 00007f4b2b2cb220 RDI: 0000000000000014
[   15.914382] RBP: 00007f4b2b2cb100 R08: 0000000000000000 R09: 0000000000000000
[   15.914413] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000a
[   15.914445] R13: ffffffffffffffd0 R14: 0000000000000000 R15: 00007ffd386450c0
[   15.914483]  </TASK>
[   15.914533]
[   15.916812] Allocated by task 78:
[   15.916975]  kasan_save_stack+0x30/0x50
[   15.917047]  kasan_save_track+0x14/0x30
[   15.917105]  __kasan_kmalloc+0x8f/0xa0
[   15.917162]  atm_mpoa_add_qos+0x1bb/0x3c0
[   15.917220]  parse_qos.cold+0x73/0x7d
[   15.917276]  proc_mpc_write+0xf4/0x150
[   15.917331]  proc_reg_write+0x1ab/0x270
[   15.917379]  vfs_write+0x1ce/0xd30
[   15.917431]  ksys_write+0xf7/0x1c0
[   15.917476]  do_syscall_64+0xa4/0x290
[   15.917523]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   15.917586]
[   15.917628] Freed by task 78:
[   15.917665]  kasan_save_stack+0x30/0x50
[   15.917714]  kasan_save_track+0x14/0x30
[   15.917762]  kasan_save_free_info+0x3b/0x70
[   15.917811]  __kasan_slab_free+0x3e/0x50
[   15.918058]  kfree+0x121/0x340
[   15.918135]  atm_mpoa_delete_qos+0xad/0xd0
[   15.918196]  parse_qos+0x1e5/0x1f0
[   15.918339]  proc_mpc_write+0xf4/0x150
[   15.918438]  proc_reg_write+0x1ab/0x270
[   15.918494]  vfs_write+0x1ce/0xd30
[   15.918538]  ksys_write+0xf7/0x1c0
[   15.918589]  do_syscall_64+0xa4/0x290
[   15.918634]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   15.918694]
[   15.918751] The buggy address belongs to the object at ffff888007517380
[   15.918751]  which belongs to the cache kmalloc-96 of size 96
[   15.918911] The buggy address is located 0 bytes inside of
[   15.918911]  freed 96-byte region [ffff888007517380, ffff8880075173e0)
[   15.919027]
[   15.919101] The buggy address belongs to the physical page:
[   15.919416] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888007517300 pfn:0x7517
[   15.919679] anon flags: 0x100000000000000(node=0|zone=1)
[   15.920064] page_type: f5(slab)
[   15.920361] raw: 0100000000000000 ffff888006c41280 0000000000000000 dead000000000001
[   15.920460] raw: ffff888007517300 0000000080200007 00000000f5000000 0000000000000000
[   15.920577] page dumped because: kasan: bad access detected
[   15.920634]
[   15.920663] Memory state around the buggy address:
[   15.920860]  ffff888007517280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   15.920944]  ffff888007517300: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   15.921017] >ffff888007517380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   15.921088]                    ^
[   15.921163]  ffff888007517400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   15.921222]  ffff888007517480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[   15.921313] ==================================================================

Reported-by: Minseong Kim <ii4gsp@gmail.com>
Closes: https://lore.kernel.org/netdev/CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 net/atm/mpc.c | 117 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 32 deletions(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..c268b5f4a266 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -9,6 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/capability.h>
 #include <linux/seq_file.h>
+#include <linux/mutex.h>
 
 /* We are an ethernet device */
 #include <linux/if_ether.h>
@@ -122,6 +123,7 @@ static struct notifier_block mpoa_notifier = {
 
 struct mpoa_client *mpcs = NULL; /* FIXME */
 static struct atm_mpoa_qos *qos_head = NULL;
+static DEFINE_MUTEX(qos_mutex); /* Protect qos_head list */
 static DEFINE_TIMER(mpc_timer, mpc_cache_check);
 
 
@@ -171,74 +173,120 @@ static struct mpoa_client *find_mpc_by_lec(struct net_device *dev)
  * Functions for managing QoS list
  */
 
+/*
+ * Search for a QoS entry. Caller must hold qos_mutex.
+ * Returns pointer to entry if found, NULL otherwise.
+ */
+static struct atm_mpoa_qos *__atm_mpoa_search_qos(__be32 dst_ip)
+{
+	struct atm_mpoa_qos *qos = qos_head;
+
+	while (qos) {
+		if (qos->ipaddr == dst_ip)
+			return qos;
+		qos = qos->next;
+	}
+	return NULL;
+}
+
+/*
+ * Search for a QoS entry.
+ * WARNING: The returned pointer is not protected. The caller must ensure
+ * that the entry is not freed while using it, or hold qos_mutex during use.
+ */
+struct atm_mpoa_qos *atm_mpoa_search_qos(__be32 dst_ip)
+{
+	struct atm_mpoa_qos *qos;
+
+	mutex_lock(&qos_mutex);
+	qos = __atm_mpoa_search_qos(dst_ip);
+	mutex_unlock(&qos_mutex);
+
+	return qos;
+}
+
 /*
  * Overwrites the old entry or makes a new one.
  */
 struct atm_mpoa_qos *atm_mpoa_add_qos(__be32 dst_ip, struct atm_qos *qos)
 {
 	struct atm_mpoa_qos *entry;
+	struct atm_mpoa_qos *new;
 
-	entry = atm_mpoa_search_qos(dst_ip);
-	if (entry != NULL) {
+	/* Fast path: update existing entry */
+	mutex_lock(&qos_mutex);
+	entry = __atm_mpoa_search_qos(dst_ip);
+	if (entry) {
 		entry->qos = *qos;
+		mutex_unlock(&qos_mutex);
 		return entry;
 	}
+	mutex_unlock(&qos_mutex);
 
-	entry = kmalloc(sizeof(struct atm_mpoa_qos), GFP_KERNEL);
-	if (entry == NULL) {
+	/* Allocate outside lock */
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new) {
 		pr_info("mpoa: out of memory\n");
-		return entry;
+		return NULL;
 	}
 
-	entry->ipaddr = dst_ip;
-	entry->qos = *qos;
+	new->ipaddr = dst_ip;
+	new->qos = *qos;
 
-	entry->next = qos_head;
-	qos_head = entry;
-
-	return entry;
-}
-
-struct atm_mpoa_qos *atm_mpoa_search_qos(__be32 dst_ip)
-{
-	struct atm_mpoa_qos *qos;
-
-	qos = qos_head;
-	while (qos) {
-		if (qos->ipaddr == dst_ip)
-			break;
-		qos = qos->next;
+	/* Re-check under lock to avoid duplicates */
+	mutex_lock(&qos_mutex);
+	entry = __atm_mpoa_search_qos(dst_ip);
+	if (entry) {
+		entry->qos = *qos;
+		mutex_unlock(&qos_mutex);
+		kfree(new);
+		return entry;
 	}
 
-	return qos;
+	new->next = qos_head;
+	qos_head = new;
+	mutex_unlock(&qos_mutex);
+
+	return new;
 }
 
 /*
- * Returns 0 for failure
+ * Returns 0 for failure, 1 for success
  */
 int atm_mpoa_delete_qos(struct atm_mpoa_qos *entry)
 {
 	struct atm_mpoa_qos *curr;
+	int ret = 0;
 
 	if (entry == NULL)
 		return 0;
+
+	mutex_lock(&qos_mutex);
+
 	if (entry == qos_head) {
 		qos_head = qos_head->next;
-		kfree(entry);
-		return 1;
+		ret = 1;
+		goto out_free;
 	}
 
 	curr = qos_head;
-	while (curr != NULL) {
+	while (curr) {
 		if (curr->next == entry) {
 			curr->next = entry->next;
-			kfree(entry);
-			return 1;
+			ret = 1;
+			goto out_free;
 		}
 		curr = curr->next;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&qos_mutex);
+	return ret;
+
+out_free:
+	mutex_unlock(&qos_mutex);
+	kfree(entry);
+	return ret;
 }
 
 /* this is buggered - we need locking for qos_head */
@@ -246,10 +294,12 @@ void atm_mpoa_disp_qos(struct seq_file *m)
 {
 	struct atm_mpoa_qos *qos;
 
-	qos = qos_head;
 	seq_printf(m, "QoS entries for shortcuts:\n");
-	seq_printf(m, "IP address\n  TX:max_pcr pcr     min_pcr max_cdv max_sdu\n  RX:max_pcr pcr     min_pcr max_cdv max_sdu\n");
+	seq_printf(m, "IP address\n  TX:max_pcr pcr     min_pcr max_cdv max_sdu\n"
+		   "  RX:max_pcr pcr     min_pcr max_cdv max_sdu\n");
 
+	mutex_lock(&qos_mutex);
+	qos = qos_head;
 	while (qos != NULL) {
 		seq_printf(m, "%pI4\n     %-7d %-7d %-7d %-7d %-7d\n     %-7d %-7d %-7d %-7d %-7d\n",
 			   &qos->ipaddr,
@@ -265,6 +315,7 @@ void atm_mpoa_disp_qos(struct seq_file *m)
 			   qos->qos.rxtp.max_sdu);
 		qos = qos->next;
 	}
+	mutex_unlock(&qos_mutex);
 }
 
 static struct net_device *find_lec_by_itfnum(int itf)
@@ -1521,8 +1572,10 @@ static void __exit atm_mpoa_cleanup(void)
 		mpc = tmp;
 	}
 
+	mutex_lock(&qos_mutex);
 	qos = qos_head;
 	qos_head = NULL;
+	mutex_unlock(&qos_mutex);
 	while (qos != NULL) {
 		nextqos = qos->next;
 		dprintk("freeing qos entry %p\n", qos);
-- 
2.39.5 (Apple Git-154)


