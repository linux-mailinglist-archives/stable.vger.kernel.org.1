Return-Path: <stable+bounces-225255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBm9IZS6s2lXaQAAu9opvQ
	(envelope-from <stable+bounces-225255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:19:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2C27EBA7
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB5D301AA49
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A6366DCF;
	Fri, 13 Mar 2026 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxLImDyp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85440366DBB
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386277; cv=none; b=jRaa99Ra/5Zbe6xa1grQwOtrCg4pAo6wMvF6lOspjgeRFuHQDQWEtKCXKh73aE/tQPwfMdmVCYRiVgnw2ULWhtUfUdDnwhwFh1+RRqnHgNwY98AF+FBGBgPKICsVk1mCNGTh7+wX44A1rsNpUtNAOmVUuFKl9PO99bYoe50+440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386277; c=relaxed/simple;
	bh=ylcjwdcy1G9q/umYTdy3ka2G5ngq9fyXAkkRRNGH5tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Af4VZYOCQpmVPf+83M0wERP2u+z5fseJ9PvvjMjpigikKua2eLQHOVR7w6oenP3/+pD3xNA6OvfuRxT+BZEKHK+DJvnk5CQx9cvL37ip+ECvyrNikccXCFvh8qFhVu0vQ+WGKxNnqXASn6RCCX5g2vtPIbgNFfPEwrauaHhww1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxLImDyp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773386272; x=1804922272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ylcjwdcy1G9q/umYTdy3ka2G5ngq9fyXAkkRRNGH5tc=;
  b=DxLImDyp+0GK9TSTjUKyq3ckYS5YSgLOVqgQK5Hdv0ZwukvcGVVd3q95
   i+sUOQXVY8KZZFNQbMGuLwFp/uvS0qeuOr0M5U6LPyM/B77ygt6nDIRvq
   xAcVgQNsB/hT8E0/fJygKLuak93sT87sfMPU4aY/xriVq4cz685YJ6YTk
   +Pup7FX4xXfOqSb3yiAsKJ9aLuWOqZOex2FDyJZDJAT9wLwyRA/Y2Kg43
   SI6FztTEstc7xILDhcFEZSzmpHzkqrNrFL9e+PVWlp6BK2FIzIJEoI7Lk
   S7yj5eX8QrTPWLndcfSpE+HDUvhTkJing/1+nw4aFgZCYc6cE8nl+Qq+X
   w==;
X-CSE-ConnectionGUID: mNsqHgdlS2G7gNbcNq8DOQ==
X-CSE-MsgGUID: t9oAQgc5RpiEQ64qxCyrbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="84809074"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="84809074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 00:17:52 -0700
X-CSE-ConnectionGUID: dHNJ+5vNTTGnPXjTbJR8Hw==
X-CSE-MsgGUID: PbjToogRRkKiMQpSNHUoyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="225532246"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 00:17:50 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2] drm/xe: Fix missing runtime PM reference in ccs_mode_store
Date: Fri, 13 Mar 2026 12:46:09 +0530
Message-ID: <20260313071608.3459480-2-sanjay.kumar.yadav@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225255-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjay.kumar.yadav@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: DDC2C27EBA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ccs_mode_store() calls xe_gt_reset() which internally invokes
xe_pm_runtime_get_noresume(). That function requires the caller
to already hold an outer runtime PM reference and warns if none
is held:

  [46.891177] xe 0000:03:00.0: [drm] Missing outer runtime PM protection
  [46.891178] WARNING: drivers/gpu/drm/xe/xe_pm.c:885 at
  xe_pm_runtime_get_noresume+0x8b/0xc0

Fix this by protecting xe_gt_reset() with the scope-based
guard(xe_pm_runtime)(xe), which is the preferred form when
the reference lifetime matches a single scope.

v2:
- Use scope-based guard(xe_pm_runtime)(xe) (Shuicheng)
- Update commit message accordingly

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7593
Fixes: 480b358e7d8e ("drm/xe: Do not wake device during a GT reset")
Cc: <stable@vger.kernel.org> # v6.19+
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
index b35be36b0eaa..baee1f4a6b01 100644
--- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
+++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
@@ -12,6 +12,7 @@
 #include "xe_gt_printk.h"
 #include "xe_gt_sysfs.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
 #include "xe_sriov.h"
 #include "xe_sriov_pf.h"
 
@@ -163,6 +164,7 @@ ccs_mode_store(struct device *kdev, struct device_attribute *attr,
 	xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
 	gt->ccs_mode = num_engines;
 	xe_gt_record_user_engines(gt);
+	guard(xe_pm_runtime)(xe);
 	xe_gt_reset(gt);
 
 	/* We may end PF lockdown once CCS mode is default again */
-- 
2.52.0


