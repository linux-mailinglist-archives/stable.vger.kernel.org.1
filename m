Return-Path: <stable+bounces-202866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B2ACC8842
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14406311A1CB
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8D34AAFD;
	Wed, 17 Dec 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeddGobW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC0329364;
	Wed, 17 Dec 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982388; cv=none; b=hfOsqIWd+3LsGTcRyD4Pt3tMjg95V01wkTO58/yDzjABQbOT1LWqJABzqnUTuiYP6FYxTLALiYmPfVZ3rOf2mw626K5M5bDx0pvmmXBMG7fiVz5Se1a3Z8AuLTr1WBNhLJDFWevsnyXbfxs1GpjeNN9wxjT/v3/i+6BetcpvS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982388; c=relaxed/simple;
	bh=rE3Ks+YCu+J7Dp7YeegytlmkFJ843FJebBEQD/mls7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YryNCqHQ6z+DEhGW8ytxfasWq6xOOS103A35XNHnpNEVSOSOkyS6zeiPBrQnwUYXvft2fu4R5SjXjDoVrw/sNEjNyUAQyRWIfMhl9EEc9ypIWS4qZefOUwzs6IY73VNHJCm9Sjx56j4GWRkCSrc9ly0bnP+prZhoMzgjYNcZB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeddGobW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982388; x=1797518388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rE3Ks+YCu+J7Dp7YeegytlmkFJ843FJebBEQD/mls7o=;
  b=VeddGobWkvsI6OtPcks/Puwkwr3/Z04sujMnXLlkIGzbHI+dQkiWXU1s
   pyBtsBWBPXi1Pmpsyc/2XxR8AHV5tDuuW7opNRjhm5OCS5eO9xb9Kc0AX
   JhltzKgvwFnBiONbjcvQpWJTpOz/UbjkOI9zoUlfpQkDPWdlAgLF0Y6X8
   vBU86v5HFnnbMZXPwSRH5jNtOMu9TtfzmlQLVMdgHSvRJm+X5Lr50BOOF
   AjKGxH9cRh7VUZhc/5dXAobdEBQcvf+x9OCqE+ojKUZD+99rPD3msYVbt
   Fvcx3UKif/ASE+T2lP+9xwSFsj61BhWPh/6yNwO6sbPEJ/trMpcXAB/5j
   A==;
X-CSE-ConnectionGUID: aD8IijTfRCm4lu24kTi+Eg==
X-CSE-MsgGUID: FwjHLfzOQwKIcUbqVmPb/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859881"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859881"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:47 -0800
X-CSE-ConnectionGUID: c4k4eZoUQySD/i4XCmC/Bg==
X-CSE-MsgGUID: d82gxLVvQ2ut+AaVo1flsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084992"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:44 -0800
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
Subject: [PATCH v3 8/8] ASoC: SOF: ipc4-control: Add support for generic bytes control
Date: Wed, 17 Dec 2025 16:39:45 +0200
Message-ID: <20251217143945.2667-9-peter.ujfalusi@linux.intel.com>
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

The generic byte control can be used in cases when the bytes data can be
changed by the firmware and it sends a notification about the change,
similarly to the enum and switch controls.

The generic control support is needed as from the param_id itself it is
not possible to know which control has changed. The needed information
is only available via generic control change notification.

Generic bytes controls use param_id 202 and their change notification can
contain payload with the change embedded or just the header message as
notification.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 156 +++++++++++++++++++++++++++++++----
 1 file changed, 142 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 453ed1643b89..0500b690f9a3 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -284,6 +284,105 @@ static void sof_ipc4_refresh_generic_control(struct snd_sof_control *scontrol)
 	kfree(data);
 }
 
+static int
+sof_ipc4_set_bytes_control_data(struct snd_sof_control *scontrol, bool lock)
+{
+	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+	struct snd_soc_component *scomp = scontrol->scomp;
+	struct sof_ipc4_control_msg_payload *msg_data;
+	struct sof_abi_hdr *data = cdata->data;
+	struct sof_ipc4_msg *msg = &cdata->msg;
+	size_t data_size;
+	int ret;
+
+	data_size = struct_size(msg_data, data, data->size);
+	msg_data = kzalloc(data_size, GFP_KERNEL);
+	if (!msg_data)
+		return -ENOMEM;
+
+	msg_data->id = cdata->index;
+	msg_data->num_elems = data->size;
+	memcpy(msg_data->data, data->data, data->size);
+
+	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
+
+	msg->data_ptr = msg_data;
+	msg->data_size = data_size;
+
+	ret = sof_ipc4_set_get_kcontrol_data(scontrol, true, lock);
+	msg->data_ptr = NULL;
+	msg->data_size = 0;
+	if (ret < 0)
+		dev_err(scomp->dev, "%s: Failed to set control update for %s\n",
+			__func__, scontrol->name);
+
+	kfree(msg_data);
+
+	return ret;
+}
+
+static int
+sof_ipc4_refresh_bytes_control(struct snd_sof_control *scontrol, bool lock)
+{
+	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+	struct snd_soc_component *scomp = scontrol->scomp;
+	struct sof_ipc4_control_msg_payload *msg_data;
+	struct sof_abi_hdr *data = cdata->data;
+	struct sof_ipc4_msg *msg = &cdata->msg;
+	size_t data_size;
+	int ret = 0;
+
+	if (!scontrol->comp_data_dirty)
+		return 0;
+
+	if (!pm_runtime_active(scomp->dev))
+		return 0;
+
+	data_size = scontrol->max_size - sizeof(*data);
+	if (data_size < sizeof(*msg_data))
+		data_size = sizeof(*msg_data);
+
+	msg_data = kzalloc(data_size, GFP_KERNEL);
+	if (!msg_data)
+		return -ENOMEM;
+
+	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
+
+	msg_data->id = cdata->index;
+	msg_data->num_elems = 0; /* ignored for bytes */
+
+	msg->data_ptr = msg_data;
+	msg->data_size = data_size;
+
+	scontrol->comp_data_dirty = false;
+	ret = sof_ipc4_set_get_kcontrol_data(scontrol, false, lock);
+	if (!ret) {
+		if (msg->data_size > scontrol->max_size - sizeof(*data)) {
+			dev_err(scomp->dev,
+				"%s: no space for data in %s (%zu, %zu)\n",
+				__func__, scontrol->name, msg->data_size,
+				scontrol->max_size - sizeof(*data));
+			goto out;
+		}
+
+		data->size = msg->data_size;
+		scontrol->size = sizeof(*cdata) + sizeof(*data) + data->size;
+		memcpy(data->data, msg->data_ptr, data->size);
+	} else {
+		dev_err(scomp->dev, "Failed to read control data for %s\n",
+			scontrol->name);
+		scontrol->comp_data_dirty = true;
+	}
+
+out:
+	msg->data_ptr = NULL;
+	msg->data_size = 0;
+
+	kfree(msg_data);
+
+	return ret;
+}
+
 static bool sof_ipc4_switch_put(struct snd_sof_control *scontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -423,6 +522,13 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 		}
 	}
 
