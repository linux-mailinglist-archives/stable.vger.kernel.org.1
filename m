Return-Path: <stable+bounces-104044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDDB9F0D16
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01E11885577
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57A1E048C;
	Fri, 13 Dec 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDydV70I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F61DFE38;
	Fri, 13 Dec 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095590; cv=none; b=SaWWFM5T/Hdz+Y1XBu8xUEyNqqFphRiTSpgsgo+H4H8ioaFKo3qBzOQu8zNLx/DmnjN+IRQZs8F4Ez7QxDp3D5SlFBXJ2Br3EUG5RXWR8xEA1BvF3qOM3q2lKBAezFxO9GexhunvBuYLqbSDY5OgA1ECtjrsJRKhvqLRhCiwtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095590; c=relaxed/simple;
	bh=zepT5xG7KjwD5ahzrLrclLsiNWQp5vHsbH5ekCNy+sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMqLlcyklrOIKz3Jv9OY2V4/r0Fdv8TVLc+1EgZhVQgsem2ibgBx3zXOllOL1YiJEfNMfgnMEjy4SxRJ84TrCQGheVrQUHooqKT8q4tOYB65MO66WiFj3YIle2ociq4x5ps3cB4/+6Vfxz/9RRhiCMo45/A0do0yXP3qOOFZgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDydV70I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734095589; x=1765631589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zepT5xG7KjwD5ahzrLrclLsiNWQp5vHsbH5ekCNy+sw=;
  b=FDydV70IAg7cllubp0yQCAFx/vNzFKhRBtG9FHhnYYN7CGahlT3fdv3E
   TO1C1xXj8xV1I/ILa6LdaYa9Zfbb0s/K5AUtfXF0Bb5n47CO/kEZvkZVw
   4SPN6vxdGBWzLTRnDT45eisA6WfV1uEozlSmSz4IFlr3z3NOmcc8vs3ll
   G4dp7d80k/LZ8/MWyIe4Z1FM8ie1UMqCEvmesB+FnbaHux9bzfu4jIBvy
   jGfXxrjN4nZ/3CWpMfH9x1mP4pweOkBv3DhXOW+EeSVvFsTksRSCrASQx
   fsnkjqHhaCtOsuWJptkYWOgAtAroPO+wF66ZJmDyZ7vHJA3ohvBe3wr9x
   w==;
X-CSE-ConnectionGUID: C35YZc3OScCO0zqCH1QOIA==
X-CSE-MsgGUID: wtkbQhxtT+621pZsuhlX0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34782339"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="34782339"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:13:08 -0800
X-CSE-ConnectionGUID: DASJJ62BTauxD0qBdcGa9A==
X-CSE-MsgGUID: T6kRZJIHQJufkwfPBmAufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97321052"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:13:05 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com
Subject: [PATCH 0/2] ASoC: SOF: Correct sps->stream and cstream nullity management
Date: Fri, 13 Dec 2024 15:13:16 +0200
Message-ID: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The Nullity of sps->cstream needs to be checked in sof_ipc_msg_data() and not
assume that it is not NULL.
The sps->stream must be cleared to NULL on close since this is used as a check
to see if we have active PCM stream.

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
2.47.1


