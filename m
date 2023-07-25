Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A259A76137A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjGYLKz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjGYLKf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01A2136
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7317461682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E1C433C9;
        Tue, 25 Jul 2023 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283377;
        bh=qCbDHeZm2q7C4WN7IypEF/PzRSktdCF8+9Q40x0kHmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHN/Bfu8qknjRrD4PyeIG1vwpHWg306SLLFajk9tAni3GYz/t0d6H62d1EWoKx03Q
         qy+QByVxBuWg4AZ7S/3mji4clA5ezH5iNoNaNyIefRE3lv6+Jub/SDArJ9w8qYs83C
         AY/23ySJujWESIyECohpJVo/AOg4lfSewb0KVDf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 27/78] ASoC: codecs: wcd938x: fix soundwire initialisation race
Date:   Tue, 25 Jul 2023 12:46:18 +0200
Message-ID: <20230725104452.368978032@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
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
@@ -4086,9 +4086,18 @@ static int wcd938x_irq_init(struct wcd93
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


