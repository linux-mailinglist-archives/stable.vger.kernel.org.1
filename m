Return-Path: <stable+bounces-227278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO66MBvnu2njpQIAu9opvQ
	(envelope-from <stable+bounces-227278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:07:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 201132CAEA4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D512032C655D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2F3CCFB8;
	Thu, 19 Mar 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIScMcrJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597743D170F
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921575; cv=none; b=bqJ74V8x/q8hTiPYTy6Qc+k7ShN5ColIXe39WWWWIChlrzbqr0N1xiE9AzEoH1s478+R516Gen0GpQVKO1fVW63QO32+vliWICG5BY+8XzmqH4TLLev4kiG4tMlFrm2u4dbrhyRF+OfoEJ/KDVdsNFw+wnBd1VAhu6J0thG2WMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921575; c=relaxed/simple;
	bh=BC9zGprXEhsbsIQS0fdZGhicl3dwenYKDlfk7ILnEuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfsPjWJqQKR8yjBgU6BfVVC6lMP6zgE4jXnip0aRtbUxMm2cuu1Hj8/SKNRmd0AG0XLx8quysW/T3D9BgzGNWgfUCSKn7WXgRG07bWCL2l+ZkPu0dYBxJrS3L5Ak75RC9xicG+vxoli7KHqJbL/0Vq7X/A6nsbhJYFcCMtGbUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIScMcrJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773921574; x=1805457574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BC9zGprXEhsbsIQS0fdZGhicl3dwenYKDlfk7ILnEuY=;
  b=DIScMcrJ0o5x0jJxpz+7GdHGImsibfh8llbYfWmeWAwuAaZazvF2TgS8
   Elv5KuHRl8rgm7BMiMgdjcTOSR/lOus8Carqqski3jZPdEelLVSDdU65f
   GIg/3njlYxtxYZLLsWPtDExLQccaY0B5ymvJ9ot1c8+cyVa8+xeYTY3eS
   e9QAWO70DjqWucpkUetT1VMXEQSos0GOiA1YBG+rTUU/LhW3mR1EDxoPI
   blvk5DxfY9KF02F8d7zdrJzNdMl5LPack0YR/HW95wZO1XJxv4yTlTlX9
   +Tn1PJ7hoX1fvPJHIxBhRYreVnj8Lx/O0QyHDhlN3rNyToIEu/Tk0HVt/
   A==;
X-CSE-ConnectionGUID: qmBJFcfvTJGg9Sfil32BZw==
X-CSE-MsgGUID: ZTimyEF/TkG5zkIkXJj+7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78593941"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="78593941"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 04:59:23 -0700
X-CSE-ConnectionGUID: tsXcdrbJRrOMuI3pIlNHVA==
X-CSE-MsgGUID: KxtHwojZR/yvmDWKQlSVsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223160886"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa007.jf.intel.com with ESMTP; 19 Mar 2026 04:59:00 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v7 0/2] drm/xe: PAT index validation for CPU_ADDR_MIRROR and madvise
Date: Thu, 19 Mar 2026 11:58:56 +0000
Message-ID: <20260319115858.444541-1-jia.yao@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227278-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 201132CAEA4
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

Changes since v6:
  - Correct fixes tag

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
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


