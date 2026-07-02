Return-Path: <stable+bounces-271574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6QiGAv3eRmqEewsAu9opvQ
	(envelope-from <stable+bounces-271574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 23:58:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454896FD1AB
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 23:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NYsEyQTH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271574-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271574-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F246303AF82
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354B3B47CB;
	Thu,  2 Jul 2026 21:58:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5203905F8
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 21:58:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029497; cv=none; b=OPZaXIEU6SWlVxZ1EYseCxAGsCJ7JvcxFrFW5HYNfZpO9OHrw+5L3qFAKwSqRO1URG9wm1gzVblApmkQWec2uSyTk3DS5X2DEC2mSAEW2sVmGnGW8ZzBvecbw0Dg/NCGs55y2af0CziSST/LBpIu2wiXMvZxYDqg4Kc4dhUbso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029497; c=relaxed/simple;
	bh=JkbgUCqRQaF8d/GqkaxFsgRIZE/GM+E2OoNJKmepXFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8I35F7OW7vl6Pk5V1P3ptb5UJK7bG1UAgstqGLBiHrApQqVhGI4t1CEy206SRdHSEt7lqNCeo/ydV7gFEEY2SQjLNGuOAhi68sjGsrsIoM+geN+hBrx3xvk/7n6jJoBsUHRNgnpUf6eB8LUABA3XcXrsCLvpg9vIB8nr/jaYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYsEyQTH; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783029496; x=1814565496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JkbgUCqRQaF8d/GqkaxFsgRIZE/GM+E2OoNJKmepXFA=;
  b=NYsEyQTHgNdz1GSCLGPlNPpFkJCQw21JWTzeMpIFgtLcVxL/qUnOzldB
   891vWK9rtMyilAW1i+7sB1GhP5M4kgYvMMPMhsTJIIP/r6Hv/M56bHmA4
   Zg3nmF6cTJjYwX/94nJ+JHkqeJdLrgBCl3RF/Rjk6F7tbohgTHZ+cbGWB
   fmzcBcCQ3pP88YSfrAJfZU4TaS4FSpXy+VruExmvD/bjqCNc8qFOg2P0x
   o+4uyPZraXJbPbAlL7NtE2nolf0X+1jpY8hhb32J224ErGJQRpue/EH9U
   2vL9GK0WI6CXqVNmUujKUQMuSbQrhN1gC3A4UXuz+qLge/ux73JYaJtQM
   Q==;
X-CSE-ConnectionGUID: xyYv9ibzSRuQiPP/etA1XQ==
X-CSE-MsgGUID: uILMQZW5R7a78ytvb/Ro8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101208458"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="101208458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 14:58:16 -0700
X-CSE-ConnectionGUID: KgVi2j/jRRSslhpkcbahIA==
X-CSE-MsgGUID: 6aKpgY3FQOWk+q94fqBw0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="253610076"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 14:58:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/xe: Wait on external BO kernel fences in exec IOCTL
Date: Thu,  2 Jul 2026 14:58:05 -0700
Message-Id: <20260702215805.4011228-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271574-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 454896FD1AB

Before arming a user job, xe_exec_ioctl() only added the VM's
dma-resv KERNEL slot as a dependency. That slot covers rebinds and
the kernel operations of the VM's private BOs, but not external BOs
(bo->vm == NULL), which carry their kernel operations (evictions,
moves, ...) in their own dma-resv KERNEL slot.

The DMA_RESV_USAGE_KERNEL slot is the cross-driver contract for
memory management operations that must complete before the BO or its
backing store may be used: any accessor is required to wait on the
KERNEL fences before touching the resv. By skipping the external BOs'
KERNEL slots, the exec path violated that contract and could schedule
a user job while a kernel operation on an external BO mapped by the VM
was still in flight, racing against it and potentially reading or
writing memory that was being moved.

Replace the VM-only dependency with an iteration over every object
locked by the exec, adding each object's KERNEL slot as a job
dependency. This covers the VM resv (rebinds and private BOs) as well
as every external BO, mirroring the drm_gpuvm_resv_add_fence() call
that later publishes the job fence to the same set of objects.
Long-running mode continues to skip this, as before.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_exec.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index e05dabfcd43c..d5293bc33a67 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -292,13 +292,23 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto err_exec;
 	}
 
-	/* Wait behind rebinds */
+	/*
+	 * Wait behind rebinds and any kernel operations (evictions, defrag
+	 * moves, ...) on the VM and all external BOs. The VM's private BOs
+	 * carry their kernel ops in the VM dma-resv KERNEL slot, while each
+	 * external BO carries them in its own dma-resv KERNEL slot; both are
+	 * covered by iterating every object locked by the exec, mirroring the
+	 * drm_gpuvm_resv_add_fence() below.
+	 */
 	if (!xe_vm_in_lr_mode(vm)) {
-		err = xe_sched_job_add_deps(job,
-					    xe_vm_resv(vm),
-					    DMA_RESV_USAGE_KERNEL);
-		if (err)
-			goto err_put_job;
+		struct drm_gem_object *obj;
+
+		drm_exec_for_each_locked_object(exec, obj) {
+			err = xe_sched_job_add_deps(job, obj->resv,
+						    DMA_RESV_USAGE_KERNEL);
+			if (err)
+				goto err_put_job;
+		}
 	}
 
 	for (i = 0; i < num_syncs && !err; i++)
-- 
2.34.1


