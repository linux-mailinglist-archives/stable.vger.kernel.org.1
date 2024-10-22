Return-Path: <stable+bounces-87682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757849A9BA1
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93631F22980
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC6155326;
	Tue, 22 Oct 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dr/T0ECM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8A1547C0
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583913; cv=none; b=kQvSLtegtVVGqQZXq+VK3dbPsQxDgevMC53BbqahYP//p9sgQeCpLiWYVzJdaTMh9PizNUET2bWClpcjta5yy8DXWiZlT7wDbk1fXFoWKaQvCgeSDd+C4Wm/vC5o8FO0fSUjKfrlajdm0Tj7g8/unNcMKAtbAtkNNAo0+RUM9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583913; c=relaxed/simple;
	bh=BFYhU+BK2A51YVThwwFxK03DcYUY0Bl3O9VzC/RSMwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNtjdu9klq4y1+R+HfOZsiacpWVZ0T7WQLn3y/Gxx4Y17J/TzMK2MOUnfAMs2i4/4jJ85S6iV2HJAGzoLU/PlMKKh55EzyTVkSI6qMa46Q/9Tnu1ge6vjQHy3E6dkrCxloh6RpUWBIUT+jaCfyeCY/hUSi6lSzL06PpfLn+uLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dr/T0ECM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583911; x=1761119911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFYhU+BK2A51YVThwwFxK03DcYUY0Bl3O9VzC/RSMwQ=;
  b=Dr/T0ECMxt1sxhbieyfCUpL08gF7D+XLP3VrPDhX0UzAEu/teoCBDcEt
   F7BPoFMLCyhHN1HHXjH5jpKLolp25HOgvplgY58GAZ8LMSBy7uoY3Mn4q
   pvcifU45k/85329lOthlKOM0CzwzYYhkMiEQgbn1MGQoMAPmFZUGWIaef
   N5PkLhVOmVzEM9Lz/zCbSgk3plmuiqoCJ1k6/jVUdQBUT4cZe+OmXsySQ
   7KNDofXB6xxK+/QFwtV1bLAHi+Dec4vNwaKX0ly9Sy29ID+McXFTW8Yla
   Eck3Li8qI/ExVyidD/uR4mOsjkNP9JTeDhep0LPuId3Rtnt8EmhmKuUhc
   A==;
X-CSE-ConnectionGUID: UzS9dfjcTJ2xxd+4vvn3mQ==
X-CSE-MsgGUID: 4eF2Mtl4RsKhpia23Ls4kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="46587869"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="46587869"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:30 -0700
X-CSE-ConnectionGUID: Uy12BY+9S/KlRUor6qidPg==
X-CSE-MsgGUID: 5Y0+hx2XRPSJe2d/cTwFlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79954792"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:28 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH stable-6.6.x 2/3] ASoC: SOF: ipc4-control: Add support for ALSA switch control
Date: Tue, 22 Oct 2024 10:58:51 +0300
Message-ID: <20241022075852.21271-3-peter.ujfalusi@linux.intel.com>
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

commit 4a2fd607b7ca6128ee3532161505da7624197f55 upstream.

Volume controls with a max value of 1 are switches.
Switch controls use generic param_id and a generic struct where the data
is passed to the firmware.

Stable 6.6.y note:
Fixes NULL dereference on Meteor Lake platforms with new SOF release
due to the use of Swithc/Enum controls.
Link: https://github.com/thesofproject/sof/issues/9600

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230919103115.30783-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 6.6.x
---
 sound/soc/sof/ipc4-control.c  | 111 +++++++++++++++++++++++++++++++++-
 sound/soc/sof/ipc4-topology.c |  16 ++++-
 2 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index e4ce1b53fba6..44e11be83482 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -201,6 +201,102 @@ static int sof_ipc4_volume_get(struct snd_sof_control *scontrol,
 	return 0;
 }
 
