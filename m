Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2257E24C8
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjKFNZO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjKFNZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:25:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC5EA
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E782C433C8;
        Mon,  6 Nov 2023 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277109;
        bh=hoEEMUlamZowNtpIW/86PMix/ig7aHIiUJ370qQwccI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfQW0DrNoI32/xqjviKP4ZxSh/BNOkApScqy4bH9N1dlyyEUngVBJGy5jvbve2g1e
         wzT6XTfSHT13hFcCZOkNkRGWh3NYsyCgnDry0zZdNdxZKKhu4lfgWggIOh6xEzUq7J
         L8fIsZlRa0BgkpTYdvLMeDjTjlhfX5FeF3db+H2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Robert Hancock <robert.hancock@calian.com>,
        "OGriofa, Conall" <conall.ogriofa@amd.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        O'Griofa@vger.kernel.org
Subject: [PATCH 5.15 042/128] iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale
Date:   Mon,  6 Nov 2023 14:03:22 +0100
Message-ID: <20231106130311.051433313@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Hancock <robert.hancock@calian.com>

commit e2bd8c28b9bd835077eb65715d416d667694a80d upstream.

The driver was previously using offset and scale values for the
temperature sensor readings which were only valid for 7-series devices.
Add per-device-type values for offset and scale and set them appropriately
for each device type.

Note that the values used for the UltraScale family are for UltraScale+
(i.e. the SYSMONE4 primitive) using the internal reference, as that seems
to be the most common configuration and the device tree values Xilinx's
device tree generator produces don't seem to give us anything to tell us
which configuration is used. However, the differences within the UltraScale
family seem fairly minor and it's closer than using the 7-series values
instead in any case.

Fixes: c2b7720a7905 ("iio: xilinx-xadc: Add basic support for Ultrascale System Monitor")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Tested-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Link: https://lore.kernel.org/r/20230915001019.2862964-3-robert.hancock@calian.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/xilinx-xadc-core.c |   17 ++++++++++++++---
 drivers/iio/adc/xilinx-xadc.h      |    2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -454,6 +454,9 @@ static const struct xadc_ops xadc_zynq_o
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const unsigned int xadc_axi_reg_offsets[] = {
@@ -564,6 +567,9 @@ static const struct xadc_ops xadc_7s_axi
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const struct xadc_ops xadc_us_axi_ops = {
@@ -575,6 +581,12 @@ static const struct xadc_ops xadc_us_axi
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED,
 	.type = XADC_TYPE_US,
+	/**
+	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
+	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
+	 */
+	.temp_scale = 509314,
+	.temp_offset = 280231,
 };
 
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
@@ -946,8 +958,7 @@ static int xadc_read_raw(struct iio_dev
 			*val2 = chan->scan_type.realbits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
-			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-			*val = 503975;
+			*val = xadc->ops->temp_scale;
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
@@ -955,7 +966,7 @@ static int xadc_read_raw(struct iio_dev
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has an offset */
-		*val = -((273150 << bits) / 503975);
+		*val = -((xadc->ops->temp_offset << bits) / xadc->ops->temp_scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_samplerate(xadc);
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -86,6 +86,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	int temp_scale;
+	int temp_offset;
 };
 
 static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,


