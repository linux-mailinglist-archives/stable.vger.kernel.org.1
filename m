Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6852F6FA9DA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjEHK4a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjEHK4L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:56:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5C22709
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101BC6294B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E408C433D2;
        Mon,  8 May 2023 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543302;
        bh=fnuaofywZ2/5O8yqHUDcIPxOi6LGC8EzXuTSfrxlI0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAwqyOxHQSnYYwcbUkm25WigNZPHQlD1r3TF2dekHZGQgvuxnfeoTGfdYDj2x1QOi
         ZvA2IORvGZQcIF1EW/WKRe/JZZ2tC5ZnmHkvtQrp3oQHQ4MMRCwj09p8N16K9G0Xgp
         c4pWLoNYbeOyuPVjoarVBuqpVjIl5DEbPFOaizys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.3 045/694] pinctrl: qcom: lpass-lpi: set output value before enabling output
Date:   Mon,  8 May 2023 11:38:00 +0200
Message-Id: <20230508094434.085000084@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -221,6 +221,15 @@ static int lpi_config_set(struct pinctrl
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
@@ -230,11 +239,6 @@ static int lpi_config_set(struct pinctrl
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
 
-	if (output_enabled) {
-		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
-		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
-	}
-
 	return 0;
 }
 


