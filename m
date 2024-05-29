Return-Path: <stable+bounces-47638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22748D360A
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 14:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10971C23B22
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47122180A8C;
	Wed, 29 May 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkmH0nMx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0D169385;
	Wed, 29 May 2024 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984703; cv=none; b=k0btgIDrqRoB4YyPck1xwJh78Bwk4kLzvFQg4TMybbXRPCd3UU1AQRIDxu0bUYSeE6vODn+DxhS0U7fikk/QJA7D3vebP7iKEDewHkT5S51ZAZBhgKwte3KC8GycOZmN9W3EUj5eW27XI4gdw16c6zG6GaHe4QwWkA0B6PrAQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984703; c=relaxed/simple;
	bh=ErrfYOqG+NJyBffD6qDn0EX4RY43mbv5qX7CHzkGS8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsryJx5RUlDoEEnLK0bgGG9zzGWXsL+4clBiWGwTwZKYmDftcr8zCytj7FruB5QE89iRQgV7lWUAo08rqrqnpxYTT9+EksGNSA0wrSp6C+1uS0CKj69M+qAwz1vDivau8MMwuZkp9kfS6oVJxAaLNgRnMISnwgriQxPZIO14xJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkmH0nMx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716984701; x=1748520701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ErrfYOqG+NJyBffD6qDn0EX4RY43mbv5qX7CHzkGS8Q=;
  b=EkmH0nMxTUkD4PNHrb8zoEuul9x7n5kPM1BZV81sJoC5ta66atmuSTUX
   8E2ptCqJLST3i4BVZmfF1dHVUx9l9OJAukk3ghLTLRlcNhqoNb8DZJvhe
   8P+WwWG6cwsukTYfAabOv7jBE83VpW3In/FyRgdpTvmP8l1dqj3xgipGX
   tkHZ11dYe9Qn7nhbQsfU27+I2BM2mQs2u9sXMF+4xbd4l4YAotiOYB/do
   SLbsc6CtN1wBu8pF98kwq769udnA8yNoLlk0G7YifF7HMEVpDQMdtzrUk
   NxFC9ljy2NSS0Bf1oeRnABESFnPNmiWzX7VCJ+AYdSXxEWNmWcBrYflkL
   A==;
X-CSE-ConnectionGUID: sEL8c8nVTCmCbTtbuRlFoQ==
X-CSE-MsgGUID: yaCye+iPSZaQdHAwTjlS1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13510679"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13510679"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:11:41 -0700
X-CSE-ConnectionGUID: 5tKlkf8LQguRC4dV1mPB6Q==
X-CSE-MsgGUID: 7NKXdOQXRnWAMaZsxzaS/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40266900"
Received: from unknown (HELO pujfalus-desk.intel.com) ([10.124.223.77])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:11:39 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org,
	seppo.ingalsuo@linux.intel.com
Subject: [PATCH 6.10] ASoC: SOF: ipc4-topology: Fix input format query of process modules without base extension
Date: Wed, 29 May 2024 15:12:01 +0300
Message-ID: <20240529121201.14687-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a process module does not have base config extension then the same
format applies to all of it's inputs and the process->base_config_ext is
NULL, causing NULL dereference when specifically crafted topology and
sequences used.

Fixes: 648fea128476 ("ASoC: SOF: ipc4-topology: set copier output format for process module")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: stable@vger.kernel.org
---
Hi Mark,

Can you please pick this patch for 6.10 as it can fix a potential NULL
pointer dereference bug.

Thank you,
Peter

 sound/soc/sof/ipc4-topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index beff10989324..33e8c5f7d9ca 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -217,6 +217,14 @@ sof_ipc4_get_input_pin_audio_fmt(struct snd_sof_widget *swidget, int pin_index)
 	}
 
 	process = swidget->private;
+
+	/*
+	 * For process modules without base config extension, base module config
+	 * format is used for all input pins
+	 */
+	if (process->init_config != SOF_IPC4_MODULE_INIT_CONFIG_TYPE_BASE_CFG_WITH_EXT)
+		return &process->base_config.audio_fmt;
+
 	base_cfg_ext = process->base_config_ext;
 
 	/*
-- 
2.45.1


