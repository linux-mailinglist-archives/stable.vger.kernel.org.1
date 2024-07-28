Return-Path: <stable+bounces-62277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EE693E7EB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5FB2834FB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494C146D6D;
	Sun, 28 Jul 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+fKLKeA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2614658C;
	Sun, 28 Jul 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182860; cv=none; b=mA9+NEUwYmKlaKA9AqeWQ0CEI4FfUDFk6iL3pM8w5PeST+I6n7wBKrbkkip4OJBkVACPa7KFFobbM/k1AOzhvP6CP5SHsQlF/jtVBwGKSs1UNpxcMgezkI9iUh5xM9mQwtQblA3TJEwelFvFbbvlQwid8wHC8n+TG0WeKVrtV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182860; c=relaxed/simple;
	bh=o3fxRJr198nUOke7XZL7AlpthTh23DFZLzphgYmF8Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLuv4wXwBowE5qsqqPpMIGmvFv4rdr2IUK0K13A7w5aZSnuao62LMy10DggOcZ7HaoU6ZGkuaihptDyuekuXZD3w+zu2xiqMEEPPuhKTZGjIJSdubiMxAK2ciIqQgcAofunCt3PxICXc4FTGWvS7+HU6Dgl/JBGGWj+OUvQ02mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+fKLKeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9F1C4AF0B;
	Sun, 28 Jul 2024 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182860;
	bh=o3fxRJr198nUOke7XZL7AlpthTh23DFZLzphgYmF8Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+fKLKeAnA81sM01qnr9xnCSl7NbAFv9MM5zQGiU+JL98Yv79HIygMmYwEWJr7eUw
	 uiWiFgtmbrQCEz88bI/LTJgRA55s5tqT6/9Or37IbbYr4iQRvFoD1wKdoFJUiaBhqq
	 QQ6/4Icp0rr2mSWjiKfbALT87pSuNEpejw63jd5nakn5epzPKm/To3uxBVKxtFFUiL
	 GZO6MNq0pa12n34pgnYKma1WtGlnZFLtwMw+2Wwo/LPT2rEQMs5aWqDcUDZ2q8R4gL
	 w1ljP/4B9r29K3TrVrS8wrFTLWBiOxQVOFxJUNUEyzOa1MeW71Q0xVyoYxaleb2gW/
	 xRdZexxmXLvOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/17] ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C
Date: Sun, 28 Jul 2024 12:06:47 -0400
Message-ID: <20240728160709.2052627-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 92d5b5930e7d55ca07b483490d6298eee828bbe4 ]

Jack detection needs to rely on JD2, as most other Dell
AlderLake-based devices.

Closes: https://github.com/thesofproject/linux/issues/5021
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20240624121119.91552-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index dc144cd7e0e3b..db1dcb9d70466 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -425,6 +425,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		/* No Jack */
 		.driver_data = (void *)SOF_SDW_TGL_HDMI,
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B8C"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0


