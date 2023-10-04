Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EBE7B8740
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjJDSDM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbjJDSDL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:03:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37750A9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675C4C433C8;
        Wed,  4 Oct 2023 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442587;
        bh=oToyiThT9VsH96w4U7z7QkHsZOsJSNzbCtD2L+zknPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2nBsinyC96r7eJODmDhOQKfvTykQ2EKupd4WNGqoajrhUiq0jIf4IoVDBwBJ3CBf
         Rvof0l8JH9WXI+m7CxCVEBR2KUXIB81wImRJa3/86YYZjHT61eJ+8M8WHoJIHmglRX
         R5xubWzWHglhRM5PEE9wGxL4W9UQs34MDBwBQTa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 039/183] ASoC: imx-audmix: Fix return error with devm_clk_get()
Date:   Wed,  4 Oct 2023 19:54:30 +0200
Message-ID: <20231004175205.594334499@linuxfoundation.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit b19a5733de255cabba5feecabf6e900638b582d1 ]

The devm_clk_get() can return -EPROBE_DEFER error,
modify the error code to be -EINVAL is not correct, which
cause the -EPROBE_DEFER error is not correctly handled.

This patch is to fix the return error code.

Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index d991e457060c7..0363255c39ea9 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -320,7 +320,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->cpu_mclk)) {
 		ret = PTR_ERR(priv->cpu_mclk);
 		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	priv->audmix_pdev = audmix_pdev;
-- 
2.40.1



