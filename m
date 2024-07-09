Return-Path: <stable+bounces-58807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2D92C034
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB8C1C23CC4
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714731BD03D;
	Tue,  9 Jul 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWCBxWit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB11BC093;
	Tue,  9 Jul 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542157; cv=none; b=fWbflQNEgeMBJKZLhp6sNilCc5ilQpJPIyLlRFX8s+aoGHPAuT/urd1inLM8I7QFQHZ+6WMUK1cXjxtKhDOR54b9tAbKrJkIaXlnerj+bllg2fk2YTYG+SlNTbaPW0j/O10sfrehAqDxky3ZtEjTB6vWoZ/K2PAgvX2rh6XhA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542157; c=relaxed/simple;
	bh=YeQU2BN8jliffaVTq/FnFtO+gHIOy2jO4x4ikDa3SII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHdngGrQE3a6OsJusgS2BpvfZruPGDbhkH3B5AENANvaUZaZg8lVUWTZQnVgGnsC5qQb/bopBQEKWRbslhFyv+re4XFSbIRXxNBEgGH9BkSukLqHOwH+9QAz32YmBx/cwJF6gO59/O7WKWJtOI5vF1AM2S8PI+kIjEdccYlfVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWCBxWit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53164C4AF07;
	Tue,  9 Jul 2024 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542157;
	bh=YeQU2BN8jliffaVTq/FnFtO+gHIOy2jO4x4ikDa3SII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWCBxWitlCnvwDtHXAT5Jnagtk31uwogaCWpbCZifl4uRg+VqZAJKa6tFJTv3PMUA
	 0brhIK2tLvr/ThhI8uR9Ns8sh7vTi7FkrHzSg7Uv2QPlmw1+YGFS9y89V+lYiuL+Ag
	 53fs5dJujXcY35qXRkG/EIxv6V5IphOH5lVhuEsQKE1DP/VedYwesaCc6aVU3uVFt6
	 bZV+5aspJv+MoyjAvCB5u6gvJ2CSUVdf2huqtHb6yja9pEenNm/VBtZYxNA4G0Hibl
	 nYS9whkR/YQhCZdgBkPyC8SHd6h1CdeV+r4yLIk6U6jFk9YLZN+KKBS66IPeb1joCW
	 Bg/DTb7CsMM9A==
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
Subject: [PATCH AUTOSEL 6.6 05/33] ASoC: topology: Fix references to freed memory
Date: Tue,  9 Jul 2024 12:21:31 -0400
Message-ID: <20240709162224.31148-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index 2362c282ec8b3..c63545b27d450 100644
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


