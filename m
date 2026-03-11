Return-Path: <stable+bounces-224725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MezN0qesWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:54:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C18267967
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75A40300680E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9F3E2743;
	Wed, 11 Mar 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN8Db9Is"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6343E2768
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248069; cv=none; b=nxUcpg+FFPTvs33h6cnZMgSBHDG39KBmOFld87d/Z8uTTBW6suGoJUzREwUda5/IS1V3wVn2NuRbQVhvclax5VUm3JC75TifBKbTOFqBf22maVHrclKzB5+DXSixB7m7o371q+yHfd5MNQs+nNb8vcTs74p64fqdXFgIcf/TRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248069; c=relaxed/simple;
	bh=4gDcSOCDCJRNZKFsw/ARflgqfkrBvU/0WcQ2EL4qSks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MfsXM6OcxRqTtYJY635Xfuhg03T/xwfPReiYSf23DIFpVZ3+StWd1Ua4LZl7uky0oLMzXX+huA10shqNOcXPme5zdV7gxHea8pqb4mLxYx7yBHHTu33j39bf4coa3lG1mIVNTYuH4G5+3IceFNtKzg+FHOmzYPMuhT2zeR7VKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN8Db9Is; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773248065; x=1804784065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4gDcSOCDCJRNZKFsw/ARflgqfkrBvU/0WcQ2EL4qSks=;
  b=CN8Db9IsbQoXbTUnjKOU3KRjdBNOtYUrEQxxhd4OsokoVday/M+gqRHx
   iU/84vW/vT1GuFzCdNg8QRIwCHxAG1hDSeIR3KSki1pVTsLANYEdzNdkO
   lQzGOrkB3warIdhmhncmsFhKoeqf5B38rkDCGo5FkY6jGrjVxmzuSWYrp
   koLu6s+Qld8j2GkobMRQs8WURWPhH3gsuyJ2J7sswX1GHGe+SXtLB5C2E
   IMA0nHNRUTxSdVeV96LOX/LWq3o4Wgde2m/4+fOqUnfJQHxosP3jgiXzH
   Fogme7jJVLzR6gEZP9MkXxYJX1EvtHZTu/be4F/yqwxfYLdUzLYzFXYgu
   w==;
X-CSE-ConnectionGUID: KL0Z6UgpR8ukq3cc5sxKNw==
X-CSE-MsgGUID: hob/mM8vT8ScPIAM+TosDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91897234"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91897234"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:54:24 -0700
X-CSE-ConnectionGUID: EO37A7oRQiS7kC7PEBid+w==
X-CSE-MsgGUID: 3o7+umt2TJaPcl9R3uCaww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="251035218"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:54:22 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/xe: Fix missing runtime PM reference in ccs_mode_store
Date: Wed, 11 Mar 2026 22:22:41 +0530
Message-ID: <20260311165242.2355683-2-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224725-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjay.kumar.yadav@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 58C18267967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ccs_mode_store() calls xe_gt_reset() which internally invokes
xe_pm_runtime_get_noresume(). That function requires the caller
to already hold an outer runtime PM reference and warns if none
is held:

  [46.891177] xe 0000:03:00.0: [drm] Missing outer runtime PM protection
  [46.891178] WARNING: drivers/gpu/drm/xe/xe_pm.c:885 at
  xe_pm_runtime_get_noresume+0x8b/0xc0

Fix this by wrapping xe_gt_reset() with xe_pm_runtime_get/put().

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7593
Fixes: 480b358e7d8e ("drm/xe: Do not wake device during a GT reset")
Cc: <stable@vger.kernel.org> # v6.19+
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
index b35be36b0eaa..f3b834a09a6d 100644
--- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
+++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
@@ -12,6 +12,7 @@
 #include "xe_gt_printk.h"
 #include "xe_gt_sysfs.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
 #include "xe_sriov.h"
 #include "xe_sriov_pf.h"
 
@@ -163,7 +164,9 @@ ccs_mode_store(struct device *kdev, struct device_attribute *attr,
 	xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
 	gt->ccs_mode = num_engines;
 	xe_gt_record_user_engines(gt);
+	xe_pm_runtime_get(xe);
 	xe_gt_reset(gt);
+	xe_pm_runtime_put(xe);
 
 	/* We may end PF lockdown once CCS mode is default again */
 	if (gt_ccs_mode_default(gt) && IS_SRIOV_PF(xe))
-- 
2.52.0


