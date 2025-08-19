Return-Path: <stable+bounces-171807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E233B2C786
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C41884E6F
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C508217659;
	Tue, 19 Aug 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMoVSrwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC53398A
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614988; cv=none; b=bfv7nzSco4MwzQB6oTTVYAsUWooQLZU+DObAljFOoXaWjL0bnKEcgIk5l2xx5Vr/w9tlaHWX9pfNXhw5Ixe9YbyEGCwpIlX2cJq+krAsjlR2CNY/hYQ1qSxyEPe2p/63UyFikdhY2Lko08CSjul6Zt8S9duQ1RonTV2O6b4KgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614988; c=relaxed/simple;
	bh=ccH11PaV2RzEluVzXukE2b+Agoca/aQtXfqh/yUsg3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLJk+ZGGdlIgaIjCGRxk1kyUvAiCV0HNyyNCLwBTHU3Jfq3mruzbHDYX4ESczrelpvaqeS2yzZvWBwJCd3uivhfPCNS9rUmqL9cw1neGPzE2vIV33hl0RcjSgLRPii9bs76dfoUf9KajYVDBayvVUc5lu95oq9mxcOx1VgxB4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMoVSrwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C30C4CEF1;
	Tue, 19 Aug 2025 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614987;
	bh=ccH11PaV2RzEluVzXukE2b+Agoca/aQtXfqh/yUsg3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMoVSrwFeyHFss8jxOI41krUuO/Uc5nJl9AaVtAbyAdYNs5RRjV5O0x/EKzPx+/ly
	 4utuyYHpIwWXJ6uMTdrxTVaraMBBW8qV3a0fwGhViN0YfZ1yZeYyzsiJ+KtYl9eBNM
	 T3y595icOA+dshkTNQyOtHEovYT7KQrVOLJa54hktn9OOhLAErgn50jLOJiEw7wFw5
	 AmxWSiywwxDPZMuLqbhSQfeqYojl30FxTUGBNiz62lIMdj53Ifo26Bz7EiS2weO2FA
	 gKUKlJoKVgg5VFIgXdtc2aXJBMRIIyTcMIiVIoLHvmoW/2fHjrzKSIKABYs3WsDqhp
	 ijkeJJqaUexng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/ptdump: take the memory hotplug lock inside ptdump_walk_pgd()
Date: Tue, 19 Aug 2025 10:49:44 -0400
Message-ID: <20250819144944.523881-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081859-excess-willfully-0f01@gregkh>
References: <2025081859-excess-willfully-0f01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit 59305202c67fea50378dcad0cc199dbc13a0e99a ]

Memory hot remove unmaps and tears down various kernel page table regions
as required.  The ptdump code can race with concurrent modifications of
the kernel page tables.  When leaf entries are modified concurrently, the
dump code may log stale or inconsistent information for a VA range, but
this is otherwise not harmful.

But when intermediate levels of kernel page table are freed, the dump code
will continue to use memory that has been freed and potentially
reallocated for another purpose.  In such cases, the ptdump code may
dereference bogus addresses, leading to a number of potential problems.

To avoid the above mentioned race condition, platforms such as arm64,
riscv and s390 take memory hotplug lock, while dumping kernel page table
via the sysfs interface /sys/kernel/debug/kernel_page_tables.

Similar race condition exists while checking for pages that might have
been marked W+X via /sys/kernel/debug/kernel_page_tables/check_wx_pages
which in turn calls ptdump_check_wx().  Instead of solving this race
condition again, let's just move the memory hotplug lock inside generic
ptdump_check_wx() which will benefit both the scenarios.

Drop get_online_mems() and put_online_mems() combination from all existing
platform ptdump code paths.

Link: https://lkml.kernel.org/r/20250620052427.2092093-1-anshuman.khandual@arm.com
Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>	[s390]
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/ptdump_debugfs.c | 3 ---
 arch/s390/mm/dump_pagetables.c | 2 --
 mm/ptdump.c                    | 2 ++
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 68bf1a125502..1e308328c079 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
-#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptdump.h>
@@ -9,9 +8,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct ptdump_info *info = m->private;
 
-	get_online_mems();
 	ptdump_walk(m, info);
-	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index ba5f80268878..65243e1d0c8e 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -249,11 +249,9 @@ static int ptdump_show(struct seq_file *m, void *v)
 		.marker = address_markers,
 	};
 
-	get_online_mems();
 	mutex_lock(&cpa_mutex);
 	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
 	mutex_unlock(&cpa_mutex);
-	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 8adab455a68b..8e29b90d6bc3 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -152,6 +152,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 {
 	const struct ptdump_range *range = st->range;
 
+	get_online_mems();
 	mmap_write_lock(mm);
 	while (range->start != range->end) {
 		walk_page_range_novma(mm, range->start, range->end,
@@ -159,6 +160,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 		range++;
 	}
 	mmap_write_unlock(mm);
+	put_online_mems();
 
 	/* Flush out the last page */
 	st->note_page(st, 0, -1, 0);
-- 
2.50.1


