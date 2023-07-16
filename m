Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB9755300
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGPUOb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjGPUOa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4F1B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E56160EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB6DC433CB;
        Sun, 16 Jul 2023 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538467;
        bh=WGshtL4AUNAYowDOlv7UohyIEj9uIHjV7Y4Gf0dv4C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3gLtyM6GCt1NBkW9DysYa8wXKhI+iPpBduR1HL0XhsouiXD+XGjMf4XUcXXd6AXR
         KmnCoArrT3Bzprw2cFPfzeyBPj6PuqmsvCmjilEPIWLGP0dtX/7YpWlLJKeWrTHXoy
         eixOUfAK3kdHpFrSdhwaVM5vwYQwvs4Tt2j3t7Sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 432/800] MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
Date:   Sun, 16 Jul 2023 21:44:45 +0200
Message-ID: <20230716194959.119195313@linuxfoundation.org>
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

[ Upstream commit 944520f85d5b1fb2f9ea243be41f9c9af3d4cef3 ]

Commit 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node
names") caused the VDDCORE power supply (regulated by the ACT8600's
DCDC1 output) to drop from a voltage of 1.2V configured by the
bootloader, to the 1.1V set in the Device Tree.

According to the documentation, the VDDCORE supply should be between
0.99V and 1.21V; both values are therefore within the supported range.

However, VDDCORE being 1.1V results in the CI20 being very unstable,
with corrupted memory, failures to boot, or reboots at random. The
reason might be succint drops of the voltage below the minimum required.

Raising the minimum voltage to 1.125 volts seems to be enough to address
this issue, while still keeping a relatively low core voltage which
helps for power consumption and thermals.

Fixes: 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node names")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index eac6b3411b5f7..c0f6c4d3618e1 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -240,8 +240,8 @@ act8600: act8600@5a {
 
 		regulators {
 			vddcore: DCDC1 {
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1125000>;
+				regulator-max-microvolt = <1125000>;
 				vp1-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
-- 
2.39.2



