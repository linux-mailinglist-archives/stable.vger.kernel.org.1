Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95D67BDD30
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376724AbjJINIS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbjJINIR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E879C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1893FC433C7;
        Mon,  9 Oct 2023 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856895;
        bh=lAN8x9K8fBhye9sJsF1Tvik9GDRyszA47lZl4z35bzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1atmBRnb6x1BiUC6zgCumhDe6AbSEWHxv+IK6gcUd/yvGtvIuNo4DacRll6HQWni
         4N/O9ekWokFeIi1xhfAzFQjjCz/tES6Q7ETY4Bo7CNJHm46r3KbpYGHNloRtiJxT6e
         jGR2qPOtppL7ZbRnzQu0Ab7UxHhcuwpxP+MS96NA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, regressions@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.5 026/163] iommu/apple-dart: Handle DMA_FQ domains in attach_dev()
Date:   Mon,  9 Oct 2023 14:59:50 +0200
Message-ID: <20231009130124.730201469@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hector Martin <marcan@marcan.st>

commit c7bd8a1f45bada7725d11266df7fd5cb549b3098 upstream.

Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
introduced in iommu_dma_init_domain() to fall back if not supported, but
this check runs too late: by that point, devices have been attached to
the IOMMU, and apple-dart's attach_dev() callback does not expect
IOMMU_DOMAIN_DMA_FQ domains.

Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
instead of explicitly enumerating all types.

Fixes an apple-dart regression in v6.5.

Cc: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/apple-dart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 2082081402d3..0b8927508427 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 		return ret;
 
 	switch (domain->type) {
-	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_UNMANAGED:
+	default:
 		ret = apple_dart_domain_add_streams(dart_domain, cfg);
 		if (ret)
 			return ret;
-- 
2.42.0



