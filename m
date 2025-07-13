Return-Path: <stable+bounces-161772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0CEB03167
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14B41893543
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1925119ABDE;
	Sun, 13 Jul 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hgoWC40O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB817433A8
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416239; cv=none; b=Fo1I0T0JpONsTifQVPc9O3+tIT/I0CSTsNjzHf8/lcmq00r2barC1MXooje+2Y0ygy7TomI5J527gh5uHchszSwtityY+LMm99/yDMgjFEyMXyadY0rzsZk2zzfe/vMezRDU6c6AZaKWxLEF4YmsmesU45fReUCJBWyK6m7JsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416239; c=relaxed/simple;
	bh=z+QyI+gBCLM7wrU2laU36/20ALs5U+YAQsxUIH3qQ/U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZU+b9Wlyilsc5AdwF1WYCfrseNlmsHlxHPRrhUJLjHWxF0YzV0H28vdM+zVuqxgwuidQBmNrNspT49nMwME6/04mbBQcv9WilsmLAxZsdSGUHBGAX5P2kwLPenZRnLOGyqq6aIVbF2XF2qTDAK6HfKbUUAa2b/QLgBiI6QeKJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hgoWC40O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AE5C4CEE3;
	Sun, 13 Jul 2025 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752416238;
	bh=z+QyI+gBCLM7wrU2laU36/20ALs5U+YAQsxUIH3qQ/U=;
	h=Subject:To:Cc:From:Date:From;
	b=hgoWC40OmEMzPB3xjexOleNpSqYcWZF5VVKf5Yxlwj8e4zgAek/tGs0L8z767Wb/z
	 LBzHpUPOunTTHlnNtB/2GHjncQGXei4mO/NxesIoCwT8jCcmzW1T7OihmyD9sCwdxY
	 t/xKgIn3QyOcLpYGi18q7nz65bJjMORR9egqHR/o=
Subject: FAILED: patch "[PATCH] mm/vmalloc: leave lazy MMU mode on PTE mapping error" failed to apply to 6.1-stable tree
To: agordeev@linux.ibm.com,akpm@linux-foundation.org,dan.carpenter@linaro.org,lkp@intel.com,ryan.roberts@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Jul 2025 16:17:16 +0200
Message-ID: <2025071315-rural-exploring-3260@gregkh>
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
git cherry-pick -x fea18c686320a53fce7ad62a87a3e1d10ad02f31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071315-rural-exploring-3260@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fea18c686320a53fce7ad62a87a3e1d10ad02f31 Mon Sep 17 00:00:00 2001
From: Alexander Gordeev <agordeev@linux.ibm.com>
Date: Mon, 23 Jun 2025 09:57:21 +0200
Subject: [PATCH] mm/vmalloc: leave lazy MMU mode on PTE mapping error

vmap_pages_pte_range() enters the lazy MMU mode, but fails to leave it in
case an error is encountered.

Link: https://lkml.kernel.org/r/20250623075721.2817094-1-agordeev@linux.ibm.com
Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202506132017.T1l1l6ME-lkp@intel.com/
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ab986dd09b6a..6dbcdceecae1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -514,6 +514,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
+	int err = 0;
 	pte_t *pte;
 
 	/*
@@ -530,12 +531,18 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	do {
 		struct page *page = pages[*nr];
 
-		if (WARN_ON(!pte_none(ptep_get(pte))))
-			return -EBUSY;
-		if (WARN_ON(!page))
-			return -ENOMEM;
-		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
-			return -EINVAL;
+		if (WARN_ON(!pte_none(ptep_get(pte)))) {
+			err = -EBUSY;
+			break;
+		}
+		if (WARN_ON(!page)) {
+			err = -ENOMEM;
+			break;
+		}
+		if (WARN_ON(!pfn_valid(page_to_pfn(page)))) {
+			err = -EINVAL;
+			break;
+		}
 
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
@@ -543,7 +550,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 
 	arch_leave_lazy_mmu_mode();
 	*mask |= PGTBL_PTE_MODIFIED;
-	return 0;
+
+	return err;
 }
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,


