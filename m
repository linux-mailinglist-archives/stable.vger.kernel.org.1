Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80632755449
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjGPU2o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjGPU2n (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18A126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E09860EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39559C433C7;
        Sun, 16 Jul 2023 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539321;
        bh=ExeXnrQEH0gmbaf5sqLVW+WVCJKswupN3MT5sfyoJs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXNZyGqRoM7/ukgV0qpPYN9Cq0Q1O3ikPItyRqcxledHtmtbFclU6CL7y7xdMs/8S
         4HSf1m3wTytIWUB5/m+DrfLPcZa1Tnb/oXeKhdf/sYoWrhnusFG9cadegAf3Q8ITW9
         awKbmbj/ZC9q8kvxZ8PMQMlW9cvo/fSgpLWWsSrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        stable@kernel.org, Ricardo Ribalda Delgado <ribalda@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 767/800] ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path
Date:   Sun, 16 Jul 2023 21:50:20 +0200
Message-ID: <20230716195006.965485437@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Ricardo Ribalda Delgado <ribalda@chromium.org>

commit a46d37012a5be1737393b8f82fd35665e4556eee upstream.

If the second component fails to initialize, cleanup the first on.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@kernel.org
Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to component")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230612-mt8173-fixup-v2-1-432aa99ce24d@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1160,14 +1160,14 @@ static int mt8173_afe_pcm_dev_probe(stru
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


