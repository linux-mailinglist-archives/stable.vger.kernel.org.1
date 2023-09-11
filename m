Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A179B290
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354200AbjIKVwu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbjIKPVw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3148DD8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7288FC433C7;
        Mon, 11 Sep 2023 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445707;
        bh=F2xYqyts/k5qoxtqlAnHEAmuM8+0gdvA34FSnJ+RMpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFyssmaJSRWSggbuodftxslqzRjE7/R87asRU4E2w4iUZOwK8wjqDusGlYLa+fWIV
         m6eEKVqmfJqNs4pr6lob6nyqYeLDoLYjHQmnf/1RxKH5ppIJZQoSlmQnz7AL3bx/6o
         BgmV2hMupTnHz9GZ3Uji6B4teONMtS3WzVTaZjxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 443/600] iommu/sprd: Add missing force_aperture
Date:   Mon, 11 Sep 2023 15:47:56 +0200
Message-ID: <20230911134646.723417381@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit d48a51286c698f7fe8efc688f23a532f4fe9a904 ]

force_aperture was intended to false only by GART drivers that have an
identity translation outside the aperture. This does not describe sprd, so
add the missing 'force_aperture = true'.

Fixes: b23e4fc4e3fa ("iommu: add Unisoc IOMMU basic driver")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/sprd-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index fadd2c907222b..8261066de07d7 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -147,6 +147,7 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = SZ_256M - 1;
+	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
 }
-- 
2.40.1



