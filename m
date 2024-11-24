Return-Path: <stable+bounces-94949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1769D714D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F29282CF8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C41DFD8C;
	Sun, 24 Nov 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaeOV72X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F51AA7B4;
	Sun, 24 Nov 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455359; cv=none; b=KFv2CErUdu5gu9I/gfxK7SHOgNKsMBDtBhA401IoGjYp481wVkjlxIsunI+0LP8RVoqlT2RGJqswwVOMOnUky7ND6+ub9MO5V+dlqgSWzuinXo4M6YhNvU5GR30WwYLDQbyjd8Z+98XadvsH8KXR8Qqucl4xDeRrhc04/osD+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455359; c=relaxed/simple;
	bh=I54OsNFDBAW38NdX5RSVWH9Z1fPn986JRBuIhmFnsMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9g6SYJpS5EvzJi3VOftZQaWNgkCpF58N2vvJ9YK34Tew303srw0IoaiI7KuaP/78uUVYd5ckZ9Snbn7LyNAvatUzVAxm7dSCPdHyCNEUdFzThXTiO4MOd1A9TVmIh8PlXrUIgp5h1o4Bzg11n/NDjEbJ/d4k17pK+KLH/iq25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaeOV72X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4FBC4CECC;
	Sun, 24 Nov 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455358;
	bh=I54OsNFDBAW38NdX5RSVWH9Z1fPn986JRBuIhmFnsMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SaeOV72XNDJTTF3pOCCFFctS6gjIfL3DEr3rQqdWCCTp6XcCMdzVkK20ohmLwYRZz
	 0UMLmM7jow8ma3vT5Cvs+7BUHrIECirwdJnHr39ViuOPxEEJO1arsWawyYOrUORn5g
	 2uNaidYwm1ptEabqFG3v/I/NkgCfKK2nxYYtUJXR/QlKzcdra+PwU0RgoKOSSrSV/4
	 QXTQmFzDC03NIZRLYXvr/oFVy8jLuwsjEPvs4h5u5VDHJXs49q5sVos6HjrsUSNeCh
	 1b0QtRb5eHAljgNF6xEoagCdJf5ZEtXlvg4wxdJ8FT26Dh+uuvCfZf5eRJLqf1PGZi
	 hxs+UWDX6/Mrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 053/107] ASoC: Intel: sof_sdw: Add quirks for some new Lenovo laptops
Date: Sun, 24 Nov 2024 08:29:13 -0500
Message-ID: <20241124133301.3341829-53-sashal@kernel.org>
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

[ Upstream commit 83c062ae81e89f73e3ab85953111a8b3daaaf98e ]

Add some more sidecar amplifier quirks.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241016030344.13535-5-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index fa937cc4d8cd1..a58842a8c8a64 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -580,6 +580,30 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "3838")
+		},
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "3832")
+		},
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "380E")
+		},
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
@@ -589,6 +613,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		/* Note this quirk excludes the CODEC mic */
 		.driver_data = (void *)(SOC_SDW_CODEC_MIC),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "233B")
+		},
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+	},
 
 	/* ArrowLake devices */
 	{
-- 
2.43.0


