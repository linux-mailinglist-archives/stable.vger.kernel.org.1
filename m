Return-Path: <stable+bounces-97790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D689E259A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9235E288042
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B081F8919;
	Tue,  3 Dec 2024 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw5MMwwd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F461F75B9;
	Tue,  3 Dec 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241742; cv=none; b=nqswRvjvMmfJ8SuknJnVO/GvknQdv5ryzjXxK2rOHGygIJejFXy8d+w3f7+bogaZhSMOoRJdJoBHYB1pQZx2Puvv9TOOSvjqBakOJwEuAJr7kod/iAxphdijpipTMSoZFfijycfNff0SnyAee3t/Yyorfe7uJrPI0lY4EtgH1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241742; c=relaxed/simple;
	bh=GChH/jFCdkIBNyblvULtWTux4IPlCojVUfqnBTARLcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nKrmauBcIq2MqZX/6SjOkzwqmw9zazt8JoFn0ZnUZ0+VXjbMXaVC2s4iMCgIpCT/+6JskcLhUZZbA2tYxBCl5HIyKkzaxiwAht1bvn+C5EkVmrkJ/vQ6+HNU59mA4z/Sdg7WJsz+9Ym4ydFDAbwN1YgFfdGuyxl65InZ6XBuMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw5MMwwd; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4668f208f10so42556821cf.3;
        Tue, 03 Dec 2024 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733241739; x=1733846539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WTzDeex6MvV2fYh0DDtmM+R3bGWHPFsxwrTc0tB2Uk=;
        b=hw5MMwwdaMmckAb70vhL6gF2HOgDzfU7SF4NwC//02/bG2oy3/icEDCM5wKyyzxbpY
         UIVdtpdtsIOKm1PgMfyjD/Qvg4WOCh6HBIeOOlD7ipeATUwZ3Vk9VY3ppol1YNkXwJnx
         2h72CDqoLHZ5VdQkSX59czxE1QRCMeLh58uSEtFNQR2kmxsHCELwdu2V5DkBZBunC36G
         sLHVOkWMj+85hY/vja/DlJjmIin2Q2zJ4GuT/okiUnX6MBWhzEQxhAF+YsMiTH2uPj/V
         8k11HNn50aLdigbwVsc4seMk+BK8x0r/jiKu9h9MuIeFbrZKtbZsfS2AMJcxRzoJ45jv
         7lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241739; x=1733846539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WTzDeex6MvV2fYh0DDtmM+R3bGWHPFsxwrTc0tB2Uk=;
        b=rXDEFUazvj+ufSMel9u7+Y+HOUOFRcXMWyjsxSumn777F4vMvT3Qw81kEr2Q1OnPXj
         KvterSNrbOLTlQg11LoSyhQSkBYSa5sTy8+gAa7XfVs8PU4d/snF869u0KyCKOim2ITF
         o8F/smcleGDblcBvJ52lOd35JQUn6nrxVQHuHycGC3WCwZj4ADDXJVPGK6obUuM3bfC8
         onzHjQ8lBpRhBy2ISIfqWsrTb4DYn17Q+iOPuka6Zs4CBv8IIA/n0FH3n5d8G7h1Frgo
         1Mg1P7iThO0ybEb82SVsWwX/ZIaX5YiWDWpYpvtb5JGoGMRSsa606VHCcyKerSWrC0E9
         uuJw==
X-Forwarded-Encrypted: i=1; AJvYcCWg6CGIZ/7NvjBT2tmaNbR/vIwpcj8hOpo8h4X0ARE3Wq1YyQSRIYjN0/BEd0hBnO7ekeo/X9qvNECbHA==@vger.kernel.org, AJvYcCXcLS7r2+3dcwuDTy2f7mrrRiC7oio4aYclyUPS/mTL8wGUeMxuyVwq9ambhflibueEWv4K/A9D@vger.kernel.org
X-Gm-Message-State: AOJu0YwAU6ajYQrRNAb7IzkswaqR89z7ZMORew2DlSl9Cx7//cCAuN46
	mrBdKYj5PE+CSxnaRkE18O0oX5IojBL502UUdIb2TjLu1nn/Nu8l
