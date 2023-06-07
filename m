Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B228726B05
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjFGUVz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjFGUVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C19126B1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA994643C9
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB470C4331D;
        Wed,  7 Jun 2023 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169253;
        bh=zLfvMhzCRef7Z/2K6eYzJSheRJ+Qi9HZ2Y80vKj0kiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tq2xwIvDos8wGLtbpaQCvd7Am6f3CWFvx9lYWTiWmDCtWlrUd0QBUSGDbJLI0Sumu
         cLLhZI5odN/QmZefJ+kjV1RrvRSarAHTjIRtQQin55WFKOo6OAZVRX8mKaXKB3p/Ds
         OqjnEpyrP3Nb6rT8YanoBT2dSYgHSOLcx2JabKIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Wang <D202280639@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 011/286] iommu/rockchip: Fix unwind goto issue
Date:   Wed,  7 Jun 2023 22:11:50 +0200
Message-ID: <20230607200923.364870380@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Wang <D202280639@hust.edu.cn>

[ Upstream commit ec014683c564fb74fc68e8f5e84691d3b3839d24 ]

Smatch complains that
drivers/iommu/rockchip-iommu.c:1306 rk_iommu_probe() warn: missing unwind goto?

The rk_iommu_probe function, after obtaining the irq value through
platform_get_irq, directly returns an error if the returned value
is negative, without releasing any resources.

Fix this by adding a new error handling label "err_pm_disable" and
use a goto statement to redirect to the error handling process. In
order to preserve the original semantics, set err to the value of irq.

Fixes: 1aa55ca9b14a ("iommu/rockchip: Move irq request past pm_runtime_enable")
Signed-off-by: Chao Wang <D202280639@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20230417030421.2777-1-D202280639@hust.edu.cn
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7a..31cd1e2929e9f 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1302,20 +1302,22 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	for (i = 0; i < iommu->num_irq; i++) {
 		int irq = platform_get_irq(pdev, i);
 
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			err = irq;
+			goto err_pm_disable;
+		}
 
 		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
 				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err) {
-			pm_runtime_disable(dev);
-			goto err_remove_sysfs;
-		}
+		if (err)
+			goto err_pm_disable;
 	}
 
 	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
 
 	return 0;
+err_pm_disable:
+	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_put_group:
-- 
2.39.2



