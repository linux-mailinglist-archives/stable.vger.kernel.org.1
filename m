Return-Path: <stable+bounces-28551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76988599D
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D141F2128F
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2884A3F;
	Thu, 21 Mar 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNwa0aW+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9484A55;
	Thu, 21 Mar 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026496; cv=none; b=TalvkNhGnkkFQSgTeOI22c6TQqmJrDkAaVXinYRz8EuTCs9v+UAO+Fb2eUM21z05Z/yUyVb8KoIbn1xJCyJgiq7AW34mKuRwp5aR0ziyB59wM/h1vggiyxLOxUyor/a4vrfqCG4jRZvt7tmScszdTkSMB4Aw+yKAJiSH6g53B+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026496; c=relaxed/simple;
	bh=XKOy5tx9UPnhGyLYYMhmSJ951yyyOqcpZrfGxLKCFHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKINYxgZfB2MhYfs8K4xT35hoIkE5bSEbBrZop1mXl0/PMUR7bGGkLkaWOdooFYYrf5qpNd0wj86GPAQab/Kz5kb/JPiM6Jltk/CB3Oshw3GxGFTl/daR9ykLzZPqJzuAtKWywzBF22PvC64oSf/kaqFTkd++YU9p2vXwemEC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNwa0aW+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026495; x=1742562495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XKOy5tx9UPnhGyLYYMhmSJ951yyyOqcpZrfGxLKCFHk=;
  b=TNwa0aW+JTDEibd1C1Knl5v4WXdNB4hYRetr9+HmpDm6WZY7G1q9PCoY
   ghK2QG+BmEPlH3aq6PdY5UKjTiBXUCiZqew6pX9U4xTtgNN09KTyEE34W
   4x82AipPjPJcW5GAJplk/feQky/zTFRsiRrUdEtZ4ASrIVVp1Oq6ZOTR0
   ZxbBfWCJp1gkjov66osSyycx/a1dFAX5T8Cm9TF67A9j12uWnQrQMpGdB
   dGrLnPNvxF3AVCNYKN6ehzyCyk9CN8isP/1PZpQFLnUyj+RRbQF7vQ8RA
   fGiNvmmoPK+iubw25Xavk8iMwUx7CObl48/hZHf7RJjsU9cc0+Bao8oNi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127219"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923265"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:12 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 10/17] ASoC: SOF: Remove the get_stream_position callback
Date: Thu, 21 Mar 2024 15:08:07 +0200
Message-ID: <20240321130814.4412-11-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
References: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_stream_position has been replaced by get_dai_frame_counter and all
related code can be dropped form the core.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h      | 10 ----------
 sound/soc/sof/sof-priv.h |  9 ---------
 2 files changed, 19 deletions(-)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index d83cd771015c..3cd748e13460 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -523,16 +523,6 @@ static inline int snd_sof_pcm_platform_ack(struct snd_sof_dev *sdev,
 	return 0;
 }
 
-static inline u64 snd_sof_pcm_get_stream_position(struct snd_sof_dev *sdev,
-						  struct snd_soc_component *component,
-						  struct snd_pcm_substream *substream)
-{
-	if (sof_ops(sdev) && sof_ops(sdev)->get_stream_position)
-		return sof_ops(sdev)->get_stream_position(sdev, component, substream);
-
-	return 0;
-}
-
 static inline u64
 snd_sof_pcm_get_dai_frame_counter(struct snd_sof_dev *sdev,
 				  struct snd_soc_component *component,
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 91043f177dfa..d3c436f82604 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -261,15 +261,6 @@ struct snd_sof_dsp_ops {
 	/* pcm ack */
 	int (*pcm_ack)(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream); /* optional */
 
-	/*
-	 * optional callback to retrieve the link DMA position for the substream
-	 * when the position is not reported in the shared SRAM windows but
-	 * instead from a host-accessible hardware counter.
-	 */
-	u64 (*get_stream_position)(struct snd_sof_dev *sdev,
-				   struct snd_soc_component *component,
-				   struct snd_pcm_substream *substream); /* optional */
-
 	/*
 	 * optional callback to retrieve the number of frames left/arrived from/to
 	 * the DSP on the DAI side (link/codec/DMIC/etc).
-- 
2.44.0


