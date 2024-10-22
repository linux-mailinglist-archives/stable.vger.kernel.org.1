Return-Path: <stable+bounces-87683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F529A9BA3
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93A71C21413
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2D1547E3;
	Tue, 22 Oct 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eH+pqGem"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B3155330
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583915; cv=none; b=SHC2K7Mc9RTk2543YohrB8Wk8lD16WvfnljXW8q7mGcQxzvJbQgXkwG8wmfhdbq0NDGqo+1LUPTakC3PLBgVgp68MhWriY6Qc36KUT46Keal8WOg6ZabX/JqY8AKa9d2l+fj8tnhyCKx/X1TZxzzl8X65hHd0UoLuAcGc7atOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583915; c=relaxed/simple;
	bh=lTeE1UIRfFH8YAqr+4u3CG+9B/nuNI9gKmA6v3/EVv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSkL7nVM0IKXszKHKsFxhaJSor4srd0BpGHtApHwL8r20qfct4QPAOKM3FEhTFVKVjUhg5h7hbgyCYa+A7N2J5Xx6Irjblr0KeQK2xCbXniyCPyS/mPFgmZqOgJyTOm+eTYBAdUM8K2fOts8tH7HXOBDSj1Rftgv1s5X53lvNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eH+pqGem; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583913; x=1761119913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTeE1UIRfFH8YAqr+4u3CG+9B/nuNI9gKmA6v3/EVv4=;
  b=eH+pqGemhl+EktNMdGMBt+Tkzd1d0GxQqv5XzXqocFVey+BdzaOzPvM+
   F1NDZK9uLVUBmLZzVMSpCzP5cuS8Uql8vAAmF+kVPxndXG6RPbfMLLCCG
   T4TBa5a9lZoUR4jKdfQTWaEIZPryHBpZoDZFuYp/lVSuY/XvvbqJNgNb3
   qxoUyTnkJr7TauwcnIBdeqi3ciEz6pgoRDZQ4ODm8DqLAqwpq4mrNNfQZ
   vNfNYVyXmAINuJiTyBuKxJ3F6VMbWDJj3eNluwUO5qAY4PlLqlGXjtPpa
   3b5z9DFyYbZwc5Khc0GQjySD4g6DuWdJ1u4Xw3LSYkTIohcVvDqsJ1plX
   g==;
X-CSE-ConnectionGUID: RQlkltHISR+EiDbvhGc5uw==
X-CSE-MsgGUID: VS/HVjgqR2aHHRpUDj4eDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="46587877"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="46587877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:33 -0700
X-CSE-ConnectionGUID: RlYdbdsDRre/un0Mcqq2TA==
X-CSE-MsgGUID: hep+V1GfTeq71UNuWqYvHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79954814"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:30 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH stable-6.6.x 3/3] ASoC: SOF: ipc4-control: Add support for ALSA enum control
Date: Tue, 22 Oct 2024 10:58:52 +0300
Message-ID: <20241022075852.21271-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022075852.21271-1-peter.ujfalusi@linux.intel.com>
References: <20241022075852.21271-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 07a866a41982c896dc46476f57d209a200602946 upstream.

Enum controls use generic param_id and a generic struct where the data
is passed to the firmware.

Stable 6.6.y note:
Fixes NULL dereference on Meteor Lake platforms with new SOF release
due to the use of Swithc/Enum controls.
Link: https://github.com/thesofproject/sof/issues/9600

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230919103115.30783-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 6.6.x
---
 sound/soc/sof/ipc4-control.c  | 64 +++++++++++++++++++++++++++++++++++
 sound/soc/sof/ipc4-topology.c | 33 ++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 44e11be83482..b4cdcec33e12 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -297,6 +297,63 @@ static int sof_ipc4_switch_get(struct snd_sof_control *scontrol,
 	return 0;
 }
 
