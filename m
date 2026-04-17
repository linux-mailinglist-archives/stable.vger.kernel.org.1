Return-Path: <stable+bounces-238415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePXVJU3M4WkhyQAAu9opvQ
	(envelope-from <stable+bounces-238415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:59:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77441737C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A07F301BAE1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE631F9A2;
	Fri, 17 Apr 2026 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLOkgcoV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA245351C28
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405572; cv=none; b=Qxzutou+FA4HfUlA9ZFmnzumLKV9xFwebfYrj9uCx96EH1n+yADG9hCQKYHFkba37gHhW6r9GS6e+gYkx9sCBXFLfYVcvMoh+BfSnDb0dQN8jQRAkWHS8oaVlX9DFI+mLqsTZ2R4CTMOe19XtpVxLl9ASpjgDVSvtimeUnzNpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405572; c=relaxed/simple;
	bh=p2fTSOTy5ZihPPPKpmaCyROroOv/bJnN3bxaFGaMe78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZzlvMITVgTzHyX9A/+3S0lXQTRRF4ECLK4IeoeIb+ak+hMlYzSDZroCczSQHZG+6P+4PVpMf6Snzf8WLVgMCdGQJ1Fb7QF0JKbCfyCaOzZ+eb01ZJMIOtQ3UXmB3RAKivJHwuFLCz4v2ohXv/kTzF9qIk/sVmBI4lCyAfTxxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLOkgcoV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776405571; x=1807941571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p2fTSOTy5ZihPPPKpmaCyROroOv/bJnN3bxaFGaMe78=;
  b=QLOkgcoVvhL9ieXUMwCZCzmgZh+NZoIC4F0DTnEagKlfmAQG/QaC2Tht
   5l49DF9ewH8j/uzfoZ7JPxu2TedINm6BZQ12WXDOGdyWQE6gsmidviFYY
   ey/Q7Vj17hExlQzX3dHYp5ZRUEglMr3nz+kGx6UZtBF6WLL/9N7Qed4eP
   9+YjiNSI5Xs0NfF1u109C8wE7cKbAif7tvyPrxyjSII6GkvJHZO+5Z0YT
   A30flrksl4tiKe3QjcZiGEq3HZ93N2PugdcWTvzpwtH6GMA9uDCnnLIWS
   zkOfksauZB1ZbTPGH39QvYpkeR/OVXuRfDS/f+iLD6vP/6jMfQ8Eq8Fi8
   g==;
X-CSE-ConnectionGUID: 64IZ16LUSqOtbF5t9fPWrQ==
X-CSE-MsgGUID: H/wi48pVTIagc4rVeN91dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="102878740"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="102878740"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:59:27 -0700
X-CSE-ConnectionGUID: 9qUEiT18QqiHWjLuUtTpKw==
X-CSE-MsgGUID: dRZ7DLlMT5i2Wuv307Jymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230871837"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa008.jf.intel.com with ESMTP; 16 Apr 2026 22:59:27 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v10 2/2] drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Fri, 17 Apr 2026 05:59:17 +0000
Message-ID: <20260417055917.2027459-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417055917.2027459-1-jia.yao@intel.com>
References: <20260417055917.2027459-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238415-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE77441737C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add validation in xe_vm_bind_ioctl() to reject PAT indices
with XE_COH_NONE coherency mode when used with
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR.

CPU address mirror mappings use system memory that is CPU
cached, which makes them incompatible with COH_NONE PAT
indices. Allowing COH_NONE with CPU cached buffers is a
security risk, as the GPU may bypass CPU caches and read
stale sensitive data from DRAM.

Although CPU_ADDR_MIRROR does not create an immediate
mapping, the backing system memory is still CPU cached.
Apply the same PAT coherency restrictions as
DRM_XE_VM_BIND_OP_MAP_USERPTR.

v2:
- Correct fix tag

v6:
- No change

v7:
- Correct fix tag

v8:
- Rebase

v9:
- Limit the restrictions to iGPU

v10:
- Just add the iGPU logic but keep dGPU logic

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Cc: stable@vger.kernel.org # v6.18
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 2408b547ca3d..1481dd53775d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3658,6 +3658,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
+				 is_cpu_addr_mirror) ||
 		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
 				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR ||
 				  is_cpu_addr_mirror) &&
-- 
2.43.0


