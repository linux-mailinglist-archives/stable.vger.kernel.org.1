Return-Path: <stable+bounces-155349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA7AE3E2F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0FA3AD6EF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23B23ED68;
	Mon, 23 Jun 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1M8YMBMz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A10238C0C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679000; cv=none; b=rbnVuYOXAk489k0vMUMDAYpFmN2oL5eeXvJRSX4P6mx2+pJnUQV2Ps9r7CRwLONRuawz+nhLevHEO/TFxj4Uec5MT06dTi88CSX3vVUfSEqtAMSQUKzAWbMtTlQLCO0wefarazL2T/dqQOJiRBsZM1KK/psdY2nUs49GnNLbUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679000; c=relaxed/simple;
	bh=WgncQhowb8T0klSpFUbD5AcUYxFI1ZvceqEgY7urWXs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ONfB9y8JX8DaN1VXC8EUyD5AzlZ6MKFzA3EDjAshHE9pjlycyFtAk2k6Xokqn3lrO7lk+Ox3jMduAr26emt7gU+9etJtjitpwG/w8GJOI9AbffhsL8fHAgGZSrV4WijKX+dVI8CZVm5OC5vhdIE69ymkPOhguLETABcYev8qZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1M8YMBMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B9EC4CEF0;
	Mon, 23 Jun 2025 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750678999;
	bh=WgncQhowb8T0klSpFUbD5AcUYxFI1ZvceqEgY7urWXs=;
	h=Subject:To:Cc:From:Date:From;
	b=1M8YMBMzgLyyWubW/a52786eaJxQbFCtRYFxmRn06TYVuwZtdtDed9Mr/h0pvmUTK
	 KAKo0m+BQs4JcXKutZJJVdYS8m2sVhh8oIHLqU5taGlItna4ltTlGwJvgcpb8MccuY
	 7WrmJT9SoSYdOq21viTBgVEF/8qAIIAsQBj1Qjrw=
Subject: FAILED: patch "[PATCH] arm64: Restrict pagetable teardown to avoid false warning" failed to apply to 6.1-stable tree
To: dev.jain@arm.com,anshuman.khandual@arm.com,catalin.marinas@arm.com,david@redhat.com,ryan.roberts@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Jun 2025 13:43:04 +0200
Message-ID: <2025062304-oyster-overhang-6204@gregkh>
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
git cherry-pick -x 650768c512faba8070bf4cfbb28c95eb5cd203f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062304-oyster-overhang-6204@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


