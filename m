Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD5726AFD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjFGUVj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjFGUVg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596872134
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3579664383
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4B9C433EF;
        Wed,  7 Jun 2023 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169263;
        bh=VWMbQlVBTydQfOAgcWyJNsnZoDMc+LJxmrmPknC6Bpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OW9hSJy6+OYkq9BRDKBuXyEOZwayaE/qKBpX5+F5pDgOpv/tWPelF/OS8qXdT3JGb
         inKEiDxJwV740b+HaDlfP7FHdKsdej3tSM6QF7Y0ieaTlT9LWKoHFM2N1jHdqTPEIC
         lBnqQnS7yS5+nvbxZfVJTmWWZQ+koK6Bw/rHjFic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 015/286] iommu/amd: Add missing domain type checks
Date:   Wed,  7 Jun 2023 22:11:54 +0200
Message-ID: <20230607200923.507514222@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 29f54745f24547a84b18582e054df9bea1a7bf3e ]

Drivers are supposed to list the domain types they support in their
domain_alloc() ops so when we add new domain types, like BLOCKING or SVA,
they don't start breaking.

This ended up providing an empty UNMANAGED domain when the core code asked
for a BLOCKING domain, which happens to be the fallback for drivers that
don't support it, but this is completely wrong for SVA.

Check for the DMA types AMD supports and reject every other kind.

Fixes: 136467962e49 ("iommu: Add IOMMU SVA domain support")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 478da9b4a1b14..8bd5390808784 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2065,7 +2065,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable = amd_iommu_pgtable;
+	int pgtable;
 	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
@@ -2082,6 +2082,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		mode = PAGE_MODE_NONE;
 	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
 		pgtable = AMD_IOMMU_V1;
+	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
+		pgtable = amd_iommu_pgtable;
+	} else {
+		return NULL;
 	}
 
 	switch (pgtable) {
-- 
2.39.2



