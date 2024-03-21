Return-Path: <stable+bounces-28553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA588599F
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA573281B54
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C0283CD8;
	Thu, 21 Mar 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrOY9kvM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8283CAA;
	Thu, 21 Mar 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026512; cv=none; b=NEk7s64rZvQqRKITVLpTBLUVMXvYqEQfTEPOpw5OtZO6jBuXgJVuIDFDcnI5RELkq1c9XGGFsXeqMOw/PW8iOh9234nIinED6QGY+oSM9fIe897eiPiDRQrW1uUCKKLaWhhz7ghZeG8ZDcRmCZNyyc5y0fPgwpLlW4CUxCaQXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026512; c=relaxed/simple;
	bh=ShrF7sHx25wi7uEqY30EhT0ukgENpLvl92FeufXyLZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXHSLz3cj+XfEFzzV7O+q+w1eQf6qPoE2MfUQQGr8R/YC3nSh0mYwDY4HkS/LKMMx2JVwVbTYmIt2D9QF0YT77IdYxfwiLQ2+6LnpPE8D6EEtscOrC8bhzV2aP8eFfyp5Mh4x/vs8I82LYejqaEajhb1J58aqhJQ5B4SBV1UgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrOY9kvM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026511; x=1742562511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ShrF7sHx25wi7uEqY30EhT0ukgENpLvl92FeufXyLZg=;
  b=YrOY9kvMyeHVqCbW73JMioqs/Ab2uv6UAihH4GUCydvaZDC8vYq0zv7t
   yTWajGVYk2Ttu1nRki2DtGvI350DSMSjkKu0bnOZ32gB0KCQ3Y8p8zapW
   XA3CWDmYhrZK01PUAvKOog4od9JNLS/XTNyry3FhSY+Fir+/G1LZg/o8z
   mHYwpZhA31c5Yv+SEeFinHvuouSY5o22wGK0ZwymGih4yVFVRHYtAh1Oy
   tf3+oPKs0YLDZXTVww+VtWMHFqVG9qRcXIozRDtfSUCy4K0XYKeajpkTJ
   7Z0cff4zD+8JCASDrT8O+ZAuDVocpXJh25v/0JxfxZphDagPlzsk9FpQb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127234"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923282"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:17 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 12/17] ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in pcm_trigger
Date: Thu, 21 Mar 2024 15:08:09 +0200
Message-ID: <20240321130814.4412-13-peter.ujfalusi@linux.intel.com>
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

The SNDRV_PCM_TRIGGER_PAUSE_PUSH does not need to be a separate case, it
can be handled along with STOP and SUSPEND

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 2d7295221884..4e41b16d3205 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -478,14 +478,12 @@ static int sof_ipc4_pcm_trigger(struct snd_soc_component *component,
 
 	/* determine the pipeline state */
 	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		state = SOF_IPC4_PIPE_PAUSED;
-		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
 		state = SOF_IPC4_PIPE_RUNNING;
 		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		state = SOF_IPC4_PIPE_PAUSED;
-- 
2.44.0


