Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E426E70C65A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjEVTRO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjEVTRH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB8115
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F84462796
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B537C433D2;
        Mon, 22 May 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783024;
        bh=yZYhrSzDOY/1TTmI7EepUGUId2YEVs/hXS25iVhQoMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2EWosJVaMfFQJWOtr3W7MCm9U2256Tiq2WH00WJAPIBekJEbYGtjeQ/Kv2qwWUh7H
         /EUMa4cGLQFpGvNMsXWZPjsl9ERlZai6x8eap7K5dI28ZXR7kLzQkOfhjrXMbHjihf
         3vibAEI6cRXQIQF0cpJDrFC9hCQj8bYS6HfWEl7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 114/203] ASoC: fsl_micfil: Fix error handler with pm_runtime_enable
Date:   Mon, 22 May 2023 20:08:58 +0100
Message-Id: <20230522190358.136409809@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 17955aba7877a4494d8093ae5498e19469b01d57 ]

There is error message when defer probe happens:

fsl-micfil-dai 30ca0000.micfil: Unbalanced pm_runtime_enable!

Fix the error handler with pm_runtime_enable and add
fsl_micfil_remove() for pm_runtime_disable.

Fixes: 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com
Link: https://lore.kernel.org/r/1683540996-6136-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 38d4d1b7cfe39..acc820da46ebf 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -763,7 +763,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to pcm register\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_micfil_component,
@@ -771,9 +771,20 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register component %s\n",
 			fsl_micfil_component.name);
+		goto err_pm_disable;
 	}
 
 	return ret;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static void fsl_micfil_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused fsl_micfil_runtime_suspend(struct device *dev)
@@ -834,6 +845,7 @@ static const struct dev_pm_ops fsl_micfil_pm_ops = {
 
 static struct platform_driver fsl_micfil_driver = {
 	.probe = fsl_micfil_probe,
+	.remove_new = fsl_micfil_remove,
 	.driver = {
 		.name = "fsl-micfil-dai",
 		.pm = &fsl_micfil_pm_ops,
-- 
2.39.2



