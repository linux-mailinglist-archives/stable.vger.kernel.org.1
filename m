Return-Path: <stable+bounces-67677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E5951F00
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E52428ACBA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF10C1B9B34;
	Wed, 14 Aug 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqZ/GYGK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B581B29CF;
	Wed, 14 Aug 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650434; cv=none; b=Q9+NFyjn07l1VdlkX4QV/tXsEr4lSmx/qBQVMwiV7THHVT7wlKa4nbT25eRVk0B7+xD5jF2ZqnNPojTnIiVwFjRVVZxM6SK9tB3cPb3oLwIXAam/kLhE97AKN0fk8CLO5f/v58Xd5JjgVmiJPpmgHv3oFAjDzYDe7lQ9VHutAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650434; c=relaxed/simple;
	bh=YBxKH7qKeqT6BE8xEXOvCRy7G11oeaHy701sQy415I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lg5bjEUMhzkMuHcHcKBQggzYlQU4YzUibqRwQi0zUEPefvY/RhO9xh8dKHXRboFGDIKS7gRipuPzw5Aeo7bE51FAivpZ581IUtlGar5vty3jRhOY1Kevs/KFai22ikGJeWohJ1RQufoEgE/JZcrw/Vu1GooGVKBBKA+UtJfWnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqZ/GYGK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723650433; x=1755186433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBxKH7qKeqT6BE8xEXOvCRy7G11oeaHy701sQy415I8=;
  b=YqZ/GYGKK+ZHillmnCW+HgA2UdV0q4r27Y0Mdnc4hWKwuCDTpB5Eoavo
   P0q8mmHT+0OgNch4Czn9FX0s5iTmgAb/gKZv+GdxenTL8tD2wXIS04X71
   c0oV06wfgR9wga8oBwCS4667W2u9mDyvF/6hKKgPAimJU/RxozEki9yl0
   gUhchCJF7SEfzUb7HBCoXHd8N07bC6aFj0mMh1oKBCHO+V4FrfLAWi0zv
   Qv1TTME/p8efurglzVePJwgqAP/o8bITAteJSedp/6pPVSdvZWocPaXzN
   Os0MgqptS8aRioL957g3tYYyCXlF6mKcQ0NW00gmPFj8s1+cuVV/eev37
   Q==;
X-CSE-ConnectionGUID: 5UO03ViiQf+b1WGoGlNoNg==
X-CSE-MsgGUID: Eli1KJ+2ThiGYEL70viWiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="47279504"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="47279504"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 08:47:02 -0700
X-CSE-ConnectionGUID: 9COW1dEGQ269B4o2UZj3PA==
X-CSE-MsgGUID: mdjBrcWxRNuTErSIpZ6V+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="58936609"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 08:46:59 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com,
	perex@perex.cz,
	lgirdwood@gmail.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH for stable v2 1/2] ASoC: topology: Clean up route loading
Date: Wed, 14 Aug 2024 17:47:48 +0200
Message-Id: <20240814154749.2723275-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>
References: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7 ]

Instead of using very long macro name, assign it to shorter variable
and use it instead. While doing that, we can reduce multiple if checks
using this define to one.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-5-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ce22613bf9690..52752e0a5dc27 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1021,6 +1021,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
+	const size_t maxlen = SNDRV_CTL_ELEM_ID_NAME_MAXLEN;
 	struct snd_soc_tplg_dapm_graph_elem *elem;
 	struct snd_soc_dapm_route *route;
 	int count, i;
@@ -1044,38 +1045,27 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		tplg->pos += sizeof(struct snd_soc_tplg_dapm_graph_elem);
 
 		/* validate routes */
-		if (strnlen(elem->source, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
-			ret = -EINVAL;
-			break;
-		}
-		if (strnlen(elem->sink, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
-			ret = -EINVAL;
-			break;
-		}
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
+		if ((strnlen(elem->source, maxlen) == maxlen) ||
+		    (strnlen(elem->sink, maxlen) == maxlen) ||
+		    (strnlen(elem->control, maxlen) == maxlen)) {
 			ret = -EINVAL;
 			break;
 		}
 
 		route->source = devm_kmemdup(tplg->dev, elem->source,
-					     min(strlen(elem->source),
-						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					     min(strlen(elem->source), maxlen),
 					     GFP_KERNEL);
 		route->sink = devm_kmemdup(tplg->dev, elem->sink,
-					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					   min(strlen(elem->sink), maxlen),
 					   GFP_KERNEL);
 		if (!route->source || !route->sink) {
 			ret = -ENOMEM;
 			break;
 		}
 
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) != 0) {
+		if (strnlen(elem->control, maxlen) != 0) {
 			route->control = devm_kmemdup(tplg->dev, elem->control,
-						      min(strlen(elem->control),
-							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+						      min(strlen(elem->control), maxlen),
 						      GFP_KERNEL);
 			if (!route->control) {
 				ret = -ENOMEM;
-- 
2.34.1


