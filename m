Return-Path: <stable+bounces-53697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4690E3E4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1E21C2098E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6ED6F314;
	Wed, 19 Jun 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eBHrBwGV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6D6BB58
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780339; cv=none; b=aGqNn7b492Td/BFxr4FL4xG7svrp4aDNXaz7n2keH65g6PtHwJKMWy2aeCQsupGAZN41g97TFItnzP0hBpgggt7gLqjCqk7oeLMVJpq9wkA8zuTy8yhX27vL63g1gHHwvORyOue6SDePz8DXMYbEGUyvK+44DbkALBPmPAVjrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780339; c=relaxed/simple;
	bh=7gLl8mSeSocLSj3yvqyFthVe4YpzuLpH7hqRRfCsFfM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pfd8XSahYmiI1PQkY1asLNXxznP5WECRzRC1SlotXTfV0hiPGG29b+4STC19UJ1/q/zMRLEixjaPz6ubVFYSSnWwVIfK1IQAGz/sLtiNzU234BRMeYR2iUNn4stVkW/iFJ3pfqybDZU5+UtBaqd5o4Fz1NuneN8EQfAJpK96AXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eBHrBwGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88599C2BBFC;
	Wed, 19 Jun 2024 06:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780338;
	bh=7gLl8mSeSocLSj3yvqyFthVe4YpzuLpH7hqRRfCsFfM=;
	h=Subject:To:Cc:From:Date:From;
	b=eBHrBwGVYc8g4lQLnDr3Ee+7RiWCd6hiicG/bkV31EyxDOvvyd3BL1gOD4/DXmq0i
	 6C0gkLOItZ2ReJZaMv7nTwF4e7PgpP0+RJXOJrSv6nopm9cQTpBBppbRG6VXywm1uu
	 hViD4nQYgs6vd7abiw+9pwHJ90TuaqYr9Hapv+ak=
Subject: FAILED: patch "[PATCH] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE," failed to apply to 5.10-stable tree
To: karol.wachowski@intel.com,airlied@gmail.com,daniel.vetter@ffwll.ch,daniel@ffwll.ch,eric@anholt.net,jacek.lawrynowicz@linux.intel.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,noralf@tronnes.org,robh@kernel.org,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:58:46 +0200
Message-ID: <2024061945-satisfy-depletion-2876@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 39bc27bd688066a63e56f7f64ad34fae03fbe3b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061945-satisfy-depletion-2876@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

39bc27bd6880 ("drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)")
21aa27ddc582 ("drm/shmem-helper: Switch to reservation lock")
67fe7487fe89 ("drm/shmem-helper: Don't use vmap_use_count for dma-bufs")
3f6a1e22fae9 ("drm/shmem-helper: Switch to use drm_* debug helpers")
aa8c85affe3f ("drm/shmem-helper: Fix locking for drm_gem_shmem_get_pages_sgt()")
09bf649a7457 ("drm/shmem-helper: Avoid vm_open error paths")
24013314be6e ("drm/shmem-helper: Remove errant put in error path")
df4aaf015775 ("drm/shmem-helper: Add missing vunmap on error")
7938f4218168 ("dma-buf-map: Rename to iosys-map")
ae710a458f0a ("drm: Replace kernel.h with the necessary inclusions")
c47160d8edcd ("drm/mipi-dbi: Remove dependency on GEM CMA helper library")
e580ea25c08d ("drm/cma-helper: Pass GEM CMA object in public interfaces")
05b1de51df07 ("drm/cma-helper: Export dedicated wrappers for GEM object functions")
d0c4e34db0b0 ("drm/cma-helper: Move driver and file ops to the end of header")
6a2d2ddf2c34 ("drm: Move nomodeset kernel parameter to the DRM subsystem")
d76f25d66ec8 ("drm/vboxvideo: Drop CONFIG_VGA_CONSOLE guard to call vgacon_text_force()")
35f7775f81bf ("drm: Don't print messages if drivers are disabled due nomodeset")
a713ca234ea9 ("Merge drm/drm-next into drm-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39bc27bd688066a63e56f7f64ad34fae03fbe3b8 Mon Sep 17 00:00:00 2001
From: "Wachowski, Karol" <karol.wachowski@intel.com>
Date: Mon, 20 May 2024 12:05:14 +0200
Subject: [PATCH] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE,
 MAP_PRIVATE)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lack of check for copy-on-write (COW) mapping in drm_gem_shmem_mmap
allows users to call mmap with PROT_WRITE and MAP_PRIVATE flag
causing a kernel panic due to BUG_ON in vmf_insert_pfn_prot:
BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));

Return -EINVAL early if COW mapping is detected.

This bug affects all drm drivers using default shmem helpers.
It can be reproduced by this simple example:
void *ptr = mmap(0, size, PROT_WRITE, MAP_PRIVATE, fd, mmap_offset);
ptr[0] = 0;

Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20240520100514.925681-1-jacek.lawrynowicz@linux.intel.com

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e435f986cd13..1ff0678be7c7 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -610,6 +610,9 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 		return ret;
 	}
 
+	if (is_cow_mapping(vma->vm_flags))
+		return -EINVAL;
+
 	dma_resv_lock(shmem->base.resv, NULL);
 	ret = drm_gem_shmem_get_pages(shmem);
 	dma_resv_unlock(shmem->base.resv);


