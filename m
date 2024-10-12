Return-Path: <stable+bounces-83518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1999B36F
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB92283BDF
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA618453E;
	Sat, 12 Oct 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blfphoUl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8C17B51B;
	Sat, 12 Oct 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732389; cv=none; b=A+uIlqezz5y0NVAymx6iEBkFS1Ns7PANDoJX7TRGO8ZEzjnJpGsHWwOLIyzo7savUd+1SdZgBhVEV6bQDGPDt+iz6CjX5+9DVC98ggsvghM9GNIXHPjPPTbJ6H8qDYnzqjKtz2zHFxhk+YJ6Zhz3ZENiWJbsXXer+ppSrG6cQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732389; c=relaxed/simple;
	bh=0auhR6tsRLm+DbOTp+TCsOMxuPCwJ8l84lQU6dR4RCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0T+aKBGr/dgr+9K7kAiytRbnsF0TqW2S9lZoZakZGRQJEMLGVxCPVebP0jgYrcvgeNT8ndls5xwlsrXQ5cDW/La76n7pDPRDq+r9484WOShr17/+RYTvC8Ogbxy3jWScPtsaGzNMJxFZzE0wopmGudEjwXZC1dLxkUOsNVZ1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blfphoUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BE6C4CEC6;
	Sat, 12 Oct 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732389;
	bh=0auhR6tsRLm+DbOTp+TCsOMxuPCwJ8l84lQU6dR4RCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blfphoUlkZ1cHv2bJX8EKaKl9DaCma3bXTUjcHY7qv2k6C4rPMxyGmK5sE+foWXF/
	 tm1A+MpfUvclhj38TDB/jet6AHjI0JEGPQlWBEGQmtSdBiC375nY/tV+0Kq/a1fnDY
	 8DHEPBP2NrzDb/ansGy3LXKbJzQXFUGYKoP7y161T0H3Pg8RPx9YDu/RKgayglLocP
	 PCM6QiB9pGdy0arYWXhSTjoMw6NGQ46Ukr7bziQd2qw0GMJX/1ZQIhKG+6NfLL7gEt
	 8ek+qD6Jz5Inh6IqMd1ixeyrxPeXA67+U7sYWUZW7FN3FUjpLTIcV+1RASWjjLfdo1
	 z6h+Di94E+KZg==
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
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/16] ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit
Date: Sat, 12 Oct 2024 07:26:00 -0400
Message-ID: <20241012112619.1762860-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 72455e33173c1a00c0ce93d2b0198eb45d5f4195 ]

FCONT=1 means On FIFO error, the SAI will continue from the
same word that caused the FIFO error to set after the FIFO
warning flag has been cleared.

Set FCONT bit in control register to avoid the channel swap
issue after SAI xrun.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/1727676508-22830-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 5 ++++-
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d03b0172b8ad2..a1f03c97b7bb8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -613,6 +613,9 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
+	/* Set to avoid channel swap */
+	val_cr4 |= FSL_SAI_CR4_FCONT;
+
 	/* Set to output mode to avoid tri-stated data pins */
 	if (tx)
 		val_cr4 |= FSL_SAI_CR4_CHMOD;
@@ -699,7 +702,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
-			   FSL_SAI_CR4_CHMOD_MASK,
+			   FSL_SAI_CR4_CHMOD_MASK | FSL_SAI_CR4_FCONT_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index dadbd16ee3945..9c4d19fe22c65 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -137,6 +137,7 @@
 
 /* SAI Transmit and Receive Configuration 4 Register */
 
+#define FSL_SAI_CR4_FCONT_MASK	BIT(28)
 #define FSL_SAI_CR4_FCONT	BIT(28)
 #define FSL_SAI_CR4_FCOMB_SHIFT BIT(26)
 #define FSL_SAI_CR4_FCOMB_SOFT  BIT(27)
-- 
2.43.0


