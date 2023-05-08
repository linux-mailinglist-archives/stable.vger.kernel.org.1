Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA986FAD48
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjEHLdQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbjEHLc7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F383DC97
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E32936304A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AAFC433EF;
        Mon,  8 May 2023 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545519;
        bh=088rvVM9AtJmY7X9z4w+ylwDXfpyP6nQeWbozy4Nn6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLoZrDDUIWYuc1gWTaF0fLJqEN577Q4K8Xdz7AIqTricjMb218OlhVRKq14n8gMDO
         HQIPtrNbb9CBzjk6Zksk9iBVlDfe/WUO7c+kameBOyXD3YMC4dlENd5BqMt+woCBLa
         v5X1K6Gs/H1YBT08DroyzaiJjulW9dD1rA8eSsOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.15 037/371] pinctrl: qcom: lpass-lpi: set output value before enabling output
Date:   Mon,  8 May 2023 11:43:58 +0200
Message-Id: <20230508094813.549721884@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 163bfb0cb1f6fbf961cf912cbde57399ea1ae0e8 upstream.

As per Hardware Programming Guide, when configuring pin as output,
set the pin value before setting output-enable (OE).  Similar approach
is in main SoC TLMM pin controller.

Cc: <stable@vger.kernel.org>
Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230309154949.658380-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -452,6 +452,15 @@ static int lpi_config_set(struct pinctrl
 		}
 	}
 
+	/*
+	 * As per Hardware Programming Guide, when configuring pin as output,
+	 * set the pin value before setting output-enable (OE).
+	 */
+	if (output_enabled) {
+		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
+		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
+	}
+
 	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
 
 	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
@@ -461,11 +470,6 @@ static int lpi_config_set(struct pinctrl
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
 
-	if (output_enabled) {
-		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
-		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
-	}
-
 	return 0;
 }
 


