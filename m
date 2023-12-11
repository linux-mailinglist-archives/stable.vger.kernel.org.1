Return-Path: <stable+bounces-5413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993F80CBE4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440CD281FF9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FDA47A5B;
	Mon, 11 Dec 2023 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZL4nbKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D147A4D;
	Mon, 11 Dec 2023 13:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E087AC433CB;
	Mon, 11 Dec 2023 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302931;
	bh=uDlu4Y967RJ4SxiO9YzlT7AG+ZRio0a6mNsr/SQmFbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZL4nbKUVzWns2EId+asMBx/XS+gzzr+KhBunQNhTHc4/c8R2eeoMrAFUgVfBK5EW
	 Q5t0uAoAVykJtlwB85OZYnzrp4542yzpCOkLsZmOEAcnlAxgoQnUxU9z0r9Ic1c4Ht
	 FsVrGRaHcl9pcUC1uYPuA2ZpbpQ570EdBgSQixgBbEs8rbEMHqoKKrAyWBtQznYcJ5
	 XgII0ZHT3i2nAkP3ZPGJaQoqz8RdwulgtqICfrFCcq3hvslYFZGIFvmGL/Hx2XEr5m
	 nPTK0mMPvWAGdYWp49RHLAan2+4tDyj/gwaZJTi6jRYGHCiJiupBZ87OsXfnEe6BHJ
	 SlmN0Za17OY/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	trevor.wu@mediatek.com,
	tinghan.shen@mediatek.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/29] ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
Date: Mon, 11 Dec 2023 08:53:55 -0500
Message-ID: <20231211135457.381397-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 505c83212da5bfca95109421b8f5d9f8c6cdfef2 ]

Add the machine compatible and topology filename for the Google Steelix
MT8186 Chromebook to load the correct SOF topology file.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231123084454.20471-1-angelogioacchino.delregno@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 181189e00e020..76ce90e1f1030 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -596,6 +596,9 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 
 static struct snd_sof_of_mach sof_mt8186_machs[] = {
 	{
+		.compatible = "google,steelix",
+		.sof_tplg_filename = "sof-mt8186-google-steelix.tplg"
+	}, {
 		.compatible = "mediatek,mt8186",
 		.sof_tplg_filename = "sof-mt8186.tplg",
 	},
-- 
2.42.0


