Return-Path: <stable+bounces-219890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDTiJ+n4oGmboQQAu9opvQ
	(envelope-from <stable+bounces-219890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:52:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C641B1A55
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48164300A669
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B1212D7C;
	Fri, 27 Feb 2026 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AV2IRe9B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7226E6F9
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157154; cv=none; b=ExM453zEGFp/Tu/Eip073uRUMArF7pITHn5Q9Wid0CV9ZvHyL9A+jEsp5DFy+nbmzWimpIvoTdFjtPJSa5W+WmedPTD7UpGvwVJ1JGJ3CTUGOOJH1ky9X1pRoIXuhFnJk26ZT7f7Ly1ypqjhCdqLwbIDh2kxWXsgQKj6LJcszv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157154; c=relaxed/simple;
	bh=L5F9A+FsGe841uZMlWDyMzsG07L5fZRaqsw4/NE32XY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgWSQZxT6KW7t9aJ6pR6oELZl9LHX3TQIncMuhRVBLT7YNEAjfn5ZrDft7g9JENr6dLrsrnOd+Vc/Eimzxh1mP+rz9w9L4OMNTIkMq7NphQGxbOQpthkGTkyroRCxQdmfsER0BKmDhT/cbCvWGwN7qM/SI24mNFL1xt5zQE1h0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AV2IRe9B; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772157152; x=1803693152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L5F9A+FsGe841uZMlWDyMzsG07L5fZRaqsw4/NE32XY=;
  b=AV2IRe9BJ+1Tk3nnNdM0BDqvj3EC4/U+z7Pc2k2Sc4ut6/VtlCJMXLk/
   hq4Ve/7nmO9tqDYqSXcm9nuU8ozuwEjjuQ0WdY75FaiHuCGjKB/NMSUw+
   bszoByhGlPgJtrlavXA2nmT3Gh3+ip4kgMF7DbZRJrpnffCir1z0vOym9
   4yBkOs+qr9WJRqaVGfrE8eUAYgtZ2mkBKeEyX7WdA8MZ8pz9LUb4Dkftu
   LtMenuk+lp+eTIqgNamtHRanvZg7izaBYqGWiA7YsUTuPPpzOa2e7I8f/
   4YMMRCAEFt9YPj+PkOYZOT0yC9s+bX6imoeLuj9F2RnKrLI2AbTZVed15
   g==;
X-CSE-ConnectionGUID: 2G8e64XdQHa2AQXGn3k5sg==
X-CSE-MsgGUID: p2fVbK24TM+i+2ZPbB50iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72268413"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="72268413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 17:52:31 -0800
X-CSE-ConnectionGUID: JfDdRbvMQliV9W4qSSj2gg==
X-CSE-MsgGUID: ZEvMzPkzQn64vh2USNBI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="239739765"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 17:52:31 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/xe: Disable garbage collector work item on SVM close
Date: Thu, 26 Feb 2026 17:52:25 -0800
Message-Id: <20260227015225.3081787-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219890-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B7C641B1A55
X-Rspamd-Action: no action

When an SVM is closed, the garbage collector work item must be stopped
synchronously and any future queuing must be prevented. Replace
flush_work() with disable_work_sync() to ensure both conditions are
met.

Fixes: 63f6e480d115 ("drm/xe: Add SVM garbage collector")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 002b6c22ad3f..f8b57eca76fd 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -903,7 +903,7 @@ int xe_svm_init(struct xe_vm *vm)
 void xe_svm_close(struct xe_vm *vm)
 {
 	xe_assert(vm->xe, xe_vm_is_closed(vm));
-	flush_work(&vm->svm.garbage_collector.work);
+	disable_work_sync(&vm->svm.garbage_collector.work);
 	xe_svm_put_pagemaps(vm);
 	drm_pagemap_release_owner(&vm->svm.peer);
 }
-- 
2.34.1


