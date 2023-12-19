Return-Path: <stable+bounces-7868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C79481827A
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544731C22FA1
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FCA8BE1;
	Tue, 19 Dec 2023 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H0vD25LC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28504125B0
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 07:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B578C433C7;
	Tue, 19 Dec 2023 07:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702971824;
	bh=AIUKWVYsBd2IgeFMHCf3Bf/p18PSfQ/7E4J8IS6X8Oc=;
	h=Subject:To:From:Date:From;
	b=H0vD25LCsgUkgM2sc5nahEZz8MM9n6n4INb3eqq8xtRN/HTf6kCxBflhL7MVcQuQR
	 VOEkFaS5iWHSHCPhgdEX2Dz/6F0FvQp16nwtuilT7LctJWSpOx627x/7vvLu/H/R91
	 KpzeKyKf9z0HPUv+I+ISy4mhD+o5aRDI/dIhmVJk=
Subject: patch "Revert "iio: hid-sensor-als: Add light chromaticity support"" added to char-misc-linus
To: srinivas.pandruvada@linux.intel.com,Jonathan.Cameron@huawei.com,gregkh@linuxfoundation.org,stable@vger.kernel.org,thomas@t-8ch.de
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Dec 2023 08:43:42 +0100
Message-ID: <2023121941-amulet-frisk-2b96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    Revert "iio: hid-sensor-als: Add light chromaticity support"

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b9670ee2e975e1cb6751019d5dc5c193aecd8ba2 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Sun, 17 Dec 2023 12:07:02 -0800
Subject: Revert "iio: hid-sensor-als: Add light chromaticity support"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit ee3710f39f9d0ae5137a866138d005fe1ad18132.

This commit assumes that every HID descriptor for ALS sensor has
presence of usage id ID HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X and
HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y. When the above usage ids are
absent,  driver probe fails. This breaks ALS sensor functionality on
many platforms.

Till we have a good solution, revert this commit.

Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218223
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:  <stable@vger.kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20231217200703.719876-2-srinivas.pandruvada@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/hid-sensor-als.c | 63 ------------------------------
 include/linux/hid-sensor-ids.h     |  3 --
 2 files changed, 66 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index f17304b54468..d44b3f30ae4a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -17,8 +17,6 @@ enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
 	CHANNEL_SCAN_INDEX_COLOR_TEMP,
-	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
-	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -78,30 +76,6 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	},
-	{
-		.type = IIO_CHROMATICITY,
-		.modified = 1,
-		.channel2 = IIO_MOD_X,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
-		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X,
-	},
-	{
-		.type = IIO_CHROMATICITY,
-		.modified = 1,
-		.channel2 = IIO_MOD_Y,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
-		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
-	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -145,16 +119,6 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
 			break;
-		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
-			report_id = als_state->als[chan->scan_index].report_id;
-			min = als_state->als[chan->scan_index].logical_minimum;
-			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
-			break;
-		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
-			report_id = als_state->als[chan->scan_index].report_id;
-			min = als_state->als[chan->scan_index].logical_minimum;
-			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
-			break;
 		default:
 			report_id = -1;
 			break;
@@ -279,14 +243,6 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
 		ret = 0;
 		break;
-	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_X] = sample_data;
-		ret = 0;
-		break;
-	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_Y] = sample_data;
-		ret = 0;
-		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -335,25 +291,6 @@ static int als_parse_report(struct platform_device *pdev,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
 
-	for (i = 0; i < 2; i++) {
-		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
-
-		ret = sensor_hub_input_get_attribute_info(hsdev,
-				HID_INPUT_REPORT, usage_id,
-				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
-				&st->als[next_scan_index]);
-		if (ret < 0)
-			return ret;
-
-		als_adjust_channel_bit_mask(channels,
-					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
-					st->als[next_scan_index].size);
-
-		dev_dbg(&pdev->dev, "als %x:%x\n",
-			st->als[next_scan_index].index,
-			st->als[next_scan_index].report_id);
-	}
-
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6730ee900ee1..8af4fb3e0254 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -22,9 +22,6 @@
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
 #define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
-#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY			0x2004d3
-#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X			0x2004d4
-#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y			0x2004d5
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0



