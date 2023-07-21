Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7F75D4C4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjGUTYn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjGUTYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141062D45
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9011E61D94
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A81BC433C7;
        Fri, 21 Jul 2023 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967478;
        bh=UEXJ3fbx8etc1Ydp4Z9DA0Iej5T633509STnRX/d/8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIZlAihGcGzHYq4EfdJSvYdN1XRUwyC8ZQ25qCiT6RAl/zJ+dlBJ6xTdOo3XboQny
         XSrAHyk48sd16CWmNlKzkQk+1oi9Cr0XDmrVJQ/UAWxLR/sCCfuh7bB534wGZkCSfr
         4kMSqwx1WmP1/NpnmbifdtU8YO60gOz22+b0Bnzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, George Stark <GNStark@sberdevices.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 169/223] meson saradc: fix clock divider mask length
Date:   Fri, 21 Jul 2023 18:07:02 +0200
Message-ID: <20230721160528.083299586@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: George Stark <gnstark@sberdevices.ru>

commit c57fa0037024c92c2ca34243e79e857da5d2c0a9 upstream.

According to the datasheets of supported meson SoCs length of ADC_CLK_DIV
field is 6-bit. Although all supported SoCs have the register
with that field documented later SoCs use external clock rather than
ADC internal clock so this patch affects only meson8 family (S8* SoCs).

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: George Stark <GNStark@sberdevices.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/20230606165357.42417-1-gnstark@sberdevices.ru
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/meson_saradc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -71,7 +71,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 