X-Gm-Gg: ASbGncu3oH7w+CuDsCgL748ukAusOkfPcRqbNkK2rAldQttribgx1TJkQvvbzrnBsEM
	meIkkypzbEoyAugg2ZKSHiMJsXQUzVvtAJkGjhpuOQv0W30iFe/SrvfAo8EzMD7FhAVrmgXqNVx
	5oImbwob7/Pnv4og0kB2ZI7xP08VbpNBr/fS8g7I7fghiw7aAzf3atUYTBdeKFXgVAo93ARp3kP
	stOP6u8Xy7a3KUl5YjzW9n/VrjlaVFX+LqK4gwGyIQAX6ev/KLS1JoPsTzyDp3Ikk5A/spAqqwP
	yUAZQU4G49Ofv+KKrnx7TJi+DUtDm/+YizvWYoWLKqTaMss1e5JkXVStW0U=
X-Google-Smtp-Source: AGHT+IGDeeGWcRCTKyUCOq7c8fevpRJKKIBDhzv1JtFZuhU7+1av0GGQHLhd5L0WUnUDcgzYEzYebw==
X-Received: by 2002:ac8:5a8b:0:b0:466:ad0d:f0ca with SMTP id d75a77b69052e-4670c6c5432mr40809661cf.50.1733241739116;
        Tue, 03 Dec 2024 08:02:19 -0800 (PST)
Received: from localhost.localdomain (host-36-26.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c42319b6sm62809341cf.77.2024.12.03.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:02:18 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mst@redhat.com,
	airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm: cast calculation to __u64 to fix potential integer overflow
Date: Tue,  3 Dec 2024 10:02:00 -0600
Message-Id: <20241203160159.8129-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

Like commit b0b0d811eac6 ("drm/mediatek: Fix coverity issue with
unintentional integer overflow"), directly multiply pitch and
height may lead to integer overflow. Add a cast to avoid it.

Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal()")
Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Fixes: dc6057ecb39e ("drm/tegra: gem: dumb: pitch and size are outputs")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 6 +++---
 drivers/gpu/drm/tegra/gem.c          | 2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 870b90b78bc4..020c3b17fc02 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -272,8 +272,8 @@ int drm_gem_dma_dumb_create_internal(struct drm_file *file_priv,
 	if (args->pitch < min_pitch)
 		args->pitch = min_pitch;
 
-	if (args->size < args->pitch * args->height)
-		args->size = args->pitch * args->height;
+	if (args->size < (__u64)args->pitch * args->height)
+		args->size = (__u64)args->pitch * args->height;
 
 	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
 						 &args->handle);
@@ -306,7 +306,7 @@ int drm_gem_dma_dumb_create(struct drm_file *file_priv,
 	struct drm_gem_dma_object *dma_obj;
 
 	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
-	args->size = args->pitch * args->height;
+	args->size = (__u64)args->pitch * args->height;
 
 	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
 						 &args->handle);
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index d275404ad0e9..a84acdbbbe3f 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -548,7 +548,7 @@ int tegra_bo_dumb_create(struct drm_file *file, struct drm_device *drm,
 	struct tegra_bo *bo;
 
 	args->pitch = round_up(min_pitch, tegra->pitch_align);
-	args->size = args->pitch * args->height;
+	args->size = (__u64)args->pitch * args->height;
 
 	bo = tegra_bo_create_with_handle(file, drm, args->size, 0,
 					 &args->handle);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..d5407316b12e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -72,7 +72,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 		return -EINVAL;
 
 	pitch = args->width * 4;
-	args->size = pitch * args->height;
+	args->size = (__u64)pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
 	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
-- 
2.34.1


