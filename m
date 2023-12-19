Return-Path: <stable+bounces-7870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3B81827E
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FC228185D
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CAA8BE1;
	Tue, 19 Dec 2023 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sw6Dzvw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5511709
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 07:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A22C433C8;
	Tue, 19 Dec 2023 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702971833;
	bh=8kPy/7qQ3R3iUh9Jvw+XXkMxiLM+vmR/hTNgyoJ1kBg=;
	h=Subject:To:From:Date:From;
	b=sw6Dzvw6SHDhKWLq9kG6IS3vDtWt1VgcSwh+jX07mnwFT90roxX0ZcnaTJ9X1cJOx
	 odUZTUIiqcEmuMXJn20n+yhBwGxf5wAJqh/vNPhc3dAG79lUQR5QgmNoCNLCHE5kp5
	 ISNdjIWHhWa2BRrfHVwjfnemFUng5mhNDCjvPcLg=
Subject: patch "Revert "iio: hid-sensor-als: Add light color temperature support"" added to char-misc-linus
To: srinivas.pandruvada@linux.intel.com,Jonathan.Cameron@huawei.com,gregkh@linuxfoundation.org,stable@vger.kernel.org,thomas@t-8ch.de
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Dec 2023 08:43:42 +0100
Message-ID: <2023121942-immunize-fiscally-54bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    Revert "iio: hid-sensor-als: Add light color temperature support"

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From d4005431673929a1259ad791db87408fcf85d2cc Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Sun, 17 Dec 2023 12:07:03 -0800
Subject: Revert "iio: hid-sensor-als: Add light color temperature support"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 5f05285df691b1e82108eead7165feae238c95ef.

This commit assumes that every HID descriptor for ALS sensor has
presence of usage id ID HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE.
When the above usage id is absent,  driver probe fails. This breaks
ALS sensor functionality on many platforms.

Till we have a good solution, revert this commit.

Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218223
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:  <stable@vger.kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20231217200703.719876-3-srinivas.pandruvada@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/hid-sensor-als.c | 37 ++----------------------------
 include/linux/hid-sensor-ids.h     |  1 -
 2 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d44b3f30ae4a..5cd27f04b45e 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -14,9 +14,8 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 enum {
-	CHANNEL_SCAN_INDEX_INTENSITY,
-	CHANNEL_SCAN_INDEX_ILLUM,
-	CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	CHANNEL_SCAN_INDEX_INTENSITY = 0,
+	CHANNEL_SCAN_INDEX_ILLUM = 1,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -66,16 +65,6 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
-	{
-		.type = IIO_COLORTEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS) |
-		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
-		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
-	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -114,11 +103,6 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
-		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
-			report_id = als_state->als[chan->scan_index].report_id;
-			min = als_state->als[chan->scan_index].logical_minimum;
-			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
-			break;
 		default:
 			report_id = -1;
 			break;
@@ -239,10 +223,6 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
 		ret = 0;
 		break;
-	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
-		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
-		ret = 0;
-		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -278,19 +258,6 @@ static int als_parse_report(struct platform_device *pdev,
 			st->als[i].report_id);
 	}
 
-	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
-				usage_id,
-				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
-				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
-	if (ret < 0)
-		return ret;
-	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
-				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
-
-	dev_dbg(&pdev->dev, "als %x:%x\n",
-		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
-		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
-
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 8af4fb3e0254..13b1e65fbdcc 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -21,7 +21,6 @@
 #define HID_USAGE_SENSOR_ALS					0x200041
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
-#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0



