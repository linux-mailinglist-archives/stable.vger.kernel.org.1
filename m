Return-Path: <stable+bounces-202865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689BFCC885D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A263132ED6
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7723366DA9;
	Wed, 17 Dec 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJLtmYde"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6966358D32;
	Wed, 17 Dec 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982385; cv=none; b=Gi56X9p6tFA9udwHFXcCLBZLA9nfSvt4oaxWKcivF+A9MyIs+l1KOzl996/81PwibeeSJUns08ApQHb9luEMTdmS47sEFWEdygKBFP/agYq9MQLAXDR3r6D59nHqVfNUmdPxufOVlWOdtIMR+5D+dcL9oZbAd5To1TMdLfCiqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982385; c=relaxed/simple;
	bh=WgGsJ88oYVRopKGvjZWIKWYQqQ7qi+7bf1Bv7HLmHIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH9yhn5nj5v0rK4Ud7wgKoAb9BEyuoG/MgSXoLhEGMjnpOytEQQyFR0Y/GoDzltyYam5ta4ST0w2h8OF7jj1BILhDbGsmfju42Qy8+1qcx7fBTRpTG2PCB52PL8OEN650Vn4Rf6e8ejD9weBlOgS6W12zl66Ihl581jCVPWWtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJLtmYde; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982384; x=1797518384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WgGsJ88oYVRopKGvjZWIKWYQqQ7qi+7bf1Bv7HLmHIM=;
  b=FJLtmYdeKVY6Y8TGVWjnn6TJsxC69E/ExSoFT7V+k1yrTDQ60kgxCQqY
   /gBMwVire3C2beXXfV4/lFe0dRrVatFymde95bYUQaSVuberxDmNd4Qdx
   GDARRMNhpLZLKaf+3MWTi/Eg+eazocwxWz7rrCgKXarqGFPqs2M9HWRxv
   UOyeUvW+x/1SRgrhHr/EzUpFhNo4GyhUBhwsOXCtxMmI/0dgPMs69VZsq
   bG4m8cbP0aIzBzxdwbt2VaIOnxwWcyL1xXhQiyHvC6C3fM7ChacahHpBR
   xe5rhOcG29EfDS0yq0zFmlRFoJYiTS3ku+jnkGrDhXsQgAMN+JBY6hPre
   A==;
X-CSE-ConnectionGUID: BAN8Y3PKQRy1pox19Lgt3A==
X-CSE-MsgGUID: mepX11ZqSXCW/MUkUyl/Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859874"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:44 -0800
X-CSE-ConnectionGUID: MKFqcREWTbi5kjGUzGgX7A==
X-CSE-MsgGUID: iT1knLrKTh+nbvzG96Xriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084978"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:41 -0800
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
Subject: [PATCH v3 7/8] ASoC: SOF: ipc4: Add definition for generic bytes control
Date: Wed, 17 Dec 2025 16:39:44 +0200
Message-ID: <20251217143945.2667-8-peter.ujfalusi@linux.intel.com>
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

Currently IPC4 only supports module specific custom bytes controls, where
each control's param_id is module specific.
These bytes controls cannot be handled in a generic way, there is no clean
way to support for example notifications from firmware when their data
has been changed.

Add definition for generic bytes control which should be handled in a
similar way as the enum/switch controls.

The generic param id for BYTES is selected to be 202

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.h | 9 +++++++--
 sound/soc/sof/ipc4.c          | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index 191b51d97993..9a028a59c553 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -368,19 +368,24 @@ struct sof_ipc4_control_data {
 
 #define SOF_IPC4_SWITCH_CONTROL_PARAM_ID	200
 #define SOF_IPC4_ENUM_CONTROL_PARAM_ID		201
+#define SOF_IPC4_BYTES_CONTROL_PARAM_ID		202
 
 /**
  * struct sof_ipc4_control_msg_payload - IPC payload for kcontrol parameters
  * @id: unique id of the control
- * @num_elems: Number of elements in the chanv array
+ * @num_elems: Number of elements in the chanv array or number of bytes in data
  * @reserved: reserved for future use, must be set to 0
  * @chanv: channel ID and value array
+ * @data: binary payload
  */
 struct sof_ipc4_control_msg_payload {
 	uint16_t id;
 	uint16_t num_elems;
 	uint32_t reserved[4];
-	DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
+	union {
+		DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
+		DECLARE_FLEX_ARRAY(uint8_t, data);
+	};
 } __packed;
 
 /**
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index a58a5049e7ac..73d9f2083326 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -445,6 +445,7 @@ static bool sof_ipc4_tx_payload_for_get_data(struct sof_ipc4_msg *tx)
 	switch (tx->extension & SOF_IPC4_MOD_EXT_MSG_PARAM_ID_MASK) {
 	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_SWITCH_CONTROL_PARAM_ID):
 	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_ENUM_CONTROL_PARAM_ID):
+	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_BYTES_CONTROL_PARAM_ID):
 		return true;
 	default:
 		return false;
-- 
2.52.0


