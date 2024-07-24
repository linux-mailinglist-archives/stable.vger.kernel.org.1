Return-Path: <stable+bounces-61254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85BE93ADE1
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728A81F21396
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07514A606;
	Wed, 24 Jul 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkXNC+4p"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28467AD23;
	Wed, 24 Jul 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809123; cv=none; b=h4fIWjMlqYLIl2oCMLjQjroi+hRsZnp6UFfvkh0KSmbAGTLiegTU/0tCcDE/Qu0zICEfSxx/r6VD+wBf6lADfpHGwAdAU05+2tUnKqSpjT35PtfnN5dlMscWs6xoo8G3ddIuSrNvr5ZK1BS+H4QNEy3SveFt4y6qbV0wJ4aF0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809123; c=relaxed/simple;
	bh=dqQHkxF05tB3TmiieXCGAuWu0V/uXuhTF6SPvMaJwqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lagYAw1B8YwXxtJRq1UoCIPaK+8wLQOlae0yQ3bbny8LU9JFKtl2iiN5XEALc5RCY+8JPjGh7IOKX5rfeSUCuIWI2L11V1R/EtFPuGbgEhxJlpMo/l46QKB2axHYGnvFqxAPupPLXnTQWteumVPsK6Xq20nsF/mIowYy+5U3rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkXNC+4p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721809122; x=1753345122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dqQHkxF05tB3TmiieXCGAuWu0V/uXuhTF6SPvMaJwqA=;
  b=mkXNC+4pggMCTwRtDUmer6q69Sk6kV8cFa8Yemd6tds9Z9IGwRyBANSG
   4SmPTogb5wtWU6QNqW19ALfevkJrsLAImxSRleClzF6sL5gg1Mm4rgJlR
   /qjNmPfJAuijyB2Mq+BEC56VbaUUiolkMSuaHCHoEJ7YVocx7l7wYwVIb
   4QcbAcUMtTB1dkm4oKv0uHlmjR2pEXEY4EmzuCbWjqZOr0C70JEAb/lIc
   wO5BckX6Wpxnx1I1FDJ19Tnt3qbMNH83DBzc4SjioqCzEoRgHTRL/B8E+
   vvkVHvuk+qhqguQgsQzd3/K1qn30fP77Ce1yrubk1/dyDlLo93oKChL9o
   w==;
X-CSE-ConnectionGUID: 6dqjPPo/Ray4SbHpbwgwKA==
X-CSE-MsgGUID: cTvs0agVT/KFlKalRzEO9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19166176"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19166176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:18:41 -0700
X-CSE-ConnectionGUID: P/nyfodXSweqZhcnoN6GAg==
X-CSE-MsgGUID: HM5esxDoT86B4U/bBRQonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52221749"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.68])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:18:39 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH fro 6.11 0/2] ASoC SOF: ipc4-topology: Fix LinkID handling for ChainDMA
Date: Wed, 24 Jul 2024 11:19:30 +0300
Message-ID: <20240724081932.24542-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A recent patch available in 6.10 [1] uncovered two issues on how the DMA Link ID
is tracked with ChainDMA and can cause under specific conditions [2] to cause a DSP
panic.
The issue is not academic as we have one user report of it:
https://github.com/thesofproject/linux/issues/5116

The patches have been marked for stable backport to made there way to 6.10.

The first patch is fixing a code move patch, for older than 6.9 we would need
different patch to fix the original code, but since the issue is only valid for
6.10, I will do that at a later time.

Mark, can you please schedule these as fixes for 6.11 to get them fast to 6.10?
Thank you.

[1] ebd3b3014eeb ("ASoC: SOF: pcm: reset all PCM sources in case of xruns")
[2] https://github.com/thesofproject/linux/pull/5119#issuecomment-2244770449

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: ipc4-topology: Only handle dai_config with HW_PARAMS for
    ChainDMA
  ASoC: SOF: ipc4-topology: Preserve the DMA Link ID for ChainDMA on
    unprepare

 sound/soc/sof/ipc4-topology.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.45.2


