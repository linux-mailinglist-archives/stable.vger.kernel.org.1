Return-Path: <stable+bounces-201055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4213CCBE436
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38B043010E7E
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540312E282B;
	Mon, 15 Dec 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHwWwvna"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A933F372;
	Mon, 15 Dec 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808714; cv=none; b=WFn03LVZj7A2dCIa6LFZJvWHT/X95DM1cawdg4Tk/mMqGjZ7BEByOhLZBPC3Un1JT1kf8kYiPDhN40ItHmuUUBVFpz3M3z/hlcxqIvzzMb6tZuhmHpx8VOH7qmjECqZFLM7xw6rEsvFa8cxYc4JcxEUuh1wrtJzhLdeTYz6R9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808714; c=relaxed/simple;
	bh=fZ0jl5gYXcULaU4KI+XXEJ6KwMNxd80BbCW+qmWeKv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKyFnoI1MigyB0OHp2e6GG2YGcM4p05EmOHFaeVATDVTHkOkhWks4WgYZVxxWf3ik2LX6aRxqMtDcbpfr1zcmMIrlHFJ/mEj2qVI6Rx9HEPmcoPwOE5bUTkaZON/Jmhr8gm46b9u8Cijisn3il1hUe+Lq2oFxVEMMtGhBP8sFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHwWwvna; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808713; x=1797344713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZ0jl5gYXcULaU4KI+XXEJ6KwMNxd80BbCW+qmWeKv8=;
  b=IHwWwvnajERNghRQEmjo52AgU8W+pXQbphf8WZ3ArJKn8VbIp8gO/N8j
   8kNW8pKQxGegKoarJRWbyElhC0RFPllrmn42p6gPEx0hhT/ugIs6RfDLi
   1caNL0b28/+A6rtCAVp9qqJ3sARLyhMIP/dcpUSI1FqsqGuPxceNZOt+4
   5TyZs+JyVtxyNF8v58xARGwU19jwi4OY1o7NJZ1WIYWK836Vc+FDX/DTL
   ByfB/VnT+26KOS0cS4wdp/D8w7+Kosf5hXsT07E/wHWHYU3E887d/0A8J
   +MLabg3pHHWhqmob3TZ5tpQvTB7D9Efsa47I4TevpSaChLBTRHhozBibD
   A==;
X-CSE-ConnectionGUID: CwzZ4w8RTXGeZUqSwacG/A==
X-CSE-MsgGUID: kp+dxDhgQDShg/v/bzOMiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866468"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866468"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:13 -0800
X-CSE-ConnectionGUID: oPEZgmBnSvqqD0mnobWMxg==
X-CSE-MsgGUID: 7xdo5hmPQ5m3327oq+aNqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362489"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:10 -0800
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
Subject: [PATCH v2 6/8] ASoC: SOF: ipc4: Support for sending payload along with LARGE_CONFIG_GET
Date: Mon, 15 Dec 2025 16:25:14 +0200
Message-ID: <20251215142516.11298-7-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are message types when we would need to send a payload along with
the LARGE_CONFIG_GET message to provide information to the firmware on
what data is requested.
Such cases are the ALSA Kcontrol related messages when the high level
param_id tells only the type of the control, but the ID/index of the exact
control is specified in the payload area.

The caller must place the payload for TX before calling the set_get_data()
and this payload will be sent alongside with the message to the firmware.

The data area will be overwritten by the received data from firmware.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index a4a090e6724a..20d723f48fff 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -15,6 +15,7 @@
 #include "sof-audio.h"
 #include "ipc4-fw-reg.h"
 #include "ipc4-priv.h"
+#include "ipc4-topology.h"
 #include "ipc4-telemetry.h"
 #include "ops.h"
 
@@ -433,6 +434,23 @@ static int sof_ipc4_tx_msg(struct snd_sof_dev *sdev, void *msg_data, size_t msg_
 	return ret;
 }
 
+static bool sof_ipc4_tx_payload_for_get_data(struct sof_ipc4_msg *tx)
+{
+	/*
+	 * Messages that require TX payload with LARGE_CONFIG_GET.
+	 * The TX payload is placed into the IPC message data section by caller,
+	 * which needs to be copied to temporary buffer since the received data
+	 * will overwrite it.
+	 */
+	switch (tx->extension & SOF_IPC4_MOD_EXT_MSG_PARAM_ID_MASK) {
+	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_SWITCH_CONTROL_PARAM_ID):
+	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_ENUM_CONTROL_PARAM_ID):
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 				 size_t payload_bytes, bool set)
 {
@@ -444,6 +462,8 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 	struct sof_ipc4_msg tx = {{ 0 }};
 	struct sof_ipc4_msg rx = {{ 0 }};
 	size_t remaining = payload_bytes;
+	void *tx_payload_for_get = NULL;
+	size_t tx_data_size = 0;
 	size_t offset = 0;
 	size_t chunk_size;
 	int ret;
@@ -469,10 +489,20 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 
 	tx.extension |= SOF_IPC4_MOD_EXT_MSG_FIRST_BLOCK(1);
 
+	if (sof_ipc4_tx_payload_for_get_data(&tx)) {
+		tx_data_size = min(ipc4_msg->data_size, payload_limit);
+		tx_payload_for_get = kmemdup(ipc4_msg->data_ptr, tx_data_size,
+					     GFP_KERNEL);
+		if (!tx_payload_for_get)
+			return -ENOMEM;
+	}
+
 	/* ensure the DSP is in D0i0 before sending IPC */
 	ret = snd_sof_dsp_set_power_state(sdev, &target_state);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tx_payload_for_get);
 		return ret;
+	}
 
 	/* Serialise IPC TX */
 	mutex_lock(&sdev->ipc->tx_mutex);
@@ -506,7 +536,15 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 			rx.data_size = chunk_size;
 			rx.data_ptr = ipc4_msg->data_ptr + offset;
 
-			tx_size = 0;
+			if (tx_payload_for_get) {
+				tx_size = tx_data_size;
+				tx.data_size = tx_size;
+				tx.data_ptr = tx_payload_for_get;
+			} else {
+				tx_size = 0;
+				tx.data_size = 0;
+				tx.data_ptr = NULL;
+			}
 			rx_size = chunk_size;
 		}
 
@@ -553,6 +591,8 @@ static int sof_ipc4_set_get_data(struct snd_sof_dev *sdev, void *data,
 
 	mutex_unlock(&sdev->ipc->tx_mutex);
 
+	kfree(tx_payload_for_get);
+
 	return ret;
 }
 
-- 
2.52.0


