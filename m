Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665097CAC6A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjJPOyU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjJPOyU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:54:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C711EA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:54:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB1AC433C8;
        Mon, 16 Oct 2023 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468058;
        bh=UlhN9TBUu+732uD3n05nVv3H/RXbBUHS042OUa7Mcxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXXOM8bhjVBQARcu7rkh3yZ0UqKLBB+zXsOSMoQ804X/rOrl7UuJlcu+Rr9HmnYR7
         Vr62Edpos4yTiYISOQZnBPiousOkTLCNbruvfarUUlmq203cXqFcbPfguEANRvWhO0
         443dhDX/a7fudmRkazbM6egvfRJ2v/On81WOciow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.5 117/191] iio: adc: ad7192: Correct reference voltage
Date:   Mon, 16 Oct 2023 10:41:42 +0200
Message-ID: <20231016084018.112793875@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alisa-Dariana Roman <alisa.roman@analog.com>

commit 7e7dcab620cd6d34939f615cac63fc0ef7e81c72 upstream.

The avdd and the reference voltage are two different sources but the
reference voltage was assigned according to the avdd supply.

Add vref regulator structure and set the reference voltage according to
the vref supply from the devicetree.

In case vref supply is missing, reference voltage is set according to
the avdd supply for compatibility with old devicetrees.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230924152149.41884-1-alisadariana@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7192.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
+	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1014,10 +1015,30 @@ static int ad7192_probe(struct spi_devic
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
 
-	ret = regulator_get_voltage(st->avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		return ret;
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->vref) != -ENODEV)
+			return PTR_ERR(st->vref);
+
+		ret = regulator_get_voltage(st->avdd);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AVdd voltage undefined\n");
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, Vref voltage undefined\n");
 	}
 	st->int_vref_mv = ret / 1000;
 


