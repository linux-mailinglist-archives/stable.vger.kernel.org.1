Return-Path: <stable+bounces-46505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07E8D070E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926EC1F23F65
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E3167285;
	Mon, 27 May 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8GYVNTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8C13AD23;
	Mon, 27 May 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825259; cv=none; b=LRvWgRkGn5DyTLQbLfo/D/f6AyinpPo1fUas7do/gewcF4ixLl3k70zVg/WLZKXGWdcGIq30/WN8fyWZqu5dBwUsAgwKGCHujBY0ux0gqcmsJ0nGYO+aHAohO0llKelBTVzMuTRbyyrdWFIsu6o2RCRS93h5UFuvkajRGgwuP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825259; c=relaxed/simple;
	bh=Nd1TIhD6iw1hsjb+KKv3Uy6VnZoxV0BzPDvKZ/mNWhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+HIGuGuvyShzs+kgwUHoOUwNoVLcUwguPmKhP0nPQfslqRKVvMvetALGoGWVZoQXtkux7xw4AGfR3LwwsKs8GGRCy/EINrWi+4kGfMbSrzDBVxvOEiOFgLp6k+EgJgB9Dvg4MN/3J9SEgbgPu2sYxQypsIupub83faLKyV3ruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8GYVNTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD7AC2BBFC;
	Mon, 27 May 2024 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825259;
	bh=Nd1TIhD6iw1hsjb+KKv3Uy6VnZoxV0BzPDvKZ/mNWhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8GYVNTl2q96yfgPRh4V5ml4M4y+T3bnFt2TtechPspKtf/G6ghfCFTkVreSQQtgx
	 xkqjMRsyMMhQQNtR6QiwexOUCpNzsEOATCKYHlyoxilXRQi9vGi2Qv/LQb/N/UA36k
	 KO+duLhO0wkkzD5nPJzNpL9xtpZ/oAWJuMhgmtdfMrbFirTHtI/4GwTwjD8w+KIZk6
	 9UNL6SfIbhPVaVqpnsz+JwrlKawlYjCEN4hrar2Ei+VKyAfa0muJLqoWRvRNIvHmWY
	 rGh3vXh94uwx6vmMwFw2U7Zzs6yqqrTTneyX/JjHSXrLvH+jjc5g8xjYbOlZBbHsjq
	 i2pNaTkAZxgaw==
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
Subject: [PATCH AUTOSEL 6.8 07/20] ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
Date: Mon, 27 May 2024 11:52:50 -0400
Message-ID: <20240527155349.3864778-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index cf14bd3053fc9..9a4f801be93d1 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -495,6 +495,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
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


