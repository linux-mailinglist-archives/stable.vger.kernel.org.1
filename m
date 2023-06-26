Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5473E81F
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjFZSXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjFZSXB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D819A5
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 105EE60F6F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16800C433C9;
        Mon, 26 Jun 2023 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803702;
        bh=qJnEFAY/vVPuLcjvZ1NZQT2IYN/SI9qiXmPm0kMiciM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqTsz+6VKhqABGKZmCXOXqqD+HGrYOkwru0qwiYskaEfdP+PkOitwEHWh23wRHwqv
         gGA53BZnquMPuKcIGuIpOQ5oDn4s1zV7lf3R64k66e1pqO3r0sM4BjWIegywB64qnI
         kjscXycLKWuSfJaxSbpYLbxFZ11pmPZ0e5VXjo6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Su Hui <suhui@nfschina.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 148/199] iommu/amd: Fix possible memory leak of domain
Date:   Mon, 26 Jun 2023 20:10:54 +0200
Message-ID: <20230626180812.121825464@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 5b00369fcf6d1ff9050b94800dc596925ff3623f ]

Move allocation code down to avoid memory leak.

Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20230608021933.856045-1-suhui@nfschina.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd0e3fb78c3ff..e9eac86cddbd2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2069,10 +2069,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
 	/*
 	 * Force IOMMU v1 page table when iommu=pt and
 	 * when allocating domain for pass-through devices.
@@ -2088,6 +2084,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		return NULL;
 	}
 
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
-- 
2.39.2



