Return-Path: <stable+bounces-172105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA9B2FAAF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4586D7B24B0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E25335BAA;
	Thu, 21 Aug 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1qv+jD8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA0335BA4
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783177; cv=none; b=DgAOO6fwsbiM1BLtCqiTPbRszpqSyIWWvSVSkWbqILsD1Y8BbPjG9LVYpsJeWgjFn0NobxDS7Ahl5o/tkil+7MCrMTKLh7DeRLyF0aYHjS15pwZKdjDeT+ZcG98lKPfpb5z9F3f3iSuuXDpUj+A3X/oXuSfZjY0FDIGeIUsK1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783177; c=relaxed/simple;
	bh=p/E2XRLTV0tw3UvfJV0Tg81IvQBAqYJi+UAzIfzmq/c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l6pPR7dojBfUjbnTD2G9zqkaRk/T1d9inSxRqyvKtydlcsHNEb6EUTMhI+tPfPQq5pbE/37oqVOBYDODjzXOPSJfeaqe1US9KVWxWP/QV/BU0t6/0eOl6amnoPVdgy06m2cAQ02KkPJ9yhz3u0OEbdK3NdBff30AzfaYLjBJxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1qv+jD8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14513C4CEEB;
	Thu, 21 Aug 2025 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783176;
	bh=p/E2XRLTV0tw3UvfJV0Tg81IvQBAqYJi+UAzIfzmq/c=;
	h=Subject:To:Cc:From:Date:From;
	b=1qv+jD8cXVEC1baH1u1I5yfa6vph/EBjKa12uKxwDhAJoYfTqLdMcdZtHwVWcXN+J
	 zfJc0wQ02wMJ3yZDsuXQicf5dhNr20peYcNtQARK1Y2EvLQ/FWDGbXKBTPZrt6F0db
	 iUtoTEdjLdiU8Wv6qGa0epfg3oVvox/3SneEaNUA=
Subject: FAILED: patch "[PATCH] parisc: Define and use set_pte_at()" failed to apply to 6.1-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:32:53 +0200
Message-ID: <2025082153-reboot-engulf-4d64@gregkh>
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
git cherry-pick -x 802e55488bc2cc1ab6423b720255a785ccac42ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082153-reboot-engulf-4d64@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 802e55488bc2cc1ab6423b720255a785ccac42ce Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 16:06:21 -0400
Subject: [PATCH] parisc: Define and use set_pte_at()

When a PTE is changed, we need to flush the PTE. set_pte_at()
was lost in the folio update. PA-RISC version is the same as
the generic version.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 1a86a4370b29..2c139a4dbf4b 100644
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
@@ -392,6 +392,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 #define set_ptes set_ptes
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /* Used for deferring calls to flush_dcache_page() */
 
@@ -456,7 +457,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned
 	if (!pte_young(pte)) {
 		return 0;
 	}
-	set_pte(ptep, pte_mkold(pte));
+	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
 	return 1;
 }
 
@@ -466,7 +467,7 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *pt
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	set_pte(ptep, pte_wrprotect(*ptep));
+	set_pte_at(mm, addr, ptep, pte_wrprotect(*ptep));
 }
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))


