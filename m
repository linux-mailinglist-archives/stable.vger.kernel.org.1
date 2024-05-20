Return-Path: <stable+bounces-45436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C38C9AF5
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 12:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD562822AC
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838D481CD;
	Mon, 20 May 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6BvVzKp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67084C125
	for <stable@vger.kernel.org>; Mon, 20 May 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199588; cv=none; b=cmnNBLauC9rZCYh8F7h0RHGEkfuaLbuyOFM0OUxvNhuumy4ab62qHwXPc3exu+XdYsIitPetsbJJuLc0NsecUGDuLBaGh3HB59gaz/5BYJ9iIKYyWMrJiUnnHCOzphvnDPXjq8J1jk/iwY8jwfzSiwBDJIZXkpgTKK+DSYGeTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199588; c=relaxed/simple;
	bh=f+kxv1VP9WWwG2js3OtiAgghZ/gIsZO1woNErtz9lSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FD5ZCus2haeG+qQth2TZ7YGPrLR4msv+g9mgnRqoVJ/DL8bVjqQQy0IaGu8i7AA1tKWXXMwRw+s+ZNHUSWl2rZEDX1Tgj1R7hI4miCwY5xkcRMeWNMTy0CgaAGMEg+azEMTtN3m1X7k5a0c09UIBHn6NrH/3VAw9dCsK8afoNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6BvVzKp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716199586; x=1747735586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f+kxv1VP9WWwG2js3OtiAgghZ/gIsZO1woNErtz9lSw=;
  b=a6BvVzKpvUgAka9t+wrddgv7iNjuqlmn5y140yK1QLL3s8B2MRZOxNwR
   8FpDZKg1zeW86OrbQ1JhoBqNOEkxoQ0AvSWiIEpWzCx6ZqyboLOLRPcAe
   YOWP6ubdmTKpYoUVHX/TNv+vpyl/ZHpzhHaPz8cwe4Zgj7lGJSTj8wFFt
   IaZmClv5prLzGE9oLUamD7hls9OtrI0u1Ew1OWyQJFEQqzAWqobZMhmBR
   B0y65KPcyAGNpItSFmMFfB//EGAS4DkQKUKt/ZOo2qYbTBN3o7nUyyRxM
   2AOrxP0wlbw32yDz3qAzsVigrZC5CHeGQtZfo0j7h5rVCQz5Y/seoJaPs
   w==;
X-CSE-ConnectionGUID: f6fhjBEZQNqwsyS5mbjjnA==
X-CSE-MsgGUID: d/dqIjPgSuegSfOpI9XRSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23725897"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="23725897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:05:19 -0700
X-CSE-ConnectionGUID: B9ISHHPDTvuFEru4+jxzsg==
X-CSE-MsgGUID: a0Vb7++0QYGn+ASfxWs+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32469419"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:05:16 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: "Wachowski, Karol" <karol.wachowski@intel.com>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Eric Anholt <eric@anholt.net>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)
Date: Mon, 20 May 2024 12:05:14 +0200
Message-ID: <20240520100514.925681-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Wachowski, Karol" <karol.wachowski@intel.com>

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
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 177773bcdbfd..885a62c2e1be 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -611,6 +611,9 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 		return ret;
 	}
 
+	if (is_cow_mapping(vma->vm_flags))
+		return -EINVAL;
+
 	dma_resv_lock(shmem->base.resv, NULL);
 	ret = drm_gem_shmem_get_pages(shmem);
 	dma_resv_unlock(shmem->base.resv);
-- 
2.45.1


