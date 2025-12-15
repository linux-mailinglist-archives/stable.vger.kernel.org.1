Return-Path: <stable+bounces-201057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED40CBE493
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B073305E72F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E230DEC0;
	Mon, 15 Dec 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOzsmeLi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE71DE3DF;
	Mon, 15 Dec 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808720; cv=none; b=VsnmgeIE+Nw9zz1rCRCyKLAbCBwx7Qpq4bjHrA/980LPcMlqHbvqcAel8mwKPP3cpcxfppJPhZ4u7NeUb7Zz7UpHlFJ5j62tkroPmgse4WXgjuKzYF1F9rFveU/0IE9f8a762T2pEBmhjxHrBdZqoYAYQsQV6P3cQmLlFXXI3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808720; c=relaxed/simple;
	bh=rE3Ks+YCu+J7Dp7YeegytlmkFJ843FJebBEQD/mls7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uepE/bA4SYpAKBrJd2HLxF+3ftAskKVwOTiTAa+ZJxrVNs2qvgBL9vNEa8TC6EGtv+WXKzt1bb4LofOHfRwFsuurh38VC1yP0d6l8aAg2reb9lr3hu2RMbVBy3CFGfKtOvd0rPnMr+fVxuDsGKcKwEetwfr2KzFkdh3VUxliPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOzsmeLi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808719; x=1797344719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rE3Ks+YCu+J7Dp7YeegytlmkFJ843FJebBEQD/mls7o=;
  b=VOzsmeLi7Zugcb5/LXpbv2w2m8QjA6pCQ9Kq+ky0me0LIkWMdC41JaMS
   V07oWQzSxkQF9cyXfn3mb+nTpRvg/smQFHYzNXLCpCBQUhd81DTbtqNvZ
   iANM9czizfUHGJqbyScbHmlTqMfM8rl2zHX88Wb0O6ru3BdErJe2dhsML
   h+vPzAsdgWfdzHx8vBcHrZBmm5t/OAU9BHqBkHSRs81y+KfFbbWuDKsz7
   Jc6rMMNNfxVIYMnsuHGubxQyae0BHG3qmC9/FFth6TO6kUK5r9B9X34OK
   gNyTBGo52WtiwBzM3T/PxemaKTAAhkd+J5wuP2HKxsGzcyk8znhTFSgDR
   A==;
X-CSE-ConnectionGUID: fD3Wm+faTfOERJm/IfvqcA==
X-CSE-MsgGUID: 7CfjvzzKRsywMEf6TlT7Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866481"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866481"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:18 -0800
X-CSE-ConnectionGUID: 6i9R/MH2S++2aOtWtun1IA==
X-CSE-MsgGUID: XxFUzbjdRvu+phbEp46R1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362527"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:15 -0800
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
Subject: [PATCH v2 8/8] ASoC: SOF: ipc4-control: Add support for generic bytes control
Date: Mon, 15 Dec 2025 16:25:16 +0200
Message-ID: <20251215142516.11298-9-peter.ujfalusi@linux.intel.com>
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


