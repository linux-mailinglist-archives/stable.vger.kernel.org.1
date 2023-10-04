Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320547B87A5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjJDSHp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjJDSHo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:07:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194D9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:07:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09001C433C7;
        Wed,  4 Oct 2023 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442860;
        bh=8a/inD/FLFUGjgHU1nacZEw2Tbb68Ohb8jAyHuY+/mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0MEpHDDopMRr8s0Y0eHacxpSgwEBr1qHUAmwsWpYn9AJ6tXGKX7HZUOE8mkFgP+3
         NFvylX0K5m5Lkf4h/l7itbcPTUoXeDitLU4VpoH+C6QZypOYf86WBY7nLD/K2Z+MvY
         gdcbkOYUEdQTz8J+VvFj/IaG3KCvBrkiRcl/9KhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chancel Liu <chancel.liu@nxp.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 135/183] ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link
Date:   Wed,  4 Oct 2023 19:56:06 +0200
Message-ID: <20231004175209.599875088@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chancel Liu <chancel.liu@nxp.com>

[ Upstream commit fac58baf8fcfcd7481e8f6d60206ce2a47c1476c ]

i.MX rpmsg sound cards work on codec slave mode. MCLK will be disabled
by CPU DAI driver in hw_free(). Some codec requires MCLK present at
power up/down sequence. So need to set ignore_pmdown_time to power down
codec immediately before MCLK is turned off.

Take WM8962 as an example, if MCLK is disabled before DAPM power down
playback stream, FIFO error will arise in WM8962 which will have bad
impact on playback next.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://lore.kernel.org/r/20230913102656.2966757-1-chancel.liu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-rpmsg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index f96fe4ff8425b..d208b05051fd5 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -66,6 +66,14 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 			    SND_SOC_DAIFMT_NB_NF |
 			    SND_SOC_DAIFMT_CBS_CFS;
 
+	/*
+	 * i.MX rpmsg sound cards work on codec slave mode. MCLK will be
+	 * disabled by CPU DAI driver in hw_free(). Some codec requires MCLK
+	 * present at power up/down sequence. So need to set ignore_pmdown_time
+	 * to power down codec immediately before MCLK is turned off.
+	 */
+	data->dai.ignore_pmdown_time = 1;
+
 	/* Optional codec node */
 	ret = of_parse_phandle_with_fixed_args(np, "audio-codec", 0, 0, &args);
 	if (ret) {
-- 
2.40.1



