Return-Path: <stable+bounces-183025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A5BB2C40
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A4A19C3E0C
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC62D372A;
	Thu,  2 Oct 2025 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eizvvnou"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C427281D;
	Thu,  2 Oct 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392292; cv=none; b=Bcnu3YRUudryv9C053uL2RajkkWUL0eLa5dEz63vJKD/6wSHKkX7XRVUDp33Tt+wSgCDF6NSvlmNFyRHp3ScGdkNG4ALiM0DiKKXM66OJ7Dro/iJbLqNHNoUTCwoX5JyHqxGWdJYbMdRl4/d+h9jsIrRvXJbjyFTxWAIM+IITK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392292; c=relaxed/simple;
	bh=39p45JoURPnhoAsqBP1T+AlYkFo9mUfk0mGNT2KFQ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luNiJvBie6PGUj3Yv8hmaNkJAwAja1Vxk8Eb86C8Nxht08LdjN0YmRzyAB39ExOKE7qdyWbNJkb/Yc699i30w22PIWKQJ/ze6sGGsyNk/mwUTTflcXVyY0eVlK26nUUZQ2T8qK57EWiscwhSnVkAUAFOm12kWPgHN44bupzhMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eizvvnou; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759392291; x=1790928291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=39p45JoURPnhoAsqBP1T+AlYkFo9mUfk0mGNT2KFQ+U=;
  b=eizvvnouyUWYZtR+TnjolkAYIDd6en23ANtCjcqYnC4mkxJOXR30lR2r
   K9LZXR/AFGJzNbhAHfMwXO81fG388Fx7z0GlYp+LLz8FVI8rKtqvlE4J2
   AAh9DGxo+TOpNQYBZHTvkrppX4iRb5Pp5hk+bIlDQee/d6k+4aCXAdu8Z
   bqdvM/Bsi+s4TDsgRAenSMEzw6xa6CcoO9HkHPmM5P6vewP+F7JSSnppg
   ByCIrXCdugfaM+OYuNAcw7fm7WqhEzIRcHdmVSQHZ8tNEU338uN2zDnve
   hXeZSuj9WyFNw750BXVsFt/1guzLhaiv0jpr4EmjjYNGvVmtN0niiHjDV
   g==;
X-CSE-ConnectionGUID: T4ZEN7pqTvCsER1+IcDwGg==
X-CSE-MsgGUID: lIJewkzDQeOAGp+9WTwBcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65525007"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="65525007"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:51 -0700
X-CSE-ConnectionGUID: gCKltIJRT9ecHrSxYIV0mg==
X-CSE-MsgGUID: beEKnG8TTW+fKfb9yIBZ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178268539"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:48 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ASoC: SOF: ipc4-topology: Account for different ChainDMA host buffer size
Date: Thu,  2 Oct 2025 11:05:37 +0300
Message-ID: <20251002080538.4418-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
References: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ChainDMA the firmware allocates 5ms host buffer instead of the standard
4ms which should be taken into account when setting the constraint on the
buffer size.

Cc: stable@vger.kernel.org
Fixes: 72af064faead ("ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 9 +++++++--
 sound/soc/sof/ipc4-topology.h | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index b6a732d0adb4..60cd7955e24f 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -666,8 +666,13 @@ static int sof_ipc4_widget_setup_pcm(struct snd_sof_widget *swidget)
 				      swidget->tuples,
 				      swidget->num_tuples, sizeof(u32), 1);
 		/* Set default DMA buffer size if it is not specified in topology */
-		if (!sps->dsp_max_burst_size_in_ms)
-			sps->dsp_max_burst_size_in_ms = SOF_IPC4_MIN_DMA_BUFFER_SIZE;
+		if (!sps->dsp_max_burst_size_in_ms) {
+			struct snd_sof_widget *pipe_widget = swidget->spipe->pipe_widget;
+			struct sof_ipc4_pipeline *pipeline = pipe_widget->private;
+
+			sps->dsp_max_burst_size_in_ms = pipeline->use_chain_dma ?
+				SOF_IPC4_CHAIN_DMA_BUFFER_SIZE : SOF_IPC4_MIN_DMA_BUFFER_SIZE;
+		}
 	} else {
 		/* Capture data is copied from DSP to host in 1ms bursts */
 		spcm->stream[dir].dsp_max_burst_size_in_ms = 1;
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index d6894fdd7e1d..fc3b6411b9b2 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -73,6 +73,9 @@
 /* FW requires minimum 4ms DMA buffer size */
 #define SOF_IPC4_MIN_DMA_BUFFER_SIZE	4
 
+/* ChainDMA in fw uses 5ms DMA buffer */
+#define SOF_IPC4_CHAIN_DMA_BUFFER_SIZE	5
+
 /*
  * The base of multi-gateways. Multi-gateways addressing starts from
  * ALH_MULTI_GTW_BASE and there are ALH_MULTI_GTW_COUNT multi-sources
-- 
2.51.0


