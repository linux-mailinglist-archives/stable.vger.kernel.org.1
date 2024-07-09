Return-Path: <stable+bounces-58810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5629892C03A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF741F21733
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794B19E7E3;
	Tue,  9 Jul 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1OFwLGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB91A00C1;
	Tue,  9 Jul 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542165; cv=none; b=Xkrsu1inRk5lNTDoxkTfBsWX2mR3O1yQPIbCLNi3SU5zCqFkX9dcznO3tzKy2CzbhUlE67xgKxCwCafrGb34WejyBq9w1KuAdYAHAMKkGYjR/4Br048GdK4ovWNLsiXZZH1gJgCMy6ifgU6BTCcMTzVhmtmxQyuMqX2wSoTwwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542165; c=relaxed/simple;
	bh=nLWJVFLnUTBOHp+Zg4qjHCWvREOSbRepbVtkv3TIICw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaD1+tyI1h7mM9qduNQ58TIAYRcFkjdJH/+s6XHUdFSnTQXi4he4WIZWbrdIL3KFi2z2CUiRsYvTnwEEXybzD/fTkH41FGDtQA0AsaN+eYHy8bkKQMWmuYP3vbyQ+F6iwcQ1sSPi/ukMnxzEW5454BctMbtFLh4eTz2oH6FUJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1OFwLGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5D6C3277B;
	Tue,  9 Jul 2024 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542164;
	bh=nLWJVFLnUTBOHp+Zg4qjHCWvREOSbRepbVtkv3TIICw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1OFwLGxMAzzV/6ZGoh5RZBnxVDQFldZoBihdDhUegOCI90U6YmrcWU0vx2hbilOC
	 XT1Byr/QE2xHhYGinY7yiqjd3iSrDds2rWzdZQWCDbsfw3TTe7ud2voCi3FcJ5paml
	 5QPsKaivw18c+jDPni/qKta0CaxxxMUEIQaLkWdMZR6cMC8PABAQZJOLwWuAXFeQ1c
	 HtiIaVGOFba6otwqBC1beST1LsGYn6a5I7UlJqR1KAdkDl8P4MekMewXDOlWSKSSW2
	 ZOEaiOMfo9oRNcRHXDTD5/yfSWx1glUoffHh+vWfBstqKC3SQGiZFxwWuaW4voL4v/
	 SSbZhv85NSZXQ==
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
	alban.boye@protonmail.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/33] bytcr_rt5640 : inverse jack detect for Archos 101 cesium
Date: Tue,  9 Jul 2024 12:21:34 -0400
Message-ID: <20240709162224.31148-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index 651408c6f399d..5b8b21ade9cfe 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -610,6 +610,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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