+static int
+sof_ipc4_set_generic_control_data(struct snd_sof_dev *sdev,
+				  struct snd_sof_widget *swidget,
+				  struct snd_sof_control *scontrol, bool lock)
+{
+	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+	struct sof_ipc4_control_msg_payload *data;
+	struct sof_ipc4_msg *msg = &cdata->msg;
+	size_t data_size;
+	unsigned int i;
+	int ret;
+
+	data_size = struct_size(data, chanv, scontrol->num_channels);
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cdata->index;
+	data->num_elems = scontrol->num_channels;
+	for (i = 0; i < scontrol->num_channels; i++) {
+		data->chanv[i].channel = cdata->chanv[i].channel;
+		data->chanv[i].value = cdata->chanv[i].value;
+	}
+
+	msg->data_ptr = data;
+	msg->data_size = data_size;
+
+	ret = sof_ipc4_set_get_kcontrol_data(scontrol, true, lock);
+	msg->data_ptr = NULL;
+	msg->data_size = 0;
+	if (ret < 0)
+		dev_err(sdev->dev, "Failed to set control update for %s\n",
+			scontrol->name);
+
+	kfree(data);
+
+	return ret;
+}
+
+static bool sof_ipc4_switch_put(struct snd_sof_control *scontrol,
+				struct snd_ctl_elem_value *ucontrol)
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
+		value = ucontrol->value.integer.value[i];
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
+static int sof_ipc4_switch_get(struct snd_sof_control *scontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+	unsigned int i;
+
+	/* read back each channel */
+	for (i = 0; i < scontrol->num_channels; i++)
+		ucontrol->value.integer.value[i] = cdata->chanv[i].value;
+
+	return 0;
+}
+
 static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 				       struct snd_sof_control *scontrol,
 				       bool set, bool lock)
@@ -438,6 +534,16 @@ static int sof_ipc4_bytes_ext_volatile_get(struct snd_sof_control *scontrol,
 	return _sof_ipc4_bytes_ext_get(scontrol, binary_data, size, true);
 }
 
+static int
+sof_ipc4_volsw_setup(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget,
+		     struct snd_sof_control *scontrol)
+{
+	if (scontrol->max == 1)
+		return sof_ipc4_set_generic_control_data(sdev, swidget, scontrol, false);
+
+	return sof_ipc4_set_volume_data(sdev, swidget, scontrol, false);
+}
+
 /* set up all controls for the widget */
 static int sof_ipc4_widget_kcontrol_setup(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget)
 {
@@ -450,8 +556,7 @@ static int sof_ipc4_widget_kcontrol_setup(struct snd_sof_dev *sdev, struct snd_s
 			case SND_SOC_TPLG_CTL_VOLSW:
 			case SND_SOC_TPLG_CTL_VOLSW_SX:
 			case SND_SOC_TPLG_CTL_VOLSW_XR_SX:
-				ret = sof_ipc4_set_volume_data(sdev, swidget,
-							       scontrol, false);
+				ret = sof_ipc4_volsw_setup(sdev, swidget, scontrol);
 				break;
 			case SND_SOC_TPLG_CTL_BYTES:
 				ret = sof_ipc4_set_get_bytes_data(sdev, scontrol,
@@ -498,6 +603,8 @@ sof_ipc4_set_up_volume_table(struct snd_sof_control *scontrol, int tlv[SOF_TLV_I
 const struct sof_ipc_tplg_control_ops tplg_ipc4_control_ops = {
 	.volume_put = sof_ipc4_volume_put,
 	.volume_get = sof_ipc4_volume_get,
+	.switch_put = sof_ipc4_switch_put,
+	.switch_get = sof_ipc4_switch_get,
 	.bytes_put = sof_ipc4_bytes_put,
 	.bytes_get = sof_ipc4_bytes_get,
 	.bytes_ext_put = sof_ipc4_bytes_ext_put,
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 284efad30f1a..cea8beb5ceb5 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2127,12 +2127,22 @@ static int sof_ipc4_control_load_volume(struct snd_sof_dev *sdev, struct snd_sof
 	msg->primary |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
 	msg->primary |= SOF_IPC4_MSG_TARGET(SOF_IPC4_MODULE_MSG);
 
-	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_GAIN_PARAM_ID);
+	/* volume controls with range 0-1 (off/on) are switch controls */
+	if (scontrol->max == 1)
+		msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_SWITCH_CONTROL_PARAM_ID);
+	else
+		msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_GAIN_PARAM_ID);
 
-	/* set default volume values to 0dB in control */
 	for (i = 0; i < scontrol->num_channels; i++) {
 		control_data->chanv[i].channel = i;
-		control_data->chanv[i].value = SOF_IPC4_VOL_ZERO_DB;
+		/*
+		 * Default, initial values:
+		 * - 0dB for volume controls
+		 * - off (0) for switch controls - value already zero after
+		 *				   memory allocation
+		 */
+		if (scontrol->max > 1)
+			control_data->chanv[i].value = SOF_IPC4_VOL_ZERO_DB;
 	}
 
 	return 0;
-- 
2.47.0


