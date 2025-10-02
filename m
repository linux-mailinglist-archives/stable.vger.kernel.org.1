Return-Path: <stable+bounces-183042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34266BB3F05
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA00719C6817
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744831079C;
	Thu,  2 Oct 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8pHRxxu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E430DED8;
	Thu,  2 Oct 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409557; cv=none; b=uULstfEkJ5o8q57tntVbioxNwxaHdD2afoxuOFb3eTkZkbfW4vdJizb1zyJfQqKDlfFpalrm/vVdyReOiDd6yfhhAZBK7K8VOQmD4vNsRJGUlXB314FzQEPxrEj50jnyOYOtmCRgaPsxL3gQCN33OTJE07Zfw71qCRIu2Q5Z9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409557; c=relaxed/simple;
	bh=i30smwRwajTkDI8STXOv3yAHySO/FGPC+2nsfXuSI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLm2D8wUT/1/odXemke6027xB1dGYjcOun6uPeiIehmEQfBakKFFBlyYs9bNmfu/XlJnhgUO6e5AWNr3qF+8nVrxDyhtexEkFFF9gDgWNk2AbQZOKiLoB6CmFwc7svAk4GZ9QGEFeWb3CmBGOjQoZKThx0qz2m3Y0w8Evb7LhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8pHRxxu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759409556; x=1790945556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i30smwRwajTkDI8STXOv3yAHySO/FGPC+2nsfXuSI64=;
  b=F8pHRxxu95P3iy2+u/rTBxm62L7fG12cX2uhiU//g2gKqXCgvGiDuXav
   sMGJEIxMH8cM07ARdaK5xxaEmSVX6iPtLCKTxlUvdRppJFU4UHK6tzaaL
   A/jK8yrFBvZODpY7PZUznZoWxcI4bJkt035WO8E9U0H2J1qq3G43DLdQT
   IGm188fh9kcHooFA0lAuVdx33/fQ6MofrDxBX7S73mi3SdTgjAM81b+TE
   5WL43VFxtJNBYj9jYwucyBIlVj05ux+cR6I3O5u+gr6EhYve4nVIFRtNf
   O85gNraaDkW5UYZeMMPqqT/ySeWj7WouKbsIYCmt4CbS14ryt1yXjD3xB
   g==;
X-CSE-ConnectionGUID: s7cIuCGyR9C4VHPippvypg==
X-CSE-MsgGUID: v1YSIxoPTkC16YOcxl13Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61579805"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="61579805"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:36 -0700
X-CSE-ConnectionGUID: wi0LIPNxSmG28Y7CZrC6FA==
X-CSE-MsgGUID: TO3k8yjpTnO9EetGqOxqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179057610"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:33 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] ASoC: SOF: ipc4-topology: Account for different ChainDMA host buffer size
Date: Thu,  2 Oct 2025 15:53:21 +0300
Message-ID: <20251002125322.15692-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
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


