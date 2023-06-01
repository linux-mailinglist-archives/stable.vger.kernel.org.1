Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4911719DE5
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjFAN10 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjFAN1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBDBFC
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D569644AB
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA3C433D2;
        Thu,  1 Jun 2023 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626009;
        bh=0eGkgerWLIqgVz1Y1CWJlD6bP0DyEuV56HfFecinMts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEAfE8D2LkNqOAoL2gVRTqc6I+6nDOl/3JgRGKqpdkxTOXDfUDbgGPuBKsxPNYQyR
         pJ8eBWY8bV9kbVIUsDnyetEV17yhvtIFBAHcGEk9L8jQlNuV/l7Yxj/QW00yyjJTK+
         fOunPPaLC6gWd/hl3dlgqboK960sldA6gU45qmas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 39/45] vfio/type1: check pfn valid before converting to struct page
Date:   Thu,  1 Jun 2023 14:21:35 +0100
Message-Id: <20230601131940.489855547@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

[ Upstream commit 4752354af71043e6fd72ef5490ed6da39e6cab4a ]

Check physical PFN is valid before converting the PFN to a struct page
pointer to be returned to caller of vfio_pin_pages().

vfio_pin_pages() pins user pages with contiguous IOVA.
If the IOVA of a user page to be pinned belongs to vma of vm_flags
VM_PFNMAP, pin_user_pages_remote() will return -EFAULT without returning
struct page address for this PFN. This is because usually this kind of PFN
(e.g. MMIO PFN) has no valid struct page address associated.
Upon this error, vaddr_get_pfns() will obtain the physical PFN directly.

While previously vfio_pin_pages() returns to caller PFN arrays directly,
after commit
34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()"),
PFNs will be converted to "struct page *" unconditionally and therefore
the returned "struct page *" array may contain invalid struct page
addresses.

Given current in-tree users of vfio_pin_pages() only expect "struct page *
returned, check PFN validity and return -EINVAL to let the caller be
aware of IOVAs to be pinned containing PFN not able to be returned in
"struct page *" array. So that, the caller will not consume the returned
pointer (e.g. test PageReserved()) and avoid error like "supervisor read
access in kernel mode".

Fixes: 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()")
Cc: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230519065843.10653-1-yan.y.zhao@intel.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 493c31de0edb9..0620dbe5cca0c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -860,6 +860,11 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 		if (ret)
 			goto pin_unwind;
 
+		if (!pfn_valid(phys_pfn)) {
+			ret = -EINVAL;
+			goto pin_unwind;
+		}
+
 		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn);
 		if (ret) {
 			if (put_pfn(phys_pfn, dma->prot) && do_accounting)
-- 
2.39.2



