Return-Path: <stable+bounces-71687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1696702E
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E84B20FE2
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F9170A23;
	Sat, 31 Aug 2024 07:41:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239416F282
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090080; cv=none; b=Pfs+rkC61iQPKufsjL+0ffl1E1RfWzG7jlVcZPAdlito2KWpp4qgl9Dr1ta7mWvq1yFnub3jBSYqze8mjE6U2BN8N73uBiHcYuGVRxjyNh8rKO0xq/dmGWdsJ2laoHdSoZAMG7sc5rKv2XUmUvox3x39iWQSVVW3mmtGVH6lcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090080; c=relaxed/simple;
	bh=1gOqJajq7K9PZT6Rc8JrdbV7NfH7TVnSIZoN1zkKZvE=;
	h=From:Date:Subject:To:Cc:Message-Id; b=Qdp6Tiras90q3nY2H09W7zYy+R/e0b2Cqpe2fiKUKB+pQSKYAsibdEHMKoXMcj4dP87YFT+c96YI6cAsi34Ei0X+266nTImhnFNI63wX7oZexxeVBhvEIgRuqxnipb2g6PCVMVpXPEOyI4LGOQUfPXX4X5Rai03/IA6NjEV3yRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1skIjT-0006fj-0q;
	Sat, 31 Aug 2024 07:41:15 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sat, 31 Aug 2024 07:40:43 +0000
Subject: [git:media_stage/master] media: ov5675: Fix power on/off delay timings
To: linuxtv-commits@linuxtv.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1skIjT-0006fj-0q@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ov5675: Fix power on/off delay timings
Author:  Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:    Sat Jul 13 23:33:29 2024 +0100

The ov5675 specification says that the gap between XSHUTDN deassert and the
first I2C transaction should be a minimum of 8192 XVCLK cycles.

Right now we use a usleep_rage() that gives a sleep time of between about
430 and 860 microseconds.

On the Lenovo X13s we have observed that in about 1/20 cases the current
timing is too tight and we start transacting before the ov5675's reset
cycle completes, leading to I2C bus transaction failures.

The reset racing is sometimes triggered at initial chip probe but, more
usually on a subsequent power-off/power-on cycle e.g.

[   71.451662] ov5675 24-0010: failed to write reg 0x0103. error = -5
[   71.451686] ov5675 24-0010: failed to set plls

The current quiescence period we have is too tight. Instead of expressing
the post reset delay in terms of the current XVCLK this patch converts the
power-on and power-off delays to the maximum theoretical delay @ 6 MHz with
an additional buffer.

1.365 milliseconds on the power-on path is 1.5 milliseconds with grace.
85.3 microseconds on the power-off path is 90 microseconds with grace.

Fixes: 49d9ad719e89 ("media: ov5675: add device-tree support and support runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma with
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ov5675.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

---

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 3641911bc73f..5b5127f8953f 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -972,12 +972,10 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
 
 static int ov5675_power_off(struct device *dev)
 {
-	/* 512 xvclk cycles after the last SCCB transation or MIPI frame end */
-	u32 delay_us = DIV_ROUND_UP(512, OV5675_XVCLK_19_2 / 1000 / 1000);
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov5675 *ov5675 = to_ov5675(sd);
 
-	usleep_range(delay_us, delay_us * 2);
+	usleep_range(90, 100);
 
 	clk_disable_unprepare(ov5675->xvclk);
 	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
@@ -988,7 +986,6 @@ static int ov5675_power_off(struct device *dev)
 
 static int ov5675_power_on(struct device *dev)
 {
-	u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov5675 *ov5675 = to_ov5675(sd);
 	int ret;
@@ -1014,8 +1011,11 @@ static int ov5675_power_on(struct device *dev)
 
 	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
 
-	/* 8192 xvclk cycles prior to the first SCCB transation */
-	usleep_range(delay_us, delay_us * 2);
+	/* Worst case quiesence gap is 1.365 milliseconds @ 6MHz XVCLK
+	 * Add an additional threshold grace period to ensure reset
+	 * completion before initiating our first I2C transaction.
+	 */
+	usleep_range(1500, 1600);
 
 	return 0;
 }

