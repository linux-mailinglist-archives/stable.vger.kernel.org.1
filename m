Return-Path: <stable+bounces-252155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIZvBe36DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC54595C1A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B78C307818F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECE3F6C5F;
	Wed, 20 May 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UMmrptxr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E73F39D7;
	Wed, 20 May 2026 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299935; cv=none; b=AD942dJdx0oSlFtWWsUWdl/BzobkPUR9pAAim8tWrLcO54hg7ohCFDJ8hpoftYfDazjyLro+artfQ7BTR0Bt5rvckTcACR8VUWrRHvEbqm2GU3+qOKtUbsi+p5KKMXj7E8foD+2feGSuDXfdPKtGNhyNwCRwVBYPgjGF72GLhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299935; c=relaxed/simple;
	bh=afVZMrF8bapjY8D9/Yz86BuF9tR80ik/ZgcVlEQKZaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTO3nvIZTcDFsoIrIXJQ45jeQx68UNhZAieJ7VbJ0B7OI7WruUKBRxSM1GPVdiL/X6qiMKoNAwkcc4WhREKJJUfAdsR/+0BchH7kiRalZxeSngxAVrfZIVGCKMJ9mi8Bu1/jyfVxxa/pZZjvnza3piTUVpcdi3dppba6Zu+tD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UMmrptxr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B931F000E9;
	Wed, 20 May 2026 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299934;
	bh=WjAEi5pxFPc+Hw7GhbQQOQPz5KKmvBgKQa9xGtOQHOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UMmrptxr/qf/wLBDhPDVdA1BvGWUMnSIgQYXVBM4fJtNmNjzJMj+Qn3Rw0pAvXchd
	 jUa0a+23jVXX38+cb98nqvt+yUrU8g/WbcRPJk0ly0iz4X3DiRRw0DMpjL+zYomqL/
	 65lU9d27QRXTS7ucWARIOiRAyCIc1trep9Mis6m4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.18 943/957] drm/xe/dma-buf: fix UAF with retry loop
Date: Wed, 20 May 2026 18:23:46 +0200
Message-ID: <20260520162155.049388588@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252155-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: BEC54595C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Auld <matthew.auld@intel.com>

commit 155a372a1cc50fa93387c5d3cdfd614a61e1afd1 upstream.

Retry doesn't work here, since bo will be freed on error, leading to
UAF. However, now that we do the alloc & init before the attach, we can
now combine this as one unit and have the init do the alloc for us. This
should make the retry safe.

Reported by Sashiko.

v2: Fix up the error unwind (CI)

Closes: https://sashiko.dev/#/patchset/20260506184332.86743-2-matthew.auld%40intel.com
Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive eviction")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260508102635.149172-4-matthew.auld@intel.com
(cherry picked from commit 479669418253e0f27f8cf5db01a731352ea592e7)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_dma_buf.c |   49 +++++++++-------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -227,16 +227,8 @@ struct dma_buf *xe_gem_prime_export(stru
 	return buf;
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
@@ -247,10 +239,8 @@ xe_dma_buf_init_obj(struct drm_device *d
 	int ret = 0;
 
 	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
-	if (!dummy_obj) {
-		xe_bo_free(storage);
+	if (!dummy_obj)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	dummy_obj->resv = resv;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
@@ -259,8 +249,7 @@ xe_dma_buf_init_obj(struct drm_device *d
 		if (ret)
 			break;
 
-		/* xe_bo_init_locked() frees storage on error */
-		bo = xe_bo_init_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
+		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
 				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
 		drm_exec_retry_on_contention(&exec);
@@ -311,7 +300,6 @@ struct drm_gem_object *xe_gem_prime_impo
 	const struct dma_buf_attach_ops *attach_ops;
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
-	struct xe_bo *bo;
 
 	if (dma_buf->ops == &xe_dmabuf_ops) {
 		obj = dma_buf->priv;
@@ -326,22 +314,14 @@ struct drm_gem_object *xe_gem_prime_impo
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
 
@@ -351,20 +331,15 @@ struct drm_gem_object *xe_gem_prime_impo
 		attach_ops = test->attach_ops;
 #endif
 
-	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, &bo->ttm.base);
+	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
 	if (IS_ERR(attach)) {
-		obj = ERR_CAST(attach);
-		goto out_err;
+		xe_bo_put(gem_to_xe_bo(obj));
+		return ERR_CAST(attach);
 	}
 
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;
-
-out_err:
-	xe_bo_put(bo);
-
-	return obj;
 }
 
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)



