Return-Path: <stable+bounces-225619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNGsJuczuGmvaAEAu9opvQ
	(envelope-from <stable+bounces-225619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:46:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B329D9BE
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E98301FFAC
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118203B9DBF;
	Mon, 16 Mar 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6CqObwf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9F334695
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679376; cv=none; b=f3IZcuOtxrznD2k+WeX1b24ulzCqb8PmH31d61yea0PsKK6ObC/IxOAT8vizlphpdZNo76vrYWQ3adfTstlkRpFBCuw7xSbI2QW4/aWrSKgmJnQVIx8lX8CPK5Yc+4Me3UgvKn98Ea4Ptczu9PTHeBdp5pa4x+OO6U+zsW3WTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679376; c=relaxed/simple;
	bh=J3LIjTrMNoQ3s69hcMh2yYKGbUpDlxQD9mU/IIUNfuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRJLz1lrJPrNFGhkzNyfryq7gktzOLNlCc5hF3H46Fn4asN3Q2toqs9Ak9NPb2dGK2ZLjPg/DDbIYkyjPyAcWYICaVC3OrTMPTw+f6f7LMzk59Q4Vn8jQR6zDtRDUIFwn+DpnGW0xZm0VtEZEmShe9kMPH8OTWvyV4YqUKz9+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6CqObwf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773679376; x=1805215376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3LIjTrMNoQ3s69hcMh2yYKGbUpDlxQD9mU/IIUNfuw=;
  b=W6CqObwfDveeosRKcX61Bq/qqNJlyg5SNmETVHqAKWsXmayRxR66c6w4
   K7ss4IlBZkYVphHd7pWLXTBo0h92ByvKsDZZ9TZe7xz7fXH4ealjiFInz
   khWQppGJG0IGdogV5yIX5PKlmeUOzowrwz31d6npEKbZvEqJOnhV3DNrU
   uV49AE7+4EL8sRKFK7mzzR9SYtdvgygND12DV3f9TbsvASiYLEyIsqtr/
   703UUfCE4Mpm4Q4be3tQpah4h2o0qbmGReFXZvMa8zuEKuastAjIw+Jpy
   /Ytw6gKgasy0ZL6efYJRLxIohzdLrBGHGxbCWG7sqtAejDY2C+/dTFZ0g
   Q==;
X-CSE-ConnectionGUID: 1AvDv7X7TtmWHXe11jU/8Q==
X-CSE-MsgGUID: 1eDCS5+AQVqBuHpsPQ6iRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97308775"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97308775"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:42:56 -0700
X-CSE-ConnectionGUID: 3HxLPx6RToaAzeW7mZ3IFg==
X-CSE-MsgGUID: rY5oxy4pS3Kfxa0/TCgbAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221013843"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 09:42:55 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v5 0/2] drm/xe: PAT index validation for CPU_ADDR_MIRROR and madvise
Date: Mon, 16 Mar 2026 16:42:51 +0000
Message-ID: <20260316164253.262406-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129000147.339361-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225619-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: F12B329D9BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series strengthens PAT index validation to reject unsafe
configurations for CPU cached memory, preventing cases where the GPU may
bypass CPU caches and observe stale or sensitive data.

Patch 1 enforces PAT validation for the madvise ioctl path, ensuring
XE_COH_NONE cannot be used on CPU cached buffers, including CPU address
mirror and userptr-backed memory.

Patch 2 applies the same validation to vm_bind, treating
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR the same as MAP_USERPTR with
respect to permissible PAT indices.

Both patches close a security gap affecting CPU cached memory access
when incoherent PAT values are used.

Changes since v5:
 - Added an additional Fixes tag to correctly reference the root cause
   patch enabling the problematic PAT behavior.

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Fixes: e1fbc4f18d5b ("drm/xe/uapi: support pat_index selection with vm_bind")
Cc: stable@vger.kernel.org # v6.18
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>

Jia Yao (2):
  drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in
    madvise
  drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR

 drivers/gpu/drm/xe/xe_vm.c         |  2 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.43.0


