Return-Path: <stable+bounces-91826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FE9C07CB
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B897C1F2156C
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB3210188;
	Thu,  7 Nov 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka5aKrJQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DA20FAB4;
	Thu,  7 Nov 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986998; cv=none; b=Fx4msy7zwjK/0YHHDA+LyzDVfWLVXGOCK1SJCC0+tNxt33jhRceGA8NBg8RW2Drq3CnTVPlYspqgIgPVkw5IGCDdqGNlW520jxODzsl9WlzCo02/SbJJVU6jx6biMTT2Z9iwMmJjFLX8dZGomrqbuBhHeIlrd0bTnU9j9BFwbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986998; c=relaxed/simple;
	bh=2BlsdBJChCstmGMmVv8EtRoLmNdjk249JBdgHPL8c0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3OAAanfYc/iEYA5sUq8ecIC/Y+cI8VqVnM/b98u0JkmntaU8H0MCoJyk01tsp32MWL6YsrBC7B51Xd80/RbmPCchQEl4jbWxLt2FHbaUNNpwKQeWEZB8E+FSmo4ECBvClO0+ufWvnpzWUFhTbQaLydbThGbutkkGuTX10dMHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka5aKrJQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730986998; x=1762522998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2BlsdBJChCstmGMmVv8EtRoLmNdjk249JBdgHPL8c0M=;
  b=ka5aKrJQy2iNv2NEHDYw+EqqYrDlB29igGBoq+cEup159EZRtfJALfWA
   vbXdkGnkFSneF3vGRLaYLz/IaVcZdc2ZjWBRFHHLYMd3AD28P1LY2DVqk
   Lj8jvRVv6gD+ey/b2jqSQegk7DGR6mCtwXJGwlpv51SkalxXkydttICDm
   mSzYpHDMwzZH3BjiBfGZsPTrUldEbcTS4iQiJVLbRLlDq7bR/2nLhgOOr
   GdZ890qeGrz2FoKwpi6MiLlqA8x4nQRRoqnlXLKP5YDMaRkB1pvRVCTUO
   x0uiPAIDTKpzCCwQScn3XnvSQ7B3s5EPLE9b3JT8K/efJaOUgXbjeW0sd
   w==;
X-CSE-ConnectionGUID: yc8/6Cu8S0aiiA6rujEUFQ==
X-CSE-MsgGUID: 9d45E5LsSya5CCUyDijrWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34522537"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34522537"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:43:17 -0800
X-CSE-ConnectionGUID: gyBzaGFYR+OGlg6pb81Znw==
X-CSE-MsgGUID: LgZAO4C0SIS4gKLNbyBlBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="115920696"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:43:14 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
Date: Thu,  7 Nov 2024 15:43:07 +0200
Message-ID: <20241107134308.23844-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
References: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nullity of sps->cstream should be checked similarly as it is done in
sof_set_stream_data_offset() function.
Assuming that it is not NULL if sps->stream is NULL is incorrect and can
lead to NULL pointer dereference.

Fixes: ef8ba9f79953 ("ASoC: SOF: Add support for compress API for stream data/offset")
Cc: stable@vger.kernel.org
Reported-by: Curtis Malainey <cujomalainey@chromium.org>
Closes: https://github.com/thesofproject/linux/pull/5214
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/sof/stream-ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/stream-ipc.c b/sound/soc/sof/stream-ipc.c
index 794c7bbccbaf..8262443ac89a 100644
--- a/sound/soc/sof/stream-ipc.c
+++ b/sound/soc/sof/stream-ipc.c
@@ -43,7 +43,7 @@ int sof_ipc_msg_data(struct snd_sof_dev *sdev,
 				return -ESTRPIPE;
 
 			posn_offset = stream->posn_offset;
-		} else {
+		} else if (sps->cstream) {
 
 			struct sof_compr_stream *sstream = sps->cstream->runtime->private_data;
 
@@ -51,6 +51,10 @@ int sof_ipc_msg_data(struct snd_sof_dev *sdev,
 				return -ESTRPIPE;
 
 			posn_offset = sstream->posn_offset;
+
+		} else {
+			dev_err(sdev->dev, "%s: No stream opened\n", __func__);
+			return -EINVAL;
 		}
 
 		snd_sof_dsp_mailbox_read(sdev, posn_offset, p, sz);
-- 
2.47.0


