Return-Path: <stable+bounces-120957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4838A5091A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF1C3A6745
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC8252918;
	Wed,  5 Mar 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kYZNRZoo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3992512C0;
	Wed,  5 Mar 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198466; cv=none; b=oU3I6szzk4QORpFsS1NLkd5tUrf7lvPu4ppyDZu/8aEYP+bhCP7xN3rzJ7sixp0vyktvLqAjhcC/ziGAj0s4WnOsL4VS4o4R3bFxG6GYWy/Mj5KDL5CPKO0DM2mHL1dsDgw/oGXWPNeyRQ8hyWA3ng3Pj6fTvw3WjmGgCn3cmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198466; c=relaxed/simple;
	bh=fZhK3/HrODARSvYFJn34OUmvCqosoTVbu5f/Ea2j+9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCq4HxaZ7WmYreNwRJKrTKpSrujl3wPvocZetP+LHA9fv9n3yuxrf38GrwdxCvEZ7a5Lo7tU726lhofh8FYdt99O4NTgLSicU0pJOYZvA9VBOJCgaexJoHJVRI6GhvFvBlZa4Kc/7leLbUYQx7BajfTiM3w3M+6umVTPLL6zRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kYZNRZoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BEBC4CED1;
	Wed,  5 Mar 2025 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198466;
	bh=fZhK3/HrODARSvYFJn34OUmvCqosoTVbu5f/Ea2j+9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYZNRZoovyCj3o5YXyzwijvOIB4j0Vm6P9MUie05ER+Z1aZDQiy0uOIws4+hsLUf3
	 s+/WlrTHz+Ws1HaKtTVxQdSP1JLvRwJeyvT0HO0kMGEhYVHCstnpwde3vRUuyiJoOj
	 2LcaH900oSkPlOAbzBzZH2ITdu0TS53f/dx0l6Lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chancel Liu <chancel.liu@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 038/157] ASoC: fsl: Rename stream name of SAI DAI driver
Date: Wed,  5 Mar 2025 18:47:54 +0100
Message-ID: <20250305174506.828620399@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chancel Liu <chancel.liu@nxp.com>

[ Upstream commit 0da83ab025bc45e9742e87c2cce19bff423377c8 ]

If stream names of DAI driver are duplicated there'll be warnings when
machine driver tries to add widgets on a route:

[    8.831335] fsl-asoc-card sound-wm8960: ASoC: sink widget CPU-Playback overwritten
[    8.839917] fsl-asoc-card sound-wm8960: ASoC: source widget CPU-Capture overwritten

Use different stream names to avoid such warnings.
DAI names in AUDMIX are also updated accordingly.

Fixes: 15c958390460 ("ASoC: fsl_sai: Add separate DAI for transmitter and receiver")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://patch.msgid.link/20250217010437.258621-1-chancel.liu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c    | 6 +++---
 sound/soc/fsl/imx-audmix.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 634168d2bb6e5..c5efbceb06d1f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -994,10 +994,10 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-tx",
 		.playback = {
-			.stream_name = "CPU-Playback",
+			.stream_name = "SAI-Playback",
 			.channels_min = 1,
 			.channels_max = 32,
-				.rate_min = 8000,
+			.rate_min = 8000,
 			.rate_max = 2822400,
 			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = FSL_SAI_FORMATS,
@@ -1007,7 +1007,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-rx",
 		.capture = {
-			.stream_name = "CPU-Capture",
+			.stream_name = "SAI-Capture",
 			.channels_min = 1,
 			.channels_max = 32,
 			.rate_min = 8000,
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 50ecc5f51100e..dac5d4ddacd6e 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -119,8 +119,8 @@ static const struct snd_soc_ops imx_audmix_be_ops = {
 static const char *name[][3] = {
 	{"HiFi-AUDMIX-FE-0", "HiFi-AUDMIX-FE-1", "HiFi-AUDMIX-FE-2"},
 	{"sai-tx", "sai-tx", "sai-rx"},
-	{"AUDMIX-Playback-0", "AUDMIX-Playback-1", "CPU-Capture"},
-	{"CPU-Playback", "CPU-Playback", "AUDMIX-Capture-0"},
+	{"AUDMIX-Playback-0", "AUDMIX-Playback-1", "SAI-Capture"},
+	{"SAI-Playback", "SAI-Playback", "AUDMIX-Capture-0"},
 };
 
 static int imx_audmix_probe(struct platform_device *pdev)
-- 
2.39.5




