Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7F76116F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGYKv3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGYKvD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFC91FCE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA3D61681
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3919FC433C8;
        Tue, 25 Jul 2023 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282238;
        bh=YVEcK3pOwhjGe0W3cqFId/pAgruqrFA6zREz1RpUdQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBhxo/pmMwEliIb1Ny64B4lJkYxJdgDPnqRano6h6BQ+hxuX8RvqcC5v/5SIGxf/f
         5ScGo65BYAXzpBB7Mngv3qa7/L/a/gNBZzDOGwRGdTFRa5kIcxz1kP/7y01+ngVXTt
         qaPwdnyG/3XVy8zblwqKf2T/c8pQNtK6ga9gAhh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Henriksson <andreas@fatal.se>,
        Fabio Estevam <festevam@denx.de>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 057/227] ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"
Date:   Tue, 25 Jul 2023 12:43:44 +0200
Message-ID: <20230725104517.127179963@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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
 sound/soc/fsl/fsl_sai.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -507,12 +507,6 @@ static int fsl_sai_set_bclk(struct snd_s
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
 


