Return-Path: <stable+bounces-5367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85280CB6D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BBB1C20F1E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604647773;
	Mon, 11 Dec 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho+7+k85"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4B38DD0;
	Mon, 11 Dec 2023 13:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C21C433C7;
	Mon, 11 Dec 2023 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302744;
	bh=B/U5W9npea2EkzEYQL8tfRUKdcmXLdor/S2UDsVoyR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ho+7+k85nLQyj9pznnMr9mQ1U5Ir0QqFxjBXCVLpDZvvp9L0jqr4eB6dopFa7jSYd
	 4QaCTiFl/ZEC5WZ4pf9LIBhMGXlaT//rb0SjyrZ0pJJGCShUfNkSOPqiq5wbGEET9K
	 xWQf9wN3w0l7h6XME5L96Lt53V452Wyg5i4BPqWD0yZaMDHbZ43dBEdYROvC6fMYk9
	 gsR5sCFzZM5jycl9QNTUgPyVC7kDhaAehVZCY1F5P26an9dIw1BLBeTiGGk5v1TDCt
	 pGeFLaLSFdF86T6tV1/H8tFAvQ+SJ9KSyimj9OcNp7XcmL6zveaFj8bB7wDRIaLMt5
	 9saGaJckwGDow==
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
Subject: [PATCH AUTOSEL 6.6 12/47] ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case
Date: Mon, 11 Dec 2023 08:50:13 -0500
Message-ID: <20231211135147.380223-12-sashal@kernel.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit c33fd110424dfcb544cf55a1b312f43fe1918235 ]

The bit 10 in TX_DPTH_CTRL register controls the TX clock rate.
If this bit is set, TX datapath clock should be = 2* TX bit rate.
If this bit is not set, TX datapath clock should be 10* TX bit rate.

As the spdif only case, we always use 2 * TX bit clock, so
this bit need to be set.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1700617373-6472-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index fa0a15263c66d..77f8e2394bf93 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -414,6 +414,16 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream *substream,
 
 	switch (xcvr->mode) {
 	case FSL_XCVR_MODE_SPDIF:
+		if (xcvr->soc_data->spdif_only && tx) {
+			ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_TX_DPTH_CTRL_SET,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM);
+			if (ret < 0) {
+				dev_err(dai->dev, "Failed to set bypass fem: %d\n", ret);
+				return ret;
+			}
+		}
+		fallthrough;
 	case FSL_XCVR_MODE_ARC:
 		if (tx) {
 			ret = fsl_xcvr_en_aud_pll(xcvr, fout);
-- 
2.42.0


