Return-Path: <stable+bounces-163790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCCB0DB91
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EC13B0A8B
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE382E2F10;
	Tue, 22 Jul 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOWjFVfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C0154457;
	Tue, 22 Jul 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192219; cv=none; b=b5G0p9UXv50fXfQQbxZtO9v7Ge3KayVww3dm4J+t0JE9uxQ9G3HGD7Bp3TmkF7qKxEGomvyyzgVajUTGcc5sJVAdwL11i3MAHvWBODv+XFCOPOJ09vWF83lTFS7A+W+aQ2cG26gf/ulEb3x8Uy9sKNexLe0aAIUBEENTMPtsiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192219; c=relaxed/simple;
	bh=1b5NwTscfFzaNCmpoVezhpvRIbCpV0WXxspeE5S/5c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxPgaOeTumr2bwJARDqlWYP4gh+eDDdvFmgR6bFvo27J6qBdjwi98KVKkA78mSYXvEti69OBGZYGjk87siPlRFkhjIfJXPpclcslJtXrI5LfR/YsSmAV34EnBC7SE502xQj2OHf3w9gRKRiBOdfiW47Tm4/6UpEZGgGVqj4lQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOWjFVfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C533C4CEEB;
	Tue, 22 Jul 2025 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192219;
	bh=1b5NwTscfFzaNCmpoVezhpvRIbCpV0WXxspeE5S/5c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOWjFVfSql33vS49Zul7J9aj7F9WpYK9GE8Iu7OQXS6M9PKiU/588OKAw+Hl2KYiX
	 YJpD1tyJ6Y6cpDXqtul8xSGlt2aZauWsnWS/3ZFPXuIUfftv+wspDygWWMv9xajLSP
	 nEUvGu5px3+5IYdlLPS3pRirDuqfZSQDiddSeqWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 78/79] mm/vmalloc: leave lazy MMU mode on PTE mapping error
Date: Tue, 22 Jul 2025 15:45:14 +0200
Message-ID: <20250722134331.266895503@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Gordeev <agordeev@linux.ibm.com>

commit fea18c686320a53fce7ad62a87a3e1d10ad02f31 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -467,6 +467,7 @@ static int vmap_pages_pte_range(pmd_t *p
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
+	int err = 0;
 	pte_t *pte;
 
 	/*
@@ -480,18 +481,25 @@ static int vmap_pages_pte_range(pmd_t *p
 	do {
 		struct page *page = pages[*nr];
 
-		if (WARN_ON(!pte_none(*pte)))
-			return -EBUSY;
-		if (WARN_ON(!page))
-			return -ENOMEM;
-		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
-			return -EINVAL;
+		if (WARN_ON(!pte_none(*pte))) {
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
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	*mask |= PGTBL_PTE_MODIFIED;
-	return 0;
+
+	return err;
 }
 
 static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,



