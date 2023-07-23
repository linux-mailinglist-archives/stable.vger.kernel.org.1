Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1D75E4D5
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 22:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGWUaX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWUaW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 16:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F25CE4E
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46B260E9D
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 20:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9FCC433C8;
        Sun, 23 Jul 2023 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690144220;
        bh=Q8a4onfKFC+QFMcnLwPcZRKcyrUnCgRPkU5Jsx4vHXM=;
        h=Subject:To:Cc:From:Date:From;
        b=wiRrUOzmNDIRIK1J8pQYF2Tqh0Y7k8icnfWjcG55elrh1NG8f8NpkE/IyuUeVO8M3
         ryr2jiupQDTpnRoZN3ANlkPMWkB/sZBp6PmVqggIXSPvI+hRAfRuNRfqChQYGEhzm2
         QKQ8ewX+i9iLeyeg0vfACf4FAsBp32E7SEgc3KuA=
Subject: FAILED: patch "[PATCH] ASoC: mediatek: mt8173: Fix irq error path" failed to apply to 5.4-stable tree
To:     ribalda@chromium.org, angelogioacchino.delregno@collabora.com,
        broonie@kernel.org, dan.carpenter@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 22:30:16 +0200
Message-ID: <2023072316-squatting-handiness-1c06@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f9c058d14f4fe23ef523a7ff73734d51c151683c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072316-squatting-handiness-1c06@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f9c058d14f4f ("ASoC: mediatek: mt8173: Fix irq error path")
4cbb264d4e91 ("ASoC: mediatek: mt8173: Enable IRQ when pdata is ready")
8c32984bc7da ("ASoC: mediatek: mt8173: Fix debugfs registration for components")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9c058d14f4fe23ef523a7ff73734d51c151683c Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda Delgado <ribalda@chromium.org>
Date: Mon, 12 Jun 2023 11:05:32 +0200
Subject: [PATCH] ASoC: mediatek: mt8173: Fix irq error path

After reordering the irq probe, the error path was not properly done.
Lets fix it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@kernel.org
Fixes: 4cbb264d4e91 ("ASoC: mediatek: mt8173: Enable IRQ when pdata is ready")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230612-mt8173-fixup-v2-2-432aa99ce24d@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index ff25c44070a3..06269f7e3756 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1070,6 +1070,10 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = &pdev->dev;
 
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id <= 0)
+		return irq_id < 0 ? irq_id : -ENXIO;
+
 	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(afe->base_addr))
 		return PTR_ERR(afe->base_addr);
@@ -1175,14 +1179,11 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_components;
 
-	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0)
-		return irq_id < 0 ? irq_id : -ENXIO;
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
 	if (ret) {
 		dev_err(afe->dev, "could not request_irq\n");
-		goto err_pm_disable;
+		goto err_cleanup_components;
 	}
 
 	dev_info(&pdev->dev, "MT8173 AFE driver initialized.\n");

