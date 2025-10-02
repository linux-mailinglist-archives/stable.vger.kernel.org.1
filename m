Return-Path: <stable+bounces-183061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01826BB41B3
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A29D74E2C37
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8730311954;
	Thu,  2 Oct 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLdB7Dwh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9943310655;
	Thu,  2 Oct 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413426; cv=none; b=PQm4ESejXCN0dEFOF19QlFO81VxFUrjayLh2GA0qbOJVUMVOrPqKJ5hXpAp9DmShiKvoHu9Zmgt21/nb6I6pvxd/WSiytnQqRqdtnh4Fmnn+7AZsUCNpU+Fx6ci55TWjj817m+mx2OJiCiD//yCcsv/N6xZdIMWep2aUUo0DJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413426; c=relaxed/simple;
	bh=i30smwRwajTkDI8STXOv3yAHySO/FGPC+2nsfXuSI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCQrFXWDjmOHfqKbfftXVsNl0ljzltmN31u+4gfTQoUTyD/oeb2Y5fTr5xx7npTX9wF7TzezWDArJq979pMaSNMvHUbwAYyADEo2xqGLbat4c8POnHzvPHHE+Nv9/76EsyDQs4PeGw419W8Vq3stqp/dawUqN+KKKFCT/A0lR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLdB7Dwh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759413425; x=1790949425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i30smwRwajTkDI8STXOv3yAHySO/FGPC+2nsfXuSI64=;
  b=BLdB7Dwh+Qxsw6zsfdWoY8402UCbOnrLpRDzFljJR+kvlLnLpP9LCSv7
   ntsiwS4GdfqpaQPUdpvWiXCPydfIeaQPk+lPiqz6oXucpIejZ6T6HNJkg
   PXgD7f5BuI3hYy17uPIf4T298jaN6oo0+SEcvPPs+2KthuAhFBcXUX4ZB
   T/UZs+EuhNyNCfvEBkeV2quDzgvXlIpPFloa88MYsgpYLvzM9yDqJ/OkA
   LzIQFh8IDRTZbqDR3Hua6KaIXhl7zeP+0gZ4mlpN+UrMMY6aOeJSYgppn
   gDytvE6jnE9g82ticbnb2ZgkozNIaZUubt29FzBspJUqwIlQV7BqZmKix
   g==;
X-CSE-ConnectionGUID: SnNS2d0QSuaNPDZV6ufasg==
X-CSE-MsgGUID: PVgvOYHPRgmgX5ukSO8vcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49251142"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="49251142"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:57:04 -0700
X-CSE-ConnectionGUID: uv8Dv3NbQuOErYMytx/7cw==
X-CSE-MsgGUID: 6Jiv4GtGSr2ZLDhA/ojFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179460664"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:57:02 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] ASoC: SOF: ipc4-topology: Account for different ChainDMA host buffer size
Date: Thu,  2 Oct 2025 16:57:51 +0300
Message-ID: <20251002135752.2430-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
References: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
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

Fixes: 842bb8b62cc6 ("ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs")
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


