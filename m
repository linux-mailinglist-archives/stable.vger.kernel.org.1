Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB97612A5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjGYLEm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjGYLE3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE25FD9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F016164D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A432DC433C7;
        Tue, 25 Jul 2023 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282896;
        bh=EuYZDRqvaRDTXZe54PnMnFdlT0OO8E4mdcFCHt03pfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmfU7JJdXplDjGr01hSa76Bgz+tU10BawjR1xM8YgVNb7c9EI9wy6aEr8AmSEKSdJ
         oljOTLMpIKFbprCb/m0xYq0MC5Mdk5Xu1KZRNwnB3DiH0NxTdUr7a3AwZqOfFzNRqo
         komwQ3o47/hYynxgjcO8K3xeNFCFUjuA1uFdwE3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Henriksson <andreas@fatal.se>,
        Fabio Estevam <festevam@denx.de>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 037/183] ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"
Date:   Tue, 25 Jul 2023 12:44:25 +0200
Message-ID: <20230725104509.275093624@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Fabio Estevam <festevam@denx.de>

commit 86867aca7330e4fbcfa2a117e20b48bbb6c758a9 upstream.

This reverts commit ff87d619ac180444db297f043962a5c325ded47b.

Andreas reports that on an i.MX8MP-based system where MCLK needs to be
used as an input, the MCLK pin is actually an output, despite not having
the 'fsl,sai-mclk-direction-output' property present in the devicetree.

This is caused by commit ff87d619ac18 ("ASoC: fsl_sai: Enable
MCTL_MCLK_EN bit for master mode") that sets FSL_SAI_MCTL_MCLK_EN
unconditionally for imx8mm/8mn/8mp/93, causing the MCLK to always
be configured as output.

FSL_SAI_MCTL_MCLK_EN corresponds to the MOE (MCLK Output Enable) bit
of register MCR and the drivers sets it when the
'fsl,sai-mclk-direction-output' devicetree property is present.

Revert the commit to allow SAI to use MCLK as input as well.

Cc: stable@vger.kernel.org
Fixes: ff87d619ac18 ("ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode")
Reported-by: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://lore.kernel.org/r/20230706221827.1938990-1-festevam@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_sai.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5e09f634c61b..54b4bf3744c6 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -507,12 +507,6 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 				   savediv / 2 - 1);
 	}
 
-	if (sai->soc_data->max_register >= FSL_SAI_MCTL) {
-		/* SAI is in master mode at this point, so enable MCLK */
-		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
-				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
-	}
-
 	return 0;
 }
 
-- 
2.41.0



