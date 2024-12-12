Return-Path: <stable+bounces-101760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AE9EEE78
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E41890BE6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EE217F34;
	Thu, 12 Dec 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="prEAK3fP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8EC217679;
	Thu, 12 Dec 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018704; cv=none; b=KzYrU8H9XnZfbjGsMqIgT5F04IJp1rS7hoEOXIOcwvqxgLQIpUhtXGpWBsVegIhivYDpUbs+QFSLUQ9dlX1Men8i4oW3XG0zjhZSgkJuEAKME57iRnKNtJfoir9a/Auh3ILhEnhyhm/IPqcBohvoiTcSPfd6pNEwwSWQ9+68szM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018704; c=relaxed/simple;
	bh=uyzfo60qlzvlhRH/ECIBXyrvAbEXVufS1OzQGPnlvDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2h7cgqoPER7jeKDc1YzxKc3LOL44LsPuSN+DqOT9ivzyi35pWYLzdhMY2CP4W0VaoabBv+/B7dd258TC/DGqh3cj54fKDvkadYyIV6LQxLVKnJzAGxmJ4m1FOoRKtCWqvHzAD5YSFexrrhorVVyzhPleIY3J8KAFxrvekBhXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=prEAK3fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54CAC4CECE;
	Thu, 12 Dec 2024 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018704;
	bh=uyzfo60qlzvlhRH/ECIBXyrvAbEXVufS1OzQGPnlvDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prEAK3fPwtxUAiXHsM2kNbX+CgwpjC/Tc9hN50pQb5S2Pp+Iy2L2xcb88GWAalPXO
	 opkvq1ryp0+mIALpBQnQfypUwk/eK9oK4l6z1GT8voJ4405Pm/dWqbjn2k+8x1iI8z
	 OSc1KwguNEacos6zyWIYLTmgDjvUvdEegBWCyGLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/772] ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
Date: Thu, 12 Dec 2024 15:49:06 +0100
Message-ID: <20241212144349.871918555@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ff879e173d51d..7a57d7abd3803 100644
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
@@ -1687,9 +1690,33 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
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




