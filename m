Return-Path: <stable+bounces-118675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F358FA40BF2
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 23:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5260171C6B
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 22:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB22040AB;
	Sat, 22 Feb 2025 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9JVxDwe"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693918EB0
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265107; cv=none; b=CcIZHgohdYpBomBJ8D73/+5mALriNWb45UrSqxOu+Wld6GLEIxy0cL63oZovOVTiwyHnStO/CeDVGTEHoIf7WFp9/pnjyFtgPXXue8gR2cedE98o1wVdAmJSDiCJBleJ29mVetcurfSiqthEwngieS4wTZRlMi8FmJ9aimLs7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265107; c=relaxed/simple;
	bh=8xX8lbiW+5RQ+wFxa3JghYTzhMpaR5RIrDRPY8soEFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJgsN6WI/apJuw/8yzB1xygf5QsmOtAOqsQJONYkOyvJkDARWHbEFhT09aBTlAbtnzRKfsEQ3zctsDs67W8VjTHTym+bp28yOQP9QrfoZR3B6K5POSYNsdELn/1XlbaQLEHXixLHPE/RApMMAnhCrrhuZAftKLCmpIcaM/WAMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9JVxDwe; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740265089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ZqF8FngRBwwLVOgM6/1uD7/Y5CAfT801f3ud25fkUA=;
	b=l9JVxDweckFogGJH5q4Ka1r3ELgk/y203WVyzs94rM2BPk0/2cTPLi6lbUkK4KTuJnFdPv
	7R2gTe6WyOAbaLq/QTaRZiTg+V5tpDuu5GPm1H6PD3+ebFO/SHEdCPcmJhDrrsIhbKQeWy
	I6+ex6pNIvN7YgCqMhwnrVITcTQo/io=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sheetal <sheetal@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ritu Chaudhary <rituc@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra: Fix ADX S24_LE audio format
Date: Sat, 22 Feb 2025 23:56:59 +0100
Message-ID: <20250222225700.539673-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
added support for the S24_LE audio format, but duplicated S16_LE in
OUT_DAI() for ADX instead.

Fix this by adding support for the S24_LE audio format.

Compile-tested only.

Cc: stable@vger.kernel.org
Fixes: 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/tegra/tegra210_adx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_adx.c b/sound/soc/tegra/tegra210_adx.c
index 3e6e8f51f380..0aa93b948378 100644
--- a/sound/soc/tegra/tegra210_adx.c
+++ b/sound/soc/tegra/tegra210_adx.c
@@ -264,7 +264,7 @@ static const struct snd_soc_dai_ops tegra210_adx_out_dai_ops = {
 			.rates = SNDRV_PCM_RATE_8000_192000,	\
 			.formats = SNDRV_PCM_FMTBIT_S8 |	\
 				   SNDRV_PCM_FMTBIT_S16_LE |	\
-				   SNDRV_PCM_FMTBIT_S16_LE |	\
+				   SNDRV_PCM_FMTBIT_S24_LE |	\
 				   SNDRV_PCM_FMTBIT_S32_LE,	\
 		},						\
 		.capture = {					\
@@ -274,7 +274,7 @@ static const struct snd_soc_dai_ops tegra210_adx_out_dai_ops = {
 			.rates = SNDRV_PCM_RATE_8000_192000,	\
 			.formats = SNDRV_PCM_FMTBIT_S8 |	\
 				   SNDRV_PCM_FMTBIT_S16_LE |	\
-				   SNDRV_PCM_FMTBIT_S16_LE |	\
+				   SNDRV_PCM_FMTBIT_S24_LE |	\
 				   SNDRV_PCM_FMTBIT_S32_LE,	\
 		},						\
 		.ops = &tegra210_adx_out_dai_ops,		\
-- 
2.48.1


