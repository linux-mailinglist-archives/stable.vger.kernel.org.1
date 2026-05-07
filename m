Return-Path: <stable+bounces-244560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHJhLb59/GnXQgAAu9opvQ
	(envelope-from <stable+bounces-244560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:55:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC244E7D26
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80DBC300DF7C
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7E3793D3;
	Thu,  7 May 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAUBRMB/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC2383C9E
	for <stable@vger.kernel.org>; Thu,  7 May 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154937; cv=none; b=GOXBTyPQxuTNZP0l1Xo+DbXm4IXkXk/y6iiNMGFedf8UxBWe9WeoICXRWnXVQoNaN5zv3WOLtOi4L73Y3caRM/cc8Qst62RjleLcxxHEL5VliKSA1iGnaYY6Gk9sDhqMHjUK3XK8LCf1O7v925LKrla6FmMk4jCUt2btOtajD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154937; c=relaxed/simple;
	bh=U0IBHnMjKywr6yvWeZMjZBF/ekC5iRQTlu1WPvf0h0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeWSB+jspZmkDwNih3+jTrKE15RKP0h/DtmPBCW6NV2Ur2+52PmnW5TL+XNiVBWsUdaRW60ELii3zZOQSO7X/EyS4PVUvEr/lC5BV9r/bEaSASHxrh5F9XacF+zoJrWyTc6CDjJ/jX1e8yprWRF/1XlxLUdMONDP8Zz7qTz7FfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAUBRMB/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778154937; x=1809690937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0IBHnMjKywr6yvWeZMjZBF/ekC5iRQTlu1WPvf0h0c=;
  b=OAUBRMB/HTIzfa8ffOIdOW1JKree9UF61cqlGU8FEg359Zh4ClkIsZa0
   QJx31VdVtIG4eaaR4Ne7P49cB5C3KvbZuxBA2YEwtOEulk6srgqgWv/vg
   64XHV9vlXP56uxcCb150vGtcXxuVLQdBuzd7MdNQaFI3PSLRaAsnpPB5R
   MCOkFuYDeSTZjuCbx0szn4p1ASQYPfVcO0BXb46G3z8VU/JEx4xNJ5m8Z
   yOpCkGnNKR/laIsWJLCel10pfn98foQu55eS58ziiVkJkbKYzYueztd+s
   baCrLQXVHvx8uZeQ0LCByO/yb7D2KAZF6xSRI+Fg0Z+k/GCZlZn8N9IIl
   Q==;
X-CSE-ConnectionGUID: 2YpK+iYvQmWZazQD9lhLfg==
X-CSE-MsgGUID: EVduoJwXSPavVJ7E/C8eQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="81672380"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="81672380"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:55:36 -0700
X-CSE-ConnectionGUID: pr5ecdAdRVWyIombGkv1tQ==
X-CSE-MsgGUID: rWvEcOczQz6ZtNoljrWOtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="230055027"
Received: from amilburn-desk.amilburn-desk (HELO mwauld-desk.intel.com) ([10.245.245.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:55:35 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/xe/dma-buf: fix UAF with retry loop
Date: Thu,  7 May 2026 12:55:21 +0100
Message-ID: <20260507115519.115309-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507115519.115309-3-matthew.auld@intel.com>
References: <20260507115519.115309-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BC244E7D26
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
	TAGGED_FROM(0.00)[bounces-244560-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

Retry doesn't work here, since bo will be freed on error, leading to
UAF. However, now that we do the alloc & init before the attach, we can
now combine this as one unit and have the init do the alloc for us. This
should make the retry safe.

Reported by Sashiko.

Closes: https://sashiko.dev/#/patchset/20260506184332.86743-2-matthew.auld%40intel.com
Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive eviction")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 42 +++++++++------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 2332db502c8b..a54ec278a915 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -258,16 +258,8 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 	return ERR_PTR(ret);
 }
 
-/*
- * Takes ownership of @storage: on success it is transferred to the returned
- * drm_gem_object; on failure it is freed before returning the error.
- * This matches the contract of xe_bo_init_locked() which frees @storage on
- * its error paths, so callers need not (and must not) free @storage after
- * this call.
- */
 static struct drm_gem_object *
-xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
-		    struct dma_buf *dma_buf)
+xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 {
 	struct dma_resv *resv = dma_buf->resv;
 	struct xe_device *xe = to_xe_device(dev);
@@ -278,10 +270,8 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 	int ret = 0;
 
 	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
-	if (!dummy_obj) {
-		xe_bo_free(storage);
+	if (!dummy_obj)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	dummy_obj->resv = resv;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
@@ -290,8 +280,7 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 		if (ret)
 			break;
 
-		/* xe_bo_init_locked() frees storage on error */
-		bo = xe_bo_init_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
+		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
 				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
 		drm_exec_retry_on_contention(&exec);
@@ -342,7 +331,6 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 	const struct dma_buf_attach_ops *attach_ops;
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
-	struct xe_bo *bo;
 
 	if (dma_buf->ops == &xe_dmabuf_ops) {
 		obj = dma_buf->priv;
@@ -357,22 +345,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	bo = xe_bo_alloc();
-	if (IS_ERR(bo))
-		return ERR_CAST(bo);
-
 	/*
-	 * xe_dma_buf_init_obj() takes ownership of the raw bo, so do not touch
-	 * on fail, since it will already take care of cleanup. On success we
-	 * still need to drop the ref, if something later fails.
-	 *
-	 * In addition this needs to happen before the attach, since
-	 * it will create a new attachment for this, and add it to the list of
-	 * attachments, at which point it is globally visible, and at any point
-	 * the export side can call into on invalidate_mappings callback, which
-	 * require a working object.
+	 * This needs to happen before the attach, since it will create a new
+	 * attachment for this, and add it to the list of attachments, at which
+	 * point it is globally visible, and at any point the export side can
+	 * call into on invalidate_mappings callback, which require a working
+	 * object.
 	 */
-	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
+	obj = xe_dma_buf_create_obj(dev, dma_buf);
 	if (IS_ERR(obj))
 		return obj;
 
@@ -382,7 +362,7 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		attach_ops = test->attach_ops;
 #endif
 
-	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, &bo->ttm.base);
+	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
 	if (IS_ERR(attach)) {
 		obj = ERR_CAST(attach);
 		goto out_err;
@@ -393,7 +373,7 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 	return obj;
 
 out_err:
-	xe_bo_put(bo);
+	xe_bo_put(gem_to_xe_bo(obj));
 
 	return obj;
 }
-- 
2.53.0


