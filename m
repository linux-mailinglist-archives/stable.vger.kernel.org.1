Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15EA726D98
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjFGUoC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFGUoB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632772700
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D6E764653
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AF4C433EF;
        Wed,  7 Jun 2023 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170609;
        bh=EOZ+3mKw9Dbp9ofImuacVyl7gE4qGUEQZCC1dXn+a3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RaY4FIT1cWTWy2t/w4+tAeQaAx4jSzWTJ6qVrupbC4od+TGrkaDNfn3o7b/HrtRv
         DBFzOQ1Fq6oNoY2sNO7UDUMlo4Hy5dChjsxK5gQcqwnwZgCNg2+CSNt8B14qJqe40k
         X9IkR1ion+RprY09hnFbSR5SjlNlPotlsRLYa7uQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Nyekjaer <sean@geanix.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 148/225] iio: adc: stm32-adc: skip adc-channels setup if none is present
Date:   Wed,  7 Jun 2023 22:15:41 +0200
Message-ID: <20230607200919.259617955@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

commit 3e27ef0ced49f8ae7883c25fadf76a2086e99025 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/stm32-adc.c |   42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1913,6 +1913,7 @@ static int stm32_adc_legacy_chan_init(st
 	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
 	struct device *dev = &indio_dev->dev;
 	u32 num_diff = adc->num_diff;
+	int num_se = nchans - num_diff;
 	int size = num_diff * sizeof(*diff) / sizeof(u32);
 	int scan_index = 0, ret, i, c;
 	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
@@ -1939,29 +1940,32 @@ static int stm32_adc_legacy_chan_init(st
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
@@ -2153,7 +2157,7 @@ static int stm32_adc_chan_fw_init(struct
 
 	if (legacy)
 		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
-						 num_channels);
+						 timestamping ? num_channels - 1 : num_channels);
 	else
 		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
 	if (ret < 0)


