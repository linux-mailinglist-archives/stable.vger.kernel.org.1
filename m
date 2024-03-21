Return-Path: <stable+bounces-28552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D688599E
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F1FB21779
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B8084A56;
	Thu, 21 Mar 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJrbL8HR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676D84A40;
	Thu, 21 Mar 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026498; cv=none; b=SLqZmq7H75aESWnfjdPVd0dvTF3NxrnstM87sAOqXX09yIHFJhNzx384Tc00xks/qR62y5SF54LPsQcYkzxRThtLD/7kbS/KB+DzWDelMYFlN80TFI5nlw1GJkPtMchEaQmkIzcQ85XiPM+GCwEo5/Vvex8htww9K8O3eEzZ+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026498; c=relaxed/simple;
	bh=o4jhy8ONO83uP8a6i+oWSqaYYz50PiC32ZZvWTPeOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOf/qTZ+h8jTGcjGJ1jJ9iIJPWD1JQFmiqUseuc2Z+6AfbaZ5z+L+f/Y4syTQeCpSB+Fb2QlAY+sk8nIyvyBu6VmMGtPkwMZcbmEeIoUL3mVaHGyi4NXAkO+7eWzKCZXv1y9jIq5HHugTIrRrd6f+4v9eRGViTDbr+RrYe2KSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJrbL8HR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026497; x=1742562497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4jhy8ONO83uP8a6i+oWSqaYYz50PiC32ZZvWTPeOMc=;
  b=iJrbL8HRicik1nteyRNbudGBHTGrWBnJgqSsF1NkirBYJ7OlqZuGkzOx
   iNhRrZzbYRGM5Vkl+rNBPo9wzzXnhbiLRGySsdFUeDVDMNtPeOmnnUFRk
   p0N1m7+TLpwfFbL0wXeRzTF+vXQWI4U6yF7F7g9LZs2JnpDB8fYyF+baD
   BuhlYoUbtBLfQByU3KM83j9yPW/G/FElo4Q7Cc1nWwIDhM6VJjsCh7snV
   vD5D467X+BusHEx1f70cmt7mzzE1+oCyk/KJ/46s9fvUMrY/gBBA60ebh
   4eBD9iX/AhRc/4MDrvFnPLV3KwQLYGGPXHKf0TkHUL6sYrJHsoMFwgAyR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127225"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923273"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:14 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 11/17] ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info definition locally
Date: Thu, 21 Mar 2024 15:08:08 +0200
Message-ID: <20240321130814.4412-12-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
References: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sof_ipc4_timestamp_info is only used by ipc4-pcm.c internally, it
should not be in a generic header implying that it might be used elsewhere.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c  | 14 ++++++++++++++
 sound/soc/sof/ipc4-priv.h | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index d0795f77cc15..2d7295221884 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -15,6 +15,20 @@
 #include "ipc4-topology.h"
 #include "ipc4-fw-reg.h"
 
+/**
+ * struct sof_ipc4_timestamp_info - IPC4 timestamp info
+ * @host_copier: the host copier of the pcm stream
+ * @dai_copier: the dai copier of the pcm stream
+ * @stream_start_offset: reported by fw in memory window
+ * @llp_offset: llp offset in memory window
+ */
+struct sof_ipc4_timestamp_info {
+	struct sof_ipc4_copier *host_copier;
+	struct sof_ipc4_copier *dai_copier;
+	u64 stream_start_offset;
+	u32 llp_offset;
+};
+
 static int sof_ipc4_set_multi_pipeline_state(struct snd_sof_dev *sdev, u32 state,
 					     struct ipc4_pipeline_set_state_data *trigger_list)
 {
diff --git a/sound/soc/sof/ipc4-priv.h b/sound/soc/sof/ipc4-priv.h
index f3b908b093f9..afed618a15f0 100644
--- a/sound/soc/sof/ipc4-priv.h
+++ b/sound/soc/sof/ipc4-priv.h
@@ -92,20 +92,6 @@ struct sof_ipc4_fw_data {
 	struct mutex pipeline_state_mutex; /* protect pipeline triggers, ref counts and states */
 };
 
-/**
- * struct sof_ipc4_timestamp_info - IPC4 timestamp info
- * @host_copier: the host copier of the pcm stream
- * @dai_copier: the dai copier of the pcm stream
- * @stream_start_offset: reported by fw in memory window
- * @llp_offset: llp offset in memory window
- */
-struct sof_ipc4_timestamp_info {
-	struct sof_ipc4_copier *host_copier;
-	struct sof_ipc4_copier *dai_copier;
-	u64 stream_start_offset;
-	u32 llp_offset;
-};
-
 extern const struct sof_ipc_fw_loader_ops ipc4_loader_ops;
 extern const struct sof_ipc_tplg_ops ipc4_tplg_ops;
 extern const struct sof_ipc_tplg_control_ops tplg_ipc4_control_ops;
-- 
2.44.0


