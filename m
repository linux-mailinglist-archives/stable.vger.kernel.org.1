Return-Path: <stable+bounces-155346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B479BAE3E2C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF6F189581A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E764877111;
	Mon, 23 Jun 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXfD1vvM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588723BF9B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678986; cv=none; b=Cff7F06hx7KuYIlWJO6xJiZfGHhc0C/rkGtoXvCMItEPLu7nEUhWYHL0ZdahlzyOdYzH9CpImNhIbztA6YwBxs/jR9Ea5SeKEYVQLkkpVlu6aEDb4xoNOirWSWxGRaMvi0UBH6PAcBK7SA3UQ2HDy4KO51kp1JCy4OYuvupn+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678986; c=relaxed/simple;
	bh=BYuht1JOuBs6qy1eX+lSQ4CBCek4w4e34l8b4h/HetY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dUEwV1mko8tHhkl1Wsgbw+f3hvL+1RIKItwcejjE8rDERvH8LkGrdQFKyZD4mbgxq+jxKnyhEMWS3F8W4r5PA0cBkrm2TRbKyOQyf4xA5q+WhEhk//yteqHisvbqsUU5aj4ENPHifzKNbStS51g0OG3PUFONYUcp2K2MsEPnh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXfD1vvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A5C4CEEA;
	Mon, 23 Jun 2025 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750678986;
	bh=BYuht1JOuBs6qy1eX+lSQ4CBCek4w4e34l8b4h/HetY=;
	h=Subject:To:Cc:From:Date:From;
	b=LXfD1vvMhLvT8Do5iu/AOPEorpiHdY8Wa/oEPhpJAaXc3/me6po2O+W8pV6yRTTEp
	 Hqjn347NfmYqh4xGsoYjs5l9ppH32jlyEFzfC4u5GIlgunEEvwCdgXNfIFLXWwgqZ5
	 NDMK5yH02U1Ia4IZBy2XMkEnR75CKtgqnq7B5mho=
Subject: FAILED: patch "[PATCH] arm64: Restrict pagetable teardown to avoid false warning" failed to apply to 5.4-stable tree
To: dev.jain@arm.com,anshuman.khandual@arm.com,catalin.marinas@arm.com,david@redhat.com,ryan.roberts@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Jun 2025 13:43:03 +0200
Message-ID: <2025062303-unsworn-penpal-7142@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 650768c512faba8070bf4cfbb28c95eb5cd203f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062303-unsworn-penpal-7142@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


