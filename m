Return-Path: <stable+bounces-233879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCX9JJhI1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:22:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD43BBF12
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31853312321E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7163C943D;
	Wed,  8 Apr 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTC3wYPW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36F3BFE4D;
	Wed,  8 Apr 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650473; cv=none; b=AZf4KhQdh+TRc3GyVqvk0rEfblqsGnPaMbdTHDmdD8lNWkMBJUb4r7qiBc/GWb35StM9px7bZZjn9x432wYuDe6yWDv3Y28lHZHbeRE9B6Bj85/6+PNbztGTaHiCggYeftvhrZsmGJNvyPgWxIENxd5re70+/MbW0HWsysYIAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650473; c=relaxed/simple;
	bh=t0QpBZgo+6dh6OHRH7sPRhr5JZdAGcagqLB6ghcprqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twkegGFBJADMj33rgs1UKeMlpl/uIMQLvj1aVFbAhiqwScMjpYfRSe7I27dpx4HcPFeVhylglb7o9KkXaZO9F83014yd9OHbRmIvYxa8wJLDgTOwt6UtXy2pMSPMwo6f39EcUBd2WxynfxJpdIp3WIN3BsbU+aTAEL4S1e5kxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTC3wYPW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775650471; x=1807186471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t0QpBZgo+6dh6OHRH7sPRhr5JZdAGcagqLB6ghcprqM=;
  b=VTC3wYPWRBdnr4ni4EE/he++y8WZlyVz2viMynvyi7rYeQe1JYE766s1
   YMelbHf2XS8UQZibC7l0H+rJNbNX8u/CxqEN9tcTdUfa+85c8TV1RbX1Q
   +5GHqR+2mnbe7wbpSaoL7+W0oWAOLLcYlcEFI3/AoelWzCSxvuQ/ksvrb
   aojCLJGCslvpCO2a8lAC2bd4AYpHV8maUEzJbMpY8c78qVQhy/MWvUTNa
   MrFRn4bqcka+4TsaeZ6wmj7nST8QMrYFMeb944nsoaPUcZwc9hK3vGbZq
   EexbbkVxDLj+powsyPiBEK89l9olmqwtukZs8dkSUFoTIjJFmh0cWhq+u
   A==;
X-CSE-ConnectionGUID: 4XUe+7rfR5mLMNtvJfi1Yw==
X-CSE-MsgGUID: 2j9Cv3jUT1qZK7hfSoffYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80225520"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="80225520"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:14:31 -0700
X-CSE-ConnectionGUID: oydK6eisSdKd3z3ICCH2vg==
X-CSE-MsgGUID: 0Q8ah2CHT5SR9y+pZt4Uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="233405308"
Received: from rvuia-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.250])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:14:28 -0700
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
Subject: [PATCH for 7.0 v2 0/2] ALSA/SOF Intel: Enforce stricter period size for NVL
Date: Wed,  8 Apr 2026 15:14:46 +0300
Message-ID: <20260408121448.31130-1-peter.ujfalusi@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.de];
	TAGGED_FROM(0.00)[bounces-233879-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 0ACD43BBF12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Changes swince v1:
- Added Cc stable to the first patch

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


