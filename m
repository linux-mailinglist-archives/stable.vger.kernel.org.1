Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C37775C1F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjHILYH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjHILYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C26FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CB26323F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4265FC433C8;
        Wed,  9 Aug 2023 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580245;
        bh=E7GGSJlgCxpYtIeRAJF+inTBdHE7dtcWrCLR0DVx1ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahaFwkRirZmfhOa+xo32yIhlQI9oARs5MyPQYoXtADeWOny2uYV5Z+sP33zNYZo2D
         BLAjb55oYs5YzKDNYzTI2sLFe2okjkML7VhiGhwAEcWGRCj065HgH/DuQQEgmRxT1f
         UM5jB7uHON7vwGOK7RNq0BZIyG1YE/IUyjFInzpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 280/323] ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register
Date:   Wed,  9 Aug 2023 12:41:58 +0200
Message-ID: <20230809103710.859192546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit f061e2be8689057cb4ec0dbffa9f03e1a23cdcb2 upstream.

The WM8904_ADC_TEST_0 register is modified as part of updating the OSR
controls but does not have a cache default, leading to errors when we try
to modify these controls in cache only mode with no prior read:

wm8904 3-001a: ASoC: error at snd_soc_component_update_bits on wm8904.3-001a for register: [0x000000c6] -16

Add a read of the register to probe() to fill the cache and avoid both the
error messages and the misconfiguration of the chip which will result.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230723-asoc-fix-wm8904-adc-test-read-v1-1-2cdf2edd83fd@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wm8904.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2264,6 +2264,9 @@ static int wm8904_i2c_probe(struct i2c_c
 	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
+	/* Fill the cache for the ADC test register */
+	regmap_read(wm8904->regmap, WM8904_ADC_TEST_0, &val);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);


