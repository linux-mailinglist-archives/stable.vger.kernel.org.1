Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81657611B5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGYKzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGYKyW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7F44A3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B38A616B7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878C2C07616;
        Tue, 25 Jul 2023 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282351;
        bh=DpOJRYfnmcE6Hy9vkDLX+n5ar5jCFUO4Gg36MOE27+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Amc/OGgXrLEeTA4nI9d8BoeHl0nVLxZA5A/DQ+StjzmCtYKhjJQHZeLv++z9oLXC+
         qY498Vcy7DiXnOc4tFnR/DxZYbz5sI16HeCat2EJPxWlDZRSH0OGX4DP+Wri6cXKUi
         nzVyjIFIU2etXqeVwBIY40s8QJDs71YImy9I1fGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 070/227] ASoC: codecs: wcd938x: fix soundwire initialisation race
Date:   Tue, 25 Jul 2023 12:43:57 +0200
Message-ID: <20230725104517.666683119@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 6f49256897083848ce9a59651f6b53fc80462397 upstream.

Make sure that the soundwire device used for register accesses has been
enumerated and initialised before trying to read the codec variant
during component probe.

This specifically avoids interpreting (a masked and shifted) -EBUSY
errno as the variant:

	wcd938x_codec audio-codec: ASoC: error at soc_component_read_no_lock on audio-codec for register: [0x000034b0] -16

in case the soundwire device has not yet been initialised, which in turn
prevents some headphone controls from being registered.

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org	# 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Link: https://lore.kernel.org/r/20230701094723.29379-1-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3090,9 +3090,18 @@ static int wcd938x_irq_init(struct wcd93
 static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 {
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct sdw_slave *tx_sdw_dev = wcd938x->tx_sdw_dev;
 	struct device *dev = component->dev;
+	unsigned long time_left;
 	int ret, i;
 
+	time_left = wait_for_completion_timeout(&tx_sdw_dev->initialization_complete,
+						msecs_to_jiffies(2000));
+	if (!time_left) {
+		dev_err(dev, "soundwire device init timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	snd_soc_component_init_regmap(component, wcd938x->regmap);
 
 	ret = pm_runtime_resume_and_get(dev);


