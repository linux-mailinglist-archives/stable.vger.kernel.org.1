Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE937552FF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGPUOa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGPUO3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23991B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E6960EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6F9C433C7;
        Sun, 16 Jul 2023 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538464;
        bh=wwn6gTY0zKcfNNTELl8wpp1wC8Oz5cI+oRoIEGrsXzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCq4GHjRX2EI58OM0INAeYZkycb1QDBQSrQieh+M+2/+0riYmfZEDwDy+RzOQbhED
         qEg9zL0Jfl8FDN6VV5Y8U0dL93rvjlSwD/mqVSY8i7v4AzPGidl7iEAJzjx0CHchJY
         g/B/cn3pqhgTH2kQ3uA8FXRAf576eNcgl6JTzt+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 431/800] MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators
Date:   Sun, 16 Jul 2023 21:44:44 +0200
Message-ID: <20230716194959.096439041@linuxfoundation.org>
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

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit fbf1e42093f8d6346baf17079585fbcebb2ff284 ]

Provide parent regulators to the ACT8600 regulators that need one.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Stable-dep-of: 944520f85d5b ("MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 2b1284c6c64a6..eac6b3411b5f7 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -242,16 +242,19 @@ regulators {
 			vddcore: DCDC1 {
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
+				vp1-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			vddmem: DCDC2 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
+				vp2-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			vcc_33: DCDC3 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				vp3-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			vcc_50: SUDCDC_REG4 {
@@ -262,21 +265,25 @@ vcc_50: SUDCDC_REG4 {
 			vcc_25: LDO5 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
+				inl-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			wifi_io: LDO6 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
+				inl-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			cim_io_28: LDO7 {
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+				inl-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			cim_io_15: LDO8 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
+				inl-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
 			vrtc_18: LDO_REG9 {
-- 
2.39.2



