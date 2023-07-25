Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247576120D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGYK7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjGYK6O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD841BD7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D546168A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14320C433C8;
        Tue, 25 Jul 2023 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282533;
        bh=nIQ4YBRHmPVAtle3mFBtgXxKRh1Hb9Iu5x34z0wIWOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkKBqVdomFXoBfwRHW9nK/sTVxsdztIWqnde0zm2bSx2twgHDVw+c/4H+jWqyJ0uD
         2xl5EI8rfbL+W6BosnRdRy6oZ+bB7TirqJOgYYOSCP3S/Rgc5zWpd+fE+KnBZq6ilK
         Yuj7uveL+c1ZewjsBKVLiI0Csyp6Iqaqj+yVHHfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 135/227] ASoC: codecs: wcd938x: fix mbhc impedance loglevel
Date:   Tue, 25 Jul 2023 12:45:02 +0200
Message-ID: <20230725104520.446159664@linuxfoundation.org>
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

[ Upstream commit e5ce198bd5c6923b6a51e1493b1401f84c24b26d ]

Demote the MBHC impedance measurement printk, which is not an error
message, from error to debug level.

While at it, fix the capitalisation of "ohm" and add the missing space
before the opening parenthesis.

Fixes: bcee7ed09b8e ("ASoC: codecs: wcd938x: add Multi Button Headset Control support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230630142717.5314-2-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 0ff8f784b5eca..8bb6a5ff7b0f6 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2165,8 +2165,8 @@ static inline void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 	else if (x1 < minCode_param[noff])
 		*zdet = WCD938X_ZDET_FLOATING_IMPEDANCE;
 
-	pr_err("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d(milliOhm)\n",
-		__func__, d1, c1, x1, *zdet);
+	pr_debug("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d (milliohm)\n",
+		 __func__, d1, c1, x1, *zdet);
 ramp_down:
 	i = 0;
 	while (x1) {
-- 
2.39.2



