Return-Path: <stable+bounces-201053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3735CCBE42D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37D15300EDED
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188E29BD94;
	Mon, 15 Dec 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+UhBOx1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1822154F;
	Mon, 15 Dec 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808709; cv=none; b=Rq5LwjnbhQIZECBy7Zsnu8ITEWUytJuy2tpNlYJmA2+8UsQg6uqFW2X7BCOJzHkBas26xv2EpJ2DCQKBH9GPR4RVstYqeLXFNLAU4k5VZebkxBibHma3LFdY7iBMqqyjWfv6ywHfrqJR7Vg4Teg3k3z1wQf2YVmujXnKtl1g2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808709; c=relaxed/simple;
	bh=og2si2JwwK5K0TXNKBXtJnNm8X4QGMPiIzr0Tc+XtLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ5K8bYtGf/ptz+K/CfVDGFE65TVJtqC26sXmLNY1WTjy7IY7e16pr5Uij8sbD4KqZHwxzuU98e0MtODaWNyfjmcvpnAnZVPs5cioanqFUO0Nv+8O1PoTroZn34SDfgEAl+eqrcjUrU6+LV4WnAH0EfSgkjhEnZZ51XjCBr74PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+UhBOx1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808707; x=1797344707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=og2si2JwwK5K0TXNKBXtJnNm8X4QGMPiIzr0Tc+XtLQ=;
  b=C+UhBOx1XogOn/Tng8grfEjz6/pFVkrEUH+UTChL3KbTgNd6z+jOkVXL
   yoGcAUUxKqn07R6g3bBe4lI2fTYDVDkebC7fD2FK3uq/pvQCRwJVGC2CH
   Ped1OKsc4IrWikY52TlW00obcfYL6OT0QfI6kMvzOVCXYlowe1ykV82jX
   B+QbuU4gQgT/wMrEPqLdrTSgLrWwEZDy2a3x4s/NDhxT7zpTwtssEBn8O
   9YWFfQLXOvOhKz6drY/mdJK6BJkuj90oX5k3YmQxlOJdiykkVCGu2zo/x
   CbJVLEjQt4IZSugNnxa4IDeBiAbFNA2z6jdk9FbIxvefbCLBkXXjViFO7
   A==;
X-CSE-ConnectionGUID: eS6pPU0SQt6lWClZsDZmeQ==
X-CSE-MsgGUID: 5Lbe452BSamhWs6idevKTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866452"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866452"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:07 -0800
X-CSE-ConnectionGUID: vU/CnnWMQDumTkMfti0PZg==
X-CSE-MsgGUID: 0al9elVmS3CgCPRMBN+NZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362413"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:04 -0800
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
Subject: [PATCH v2 4/8] ASoC: SOF: ipc4-control: Keep the payload size up to date
Date: Mon, 15 Dec 2025 16:25:12 +0200
Message-ID: <20251215142516.11298-5-peter.ujfalusi@linux.intel.com>
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