+	if (data->type == SOF_IPC4_BYTES_CONTROL_PARAM_ID) {
+		if (set)
+			return sof_ipc4_set_bytes_control_data(scontrol, lock);
+		else
+			return sof_ipc4_refresh_bytes_control(scontrol, lock);
+	}
+
 	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
 
 	msg->data_ptr = data->data;
@@ -507,6 +613,8 @@ static int sof_ipc4_bytes_get(struct snd_sof_control *scontrol,
 		return -EINVAL;
 	}
 
+	sof_ipc4_refresh_bytes_control(scontrol, true);
+
 	size = data->size + sizeof(*data);
 
 	/* copy back to kcontrol */
@@ -661,6 +769,8 @@ static int sof_ipc4_bytes_ext_get(struct snd_sof_control *scontrol,
 				  const unsigned int __user *binary_data,
 				  unsigned int size)
 {
+	sof_ipc4_refresh_bytes_control(scontrol, true);
+
 	return _sof_ipc4_bytes_ext_get(scontrol, binary_data, size, false);
 }
 
@@ -714,6 +824,9 @@ static void sof_ipc4_control_update(struct snd_sof_dev *sdev, void *ipc_message)
 	case SOF_IPC4_ENUM_CONTROL_PARAM_ID:
 		type = SND_SOC_TPLG_TYPE_ENUM;
 		break;
+	case SOF_IPC4_BYTES_CONTROL_PARAM_ID:
+		type = SND_SOC_TPLG_TYPE_BYTES;
+		break;
 	default:
 		dev_err(sdev->dev,
 			"%s: Invalid control type for module %u.%u: %u\n",
@@ -764,23 +877,38 @@ static void sof_ipc4_control_update(struct snd_sof_dev *sdev, void *ipc_message)
 		 * The message includes the updated value/data, update the
 		 * control's local cache using the received notification
 		 */
-		for (i = 0; i < msg_data->num_elems; i++) {
-			u32 channel = msg_data->chanv[i].channel;
+		if (type == SND_SOC_TPLG_TYPE_BYTES) {
+			struct sof_abi_hdr *data = cdata->data;
 
-			if (channel >= scontrol->num_channels) {
+			if (msg_data->num_elems > scontrol->max_size - sizeof(*data)) {
 				dev_warn(sdev->dev,
-					 "Invalid channel index for %s: %u\n",
-					 scontrol->name, i);
-
-				/*
-				 * Mark the scontrol as dirty to force a refresh
-				 * on next read
-				 */
-				scontrol->comp_data_dirty = true;
-				break;
+					 "%s: no space for data in %s (%u, %zu)\n",
+					 __func__, scontrol->name, msg_data->num_elems,
+					 scontrol->max_size - sizeof(*data));
+			} else {
+				memcpy(data->data, msg_data->data, msg_data->num_elems);
+				data->size = msg_data->num_elems;
+				scontrol->size = sizeof(*cdata) + sizeof(*data) + data->size;
+			}
+		} else {
+			for (i = 0; i < msg_data->num_elems; i++) {
+				u32 channel = msg_data->chanv[i].channel;
+
+				if (channel >= scontrol->num_channels) {
+					dev_warn(sdev->dev,
+						 "Invalid channel index for %s: %u\n",
+						 scontrol->name, i);
+
+					/*
+					 * Mark the scontrol as dirty to force a refresh
+					 * on next read
+					 */
+					scontrol->comp_data_dirty = true;
+					break;
+				}
+
+				cdata->chanv[channel].value = msg_data->chanv[i].value;
 			}
-
-			cdata->chanv[channel].value = msg_data->chanv[i].value;
 		}
 	} else {
 		/*
-- 
2.52.0


