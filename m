Return-Path: <stable+bounces-46522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750608D074A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68111C2269F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C2161915;
	Mon, 27 May 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z79BUZno"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221816088F;
	Mon, 27 May 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825363; cv=none; b=KL3IYLwG9TbcHOeNEYOrWQl8WPei/5GTY+pQyC849yM8O46cfKOtRunSkInxNyrHXnY24KvKNEry3NTv2eAURzx76tt5L0Kb3B+Zd8C5dlGVMLSf+udPGGrm6lT7UVAdizd9TnQ0XQ1QAdxHdwHVoXp3EIHFXnwplE8D0gfRIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825363; c=relaxed/simple;
	bh=E5DaFtZIyxLWlnp164qlR0jAfGeq/UpBF6p2+NL0GGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWwMT/ZZyUdhcNBD5A81o3KXvXyUZs899FIO2MK1SkISxvFKspApf2oRYVogKhtMFlXar//TygF/QCdcgojSGnJkSyXVj9aSmX5HMzqBR+MgZEEl3+PlyTlhoeEcy9iFF4cfaUTfBT2GmGwONjwnDb3/IuncqMQdvpDG3fKjztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z79BUZno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C73BC2BBFC;
	Mon, 27 May 2024 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825363;
	bh=E5DaFtZIyxLWlnp164qlR0jAfGeq/UpBF6p2+NL0GGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z79BUZnoAHHy7Ov1HzOQnTrIW2ZcxOgZDkPHMhilEBjZWVLyb3TJpF5TKaVlX3jaw
	 SVB2zo3HEEpuGs4Y9stznligiJlwU1IQ24EZ/z7qEfWdqDAD9HptLwLSdkZ1kzQNih
	 IBLuteE85nZV41y46x8N4Ie64fu2te+CzdhEPLPtUcGtsSI0BYr2As2WlnGqmu+sa1
	 joFqf2lJ7Ks0VTuNz6FmZrGmXkzxNmCL3a8bDo69QXXxxXNBTY122rT39GYwF+EXgf
	 gF48q77cltnDfgvCn0SMQfMZgGhbTpp1XMHpfa9bV9fDrKFD6fFpHVuJS/WXCVe+QP
	 GF5pRbwkfnpTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/16] ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
Date: Mon, 27 May 2024 11:54:55 -0400
Message-ID: <20240527155541.3865428-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155541.3865428-1-sashal@kernel.org>
References: <20240527155541.3865428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 4fee07fbf47d2a5f1065d985459e5ce7bf7969f0 ]

The default JD1 does not seem to work, use JD2 instead.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240411220347.131267-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 0ea7812125fee..59621a9c389c7 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -502,6 +502,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_BT_OFFLOAD_SSP(1) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN Transcend Gaming Laptop"),
+		},
+		.driver_data = (void *)(RT711_JD2),
+	},
+
 	/* LunarLake devices */
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.43.0


