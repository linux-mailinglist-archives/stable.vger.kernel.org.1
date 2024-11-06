Return-Path: <stable+bounces-91635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B689BEEE3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495942865BA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561AE1DFDA4;
	Wed,  6 Nov 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlZtvZ1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A031CCB5F;
	Wed,  6 Nov 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899313; cv=none; b=nupA4L7Dn71YSqbTHFp7V5tHz6Ipf+iVOIGyeIEgk5xuAAQCFZQBIwc6rtXBVaHkCA80tSC4e1ncyYirv3BJefAaNOuzgFd9OBsiq2npG+PZ9y0zOXIMBzkY6A9n4/YezaxFOULJwP8TQKWJqBh/Wx0aheekH5vXLtvtBKVnLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899313; c=relaxed/simple;
	bh=OPc227HmXdqe2VISH3VZtrttvtL4NnrQVJ9dCZsCXCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIGvdiWXtTYs64ysC7OIoxYaE7TfCVtpyJuhTCcqsDfKnz4tA1M7Ml3V3hGbKyvu0aStKgX9NHQM29/g29BpQHznf47gQmMnWK0DT5IJH/LDU+X57sp8ENmL3W7SFjMhcyXBMTww5GU9wmt7E7Dw3mtaYuZu0otH8+vuAatyvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlZtvZ1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47126C4CECD;
	Wed,  6 Nov 2024 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899312;
	bh=OPc227HmXdqe2VISH3VZtrttvtL4NnrQVJ9dCZsCXCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zlZtvZ1XiTce2gflDsyb7dCGTuTT5tPdVFv83nxFIfvvqgIigmVaGwLm62UV7lHBX
	 r/rV0LfcK6xxKibwkAmznqgS5GJN9qn1+xv0LQllRWSe5jBDUtpYJwSGadNRU3+0RW
	 6k9+K7qOsq5wDBPgmJae/OP2s6VcXe5GZeMOgJfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sherry Yang <sherry.yang@oracle.com>
Subject: [PATCH 5.15 71/73] drm/i915: Fix potential context UAFs
Date: Wed,  6 Nov 2024 13:06:15 +0100
Message-ID: <20241106120302.062992254@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

commit afce71ff6daa9c0f852df0727fe32c6fb107f0fa upstream.

gem_context_register() makes the context visible to userspace, and which
point a separate thread can trigger the I915_GEM_CONTEXT_DESTROY ioctl.
So we need to ensure that nothing uses the ctx ptr after this.  And we
need to ensure that adding the ctx to the xarray is the *last* thing
that gem_context_register() does with the ctx pointer.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Fixes: eb4dedae920a ("drm/i915/gem: Delay tracking the GEM context until it is registered")
Fixes: a4c1cdd34e2c ("drm/i915/gem: Delay context creation (v3)")
Fixes: 49bd54b390c2 ("drm/i915: Track all user contexts per client")
Cc: <stable@vger.kernel.org> # v5.10+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
[tursulin: Stable and fixes tags add/tidy.]
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230103234948.1218393-1-robdclark@gmail.com
(cherry picked from commit bed4b455cf5374e68879be56971c1da563bcd90c)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Sherry: bp to fix CVE-2023-52913, ignore context conflicts due to
  missing commit 49bd54b390c2 "drm/i915: Track all user contexts per
  client")]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1436,6 +1436,10 @@ void i915_gem_init__contexts(struct drm_
 	init_contexts(&i915->gem.contexts);
 }
 
+/*
+ * Note that this implicitly consumes the ctx reference, by placing
+ * the ctx in the context_xa.
+ */
 static void gem_context_register(struct i915_gem_context *ctx,
 				 struct drm_i915_file_private *fpriv,
 				 u32 id)
@@ -1449,13 +1453,13 @@ static void gem_context_register(struct
 	snprintf(ctx->name, sizeof(ctx->name), "%s[%d]",
 		 current->comm, pid_nr(ctx->pid));
 
-	/* And finally expose ourselves to userspace via the idr */
-	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
-	WARN_ON(old);
-
 	spin_lock(&i915->gem.contexts.lock);
 	list_add_tail(&ctx->link, &i915->gem.contexts.list);
 	spin_unlock(&i915->gem.contexts.lock);
+
+	/* And finally expose ourselves to userspace via the idr */
+	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
+	WARN_ON(old);
 }
 
 int i915_gem_context_open(struct drm_i915_private *i915,
@@ -1932,14 +1936,22 @@ finalize_create_context_locked(struct dr
 	if (IS_ERR(ctx))
 		return ctx;
 
+	/*
+	 * One for the xarray and one for the caller.  We need to grab
+	 * the reference *prior* to making the ctx visble to userspace
+	 * in gem_context_register(), as at any point after that
+	 * userspace can try to race us with another thread destroying
+	 * the context under our feet.
+	 */
+	i915_gem_context_get(ctx);
+
 	gem_context_register(ctx, file_priv, id);
 
 	old = xa_erase(&file_priv->proto_context_xa, id);
 	GEM_BUG_ON(old != pc);
 	proto_context_close(pc);
 
-	/* One for the xarray and one for the caller */
-	return i915_gem_context_get(ctx);
+	return ctx;
 }
 
 struct i915_gem_context *



