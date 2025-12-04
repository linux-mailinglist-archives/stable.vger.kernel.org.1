Return-Path: <stable+bounces-199961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A001CA2837
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 07:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CBC130A35E3
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138330B50F;
	Thu,  4 Dec 2025 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC1hoKBH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD372FB63A
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764829478; cv=none; b=lHso+a1U+Y2tJWitLCs4zkeghKNThGsiUKZ6jjxJsmjnC147TyGdUhAjHNuozp4+Ee1an5oiZvvR8YGjWU75x5bPnfwlqYEb8rEoOnsnmH1b5Zj7rQIvS/CYANZ7tMQLjwhq7K8uxf9nYhSvemLsabrMUrIOFC8UQLm7rxW66mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764829478; c=relaxed/simple;
	bh=qI5EDftKrW3RqXCZ7LbaN7EmlHId//ZoPU1+jpakcps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OM0IsjHzBRBhSaS9EHnmvNRfID/YtrQ6lC2KyVkBab1RE+6R0P51cyWdPrf8voMyu/Bzlod9RWQg03yFmcrCtyb24F/eMIXQw3BVmNbzp28gRo4BDE9JHzvSDMbYX13mMrgp5A7usMfjwUxbudwtGLZgxUA2k81Lzsv+PfQNPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC1hoKBH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso417933a91.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 22:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764829476; x=1765434276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwjkeXFAKycBz5kVPuQsfA9dknSV5j6SmUCidRuGB8w=;
        b=iC1hoKBHJor8P3ZT4hDmYjY20pbb58hrD46rVzRzUP1i+XwMUesfEqooviI5z0QFZU
         maF4UdonkJmCOedvPPKsyxlGYjkJ/YOZoPfrwozSU1f4ukwzNIA93WELfd6uJUi0SOFl
         zVHZzhBs4FkOr8c0ShtDaQBr+mNDUIJl586xI1o7jbsPfBYX/dUQO6DBmgaJJHo4SqjN
         3zIm7PJokWmloxhjeK8BLSzvH1Dxb5eAY+v+aIzF2mL/wHz0eHm1lP8H+inEdHRhB0xc
         ytxkKFFNnw3EgILhSStAmDp8NloHMIJzk8SKTrdoqoVqV6HujIBsnwHH7zX5/3wqhRbU
         62HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764829476; x=1765434276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwjkeXFAKycBz5kVPuQsfA9dknSV5j6SmUCidRuGB8w=;
        b=RgyWnsKTSOAJ73PDurcOZ+LVn5C/ZM3NaofflEn7x3AHTj+dBf34facyYvnA6KvZ0u
         i1SRR0X6xvnxuqOeSiGVcSj544z4g2BCyfU14efQpvO1CLvNAzEdc+/T6HEyXEEchfIv
         b7gFTSr3xqlp1kAyxgH3NfHrAGEcQS2W1lHAKT8WSbdgzjKLjkqcbmkf2DCJVsr2lp2d
         8MktadwAhJd5z4skalLrzWkRYiP2Vyst3ylm60P5FMIENldM+LGwYFxLaCQq3zSn0YKZ
         iXHG6tOZInOQ61hl4tJst5mTjVE9vXtFaNfzPL8jh3qoj0S42tZr60K5MBNRmqRsTAhs
         RKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkjgm4uiHmo4fSvKCrKEXXly0A+BheB5b9dS2EO0b/SUo8fzjGCpgfYuK5l/G3busQTZFgA9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ktPBi9x4Xc4KNcc0jGRrLeZXQCrsGcjqOCMYDzb/e32C5D7/
	jKzjISQJe5iTvBZP2DlciLKlaA1u7tO5cKuZ2MCX6HXZgr6YnznA6cv6
