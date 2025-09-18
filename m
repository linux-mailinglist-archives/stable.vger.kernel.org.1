Return-Path: <stable+bounces-173065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BFB35B53
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601DB7C1813
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED652F8BD9;
	Tue, 26 Aug 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TVXPoNta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F0284B5B;
	Tue, 26 Aug 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207282; cv=none; b=JdW8t+RXGnfyBSpzlGe/65Z6IaIlRQaWNQSARBfijJAAinvHbEU/6xpEZ5ISmSXVdsxEm1LCQO1/ZCSUDj3LbpIbYd0GMhx19UlT0hyfFa+d+Wy7o4xjbiF4qHSvMyGsPBTSmcMld1glZfvTVMtP3JyVbHofYuUM7R41oWMVmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207282; c=relaxed/simple;
	bh=gIvOHxGxUTNMz41N887YMmS8hltahLIDYutCngOQLiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwrWIepZmxp2kInGGJICoT0/W8VjKoKbFjWxSD6H2lvO/KblKfpnlPe7cxlz2ocvjKUp5Tpyd7kWJOFufECGXVBlB+PTpc5PKDiYx1qDyZxf2osSJ/0vnh45sCtcr8jFkyr1+eBQYROv7/dG0VeC6xsp6AOWBle4apShtlXOMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TVXPoNta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6DCC4CEF1;
	Tue, 26 Aug 2025 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207282;
	bh=gIvOHxGxUTNMz41N887YMmS8hltahLIDYutCngOQLiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVXPoNtamYj9JrAYtKOryTxsLgQGbrhtRNCx9UvIsC/waLPcP7gOqNZMktzeZ5Mcs
	 cYbDeddJthtjXiYLSMbKFP6/6g5RW1nHlkHewSFNI5eZumNcglagH2Zx5EdNRKoSqT
	 2lQDTeZxtOGjVVvIiJaDb4ILhWtqG9WXRUe6Mb7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.16 122/457] parisc: Define and use set_pte_at()
Date: Tue, 26 Aug 2025 13:06:46 +0200
Message-ID: <20250826110940.388697725@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit 802e55488bc2cc1ab6423b720255a785ccac42ce upstream.

When a PTE is changed, we need to flush the PTE. set_pte_at()
was lost in the folio update. PA-RISC version is the same as
the generic version.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/pgtable.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -276,7 +276,7 @@ extern unsigned long *empty_zero_page;
 #define pte_none(x)     (pte_val(x) == 0)
 #define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
 #define pte_user(x)	(pte_val(x) & _PAGE_USER)
-#define pte_clear(mm, addr, xp)  set_pte(xp, __pte(0))
+#define pte_clear(mm, addr, xp) set_pte_at((mm), (addr), (xp), __pte(0))
 
 #define pmd_flag(x)	(pmd_val(x) & PxD_FLAG_MASK)
 #define pmd_address(x)	((unsigned long)(pmd_val(x) &~ PxD_FLAG_MASK) << PxD_VALUE_SHIFT)
@@ -392,6 +392,7 @@ static inline void set_ptes(struct mm_st
 	}
 }
 #define set_ptes set_ptes
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /* Used for deferring calls to flush_dcache_page() */
 
@@ -456,7 +457,7 @@ static inline int ptep_test_and_clear_yo
 	if (!pte_young(pte)) {
 		return 0;
 	}
-	set_pte(ptep, pte_mkold(pte));
+	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
 	return 1;
 }
 
@@ -466,7 +467,7 @@ pte_t ptep_clear_flush(struct vm_area_st
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	set_pte(ptep, pte_wrprotect(*ptep));
+	set_pte_at(mm, addr, ptep, pte_wrprotect(*ptep));
 }
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))



