Return-Path: <stable+bounces-94946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA479D713E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40827283C51
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34431A0AF0;
	Sun, 24 Nov 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3FNo0Ji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72D1A01BE;
	Sun, 24 Nov 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455344; cv=none; b=TGq0t6bN301kXgRw6vD0r4BkpTdiOea9KMDL3PbjWuwDp+3z3h2du2k7cjS+Mmr0TdBjgg9L9sUAPjhqX9Dhq1VyAliHOptZrtYy+xWHg4lTmzM6hg0blvmrD/23eqVozrw25Yl6vVdV52qsPtZNZsSIGKFPnODuvtQB0HWsraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455344; c=relaxed/simple;
	bh=yU37XBj/kCLIP04PkDC2YFjUJ4qMnTPLcfM7FjmFDZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2LbqSR4tqszCkaXmlAmJNbhp/v7vFn1Fpvpd3DI/CA9Yy7xNcgUbOqhNKfrE3Ndwa3m+VmMYJme6fpkC8/9D6eQEtRTj0MbIdltkZZDd2RKRuxsGh2CFM5TYZpeIWZq+KcV8Wy7q8TcqooViDG3u5x5GrM2M+43jsmwwr4PYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3FNo0Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76146C4CECC;
	Sun, 24 Nov 2024 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455344;
	bh=yU37XBj/kCLIP04PkDC2YFjUJ4qMnTPLcfM7FjmFDZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3FNo0Jivq9lFf+GjRkZ8oCAEto+ZMT5vSpr9Gm3TiZdNGgfNV/cUItm/MRa6fS8s
	 GfqB1Z/Uh1FnAgY7Wzgp4UTu9tad15Wy1ZgsH8MLhFKApsl7iX2iNqkaHGK6IY4Ved
	 JlhN2CluWzBXSySdNBOZzd5ICLfvFl0rmvsh/d0sRZ7w2Udc8WQJeQ0KhIO1xLnsKo
	 Ta0hsvYhRnk/HMcD3exGWXcSw2L+wWAnUVeCOsbRJDpWf/2v43xsJHWHasn44WnRmd
	 zzWutdZH1230qV8T3/iAB4680FpuqPUXDTO1u79JSZYoVS1sxFjb6spEiZ6A+OF5Yd
	 pnoUiv5Td/40A==
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
Subject: [PATCH AUTOSEL 6.12 050/107] ASoC: sdw_utils: Add support for exclusion DAI quirks
Date: Sun, 24 Nov 2024 08:29:10 -0500
Message-ID: <20241124133301.3341829-50-sashal@kernel.org>
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

[ Upstream commit 3d9b44d0972be1298400e449cfbcc436df2e988e ]

The system contains a mechanism for certain DAI links to be included
based on a quirk. Add support for certain DAI links to excluded based on
a quirk, this is useful in situations where the vast majority of SKUs
utilise a feature so it is easier to quirk on those that don't.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241016030344.13535-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc_sdw_utils.h       | 1 +
 sound/soc/sdw_utils/soc_sdw_utils.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index f68c1f193b3b4..dc7541b7b6158 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -59,6 +59,7 @@ struct asoc_sdw_dai_info {
 	int (*rtd_init)(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 	bool rtd_init_done; /* Indicate that the rtd_init callback is done */
 	unsigned long quirk;
+	bool quirk_exclude;
 };
 
 struct asoc_sdw_codec_info {
diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index a6070f822eb9e..863b4d5527cbe 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -1112,7 +1112,8 @@ int asoc_sdw_parse_sdw_endpoints(struct snd_soc_card *card,
 				dai_info = &codec_info->dais[adr_end->num];
 				soc_dai = asoc_sdw_find_dailink(soc_dais, adr_end);
 
-				if (dai_info->quirk && !(dai_info->quirk & ctx->mc_quirk))
+				if (dai_info->quirk &&
+				    !(dai_info->quirk_exclude ^ !!(dai_info->quirk & ctx->mc_quirk)))
 					continue;
 
 				dev_dbg(dev,
-- 
2.43.0


