Return-Path: <stable+bounces-238188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6oCVTd32nXZgAAu9opvQ
	(envelope-from <stable+bounces-238188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51716407304
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A71EC3024631
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28524A078;
	Wed, 15 Apr 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1fQW6alJ"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B6344DB4
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278856; cv=none; b=Plj891ZAkqtsEoMMnNtWlnR6FveCu0Acz7JFOStD/JsEP7NXWQrwzouF2QLuWYP2TCncMZywpT+4rSHa8wZSF0eFMgxbqjYdOKVWyqgiQ5wKqqGlHc0em0KfMzGUTuB/4oLkCE4ChcTTIDBl5Pl2yluNE9KLOrvGuBQ6Tw2xcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278856; c=relaxed/simple;
	bh=T9Du9sJUHk3DVlLuIMEc9rxXjU0R4sgGy3E3feG30ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFdeU5SaUVFPKeidYVEYwU0AKL+7b+pGSmCKXXdIJuyzYh3EX/YfQxhLCuakTBQ4R5ICt1BZrdGqjH4NJOvryLBncPpTh7H07MVrfJVIl375zI8g/6W71wNO4BhTfChrvJ02AoXRwTIh+ffxwcAnty8kqj/u5IoWc3aWXLv5O90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1fQW6alJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=5ZTJIVGBlSBfRycx713LwLhjMGdQSP0TB74Hk/sQa5I=; b=1fQW6alJ2gGNu9JkoT0uqxeAa1
	iIHq0n2pF5ff7NHdjpN/SWl1qfCqVNb1jEGepig27A8AokVzInJ/53TKniG+fyK6ZAABSjk9HFmgl
	4Oew8BDzeUTQL6XlK3i4A3dziW8mTzgPH/fm4Z29Pwr0KY5wDsTC4gmHEV77ZLO1of+3ReciT0JOs
	eb3hPZyFxJ107AcSoWCnvXlvDaDurlSsPj/O+uJk6pI2+Rlp5UNvXsU4CFJGnc2VuuXpgWQMO5JgN
	5fGS1fxFEe1XAgq4U8EPofF80uUTzF5/ef8MaVXVj+Igah2t4rPaDt5hFcR/LlgFuCxSGqn+MAvm5
	fziKB8BA==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: quentin.schulz@cherry.de,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y] kernel: be more careful about dup_mmap() failures and uprobe registering
Date: Wed, 15 Apr 2026 20:06:23 +0200
Message-ID: <20260415180623.199818-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238188-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bytedance.com:email,cherry.de:email]
X-Rspamd-Queue-Id: 51716407304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

[ Upstream commit 64c37e134b120fb462fb4a80694bfb8e7be77b14 ]

If a memory allocation fails during dup_mmap(), the maple tree can be left
in an unsafe state for other iterators besides the exit path.  All the
locks are dropped before the exit_mmap() call (in mm/mmap.c), but the
incomplete mm_struct can be reached through (at least) the rmap finding
the vmas which have a pointer back to the mm_struct.

Up to this point, there have been no issues with being able to find an
mm_struct that was only partially initialised.  Syzbot was able to make
the incomplete mm_struct fail with recent forking changes, so it has been
proven unsafe to use the mm_struct that hasn't been initialised, as
referenced in the link below.

Although 8ac662f5da19f ("fork: avoid inappropriate uprobe access to
invalid mm") fixed the uprobe access, it does not completely remove the
race.

This patch sets the MMF_OOM_SKIP to avoid the iteration of the vmas on the
oom side (even though this is extremely unlikely to be selected as an oom
victim in the race window), and sets MMF_UNSTABLE to avoid other potential
users from using a partially initialised mm_struct.

When registering vmas for uprobe, skip the vmas in an mm that is marked
unstable.  Modifying a vma in an unstable mm may cause issues if the mm
isn't fully initialised.

Link: https://lore.kernel.org/all/6756d273.050a0220.2477f.003d.GAE@google.com/
Link: https://lkml.kernel.org/r/20250127170221.1761366-1-Liam.Howlett@oracle.com
Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[resolved conflict from missing header includes:
 - linux/workqueue.h missing, introduced by commit 2bf8e5aceff8 ("uprobes:
   allow put_uprobe() from non-sleepable softirq context")
 - linux/srcu.h missing, introduced by commit dd1a7567784e ("uprobes:
   SRCU-protect uretprobe lifetime (with timeout)") ]
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 kernel/events/uprobes.c |  4 ++++
 kernel/fork.c           | 17 ++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1ff26dc3bdb0..5059de5fcc23 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/oom.h>          /* check_stable_address_space */
 
 #include <linux/uprobes.h>
 
@@ -1106,6 +1107,9 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 		 * returns NULL in find_active_uprobe_rcu().
 		 */
 		mmap_write_lock(mm);
+		if (check_stable_address_space(mm))
+			goto unlock;
+
 		vma = find_vma(mm, info->vaddr);
 		if (!vma || !valid_vma(vma, is_register) ||
 		    file_inode(vma->vm_file) != uprobe->inode)
diff --git a/kernel/fork.c b/kernel/fork.c
index 55086df4d24c..a01cf3a904bf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -766,7 +766,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		mt_set_in_rcu(vmi.mas.tree);
 		ksm_fork(mm, oldmm);
 		khugepaged_fork(mm, oldmm);
-	} else if (mpnt) {
+	} else {
+
 		/*
 		 * The entire maple tree has already been duplicated. If the
 		 * mmap duplication fails, mark the failure point with
@@ -774,8 +775,18 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		 * stop releasing VMAs that have not been duplicated after this
 		 * point.
 		 */
-		mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
-		mas_store(&vmi.mas, XA_ZERO_ENTRY);
+		if (mpnt) {
+			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
+			mas_store(&vmi.mas, XA_ZERO_ENTRY);
+			/* Avoid OOM iterating a broken tree */
+			set_bit(MMF_OOM_SKIP, &mm->flags);
+		}
+		/*
+		 * The mm_struct is going to exit, but the locks will be dropped
+		 * first.  Set the mm_struct as unstable is advisable as it is
+		 * not fully initialised.
+		 */
+		set_bit(MMF_UNSTABLE, &mm->flags);
 	}
 out:
 	mmap_write_unlock(mm);
-- 
2.53.0


