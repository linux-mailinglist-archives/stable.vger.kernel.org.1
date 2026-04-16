Return-Path: <stable+bounces-238251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMlxMolx4GlkgwAAu9opvQ
	(envelope-from <stable+bounces-238251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:20:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191140A511
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1059C30466BE
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CC36657B;
	Thu, 16 Apr 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXwKl72G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3797365A03
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316804; cv=none; b=umdT6IhkV0gWaNd4h7Ax6UMgudpRt2uqhb2NZ8EDx0cnjTT/tpMFx0jIAGXKOs0t1ljrJ22r16MqPXn2kTnYwDcyZHRWyQCfCNQTlhh1ke9BLOS2Dt3UJbKDN8k3RrVuOXfrdD8gGDxp5DDCZtXSYvqxgwUPN96SQrgJrhYbDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316804; c=relaxed/simple;
	bh=7oC3WCu4+CGxZwvtT3OZit1QhOxhejkXOC9t9Ayzta4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcP7dGdXg8g8dir0tzoY+BDhgwaZkRyl6uiYW5zyMvTbxtgx8kUjwFbvsOwOw1sRYiv+R4BPYdyQrBL+OcZo/G+Wo1eqbTqUkwKADbYC0/uAAuvct9Xl3ynrC2UfWQiYTS1OUAnDzontlqEzHwo9xBw3Af/e1aq0ffOjGOnB3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXwKl72G; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776316803; x=1807852803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oC3WCu4+CGxZwvtT3OZit1QhOxhejkXOC9t9Ayzta4=;
  b=MXwKl72GnuIuEUl/EvcN2HPaAiKed2O3UDjOkRhVVHq3j/ymO8ln7WNa
   C6p4Gj8gOkfae8n0v8i9NM5zRtzR2gjf+rTuVO3ZXEDm5cjBR7Yjj2brb
   o+3hv+6UoF3+QOT8OoS34SxUu4sKjQZiFdUC6taBoX8bcAEl9lvwcQ9vn
   i6187s+ZO5HdkrSL/BwRaJx3BI6YnZ7v99YHW/ezykWbhz0bBF56R+It2
   mbUwfA5uYMrrdA+9X87rP+UuSAsJFXdWH8KBr6p0+TINiORxDzLd3/p1K
   r+6KRkYwl8B4nYbdiln4h+doeykqx56pt3EyClkNEDhol/FaXxkq2GJiw
   w==;
X-CSE-ConnectionGUID: SO7V5LghRmOcidSQYOvJfg==
X-CSE-MsgGUID: 2cCg4ijlRRigi6ihkvGqWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77213048"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77213048"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 22:20:01 -0700
X-CSE-ConnectionGUID: oyNhGBJ0QxWNcaf9eJbUog==
X-CSE-MsgGUID: aVjDku9tSPiADe9b28D62w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227963732"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2026 22:20:01 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v9 2/2] drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Thu, 16 Apr 2026 05:19:57 +0000
Message-ID: <20260416051957.651337-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416051957.651337-1-jia.yao@intel.com>
References: <20260416051957.651337-1-jia.yao@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238251-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5191140A511
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
 drivers/gpu/drm/xe/xe_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 2408b547ca3d..f2e733c7ddab 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3656,8 +3656,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_UNMAP_ALL) ||
 		    XE_IOCTL_DBG(xe, obj &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
-		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
-				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
+				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR || is_cpu_addr_mirror)) ||
 		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
 				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR ||
 				  is_cpu_addr_mirror) &&
-- 
2.43.0


