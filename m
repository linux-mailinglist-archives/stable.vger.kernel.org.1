Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9027A7FC5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjITMaV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbjITMaU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFA9E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:30:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2F8C433CD;
        Wed, 20 Sep 2023 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213014;
        bh=psks8Vue4nCpzQjVHcJNeWFh1xn+rEpvU/u78pUISEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzUcw3oF5SplLfAvBIKy3/2NZML6m4wak6CCP/J4i1zxkPQzrw6BC9abiB2o/aX2i
         TsL7EVLuc283BXGuXchaP7DBSkdEU71Q21DMAFV3DzPv1RDYafVCwON8UFDGmjotuv
         F3/ePzyrthzJornHUww2u8ZuGmNW55OpiFRsqTt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 101/367] ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
Date:   Wed, 20 Sep 2023 13:27:58 +0200
Message-ID: <20230920112901.183034364@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit cf0cb2af6a18f28b84f9f1416bff50ca60d6e98a ]

The davicom,dm9000 Ethernet Controller accepts two reg addresses.

Fixes: a43736deb47d ("ARM: dts: Add dts file for S3C6410-based Mini6410 board")
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20230713152926.82884-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 17097da36f5ed..0b07b3c319604 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -51,7 +51,7 @@ srom-cs1-bus@18000000 {
 
 		ethernet@18000000 {
 			compatible = "davicom,dm9000";
-			reg = <0x18000000 0x2 0x18000004 0x2>;
+			reg = <0x18000000 0x2>, <0x18000004 0x2>;
 			interrupt-parent = <&gpn>;
 			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 			davicom,no-eeprom;
-- 
2.40.1



