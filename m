Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43084742C3F
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjF2SqL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjF2SqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7C2D71
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90467615E8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09F3C433C0;
        Thu, 29 Jun 2023 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064365;
        bh=7wwdWGyFfjDDBnQlVbssNn+waZa93z13xjpKnYtD430=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udvd00WC9JguFiW7kcHPEtN0IemY3p/30hS90Ok8wh6xUzOVDGBs/LuPBFavmD9pb
         pg0u7iwOHfTgwlU7SaNVsQO5djIhwHvhHwhwD4AktgLV1n2goy0U7ysNOQXQbbi73/
         z9OoUtBw/B2iYZPGsd1JfDFwjKX3OGBJO9BW0NCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.1 30/30] Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"
Date:   Thu, 29 Jun 2023 20:43:49 +0200
Message-ID: <20230629184152.853039128@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
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

From: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

commit 86edac7d3888c715fe3a81bd61f3617ecfe2e1dd upstream.

This reverts commit f05c7b7d9ea9477fcc388476c6f4ade8c66d2d26.

That change was causing a regression in the generic-adc-thermal-probed
bootrr test as reported in the kernelci-results list [1].
A proper rework will take longer, so revert it for now.

[1] https://groups.io/g/kernelci-results/message/42660

Fixes: f05c7b7d9ea9 ("thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe")
Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230525121811.3360268-1-ricardo.canuelo@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/mtk_thermal.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1028,12 +1028,7 @@ static int mtk_thermal_probe(struct plat
 		return -ENODEV;
 	}
 
-	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
-	if (IS_ERR(auxadc_base)) {
-		of_node_put(auxadc);
-		return PTR_ERR(auxadc_base);
-	}
-
+	auxadc_base = of_iomap(auxadc, 0);
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1049,12 +1044,7 @@ static int mtk_thermal_probe(struct plat
 		return -ENODEV;
 	}
 
-	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
-	if (IS_ERR(apmixed_base)) {
-		of_node_put(apmixedsys);
-		return PTR_ERR(apmixed_base);
-	}
-
+	apmixed_base = of_iomap(apmixedsys, 0);
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);


