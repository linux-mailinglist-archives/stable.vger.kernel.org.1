Return-Path: <stable+bounces-248632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL75N5hYB2pmzgIAu9opvQ
	(envelope-from <stable+bounces-248632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:32:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA3555302
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BAE331738A9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE43C819C;
	Fri, 15 May 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xr7CKGQH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492A26CE11;
	Fri, 15 May 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862230; cv=none; b=SMuwWNRjnc6tP9ZNhFoOAlgsUdkqg1YXnDwZODPoeKgDWB9IVHW9Cqv40wCIIZfo/PqP92iOWolVuLKHuPoxLYb9NlnJuBkRw5O51/qf/OFL7uTT2/+zRbeEpAyAOfj4MHNOMulU4o4pnZPyP1kGeQyBajL0MpUTn2UDOppOT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862230; c=relaxed/simple;
	bh=Pq0N3jveOePUmAreNjRM29DWzLdk+SBX9+5PoYLyGMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYokqfQvc3APwoZQ3as30XQFGf9WOxvNoYOlM7bziJ6Y07CNraD4p4qXbt22lVFy8q86iQ8oxU2xGS1jgmVo4fzchpm3TyoyefWEfKOwmGjkIs84T2Kn89wZLjS19Y4dW0DoRM6DNBaRoVFWMkUvpwaoUKPGkMyiZijFabKfHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xr7CKGQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC65C2BCB0;
	Fri, 15 May 2026 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862229;
	bh=Pq0N3jveOePUmAreNjRM29DWzLdk+SBX9+5PoYLyGMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xr7CKGQHCqMw/4PrnpwUYQhmQSyFe3uMmZVSvSz/xqzjMswStqImK1S1iq6Ll95Ho
	 0espsrwzxFlhNpZQozSazVR+ooXyw1z1eIKFvIYHsApbtmWY2SuChpGXsGsh1EytFR
	 zylqn3qafzWSQUCyhwLNTm18cQPLkZXEUb1MV2N0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.18 116/188] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on allocation failure
Date: Fri, 15 May 2026 17:48:53 +0200
Message-ID: <20260515154659.847732961@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43CA3555302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248632-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

commit 93a528f67ce5095bcab46a69839eca97f43dd352 upstream.

When drm_gpuvm_resv_object_alloc() fails, the pre-allocated storage bo
is not freed. Add xe_bo_free(storage) before returning the error.

xe_dma_buf_init_obj() calls xe_bo_init_locked(), which frees the bo on
error. Therefore, xe_dma_buf_init_obj() must also free the bo on its own
error paths. Otherwise, since xe_gem_prime_import() cannot distinguish
whether the failure originated from xe_dma_buf_init_obj() or from
xe_bo_init_locked(), it cannot safely decide whether the bo should be
freed.

Add comments documenting the ownership semantics: on success, ownership
of storage is transferred to the returned drm_gem_object; on failure,
storage is freed before returning.

v2: Add comments to explain the free logic.

Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive eviction")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260408175255.3402838-4-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit 78a6c5f899f22338bbf48b44fb8950409c5a69b9)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_dma_buf.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -227,6 +227,13 @@ struct dma_buf *xe_gem_prime_export(stru
 	return buf;
 }
 
+/*
+ * Takes ownership of @storage: on success it is transferred to the returned
+ * drm_gem_object; on failure it is freed before returning the error.
+ * This matches the contract of xe_bo_init_locked() which frees @storage on
+ * its error paths, so callers need not (and must not) free @storage after
+ * this call.
+ */
 static struct drm_gem_object *
 xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 		    struct dma_buf *dma_buf)
@@ -240,8 +247,10 @@ xe_dma_buf_init_obj(struct drm_device *d
 	int ret = 0;
 
 	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
-	if (!dummy_obj)
+	if (!dummy_obj) {
+		xe_bo_free(storage);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	dummy_obj->resv = resv;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
@@ -250,6 +259,7 @@ xe_dma_buf_init_obj(struct drm_device *d
 		if (ret)
 			break;
 
+		/* xe_bo_init_locked() frees storage on error */
 		bo = xe_bo_init_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
 				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);



