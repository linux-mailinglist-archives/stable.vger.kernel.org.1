Return-Path: <stable+bounces-94947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E809D7146
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677AD163BD8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3E1DF27B;
	Sun, 24 Nov 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZq6XT6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A11A7275;
	Sun, 24 Nov 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455351; cv=none; b=EtKacMC9g+f7RFGLpIRo/rbsKuSomZtD0Qc1IU1S3GjEY34vY1iM/1w6KpU+eynTimafBIvTHghjWAWvag3vJBFBxMNM/AU+PNNM1DJL1iobzu4TOlZnG4inBmIhr3K9wmJ17Qfcwy8lKMsL8R/bWBAOkO8Z9di93v/rovv23To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455351; c=relaxed/simple;
	bh=3sQGpphI/2dGmrf3ZuBlJQb2gp57vrjutXFxoL3bvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaBZNTGzzlql6Botp8qr0HG2gxofqOYsiuHRJECctDkASwk7o3jYaIThO87ssCeqKDiiTPClpk97OBkPom+HpgMf8hyUvxoPV/YUlvXGNORYzqtUZvHtVek4xQ/PsG92m+Yg+cCE+X+JfNjown6/o4NJ2GCCrla7jDCiEVlko9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZq6XT6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B031C4CECC;
	Sun, 24 Nov 2024 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455350;
	bh=3sQGpphI/2dGmrf3ZuBlJQb2gp57vrjutXFxoL3bvvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZq6XT6LPYzrgmnAsl3j1p4+YGPjIJhJ0dUsgaUhMdReyz+9OnhsEPYTBnizISaJX
	 AiUCqd/tikbRoadfzjEbuaEEfs1fZwDswGy0nkCfj99RgHiGpVHN3iJVSylPFdlvaB
	 Ax7ly6ichAsMG7uW69anocYVp0s5ganZZbr1A9N2ZcAiWlfxBykPcS6t35riWVQhRz
	 mXcAYwU/AMp2RoMi+EWsny7isyGGnKYhw0VcWz2TUQX3Q5oG8HC8Z8DvIxBXDXIeL9
	 aHt0xOL+s6WKc+E61P9CIIcltKZyMqLuZIp/724jiVZ3YAADCatKQcjkK7MXIqhFD5
	 GZHSLqF+mSaiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	Vijendar.Mukunda@amd.com,
	naveen.m@intel.com,
	mac.chiang@intel.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 051/107] ASoC: sdw_utils: Add a quirk to allow the cs42l43 mic DAI to be ignored
Date: Sun, 24 Nov 2024 08:29:11 -0500
Message-ID: <20241124133301.3341829-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit a6f7afb39362ef70d08d23e5bfc0a14d69fafea1 ]

To support some systems using host microphones add a quirk to allow the
cs42l43 microphone DAI link to be ignored.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241016030344.13535-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc_sdw_utils.h       | 1 +
 sound/soc/sdw_utils/soc_sdw_utils.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index dc7541b7b6158..0150b3735b4bd 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -28,6 +28,7 @@
  *   - SOC_SDW_CODEC_SPKR | SOF_SIDECAR_AMPS - Not currently supported
  */
 #define SOC_SDW_SIDECAR_AMPS		BIT(16)
+#define SOC_SDW_CODEC_MIC		BIT(17)
 
 #define SOC_SDW_UNUSED_DAI_ID		-1
 #define SOC_SDW_JACK_OUT_DAI_ID		0
diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 863b4d5527cbe..c06963ac7fafa 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -487,6 +487,8 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.rtd_init = asoc_sdw_cs42l43_dmic_rtd_init,
 				.widgets = generic_dmic_widgets,
 				.num_widgets = ARRAY_SIZE(generic_dmic_widgets),
+				.quirk = SOC_SDW_CODEC_MIC,
+				.quirk_exclude = true,
 			},
 			{
 				.direction = {false, true},
-- 
2.43.0


