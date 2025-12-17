Return-Path: <stable+bounces-202862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD16CC894D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE1C30A5D95
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A7B33C511;
	Wed, 17 Dec 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpVVnU2T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41134CFCC;
	Wed, 17 Dec 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982376; cv=none; b=hnpbLlLOZxANMXf0EDhHAJ+YoWBcurQlY9nyTlC+4NSlVWtkADq03gFbp8bm8ikg5zIVPwaBIraENSNFq6YiuxDRMPSnbdmXPJjFPBZaOQkVpBNyeoKE2Adyjnz+rUhkvKxYzjwU7zrJCQuvhymB1wMFd9+MqYrtDzGwrfU7VfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982376; c=relaxed/simple;
	bh=og2si2JwwK5K0TXNKBXtJnNm8X4QGMPiIzr0Tc+XtLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfv8phLLQYcXXU/4iHrZJLsUfVibkPkowqTphZ+e9ItJQx6WMjHHyaFdVCGlsYFe2a5wPpjldex1V8pSXjYAKIyaFqSNm9D+znOUwW4YFCvHuFdVo5KOrk4gsW4CcvsvvzNa1Owx1M1bpfma+aiF2w0dlJYNdqMqQk9jFGujJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpVVnU2T; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982375; x=1797518375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=og2si2JwwK5K0TXNKBXtJnNm8X4QGMPiIzr0Tc+XtLQ=;
  b=mpVVnU2TgF200y2R0zvZFc/GTtA0uDWh7BUHe7Uy716sIKVl8p/oh6db
   /k67Mgl3ysY1q9fZjEjDzgVjA0eT2GF6T+6cx+525nVNYzE+n7bk9J0Ek
   McLYynJR3gediPq9+RJzfy3MugZOvZLi9PWzYghZpmxzUBPKIdtiCVrCq
   cvXGHJiPZUe439OwqbMNBgpfe7XE6fVX3iatjEVOMm5f6P+i1ZI4tmD9k
   8CkVqPXFW887PIqJ1zWPY+MrTKHcfJu6uO37pppSBf/M/xMWQBRrALJk0
   fuXOtzYtTLsfJnG+CQmD77UinITMrfK2x5AQ52UDr7JlxdT/5KYBw8Oym
   g==;
X-CSE-ConnectionGUID: ww0wiCFSTIyXNGzTooR6Yg==
X-CSE-MsgGUID: s0wK26N6Tbi5YCCRHLOKIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859853"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859853"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:35 -0800
X-CSE-ConnectionGUID: /OHMLa+tTMOL0jGGgl9lgw==
X-CSE-MsgGUID: bdpPyR8DTM+tb8W7hB/FBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084951"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:32 -0800
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
Subject: [PATCH v3 4/8] ASoC: SOF: ipc4-control: Keep the payload size up to date
Date: Wed, 17 Dec 2025 16:39:41 +0200
Message-ID: <20251217143945.2667-5-peter.ujfalusi@linux.intel.com>
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

When the bytes data is read from the firmware, the size of the payload
can be different than what it was previously.
For example when the topology did not contained payload data at all for the
control, the data size was 0.
For get operation allow maximum size of payload to be read and then update
the sizes according to the completed message.

Similarly, keep the size in sync when updating the data in firmware.

With the change we will be able to read data from firmware for bytes
controls which did not had initial payload defined in topology.

Fixes: a062c8899fed ("ASoC: SOF: ipc4-control: Add support for bytes control get and put")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 80111672c179..453ed1643b89 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -426,13 +426,21 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
 
 	msg->data_ptr = data->data;
-	msg->data_size = data->size;
+	if (set)
+		msg->data_size = data->size;
+	else
+		msg->data_size = scontrol->max_size - sizeof(*data);
 
 	ret = sof_ipc4_set_get_kcontrol_data(scontrol, set, lock);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(sdev->dev, "Failed to %s for %s\n",
 			set ? "set bytes update" : "get bytes",
 			scontrol->name);
+	} else if (!set) {
+		/* Update the sizes according to the received payload data */
+		data->size = msg->data_size;
+		scontrol->size = sizeof(*cdata) + sizeof(*data) + data->size;
+	}
 
 	msg->data_ptr = NULL;
 	msg->data_size = 0;
@@ -448,6 +456,7 @@ static int sof_ipc4_bytes_put(struct snd_sof_control *scontrol,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct sof_abi_hdr *data = cdata->data;
 	size_t size;
+	int ret;
 
 	if (scontrol->max_size > sizeof(ucontrol->value.bytes.data)) {
 		dev_err_ratelimited(scomp->dev,
@@ -469,9 +478,12 @@ static int sof_ipc4_bytes_put(struct snd_sof_control *scontrol,
 	/* copy from kcontrol */
 	memcpy(data, ucontrol->value.bytes.data, size);
 
-	sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
+	ret = sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
+	if (!ret)
+		/* Update the cdata size */
+		scontrol->size = sizeof(*cdata) + size;
 
-	return 0;
+	return ret;
 }
 
 static int sof_ipc4_bytes_get(struct snd_sof_control *scontrol,
@@ -581,6 +593,9 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 		return -EFAULT;
 	}
 
+	/* Update the cdata size */
+	scontrol->size = sizeof(*cdata) + header.length;
+
 	return sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
 }
 
-- 
2.52.0


