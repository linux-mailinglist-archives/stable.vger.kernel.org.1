Return-Path: <stable+bounces-58769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B0F92BFA2
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7151C22E3E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9CD19FA66;
	Tue,  9 Jul 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcbvUBqy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3419F49C;
	Tue,  9 Jul 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542026; cv=none; b=nd9MaTZoH/LdBmDg0wllyI5FFWLGOAPusjpyFbO5MaeLdyYnGkvE5lHJkGrwT4Bs+sIbsoCUMVooctHY7iBxitZ24Hkb+a6qaGHPOJ9RpwgqtiUHMewvsQhaurTfKf2upkruG7SHD94gT11taruxvC4xPgoA8AQiBJBufDH5EGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542026; c=relaxed/simple;
	bh=bVKOYWwHqfZzzQaFxXS6lZ1Iq4LgfUqNG5EGfe8+FYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nk4WmjmDfHg56r+LzJ1PZURBkGXIYPF9Kv/pz6Rg0+OHk86EnIP7bRpUlR6Z3PTdBM41vOljdXMAFRsS9+ZDx+GspxuvaG6+Em8mBqH3iiPjWwwKFJU1AORwS5FQx5d1NJqRSwB/yRpKkTH/zdJr7hmjwTuMQs3vPfr/GBlqqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcbvUBqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E8BC3277B;
	Tue,  9 Jul 2024 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542025;
	bh=bVKOYWwHqfZzzQaFxXS6lZ1Iq4LgfUqNG5EGfe8+FYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcbvUBqyiC4VU0ZDNLcUtNttp5u6cOy8FLxn+kcHh3WtxXyFkVVXriaKMmeLNUKXP
	 niE0lAOUzWhF0W7OAhX9Bn1DdLlU40WI3BfkzKHvpP3mjAv+28tmec/35bK08GD4Cw
	 LAnMbE+BFjZ7CUWdF7NGhQZm3O4JQPmSKNLeF0mAvvoLZAA+SeGItbDXIX8bi5ZeIV
	 ONnELK1eq+Hyj/2uJI2b8w54Q3IibfktkHXWcjqHhpy2YoQb8rnBSi8tsbAwhKx6IL
	 h8XSyec7d1Sb9YFiSzGTuUHNLTMNpMENgTgk21pWe/6Li5ZsuEK1x/e9Zg2bWOQPxR
	 xXRU++pTe4K4A==
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
Subject: [PATCH AUTOSEL 6.9 07/40] ASoC: topology: Fix references to freed memory
Date: Tue,  9 Jul 2024 12:18:47 -0400
Message-ID: <20240709162007.30160-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
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
index ba4890991f0d7..7add1dbf1d214 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1060,15 +1060,32 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
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


