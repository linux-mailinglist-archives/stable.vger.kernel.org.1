Return-Path: <stable+bounces-88114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A287B9AEFB3
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686A5283F67
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16C17ADF7;
	Thu, 24 Oct 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX72jzdu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8012FB1B
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794699; cv=none; b=OtP6wJlKE86N7M2gzVnGXGaOjmXHgag9Sgqpf789dGp9/mNcts6aif7kkmL2BZAduQO4fMSph7dCGlGfQejj3yFl//SUWB7bUnxgPkSuHToaGUX6eVocwU00A1YzKnXIPVrOgpu3d1E58MF9zCQ68Iucjt4O5+8U1++GA9k+QrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794699; c=relaxed/simple;
	bh=qr8elp8gQgLEbE2zKw6PG4i3d3rz5e+tw/+2mViLjiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GApaXhGY9V4PLZQywyfvp/qZs8pzKf7cmboVm5/sj8ygR/rI1MXkmbftjD3IJxe2tQdYpxSV9BBKIV9DrnweEoSlZmy06EJ8e+9TA0WE3ovSJU+my5MLo9OQTZf9f01q1PONb+JrMkTygKm3pOg2akpn8ypjSpvThyQWWoR4T6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX72jzdu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so14303141fa.2
        for <stable@vger.kernel.org>; Thu, 24 Oct 2024 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729794693; x=1730399493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOBu1OMmvywWy1HbeYv/LsS1VtoCNLbACKbDMs6n65U=;
        b=KX72jzduaoQR37G4eL4VUU78TiSiYv5cI4fQ0hylVuqkRl8618FUcVLOncAL7hhVTW
         YuQl/ubNaA7i4Ju6CvOm4Edmpt4t22nppjDqv4oH4QOqJ2OP3w32XoXWOe6u+SKhjFod
         zUe4csdgm00fGo0+/+DPxijXN62IfXjW5OJ+yeMjcE5OhF7/cC/Ms8NoPRk+7mWdrs4Z
         epa65X5VxuODPM9fGwa9M7ZD5suCNLssD4iZrocNZvBRHYb7jcLdfFeNWGZxcIOE4+Xy
         JMj9vhnbH0fl1/9+4PvxjpRuUDwpdDc6fhuDC7xAIk4nwvkzO0+P63Nd26UwqRF1U+uD
         gcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794693; x=1730399493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOBu1OMmvywWy1HbeYv/LsS1VtoCNLbACKbDMs6n65U=;
        b=t6BIpF22aueEfpc65PyAkofTuorhV4IhA7xnZjqHgUXb3kfG3G3PrYPPGt3Jf0zlVp
         uzdk8kV0kkx3GTOCkgestowg+0m51ZjWLvPA1oUJtpJPXD8zJa2H9h76VvvxA5tAvGsh
         vTqZowFLY2+lLaMQ8QPly9lhJsHx/KFxlvk5WdodvgW13F1NLg3AvSnSLWvw6Ipfd4jA
         Hq6lcL44ZEeRzRk65NuSrZR0857oNoX3fWtKllvtjAbffcpVxAkhSDJkYOu3nomXo7P4
         U4j/IU3un+YZ+p9gWEC/L77pafIUUlZcg1x0pQqwYxvndZQh840rDTZ7vPKMM9XcMlDs
         o6vw==
X-Gm-Message-State: AOJu0Yx5626Y7gDxq3k2i2e5Nz2iRFnXPdbQk1VpAIg3xnR6HAIR9OfA
	xo+QdoVmQMkbifHUqVtviGUTn6g6NaCMUSHDSr0/zubxaSCqqqkEeAqDf/Rq
X-Google-Smtp-Source: AGHT+IHuCw6IlDpWujNFu50s6SeTHaw+23ZfZcLCN5zf5QBQZOpBGoJig/6yaGz8saMNSIZtlq9+KA==
X-Received: by 2002:a2e:b8cb:0:b0:2fb:3445:a4af with SMTP id 38308e7fff4ca-2fc9d31133cmr40221691fa.21.1729794692924;
        Thu, 24 Oct 2024 11:31:32 -0700 (PDT)
Received: from localhost.localdomain (46-138-2-161.dynamic.spd-mgts.ru. [46.138.2.161])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2fb9ae1262bsm14769871fa.117.2024.10.24.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:31:32 -0700 (PDT)
From: Artem Sdvizhkov <raclesdv@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Artem Sdvizhkov <raclesdv@gmail.com>,
	lvc-project@linuxtesting.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Eric Anholt <eric@anholt.net>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 5.10] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)
Date: Thu, 24 Oct 2024 21:31:06 +0300
Message-Id: <20241024183106.26151-1-raclesdv@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Wachowski, Karol" <karol.wachowski@intel.com>

commit 39bc27bd688066a63e56f7f64ad34fae03fbe3b8 upstream.

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
[Artem: bp to fix CVE-2024-39497, in order to adapt this patch to branch 5.10
add header file mm/internal.h]
Signed-off-by: Artem Sdvizhkov <raclesdv@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e8f07305e279..37f347f39c88 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -17,6 +17,8 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 
+#include "../../../mm/internal.h"   /* is_cow_mapping() */
+
 /**
  * DOC: overview
  *
@@ -630,6 +632,9 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 		return ret;
 	}
 
+	if (is_cow_mapping(vma->vm_flags))
+		return -EINVAL;
+
 	shmem = to_drm_gem_shmem_obj(obj);
 
 	ret = drm_gem_shmem_get_pages(shmem);
-- 
2.43.0


