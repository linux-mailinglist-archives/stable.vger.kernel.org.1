Return-Path: <stable+bounces-134935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFEA95B62
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F278916D68D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2225B675;
	Tue, 22 Apr 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myhualnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682825B66C;
	Tue, 22 Apr 2025 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288236; cv=none; b=ONCtU7Yg/9Nvim+83Hx0ZLHVHVEa00cMooEAGu/KdczUeY6XcVUsG/8FNG2GXdVxP5A0HJL2ZNb0QS0Lu6L2PLqauwULrY7qY+s6wZkTnI7lDduh/iOUvZumSBASdHem2kMEHEl2lwoCt2A4N3pWCO/cXgMKRgeGHWXAsu4aIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288236; c=relaxed/simple;
	bh=NjNbpF18wPAYd3eJEswSOl8w+6PgqTaTcYBTzvy0/08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjUmzlTLe5EzDRj0gnWjxvGJkq5EsWbwWffMGhLGQB6On/Rwwd/BhynsNEqcKVfiwJrz0vJzDj1YMPxaipowHqvlRTbmCNg9L4HzzSKIAEu8lSd2JBj84MHRK0xITGP+NV78q8j8OfKtWvZsBm9uG1Q+xXxjd025RVSLeettxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myhualnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD6C4CEEE;
	Tue, 22 Apr 2025 02:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288235;
	bh=NjNbpF18wPAYd3eJEswSOl8w+6PgqTaTcYBTzvy0/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myhualnbDMfLHwDB1hoHPqRPJtTa+7waxg6JDU0hWW00KQSUwZfmyrBlsMpI5BtAh
	 WX6TDBujrsi1h9CJNtD6MbWWWQ2nMmLq1zI7NcRGB88q2kA6MArJ8pOGoPexJqqrm5
	 9RdACuCLAVsCCOjSEOUGZG9VoHa6xcXVqW7HMrW8IOEricD88vuJ+ulY1v1DfSN/W+
	 g3uZvqnUUdQ+sj3NqQjLte5IEd7oDP2bcYFb8MO7Z2pftvDI1ouxXmskzHeAD7927W
	 N/JUdIvT0qkxUI326jEqMd1F3dfj64NhU3k8Y8BXGE3wbb3bYXDdGrwCkPaspuW56A
	 U9cV79TOeBTQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.12 07/23] ASoC: fsl_asrc_dma: get codec or cpu dai from backend
Date: Mon, 21 Apr 2025 22:16:47 -0400
Message-Id: <20250422021703.1941244-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit ef5c23ae9ab380fa756f257411024a9b4518d1b9 ]

With audio graph card, original cpu dai is changed to codec device in
backend, so if cpu dai is dummy device in backend, get the codec dai
device, which is the real hardware device connected.

The specific case is ASRC->SAI->AMIX->CODEC.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20250319033504.2898605-1-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_asrc_dma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index f501f47242fb0..1bba48318e2dd 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -156,11 +156,24 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	for_each_dpcm_be(rtd, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *substream_be;
-		struct snd_soc_dai *dai = snd_soc_rtd_to_cpu(be, 0);
+		struct snd_soc_dai *dai_cpu = snd_soc_rtd_to_cpu(be, 0);
+		struct snd_soc_dai *dai_codec = snd_soc_rtd_to_codec(be, 0);
+		struct snd_soc_dai *dai;
 
 		if (dpcm->fe != rtd)
 			continue;
 
+		/*
+		 * With audio graph card, original cpu dai is changed to codec
+		 * device in backend, so if cpu dai is dummy device in backend,
+		 * get the codec dai device, which is the real hardware device
+		 * connected.
+		 */
+		if (!snd_soc_dai_is_dummy(dai_cpu))
+			dai = dai_cpu;
+		else
+			dai = dai_codec;
+
 		substream_be = snd_soc_dpcm_get_substream(be, stream);
 		dma_params_be = snd_soc_dai_get_dma_data(dai, substream_be);
 		dev_be = dai->dev;
-- 
2.39.5


