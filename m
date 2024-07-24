Return-Path: <stable+bounces-61256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE893ADE3
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9D4282738
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD614B968;
	Wed, 24 Jul 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUDpyGnh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC64140397;
	Wed, 24 Jul 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809128; cv=none; b=Wwgo4VYlPFTuGW1RAqJQxFOITeYuzoFK2TpayqDaUDPBLFsbhF6hozu7paSqbxlNB0ahXMKCMJt0LmIXTpCUbZsIPXfXFakUHDVenstCxEf6dm/mvbdFss+qW1YJtjX0sw0aLtl98ZU1TA/RyNA927bpc/hXirEMQInohaigPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809128; c=relaxed/simple;
	bh=GVTqlhzIWAsTGoZvbf/CafZ28PBBGs54WSfwVjChil8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOUvVcJH+ykhct4rdv+Pd/5a6j6Kun8DO9z8Kqwf6uyDWl2bhyXMnNLRBWvybrG1wFoDGkAuoNp3PekTn3/dNP6vRGdBIiCqWfYMdRBn0bfELD7iunzBjdrSplJU6fCx0AihAVRk+aeGxYDjLMiBlXrpRCdA3eInDnvKuOCg318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUDpyGnh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721809127; x=1753345127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVTqlhzIWAsTGoZvbf/CafZ28PBBGs54WSfwVjChil8=;
  b=PUDpyGnhcTNy41wqopPUpBkvaQyVpts5OFYR7xtruFUoAo6rybnC1eVT
   VMsgTMxCB6utYs1yE8MIuyF/4zFBzNzqwDF+fdp5bW7wSI/Obr6Hk8xhQ
   u3WpgkUaAxpWvNi+aR3AeKtWeTK4tJ71QGgakizxx8VJK+vy0NYWWVny7
   CmctpsehDJzDZ2rHXk+B55lEGc+f759x0RHQ/tphKGivt1VYa+tZ4a+El
   y+KBKdRL7mxphfyBihGMZ/JjsHgYNl1wBmLlVJf7RQbM29ds2HyKTuqqy
   P1KfT3Mll/bNuhR6WebCTCbWc9Pjl8qR8mQ/a0yPDP3cEd1/Wg0szmlvS
   g==;
X-CSE-ConnectionGUID: KChGDK9FSKiDHqBfv0LSRg==
X-CSE-MsgGUID: ihkE9i0ITGKpEvmukmDJKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19166185"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19166185"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:18:46 -0700
X-CSE-ConnectionGUID: LZjPVV5eR+SXXOwNJ1ABdw==
X-CSE-MsgGUID: uO7LKwuBS5agCfttjtUDFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52221769"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.68])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:18:44 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ASoC: SOF: ipc4-topology: Preserve the DMA Link ID for ChainDMA on unprepare
Date: Wed, 24 Jul 2024 11:19:32 +0300
Message-ID: <20240724081932.24542-3-peter.ujfalusi@linux.intel.com>
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

The DMA Link ID is set to the IPC message's primary during dai_config,
which is only during hw_params.
During xrun handling the hw_params is not called and the DMA Link ID
information will be lost.

All other fields in the message expected to be 0 for re-configuration, only
the DMA Link ID needs to be preserved and the in case of repeated
dai_config, it is correctly updated (masked and then set).

Cc: stable@vger.kernel.org
Fixes: ca5ce0caa67f ("ASoC: SOF: ipc4/intel: Add support for chained DMA")
Link: https://github.com/thesofproject/linux/issues/5116
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 4a4234d5c941..87be7f16e8c2 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1358,7 +1358,13 @@ static void sof_ipc4_unprepare_copier_module(struct snd_sof_widget *swidget)
 		ipc4_copier = dai->private;
 
 		if (pipeline->use_chain_dma) {
-			pipeline->msg.primary = 0;
+			/*
+			 * Preserve the DMA Link ID and clear other bits since
+			 * the DMA Link ID is only configured once during
+			 * dai_config, other fields are expected to be 0 for
+			 * re-configuration
+			 */
+			pipeline->msg.primary &= SOF_IPC4_GLB_CHAIN_DMA_LINK_ID_MASK;
 			pipeline->msg.extension = 0;
 		}
 
-- 
2.45.2


