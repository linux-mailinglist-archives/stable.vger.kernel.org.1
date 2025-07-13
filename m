Return-Path: <stable+bounces-161773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF8B03168
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D87A3B9939
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E651B87E9;
	Sun, 13 Jul 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OGyAczhY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2D78F29
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416246; cv=none; b=tW+nmXFhs0OrMEy58Ik+KpQlxvwn7COWqJemKDQfdBzklpJHrzdl4Bwjnjbwvzr81jIpufhsodG6/qMT8ameMV4gpoXaAF0MyGAyP0xjfKghcOvr6J9Y2T591+VkxOnO3jz9kZJqCVKiOfkN/U1ZpxP9EkT5e91VahcNDbeKV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416246; c=relaxed/simple;
	bh=j2w0miqfsJ80TuY29DNK5rLLkXUhYo4j7Ifqz/p9eCU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X+kzoycBRmdIRX1CIqqVzEcieHZYRkvkpc8FrIlka7h2h6uGSUjbYP4NHacm80DYM20EPhq8mSEZZxpErLkrGJZmEofm6OPRCoLjXNZW7gsQBdfDI3SEjjYq4k6FamfyxSXECMgu+/giwOCtOxKaewvi6vA/7+0d4oP27VHqDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OGyAczhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC7C4CEE3;
	Sun, 13 Jul 2025 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752416245;
	bh=j2w0miqfsJ80TuY29DNK5rLLkXUhYo4j7Ifqz/p9eCU=;
	h=Subject:To:Cc:From:Date:From;
	b=OGyAczhYf0HXzUlVF/jodgO7kFSNT0hxPXpVvpjvcOe1Fj2qy8HitzamRoQ3MiKOV
	 ZYAo6PzDRBr4QVyXHyBAKxlC/bJSsXzJWHxGHw1YpqsrNHd87lLnAtKY+OxxXGchUn
	 Z4LCKUnmt2Q5YJ86uqdBIc4LEpJbLYm/xEe0iQMA=
Subject: FAILED: patch "[PATCH] mm/vmalloc: leave lazy MMU mode on PTE mapping error" failed to apply to 5.15-stable tree
To: agordeev@linux.ibm.com,akpm@linux-foundation.org,dan.carpenter@linaro.org,lkp@intel.com,ryan.roberts@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Jul 2025 16:17:16 +0200
Message-ID: <2025071316-jawed-backward-2063@gregkh>
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
git cherry-pick -x fea18c686320a53fce7ad62a87a3e1d10ad02f31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071316-jawed-backward-2063@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