+static bool sof_ipc4_enum_put(struct snd_sof_control *scontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+	struct snd_soc_component *scomp = scontrol->scomp;
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
+	struct snd_sof_widget *swidget;
+	bool widget_found = false;
+	bool change = false;
+	unsigned int i;
+	u32 value;
+	int ret;
+
+	/* update each channel */
+	for (i = 0; i < scontrol->num_channels; i++) {
+		value = ucontrol->value.enumerated.item[i];
+		change = change || (value != cdata->chanv[i].value);
+		cdata->chanv[i].channel = i;
+		cdata->chanv[i].value = value;
+	}
+
+	if (!pm_runtime_active(scomp->dev))
+		return change;
+
+	/* find widget associated with the control */
+	list_for_each_entry(swidget, &sdev->widget_list, list) {
+		if (swidget->comp_id == scontrol->comp_id) {
+			widget_found = true;
+			break;
+		}
+	}
+
+	if (!widget_found) {
+		dev_err(scomp->dev, "Failed to find widget for kcontrol %s\n", scontrol->name);
+		return false;
+	}
+
+	ret = sof_ipc4_set_generic_control_data(sdev, swidget, scontrol, true);
+	if (ret < 0)
+		return false;
+
+	return change;
+}
+
+static int sof_ipc4_enum_get(struct snd_sof_control *scontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+	unsigned int i;
+
+	/* read back each channel */
+	for (i = 0; i < scontrol->num_channels; i++)
+		ucontrol->value.enumerated.item[i] = cdata->chanv[i].value;
+
+	return 0;
+}
+
 static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 				       struct snd_sof_control *scontrol,
 				       bool set, bool lock)
@@ -562,6 +619,11 @@ static int sof_ipc4_widget_kcontrol_setup(struct snd_sof_dev *sdev, struct snd_s
 				ret = sof_ipc4_set_get_bytes_data(sdev, scontrol,
 								  true, false);
 				break;
+			case SND_SOC_TPLG_CTL_ENUM:
+			case SND_SOC_TPLG_CTL_ENUM_VALUE:
+				ret = sof_ipc4_set_generic_control_data(sdev, swidget,
+									scontrol, false);
+				break;
 			default:
 				break;
 			}
@@ -605,6 +667,8 @@ const struct sof_ipc_tplg_control_ops tplg_ipc4_control_ops = {
 	.volume_get = sof_ipc4_volume_get,
 	.switch_put = sof_ipc4_switch_put,
 	.switch_get = sof_ipc4_switch_get,
+	.enum_put = sof_ipc4_enum_put,
+	.enum_get = sof_ipc4_enum_get,
 	.bytes_put = sof_ipc4_bytes_put,
 	.bytes_get = sof_ipc4_bytes_get,
 	.bytes_ext_put = sof_ipc4_bytes_ext_put,
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index cea8beb5ceb5..c380ddf68a58 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2148,6 +2148,36 @@ static int sof_ipc4_control_load_volume(struct snd_sof_dev *sdev, struct snd_sof
 	return 0;
 }
 
+static int sof_ipc4_control_load_enum(struct snd_sof_dev *sdev, struct snd_sof_control *scontrol)
+{
+	struct sof_ipc4_control_data *control_data;
+	struct sof_ipc4_msg *msg;
+	int i;
+
+	scontrol->size = struct_size(control_data, chanv, scontrol->num_channels);
+
+	/* scontrol->ipc_control_data will be freed in sof_control_unload */
+	scontrol->ipc_control_data = kzalloc(scontrol->size, GFP_KERNEL);
+	if (!scontrol->ipc_control_data)
+		return -ENOMEM;
+
+	control_data = scontrol->ipc_control_data;
+	control_data->index = scontrol->index;
+
+	msg = &control_data->msg;
+	msg->primary = SOF_IPC4_MSG_TYPE_SET(SOF_IPC4_MOD_LARGE_CONFIG_SET);
+	msg->primary |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
+	msg->primary |= SOF_IPC4_MSG_TARGET(SOF_IPC4_MODULE_MSG);
+
+	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_ENUM_CONTROL_PARAM_ID);
+
+	/* Default, initial value for enums: first enum entry is selected (0) */
+	for (i = 0; i < scontrol->num_channels; i++)
+		control_data->chanv[i].channel = i;
+
+	return 0;
+}
+
 static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_control *scontrol)
 {
 	struct sof_ipc4_control_data *control_data;
@@ -2222,6 +2252,9 @@ static int sof_ipc4_control_setup(struct snd_sof_dev *sdev, struct snd_sof_contr
 		return sof_ipc4_control_load_volume(sdev, scontrol);
 	case SND_SOC_TPLG_CTL_BYTES:
 		return sof_ipc4_control_load_bytes(sdev, scontrol);
+	case SND_SOC_TPLG_CTL_ENUM:
+	case SND_SOC_TPLG_CTL_ENUM_VALUE:
+		return sof_ipc4_control_load_enum(sdev, scontrol);
 	default:
 		break;
 	}
-- 
2.47.0


