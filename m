Return-Path: <stable+bounces-112106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F9A269BE
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F57165AE9
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708D21519D;
	Tue,  4 Feb 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV9jUuc0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A5202C34;
	Tue,  4 Feb 2025 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631942; cv=none; b=DJQ20Na9WbWpijwVQJ21kFQHE5na1XIdQfxbk3Sq2uBf87W+oM2hyShwjGapmgeKgJHblTd2BweEsZosBlpjT8w3pRlnRP2twUWf1hz4lf1DWrgoajsn4YSHxW3CBMEAVKSpaqbDotJ7PHqxNfjmaZMpbjrxM5hlv1h3xKCPoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631942; c=relaxed/simple;
	bh=pfrrvf6qv3qt2xl3dimFpcaq4Vglrm2xBzzAceCJ210=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7hHX59vmTpKxq4vv23q9JRCm3Ij8Btt4DAw7O0pyoLhNPlyEpQrLHpQIueicusS6yDO+a2Pkww26nJ7a7+ufiUUfSEVOLmHoKZBB9zyEeS1s9n5Nx3soi3eaC4mwq3x3xApEXC6TgiGiYHWRxLfmHLL0nO1hMeECDrH6GoWOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV9jUuc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD786C4CEE0;
	Tue,  4 Feb 2025 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631941;
	bh=pfrrvf6qv3qt2xl3dimFpcaq4Vglrm2xBzzAceCJ210=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV9jUuc0lCq5MxBKutNk/G2RB8Rt9ZQrkhPmP/ivOtn7irwmB/ayZXbMQGIIFFeRm
	 xGYHK/Qcm6gM/FuArtGBsLEVthvZyqo8F12Hc9kWyEZepUbc+n/6UXDFBoDoDNCgsm
	 d6za1fK1Z1Wgl87ULuWrCTCsPbRFYwjRmihxALv0+oo1uGYyiHFyD0oQ8g/u2uDaU4
	 HPXbIKTXI5WiJw8Pc9OZXrE3f1zg+GYqKZ33AL8f4CiNSowkYhL80zWrOVMpIwhGTb
	 IfuT7pt8YvyXbW8CPAylmKxKKyJYZcOcCGdKvZFnr7Qz69qOWZRmnF5Ahg/lpsQ3DF
	 h4bG38Rq0GXRw==
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
	kuninori.morimoto.gx@renesas.com,
	tomlohave@gmail.com,
	u.kleine-koenig@baylibre.com,
	alban.boye@protonmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/2] ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V
Date: Mon,  3 Feb 2025 20:18:53 -0500
Message-Id: <20250204011853.2207241-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011853.2207241-1-sashal@kernel.org>
References: <20250204011853.2207241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 6917192378c1ce17ba31df51c4e0d8b1c97a453b ]

The Vexia EDU ATLA 10 tablet comes in 2 different versions with
significantly different mainboards. The only outward difference is that
the charging barrel on one is marked 5V and the other is marked 9V.

The 5V version mostly works with the BYTCR defaults, except that it is
missing a CHAN package in its ACPI tables and the default of using
SSP0-AIF2 is wrong, instead SSP0-AIF1 must be used. That and its jack
detect signal is not inverted as it usually is.

Add a DMI quirk for the 5V version to fix sound not working.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20250123132507.18434-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 6fc6a1fcd935e..06559f2afe326 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -935,7 +935,22 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
-	{	/* Vexia Edu Atla 10 tablet */
+	{
+		/* Vexia Edu Atla 10 tablet 5V version */
+		.matches = {
+			/* Having all 3 of these not set is somewhat unique */
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Vexia Edu Atla 10 tablet 9V version */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
-- 
2.39.5


