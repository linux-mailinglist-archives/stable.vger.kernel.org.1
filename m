Return-Path: <stable+bounces-143023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CADAB0DFC
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C269A1C258E5
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9B2749D3;
	Fri,  9 May 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqLdIXrW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16627465D;
	Fri,  9 May 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781125; cv=none; b=C5c4cApKUkKeDJNuE0VPJ1vVmikFnbdQONMELdDzjSaKF+2EO4Vd/YX1cXdtoXzKW9a1LRXKY2Mcqd+OHr0vzBXoYwc95DJ6okh83w/3BD6j9maS/B9V/hioqAH71uJZS930a1LRc1Q2juqd9Ec1Asus2m2DHsXsuhhIzAUNlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781125; c=relaxed/simple;
	bh=YlY2TPDrUaMotWO29pbLxuq54Ab8C2uXB8QA+D5yLH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8A3nhT99cGdMSzhFkzHUYk887R2QMyPcvCiJOw0RMKdEkWxf1VMN/qU7QJ0+zDhDCbot4z3U7n4FrJU+MiFk8WFuhzvkuV1ZXtf68VgDyGOcYgwczsuwpfpu/iRCMRvOdow+6r43qEmS+S3qLhk+sk2tYGWmB4bq4AE2qAUirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqLdIXrW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746781124; x=1778317124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YlY2TPDrUaMotWO29pbLxuq54Ab8C2uXB8QA+D5yLH4=;
  b=dqLdIXrW6BuWAMNt/kJ7ZCARt4mg1mJwsjGdM1SV0Rd8dnKAAIXuAEpS
   KAG4bKAl2lZEAqhB3YgBGDHPTYwwIHaZL90Pb0vUzPc7HPRksTJdWfP4J
   9NA7RN5SNc0ahmr23hdo9Qj3kIR2Q+bb8K0J0XS1rAtChk/r2ACc3tQBU
   Ju7aNiTCYjuKLa/R/O9X5dQTHjwGfipV8ByxSNJkLCUaYM7npHwITPDpU
   O00VhvB9UD3/sXs7dQ8brXFxgFBwx31JADtN3tmFaymeIbrVFYkVLgQTA
   2mbJW3vdqpXu17HJfHV4TRzbCxLSwpJeQdyiFzpIjB/8lGxsHgjxbyNAB
   g==;
X-CSE-ConnectionGUID: v5enrre6QhOT/58+HyQOHg==
X-CSE-MsgGUID: MOuW4BudTXmTJCDwj7M1fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58818290"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="58818290"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:58:43 -0700
X-CSE-ConnectionGUID: dIFDx1o2SkOyDcPenI/6pA==
X-CSE-MsgGUID: QpTOAGMTRn63d+IGPpuOeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136514455"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:58:41 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: [PATCH] ASoC: SOF: ipc4-pcm: Delay reporting is only supported for playback direction
Date: Fri,  9 May 2025 11:59:51 +0300
Message-ID: <20250509085951.15696-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware does not provide any information for capture streams via the
shared pipeline registers.

To avoid reporting invalid delay value for capture streams to user space
we need to disable it.

Fixes: af74dbd0dbcf ("ASoC: SOF: ipc4-pcm: allocate time info for pcm delay feature")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 52903503cf3b..8eee3e1aadf9 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -799,7 +799,8 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 
 		spcm->stream[stream].private = stream_priv;
 
-		if (!support_info)
+		/* Delay reporting is only supported on playback */
+		if (!support_info || stream == SNDRV_PCM_STREAM_CAPTURE)
 			continue;
 
 		time_info = kzalloc(sizeof(*time_info), GFP_KERNEL);
-- 
2.49.0


