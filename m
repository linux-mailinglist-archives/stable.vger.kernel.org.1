Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BE713C1F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjE1TFG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE1TFF (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95790
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441856160D
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61830C4339B;
        Sun, 28 May 2023 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300702;
        bh=qoc0DHzLQ8RAH/s30zu7SFfMF6rBhwMav0nfmOopKv0=;
        h=Subject:To:From:Date:From;
        b=E0nfJL1UmxYgUB1PeoIqTqpOiPqeLUboBeoqbEoACHNoweS4pXKCzlpDYKmWtb1Qs
         FqM9pAQUQRq9/UVbaQhIsor+07YGICjUEXrRLu8iczGiA8URo7irlAfZ+ID2Coeaz8
         zJ/tIa02zxe9gB96wVNXJ0CD34cnFPvs12r8t+Hk=
Subject: patch "iio: adc: stm32-adc: skip adc-channels setup if none is present" added to char-misc-linus
To:     sean@geanix.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, olivier.moysan@foss.st.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:38 +0100
Message-ID: <2023052838-lesser-mortician-ee32@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: adc: stm32-adc: skip adc-channels setup if none is present

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3e27ef0ced49f8ae7883c25fadf76a2086e99025 Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 3 May 2023 18:20:29 +0200
Subject: iio: adc: stm32-adc: skip adc-channels setup if none is present

If only adc differential channels are defined driver will fail with
stm32-adc: probe of 48003000.adc:adc@0 failed with error -22

Fix this by skipping the initialization if no channels are defined.

This applies only to the legacy way of initializing adc channels.

Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://lore.kernel.org/r/20230503162029.3654093-2-sean@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-adc.c | 42 ++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c105d82c3e45..bd7e2408bf28 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2036,6 +2036,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
 	struct device *dev = &indio_dev->dev;
 	u32 num_diff = adc->num_diff;
+	int num_se = nchans - num_diff;
 	int size = num_diff * sizeof(*diff) / sizeof(u32);
 	int scan_index = 0, ret, i, c;
 	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
@@ -2062,29 +2063,32 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 			scan_index++;
 		}
 	}
-
-	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
-					     nchans);
-	if (ret)
-		return ret;
-
-	for (c = 0; c < nchans; c++) {
-		if (chans[c] >= adc_info->max_channels) {
-			dev_err(&indio_dev->dev, "Invalid channel %d\n",
-				chans[c]);
-			return -EINVAL;
+	if (num_se > 0) {
+		ret = device_property_read_u32_array(dev, "st,adc-channels", chans, num_se);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Failed to get st,adc-channels %d\n", ret);
+			return ret;
 		}
 
-		/* Channel can't be configured both as single-ended & diff */
-		for (i = 0; i < num_diff; i++) {
-			if (chans[c] == diff[i].vinp) {
-				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
+		for (c = 0; c < num_se; c++) {
+			if (chans[c] >= adc_info->max_channels) {
+				dev_err(&indio_dev->dev, "Invalid channel %d\n",
+					chans[c]);
 				return -EINVAL;
 			}
+
+			/* Channel can't be configured both as single-ended & diff */
+			for (i = 0; i < num_diff; i++) {
+				if (chans[c] == diff[i].vinp) {
+					dev_err(&indio_dev->dev, "channel %d misconfigured\n",
+						chans[c]);
+					return -EINVAL;
+				}
+			}
+			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
+						chans[c], 0, scan_index, false);
+			scan_index++;
 		}
-		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
-					chans[c], 0, scan_index, false);
-		scan_index++;
 	}
 
 	if (adc->nsmps > 0) {
@@ -2305,7 +2309,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 
 	if (legacy)
 		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
-						 num_channels);
+						 timestamping ? num_channels - 1 : num_channels);
 	else
 		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
 	if (ret < 0)
-- 
2.40.1


