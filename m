Return-Path: <stable+bounces-89637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841589BB1E5
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55C41C21231
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EBC1B3925;
	Mon,  4 Nov 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY06DNwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC271CF2B2;
	Mon,  4 Nov 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717556; cv=none; b=KRySXlWj1+oywmxl8PMNSLfE0lYUtnaA1srS355gq86NBw0NFPzsGIcP+VYQqULSVjwi/+DK0zMkH6dKDac9l9HkJVPWyCBazHmrGJOUIajgSPYOu+3ucvWQFRykh1EaFauqi7lHK+yJsBkGg3BtFRgiy9m9OrgJnyDtzsGG1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717556; c=relaxed/simple;
	bh=wBLG1Che7L96AwMT+MeSjRzLbVK81M5bL/qC/CdUwKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrWUUbzuOlWg+LfV4KeFT0BPQHwcydUetNgjk7ZZi0ehvUNys008LuBqSUlOv+I9BNlK3erUQNenItuceXcz8X6DcVBuHJvTLvmKQg++kpp6xryZrVqsdAaXDTza1fNAz1vTSjdFeAzowU3SkaRsL9x8HSPAAejgYtNcD87DI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY06DNwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F9C4CECE;
	Mon,  4 Nov 2024 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717556;
	bh=wBLG1Che7L96AwMT+MeSjRzLbVK81M5bL/qC/CdUwKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mY06DNwmjt/Pj9KKxCG/u7PXMwq0Cp46omQtXyj2Z//s3slO2lRVQWCRyyXHQovGQ
	 NOti9+zBwp89DfBcHK4L3PVUgeDGlLbTiivnG6wJj3abiN7hEStpSJqLFhydtmBdfn
	 DNbEu4QfJZVtfsPwCGCEbnaYPfchiNIe+tGmUst857BcxPn6nIF54Sub7yOJfwFRZD
	 DHJ4mJym4bhf+JB1vbU+oxyjKRMqXRB+LsibX0dFInw5/9ApWF4xOHcv35VECmAAQs
	 iU3UfrmWH9RorxqX8nqBRUvMtReCIR/SCG2/wipP3XVW7YaHJ2umV/t3u9ZF1njHK3
	 aj6nWES5POKmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	alban.boye@protonmail.com,
	u.kleine-koenig@baylibre.com,
	tomlohave@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/14] ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
Date: Mon,  4 Nov 2024 05:51:55 -0500
Message-ID: <20241104105228.97053-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit d48696b915527b5bcdd207a299aec03fb037eb17 ]

On some x86 Bay Trail tablets which shipped with Android as factory OS,
the DSDT is so broken that the codec needs to be manually instantatiated
by the special x86-android-tablets.ko "fixup" driver for cases like this.

This means that the codec-dev cannot be retrieved through its ACPI fwnode,
add support to the bytcr_rt5640 machine driver for such manually
instantiated rt5640 i2c_clients.

An example of a tablet which needs this is the Vexia EDU ATLA 10 tablet,
which has been distributed to schools in the Spanish Andalucía region.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241024211615.79518-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 33 ++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5b8b21ade9cfe..79c50498144ec 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -17,6 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
 #include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
@@ -32,6 +33,8 @@
 #include "../atom/sst-atom-controls.h"
 #include "../common/soc-intel-quirks.h"
 
+#define BYT_RT5640_FALLBACK_CODEC_DEV_NAME	"i2c-rt5640"
+
 enum {
 	BYT_RT5640_DMIC1_MAP,
 	BYT_RT5640_DMIC2_MAP,
@@ -1697,9 +1700,33 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	codec_dev = acpi_get_first_physical_node(adev);
 	acpi_dev_put(adev);
-	if (!codec_dev)
-		return -EPROBE_DEFER;
-	priv->codec_dev = get_device(codec_dev);
+
+	if (codec_dev) {
+		priv->codec_dev = get_device(codec_dev);
+	} else {
+		/*
+		 * Special case for Android tablets where the codec i2c_client
+		 * has been manually instantiated by x86_android_tablets.ko due
+		 * to a broken DSDT.
+		 */
+		codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL,
+					BYT_RT5640_FALLBACK_CODEC_DEV_NAME);
+		if (!codec_dev)
+			return -EPROBE_DEFER;
+
+		if (!i2c_verify_client(codec_dev)) {
+			dev_err(dev, "Error '%s' is not an i2c_client\n",
+				BYT_RT5640_FALLBACK_CODEC_DEV_NAME);
+			put_device(codec_dev);
+		}
+
+		/* fixup codec name */
+		strscpy(byt_rt5640_codec_name, BYT_RT5640_FALLBACK_CODEC_DEV_NAME,
+			sizeof(byt_rt5640_codec_name));
+
+		/* bus_find_device() returns a reference no need to get() */
+		priv->codec_dev = codec_dev;
+	}
 
 	/*
 	 * swap SSP0 if bytcr is detected
-- 
2.43.0


