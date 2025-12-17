Return-Path: <stable+bounces-202864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05FCC87AC
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42E1B307564B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08B34CFB8;
	Wed, 17 Dec 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4fuALSs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC6366DA9;
	Wed, 17 Dec 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982382; cv=none; b=il8ugnedNeHq0JsR9kLZz7IU4mijml5hq0VoXV5HPBY0Q5tWRkk4GsneUvN0s6RXa1YTf7sUQjkfheuN2tc3bPevQZwzgu/pCfu/DJar5RGjoXAP/vrBOvrFL/vaIzFMRnJBQaOFP/IVSWceMjKV1Gg7AarGQwCA9+p/+fyR5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982382; c=relaxed/simple;
	bh=Utg/xJXItLzsIiEuLnKT16uKDe6Iw5MecYKp375hg7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOgnSJL00jrk4SMU6/tfN/AdXL3dw4M9Wfa6CpFtT/wgBzuBgX2I0Z4XW+x0wHMTfvO0V/7oo8Qo1aBFjc1e/aoRlwy2eMEp71YEHsl5tcoMAUxDjpARvoaQq5Xt8svbMLPnnalK8c694TI2WI78mOD87pY8yLJnuWKIRf6rhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4fuALSs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982381; x=1797518381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Utg/xJXItLzsIiEuLnKT16uKDe6Iw5MecYKp375hg7A=;
  b=D4fuALSsEuHEC581OS1QBppQXl/Z+88Sb2z5ST8MoPTAeyO1ADDNJsgO
   C0WoVJLSM0ZJJmEYpb20+AneGCmfUNreu7TXrNYyEB9jbBaacjZ8xskmG
   OMpjLJmxCdNOmsmGyjSoUU/wioDhBiiCFDcdHD0yXqHvZn3tsHOCdRK8o
   WPafXp6K4fyN8DQ4GFxpt7iHE581U2CMO5sB3ZyBh5DBwnhrEwYhpnZpn
   fBqrdX+H8ko5AvhoGREVYHKeBdXQ+8xEup6vkT62wH+7YvASP1LK79jEY
   8E2AxnTOZ7ftnENAsch+2LDpR+PNwHfU+Un+EXrj0tASZEVqFCzJOfDzV
   A==;
X-CSE-ConnectionGUID: 1rpFb6amTWqEsKLBBYoJRQ==
X-CSE-MsgGUID: kgB6hEdZRluiClgzb1Iztw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859866"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859866"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:41 -0800
X-CSE-ConnectionGUID: +KFWjlWmR2qODk5/sn7S+w==
X-CSE-MsgGUID: DgCnZGAJTkOd9ZD25pXL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084964"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:38 -0800
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
Subject: [PATCH v3 6/8] ASoC: SOF: ipc4: Support for sending payload along with LARGE_CONFIG_GET
Date: Wed, 17 Dec 2025 16:39:43 +0200
Message-ID: <20251217143945.2667-7-peter.ujfalusi@linux.intel.com>
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
index 1df97129cee6..a58a5049e7ac 100644
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


