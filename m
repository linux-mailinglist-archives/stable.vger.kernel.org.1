Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F77D3103
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjJWLEd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJWLEa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DB10C3
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A556C433C9;
        Mon, 23 Oct 2023 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059068;
        bh=ivrtI1ZHLYv3wsCwrZOws0rK4BN3OBIaxiGXab1wUS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/mcQW9ARtkIw7YL9gYid9fVRM3mjhWcXrF8GMUxj08J3u8zdwMlShus9d7RgfN0b
         2z3OzL9VZ4SlgOfZbCbkhzFWxADAQBPWY2tmb61dYxddEyXWR550Zo5HVCKYf86U8j
         6O773cNYrKYA7puRuT1RKCUMOZ9TPJSgnNLa8OqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 052/241] ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
Date:   Mon, 23 Oct 2023 12:53:58 +0200
Message-ID: <20231023104835.177710411@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 3ebebb2c1eca92a15107b2d7aeff34196fd9e217 upstream.

Make sure to balance the runtime PM operations, including the disable
count, on driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-6-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3620,9 +3620,15 @@ err_disable_regulators:
 
 static void wcd938x_remove(struct platform_device *pdev)
 {
-	struct wcd938x_priv *wcd938x = dev_get_drvdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
+
+	component_master_del(dev, &wcd938x_comp_ops);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 
-	component_master_del(&pdev->dev, &wcd938x_comp_ops);
 	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }


