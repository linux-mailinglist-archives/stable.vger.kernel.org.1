Return-Path: <stable+bounces-46553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED38D07B2
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D6A297D0D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B7167DBB;
	Mon, 27 May 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TflQkn5l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0B15FA87;
	Mon, 27 May 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825544; cv=none; b=IiF2utYri5VIPGzIk/Gq8O2gbvQPq4YUDUexj7vjkHDEQbCk/OwizSo/CD+3bDfr1l9k7diNDbzYNeTePFlgvVaw+lIwOlvyg3HYew90XeZx0fo6z7MgBg3f5aAslZmw7uZkhx/cXoPaLFCnLHa3yds7UcM/q/Yf9Ryrx8t1f4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825544; c=relaxed/simple;
	bh=Re9r1HZSnJBp/ABv73t44f6FfiI/yh6x4nMP3L9lO1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DamhchzdbbInUWYdlWY5YItOxMchi9i59wPmI1lmd1BDdVyy3bSFSIIQEX5u6yqvBwOcq1zGFLEU+b8ToryIVWCxPMVnGXqRzw8uHOXgPdWRJaFqyF6dLSWP4Uz1xWxmpnJj1wTyPxHMd/nwoEZQ+/tevRBsvduhVQO+mAkkOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TflQkn5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F9C32789;
	Mon, 27 May 2024 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825543;
	bh=Re9r1HZSnJBp/ABv73t44f6FfiI/yh6x4nMP3L9lO1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TflQkn5lka152MNT/XYuGHAy5J/ufkcUxouxIcwChnThMAinOg/OLl1XWWeZESrdI
	 JN5FmPib7zeHlDVsJ4Ip+UB9k1Ssvb7S7JtrInkXAwmQKfmeIWmVdwYS2AvRZC4+2N
	 YfeAS+5lcV84+ZG/8TWHrhYIkE2HePAJUsabJgm6QzJKph1ZBR9r0qIwA2/B8KtFQQ
	 xOSWRt3GCjEprP+O3Mo2N75Vrwak6vh1wMhwBPvh5L0PfpT6W7KbcQqd8+Q+7ZUFSb
	 tDettvfC9WLs3dzh5yFjoA4qQG2hrMyswU1hPllFv71GIcZUePOgOdzrkBcLbQUzKF
	 I1VFvdHLQpDlQ==
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
Subject: [PATCH AUTOSEL 5.10 2/7] ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
Date: Mon, 27 May 2024 11:58:26 -0400
Message-ID: <20240527155845.3866271-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155845.3866271-1-sashal@kernel.org>
References: <20240527155845.3866271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index f36a0fda1b6ae..25bf73a7e7bfa 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -216,6 +216,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
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


