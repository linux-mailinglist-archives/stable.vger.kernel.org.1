Return-Path: <stable+bounces-244440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPFEFlGM+2mWcQMAu9opvQ
	(envelope-from <stable+bounces-244440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:45:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 987BB4DF7F6
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2956330071D9
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE930E0D5;
	Wed,  6 May 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j56jrKPj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85E2F83B5
	for <stable@vger.kernel.org>; Wed,  6 May 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093134; cv=none; b=LI3piYSLaJtepbu+wfmDKGTt1yJNUnY+h9yh+QCIQJtz0kIceVYXx9KTUj3dj9UReqxMGDxNHsejG5AUB9K3ajanQ5rQPWkE2fQg+mUVlsQYMNG0REWJ2RMIZr39a4mdNyvfepPJrI09rN25j/bXACWtPM9wDJwMjeKdRnY9oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093134; c=relaxed/simple;
	bh=vO0CE+HhHwzas2hl6tUhYO5hr4xt4KkqmbRITkttGOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZhtS5BKkFpV4pr0ORm53LpvuKtnxMg2DdDB6d99tJBLxJrxUItAYv9TCK2fHzxTb5g0OVcpktRePaellD9LUiAtE6EKZwDCU23Cf2bYFQgyRTyEciTDkK549Kx8J/zOMBLxr4skIRp/YlBX4KUo4BLzxwO08ujwgBR5bP5eiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j56jrKPj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778093132; x=1809629132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vO0CE+HhHwzas2hl6tUhYO5hr4xt4KkqmbRITkttGOI=;
  b=j56jrKPjWU55USDP42UovafTul9Xs9Fn37ZaJInNJ/F8AWR7tcgdc0TS
   HeGBobPiNxAkXr0Kv09Hr9aB2ydk+qngJLTzp8SsjEFZlY1iKAhhDjwNl
   pU2yjJcx8pxns/QbA/yHNHt9v3Tc2HA9ZESFjjq/rDAATplOYH+EQ7HQZ
   CDUwXid1/ag304dEKh/o8xMbqRhGB9zB/1LAnP9mKm4zL/ijsyX+9aW25
   qPeATRJ7IuQdWSEK5tmZZsG/MY92U6awS5+FY5sVy2ZdeKN1iN4oGv85b
   eg6UViJjhlNy6evGd4pmJbaS2rJzkMzLhlxSarVJut0rnWk7DrQskeEoR
   A==;
X-CSE-ConnectionGUID: e0ytfvMOSHSHXV4HNFacXg==
X-CSE-MsgGUID: HLPwi9cHTx6nRED83m+Hqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66566537"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="66566537"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:45:31 -0700
X-CSE-ConnectionGUID: t/EOAh1sTWG232n4AbyeMw==
X-CSE-MsgGUID: fURdGmmbQDef+sJMDuXhWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259661173"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:45:29 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/dma-buf: handle empty bo and UAF races
Date: Wed,  6 May 2026 19:43:33 +0100
Message-ID: <20260506184332.86743-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 987BB4DF7F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244440-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,gitlab.freedesktop.org:url]

There look to be some nasty races here when triggering the
invalidate_mappings hook:

1) We do xe_bo_alloc() followed by the attach, before the actual full bo
   init step in xe_dma_buf_init_obj(). However the bo is visible on the
   attachments list after the attach.  This is bad since exporter driver,
   say amdgpu, can at any time call back into our invalidate_mappings hook,
   with an empty/bogus bo, leading to potential bugs/crashes.

2) Similar to 1) but here we get a UAF, when the invalidate_mappings
   hook is triggered. For example, we get as far as xe_bo_init_locked()
   but this fails in some way. But here the bo will be freed on error, but
   we still have it attached from dma-buf pov, so if the
   invalidate_mappings is now triggered then the bo we access is gone and
   we trigger UAF and more bugs/crashes.

To fix this, move the attach step until after we actually have a fully
set up buffer object. Note that the bo is not published to userspace
until later, so not sure what the comment "Don't publish the bo
until we have a valid attachment", is referring to.

We have at least two different customers reporting hitting a NULL ptr
deref in evict_flags when importing something from amdgpu, followed by
triggering the evict flow. Hit rate is also pretty low, which would
hint at some kind of race, so something like 1) or 2) might explain
this.

Assisted-by: Gemini:gemini-3 #debug
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7903
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/4055
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index b9828da15897..e6c2f7d30abb 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -357,11 +357,6 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	/*
-	 * Don't publish the bo until we have a valid attachment, and a
-	 * valid attachment needs the bo address. So pre-create a bo before
-	 * creating the attachment and publish.
-	 */
 	bo = xe_bo_alloc();
 	if (IS_ERR(bo))
 		return ERR_CAST(bo);
@@ -371,6 +366,13 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 	if (test)
 		attach_ops = test->attach_ops;
 #endif
+	/*
+	 * xe_dma_buf_init_obj() takes ownership of bo on both success
+	 * and failure, so we must not touch bo after this call.
+	 */
+	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
+	if (IS_ERR(obj))
+		return obj;
 
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, &bo->ttm.base);
 	if (IS_ERR(attach)) {
@@ -378,21 +380,12 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		goto out_err;
 	}
 
-	/*
-	 * xe_dma_buf_init_obj() takes ownership of bo on both success
-	 * and failure, so we must not touch bo after this call.
-	 */
-	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
-	if (IS_ERR(obj)) {
-		dma_buf_detach(dma_buf, attach);
-		return obj;
-	}
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;
 
 out_err:
-	xe_bo_free(bo);
+	xe_bo_put(bo);
 
 	return obj;
 }
-- 
2.53.0


