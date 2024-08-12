Return-Path: <stable+bounces-66419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7E394E9BE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180FF280199
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FC16D4DE;
	Mon, 12 Aug 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coqKc5y4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414620323
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454836; cv=none; b=RgQiIIXdi0T6F4xDtfVHZK73yV7tmOKpcWL+GKbhwtqoUPn6x1E7EikcO/sfpuYJQDs255czSfOIyZppLU7FUhil8EkvLnsQAjGN0NdPSAtX3eETST9Ghj4paJZJh7mlBhSCRr2kB4IHDrQCfYGrNqOEiHuJFg2E2fnwGdDQuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454836; c=relaxed/simple;
	bh=aIEk823tEhszHngzKIbnVi/sCvOzWB+BdDx2Nwvt+uk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sfbl0VtG5W2G/J+UHh8tDkAxv1d/kb91f2osJfNliPGUmDvRtOTU4dJ5REh0ZbKYUJ4p3kQ9nwZugz+DQ62/vkv/rdLbXTN2KWfbfwGXP6yd3SSyV34fQSwB8erJFAwvQGx9gos70M57u90CjXCgLkATIVfceS+s+XlpC+Eo1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coqKc5y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF9C32782;
	Mon, 12 Aug 2024 09:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723454836;
	bh=aIEk823tEhszHngzKIbnVi/sCvOzWB+BdDx2Nwvt+uk=;
	h=Subject:To:Cc:From:Date:From;
	b=coqKc5y4AZmoKXVBJjpEbFQOAdZxpVL/Esjd6MxKu+3Z+CC21AJDy9zHhIeJaD+uj
	 4nOGJ+knZZ8dt51opezEGvB4tpjGa4cjCihNkaPYc19lwzctd/FN1O5wJefRxiJlPh
	 WbAsSFkdSb8yF4Ej7mG6EufCNuMNIXcumqx3t8yA=
Subject: FAILED: patch "[PATCH] drm/i915/gem: Adjust vma offset for framebuffer mmap offset" failed to apply to 5.15-stable tree
To: andi.shyti@linux.intel.com,chris.p.wilson@linux.intel.com,jonathan.cavitt@intel.com,joonas.lahtinen@linux.intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:27:10 +0200
Message-ID: <2024081210-gathering-rocklike-26ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1ac5167b3a90c9820daa64cc65e319b2d958d686
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081210-gathering-rocklike-26ad@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


