Return-Path: <stable+bounces-89861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F49BD21C
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5871F218DE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7F1714B6;
	Tue,  5 Nov 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ttdfPDUE"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF1170A2A
	for <Stable@vger.kernel.org>; Tue,  5 Nov 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823442; cv=none; b=f8EKolu3Lj7THl3TQ84TXGfTqi4Ip6aHCWGhSfVuWiNpT7ZaGsKMPFrhKlNxMnwSBYEhtsmgjy2vDdTON4rPQv5wYszbuDRE3iHCpxUI3iisV7bET1abqP0zFP7CHVc4qxX5jcteCl/J2nB43VRfv2RRCHzYXyzBy3aVmNhij3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823442; c=relaxed/simple;
	bh=hCdOCVlL3kMzhK4cBkaXvB4Xj5sfIJq4gRu/KYFbVv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EDFpg5Y0vPLgtiJ2wGWQCA2prlQIAcYcNdoUo5N/B91HeK+F3Qdp43YWq/J2ACP2h5z7TKSyydWv5O5EMCY0KxUsTa3Q2CBU/bWx2c2qvRGn2Lt/U0gpOrMqfOqSGLdsWd2s138qSNEkadYljUP4BvRrt+8IiqFm/d8aFkGXNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ttdfPDUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC94C4CECF;
	Tue,  5 Nov 2024 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730823442;
	bh=hCdOCVlL3kMzhK4cBkaXvB4Xj5sfIJq4gRu/KYFbVv8=;
	h=Subject:To:Cc:From:Date:From;
	b=ttdfPDUEluYsi3rB24VLoFX8valHFAq6XcjdLfteyQ6GTJjLS3Ozy7uteEE7e+khc
	 HvGFOg69Vgd1qgUfOH/qXz5jNSrJgBgj1kjpp5Axuwse8kbWWGJ8DoSuVxhG3HkVxl
	 pSqVNwZIgfT1NBqlVywrV0mUHfN1LC5/L/geL440=
Subject: FAILED: patch "[PATCH] iio: adc: ad7380: fix supplies for ad7380-4" failed to apply to 6.11-stable tree
To: jstephan@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:17:04 +0100
Message-ID: <2024110504-eloquent-stalling-91df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 05f9c67179c9a8d66dee175fb4b17f380908a26f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110504-eloquent-stalling-91df@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05f9c67179c9a8d66dee175fb4b17f380908a26f Mon Sep 17 00:00:00 2001
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 22 Oct 2024 15:22:39 +0200
Subject: [PATCH] iio: adc: ad7380: fix supplies for ad7380-4

ad7380-4 is the only device in the family that does not have an internal
reference. It uses "refin" as a required external reference.
All other devices in the family use "refio"" as an optional external
reference.

Fixes: 737413da8704 ("iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://patch.msgid.link/20241022-ad7380-fix-supplies-v3-4-f0cefe1b7fa6@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index b107d8e97ab3..fb728570debe 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -89,6 +89,7 @@ struct ad7380_chip_info {
 	bool has_mux;
 	const char * const *supplies;
 	unsigned int num_supplies;
+	bool external_ref_only;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -431,6 +432,7 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
 	.num_supplies = ARRAY_SIZE(ad7380_supplies),
+	.external_ref_only = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -1047,17 +1049,31 @@ static int ad7380_probe(struct spi_device *spi)
 				     "Failed to enable power supplies\n");
 	fsleep(T_POWERUP_US);
 
-	/*
-	 * If there is no REFIO supply, then it means that we are using
-	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
-	 */
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(&spi->dev, ret,
-				     "Failed to get refio regulator\n");
+	if (st->chip_info->external_ref_only) {
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "refin");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get refin regulator\n");
 
-	external_ref_en = ret != -ENODEV;
-	st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
+		st->vref_mv = ret / 1000;
+
+		/* these chips don't have a register bit for this */
+		external_ref_en = false;
+	} else {
+		/*
+		 * If there is no REFIO supply, then it means that we are using
+		 * the internal reference, otherwise REFIO is reference voltage.
+		 */
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "refio");
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get refio regulator\n");
+
+		external_ref_en = ret != -ENODEV;
+		st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
+	}
 
 	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
 		return dev_err_probe(&spi->dev, -EINVAL,


