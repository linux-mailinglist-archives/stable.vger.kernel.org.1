Return-Path: <stable+bounces-28541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA26885993
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C79B21738
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B19684A32;
	Thu, 21 Mar 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8sODEWl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093884038;
	Thu, 21 Mar 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026471; cv=none; b=jrdtTkzzKSqg0nQ3mS1AmJtkFxSEyZOZAjqYibhrdHujGzfXTgACNfOJ+piw8t7aLKQw/VFm4+iHTyiCwOlXYWc7UGu3D6mjhLVO/8dyRlXalhgQbPoYTl718xVIPlkzM1LJkx/OthkVgOKtTeP5RI1fKCEZB37C4nkse0r5ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026471; c=relaxed/simple;
	bh=lNF/nXlhxo+l9WMdwFIqQFvTQLSF/djgFb4AU2uJoaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKm2GP07BQE+nt7FR9yz0OuD1+sXSDAZ8su/XEcx871UF/Y+GQtScJZtt/nwxUFIKHYaSpUFYupKyTC6b3jnKLvNFXZciJuBL/sKJGwN0JIsqKFYDzuMhZw/9BAJaSLOC3ATmoiW2U5VTCU8ptWb2xbN1YKmYRLlAwiJbs7RPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8sODEWl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026469; x=1742562469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lNF/nXlhxo+l9WMdwFIqQFvTQLSF/djgFb4AU2uJoaY=;
  b=h8sODEWlt9xkhmEf4ZTnM6LNEtgjU1JqseSSyoWRvxZIGhFGKSy6lpCM
   xHUeWDEKWb91wJmNtyo9/bknZN27FWSB+ti7udz0/L9VEcmhR+e9Vb1di
   Z6xGo/pwJUfsl7oPByNhxvjYxzvVa325y97bobKcnLYveKbM1OO+6Dv+H
   IEZRFSfEyAvPjmhqVsxYZRjLNgcCrKkqTF+XQ0oPRIs/aaPlMZC5ZVaij
   KOOc+y+LmawZ/jWauyfBb4eX3olybRT/U3gKTgETjgp+iyq93fPcxNufQ
   k8fP90AVBhqa4Ak38cR5ejFhTCjR8ZLO4nQffrwB1OqUhH3x0+SiBg86K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127128"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127128"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923188"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:07:46 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 00/17] ASoC: SOF: ipc4/Intel: Fix delay reporting (for 6.9 / 6.8)
Date: Thu, 21 Mar 2024 15:07:57 +0200
Message-ID: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The current version of delay reporting code can report incorrect
values when paired with a firmware which enables this feature.

Unfortunately there are several smaller issues that needed to be addressed
to correct the behavior:

Wrong information was used for the host side of counter
For MTL/LNL used incorrect (in a sense that it was verified only on MTL)
link side counter function.
The link side counter needs compensation logic if pause/resume is used.
The offset values were not refreshed from firmware.
Finally, not strictly connected, but the ALSA buffer size needs to be
constrained to avoid constant xrun from media players (like mpv)

The series applies cleanly for 6.9 and 6.8.y stable, but older stable
would need manual backport, but it is questionable if it is needed as
MTL/LNL is missing features.

Mark, can you pick these patches for the 6.9 cycle as fixes?

Regards,
Peter
---
Peter Ujfalusi (17):
  ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream
  ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs
  ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place
    constraint
  ASoC: SOF: Intel: hda: Implement get_stream_position (Linear Link
    Position)
  ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position
    callback
  ASoC: SOF: Introduce a new callback pair to be used for PCM delay
    reporting
  ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks
  ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter() for
    pcm_delay
  ASoC: SOF: Intel: hda-common-ops: Do not set the get_stream_position
    callback
  ASoC: SOF: Remove the get_stream_position callback
  ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info definition
    locally
  ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in
    pcm_trigger
  ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED
    state
  ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops
  ASoC: SOF: ipc4-pcm: Correct the delay calculation
  ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
  ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset

 include/sound/hdaudio_ext.h          |   3 +
 sound/soc/sof/intel/hda-common-ops.c |   3 +
 sound/soc/sof/intel/hda-dai-ops.c    |  11 ++
 sound/soc/sof/intel/hda-pcm.c        |  29 ++++
 sound/soc/sof/intel/hda-stream.c     |  70 ++++++++++
 sound/soc/sof/intel/hda.h            |   6 +
 sound/soc/sof/intel/lnl.c            |   2 -
 sound/soc/sof/intel/mtl.c            |  14 --
 sound/soc/sof/intel/mtl.h            |  10 --
 sound/soc/sof/ipc4-pcm.c             | 191 ++++++++++++++++++++++-----
 sound/soc/sof/ipc4-priv.h            |  14 --
 sound/soc/sof/ipc4-topology.c        |  22 ++-
 sound/soc/sof/ops.h                  |  24 +++-
 sound/soc/sof/pcm.c                  |   8 ++
 sound/soc/sof/sof-audio.h            |   9 +-
 sound/soc/sof/sof-priv.h             |  24 +++-
 16 files changed, 351 insertions(+), 89 deletions(-)

-- 
2.44.0


