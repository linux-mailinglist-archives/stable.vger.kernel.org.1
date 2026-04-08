Return-Path: <stable+bounces-233819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kERgJU8W1mnwAwgAu9opvQ
	(envelope-from <stable+bounces-233819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:48:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F20613B94DD
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4923301A711
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2753A782E;
	Wed,  8 Apr 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBU4giBp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D913A7824;
	Wed,  8 Apr 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637898; cv=none; b=s0TAQ1ZIlXUAHmAQafOckEQQgEh0+9rLD6N9dENWCLAzkx8wjfOwUIuWpMueGXUm95+A3vpqTCCPQny+fXrjxOuECafcKfjCJd5XXyczRh3rEDE1ZwPEMiaXb+dxD+F7y1F+Usp0nABgIgU3CMQVQ9XXgbnbiTl729exK9OpxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637898; c=relaxed/simple;
	bh=Qds2/JPG0vRbtvp2UYNe53krBbK28vZwpnKqeVEiAZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K/fQZ5qnFpTU3rB2AYq7TRR1bUHmLUVFm2ykbILoAmeAaw5As06vgVvkN2F9tZHOVDziAjy2iuFzWfIOIS6Yfeqa4gtuO0I8fDbCToCN+hQmkrj6diSQDFKS8APGxeD1dbBfMoqadjJIEOQgzHpC/ueCcmls/lNVvTluJF9z8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBU4giBp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637897; x=1807173897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qds2/JPG0vRbtvp2UYNe53krBbK28vZwpnKqeVEiAZA=;
  b=dBU4giBp4H5CQbZfMmO4jns+GkzEylT9SZqzoa7Z+OLkjMlRnUiEdUFH
   QZgsINwkYQxjsklilwZqy9mjTbHqUr4zAGm3t0M1p/Yc1wQi5TIK/LSCW
   SY41o78GaPvX5V7WziC0rWnkLEf3HFvVc0NL3bLZGZNANWfAYiOWCsASv
   US/1xHHH2U/5Ct0yzGJ82QuZdCgJbRRC/Iis4O29SEkgAvnER+/fIByV1
   souOTJdxK+KcoGnbl3MlNCLrvG0CRNMfEXuO++fcBPmEpwKb+oyNmQYIh
   Gy0uyufbYg0jloIb4RgCUrrWpfJaseeAAwNR92hEHO01qYaAkyF+w2ho/
   w==;
X-CSE-ConnectionGUID: fRpPAynWRTiDboCCpIe+ow==
X-CSE-MsgGUID: uEWcmdAKRye63xRwYOYXgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94003639"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="94003639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:44:56 -0700
X-CSE-ConnectionGUID: 5fNn/h3lRZCrs9/OlrOliQ==
X-CSE-MsgGUID: qyHi5ervS3qQoWgcFDGWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251741953"
Received: from rvuia-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:44:53 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: [PATCH for 7.0 0/2] ALSA/SOF Intel: Enforce stricter period size for NVL
Date: Wed,  8 Apr 2026 11:45:12 +0300
Message-ID: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.de];
	TAGGED_FROM(0.00)[bounces-233819-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: F20613B94DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

NVL and NVL-S (ACE4) needs to use stricter period size constraint to
meet the address alignment for each BDLE buffer (start of each period in
the continuous ALSA buffer) set in the HDA specification.

It would be great if these can be sent for 7.0 as last minute if it is
doable, I left out the Fixes tag from the first patch as that is
introduced in 7.0.

Regards
Peter
---
Kai Vehmanen (2):
  ALSA: hda/intel: enforce stricter period-size alignment for Intel NVL
  ASoC: SOF: Intel: hda: modify period size constraints for ACE4

 sound/hda/controllers/intel.c |  7 +++++--
 sound/soc/sof/intel/hda-pcm.c | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.53.0


