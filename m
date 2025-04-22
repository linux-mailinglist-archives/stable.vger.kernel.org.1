Return-Path: <stable+bounces-134905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B6A95B00
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3683B752F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79E1E8346;
	Tue, 22 Apr 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0cGpG5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E61E5B6B;
	Tue, 22 Apr 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288163; cv=none; b=WXXQyHvXm2kXZTpS4AlysxkmoZu/Oh5qjecyjH8uMzVfgUBjnsx7SnSNekFpLQA2b6gCOADkdZYYPQgvyrD4HH4in751wyCs2C/uRSQOq127WQhMRe64XSpYjqsmBW3aTe8bmzoXoPuUxLE5Yx8IYDEImYlHnZ7LvZB5nEtuC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288163; c=relaxed/simple;
	bh=NjNbpF18wPAYd3eJEswSOl8w+6PgqTaTcYBTzvy0/08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdukhPB5R6V0B4nB5goODlIlN7L5MYjkJci2BqgZ8Dm9LmXxM7uEOBS3yN/d9epIdMTzrqipkH++rPc1YDTF6GAukSBYHHZ+rRxRE6N2kIebSDtgpOSnCqiBFIyq4mf/8TAocHHmDhZieHqCMfzKEccpraMY5DEovr2ik4FBxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0cGpG5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2B6C4CEE4;
	Tue, 22 Apr 2025 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288162;
	bh=NjNbpF18wPAYd3eJEswSOl8w+6PgqTaTcYBTzvy0/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0cGpG5pt5czQsrotSYEqBUiq8Z1Ytt4b1AyrqD4F7+mEz1csQmgIQiTUi6CejhZy
	 4/WrPT3rb0+gy1qiwQQS6imAhdv81PdZOLh6RJPVHY2U/wROVrjbTNhtX4w5UvcY4E
	 qlxMYwZylZwXh80VZLEVexWvkajFEfcId9Ho8L2eHY9hFfhRIwAgD0jQLUe587+9IN
	 g2AAenO0LsFVLAiyHIe7T8StZHTy7pYcz9Dl4yO6srn1iBPTDmpvnC+3p8HlpjYqq3
	 KbTH0a1MA7jxCNjDoLOQdNyPv92HezL/qXNP4XoH0Ek9gkGctCAEfRG38LWZxh/7Jw
	 TEE0iJn/jUfzw==
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
Subject: [PATCH AUTOSEL 6.14 07/30] ASoC: fsl_asrc_dma: get codec or cpu dai from backend
Date: Mon, 21 Apr 2025 22:15:27 -0400
Message-Id: <20250422021550.1940809-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
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


