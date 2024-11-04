Return-Path: <stable+bounces-89660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB239BB23A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FCE1C20FED
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E3C1B3946;
	Mon,  4 Nov 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUUv5ouT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6F1B21AF;
	Mon,  4 Nov 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717658; cv=none; b=IB7YiCsWCx84Lz+ppoVurowwxqsy88vrICXnEDzf0sztPDDcpAhoJC8KH94UJIVSN7h54EsTtGp5CgkTQvlmcGfIdZQPDuqBAF3gMo3EluzuiaWKZKGPsUG3PMs/PrrtD3CjD5pAyyWv1W0BHMp584oQiCOjFOp/6earlSkybp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717658; c=relaxed/simple;
	bh=olo6eprQKwiH0qtFdCz7PVn2ZSidv6KVC1elYUD1bTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jB9zIAR028YL3EfUHhzJB+XMvxZh6oE05ViIGYnou+rhwjPYUtwXpbJX7M6ArtE5raLbHKDPNfYdqVmNHM5EkXnG4Bu0bTKUTuBvOzmf54gr12Ix6HJ0iOta9tuacqyZ/hm1ZVEQsm5KGTnMXflp72cHypZOhHeV5iskY3OmC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUUv5ouT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5518EC4CED1;
	Mon,  4 Nov 2024 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717658;
	bh=olo6eprQKwiH0qtFdCz7PVn2ZSidv6KVC1elYUD1bTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BUUv5ouT/ujvlSFuc1sxZh1xmhV94QJs/eFIaFukY80F9HYKi5/jbkxjbaBo6EXJW
	 1a6nISwrGRChRqN5Sjc7/Lq3RcCblPt1JI12I7ZMlEbnM4UEmhdPpN9ERLvR1AC1ja
	 aojuIXB6A3euhcrGOATBUbKuiPP5UupTpzg3KWz2AyRv5Ic0KrTp5kaRAuO39PrO2L
	 onDsMXKA6e3noTLdfSskMpBVajj3PiTRHlMWwpN2FPvsWSdVbuplOwVyZndJI5oQKA
	 hpWMfiAQQA5zirX+Yy2EmcYD6th0Aeim6v+8mfuyvYhNjJEEN+XDioFQp+tbSkAgVy
	 SNTUGrLlGYuoQ==
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
Subject: [PATCH AUTOSEL 5.15 01/10] ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec
Date: Mon,  4 Nov 2024 05:53:50 -0500
Message-ID: <20241104105414.97666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.170
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
index 3d2a0e8cad9a5..899a8435a1eb8 100644
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
@@ -1616,9 +1619,33 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
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


