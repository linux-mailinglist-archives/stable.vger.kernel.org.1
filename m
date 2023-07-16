Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306677552BF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGPUL1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGPUL1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD779B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D3960E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75DEC433C7;
        Sun, 16 Jul 2023 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538285;
        bh=0PtIYive8b/RYSKz5SvHu5OKERzc2exDMUsiW5EeQJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9mtza2Zl/u4OeWpQO8W0ZCobVHEHHNMck4Xg8OvNl9ZZeoldWe+Eqt1ii0hz5ctK
         S0pTyn/RMw28vUyhcX4EgstDYst7ZUEZrziX5yhVquWhsHOrSsxo7nKkjZ2Db96Z2d
         7LHFUI5Q+qM1IoaHZK4my9YWBImNS6gaXVXX8Aqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 353/800] arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b
Date:   Sun, 16 Jul 2023 21:43:26 +0200
Message-ID: <20230716194957.279055789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 28ee08cef4f838c343013330a3cd12674c4dd113 ]

The I2S0_8CH_MCLKOUT clock rate on Rock 5B board defaults to 12 MHz and
it is used to provide the master clock (MCLK) for the ES8316 audio
codec.

On sound card initialization, this limits the allowed sample rates
according to the MCLK/LRCK ratios supported by the codec, which results
in the following non-standard rates: 15625, 30000, 31250, 46875.

Hence, the very first access of the sound card fails:

  Broken configuration for playback: no configurations available: Invalid argument
  Setting of hwparams failed: Invalid argument

However, all subsequent attempts will succeed, as the audio graph card
will request a correct clock frequency, based on the stream sample rate
and the multiplication factor.

Assign MCLK to 12.288 MHz, which allows the codec to advertise most of
the standard sample rates.

Fixes: 55529fe3f32d ("arm64: dts: rockchip: Add rk3588-rock-5b analog audio")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20230530181140.483936-4-cristian.ciocaltea@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 3e4aee8f70c1b..30cdd366813fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -133,6 +133,8 @@ es8316: audio-codec@11 {
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		clock-names = "mclk";
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
 		#sound-dai-cells = <0>;
 
 		port {
-- 
2.39.2



