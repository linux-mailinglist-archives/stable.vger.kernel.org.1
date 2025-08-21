Return-Path: <stable+bounces-172113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A880AB2FAF0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9CD582BE5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2423376BE;
	Thu, 21 Aug 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwzAFrWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A383376BA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783235; cv=none; b=uViNLVStHIURWqJRltNqpzok35zEHAMmKvNK4j9n5wzV59Scmg0zGQ/h77G79uD61q97oAUCOpTnb57N5NuAGwEnXOh9SoEqwIyIWZarhKRsJPph1l9HdFyukU/l9YfadDyMbNg3/Je+fLBfwpw7/Bg2MfVwBZEgfaFX7gUG0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783235; c=relaxed/simple;
	bh=V6osLPernkVYoVfkRRhaQ2QdlX30v7mQWhlO3qlX1oU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r6HTRga2RkfKn+zMPrFT4ql0D8vpCb8fU1fT4DdFxJYou23YFbPyb5VFxZElpeYlJrdzkzAOokr0cEDA1U5pTs7YbeV66hdG/jGYhFk/X60ajFjYypf3rOWoKFUvQ2/MC7A2uJ307oyyZlNjn03KdsXOggpdkxbofs97S9Wvby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwzAFrWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D187EC4CEEB;
	Thu, 21 Aug 2025 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783235;
	bh=V6osLPernkVYoVfkRRhaQ2QdlX30v7mQWhlO3qlX1oU=;
	h=Subject:To:Cc:From:Date:From;
	b=TwzAFrWkALLl+aUXFax1GC7EV7L0MgVnJqvhQ2+gBNIiTRBU6WUcAEqRB3uNy4taw
	 l+X0lQTEGiiBtbvwGFcwdHWGJcFb4yeVK/Kloo3iREXLpQJG1NKduAJmP4uoNvXtyF
	 aMrKnJNvR2PThof01vqg/SHmyXRRVQufpEpS7VWw=
Subject: FAILED: patch "[PATCH] parisc: Rename pte_needs_flush() to pte_needs_cache_flush()" failed to apply to 5.15-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:33:44 +0200
Message-ID: <2025082143-crafty-publisher-62f8@gregkh>
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
git cherry-pick -x 52ce9406a9625c4498c4eaa51e7a7ed9dcb9db16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082143-crafty-publisher-62f8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52ce9406a9625c4498c4eaa51e7a7ed9dcb9db16 Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 15:56:04 -0400
Subject: [PATCH] parisc: Rename pte_needs_flush() to pte_needs_cache_flush()
 in cache.c

The local name used in cache.c conflicts the declaration in
include/asm-generic/tlb.h.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index db531e58d70e..3b37a7e7abe4 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -429,7 +429,7 @@ static inline pte_t *get_ptep(struct mm_struct *mm, unsigned long addr)
 	return ptep;
 }
 
-static inline bool pte_needs_flush(pte_t pte)
+static inline bool pte_needs_cache_flush(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_NO_CACHE))
 		== (_PAGE_PRESENT | _PAGE_ACCESSED);
@@ -630,7 +630,7 @@ static void flush_cache_page_if_present(struct vm_area_struct *vma,
 	ptep = get_ptep(vma->vm_mm, vmaddr);
 	if (ptep) {
 		pte = ptep_get(ptep);
-		needs_flush = pte_needs_flush(pte);
+		needs_flush = pte_needs_cache_flush(pte);
 		pte_unmap(ptep);
 	}
 	if (needs_flush)


