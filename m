Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE240742C7B
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF2St1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjF2StM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125E30F0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA21615FF
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E2C433C8;
        Thu, 29 Jun 2023 18:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064543;
        bh=K+MzIwaoPyUU2Hhc0WU9WICu6rpHqVPJ91hE5j2Pfs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr5TQrh914nf5rovCECKtzNq4fDpfM4DsDl4YXU+aONrX3Uf2AZ+tmAb6DCnlOcbk
         RR1lSZ+MM2FVMmlQeHg/09iGD8EAkQsocsHrRxdoRvCxd6R+FNEUjPbnPD3NM8X2Zj
         2CA97VT3pEmIwldG6Fv2wfzi75GpTGMQ1ZOpXPFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.4 28/28] Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"
Date:   Thu, 29 Jun 2023 20:44:16 +0200
Message-ID: <20230629184152.971745659@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
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
 drivers/thermal/mediatek/auxadc_thermal.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1222,12 +1222,7 @@ static int mtk_thermal_probe(struct plat
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
@@ -1243,12 +1238,7 @@ static int mtk_thermal_probe(struct plat
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


