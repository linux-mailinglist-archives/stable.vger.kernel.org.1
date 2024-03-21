Return-Path: <stable+bounces-28549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1C88599B
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BAB281EBA
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4984A39;
	Thu, 21 Mar 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX8ScXxK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D484A3B;
	Thu, 21 Mar 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026490; cv=none; b=gbSA3yEuARfldlWD//Gz5thX8K5grscHmVBGh6ylBYOfxUaDGMBop8OBXI/ZnFV6NuB+yd4GC/kuMBYoxl30DJ3BYvB3uwyYSY+pxc5hDmC/neHYvfbetpZn62wxbC0w6LODcg3dOGIIJAXtCrbcqY+r9yGHQDmUs62tTZIAJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026490; c=relaxed/simple;
	bh=TZdsdXoAw/13E4WhiE46hTl6gmBb7N9zsJKwRo+rOdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGLr8iV+pU/TkhDD8oX4frfP5n2NlvyTHr4Zn+4SiUDue9YOMY3ohQXeB1SNm3JirndEBT+RmhiuS95W3KMjG2zQmTR4rEdRlZovLZCEALZl2plHxtK9Gm/DFRjhKbWNhyh3r24bCII4dNQAtyUp844tjoaaVUQ6jwawpIs/NXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX8ScXxK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026489; x=1742562489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZdsdXoAw/13E4WhiE46hTl6gmBb7N9zsJKwRo+rOdo=;
  b=hX8ScXxK4w6hax+qd3PlB91VeDbT081PQhieX5PiFpEj+JesxzBC9GYZ
   La2+J6TSATfy7qsTA6nZSq2vqk0NJl3/hzcL5TNU0NggKoPSSDQah5Gxb
   5yxadF09yp7SSPh5K8fxV9gQGR67pNevharhRnw0MQcYEcH5oSzyE4F37
   JNPPDTdVLy7VQJ+xRw6LdeHgx16jkYU5+FBWLwxJTyKqMB8n5AtF9VsJA
   u2cPoqebeaTgjm0I7y/OY64I/qUZQGZmi8DP5SU6H+7pkuamle9BQpSIl
   VuA+rqmkBS8DU9l2N8AG3556FFUbClZ1gKj06CIqSGaHKZvdLpp1L5+jm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127198"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923260"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:07 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 08/17] ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() for pcm_delay
Date: Thu, 21 Mar 2024 15:08:05 +0200
Message-ID: <20240321130814.4412-9-peter.ujfalusi@linux.intel.com>
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

Switch to the new callback to retrieve the DAI (link) frame counter.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 0f332c8cdbe6..d0795f77cc15 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -897,11 +897,12 @@ static snd_pcm_sframes_t sof_ipc4_pcm_delay(struct snd_soc_component *component,
 	}
 
 	/*
-	 * HDaudio links don't support the LLP counter reported by firmware
-	 * the link position is read directly from hardware registers.
+	 * If the LLP counter is not reported by firmware in the SRAM window
+	 * then read the dai (link) position via host accessible means if
+	 * available.
 	 */
 	if (!time_info->llp_offset) {
-		tmp_ptr = snd_sof_pcm_get_stream_position(sdev, component, substream);
+		tmp_ptr = snd_sof_pcm_get_dai_frame_counter(sdev, component, substream);
 		if (!tmp_ptr)
 			return 0;
 	} else {
-- 
2.44.0


