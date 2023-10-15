Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CF7C9A9F
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOSLv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSLu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:11:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CEAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:11:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B9DC433C7;
        Sun, 15 Oct 2023 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697393509;
        bh=kwhyxgnR9UX5zlVa/MQ4sNp8yB+dLMiMrvxiEd7EJBk=;
        h=Subject:To:Cc:From:Date:From;
        b=aYwXXBuxS3IqSviwfdfrRNDx3vA92mU5S4swSXSRv7lCVZPTtxyrMaFwMf5L8dsVH
         4rXMLWGVBJFf8ysUcWK+7SEvcbdVb3TWluG3dfGLAFNviq4ZDb5/4kasYM3y5os95D
         GJG0723j6oAzPZ8Egxb5igyCH1Og5qA1QWiNczEE=
Subject: FAILED: patch "[PATCH] iio: adc: ad7192: Correct reference voltage" failed to apply to 6.1-stable tree
To:     alisa.roman@analog.com, Jonathan.Cameron@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:11:41 +0200
Message-ID: <2023101541-sandpit-geologist-1595@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7e7dcab620cd6d34939f615cac63fc0ef7e81c72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101541-sandpit-geologist-1595@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e7dcab620cd6d34939f615cac63fc0ef7e81c72 Mon Sep 17 00:00:00 2001
From: Alisa-Dariana Roman <alisa.roman@analog.com>
Date: Sun, 24 Sep 2023 18:21:48 +0300
Subject: [PATCH] iio: adc: ad7192: Correct reference voltage

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

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 69d1103b9508..b64fd365f83f 100644
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
@@ -1008,10 +1009,30 @@ static int ad7192_probe(struct spi_device *spi)
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
 

