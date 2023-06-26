Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79673E84A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjFZSYI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjFZSXw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE92126
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA3F60F5D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF5C433C8;
        Mon, 26 Jun 2023 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803794;
        bh=OqNyedVHswv5NRPSh0HF6uIm6eUiggJvMRqWkj+Shr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/HF0ywbBss345ENNNMo6RNEUNOQzfrMPXIp07rfl6sh6tUXecV3oUJzBhWNX2ZeF
         ozV1FDkfBEVRY3Zzsu2H6zFW1nTfO4KlNnEr/vtI1tFZO0lKrRfGFH1wIrBtg2Oxqn
         9nuwOZk3RQhdlAoSl9nxfolgmZvbAIM0HXiiGK9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chancel Liu <chancel.liu@nxp.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 179/199] ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted
Date:   Mon, 26 Jun 2023 20:11:25 +0200
Message-ID: <20230626180813.606904399@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Chancel Liu <chancel.liu@nxp.com>

[ Upstream commit 32cf0046a652116d6a216d575f3049a9ff9dd80d ]

There's an issue on SAI synchronous mode that TX/RX side can't get BCLK
from RX/TX it sync with if BYP bit is asserted. It's a workaround to
fix it that enable SION of IOMUX pad control and assert BCI.

For example if TX sync with RX which means both TX and RX are using clk
form RX and BYP=1. TX can get BCLK only if the following two conditions
are valid:
1. SION of RX BCLK IOMUX pad is set to 1
2. BCI of TX is set to 1

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://lore.kernel.org/r/20230530103012.3448838-1-chancel.liu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 11 +++++++++--
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 990bba0be1fb1..8a64f3c1d1556 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -491,14 +491,21 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	regmap_update_bits(sai->regmap, reg, FSL_SAI_CR2_MSEL_MASK,
 			   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
 
-	if (savediv == 1)
+	if (savediv == 1) {
 		regmap_update_bits(sai->regmap, reg,
 				   FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
 				   FSL_SAI_CR2_BYP);
-	else
+		if (fsl_sai_dir_is_synced(sai, adir))
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+					   FSL_SAI_CR2_BCI, FSL_SAI_CR2_BCI);
+		else
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+					   FSL_SAI_CR2_BCI, 0);
+	} else {
 		regmap_update_bits(sai->regmap, reg,
 				   FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
 				   savediv / 2 - 1);
+	}
 
 	if (sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		/* SAI is in master mode at this point, so enable MCLK */
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 197748a888d5f..a53c4f0e25faf 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -116,6 +116,7 @@
 
 /* SAI Transmit and Receive Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
+#define FSL_SAI_CR2_BCI		BIT(28)
 #define FSL_SAI_CR2_MSEL_MASK	(0x3 << 26)
 #define FSL_SAI_CR2_MSEL_BUS	0
 #define FSL_SAI_CR2_MSEL_MCLK1	BIT(26)
-- 
2.39.2



