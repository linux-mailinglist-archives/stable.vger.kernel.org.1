Return-Path: <stable+bounces-202859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D2CC88B7
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430E8308CBF6
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641083596E3;
	Wed, 17 Dec 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Up7qEdZm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4934D92E;
	Wed, 17 Dec 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982367; cv=none; b=Sh+AAwPZJsMIRnY1Poc6RSBCS8IHSiQwXozLf4HUzcaBk03RoiVeBuV3ixL9BV51vTh1DLvoy+lOSSezirQ/XNM03qfFe67WXRvi2Y1nAsn27esTJYJbkEdsJ4uNpzK6KRG2oqdcVkNvkG8q4ZltQMOwfcNVmeQ1iyn+KAZgj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982367; c=relaxed/simple;
	bh=kOY13FM4fHZuGeAXmtW23FFbRnGam9T6ZD5pzo6LR2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVbnzh+/XEBF4RC1OKhWqW+Vnw82qWW0U+5p8uF10npJEh4lOxu+4p3nyf2SZeNFO9LR0wcnKFhhjXd1u+bFDjun7v20l2bMvX+deusiwr70WFonBTfSagC02HW3w7h9XsSea4tw2UVdPSRcxT/izHcx9ESgFEJ3ctN46uuVB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Up7qEdZm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982366; x=1797518366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOY13FM4fHZuGeAXmtW23FFbRnGam9T6ZD5pzo6LR2I=;
  b=Up7qEdZma64mtyuKd32SLUCzFSsJ+fWBa2+GkL6z7hot4THIRz0iHXbY
   s/1kTU4Pl4nPEa+aJxAJY3ezTTbNx0H4v3yo50VK1SaSa3EHcSrfjfWsD
   h8RL5AgS+HZzHQeQtr466KAwrpz5ZFKK+qqiXuv6ypEItIsiKV5/DaSPl
   vlEd8YrZ0EhWH6P7drQk+/T9LLE/tg7uXc+ySgPbgMo4VLbZrMb5LDnAP
   kGhDKrbRTicsjWkTaqv04iWA73EdxWyH8U1PiS/GVHn0EGkV7ADOM1aFV
   KO1gmYjjgV9uV92gvUKlU7XgQ4XNkG/IoK2U4aDotifobkq+cMDrgmrpH
   w==;
X-CSE-ConnectionGUID: G2vZGscDRsOtHfIKdtkcVg==
X-CSE-MsgGUID: GCF1LmtpQuCayH/oVsl3zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859829"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859829"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:26 -0800
X-CSE-ConnectionGUID: EqCGWAVtTFmQkmM7WaU/zA==
X-CSE-MsgGUID: hSMAOEhwQfWkDKBmUhHEBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084916"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:22 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] ASoC: SOF: ipc4-control: If there is no data do not send bytes update
Date: Wed, 17 Dec 2025 16:39:38 +0200
Message-ID: <20251217143945.2667-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
References: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the bytes control have no data (payload) then there is no need to send
an IPC message as there is nothing to send.

Fixes: a062c8899fed ("ASoC: SOF: ipc4-control: Add support for bytes control get and put")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 976a4794d610..0a05f66ec7d9 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -412,8 +412,16 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 	int ret = 0;
 
 	/* Send the new data to the firmware only if it is powered up */
-	if (set && !pm_runtime_active(sdev->dev))
-		return 0;
+	if (set) {
+		if (!pm_runtime_active(sdev->dev))
+			return 0;
+
+		if (!data->size) {
+			dev_dbg(sdev->dev, "%s: No data to be sent.\n",
+				scontrol->name);
+			return 0;
+		}
+	}
 
 	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
 
-- 
2.52.0


