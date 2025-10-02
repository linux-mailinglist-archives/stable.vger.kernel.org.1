Return-Path: <stable+bounces-183040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D200BBB3EFF
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A91E3AEE4D
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577331079B;
	Thu,  2 Oct 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djtcmgr2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241D30DED8;
	Thu,  2 Oct 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409552; cv=none; b=Piq98CxU9Kik3nHRs/3b2nuiIfO1Lx7+tox078/35xi9MhqH1DM1KXFeojXZW9gl2bctkyTajdJcfqHIiEs7U3RfNrRNKBs2dgqPgJjk1kIPdCi81I9aY3yQ6cGc3dm5aoyAe2YIhedkbMqFcqSe9eZ/uE90kmaeMGFSXeV1BC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409552; c=relaxed/simple;
	bh=FACWBzpvG1b3ETkviRYY/WBtECv4/Sn/lUE6uIBX6Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFbMB8w/NWGDOdbychogV5lAAyxpkbXUu0c3e1NrL+S8+5UEDramdI2m7uNl7v9rOgcZ43Dq7zmgPyZ62PVar8swJClXc3n+XLu3KyZ//jNh1Pvpt1Fc3oU0hAqi/uXAgQ+n592nfwtMmtdLRLpSo8M1rA2pB7/i+auLoCYvEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djtcmgr2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759409550; x=1790945550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FACWBzpvG1b3ETkviRYY/WBtECv4/Sn/lUE6uIBX6Sg=;
  b=djtcmgr2ruprlt7aAvuAGoyBGiwGuaHC4lw3rJAbr4xxIJXZf3qfDuY0
   PrQymClBr5Tj4yVb7nua+Q5W3EvX4ydG43NW26Cv+VLVcvAkL5O8d/Mtw
   nEwpTsJQCVW7IMAH82wpxcwDl6MFzVCBjBsAbLufl4cePGGgZS39xJzfW
   y64l2lt7dmVizbC68hX1iZDcwxxKcdtWt7sX7RY/KaNwl8pHMmbarSYSf
   V6rRACRMCjkp8vsfIyEMmoCw6W8EU+DZxRaUp3RlcpKsUi5X+zIRVBZjH
   GMPkqPFjrYZopusX8eaMnd21XtLBYi6mfK22kGkwFRhr1K5Qp6Y1cS2iN
   A==;
X-CSE-ConnectionGUID: JvFrHMAORSuoYIV7d/AXXA==
X-CSE-MsgGUID: NEI1pk6EQc6NJ+zDxrE17Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61579795"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="61579795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:30 -0700
X-CSE-ConnectionGUID: 3jxDYSvyTB+06NR917O+wg==
X-CSE-MsgGUID: 3/B5TgQTSCK6SMs1fePKJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179057607"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:52:27 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer constraint
Date: Thu,  2 Oct 2025 15:53:19 +0300
Message-ID: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- SHAs for Fixes tag corrected (sorry)

The size of the DSP host buffer was incorrectly defined as 2ms while
it is 4ms and the ChainDMA PCMs are using 5ms as host facing buffer.

The constraint will be set against the period time rather than the buffer
time to make sure that application will not face with xruns when the
DMA bursts to refill the host buffer.

The minimal period size will be also used by Pipewire in case of SOF
cards to set the headroom to a length which will avoid the cases when
the hw_ptr jumps over the appl_ptr because of a burst.
Iow, it will make Pipewire to keep a safe distance from the hw_ptr.

https://github.com/thesofproject/linux/issues/5284
https://gitlab.freedesktop.org/pipewire/wireplumber/-/merge_requests/740
https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2548

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size
  ASoC: SOF: ipc4-topology: Account for different ChainDMA host buffer
    size
  ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead
    of buffer time

 sound/soc/sof/intel/hda-pcm.c | 29 +++++++++++++++++++++--------
 sound/soc/sof/ipc4-topology.c |  9 +++++++--
 sound/soc/sof/ipc4-topology.h |  7 +++++--
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.51.0


