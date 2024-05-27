Return-Path: <stable+bounces-46523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49108D074C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745D41F23193
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F24161B6A;
	Mon, 27 May 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="layX1l3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DA16088F;
	Mon, 27 May 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825367; cv=none; b=XOg7ljzKH7J7lx1Fz1vYWDccfq5z+ngmuSefbtXdQ/0nq4NDEIvuVPnLOkmXQbs6uf8clMLXyh+ELUtIgT1mBiUH7xJtgYvNPnft2M9HOYS+n9xff1s6kmUT3Y5tie9zub+uzGOruxmvnoF13uOIl3RLxaUDMBv1UNSqBj6Bfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825367; c=relaxed/simple;
	bh=fAv49FxfjPWBFgHN2MTZQbQIwbW2xRZNMLpxxefCvXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egBUM4v+QEMKuWLm0d2ptL1iofKJeJrPSYTHnY7bvzTdUM2Zi9C4svYUQasvEAvtDBGXHauTyBJRx9bmlb2JKEk0vMWWor0064OA9r/ilhew2I2VyY1nhmFtklPGtpW0t2caijBKVW5288JQLcIQTY3adAEzwM2pG7hs2J8hoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=layX1l3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D20C4AF07;
	Mon, 27 May 2024 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825366;
	bh=fAv49FxfjPWBFgHN2MTZQbQIwbW2xRZNMLpxxefCvXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=layX1l3OptzEDVYVonhTcZUCyJwSNjOcCDYCqvGkAofzZZSNCAPHaLyOKiZxpLF00
	 JknGIs1PDCr59b8IYJQ1H+KJjlx/qACv9/4lA1eWhIdUvJk7uNmS5pEYg/C5T0QLpr
	 6EAu7PZWWiMLbUj+kSES0Hce3OiOckrSxWK+Vv95SluPrwqgxWXKN7w93cizsVsOE3
	 7cqUlx7qqDYEChFhOSdFOLe87Adspr6H7iqgSKBnGJDHws5uopiZj8C1tUYceDTZmI
	 QkBQ8O1lXsGA3aiNv5Ayw7WCKde9zqkoxeb492juu8VUFyD+gyQIqSNC7YkXh9aZED
	 vw2CKWOKnQcwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/16] ASoC: Intel: sof_sdw: add quirk for Dell SKU 0C0F
Date: Mon, 27 May 2024 11:54:56 -0400
Message-ID: <20240527155541.3865428-5-sashal@kernel.org>
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

[ Upstream commit b10cb955c6c0b8dbd9a768166d71cc12680b7fdf ]

The JD1 jack detection doesn't seem to work, use JD2.
Also use the 4 speaker configuration.

Link: https://github.com/thesofproject/linux/issues/4900
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20240411220347.131267-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 59621a9c389c7..91098d7922bef 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -436,6 +436,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					RT711_JD2 |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0C0F")
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2 |
+					SOF_SDW_FOUR_SPK),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0