X-Gm-Gg: ASbGncsW51a283hNnlZMPr7K6iRRcuzEetN76ISdU6XA1uJ2AHpLP+aVIVKTUx45DZk
	H1hpcB3TYnRdHBthledT5qHJJDldVsiDKtDYpvx1YLzJQxbWd1A7pqT4P1JP0pylBxhL1YK0M25
	k+SJObba+nIA6Hmevvh75MFQRKp/SCTI/KvjKISoM66E0Y1+qh4r55wPkO97DBPu6IvbF5uLVk8
	cxdmAjM8dBPo4GGgabX1iLRSRoAAqOIn2nSY8UWZQceFYrJvve6WS8l/f8rnTrUmzqOauYmw1eI
	QOQ+PqLxWgwNMQW6+6yBj8U2OANn2IQ4neH9JyL6QdUJAhgFu7CGhG1mUMvjax1YczTq4NpiLTa
	CBktu1ZihJH2V6gRa/JgsbIA41htDBxg4jht1x6BcTN2BmovPcjUK3e2TAaC3jHc2wsK1npRhkt
	fFf8nBsh0BYBC5T1rxrPf+V8VPs1Knjw==
X-Google-Smtp-Source: AGHT+IG1jA6VJk6bFAYklmbDfBZ3ne4ku1nuwKBVNGxzQh75d2PfyV5AUlD3S2xVp47P+9ZdWCKPig==
X-Received: by 2002:a17:90b:4a8b:b0:341:194:5e7a with SMTP id 98e67ed59e1d1-349127fdfd5mr6151039a91.29.1764829475717;
        Wed, 03 Dec 2025 22:24:35 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea63e87sm804640a91.12.2025.12.03.22.24.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 22:24:35 -0800 (PST)
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
Subject: [PATCH net v3 1/1] atm: mpoa: Fix UAF on qos_head list in procfs
Date: Thu,  4 Dec 2025 15:24:21 +0900
Message-Id: <20251204062421.96986-2-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251204062421.96986-1-ii4gsp@gmail.com>
References: <20251204062421.96986-1-ii4gsp@gmail.com>
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
and kfree() entries immediately. Concurrent read/write therefore leads
to a use-after-free.

Fix this by serializing all qos_head list operations with a mutex.
A mutex is used because seq_printf() may sleep.

To avoid returning an unprotected pointer (and the resulting lifetime
race), replace atm_mpoa_search_qos() with atm_mpoa_get_qos(), which
copies the QoS under lock. Also add atm_mpoa_delete_qos_by_ip() so
search+unlink+free is atomic under the same lock, preventing concurrent
double-free/UAF scenarios.

KASAN report:

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

