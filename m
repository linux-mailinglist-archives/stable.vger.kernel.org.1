Return-Path: <stable+bounces-89682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FB9BB28F
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECAB1F21CE2
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E782F1EBA1D;
	Mon,  4 Nov 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw2Ry4W4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77D1C6F72;
	Mon,  4 Nov 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717742; cv=none; b=HlGtwftmNwn4F6QTfk4S/IP5nX0154MY0NuJDjCAzelnfart44N4/sEaq82M8XLAb3GvphjwNgzg0TGuPOn3TZxoeHMe0SVYy21gtvq6dtQulSj3JMgARrWe1ikBwa5Q42iJZmNlt5Rsl5HOSPqylrxa0Hq6tAVXRJHL5fwETfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717742; c=relaxed/simple;
	bh=kJpDQw+xwsKO10rJ3WJ+NUqZU6XSrhQ2MlqEGPupdQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IP377Sylk84up7Q/yK3y7PKptLR1/LtjDLv5F3CxYPGFyqUQkb5FXsZGtJUF4EBjdnoVlxiGV9vbhZohFGHPPZ5LESK1TWVbjIRNq1P1ovQYIHzYLuh0QkZI0DOoGQTwqz7kj4AuWqNH6iSP/8jOurO156RSNjo9mU3WGoWJ21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw2Ry4W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACECC4CECE;
	Mon,  4 Nov 2024 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717742;
	bh=kJpDQw+xwsKO10rJ3WJ+NUqZU6XSrhQ2MlqEGPupdQg=;
	h=From:To:Cc:Subject:Date:From;
	b=Gw2Ry4W4/Z37gvUXr4rS6fIX6PQFg4FPsanPdaWbgupllhyTC9bcITxEAWJ0TY5AI
	 cb5MqQSj4yVT5lc6UkH4g4m/ypd/TroNN8x2v1rCnTE7ob07KEa7CnwM53vViJjL5I
	 ruOD7Ek+n7pyUmj3P66MdVEaZQYSPeplPog8JOjnLNgOE9HiGRxdQSlmqsfcuNgUQf
	 DS7OEFKrwi/A9yG2xsFOx3Ia2ul6izA+8LTjNOfdkrxxz8bp5AjWLDZkYo5gwN7drS
	 IwFaPJNxHSWD8cbq4RCL4PZd++iEtj5p9ydCD6CRo/Gkln0wkJso9Dvviak86G5tUb
	 URcdNKwEaAJtA==
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
Subject: [PATCH AUTOSEL 4.19 1/5] ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
Date: Mon,  4 Nov 2024 05:55:30 -0500
Message-ID: <20241104105539.98219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0107f28f135231da22a9ad5756bb16bd5cada4d5 ]

The Vexia Edu Atla 10 tablet mostly uses the BYTCR tablet defaults,
but as happens on more models it is using IN1 instead of IN3 for
its internal mic and JD_SRC_JD2_IN4N instead of JD_SRC_JD1_IN4P
for jack-detection.

Add a DMI quirk for this to fix the internal-mic and jack-detection.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241024211615.79518-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 16e2ab2903754..2ed63866e9cc6 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -879,6 +879,21 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Vexia Edu Atla 10 tablet */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Voyo Winpad A15 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-- 
2.43.0


