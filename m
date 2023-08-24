Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994BA7876FD
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbjHXRVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbjHXRVd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361512C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C1A6756B
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BECC433C8;
        Thu, 24 Aug 2023 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897690;
        bh=+emhKUzQL5e6sdKV6fQ2hqfoyyZTSPMlf8U/gnOeXMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiAQCP0232m55fJpJIfGIdQMDdLPcB0WRtC2VCgq3zvz4YBUJLFyiukmelL+rsY88
         4aa3xsm2l0Swg/fhAvYM+n6mPPEONEW0NITkLHua1PIb7Sw+rfKZhkjcS7Vhrj/kH7
         eScG4xQhsiuzL9GaQBkoTcabuw2k1kpt3kMSur+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Bee <knaerzche@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/135] arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
Date:   Thu, 24 Aug 2023 19:09:29 +0200
Message-ID: <20230824170621.475417408@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Bee <knaerzche@gmail.com>

[ Upstream commit 65bd2b8bdb3bddc37bea695789713916327e1c1f ]

ROCK Pi 4 boards have the codec connected to i2s0 and it is accessible
via i2c1 address 0x11.
Add an audio-graph-card for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Link: https://lore.kernel.org/r/20210618181256.27992-5-knaerzche@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 6dc6dee6c13e2..f80cdb021f7fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -31,6 +31,12 @@
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	sound {
+		compatible = "audio-graph-card";
+		label = "Analog";
+		dais = <&i2s0_p0>;
+	};
+
 	vcc12v_dcin: dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -417,6 +423,20 @@
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
+
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_p0_0>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -435,6 +455,14 @@
 	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <8>;
 	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
 };
 
 &i2s1 {
-- 
2.40.1



