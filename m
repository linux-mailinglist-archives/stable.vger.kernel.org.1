Return-Path: <stable+bounces-58895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4245E92C147
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F431C22F73
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD31AA37F;
	Tue,  9 Jul 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB2+WQ45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA861AA358;
	Tue,  9 Jul 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542420; cv=none; b=GKtEFQZq9VvIPsNQQp/cyIGoaB5dWU6I4ULxgovK+ZlXOfClTWZkJ772QXzJ0zCUGtZfwIKS3z1bVvbhvKDlz/bWFNn9XQJfix6aoy8/cPBmEv1g0U0Y+RCcn2+NLr0YmW5xbURikybuVtw/BtMo8rjRv6SmfNpGAT3uWlKuRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542420; c=relaxed/simple;
	bh=mP2+Pn/3K3evspy9XGb9JyHVN6ZUhaYHN7nE6Ykj3Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCqPL0Ee1qjOUDkAVgrnCl+rzLXOfcVe/VcPinyWLb62XmeoRyyC6Frx1eEvRxiUYIU+lqdy508aYuXX/pkkCx8k9DObTqtOEUOWl1okm+Bd+kh9Y4nxqvPr1eVqu6fnGhkVd0Em+8ejOsTXmr9NnHrz5+yg3hTWhSmtu8lIxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB2+WQ45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2243C3277B;
	Tue,  9 Jul 2024 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542419;
	bh=mP2+Pn/3K3evspy9XGb9JyHVN6ZUhaYHN7nE6Ykj3Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EB2+WQ45r/Kr4frTVvI1Lys9Ksh2aOonaN1op5xFLQmzI5/R6peZxS8Z88bL9Pe5i
	 xjNZPpDiWB17oDK2uum1fDrHhOY20GtSYBfJiYalBTKqd1LOl44jpCCGYL8VbZS2u8
	 u6x5Smp2a/UBPYSMeryc1EPnsym0ckSW3coOwSusSdtIU9XB/qzaUtxtdrWJPMPnyK
	 C0DoLsTutp5e5mwjTR0yFSm0QTWmk4uULzcb6ClOxmE6w/OiTZ6MiGNl4PJJqFmlyH
	 RmdFX/Uc4ereofJQhI9QQJN7oanmEjCsu1UlGs9aXcJPPmY/LnqZZP+3+F3EdsD0Ck
	 2NJyV9dS0DzpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas GENTY <tomlohave@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
	kuninori.morimoto.gx@renesas.com,
	alban.boye@protonmail.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/11] bytcr_rt5640 : inverse jack detect for Archos 101 cesium
Date: Tue,  9 Jul 2024 12:26:35 -0400
Message-ID: <20240709162654.33343-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162654.33343-1-sashal@kernel.org>
References: <20240709162654.33343-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
Content-Transfer-Encoding: 8bit

From: Thomas GENTY <tomlohave@gmail.com>

[ Upstream commit e3209a1827646daaab744aa6a5767b1f57fb5385 ]

When headphones are plugged in, they appear absent; when they are removed,
they appear present.
Add a specific entry in bytcr_rt5640 for this device

Signed-off-by: Thomas GENTY <tomlohave@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240608170251.99936-1-tomlohave@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index c740dec00f83b..057ecfe2c8b5c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -465,6 +465,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 101 CESIUM"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
-- 
2.43.0


