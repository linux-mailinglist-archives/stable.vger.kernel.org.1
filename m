Return-Path: <stable+bounces-183059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F12BB41AF
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571C5422C34
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C43310620;
	Thu,  2 Oct 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIsfR4B1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107251DE4CD;
	Thu,  2 Oct 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413422; cv=none; b=qutDb9/WQqcMKOks8+kgm2Wwsj6YRTOM6+cFsZrHUvItu4txf+WrLrwS7eyTlXu7BK7OMMW70Mnr5BJt1p/s7L40nb0boDRjtxphDxn1HwM5n9B35pXr4qRjIEh7M/wm4fwKlV7GPkBHoVGAxGQIkc5pP0+EtsvVxERFbeaiY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413422; c=relaxed/simple;
	bh=qjdkpeXM90QVruKA+KeLx29wGlmTHk5mLPRee4TS3a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkK9DqJSjqAtEihKu58MostsXOKi4gv4jEFvNVmvNVsivQeRhKl8atY2CWIdh2xqHZ3xblQOE6ois1+ECpXjkukuEKmufj4Wcl11NLY4asay26a/TgMVmSOZkTkky7lrBlxcp2RWau2pqrVjpY4J4HAKjRRUjyfKl24Wg8OSbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIsfR4B1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759413420; x=1790949420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qjdkpeXM90QVruKA+KeLx29wGlmTHk5mLPRee4TS3a0=;
  b=SIsfR4B1USsBVZRiIYhZPTm8nsryuhR0si3DBP8FAFBpHU21D6/fY7iR
   RgTSfIPxou5Zc9Qkflcm8agP+vtrXFs9Ha6lkAI8sxekkL2xu0xPJGVex
   3r2fZE+XvbN9TYld/GctofTA4Qaj4fcgJcg+9tOS4drf3CyKd6Ocu0svW
   Pililz6qW/4qLQZiICt2QQkO+BOzYzQem+UeT8Viye/Mo1YCIWZ4iDqn4
   S2KaE47O6GLdK6sK2f3cyHyplMBEv4IS77ZhaSQgiG4Mq4uBzUvh8+pXu
   1VD8RzlNs19rEI1AcT6YIHbblYMPuZAh6+8g7MDH+GK5YYnKzAm8R28CO
   w==;
X-CSE-ConnectionGUID: rm1cBb9jTA6uxQwtzvzxZg==
X-CSE-MsgGUID: mH0WPZZmRGOhSq0XVD01Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49251120"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="49251120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:56:59 -0700
X-CSE-ConnectionGUID: Sgy3vBExRGCWDN5cDn/7tw==
X-CSE-MsgGUID: dy3l+MiITkusD4XQEtWjPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179460658"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:56:57 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer constraint
Date: Thu,  2 Oct 2025 16:57:49 +0300
Message-ID: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

CHanges since v2:
- SHA fix for the last commit, tripple checked them

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


