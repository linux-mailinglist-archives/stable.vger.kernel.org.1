Return-Path: <stable+bounces-40900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9868AF985
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC6A1C23B20
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC4F144D24;
	Tue, 23 Apr 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhSPu/Lc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6F20B3E;
	Tue, 23 Apr 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908541; cv=none; b=tRJYDQXnmbuKDD6h5wwXzBUjTKUTVU8mfyVW+p7qhwz7WDQTfL5fzgP2xJYOhVikp91H07YUSODWhMii7hU7oeIDQOzubP5b9xMJpcWZ58b/qp8H9l3g+a0OWhvEw5gz9e3Wm2jzygerMYio7iXniapIDUuo0n3Du4DzJFEsWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908541; c=relaxed/simple;
	bh=RYOIigWsC4u46/d0rJjqO5ZLTT/X8rurmbISOYmxuDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TncWewYdf3UYZPx8LKpHH45F5c3aIw01ibM9aybK/2mbz7UAI4/an/BpdDMkQeQUIe44HStGHWJZaKshzgB+xEoLzp0B9IfO4M0yxWOI1b/Y7RT/fKDphuRAIXdgunxrc3Q5JIqb2YihVbD9x26eNwUBODrliGIMQyzIUAXgaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhSPu/Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ECCC116B1;
	Tue, 23 Apr 2024 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908541;
	bh=RYOIigWsC4u46/d0rJjqO5ZLTT/X8rurmbISOYmxuDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhSPu/LcXkOPdobJc7OA2L1o0zbGohbH0u+86C9v/0rYtr8kcGlVBZl/jrgWczxlI
	 egmh2htqHtUXEvKHU2NAnlpU8T8JoEuU7HzIfUQS5ZLBXsRbj5ZAwIALS0g8sT05tr
	 VZSllK4LSwY6OYoRAyEtZgEf2oFGTEHTOMs0UO8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oscar Salvador <osalvador@suse.de>,
	Tony Luck <tony.luck@intel.com>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.8 136/158] mm,swapops: update check in is_pfn_swap_entry for hwpoison entries
Date: Tue, 23 Apr 2024 14:39:18 -0700
Message-ID: <20240423213900.299583509@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Salvador <osalvador@suse.de>

commit 07a57a338adb6ec9e766d6a6790f76527f45ceb5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/swapops.h |   65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -390,6 +390,35 @@ static inline bool is_migration_entry_di
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
@@ -470,8 +499,9 @@ static inline struct page *pfn_swap_entr
 
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
@@ -479,7 +509,7 @@ static inline bool is_pfn_swap_entry(swp
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
 
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
 }
 
 struct page_vma_mapped_walk;
@@ -548,35 +578,6 @@ static inline int is_pmd_migration_entry
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



