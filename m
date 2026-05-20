Return-Path: <stable+bounces-252154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGONKvb3DWry4wUAu9opvQ
	(envelope-from <stable+bounces-252154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:05:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6659544C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE2BD3108C9A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A03FB075;
	Wed, 20 May 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6yGlnQx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53523B61B;
	Wed, 20 May 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299932; cv=none; b=RzRP6v00C4vucC+m50xQPFaGYC7JST6mHXZ07Kztp8Lawm1vI2CdLYMM8zB7znGU9uglZ4H0Wa78KgXFbEMRdgp3wyrXrN3Ob6YXBIXPZ6+3s+mAGZI76d1fb4EfswNsEEZx70witjT3OW5MqEzwfrXX4fBKAjVsj/UFCz9ipVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299932; c=relaxed/simple;
	bh=xmBz1jz2ckoeR4jHkctDZ9uN8rGh5Ecer9IBZ+FABr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZsEpyxzgz5tNRBwiri2TYS1HtxMnIt15SyGPtX1mRzFl3jZGlKZYMvSBLQU7eM5niCyn0PVjfGSDkBqSXrHrXP8uy+71J9GUTFt1+8wOHNfgZsZEYruoxBWSXiUfkLn6bRuWhcR6UgIPk/NLw3yZkBzwqakyb4ocFxjZlrpEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6yGlnQx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16C71F000E9;
	Wed, 20 May 2026 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299931;
	bh=drIZ5blLR3pjKdy1RdXdOieyQP61LUeUS69ef8Aewo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6yGlnQxrBcuQUKqOrBXWNHcrI1L6oBx5PVu09DJ29pBmA8h5S4tL8tkLlQoxFEWr
	 wy+LVUoCL/HQ24prObHeyidsVrrDM74shfBBGePfrtcDkOO9naYR9us+sXMySh4Wsv
	 dlK44ltwimfOB7NVTzWx+zb1e8YiP7F1A2BmkdSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.18 942/957] drm/xe/dma-buf: handle empty bo and UAF races
Date: Wed, 20 May 2026 18:23:45 +0200
Message-ID: <20260520162155.026815186@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252154-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 31F6659544C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Auld <matthew.auld@intel.com>

commit 981bedbbe61364fcc3a3b87ebaf648a66cd07108 upstream.

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
Link: https://patch.msgid.link/20260508102635.149172-3-matthew.auld@intel.com
(cherry picked from commit af1f2ad0c59fe4e2f924c526f66e968289d77971)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_dma_buf.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -326,15 +326,25 @@ struct drm_gem_object *xe_gem_prime_impo
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
@@ -347,21 +357,12 @@ struct drm_gem_object *xe_gem_prime_impo
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



