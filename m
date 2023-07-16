Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D138754E58
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPKUn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGPKUm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FAB1BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A92060C79
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692B9C433C7;
        Sun, 16 Jul 2023 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502840;
        bh=qPmvF4ZTCQ7WmgZi3MRqraOHfq1qg4JAxrHLfEVy7wQ=;
        h=Subject:To:Cc:From:Date:From;
        b=qVVTCVwVie0m6SDUX3UJHWihIWfjan/5762Is32HFOEXfM3wA8zd6yaekG4O7UROz
         /G7aPqyXx4uO1aEwMYrxeIPIRRAZww/hC8EBLMOcjJAjkzbT80ZxdlMQc6yNfvRz3+
         AUdUcF97YmCl864A3eqrWWtmQzPYD/oI+Sg0gBzQ=
Subject: FAILED: patch "[PATCH] ASoC: mediatek: mt8173: Fix snd_soc_component_initialize" failed to apply to 5.4-stable tree
To:     ribalda@chromium.org, angelogioacchino.delregno@collabora.com,
        broonie@kernel.org, dan.carpenter@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:20:38 +0200
Message-ID: <2023071637-hankering-crop-89ef@gregkh>
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
git cherry-pick -x a46d37012a5be1737393b8f82fd35665e4556eee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071637-hankering-crop-89ef@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

a46d37012a5b ("ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path")
8c32984bc7da ("ASoC: mediatek: mt8173: Fix debugfs registration for components")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a46d37012a5be1737393b8f82fd35665e4556eee Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda Delgado <ribalda@chromium.org>
Date: Mon, 12 Jun 2023 11:05:31 +0200
Subject: [PATCH] ASoC: mediatek: mt8173: Fix snd_soc_component_initialize
 error path

If the second component fails to initialize, cleanup the first on.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@kernel.org
Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to component")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230612-mt8173-fixup-v2-1-432aa99ce24d@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index f93c2ec8beb7..ff25c44070a3 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1156,14 +1156,14 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	comp_hdmi = devm_kzalloc(&pdev->dev, sizeof(*comp_hdmi), GFP_KERNEL);
 	if (!comp_hdmi) {
 		ret = -ENOMEM;
-		goto err_pm_disable;
+		goto err_cleanup_components;
 	}
 
 	ret = snd_soc_component_initialize(comp_hdmi,
 					   &mt8173_afe_hdmi_dai_component,
 					   &pdev->dev);
 	if (ret)
-		goto err_pm_disable;
+		goto err_cleanup_components;
 
 #ifdef CONFIG_DEBUG_FS
 	comp_hdmi->debugfs_prefix = "hdmi";

