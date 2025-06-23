Return-Path: <stable+bounces-155348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8157AE3E2E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A07A6BB4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54F23BF9B;
	Mon, 23 Jun 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWOyk1II"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047E238C0C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678999; cv=none; b=t09t794FfR3WltxtGxCLULzeQnBXSlefD+1/OuIjABdSMfqFgrANzpOZbORytvvGPnlF0ab57w9Ve4Q5UEqYOJCO43n8r1PReiw6Q8OuOGYwF9pKEsY204QhPQHgrFKBmmNEziZDiHfAzeWkFJgOnUfaKqxe5oYNg0j7vUKlGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678999; c=relaxed/simple;
	bh=wlZuT0wAKoLzfLuz4UtSKvjuvjWamUoBKYCrGagrSOA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qRQRiQm9HWMZPSptpTjWQsHXWyU9V3vDSyYXWdUbqhAZIz8YWipFz9twSxAUftya3lBRPSMen+p0nO7bTpe+i9CxJyDuc7MZgYcZx04EdHZ19lMwR0RByMBOAE9yLQKmqSKaxlmZTApB0lOPeoD6+fXRcxBMLUoiw4AYCsnmIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWOyk1II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770BDC4CEEA;
	Mon, 23 Jun 2025 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750678996;
	bh=wlZuT0wAKoLzfLuz4UtSKvjuvjWamUoBKYCrGagrSOA=;
	h=Subject:To:Cc:From:Date:From;
	b=zWOyk1II09tLD2q4RDKbgFXWE7Ukp+0eIxMHbjw9OpT1w8IPyj3WV6GDe/bUCl2v+
	 KFSesMLU+fxvFDMwIVBj/TbQYPC4CPU9Qfb3FAjCxCkM6CiUiY784L+f//v7CjHpvg
	 hcfdLe3GkpDhWUymB9Y5E9jztSbx920M2ajZXrn0=
Subject: FAILED: patch "[PATCH] arm64: Restrict pagetable teardown to avoid false warning" failed to apply to 5.15-stable tree
To: dev.jain@arm.com,anshuman.khandual@arm.com,catalin.marinas@arm.com,david@redhat.com,ryan.roberts@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Jun 2025 13:43:04 +0200
Message-ID: <2025062304-prune-getup-2943@gregkh>
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
git cherry-pick -x 650768c512faba8070bf4cfbb28c95eb5cd203f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062304-prune-getup-2943@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 650768c512faba8070bf4cfbb28c95eb5cd203f3 Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Tue, 27 May 2025 13:56:33 +0530
Subject: [PATCH] arm64: Restrict pagetable teardown to avoid false warning

Commit 9c006972c3fe ("arm64: mmu: drop pXd_present() checks from
pXd_free_pYd_table()") removes the pxd_present() checks because the
caller checks pxd_present(). But, in case of vmap_try_huge_pud(), the
caller only checks pud_present(); pud_free_pmd_page() recurses on each
pmd through pmd_free_pte_page(), wherein the pmd may be none. Thus it is
possible to hit a warning in the latter, since pmd_none => !pmd_table().
Thus, add a pmd_present() check in pud_free_pmd_page().

This problem was found by code inspection.

Fixes: 9c006972c3fe ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
Cc: stable@vger.kernel.org
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/r/20250527082633.61073-1-dev.jain@arm.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8fcf59ba39db..00ab1d648db6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1305,7 +1305,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
-		pmd_free_pte_page(pmdp, next);
+		if (pmd_present(pmdp_get(pmdp)))
+			pmd_free_pte_page(pmdp, next);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
 	pud_clear(pudp);


