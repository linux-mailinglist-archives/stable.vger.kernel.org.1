Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE33731639
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjFOLOR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbjFOLOP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 07:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24932707
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 04:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31BB662E25
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 11:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C31CC433C0;
        Thu, 15 Jun 2023 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686827652;
        bh=UbUSSvVOYjsoKCkYr96l7SYeUZsq4k0COdUfu9rbzlM=;
        h=Subject:To:From:Date:From;
        b=Dv5ijdZw81LqG1xgZgEJ/Q2uZYJ/nZzd/W22E2klWeJTuiyg88rB/CtaAN4pS9G+J
         n72iv+NJdXrAvuiRplKjI5O6+RllWnDk31qRVCKKn2vIqLG9tXi7OP4XWk6tz/Oye2
         1W3XUm+uu1pK8qzem1GVJvRh6qTaT/+GSGsnJFq0=
Subject: patch "meson saradc: fix clock divider mask length" added to char-misc-next
To:     gnstark@sberdevices.ru, GNStark@sberdevices.ru,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        martin.blumenstingl@googlemail.com, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 15 Jun 2023 13:11:46 +0200
Message-ID: <2023061546-snore-dedicator-eed9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    meson saradc: fix clock divider mask length

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From c57fa0037024c92c2ca34243e79e857da5d2c0a9 Mon Sep 17 00:00:00 2001
From: George Stark <gnstark@sberdevices.ru>
Date: Tue, 6 Jun 2023 19:53:57 +0300
Subject: meson saradc: fix clock divider mask length

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
---
 drivers/iio/adc/meson_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 18937a262af6..af6bfcc19075 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -72,7 +72,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 
-- 
2.41.0


