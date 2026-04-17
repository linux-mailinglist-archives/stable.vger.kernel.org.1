Return-Path: <stable+bounces-238413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBAiA9vM4WkhyQAAu9opvQ
	(envelope-from <stable+bounces-238413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:02:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37B4173AB
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0478A307D21D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153431F9A2;
	Fri, 17 Apr 2026 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBV6wUj2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E7327C0D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405566; cv=none; b=aEARcy9PML1K/uZpEI305iSmNkbviSPfV1sRVmiwb9mbdAwTv/hF5omIkS1/ljtmHgHpUX+YXr4vkMzQtSm3afd2Yd6nZwxLBCXvuAa+xgxHnKMmcxfohvoTwfqG+WxYizUni1jypBNs/Nufex1j/t5dIBMkL7hHsVqtLBF+Juo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405566; c=relaxed/simple;
	bh=y+pbNHaGI/qun7rM19bS2zigwvEUEuecNLoSu0RRjPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u12AERlbp2iPc8tdjjQq+GcKEU7pCuAr173v5OwZ8LKcWL2bUEhsxtVTaTBIV/teM4UmrqrSy06WVMbJRl2K8pu5IQ6Ktoxx4ExJvjTvj6tugYRBoh3nql8ENHK4U3C49aYSMCugICTQOzlhTtsk2wJED41M0NmMD41LZdTloyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBV6wUj2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776405564; x=1807941564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y+pbNHaGI/qun7rM19bS2zigwvEUEuecNLoSu0RRjPg=;
  b=UBV6wUj2Dhz22aQ4g0pOIExaSjkuZKAyxongBoWq3kxo2Hc/ORQoDJhs
   Xxw72h7lgrsbBGh6xCCzCbnKsWskJLM0ai3lG4bptxqtKG6w0ldGMrAyo
   x+qiQzG4UqigKqOwF94/xqzQxh966v0YnXWSagnWX2QAlAXwktphU1Yx5
   f3HJ+yaYgNxtv2Wr9CrCdzLK9XltsYhKeMfEHrVMTUa0wP4jZKofmepMg
   025BzZIRnBNqb619uionarG8P6zV1x9/9vRM6wONxscqQFTET7btNB/yc
   RTcwTwvWxxrBEruXCSoU+/8sfyWv558v4Qgyz1gQ43t6s2z4UFK9rNMIx
   w==;
X-CSE-ConnectionGUID: IAl1pt60SvGNqNnPFv0yTA==
X-CSE-MsgGUID: nOy+jeYWSkuSdFpwo6gRFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="102878726"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="102878726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:59:23 -0700
X-CSE-ConnectionGUID: 8rWlx4HhTCCSInfucycFzw==
X-CSE-MsgGUID: wvs2048STTGDtgU0tW9d0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230871795"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa008.jf.intel.com with ESMTP; 16 Apr 2026 22:59:23 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v8 0/2] drm/xe: Reject unsafe PAT indices for CPU cached memory
Date: Fri, 17 Apr 2026 05:59:15 +0000
Message-ID: <20260417055917.2027459-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-238413-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E37B4173AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series strengthens PAT index validation to reject unsafe
configurations for CPU cached memory, preventing cases where the GPU
may bypass CPU caches and observe stale or sensitive data.

Patch 1 enforces PAT validation for the madvise ioctl path, ensuring
XE_COH_NONE cannot be used on CPU cached buffers, including CPU address
mirror and userptr-backed memory.

Patch 2 applies the same validation to vm_bind, treating
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR the same as MAP_USERPTR with respect
to permissible PAT indices.

Together, these patches close a security gap affecting CPU cached
memory access when incoherent PAT values are used.

Changes since v10:
- Just add the iGPU logic but keep dGPU logic

Changes since v7:
- Rebased onto latest drm/xe tree, no functional changes.

Changes since v6:
- Corrected Fixes tags.

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
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


