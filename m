Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EA74A6A6
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 00:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGFWSk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 18:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFWSk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 18:18:40 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F51B6
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 15:18:39 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5635a80f367so125198eaf.0
        for <stable@vger.kernel.org>; Thu, 06 Jul 2023 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688681918; x=1691273918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bu4ArN757zrK6429dA+5bQX13DVBTagf2yg0iXGGPcU=;
        b=QknGzXf7i6AU7TTviRyC3tzzf+EQYyXQjMOkPUfvQ7s4nJG1+MllzFOfQ79sOLX0DO
         muej3qCZuuVYAJO+ErY1H3BCZ+EKAmGx76ieSBR+ev+pof711p43KhdzBaNou6DhNjND
         Ehe+HnPka0Tf95GS12lg5/ka78XThImyXtd2HKRVgmKTrq11V4ko1miWO+BZjccvcsiI
         ccuFGU6171Ib/rxRELkGlMrw8L4xcMr1aJOBKMIt8VgBuAmAFlsESL3MvSkVS1yoVGwL
         A6w9HCgfRTtIxK3C/yh+8hRa2zJCXqYXo0nY7SckAGj31tcphKmhGnrsvwkDXsYxlBis
         EDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688681918; x=1691273918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu4ArN757zrK6429dA+5bQX13DVBTagf2yg0iXGGPcU=;
        b=Ge0AmCg7OV/ys+ZMx+pFzKnVi4lMuXum7L01HrCLTOFO46wruR6NgusK39bndCBaZX
         3I6sFa6FnQz47GOiUnQKw2Hmmm8sK+ja+sW7SE4A/xmLYDZLkayaBJEXzG4sLi4yHGtp
         bw0kbxXvoBJkFOCoyZndzcqu4k5GsRWLuIRAhFCkQVhYskK0HHL9QnAtipmnYG882QbE
         IMrsEkBfJIM9cTP92WerZD2ZOnR5ZtLGOM7XVF462ZkpOpsi5LTUEhfraG3gcssuxzvb
         z6VyCnKQ7bEdOotoxgpms2T1hkQsp6QQbZSJ6o8qehcdk53PQiceNTnykdFAUaINEmCv
         5Xlg==
X-Gm-Message-State: ABy/qLaQ5MvZzM7AqiHJO/VxcZEIQZt1A61CcXrssuH2CRF5dxRns0zD
        4AbrVoEeNcnpe+0fhesXmbQ=
X-Google-Smtp-Source: APBJJlHS7EV2bmXMGM2r/VB1wrv4UFoC7vNpA114sabEnY7BGHNtjRyj+Oi6h4CO77mm9NagfbHJ5g==
X-Received: by 2002:a4a:c4c4:0:b0:563:3b56:5dc1 with SMTP id g4-20020a4ac4c4000000b005633b565dc1mr2269131ooq.0.1688681918360;
        Thu, 06 Jul 2023 15:18:38 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:da08:7cc0:c10e:810f])
        by smtp.gmail.com with ESMTPSA id bg30-20020a056820081e00b00558c88d131asm1005708oob.36.2023.07.06.15.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 15:18:37 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        andreas@fatal.se, hans.soderlund@realbit.se,
        Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"
Date:   Thu,  6 Jul 2023 19:18:27 -0300
Message-Id: <20230706221827.1938990-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

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
2.34.1

