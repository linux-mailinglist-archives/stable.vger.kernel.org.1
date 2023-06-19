Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAA7352FA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjFSKk3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjFSKkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B210F3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 251DA60B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AFDC433C8;
        Mon, 19 Jun 2023 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171199;
        bh=YPc0r6NfNEELinNLXJAgz1eeQAItNh35zU/sjR1QM/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7fYUkB0VIpnl31hsGaqiAJeBLTqTYM6EaAfdNNVwNqaBvtH9P7Z61voKV53bKNWA
         l26Wbkier6ja420JNOoBczjDZhZQf4zTWNmx3N5ilzZie5Cw2o+OxfGTR9+IOKweiE
         aDywEpCNdMuj6TVaHqkgBMjAd2h833p4UDtgm9S0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Su Hui <suhui@nfschina.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 157/187] drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
Date:   Mon, 19 Jun 2023 12:29:35 +0200
Message-ID: <20230619102205.181413751@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 95011f267c44a4d1f9ca1769e8a29ab2c559e004 ]

Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <= 5.

Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230608012443.839372-1-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 1e26fa63845a2..0ae8a52acf5e4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -298,6 +298,10 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
 		if (refclk_lut[i] == refclk_rate)
 			break;
 
+	/* avoid buffer overflow and "1" is the default rate in the datasheet. */
+	if (i >= refclk_lut_size)
+		i = 1;
+
 	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
 			   REFCLK_FREQ(i));
 
-- 
2.39.2



