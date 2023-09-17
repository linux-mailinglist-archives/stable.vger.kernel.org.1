Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B87A3BD6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjIQUXB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbjIQUWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:22:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C001B4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:22:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027A7C433C9;
        Sun, 17 Sep 2023 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982153;
        bh=W5g1p3LX56Lm0a7ERjzCo2vYDVIzRCQ4Wcces/QAEyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjJVgrumxmV69EqOcB5TOGrCRQGkM93vUKZFgKHqYGFpnTnQM3wuHktTAJAr/81FW
         1dEEWAey9741/HLAPfvYOj/SErTItnhNvnlHYChzKxZfocr0Clu3Y653CGQlFQg0af
         nepSrvBP/NM07uCADhn/dWZMg1LrEhI4sfqlQZz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zeyan Li <qaz6750@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 168/511] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Sun, 17 Sep 2023 21:09:55 +0200
Message-ID: <20230917191117.897260450@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zeyan Li <qaz6750@outlook.com>

[ Upstream commit f9568d22ce06192a7e14bda3a29dc216659554ff ]

I2C6 and I2C7 use the same interrupts, which is incorrect.
In the downstream kernel, I2C7 has interrupts of 608 instead of 607.

Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
Signed-off-by: Zeyan Li <qaz6750@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/SY7P282MB378712225CBCEA95FE71554DB201A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 292e40d6162dd..e8cb20c4cbf22 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1131,7 +1131,7 @@ i2c7: i2c@89c000 {
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c7_default>;
-				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.40.1



