Return-Path: <stable+bounces-28542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DFE885994
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE890B21666
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15884A38;
	Thu, 21 Mar 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyQfpr/v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547D84A30;
	Thu, 21 Mar 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026472; cv=none; b=e1yDggLkgWIe2fP4B5L7EXJjKauTU+lXThAIWWvZWPjNcoEOtzVnrE91vFGsexq3FRawEoPw4Hg7ox9lMDRQxUrseBHVDm9e93TZBBdnv14i1KLqq6HuvMBwl0+thTBT6C1kKKruQZgW1ksNLfszYy4F9IL15acrhGYTf3JG2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026472; c=relaxed/simple;
	bh=PQ+RCCDlc8CStyeXFRt+KJPHM6NMji1fGK9uiRz8Wqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U49NfuMv16VlJiSOQj+4JdE4Nd8DCy7qB+v4d+yFSLHlYneE9wFtfyOfviB59fyBQaQcdAnyQ9nJz+k6QCoN0Oi6093omXBG5X3SDtXCbE4IzXxfUsP2W5/qkbdSbh2psTVFNFVnTmka1xuGKFG1FkxweQPiIxE5LUGw/wqkatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyQfpr/v; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026471; x=1742562471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQ+RCCDlc8CStyeXFRt+KJPHM6NMji1fGK9uiRz8Wqk=;
  b=OyQfpr/v5moPSu9odEswMf2wCgyASIdDZw5/sodZ2Ahh1KjZBflCnXYy
   PSnMYHWRghSv2IaJPqDkrs4FoTS1sT//FqutBHTAW7dzoHGQEX/v+U2X5
   rZEAP4x3NHZk/3BnTuFjsZGJHh8jOkdmFJaj8Q8eM6NuD/YqGsDiyKUtE
   1y6Y0d8Jm/WvGZO90dPWJ8hitQh3Bs3EXlS6yF8LJhh70fgkByUFbQpaD
   eC/ETOtaoCmNGBDffdpw+HIRrUuAG6wORpEFk5X8ENVhOvzky4jg5YCkK
   CXJxlApkCdmsB7DQGCeQCVsPViom1Zk/WdYExTk+Xp28EECSxkxK7Cw23
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127140"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127140"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923212"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:48 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 01/17] ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream
Date: Thu, 21 Mar 2024 15:07:58 +0200
Message-ID: <20240321130814.4412-2-peter.ujfalusi@linux.intel.com>
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

The dsp_max_burst_size_in_ms can be used to save the length of the maximum
burst size in ms the host DMA will use.

Platform code can place constraint using this to avoid user space
requesting too small ALSA buffer which will result xruns.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-audio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 9ea2ac5adac7..04e5cb2c70a7 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -322,6 +322,7 @@ struct snd_sof_pcm_stream {
 	struct work_struct period_elapsed_work;
 	struct snd_soc_dapm_widget_list *list; /* list of connected DAPM widgets */
 	bool d0i3_compatible; /* DSP can be in D0I3 when this pcm is opened */
+	unsigned int dsp_max_burst_size_in_ms; /* The maximum size of the host DMA burst in ms */
 	/*
 	 * flag to indicate that the DSP pipelines should be kept
 	 * active or not while suspending the stream
-- 
2.44.0


