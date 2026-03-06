Return-Path: <stable+bounces-223364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IV2ENEHq2k/ZgEAu9opvQ
	(envelope-from <stable+bounces-223364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 17:58:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF0B225952
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E80C31477DA
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE4393DC0;
	Fri,  6 Mar 2026 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIWC8SXX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0E33BBC6
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815945; cv=none; b=fmcprtNwoNSW2QMgBXVgch5KQWzcuROqioR29JgcuaN4ywVbbd9Xw6bckoI18oq6U9qSdyTPM1GRvNYkOrR2n2p19GDbnU0m/yWmErPJX1r0FTbuRnRffj2Yz1yDIVXJMjCrA/lCE2GjmDBtPqnhe8zV6hycQKTiihOXFhIy05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815945; c=relaxed/simple;
	bh=GpTfZf18pCNdMh0u6lmxOJZGE8n9YE0rGbitPXLVVU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jX66roaimoAHKo4Ga+KxcjAAf7nD/ORRnrjD8UAG/tvPN6eHaheuNCjYHpstMnTT0ywgeUOYxZ5If7mrYo6FwnIoM+zwPdO81nTKZQDCWwgTn0R+Mipevd3exEw3rlSJIxY2Rx0v4/wOrYgLd5va1vzMd0fP6J+h1AffMIZuF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIWC8SXX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772815942; x=1804351942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GpTfZf18pCNdMh0u6lmxOJZGE8n9YE0rGbitPXLVVU8=;
  b=cIWC8SXXDKY49dMriVDGlj20+CMz4ZIZGrdntF+qJtje9sDxSRX9MIDt
   UpOEEeCyqQvL8eW57srt/JiTWUUHVhy/8Heg7oFpx7k+bqoH4S2Mj+4rV
   M88R7lYK/MXIqSOIFGpNcHqju9/XRbHsilPyOrKsal2ZNPYmOECSMEglY
   m4L/kD0MrwTvc5NdKZlyP2xjhpSIR/5HEZYHiT3vP9qX6I1Kkn47NwVQv
   NSIW2R6Q/Yh2YV+NTHX4ne6Eao+FXZ0v70YzWFJ9id5QLzHeNLeAsdt1y
   tHHTKQOqpgcC0Iw4coGKw8MakEmY1BkwJ2ao4Ycpqlt+EtwKSB01vu/R6
   Q==;
X-CSE-ConnectionGUID: WHpaTLIoRiu/BgT2RMP9cA==
X-CSE-MsgGUID: 5MMoj7x7TOOe2pd+YraMBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73843750"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73843750"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:52:18 -0800
X-CSE-ConnectionGUID: DpFJEyeqQPqhK2mFiS7lbA==
X-CSE-MsgGUID: 2vQ0Q01OTMOP1t1seA3oQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="223753611"
Received: from dut6079bmgfrd.fm.intel.com ([10.80.55.56])
  by fmviesa005.fm.intel.com with ESMTP; 06 Mar 2026 08:52:17 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Subject: [PATCH v2 1/2] drm/xe: Fix missing xe_hw_engine_group_del_exec_queue() in error path
Date: Fri,  6 Mar 2026 16:52:06 +0000
Message-Id: <20260306165207.176758-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306165207.176758-1-shuicheng.lin@intel.com>
References: <20260306165207.176758-1-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACF0B225952
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223364-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When xa_alloc() fails after xe_hw_engine_group_add_exec_queue() has
already succeeded, xe_hw_engine_group_del_exec_queue() is never called
to undo the add.

Add xe_hw_engine_group_del_exec_queue() at the kill_exec_queue label
to fix it.

Fixes: 7970cb36966c ("drm/xe/hw_engine_group: Register hw engine group's exec queues")
Cc: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 5c67185d5357..af915ccb4925 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1408,6 +1408,8 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 	return 0;
 
 kill_exec_queue:
+	if (q->vm && q->hwe->hw_engine_group)
+		xe_hw_engine_group_del_exec_queue(q->hwe->hw_engine_group, q);
 	xe_exec_queue_kill(q);
 delete_queue_group:
 	if (xe_exec_queue_is_multi_queue_secondary(q))
-- 
2.34.1


