Return-Path: <stable+bounces-95556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BB49D9D33
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F96164146
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47F1DD88E;
	Tue, 26 Nov 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcgZDraF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7C1DD884
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644838; cv=none; b=fdjl4DEkDpdeq44jnUMue9MqwN+DqC28epyn3PyKcYSVLCmY2b6yfXSa4/zngJWn+xS+GSozt/aypRP0doingXxWxAcBq7FIuPbH0+AJaMFTf2BuMMUUog5tflf/j0fV2chZuwwYEnmB3oayMNjdqxclMtvpJ+jKp7V9bQ3Yvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644838; c=relaxed/simple;
	bh=/i3+h1awJGQqs17lzBBDvl8WRlndNoTgou2adlItUAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrmB3PAXnVOQeIRaf5/hXeLD4S/Hf84Q+nUrDUHfCnCZOs3v9pr7CL0+FbG1o4+FkVPNjqF8F/CzPV1bPQRIKiH6ubH+ntheoOdvmtwEAms91fBX/+PWekDOretJqafjC6RQAe8Shk/Cn//OLaL1t/GEUW/XBD4n8iunYuEaL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcgZDraF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732644837; x=1764180837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/i3+h1awJGQqs17lzBBDvl8WRlndNoTgou2adlItUAE=;
  b=fcgZDraFtZjQpFrC0IXx8OdVBJiG8tViIpE4Vi0xZwhseyNXS3x4sdy0
   BUw+K02T2dqTQAm53e0eQLtEaJHn6MhLUcMaMVsoJD6g6QTYK+XJzURfA
   X7qqYSwJnpkKus9e1vM8vGAT8cNEEzrxVL276M661e1kulqI+qoYh40GH
   pAW/i/7fNybtpfznUi4EI8Abp7dJAeqwBj7cNTXg0edc1MXpTy/ICmW3f
   1hO2dmVvxOgVLZh9D9lmVUCeiNYKj/ZtHAWmfZ/0NROaAlMAZbw//DS4H
   NIquKPjgCPMne/SDNItLe+m2+j9TZrtAWdmWuTtKmWZWemlRQI1tcVbj5
   Q==;
X-CSE-ConnectionGUID: ewwiFpQgQhiFw99WHIxxJg==
X-CSE-MsgGUID: Ica+OLiHT5KzxoEIE4zn4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32197192"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32197192"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:13:56 -0800
X-CSE-ConnectionGUID: BlwS6kv4TSqPiH68QOdk1w==
X-CSE-MsgGUID: qOGfTqo9TNSpVhXQqnCIHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91642696"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.145])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:13:55 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/migrate: fix pat index usage
Date: Tue, 26 Nov 2024 18:13:00 +0000
Message-ID: <20241126181259.159713-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XE_CACHE_WB must be converted into the per-platform pat index for that
particular caching mode, otherwise we are just encoding whatever happens
to be the value of that enum.

Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/xe_migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index cfd31ae49cc1..48e205a40fd2 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -1350,6 +1350,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 
 	/* For sysmem PTE's, need to map them in our hole.. */
 	if (!IS_DGFX(xe)) {
+		u16 pat_index = xe->pat.idx[XE_CACHE_WB];
 		u32 ptes, ofs;
 
 		ppgtt_ofs = NUM_KERNEL_PDE - 1;
@@ -1409,7 +1410,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
 						pt_bo->update_index = current_update;
 
 					addr = vm->pt_ops->pte_encode_bo(pt_bo, 0,
-									 XE_CACHE_WB, 0);
+									 pat_index, 0);
 					bb->cs[bb->len++] = lower_32_bits(addr);
 					bb->cs[bb->len++] = upper_32_bits(addr);
 				}
-- 
2.47.0


