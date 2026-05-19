Return-Path: <stable+bounces-249506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJarG8MwDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:43:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D857B7FF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6617230CF692
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7143DB65A;
	Tue, 19 May 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOs8foM+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2B3FAE1D
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183404; cv=none; b=THkHsDMbyGvaPT9SCbyBB+xSF80b9UGCm0Bo27Wb9dhH9UQNEMniXWSj6I0n4/a1uNLnPuNWRyFpYtJmCR78P2qD3fD/RJiv2R/NEHIpNuFV2pMQ1Vh0td+VDDBXINzv+36Qq/h8UU+6bFgJP19Fds+OkwxHPpnUTODPMzh+cGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183404; c=relaxed/simple;
	bh=fZsdXual8drNBaf6FbeMSKP9lM5ZDrtKFMzaStvsGIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhOLbBATGiP/bjjimgS/aBC+VPt/b+nI4zp1uTeVa2e5VKEHofU9bvIkudq9o2u1IW+oxleB6gJ0m61cQtdASVD99xYd+KLfBKvlhae3gjspkvH09vEzGFpg9yuwCDyoyOPLE2RWGwdjul6boQiww2oPFYzOXa6mirGAWWjiZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOs8foM+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183403; x=1810719403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fZsdXual8drNBaf6FbeMSKP9lM5ZDrtKFMzaStvsGIM=;
  b=hOs8foM+8uPgsc6rU+M5Suc+y/Ww49mHBlZizTxn9VJoAt0c9EmDYYFl
   UgmUSvSV2E8MMMA38ETWa7EsG2/iFdrIyAf72LigjpNyYRKxzoJqiKFQQ
   p/aDWY+H08KQOH2OmbCjUfiFCiYz/8+5NKpHvgAPaB4UfLQrljcNNf7kR
   7OFsnY5qYtgourvQIvs0JXKd8A5Csy8hE27T3VlUPSanoqsKNlLcU3k61
   PWPkKIcEDAd7CW/qnuNvSfJekkN6YmwDKE1kwLlW5QmEotkNr9mnbhCRu
   7YhycI73ZezeyB35to94G9OWV8rOoeSYhlZ2L6aXHw5kw6Qow8gEgHb78
   w==;
X-CSE-ConnectionGUID: HwXWhkvcQ7OlPgcy8jZfqA==
X-CSE-MsgGUID: pIHn7JDTTTKx19yw3lLDoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="67583815"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67583815"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:36:42 -0700
X-CSE-ConnectionGUID: J2KzBtqYRMqeIiv20oic1Q==
X-CSE-MsgGUID: yvkQn3sjQCyQiNVLjdwkTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244701543"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:36:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/10] PCI: Head alignment fix series
Date: Tue, 19 May 2026 12:36:23 +0300
Message-ID: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249506-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: DA4D857B7FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series [1] fixed resource assignment regressions for a few setups so
I'm sending it now to stable.

The series resolves regressions caused by 3958bf16e2fe ("PCI: Stop
over-estimating bridge window size") + bc75c8e50711 ("PCI: Rewrite
bridge window head alignment function"), the latter adds new head
alignment strategy and the former removes the old strategy making the
new, more memory efficient strategy the only one.

I've added those two commit as Fixes and a recent bugzilla ticket +
Tested-by done with 6.18 to patch 09/10. These are plain cherrypicks
from the upstream commits codewise, no manual modifications to the code
changes have been done.

I've not heard the series itself causing any regression.

I didn't know what is the correct way to deal with my Sign-off-by when
sending patches separately to stable like this, that is, whether to add
another (duplicate) Sign-off-by line of mine as the last line to each
patch or not so I left it out.

[1] https://lore.kernel.org/linux-pci/20260324165633.4583-1-ilpo.jarvinen@linux.intel.com/

Ilpo Järvinen (10):
  resource: Add __resource_contains_unbound() for internal contains
    checks
  resource: Pass full extent of empty space to resource_alignf callback
  resource: Rename 'tmp' variable to 'full_avail'
  ARM/PCI: Remove unnecessary second application of align
  m68k/PCI: Remove unnecessary second application of align
  MIPS: PCI: Remove unnecessary second application of align
  parisc/PCI: Clean up align handling
  PCI: Rename window_alignment() to pci_min_window_alignment()
  PCI: Align head space better
  PCI: Fix alignment calculation for resource size larger than align

 arch/alpha/kernel/pci.c          |  1 +
 arch/arm/kernel/bios32.c         |  9 ++++---
 arch/m68k/kernel/pcibios.c       |  8 +++++--
 arch/mips/pci/pci-generic.c      |  8 ++++---
 arch/mips/pci/pci-legacy.c       |  3 +++
 arch/parisc/kernel/pci.c         | 17 ++++++++------
 arch/powerpc/kernel/pci-common.c |  6 ++++-
 arch/s390/pci/pci.c              |  1 +
 arch/sh/drivers/pci/pci.c        |  6 ++++-
 arch/x86/pci/i386.c              |  5 +++-
 arch/xtensa/kernel/pci.c         |  3 +++
 drivers/pci/pci.h                |  3 +++
 drivers/pci/setup-bus.c          | 15 ++++++++----
 drivers/pci/setup-res.c          | 40 +++++++++++++++++++++++++++++++-
 drivers/pcmcia/rsrc_nonstatic.c  |  3 ++-
 include/linux/ioport.h           | 22 +++++++++++++++---
 include/linux/pci.h              | 12 +++++++---
 kernel/resource.c                | 33 +++++++++++++-------------
 18 files changed, 149 insertions(+), 46 deletions(-)


base-commit: 9021cc14f7d98b4a1d2c932f52c5343d4d0f6b92
-- 
2.47.3


