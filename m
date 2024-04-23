Return-Path: <stable+bounces-40671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2138AE707
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8581C22D48
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474912CD86;
	Tue, 23 Apr 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzxmrK7h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9184A20
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876680; cv=none; b=JxTggu5qSmYWRwfzg8UI4pCajiDZVoZvN6k/8AVYdvgNe7fGKMYX537VcIiS+Yc++n97Q1b18mzVG4a2Grkg7/HEh9ym3hA+E0ORgx0qSvpNyFEy6rm1LQz9lckI1Gii4JRM6kYIBBONWhTKWbN7b85efS8qzIMrPQbuZ1caH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876680; c=relaxed/simple;
	bh=0ZR2Upxy4Cil5pA8Y7nU/c392vQ6JhulLRqNd9Pc6uQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jyq+SUZrBJFQV853cliYTeoWV2fxTf6XWLNWK6L0PcR/G1HFpGs9roeNf3BQz9I1gQ0DAr3ltoU9tOZJ/43lAb9OZMhW7hQokLFz3z806qE1NgQtzCr2/GvdW1O177Pw+lwDwZITQnuRBsGkS4ZHbqhrGHFLfLBo+Sv3H7Gppek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzxmrK7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD03C116B1;
	Tue, 23 Apr 2024 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876679;
	bh=0ZR2Upxy4Cil5pA8Y7nU/c392vQ6JhulLRqNd9Pc6uQ=;
	h=Subject:To:Cc:From:Date:From;
	b=WzxmrK7hPG3a2tcpC+/H+ADkSdd0sdGtPnFv+WT8Vk91gXG3LxIrz50bmp/HkOQot
	 eJ8B6HUrhq4KfAm3y3O1sKZDPkBf7rtLRAyx8kBLivbyrO5XO7pDa8fAmxomszZZJP
	 l8I3zU3RmcoD3KT+JEU2nuiZdxGCULdPYVn+cLGY=
Subject: FAILED: patch "[PATCH] mm,swapops: update check in is_pfn_swap_entry for hwpoison" failed to apply to 6.1-stable tree
To: osalvador@suse.de,akpm@linux-foundation.org,david@redhat.com,linmiaohe@huawei.com,peterx@redhat.com,stable@vger.kernel.org,tony.luck@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:51:09 -0700
Message-ID: <2024042309-rural-overlying-190b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 07a57a338adb6ec9e766d6a6790f76527f45ceb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042309-rural-overlying-190b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

07a57a338adb ("mm,swapops: update check in is_pfn_swap_entry for hwpoison entries")
d027122d8363 ("mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c")
e591ef7d96d6 ("mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07a57a338adb6ec9e766d6a6790f76527f45ceb5 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Sun, 7 Apr 2024 15:05:37 +0200
Subject: [PATCH] mm,swapops: update check in is_pfn_swap_entry for hwpoison
 entries

Tony reported that the Machine check recovery was broken in v6.9-rc1, as
he was hitting a VM_BUG_ON when injecting uncorrectable memory errors to
DRAM.

After some more digging and debugging on his side, he realized that this
went back to v6.1, with the introduction of 'commit 0d206b5d2e0d
("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")'.  That
commit, among other things, introduced swp_offset_pfn(), replacing
hwpoison_entry_to_pfn() in its favour.

The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(), but
is_pfn_swap_entry() never got updated to cover hwpoison entries, which
means that we would hit the VM_BUG_ON whenever we would call
swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM
set.  Fix this by updating the check to cover hwpoison entries as well,
and update the comment while we are it.

Link: https://lkml.kernel.org/r/20240407130537.16977-1-osalvador@suse.de
Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Tony Luck <tony.luck@intel.com>
Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>	[6.1.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 48b700ba1d18..a5c560a2f8c2 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -390,6 +390,35 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 }
 #endif	/* CONFIG_MIGRATION */
 
+#ifdef CONFIG_MEMORY_FAILURE
+
+/*
+ * Support for hardware poisoned pages
+ */
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+	BUG_ON(!PageLocked(page));
+	return swp_entry(SWP_HWPOISON, page_to_pfn(page));
+}
+
+static inline int is_hwpoison_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_HWPOISON;
+}
+
+#else
+
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+	return swp_entry(0, 0);
+}
+
+static inline int is_hwpoison_entry(swp_entry_t swp)
+{
+	return 0;
+}
+#endif
+
 typedef unsigned long pte_marker;
 
 #define  PTE_MARKER_UFFD_WP			BIT(0)
@@ -483,8 +512,9 @@ static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
 
 /*
  * A pfn swap entry is a special type of swap entry that always has a pfn stored
- * in the swap offset. They are used to represent unaddressable device memory
- * and to restrict access to a page undergoing migration.
+ * in the swap offset. They can either be used to represent unaddressable device
+ * memory, to restrict access to a page undergoing migration or to represent a
+ * pfn which has been hwpoisoned and unmapped.
  */
 static inline bool is_pfn_swap_entry(swp_entry_t entry)
 {
@@ -492,7 +522,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
 
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
 }
 
 struct page_vma_mapped_walk;
@@ -561,35 +591,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 }
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-#ifdef CONFIG_MEMORY_FAILURE
-
-/*
- * Support for hardware poisoned pages
- */
-static inline swp_entry_t make_hwpoison_entry(struct page *page)
-{
-	BUG_ON(!PageLocked(page));
-	return swp_entry(SWP_HWPOISON, page_to_pfn(page));
-}
-
-static inline int is_hwpoison_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_HWPOISON;
-}
-
-#else
-
-static inline swp_entry_t make_hwpoison_entry(struct page *page)
-{
-	return swp_entry(0, 0);
-}
-
-static inline int is_hwpoison_entry(swp_entry_t swp)
-{
-	return 0;
-}
-#endif
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;


