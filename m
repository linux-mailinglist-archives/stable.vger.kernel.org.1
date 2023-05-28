Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B4713D52
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjE1TYJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjE1TYI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:24:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70043B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC4D61BA7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD62C433EF;
        Sun, 28 May 2023 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301846;
        bh=zHAYHZ3I3PBKqoRHkwu96WrEYje4FitCYLS1suAjxpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlnDfkrQ68DBjinCJUjJ2Yjvad1XXml6LXGbeInyYc3G+3xWEncna+6s9a7dMF5cI
         frMs1REFJqWfEK8MyM8AP08AiXXBkIpiRb7SrBxDMoONFvRszIH01xc39f7mJ8hTcN
         i/pJK1PGkQkntCnkgpRBJB4QsoM+kX7qxrGf7xzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 059/161] ASoC: fsl_micfil: register platform component before registering cpu dai
Date:   Sun, 28 May 2023 20:09:43 +0100
Message-Id: <20230528190839.066519672@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 0adf292069dcca8bab76a603251fcaabf77468ca ]

There is no defer probe when adding platform component to
snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()

snd_soc_register_card()
  -> snd_soc_bind_card()
    -> snd_soc_add_pcm_runtime()
      -> adding cpu dai
      -> adding codec dai
      -> adding platform component.

So if the platform component is not ready at that time, then the
sound card still registered successfully, but platform component
is empty, the sound card can't be used.

As there is defer probe checking for cpu dai component, then register
platform component before cpu dai to avoid such issue.

Fixes: 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1630665006-31437-4-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index b33746d586337..6285ee8f829e5 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -740,18 +740,23 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
+	/*
+	 * Register platform component before registering cpu dai for there
+	 * is not defer probe for platform component in snd_soc_add_pcm_runtime().
+	 */
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to pcm register\n");
+		return ret;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
 					      &fsl_micfil_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register component %s\n",
 			fsl_micfil_component.name);
-		return ret;
 	}
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
-	if (ret)
-		dev_err(&pdev->dev, "failed to pcm register\n");
-
 	return ret;
 }
 
-- 
2.39.2



