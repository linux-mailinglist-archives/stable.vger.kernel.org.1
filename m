Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619F723184
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjFEUi7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjFEUi6 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Mon, 5 Jun 2023 16:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF0113
        for <Stable@vger.kernel.org>; Mon,  5 Jun 2023 13:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F5762152
        for <Stable@vger.kernel.org>; Mon,  5 Jun 2023 20:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF441C433EF;
        Mon,  5 Jun 2023 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685997536;
        bh=iWJZYrpNEfk6+sz0sAuodGqoZWuRBNK6cvqRui5ECfc=;
        h=Subject:To:Cc:From:Date:From;
        b=lF+mTX1O7Pndu+VNjH8TmW+N5+VSNNE2XAfU4Py+Rz8Eo56q9JiGkCWAGOZBlF47Q
         bglfkZKRlOwW5IXpRmdIcCYubHjHULNzPe8MkuoMlr0Du58fGkk5n/EMODCutgQhhe
         H7k0rPnnyDliTDE0ZiBbQBZ2FyVuiCKXbScHiIFU=
Subject: FAILED: patch "[PATCH] iommu/amd/pgtbl_v2: Fix domain max address" failed to apply to 6.3-stable tree
To:     vasant.hegde@amd.com, Stable@vger.kernel.org, jroedel@suse.de,
        jsnitsel@redhat.com, suravee.suthikulpanit@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 05 Jun 2023 22:38:48 +0200
Message-ID: <2023060548-rake-strongman-fdbe@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060548-rake-strongman-fdbe@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11c439a19466e7feaccdbce148a75372fddaf4e9 Mon Sep 17 00:00:00 2001
From: Vasant Hegde <vasant.hegde@amd.com>
Date: Thu, 18 May 2023 05:43:51 +0000
Subject: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address

IOMMU v2 page table supports 4 level (47 bit) or 5 level (56 bit) virtual
address space. Current code assumes it can support 64bit IOVA address
space. If IOVA allocator allocates virtual address > 47/56 bit (depending
on page table level) then it will do wrong mapping and cause invalid
translation.

Hence adjust aperture size to use max address supported by the page table.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
Cc: <Stable@vger.kernel.org>  # v6.0+
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20230518054351.9626-1-vasant.hegde@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0f3ac4b489d6..dc1ec6849775 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2129,6 +2129,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	return NULL;
 }
 
+static inline u64 dma_max_address(void)
+{
+	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+		return ~0ULL;
+
+	/* V2 with 4/5 level page table */
+	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
+}
+
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
@@ -2145,7 +2154,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
 
 	return &domain->domain;

