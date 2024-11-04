Return-Path: <stable+bounces-89620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A749BB1A0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E622822EF
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9C1BB6BA;
	Mon,  4 Nov 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikkd9HeP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA11B9835;
	Mon,  4 Nov 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717465; cv=none; b=XrXGzVM+Kdca1h/yZshV3zEQyRUQAOm99U3wrxWX5A2SgIr01/MPRiAJD/LDzsvypCI2RlXCEEPWhTqyeNj69aJVNKhHVvd4QTzMCj0EtMozC61r+dchNfR/B6uN9juGLC52bAXTLPl9W/rSDI3XtKdpAT5zOt4OYVhJ1Vu3itk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717465; c=relaxed/simple;
	bh=lL6mXjSjd898xb2vfgRX7EI4j+7rWrM/ViTiNlFpJII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFzj2dSWPPNwY1fmWKOuZM7fKZlo7/6AEq6F4ZnV7mby2UDchrB9sAf6ipp3BaMd446gYeLCjAEvD39unarXIs8w2t43LlnYW++yz1kTi1OmQYRqFzqhuaJdYNaurCXSUIZhOKkUuNdDtH6nu+8/IYzhMyZaoNifzxlzAi688o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikkd9HeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C664C4CED5;
	Mon,  4 Nov 2024 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717465;
	bh=lL6mXjSjd898xb2vfgRX7EI4j+7rWrM/ViTiNlFpJII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikkd9HePx3FXHZlzIjjRN+N7z+fx6codO46B2zmcPuyUyxSo5XO443nUqXDz3UROY
	 FXPhRxwuFhyzGxNYVxhc9uVJCgynSgbDWUcpyqtHLr5dPaq19G/JEKcNIbBfoJ65Q1
	 lBlRFuMaaS1cseu/oKjBTne1lzNZ43j4d6Z1LJQ2FsUXjO2ZyXuZIb6YDL+eLpfjG3
	 gd38eLNYkEQ/BgqDfcnWL5vttwI1KC4V0SGhqk4wTcEINKfotbmqpRUUhdyioJL/MY
	 T87Fm7HwPPc8D6GQh1hEF0ZxhmiktUeTq4iMS2b8tL0l9WkRb49+fnjCtOW91Xg0Ei
	 n27oY6Fp1oBew==
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
	tomlohave@gmail.com,
	u.kleine-koenig@baylibre.com,
	alban.boye@protonmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 07/21] ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
Date: Mon,  4 Nov 2024 05:49:43 -0500
Message-ID: <20241104105048.96444-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
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
index 4479825c08b5e..ba4293ae7c24f 100644
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
@@ -1698,9 +1701,33 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
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