Reported-by: Minseong Kim <ii4gsp@gmail.com>
Closes: https://lore.kernel.org/netdev/CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 net/atm/mpc.c         | 184 ++++++++++++++++++++++++++++++++----------
 net/atm/mpc.h         |   3 +-
 net/atm/mpoa_caches.c |  17 ++--
 net/atm/mpoa_proc.c   |   2 +-
 4 files changed, 149 insertions(+), 57 deletions(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..650081dd82d1 100644
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
 
 
@@ -172,67 +174,63 @@ static struct mpoa_client *find_mpc_by_lec(struct net_device *dev)
  */
 
 /*
- * Overwrites the old entry or makes a new one.
+ * Search for a QoS entry. Caller must hold qos_mutex.
+ * Returns pointer to entry if found, NULL otherwise.
  */
-struct atm_mpoa_qos *atm_mpoa_add_qos(__be32 dst_ip, struct atm_qos *qos)
+static struct atm_mpoa_qos *__atm_mpoa_search_qos(__be32 dst_ip)
 {
-	struct atm_mpoa_qos *entry;
-
-	entry = atm_mpoa_search_qos(dst_ip);
-	if (entry != NULL) {
-		entry->qos = *qos;
-		return entry;
-	}
+	struct atm_mpoa_qos *qos = qos_head;
 
-	entry = kmalloc(sizeof(struct atm_mpoa_qos), GFP_KERNEL);
-	if (entry == NULL) {
-		pr_info("mpoa: out of memory\n");
-		return entry;
+	while (qos) {
+		if (qos->ipaddr == dst_ip)
+			return qos;
+		qos = qos->next;
 	}
-
-	entry->ipaddr = dst_ip;
-	entry->qos = *qos;
-
-	entry->next = qos_head;
-	qos_head = entry;
-
-	return entry;
+	return NULL;
 }
 
-struct atm_mpoa_qos *atm_mpoa_search_qos(__be32 dst_ip)
+/*
+ * Get a QoS entry by copying its value.
+ * Caller gets a COPY of qos under lock.
+ * Returns true if found and copied, false if not found.
+ * This avoids lifetime issues with the returned pointer.
+ */
+bool atm_mpoa_get_qos(__be32 dst_ip, struct atm_qos *out)
 {
-	struct atm_mpoa_qos *qos;
+	struct atm_mpoa_qos *q;
 
-	qos = qos_head;
-	while (qos) {
-		if (qos->ipaddr == dst_ip)
-			break;
-		qos = qos->next;
-	}
+	if (!out)
+		return false;
 
-	return qos;
+	mutex_lock(&qos_mutex);
+	q = __atm_mpoa_search_qos(dst_ip);
+	if (q)
+		*out = q->qos;
+	mutex_unlock(&qos_mutex);
+
+	return q;
 }
 
 /*
- * Returns 0 for failure
+ * Delete a QoS entry from the list. Caller must hold qos_mutex.
+ * Returns 1 if found and deleted, 0 if not found.
  */
-int atm_mpoa_delete_qos(struct atm_mpoa_qos *entry)
+static int __atm_mpoa_delete_qos_locked(struct atm_mpoa_qos *entry)
 {
 	struct atm_mpoa_qos *curr;
 
-	if (entry == NULL)
+	if (!entry)
 		return 0;
+
 	if (entry == qos_head) {
-		qos_head = qos_head->next;
-		kfree(entry);
+		qos_head = entry->next;
 		return 1;
 	}
 
 	curr = qos_head;
-	while (curr != NULL) {
+	while (curr) {
 		if (curr->next == entry) {
 			curr->next = entry->next;
-			kfree(entry);
 			return 1;
 		}
 		curr = curr->next;
@@ -241,15 +239,107 @@ int atm_mpoa_delete_qos(struct atm_mpoa_qos *entry)
 	return 0;
 }
 
+/*
+ * Delete a QoS entry by IP address.
+ * This is atomic: search+unlink+free happens entirely under lock,
+ * avoiding the double-free issue with atm_mpoa_delete_qos(atm_mpoa_search_qos(ipaddr)).
+ */
+int atm_mpoa_delete_qos_by_ip(__be32 dst_ip)
+{
+	struct atm_mpoa_qos *entry;
+	int ret = 0;
+
+	mutex_lock(&qos_mutex);
+	entry = __atm_mpoa_search_qos(dst_ip);
+	if (entry) {
+		ret = __atm_mpoa_delete_qos_locked(entry);
+		if (ret)
+			kfree(entry);
+	}
+	mutex_unlock(&qos_mutex);
+
+	return ret;
+}
+
+/*
+ * Overwrites the old entry or makes a new one.
+ */
+struct atm_mpoa_qos *atm_mpoa_add_qos(__be32 dst_ip, struct atm_qos *qos)
+{
+	struct atm_mpoa_qos *entry;
+	struct atm_mpoa_qos *new;
+
+	/* Fast path: update existing entry */
+	mutex_lock(&qos_mutex);
+	entry = __atm_mpoa_search_qos(dst_ip);
+	if (entry) {
+		entry->qos = *qos;
+		mutex_unlock(&qos_mutex);
+		return entry;
+	}
+	mutex_unlock(&qos_mutex);
+
+	/* Allocate outside lock */
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	new->ipaddr = dst_ip;
+	new->qos = *qos;
+
+	/* Re-check under lock to avoid duplicates */
+	mutex_lock(&qos_mutex);
+	entry = __atm_mpoa_search_qos(dst_ip);
+	if (entry) {
+		entry->qos = *qos;
+		mutex_unlock(&qos_mutex);
+		kfree(new);
+		return entry;
+	}
+
+	new->next = qos_head;
+	qos_head = new;
+	mutex_unlock(&qos_mutex);
+
+	return new;
+}
+
+/*
+ * Delete a QoS entry by pointer.
+ * WARNING: This function is unsafe if called with an entry pointer
+ * obtained outside of qos_mutex protection. The entry may have been
+ * freed by another thread between the time the pointer was obtained
+ * and when this function is called.
+ * Use atm_mpoa_delete_qos_by_ip() instead for safe deletion by IP address.
+ * Returns 0 for failure, 1 for success
+ */
+int atm_mpoa_delete_qos(struct atm_mpoa_qos *entry)
+{
+	int ret;
+
+	if (!entry)
+		return 0;
+
+	mutex_lock(&qos_mutex);
+	ret = __atm_mpoa_delete_qos_locked(entry);
+	if (ret)
+		kfree(entry);
+	mutex_unlock(&qos_mutex);
+
+	return ret;
+}
+
 /* this is buggered - we need locking for qos_head */
 void atm_mpoa_disp_qos(struct seq_file *m)
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
@@ -265,6 +355,7 @@ void atm_mpoa_disp_qos(struct seq_file *m)
 			   qos->qos.rxtp.max_sdu);
 		qos = qos->next;
 	}
+	mutex_unlock(&qos_mutex);
 }
 
 static struct net_device *find_lec_by_itfnum(int itf)
@@ -1118,13 +1209,16 @@ static void check_qos_and_open_shortcut(struct k_message *msg,
 					in_cache_entry *entry)
 {
 	__be32 dst_ip = msg->content.in_info.in_dst_ip;
-	struct atm_mpoa_qos *qos = atm_mpoa_search_qos(dst_ip);
+	struct atm_qos tmp_qos;
+	bool has_qos;
 	eg_cache_entry *eg_entry = client->eg_ops->get_by_src_ip(dst_ip, client);
 
+	has_qos = atm_mpoa_get_qos(dst_ip, &tmp_qos);
+
 	if (eg_entry && eg_entry->shortcut) {
 		if (eg_entry->shortcut->qos.txtp.traffic_class &
 		    msg->qos.txtp.traffic_class &
-		    (qos ? qos->qos.txtp.traffic_class : ATM_UBR | ATM_CBR)) {
+		    (has_qos ? tmp_qos.txtp.traffic_class : ATM_UBR | ATM_CBR)) {
 			if (eg_entry->shortcut->qos.txtp.traffic_class == ATM_UBR)
 				entry->shortcut = eg_entry->shortcut;
 			else if (eg_entry->shortcut->qos.txtp.max_pcr > 0)
@@ -1142,9 +1236,9 @@ static void check_qos_and_open_shortcut(struct k_message *msg,
 
 	/* No luck in the egress cache we must open an ingress SVC */
 	msg->type = OPEN_INGRESS_SVC;
-	if (qos &&
-	    (qos->qos.txtp.traffic_class == msg->qos.txtp.traffic_class)) {
-		msg->qos = qos->qos;
+	if (has_qos &&
+	    tmp_qos.txtp.traffic_class == msg->qos.txtp.traffic_class) {
+		msg->qos = tmp_qos;
 		pr_info("(%s) trying to get a CBR shortcut\n",
 			client->dev->name);
 	} else
@@ -1521,8 +1615,10 @@ static void __exit atm_mpoa_cleanup(void)
 		mpc = tmp;
 	}
 
+	mutex_lock(&qos_mutex);
 	qos = qos_head;
 	qos_head = NULL;
+	mutex_unlock(&qos_mutex);
 	while (qos != NULL) {
 		nextqos = qos->next;
 		dprintk("freeing qos entry %p\n", qos);
diff --git a/net/atm/mpc.h b/net/atm/mpc.h
index 454abd07651a..0536946989ad 100644
--- a/net/atm/mpc.h
+++ b/net/atm/mpc.h
@@ -47,8 +47,9 @@ struct atm_mpoa_qos {
 
 /* MPOA QoS operations */
 struct atm_mpoa_qos *atm_mpoa_add_qos(__be32 dst_ip, struct atm_qos *qos);
-struct atm_mpoa_qos *atm_mpoa_search_qos(__be32 dst_ip);
+bool atm_mpoa_get_qos(__be32 dst_ip, struct atm_qos *out);
 int atm_mpoa_delete_qos(struct atm_mpoa_qos *qos);
+int atm_mpoa_delete_qos_by_ip(__be32 dst_ip);
 
 /* Display QoS entries. This is for the procfs */
 struct seq_file;
diff --git a/net/atm/mpoa_caches.c b/net/atm/mpoa_caches.c
index f7a2f0e41105..30c5b10ee562 100644
--- a/net/atm/mpoa_caches.c
+++ b/net/atm/mpoa_caches.c
@@ -132,7 +132,6 @@ static in_cache_entry *in_cache_add_entry(__be32 dst_ip,
 
 static int cache_hit(in_cache_entry *entry, struct mpoa_client *mpc)
 {
-	struct atm_mpoa_qos *qos;
 	struct k_message msg;
 
 	entry->count++;
@@ -144,9 +143,8 @@ static int cache_hit(in_cache_entry *entry, struct mpoa_client *mpc)
 			msg.type = SND_MPOA_RES_RQST;
 			msg.content.in_info = entry->ctrl_info;
 			memcpy(msg.MPS_ctrl, mpc->mps_ctrl_addr, ATM_ESA_LEN);
-			qos = atm_mpoa_search_qos(entry->ctrl_info.in_dst_ip);
-			if (qos != NULL)
-				msg.qos = qos->qos;
+			if (!atm_mpoa_get_qos(entry->ctrl_info.in_dst_ip, &msg.qos))
+				memset(&msg.qos, 0, sizeof(msg.qos));
 			msg_to_mpoad(&msg, mpc);
 			entry->reply_wait = ktime_get_seconds();
 			entry->entry_state = INGRESS_RESOLVING;
@@ -167,9 +165,8 @@ static int cache_hit(in_cache_entry *entry, struct mpoa_client *mpc)
 		msg.type = SND_MPOA_RES_RQST;
 		memcpy(msg.MPS_ctrl, mpc->mps_ctrl_addr, ATM_ESA_LEN);
 		msg.content.in_info = entry->ctrl_info;
-		qos = atm_mpoa_search_qos(entry->ctrl_info.in_dst_ip);
-		if (qos != NULL)
-			msg.qos = qos->qos;
+		if (!atm_mpoa_get_qos(entry->ctrl_info.in_dst_ip, &msg.qos))
+			memset(&msg.qos, 0, sizeof(msg.qos));
 		msg_to_mpoad(&msg, mpc);
 		entry->reply_wait = ktime_get_seconds();
 	}
@@ -249,7 +246,6 @@ static void clear_count_and_expired(struct mpoa_client *client)
 static void check_resolving_entries(struct mpoa_client *client)
 {
 
-	struct atm_mpoa_qos *qos;
 	in_cache_entry *entry;
 	time64_t now;
 	struct k_message msg;
@@ -283,9 +279,8 @@ static void check_resolving_entries(struct mpoa_client *client)
 				msg.type = SND_MPOA_RES_RTRY;
 				memcpy(msg.MPS_ctrl, client->mps_ctrl_addr, ATM_ESA_LEN);
 				msg.content.in_info = entry->ctrl_info;
-				qos = atm_mpoa_search_qos(entry->ctrl_info.in_dst_ip);
-				if (qos != NULL)
-					msg.qos = qos->qos;
+				if (!atm_mpoa_get_qos(entry->ctrl_info.in_dst_ip, &msg.qos))
+					memset(&msg.qos, 0, sizeof(msg.qos));
 				msg_to_mpoad(&msg, client);
 				entry->reply_wait = ktime_get_seconds();
 			}
diff --git a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
index aaf64b953915..600075c6022e 100644
--- a/net/atm/mpoa_proc.c
+++ b/net/atm/mpoa_proc.c
@@ -254,7 +254,7 @@ static int parse_qos(const char *buff)
 	if (sscanf(buff, "del %hhu.%hhu.%hhu.%hhu",
 			ip, ip+1, ip+2, ip+3) == 4) {
 		ipaddr = *(__be32 *)ip;
-		return atm_mpoa_delete_qos(atm_mpoa_search_qos(ipaddr));
+		return atm_mpoa_delete_qos_by_ip(ipaddr);
 	}
 
 	if (sscanf(buff, "add %hhu.%hhu.%hhu.%hhu tx=%d,%d rx=tx",
-- 
2.39.5 (Apple Git-154)


