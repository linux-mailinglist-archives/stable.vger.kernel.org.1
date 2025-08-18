Return-Path: <stable+bounces-170028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19DB2A011
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A58205B7D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D53101A3;
	Mon, 18 Aug 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2+pc/2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117F30DEC8
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515294; cv=none; b=R/qCI4p7hgir1sKAHb16/hbGfQIB0XuY/qKmmz3xciQt56zE1ix1eZ0FQ3h5fc9O0DKJvj+9C2M1Ehas47/QVQ3OWq/Nwx4qi6+MMmmV+PhSYyT5oO+F0WuIkZ2kaIfC+T0Kqha5L3hihnRPzr7amboAiOMrC5+Fhjdoc3bZ0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515294; c=relaxed/simple;
	bh=fqlyfKUwW0P0Im56Ay+VvtCOTxK4ZvWqamn8tHWsNTY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VTgd2nNkVFGmA6k6ThPUO+t0XbNwDRKGkIJTkewA5pZp/+qodY+LagQQfA9/xBb2B2ypgTMwbVBaKJv5X3ecUXS8qur5dmIEII+LknS/8iDur/0/GptRkn1jcwxzmVobgKqAFsuWlPSWrtvY2Q4Wuk2+KiYKRfBd9a/pAaEMbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2+pc/2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56F4C4CEEB;
	Mon, 18 Aug 2025 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515294;
	bh=fqlyfKUwW0P0Im56Ay+VvtCOTxK4ZvWqamn8tHWsNTY=;
	h=Subject:To:Cc:From:Date:From;
	b=v2+pc/2HtPEnYkSjFDrkVVIAMj37ZBepnflk26yFKQZVUOY2ZHS0HGOw+C8T0nbn8
	 T1F+Ycdkooan/xgycjWbOnQwocSRHKO7DVHSIl/1HKXZyG/STomYydP6yMr55lFaFu
	 mSFaVVNjPUGkYImiqt4iC1ItOURBCRrWhk0Ng+Tg=
Subject: FAILED: patch "[PATCH] mm/ptdump: take the memory hotplug lock inside" failed to apply to 5.15-stable tree
To: anshuman.khandual@arm.com,agordeev@linux.ibm.com,akpm@linux-foundation.org,borntraeger@linux.ibm.com,catalin.marinas@arm.com,david@redhat.com,dev.jain@arm.com,gerald.schaefer@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com,palmer@dabbelt.com,paul.walmsley@sifive.com,ryan.roberts@arm.com,stable@vger.kernel.org,svens@linux.ibm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:08:00 +0200
Message-ID: <2025081800-autopilot-booted-fb7f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 59305202c67fea50378dcad0cc199dbc13a0e99a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081800-autopilot-booted-fb7f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59305202c67fea50378dcad0cc199dbc13a0e99a Mon Sep 17 00:00:00 2001
From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Fri, 20 Jun 2025 10:54:27 +0530
Subject: [PATCH] mm/ptdump: take the memory hotplug lock inside
 ptdump_walk_pgd()

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
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 32922550a50a..3b51690cc876 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,7 +6,6 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
-#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -413,9 +412,7 @@ bool ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
-	get_online_mems();
 	ptdump_walk(m, m->private);
-	put_online_mems();
 
 	return 0;
 }
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index ac604b176660..9af2aae0a515 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -247,11 +247,9 @@ static int ptdump_show(struct seq_file *m, void *v)
 		.marker = markers,
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
index 61a352aa12ed..b600c7f864b8 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -176,6 +176,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 {
 	const struct ptdump_range *range = st->range;
 
+	get_online_mems();
 	mmap_write_lock(mm);
 	while (range->start != range->end) {
 		walk_page_range_debug(mm, range->start, range->end,
@@ -183,6 +184,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 		range++;
 	}
 	mmap_write_unlock(mm);
+	put_online_mems();
 
 	/* Flush out the last page */
 	st->note_page_flush(st);


