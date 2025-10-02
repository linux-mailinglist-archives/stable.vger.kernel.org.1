Return-Path: <stable+bounces-183023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DBBB2C3A
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D433F3B37A0
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79A2D3737;
	Thu,  2 Oct 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/tJsGau"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C52C08CD;
	Thu,  2 Oct 2025 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392287; cv=none; b=AzyvLQX3UUi7TQrFT4nuSvRDg2qUfOwN3+6ATwVjHIAe0SGkC8DWwJUeK3XYS75SXm/Q88HoBLKGcqw+clRzvhgTd0cttK5D1fCpmox3gFtkh+BjR+HN2PL3g2YRnMegPzY6ka0VUrsOGm2pPlZ/OOR01IjkKKDFkygCZJTpP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392287; c=relaxed/simple;
	bh=4OGj4Dcw7etnUU306sHxq0QzG7OmdFR0kOykKL9U1mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocisOnV9FfIT1wCb6H31aT0s5OnoQZCu5a3j2nqBLUeHdQg7COCvkOEAjsXWt2MFRz3zNXQWpMAiZqMIpASDcEQCwVGqWBoGUsrEoIAenQGAm1Ezr+CbeuDbUvJ+S77JCBZsIjN45i9odOeniBEi4mUHScoCcUp/thzx7Lup4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/tJsGau; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759392286; x=1790928286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4OGj4Dcw7etnUU306sHxq0QzG7OmdFR0kOykKL9U1mI=;
  b=k/tJsGauAxg1kQYeLRShv0Ml6w7X78m0vA8el1jNAo5n0hatDnw42oBV
   xHSZUrIyfmdVgOfSZPH8CZOuS3wdLv9QTEpzri7Y7DijIGnslq8O23bLG
   lRhnL34+AiX6U/G/pf9ImIy8jgULThs96QtJUiBqwMLADw8t85z4hkL4r
   cxW1nEu2schWAaiT4baIi3Q6LfEFAeKBEMKAWO0cmB/auG8grmx5xJafv
   sDz3Lr+uAQv8vW9kPt9bRRnEfcePIu790R2OVlmgzdFMI1ufMJ2ncSCNM
   UoOTRoupmEzYFCUpueM+gCGdhR+sTfj45l751DVmwx4jcZkZFO8JoeQAV
   A==;
X-CSE-ConnectionGUID: iQ5+QyXwRP+xGCkrb/RsKQ==
X-CSE-MsgGUID: pTyC/5xPQTCBMsVMGNHdqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65524993"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="65524993"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:45 -0700
X-CSE-ConnectionGUID: zNSpYlyxTf6y8RGCr4HPaQ==
X-CSE-MsgGUID: sGweLt+OR4qFDS8Ib7olQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178268532"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:42 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer constraint
Date: Thu,  2 Oct 2025 11:05:35 +0300
Message-ID: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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


