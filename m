Return-Path: <stable+bounces-244559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJrcI8B9/GnXQgAAu9opvQ
	(envelope-from <stable+bounces-244559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:55:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074274E7D25
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2972E300C919
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C789390995;
	Thu,  7 May 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgOgNHH9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59630F535
	for <stable@vger.kernel.org>; Thu,  7 May 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154937; cv=none; b=lss5eX+fhecREvzz1WfaZ905CfEdkTvjx8kL8CVKIOOnlbsN5STz6ErzrV1fEApty0V4a7UNd83l06ZDfZgMqaZ3emfm7xzeVAoHZyPjXQRm3oxO993p5KhgHspVbfkVYUY50tY607E0VQsiv9RqRyBVw3HJDYqhFxmdLp8tCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154937; c=relaxed/simple;
	bh=uOZzP+hnc2KkpXmUBEYDiNlvJmdc3wTyTq/s/nSWBdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jUfKplAZVv6hy6olQyQ6mxw+JWXAVj/zSWVFAOSXQgq/bwUE1/uWVAvEAp976Tn2pWcwNRYzuPTxN+vrsj6HigSaC9JRi0Qwi0k6rWgjJ5SSqKnhpVdDbSWFA+mla+oIUpWQmNnWfAlwmA1tHrpOO5Hv7iHZTMWzlsD+0ec3NgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgOgNHH9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778154936; x=1809690936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uOZzP+hnc2KkpXmUBEYDiNlvJmdc3wTyTq/s/nSWBdI=;
  b=EgOgNHH9x5SdLl85hzGwizUzGAbb3m2IVxWJQm7Z4h/9894P9wqGByT5
   D5E4c7fnjgr7E3t3YeZqQP7rsf836sLla92ubTjc733MQ6meOC/R+/RsZ
   8zqNU9jJMHClyyveHWWsC7MYW8qIjmvn1VegPjoa54jq7XR1o5z9OHNim
   FWsN+T+/CQJA1avWebfiu4/TO2Ejg1R6jIvJxfD19m4e4+ZTvBYVlYme7
   RzwipHrjWPdgx6Ou97d2C0DdVxhWI+rAT6ROtz/ro2+VJ2J4jhKjfI7E3
   naE7lbk+8oWcOm+1PSCMFahAp9XPnjvqh14bF8cC/F3lc+dHsgV86Tlh4
   A==;
X-CSE-ConnectionGUID: PXEPiMpdSnSZHvkElRm0kQ==
X-CSE-MsgGUID: 6TG9MAu2SJuGKoNlP82z3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="81672376"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="81672376"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:55:35 -0700
X-CSE-ConnectionGUID: VTo835LLSkK2masNB5HJAQ==
X-CSE-MsgGUID: 21d7cxqFQrWsq8IrsjWt9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="230055022"
Received: from amilburn-desk.amilburn-desk (HELO mwauld-desk.intel.com) ([10.245.245.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:55:33 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/xe/dma-buf: handle empty bo and UAF races
Date: Thu,  7 May 2026 12:55:20 +0100
Message-ID: <20260507115519.115309-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 074274E7D25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244559-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action

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

v2:
  - Shuffle the order of the ops slightly (no functional change)
  - Improve the comment to better explain the ordering (Matt B)

Assisted-by: Gemini:gemini-3 #debug
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7903
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/4055
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Acked-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index b9828da15897..2332db502c8b 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -357,15 +357,25 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
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
 
+	/*
+	 * xe_dma_buf_init_obj() takes ownership of the raw bo, so do not touch
+	 * on fail, since it will already take care of cleanup. On success we
+	 * still need to drop the ref, if something later fails.
+	 *
+	 * In addition this needs to happen before the attach, since
+	 * it will create a new attachment for this, and add it to the list of
+	 * attachments, at which point it is globally visible, and at any point
+	 * the export side can call into on invalidate_mappings callback, which
+	 * require a working object.
+	 */
+	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
+	if (IS_ERR(obj))
+		return obj;
+
 	attach_ops = &xe_dma_buf_attach_ops;
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 	if (test)
@@ -378,21 +388,12 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
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


