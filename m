Return-Path: <stable+bounces-232952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKUeNlU1zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CBB386D17
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 274C1300C0D1
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BE433FE15;
	Thu,  2 Apr 2026 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D90bB+of"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4C33E374
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121392; cv=none; b=YrL6WDZre3O+Hkiqt17BuShR/fk8QKKfSSAs7e/PneLxovFoQdtSporqgSDU/rIoCs1T0XH6H1XChee85L9JMbQpAe6a3ZBCAR4+zx9KLZXNuqhO4eu3sXX+Lb+zbCikClG5HpU4BwEDbPr9IfvmIylDd9yffyDbdow47Ovg7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121392; c=relaxed/simple;
	bh=AztiPs5S9VA3snwSOj1X1fMakFzfMHl7HwuHgGJ/BCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zb4zH7sQZGwF7Ahfi2tRSmVyuaQJGFC7cbc++Vl/lGkQHAyowVGV9o3vdM1wRN/ImxRTzG6dnAyX7bxLN6QHjWT86Bc5jFBr5k/eiK/wsE9D59hpLdKvfL0MmZt5dp86pgiRovF9aLF4jWA07JDnPRZGSXUB9A5ScrB1TV9N0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D90bB+of; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775121391; x=1806657391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AztiPs5S9VA3snwSOj1X1fMakFzfMHl7HwuHgGJ/BCs=;
  b=D90bB+ofS37FoEMTD8z3HIvb8Ysaa4EpdM1a01awhexQsNVXeSY5X2ZB
   lUSeCQt5MkbCvsAB7BSHZeWglQGOoRSX5TRjWoS2u+wEgDZyDJJZRr+5C
   MFmV64oxs7cTS2dYhlSA1Op2jlxpVYYR2ymTzO+NZVsMPHqBEKUR/h+B+
   nknG7N+LU1MccXzz+9YWNr8uxFNF+hSy4YVXU7vwvi0wtJMA9Q0kcEcBW
   mBaQfOi+U4YlQaWb74Gcjj4S70+o/qgySLNAzsTFBBLgO23qLJvrusNSK
   5Jmkm7FKHxS7xuROQN+sGTGSRpj6X+aJ2O0J0EHqoWhLAM2a0GZBTwftv
   A==;
X-CSE-ConnectionGUID: uGW+PohCQqyiHOxIstXHww==
X-CSE-MsgGUID: 5vTgFm78QDKt6tE5IFFXcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76066652"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76066652"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 02:16:30 -0700
X-CSE-ConnectionGUID: gHLcrzBuRkGnlq4p7I8C0Q==
X-CSE-MsgGUID: et2+fDOoQ2m8VfdJPQkB7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="264867194"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 02:16:28 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix slab-out-of-bounds on PT update ops retry
Date: Thu,  2 Apr 2026 11:15:39 +0200
Message-ID: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232952-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 72CBB386D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xe_pt_update_ops_prepare() calls xe_pt_update_ops_init() at the start of
each invocation to reset per-attempt state, but current_op was not
included in that reset. When vm_bind_ioctl_ops_execute() retries due to
ww-mutex contention (drm_exec_retry_on_contention), ops_execute() calls
xe_pt_update_ops_prepare() again. The second call walks the same op list
and fills ops[] starting from current_op, which still holds the value
from the first attempt. This indexes past the end of the ops array
allocated by xe_vma_ops_alloc(), whose size was computed for a single
pass.

KASAN reported:
  BUG: KASAN: slab-out-of-bounds in bind_op_prepare+0x89c/0xae0 [xe]
  Write of size 8 at addr ffff88812e72bae8 by task xe_evict/2848
  [...]
  bind_op_prepare+0x89c/0xae0 [xe]
  xe_pt_update_ops_prepare+0xbd0/0x1570 [xe]
  ops_execute+0x3ae/0x2030 [xe]
  vm_bind_ioctl_ops_execute+0x4d5/0xed0 [xe]

The write lands at ops[1].vma (offset 360 into the second element of a
one-element 384-byte allocation) because entries[] is exactly 360 bytes
and current_op was 1 at the start of the retried prepare pass.

Fix by resetting current_op to 0 in xe_pt_update_ops_init().

Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 8e5f4f0dea3f..3607cd57fc4c 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -2291,6 +2291,7 @@ xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
 	init_llist_head(&pt_update_ops->deferred);
 	pt_update_ops->start = ~0x0ull;
 	pt_update_ops->last = 0x0ull;
+	pt_update_ops->current_op = 0;
 	xe_page_reclaim_list_init(&pt_update_ops->prl);
 }
 
-- 
2.53.0


