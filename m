Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F776FA603
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjEHKPQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjEHKPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448FB3ACC6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42F562474
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6222C433D2;
        Mon,  8 May 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540913;
        bh=PDufh/iI6PpeM985NOlyt2mzttbmZHePkjpWDnR1t3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfp9IWWwMeMuJhSaXh1VCXX7uguayUKY4D1Zlz8Cg/MDD8XWK0eq4L5g+F4kG2na2
         a2Qs0d/a6kos2nRyR9KGvdQ58TDDXl06nbsPY2W2Fj63TTBuWODRY/IQzoXI0Sqcr7
         5ZlWKFQqFMIqNTbyhyWoLHqmW2Raao3hDCGMVWYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kang Chen <void0red@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 545/611] thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe
Date:   Mon,  8 May 2023 11:46:27 +0200
Message-Id: <20230508094439.715076171@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Kang Chen <void0red@hust.edu.cn>

[ Upstream commit f05c7b7d9ea9477fcc388476c6f4ade8c66d2d26 ]

Smatch reports:
1. mtk_thermal_probe() warn: 'apmixed_base' from of_iomap() not released.
2. mtk_thermal_probe() warn: 'auxadc_base' from of_iomap() not released.

The original code forgets to release iomap resource when handling errors,
fix it by switch to devm_of_iomap.

Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
Signed-off-by: Kang Chen <void0red@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230419020749.621257-1-void0red@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mtk_thermal.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 8440692e3890d..62f1e691659e3 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1028,7 +1028,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = of_iomap(auxadc, 0);
+	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
+	if (IS_ERR(auxadc_base)) {
+		of_node_put(auxadc);
+		return PTR_ERR(auxadc_base);
+	}
+
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1044,7 +1049,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = of_iomap(apmixedsys, 0);
+	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
+	if (IS_ERR(apmixed_base)) {
+		of_node_put(apmixedsys);
+		return PTR_ERR(apmixed_base);
+	}
+
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
-- 
2.39.2



