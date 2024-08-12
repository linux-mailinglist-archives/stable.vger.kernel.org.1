Return-Path: <stable+bounces-66418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE294E9BD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188731C216EA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F716CD3D;
	Mon, 12 Aug 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVZDjrqT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199916C695
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454833; cv=none; b=pePbqtmB8+1QqsazbVeWLLg+pGa/fwWYTU0+pJaRGkak/BBHR4U/aOJbopCFbUJed1vNEFUDgg3JWKp1dW3680xdfxx5ehu9oAPT8T9Hw9zpnre1Cc5t3ZlYRtMXh/bYHpv2LqLZTMf9JSzdMLf0EjzuqkwWKRdzXp+3u7HCIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454833; c=relaxed/simple;
	bh=bCEfhuRaZDzLxHf6nQqqbYwLNjioYHrKryc6d4AEQ+E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iq3v3bfoPN0sbPqCdb0UFAykAn+iDlRfJxE+bIn76Fk3y40QwwWLhA0gZ2wRaWUqEn0pmKGWFwUa+dTJns0t++bwFfBHarUNzRJ2Q9wNVnyMUT2LugxlHMXvnWNhBKvScN/ZQuMwmU0ykj/XiAeytN2CnrFeqZg7y+SkP2Ks5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVZDjrqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C699C32782;
	Mon, 12 Aug 2024 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723454832;
	bh=bCEfhuRaZDzLxHf6nQqqbYwLNjioYHrKryc6d4AEQ+E=;
	h=Subject:To:Cc:From:Date:From;
	b=HVZDjrqT1KCT1QsuqJ4v6HFQ3buaP29j9x+BgP5sMmFmUzXQXvDu3Yy4yFG5ixA+4
	 pZYcFfSiVzr8cgVRY6+lDQwoBAqieDD9GtPlScEFulLMqL14qDvciVQlKP6N0hHVdx
	 69ukmlINou67FmWvbparoXLwWffFlCjGrrU35Tyk=
Subject: FAILED: patch "[PATCH] drm/i915/gem: Adjust vma offset for framebuffer mmap offset" failed to apply to 6.1-stable tree
To: andi.shyti@linux.intel.com,chris.p.wilson@linux.intel.com,jonathan.cavitt@intel.com,joonas.lahtinen@linux.intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:27:09 +0200
Message-ID: <2024081209-faculty-overplant-91c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1ac5167b3a90c9820daa64cc65e319b2d958d686
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081209-faculty-overplant-91c9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1ac5167b3a90 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
274d4b96b12f ("drm/i915: Fix a NULL vs IS_ERR() bug")
eaee1c085863 ("drm/i915: Add a function to mmap framebuffer obj")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ac5167b3a90c9820daa64cc65e319b2d958d686 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Fri, 2 Aug 2024 10:38:49 +0200
Subject: [PATCH] drm/i915/gem: Adjust vma offset for framebuffer mmap offset

When mapping a framebuffer object, the virtual memory area (VMA)
offset ('vm_pgoff') should be adjusted by the start of the
'vma_node' associated with the object. This ensures that the VMA
offset is correctly aligned with the corresponding offset within
the GGTT aperture.

Increment vm_pgoff by the start of the vma_node with the offset=
provided by the user.

Suggested-by: Chris Wilson <chris.p.wilson@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v4.9+
[Joonas: Add Cc: stable]
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-2-andi.shyti@linux.intel.com
(cherry picked from commit 60a2066c50058086510c91f404eb582029650970)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index a2195e28b625..ce10dd259812 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -1084,6 +1084,8 @@ int i915_gem_fb_mmap(struct drm_i915_gem_object *obj, struct vm_area_struct *vma
 		mmo = mmap_offset_attach(obj, mmap_type, NULL);
 		if (IS_ERR(mmo))
 			return PTR_ERR(mmo);
+
+		vma->vm_pgoff += drm_vma_node_start(&mmo->vma_node);
 	}
 
 	/*


