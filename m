Return-Path: <stable+bounces-201104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9ECC008F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F238230D9863
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE6322B83;
	Mon, 15 Dec 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghmLA2i/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BD32D7E0
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834993; cv=none; b=G+2ZohK7KdAtP/jHgdhl4956Oj68HlQRbriRh1Fa5nyn0SJiZHYxTk2blQ970Mcwuzde7ORTfbZsRWfd+89d8rfX1fc7eLSnY2yn4/NQ+3MVTGNbvCUp6Wg4ppMOOjQU/yI3gVdwpVcmtdGIFZI7oEptD+Pv5aJnoJcLE+9yxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834993; c=relaxed/simple;
	bh=3MjcuJY22+uRyR9fIzYdnUpaGQrSnxWmMSsVGq3lJvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PD36uGk0AbwH5hGk1phsX/VDTlldXsc/Z12MqsfOSdmJTUQ2aFitwKw9E06kEtAVIb/nCCxrBHFnackfngX+0hTK7KBs2+DP9ygek/V/CMaHRB3GK/drB6dBB9o0OMnVidobc4emRzH9t/WF2Lx5c97SMdYplcJa6i5l7vQ0D94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghmLA2i/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765834991; x=1797370991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3MjcuJY22+uRyR9fIzYdnUpaGQrSnxWmMSsVGq3lJvs=;
  b=ghmLA2i/RdmqTT83pM15rLiKunuAdfu0xvcH+qOHGjTa4FQwgI9r7RIL
   Zvhxh1+Hz8tzM/QYHznZZuVDmpKXHI79ftBYrARuJOSWlP2CaA1aKVP4d
   IHaG8OFL8fFKOE6zYgbYRiml9mw+bj8doykZtritsOGXfw4cXbnycJtkc
   vpZyUYLgib0WzIb1e0tfNFxKdbdLMOuPOhibNBJrIKlswTwubf8EU6+st
   dcVpt0Lai3z4+3nNcqw2lAza2XiyAfCsKXM2vfHukTSNO4Il/BvaOdnJm
   0wsYlBoXYmbu6bVi8nPw6eSlIPWtrqC308Gp4znJ9EhG4ikYN4Y1HSE4A
   g==;
X-CSE-ConnectionGUID: q/FPX+5TQx+nDr7sgggFEg==
X-CSE-MsgGUID: W2Y95eLrQx2L4AyLMoy9vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67711902"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67711902"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:43:10 -0800
X-CSE-ConnectionGUID: 3gfxulAJRmOlhyR60LMFbw==
X-CSE-MsgGUID: xR0Mh4IgSeqvXFhsFLHPKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197110676"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 13:43:11 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: stable@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	decot@google.com,
	lrizzo@google.com,
	brianvv@google.com
Subject: [PATCH stable 6.12.y 0/8] idpf: fix Tx timeout issues
Date: Mon, 15 Dec 2025 13:42:39 -0800
Message-ID: <20251215214303.2608822-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This targets the 6.12-y branch and fixes stability issues in the flow
scheduling Tx send/clean path that results in a Tx timeouts and can
occasionally crash in certain environments.

The majority of the patches come from the series "idpf: replace Tx flow
scheduling buffer ring with buffer pool" [1] except for the first two
patches which are included as they address additional situations that
can result in Tx timeouts. There are two minor differences from the
original patch (3&8), also noted in the respective patches, for size
assertions due to differences in struct sizes between the original
version and what is present here.

Snippet from the cover letter of the referenced series:

The existing guardrails in the Tx path were not sufficient to prevent
the driver from reusing completion tags that were still in flight (held
by the HW).  This collision would cause the driver to erroneously clean
the wrong packet thus leaving the descriptor ring in a bad state.

The main point of this fix is to replace the flow scheduling buffer ring
with a large pool/array of buffers.  The completion tag then simply is
the index into this array.  The driver tracks the free tags and pulls
the next free one from a refillq.  The cleaning routines simply use the
completion tag from the completion descriptor to index into the array to
quickly find the buffers to clean.

All of the code to support this is added first to ensure traffic still
passes with each patch.  The final patch then removes all of the
obsolete stashing code.

[1] https://lore.kernel.org/netdev/20250821180100.401955-1-anthony.l.nguyen@intel.com/
---
We do realize this request is larger than stable rules, however, one of
our customers asked if this could be backported to this LTS kernel. We're
hoping this can be accepted since these changes are isolated to this
driver alone and have been tested by the customer and Intel validation.

Joshua Hay (8):
  idpf: add support for SW triggered interrupts
  idpf: trigger SW interrupt when exiting wb_on_itr mode
  idpf: add support for Tx refillqs in flow scheduling mode
  idpf: improve when to set RE bit logic
  idpf: simplify and fix splitq Tx packet rollback error path
  idpf: replace flow scheduling buffer ring with buffer pool
  idpf: stop Tx if there are insufficient buffer resources
  idpf: remove obsolete stashing code

 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   3 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  61 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 750 +++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  95 +--
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   3 +
 5 files changed, 390 insertions(+), 522 deletions(-)

-- 
2.47.1


