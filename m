Return-Path: <stable+bounces-5371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676680CB76
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4339EB2137D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AE4777E;
	Mon, 11 Dec 2023 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs6AZikW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640938DD0;
	Mon, 11 Dec 2023 13:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C30C433CC;
	Mon, 11 Dec 2023 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302756;
	bh=YCjqbVJjc6rVBNyftuGcxhYmndQY55/iXmK/twrIVFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qs6AZikWd5f1Fvxtou/0Dm42zcpzPi22CQ56Z2dbdkoCxhkVhviCUe6VPvCrbagww
	 prqP9RCS6aK3Ggoxla7PLkgwYU01jmdax/nj+BHuC2RySurE8Gr9T8IZXhObz4iYWZ
	 2fQsr35CTD035nbSdzoQ2YKfRGx63l25VeBk8TJV7PRXshD3ezfmiAsPY0a7bvcYwN
	 lT9iV2QqJuRu87FnznUMMmnaoX4beQpzkzUplq1ZOR1cv4BkbGrh+tCR1hwRkJInSL
	 VpLB2mmww0Cp/nEnQwaOxA2gj1begxrQyaHOpJENDXoDBcQV1V0n6zutEh2wBwSxDd
	 dkAsoEoumz+oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/47] ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available
Date: Mon, 11 Dec 2023 08:50:17 -0500
Message-ID: <20231211135147.380223-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 3d1dc8b1030df8ca0fdfd4905c88ee10db943bf8 ]

When the HDMI is not present due to disabled display support
we will use dummy codec and the HDMI routes will refer to non existent
DAPM widgets.

Trim the route list from the HDMI routes to be able to probe the card even
if the HDMI dais are not registered.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20231124124015.15878-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index a06e05154ae1f..70c806cc5b2ee 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -154,6 +154,8 @@ static int skl_hda_fill_card_info(struct snd_soc_acpi_mach_params *mach_params)
 		card->dapm_widgets = skl_hda_widgets;
 		card->num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets);
 		if (!ctx->idisp_codec) {
+			card->dapm_routes = &skl_hda_map[IDISP_ROUTE_COUNT];
+			num_route -= IDISP_ROUTE_COUNT;
 			for (i = 0; i < IDISP_DAI_COUNT; i++) {
 				skl_hda_be_dai_links[i].codecs = &asoc_dummy_dlc;
 				skl_hda_be_dai_links[i].num_codecs = 1;
-- 
2.42.0


