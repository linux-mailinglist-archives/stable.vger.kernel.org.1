Return-Path: <stable+bounces-155347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF1AE3E30
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608A4173F24
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E323C390;
	Mon, 23 Jun 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MYSaWGqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176723182D
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678994; cv=none; b=LkMop30sOE1WHNNKCNoZMVMs8iucqk2swyy+jCc7hR6rbtKD6xIwSgasHMTIiqSokax1ko0wLnx1xy9AcPCODm+UcfGDAYcCv54bPVCgyTlIXmpkrvdsafBGGheN6b0MDKOBzWDfFGAKNDUhQD1VpKi8L7bRgW9VA86FEoc89v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678994; c=relaxed/simple;
	bh=K94cpsogGu1p3Q4BCPjXzzQggwikf6HlQaHOqUyS/cY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EfhLSwB/EXOPKS63vHRvOZkyYCpw9OFYD51sejPkJsPXSuQvxI37F2byC+Adjrj0AkG04YNhSTqQWpVVwt/ZJlj2kV2Y2bWb7rKng5ON6kedpDOG3iQvgBUGzZlU/HbXJiw087aGTRQU2nZA815aR8L8GotFVrXn6NaKzc2xvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MYSaWGqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1556C4CEEA;
	Mon, 23 Jun 2025 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750678994;
	bh=K94cpsogGu1p3Q4BCPjXzzQggwikf6HlQaHOqUyS/cY=;
	h=Subject:To:Cc:From:Date:From;
	b=MYSaWGqiCq8z8V7HRXZFdydl4CIb0kftlSmYlRMpe7hkFuqJ087Xr58ys3tNx9VoO
	 U6HBfnLza8d7PqJv5e935qoSTTOpowmC6SgWnmDSX1/UYqRGD79lwuUVSD7UkYkHIk
	 mIbhIrYQyFHW7HPoEKNVqRttai1GV5AP7dabcfVc=
Subject: FAILED: patch "[PATCH] arm64: Restrict pagetable teardown to avoid false warning" failed to apply to 5.10-stable tree
To: dev.jain@arm.com,anshuman.khandual@arm.com,catalin.marinas@arm.com,david@redhat.com,ryan.roberts@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Jun 2025 13:43:03 +0200
Message-ID: <2025062303-spoon-unfrosted-5eee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 650768c512faba8070bf4cfbb28c95eb5cd203f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062303-spoon-unfrosted-5eee@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


