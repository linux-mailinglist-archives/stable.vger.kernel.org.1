Return-Path: <stable+bounces-28550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11EB88599C
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD53281EBA
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5684A53;
	Thu, 21 Mar 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3BlWwnv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3448405F;
	Thu, 21 Mar 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026493; cv=none; b=qf/BInQg1NO+bkpHpQXEFSqvrV7SbED0BLuqD2UzjANb5ijrl1PThT5dRee6YdNZnJqEc721JVJkSE/QzM5GkA1EdKE02QNJaHXRZjL/i7QCLhGeqGnCbrw7GBZpHYWpAtJGBNM8M/OyQJFwwZkdtlHyiOi1bi1H2+VkLEXnfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026493; c=relaxed/simple;
	bh=qAqVG6/p3SmMmut5kfgrxNRTvsQcb5fMbJw2tj3c5ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRCggovJ1N+Wz0iHDeHTKaaw48DrQtpebbNS5TsYwTDPMDRMoqm1zj0BxOVrpsUqUOF42VWjRfZOmrqbeM3d8qPRxj6U0E1Q/SjVaCHQoIjPuRoi/nNF7U2hgau89NuGoLnGDQ+v7isLhXvlOAP/U5F12jFW84Z54tRVfhBKWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3BlWwnv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026492; x=1742562492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qAqVG6/p3SmMmut5kfgrxNRTvsQcb5fMbJw2tj3c5ew=;
  b=S3BlWwnvvCbTJoVXhcsIZYFZAJ7V5lzEWYMM5IuhRM2x24AFZUwWDIQt
   HPifZbqZgAx+xwj9UHgxgiLZofSs6R9mjQcMnFdBDfIEm7e+s9F0qnNMp
   0K4KkbfwRlIA0McAV0jQTXE4PyiYe2SE9rV4x3QTD5dyVy/SfUEiHQ1rl
   ZLF2PajjYOgpJTazezUERgUtQRlXqI0373E1ils0zrgq6heO3wQUPLZBY
   oDiMboP+3dgO4UBC9rgLROdhbsGscj0/VvHs3cgo8wlMvJTi9hIE/783R
   sKnUUBVJKJqeb2JDIHc+uEIko9ApZ9URF+n1mNg56dMQ7q/j2BSwIWlh+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127208"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127208"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923263"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:09 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 09/17] ASoC: SOF: Intel: hda-common-ops: Do not set the get_stream_position callback
Date: Thu, 21 Mar 2024 15:08:06 +0200
Message-ID: <20240321130814.4412-10-peter.ujfalusi@linux.intel.com>
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

The get_stream_position has been replaced by get_dai_frame_counter, it
should not be set to allow it to be dropped from core code.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-common-ops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index 4d7ea18604ee..d71bb66b9991 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -57,7 +57,6 @@ struct snd_sof_dsp_ops sof_hda_common_ops = {
 	.pcm_pointer	= hda_dsp_pcm_pointer,
 	.pcm_ack	= hda_dsp_pcm_ack,
 
-	.get_stream_position = hda_dsp_get_stream_llp,
 	.get_dai_frame_counter = hda_dsp_get_stream_llp,
 	.get_host_byte_counter = hda_dsp_get_stream_ldp,
 
-- 
2.44.0


