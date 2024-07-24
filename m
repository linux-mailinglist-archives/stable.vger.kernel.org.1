Return-Path: <stable+bounces-61255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1793ADE2
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 10:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA11F2285B
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8A14B08C;
	Wed, 24 Jul 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJcppO5k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1773140397;
	Wed, 24 Jul 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809125; cv=none; b=NG8mIGL4hAfwCErIG1BZia/qnhFUrfHcj3n9p6yMVEI8ILvkdB7DuqSWwrgn7PSIdPJTCnOyz+hE/ZminjS7hNaHUFJpCJbP2hm1qb23B0rEN77cEce7b2Q19c9oRYVfQhxZ3IQmH+JJZguwcBRnoGGkZy0YBdb30VNV3w7Bs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809125; c=relaxed/simple;
	bh=txGLNyTK4nbYXVaco3tmk9aPEaF4Eu7gOzpBGr6f6Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv0XI6tyGe0RhpC2Qbohll7/A4w8WwJ9wzgo/Y+ZCAPQezFDgCut9h7SbRotROVi/3t6vatxo37I6QAnWs1+mWwb1nvkpSvOrlTUdEQF5WEGJt0zwou19wriF6NSEUNOC9DzkizFKKp3hIVB/zgPZE3Yy/Wfhn+9YbXxMcpmLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJcppO5k; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721809124; x=1753345124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txGLNyTK4nbYXVaco3tmk9aPEaF4Eu7gOzpBGr6f6Fs=;
  b=CJcppO5k1A3uYskBb82pnpXc28/nZETGC62He3SGiWFiBNk7PkKD8l23
   TwsP/UuPY+G+HuLOzAlbyPSwA7KQkRjBbzIH7Q+ea+ZoW9TNksv55Eac+
   HK8lyouR2UfmIi3uhJjmAec4k5UT0s6DJXuySj0typlUGjPwm/kK8Ssos
   xL1mBEpetCHk1wGLdmA3WUndIco8K9oDobFrcHBnXR5oa84zVrgKg4KEu
   LaYJcI/eN8H0YxTc7T4eIeAdZQXuG6y3TEPHI6XzMuvrzuCs//c3P+9mo
   n1j/VhHra7SNsQI6LLR+WuKH48cvf0wwzplL7ZD0Drlu3mRfCJeYQ/Hcw
   A==;
X-CSE-ConnectionGUID: hHc7RS6WSUSM41GY2m3reA==
X-CSE-MsgGUID: 3cFHbP18TY+LA7KGEcv/4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19166179"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19166179"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:18:43 -0700
X-CSE-ConnectionGUID: n4J4W15KR7yKnLMNLtWRfw==
X-CSE-MsgGUID: 1A54XBQPR66ezyMNjawKug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52221763"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.68])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:18:41 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: SOF: ipc4-topology: Only handle dai_config with HW_PARAMS for ChainDMA
Date: Wed, 24 Jul 2024 11:19:31 +0300
Message-ID: <20240724081932.24542-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724081932.24542-1-peter.ujfalusi@linux.intel.com>
References: <20240724081932.24542-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA Link ID is only valid in snd_sof_dai_config_data when the
dai_config is called with HW_PARAMS.

The commit that this patch fixes is actually moved a code section without
changing it, the same bug exists in the original code, needing different
patch to kernel prior to 6.9 kernels.

Cc: stable@vger.kernel.org
Fixes: 3858464de57b ("ASoC: SOF: ipc4-topology: change chain_dma handling in dai_config")
Link: https://github.com/thesofproject/linux/issues/5116
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 90f6856ee80c..4a4234d5c941 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -3095,8 +3095,14 @@ static int sof_ipc4_dai_config(struct snd_sof_dev *sdev, struct snd_sof_widget *
 		return 0;
 
 	if (pipeline->use_chain_dma) {
-		pipeline->msg.primary &= ~SOF_IPC4_GLB_CHAIN_DMA_LINK_ID_MASK;
-		pipeline->msg.primary |= SOF_IPC4_GLB_CHAIN_DMA_LINK_ID(data->dai_data);
+		/*
+		 * Only configure the DMA Link ID for ChainDMA when this op is
+		 * invoked with SOF_DAI_CONFIG_FLAGS_HW_PARAMS
+		 */
+		if (flags & SOF_DAI_CONFIG_FLAGS_HW_PARAMS) {
+			pipeline->msg.primary &= ~SOF_IPC4_GLB_CHAIN_DMA_LINK_ID_MASK;
+			pipeline->msg.primary |= SOF_IPC4_GLB_CHAIN_DMA_LINK_ID(data->dai_data);
+		}
 		return 0;
 	}
 
-- 
2.45.2


