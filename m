Return-Path: <stable+bounces-91825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3C9C07CC
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261C2B237DE
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C82101AE;
	Thu,  7 Nov 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4uriV7R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0620EA3C;
	Thu,  7 Nov 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986996; cv=none; b=doiFvLAQoZ+zhk9Qc7Zqqg0SMqA1JDhCyQG0woWIm8bRZFxh/9nbkj2/4sii0L7Wey74ZLPHofjRkrwewQFU3Gi/lasqmJE0RIF5rSm9X9gSNUuFZPG2jlAs66+CH3p63FPKGpEKtzdcUs4vNq0GRjK6YiwWvlX3b0S6yUyV59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986996; c=relaxed/simple;
	bh=ny3OTEwMNeFJZnyUrGXZzNkltCMnSYkuaDnuh0n+10M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnGpghcwL5uUcgLWcMpSgNeTsIKT8wjlLFOK/UFbo4S6xkascZtkb7OduziBfhjVQVAh3LfkM+Q1I2KLn1FasFFoPqVrR7gOYSm+ejByw4LonVqWj1cnThadaHtwZ+lKhhUhJRfiFBm3MmCXzQQQosCQ1W0kJ+/8jTE4hVP8NWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4uriV7R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730986995; x=1762522995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ny3OTEwMNeFJZnyUrGXZzNkltCMnSYkuaDnuh0n+10M=;
  b=k4uriV7RH5kI2urtow6KdDle+MzM2v821LOXVVUZaEiEYYm96VyTl4Dy
   RtxI0rMnP2P9ar6hgmL5NUmeY5DmQ0VeyYno2KmyIRLPUh5Qzy9kUShur
   vpMmSd1zLSp54iqPMd+s/7Qdb+/yjek0GIMvWKEySBklxIdQwWHpODOpI
   VSL7pu1f7TW3GHdjhG63O2YdIfPxVWidX1v/t26FtX6FNxe5Mx1i+IQKy
   Sje9Owo5h/ZnGBlfV5lSXJqyeUX8SG3Mw29ndYFsKmixD2mH5jlKeP3Xb
   soN8Ztt3EzFVmvQ3gb4MDU6gCH3PxX+spZejCMv7GFFlpst0x3aN2q4lk
   Q==;
X-CSE-ConnectionGUID: 0WQ6oSWDSVC0Iv9CwyFy5g==
X-CSE-MsgGUID: 6GwNCSkWTZeE5ol2mD2CQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34522530"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34522530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:43:15 -0800
X-CSE-ConnectionGUID: nGrVKZIBRReXyTmOZoFCxQ==
X-CSE-MsgGUID: F2GLIvRgRle5GROrm8rFRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="115920690"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:43:11 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] ASoC: SOF: Correct sps->stream and cstream nullity management
Date: Thu,  7 Nov 2024 15:43:06 +0200
Message-ID: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- Cc stable

The nullity of sps->cstream needs to be checked in sof_ipc_msg_data()
and not assume that it is not NULL.
The sps->stream must be cleared to NULL on close since this is used
as a check to see if we have active PCM stream.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
  ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close

 sound/soc/sof/pcm.c        | 2 ++
 sound/soc/sof/stream-ipc.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.47.0


