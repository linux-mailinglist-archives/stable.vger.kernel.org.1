Return-Path: <stable+bounces-183017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB6BB2BA4
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABF53C3162
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710A298CCF;
	Thu,  2 Oct 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/qgw/eV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CEE169AD2;
	Thu,  2 Oct 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391188; cv=none; b=WRBo46uRMbdx5KnKMn7eaBxx57SfsT0t+YSeBsWpU586VDuSO1c/vHkfROkqBxOwSc+boHm5Q0YIhvE06sS4SVsgC18fBR0NTyKwYGOosgMBtLTrgO1VwLIC8fO+VqoVPmHsMoTsNN1HKGg8WNSgL1an27eXBmFAAEB8x1tvsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391188; c=relaxed/simple;
	bh=QPtP61rP2HSVa/Dj4rmPrjRi5Tfuz5S8TThF06PJz+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GA6I0WHTtsd6qkYXmSqYZL0AJ3m48NGs7SdBk2lE8zqs8fE6Hbv7+GJ7TXxrXmRjif833PJRF20e20igrR2LmpUfCiMU8BB97hUb2NpLk6hbUGViTkhq+Z5JTD577pS5Ge5HJQ0V6d6jOSZaPbSm7bx1V7gtxTYvxl4Tai9tg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/qgw/eV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759391187; x=1790927187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QPtP61rP2HSVa/Dj4rmPrjRi5Tfuz5S8TThF06PJz+o=;
  b=h/qgw/eVNT8AUnG6/PDe3tXmCUsoeWDfXQLHNmr5skQ5Dpi80kVv6ohs
   CjIzzPyhaFQT53pSGrJQgkyw4gVKmMewuQVqN4iDzUehmDRu5rBbqXlGC
   QduwHsz3GAntL4/mc/uRGBTTZmyjHoS3RYWs8lkuzQh0hyOq09MVZZIML
   NhjQEl73cDLrqCZ9+Q4aCbh6D0TCRq5nMg2NPaDsNs97UdJzdYAEa1ift
   sj8GuuAiPscnbHj5Y8DWnHZEUW8HNfl5HkFaLX2EIdnDNU5NHsVpnBNpp
   /FBN8g2LkArpVxZWTzypltQw6Yb3S2iWwf2af4lENwkPbO5zGfPVb5sFz
   A==;
X-CSE-ConnectionGUID: 5SGJfqHBQF6NiZd8g3bgvQ==
X-CSE-MsgGUID: 3leicLQbROagHfYbmuxCPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61630967"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61630967"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:26 -0700
X-CSE-ConnectionGUID: 8ui1yOCrRfWALhIAMoBIhw==
X-CSE-MsgGUID: ufA4BcifQUag7Ziv5yH7Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179760343"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:23 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 0/5] ASoC: SOF: ipc4: Fixes for delay reporting
Date: Thu,  2 Oct 2025 10:47:14 +0300
Message-ID: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

With SRC in the firmware processing pipeline the FE and BE rate
can be different, the sample counters on the two side of the DSP
counts in different rate domain and they will drift apart.
The counters should be moved to the same rate domain to be
usable for delay calculation.

The ChainDMA offset value was incorrect since the host buffer size
and the trigger to start the chain is misunderstood initially.

Finally: we can have a situation when the host and link DMA channel
in HDA is not using matching channel ids.
We  need to look up the link channel explicitly to make sure that we
read the LLP from the correct link.

Regards,
Peter
---
Kai Vehmanen (3):
  ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples
  ASoC: SOF: ipc4-pcm: fix start offset calculation for chain DMA
  ASoC: SOF: ipc4-pcm: do not report invalid delay values

Peter Ujfalusi (2):
  ASoC: SOF: sof-audio: add dev_dbg_ratelimited wrapper
  ASoC: SOF: Intel: Read the LLP via the associated Link DMA channel

 sound/soc/sof/intel/hda-stream.c |  29 ++++++++-
 sound/soc/sof/ipc4-pcm.c         | 104 ++++++++++++++++++++++++-------
 sound/soc/sof/ipc4-topology.c    |   1 -
 sound/soc/sof/ipc4-topology.h    |   2 +
 sound/soc/sof/sof-audio.h        |   5 ++
 5 files changed, 114 insertions(+), 27 deletions(-)

-- 
2.51.0


