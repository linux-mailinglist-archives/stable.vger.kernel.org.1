Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1F761690
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjGYLkZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjGYLkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5F1FC2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 681396156E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C7CC433B9;
        Tue, 25 Jul 2023 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285210;
        bh=MO0uyxFgUDb4VQhYerPQ5URvu2DlAFJz2joEd8nYHOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlJBmc8VG7kpKyC8Cpq+YkLLVKvdYB11fOv2LCbfKvDEIOnOidscIOb8a1bdCUZlk
         d/etEy3kV/CcOP323+G//AjVhXNEDnhttWgRc5QlUbPvtLLHs0bIt0CI41+LPKgybh
         FZQlQK2ErpaOqGc7gFMCaygcVEh2l5zZ0bwHAPZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 094/313] ASoC: imx-audmix: check return value of devm_kasprintf()
Date:   Tue, 25 Jul 2023 12:44:07 +0200
Message-ID: <20230725104525.034147437@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 2f76e1d6ca524a888d29aafe29f2ad2003857971 ]

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230614121509.443926-1-claudiu.beznea@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 71590ca6394b9..08c044a72250a 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -230,6 +230,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
 					  fe_name_pref, args.np->full_name + 1);
+		if (!dai_name)
+			return -ENOMEM;
 
 		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
 
@@ -238,6 +240,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 			capture_dai_name =
 				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 					       dai_name, "CPU-Capture");
+			if (!capture_dai_name)
+				return -ENOMEM;
 		}
 
 		priv->dai[i].cpus = &dlc[0];
@@ -268,6 +272,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 				       "AUDMIX-Playback-%d", i);
 		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				       "AUDMIX-Capture-%d", i);
+		if (!be_name || !be_pb || !be_cp)
+			return -ENOMEM;
 
 		priv->dai[num_dai + i].cpus = &dlc[3];
 		priv->dai[num_dai + i].codecs = &dlc[4];
@@ -295,6 +301,9 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dapm_routes[i].source =
 			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 				       dai_name, "CPU-Playback");
+		if (!priv->dapm_routes[i].source)
+			return -ENOMEM;
+
 		priv->dapm_routes[i].sink = be_pb;
 		priv->dapm_routes[num_dai + i].source   = be_pb;
 		priv->dapm_routes[num_dai + i].sink     = be_cp;
-- 
2.39.2



