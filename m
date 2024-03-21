Return-Path: <stable+bounces-28554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E18859A1
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540FFB21BAC
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05F84A23;
	Thu, 21 Mar 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBFaIvNH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726484037;
	Thu, 21 Mar 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026514; cv=none; b=rj1TvxKpa8ckiyHoe9pRHTFFFJgbdc+uuqsZYWky/PLNosk2WVc/T5a8z9LlGapk8TVjvMh5a17MdrxWcWVLXztP/Vuc4Mr/SkZJeN23zDJayGBmJW4I1V/TbuA2n7R3Igm8qXECn+aweTKiSXaJLlx4lhkzI8IUklOq37nBJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026514; c=relaxed/simple;
	bh=ag0JIV67bs31FLKSXc8PjvmSXq8lcFv62XJR/GCooBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoMwF1HM30Yh1MBF57KfsbwJnxoHs6O5nenypzpJ15OxxIiISFVgEfhkIWObxxZ5mYurKDPX4v169T1r4ukg38ECVISVtiCM/QdPtkV09THrsZrYPMlSx1kb8hiixwJiPmciUBDgDa4RovkA7TAWOPfm+JmxWT4W7bNf5Zuw8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBFaIvNH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026513; x=1742562513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ag0JIV67bs31FLKSXc8PjvmSXq8lcFv62XJR/GCooBA=;
  b=TBFaIvNHtqQHb9pfX6dB2ny6EQiY+x8+uKHNwA+f1g/YbtEYVHkQLiQs
   OF44a50Qmm3vJkH8gl0NDstB5Jeo89hJjoARC7Aut44YDSaTQ04irXS/j
   x0m0mOVq6GuazYW1WMk9MW4nFgJXfcEXEti6R8wEMMyPK0QwMwHYFgHhB
   PeGSCqO/FvGMSs+hLnz+pNIGvWBa0PkMH5WUi+Rsuup8zjH+6KSFYPEwW
   A8DOK3W5izLVQ1rhMiGvvgquv3KuX/ZFy8RT3loJ4B8f9tghHiGyFx1Iw
   FD6Rv4N3gLjM4tWE5VCJjlR0kzgdFR6G4xIoucGTmAMST1TUEBncTGmMF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127245"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923293"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:20 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 13/17] ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED state
Date: Thu, 21 Mar 2024 15:08:10 +0200
Message-ID: <20240321130814.4412-14-peter.ujfalusi@linux.intel.com>
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

When the final state is SOF_IPC4_PIPE_PAUSED, it is possible that the
stream will be restarted (resume or start) in which case we need to update
the offset from the firmware.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 4e41b16d3205..905dbc4852b1 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -437,8 +437,19 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	}
 
 	/* return if this is the final state */
-	if (state == SOF_IPC4_PIPE_PAUSED)
+	if (state == SOF_IPC4_PIPE_PAUSED) {
+		struct sof_ipc4_timestamp_info *time_info;
+
+		/*
+		 * Invalidate the stream_start_offset to make sure that it is
+		 * going to be updated if the stream resumes
+		 */
+		time_info = spcm->stream[substream->stream].private;
+		if (time_info)
+			time_info->stream_start_offset = SOF_IPC4_INVALID_STREAM_POSITION;
+
 		goto free;
+	}
 skip_pause_transition:
 	/* else set the RUNNING/RESET state in the DSP */
 	ret = sof_ipc4_set_multi_pipeline_state(sdev, state, trigger_list);
-- 
2.44.0


