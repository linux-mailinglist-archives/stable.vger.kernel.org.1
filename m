Return-Path: <stable+bounces-151559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15748ACF88B
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAA81893B27
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75627E7D9;
	Thu,  5 Jun 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="KI9nhAcI"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BA17548
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153841; cv=none; b=IborKHg5s+KgwHK+JkuntJtYyKWffzMaMqf05lCsgYvvMiIkYKaXQEZ9PVX+HH5KtMVhqO6Ai29TQG5LlBHrPGUokEnzBrK9ictyBZ5EYK7NAYRAxclHCylrR/VvPDceWn8VhGxhT9bEnv28RkKOYUkW5Q/rOt6qFP1iRTOLNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153841; c=relaxed/simple;
	bh=o1vWj2peYFzT+9B8W1tqxLwFgYA9lzDCmka4MeMf2gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q56KV4HA8TwIkZIpJH+xzuPKHpeHoM+0KUkZCLXxjaH6wE7XwLAWXMvJVdncdxyfpT2VxB8+/jBJ3H51XmFtKNsGNtQN1X0qVJbibLIKyLlYLkn+SPTrJo3t+p6OV+k53Ov3L9oGmxX7MpnX31bpFmIQAl/3+yLaqlw9C3tYyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=KI9nhAcI; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 0E6BA1C11FD
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 23:03:46 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1749153825; x=
	1750017826; bh=o1vWj2peYFzT+9B8W1tqxLwFgYA9lzDCmka4MeMf2gg=; b=K
	I9nhAcIiu7lrXTn3NaSpYUL8bNKN3JuEZPUAtssONVOxwA0OfQrmMVRtqDrTfQST
	kfd5pvsOhmYcS89KLUgIxIfiT1B07gzs9+gNkR1YbWtLTB6hmsD1SiWoIZQ8MmcF
	WObORsAQhNJAosjXCOvEpGDGM+Y6fvXsMWBkPfkouw=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o_D6JRCMg3Z9 for <stable@vger.kernel.org>;
	Thu,  5 Jun 2025 23:03:45 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 786081C0D75;
	Thu,  5 Jun 2025 23:03:40 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: 
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau/instmem/gk20a: fix overflow in IOVA calculation for iommu_map/unmap
Date: Thu,  5 Jun 2025 20:03:23 +0000
Message-ID: <20250605200332.336245-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix possible overflow in the address expression used as the second
argument to iommu_map() and iommu_unmap(). Without an explicit cast,
this expression may overflow when 'r->offset' or 'i' are large. Cast
the result to unsigned long before shifting to ensure correct IOVA
computation and prevent unintended wraparound.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
index 201022ae9214..17a0e1a46211 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
@@ -334,7 +334,7 @@ gk20a_instobj_dtor_iommu(struct nvkm_memory *memory)
 	/* Unmap pages from GPU address space and free them */
 	for (i = 0; i < node->base.mn->length; i++) {
 		iommu_unmap(imem->domain,
-			    (r->offset + i) << imem->iommu_pgshift, PAGE_SIZE);
+			    ((unsigned long)r->offset + i) << imem->iommu_pgshift, PAGE_SIZE);
 		dma_unmap_page(dev, node->dma_addrs[i], PAGE_SIZE,
 			       DMA_BIDIRECTIONAL);
 		__free_page(node->pages[i]);
@@ -472,7 +472,7 @@ gk20a_instobj_ctor_iommu(struct gk20a_instmem *imem, u32 npages, u32 align,
 
 	/* Map into GPU address space */
 	for (i = 0; i < npages; i++) {
-		u32 offset = (r->offset + i) << imem->iommu_pgshift;
+		unsigned long offset = ((unsigned long)r->offset + i) << imem->iommu_pgshift;
 
 		ret = iommu_map(imem->domain, offset, node->dma_addrs[i],
 				PAGE_SIZE, IOMMU_READ | IOMMU_WRITE,
-- 
2.43.0


