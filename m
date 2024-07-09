Return-Path: <stable+bounces-58838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC592C098
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980BE1F21659
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B811D47D7;
	Tue,  9 Jul 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdTjoP3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF61D47CE;
	Tue,  9 Jul 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542248; cv=none; b=leOtM+U/nNpbK0ZkHWAbbF9DmQp8m0XM/19TT9gEW3DKl/sCeuC5LEMHT1Tkp+DmQNe3hXkEkiaTOdFYvEm0sekpcrkeC/T4LGoeqhhehU8zNQJvUke26YxARY1oq1fDAu/BJlRusJhGjiIuzSND/3cSR3u7ZwEpOmScNT0nv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542248; c=relaxed/simple;
	bh=jaPpI5Eqcuz056iC/8jfQHa6ir1jCT7clsEmTe7NEos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZGkJeVbtBW3eGDaVanHkoFbccqbVtecwi8pzSCZ6ywD3wG35QdjFeP3yyLnTUVHDIv0wI4aJENy/dNYM9M8yhmGgq4epwzvA447AKZeurXWdaRgvk0xtWKm120BtbB3P/Y8qhw/BHg0MBp7Jr5HwF131rY9NpCwFsYj2sLPrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdTjoP3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C4BC3277B;
	Tue,  9 Jul 2024 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542248;
	bh=jaPpI5Eqcuz056iC/8jfQHa6ir1jCT7clsEmTe7NEos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdTjoP3wAVXH67zWu9dmcRP9gNNYhGA7eGpliE9IJmrCk179TqPyXrz84UfergoLx
	 RKrh5qrN+eNmVAl0H01O6Sx75eyWOB+TQxEoCG+YwNl1yLFhqXQKP117BLMRDn11db
	 Ep1pgsSonIWxFTFXXDYIyJabVhOiUK/VMWspZmOM56/bJYYZHaAFX5s0yh80J9Jc3W
	 j9GJXLEDRzTc7SioFHf8pVbK9vkl+CuJLc8uSD/dx/h7TUbeP0s95MRZ7FQ33g+pc1
	 JX2jc0x05CyA+x/YyYFYjCa8SguAhP1RHoCFE/OQQh/9c6fsrlIzqSUBfa5uwqtybD
	 HvTmzGDzra8sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Jason Montleon <jmontleo@redhat.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/27] ASoC: topology: Fix references to freed memory
Date: Tue,  9 Jul 2024 12:23:17 -0400
Message-ID: <20240709162401.31946-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1 ]

Most users after parsing a topology file, release memory used by it, so
having pointer references directly into topology file contents is wrong.
Use devm_kmemdup(), to allocate memory as needed.

Reported-by: Jason Montleon <jmontleo@redhat.com>
Link: https://github.com/thesofproject/avs-topology-xml/issues/22#issuecomment-2127892605
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d68c48555a7e3..b07083bae65ed 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1101,15 +1101,32 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		route->source = elem->source;
-		route->sink = elem->sink;
+		route->source = devm_kmemdup(tplg->dev, elem->source,
+					     min(strlen(elem->source),
+						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					     GFP_KERNEL);
+		route->sink = devm_kmemdup(tplg->dev, elem->sink,
+					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					   GFP_KERNEL);
+		if (!route->source || !route->sink) {
+			ret = -ENOMEM;
+			break;
+		}
 
 		/* set to NULL atm for tplg users */
 		route->connected = NULL;
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0)
+		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0) {
 			route->control = NULL;
-		else
-			route->control = elem->control;
+		} else {
+			route->control = devm_kmemdup(tplg->dev, elem->control,
+						      min(strlen(elem->control),
+							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+						      GFP_KERNEL);
+			if (!route->control) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
 
 		/* add route dobj to dobj_list */
 		route->dobj.type = SND_SOC_DOBJ_GRAPH;
-- 
2.43.0


