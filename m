Return-Path: <stable+bounces-64876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B9943B5F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1885A28004B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596717276D;
	Thu,  1 Aug 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkMh2Irl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62384171092;
	Thu,  1 Aug 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471268; cv=none; b=SEGPuXj4ZdOeMojAgVhnmCTFinYugIwTRRoHEJptpzqxjuSEFwsOyH7vl1Z69Qhuc6VM+FH9aRR1BZ+XWzdMqmUzBbhoNexTx/L8pfq2eXwIXy/rn0dYdHHqrpVNxICIJb0IbcHXWT3DQ5jrTyIrBmDrS34b00lEIOkScjUPIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471268; c=relaxed/simple;
	bh=esHJuFnMNtZ9yD6SQgsk+9Gw7KYDFRp6JRZmi4m0PKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F52rvtlrcjjwZPZ+T9kDxVIWkBdJ2Igl7Wqzsub0vun86RnZjAnzBa2wa11z4sALWbhXfVqZuTvm8Awp4zCobDnHer130edflzFpfTlosc6JsNfR7QKHu1tUXMH7sENmvCw32U2V1TKAEmVsfoLeEuvEoN9JIqEbsaPb1/IAkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkMh2Irl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C5DC4AF0F;
	Thu,  1 Aug 2024 00:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471267;
	bh=esHJuFnMNtZ9yD6SQgsk+9Gw7KYDFRp6JRZmi4m0PKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkMh2IrlsrtUm/dft2UmfCd7i7OKe+d1p0VRVWmy4rZrnNotKYGP2dDBVE3wXnDtM
	 qg7Jvbcn8nrMpBeS5+7gZcJoPJu8wMTZEbXn6NsoJ5KNS6OL13mlwXZv5QFl8E0H+3
	 OLwMMyvKmN+YnFxisc6iufQ1CTEPjkDRTnC83T/g/Rg3WiI2Oer02qrU3tkP8hxxCq
	 rymJXGPTwQZKLTLD0pLO3UcpEkbywXbAOkTfgBdx/BM7vqUj/d6Fq2XvOpTTfvg4Wz
	 Gjp1IworWe5Ck8MekAP8NrmtA8J5z1GRhqD4cHFeTi/1NtL05FFDXs+NaFe26rgg2j
	 rAFturoCogkhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 051/121] drm/xe: reset mmio mappings with devm
Date: Wed, 31 Jul 2024 19:59:49 -0400
Message-ID: <20240801000834.3930818-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit c7117419784f612d59ee565145f722e8b5541fe6 ]

Set our various mmio mappings to NULL. This should make it easier to
catch something rogue trying to mess with mmio after device removal. For
example, we might unmap everything and then start hitting some mmio
address which has already been unmamped by us and then remapped by
something else, causing all kinds of carnage.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240522102143.128069-33-matthew.auld@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c |  4 +++-
 drivers/gpu/drm/xe/xe_mmio.c   | 35 ++++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_mmio.h   |  2 +-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 5ef9b50a20d01..a1cbdafbff75e 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -551,7 +551,9 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
-	xe_mmio_probe_tiles(xe);
+	err = xe_mmio_probe_tiles(xe);
+	if (err)
+		return err;
 
 	xe_ttm_sys_mgr_init(xe);
 
diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 2ebb2f0d6874e..9d8fafdf51453 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -254,6 +254,21 @@ static int xe_mmio_tile_vram_size(struct xe_tile *tile, u64 *vram_size,
 	return xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
+static void vram_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+	struct xe_tile *tile;
+	int id;
+
+	if (xe->mem.vram.mapping)
+		iounmap(xe->mem.vram.mapping);
+
+	xe->mem.vram.mapping = NULL;
+
+	for_each_tile(tile, xe, id)
+		tile->mem.vram.mapping = NULL;
+}
+
 int xe_mmio_probe_vram(struct xe_device *xe)
 {
 	struct xe_tile *tile;
@@ -330,10 +345,20 @@ int xe_mmio_probe_vram(struct xe_device *xe)
 	drm_info(&xe->drm, "Available VRAM: %pa, %pa\n", &xe->mem.vram.io_start,
 		 &available_size);
 
-	return 0;
+	return devm_add_action_or_reset(xe->drm.dev, vram_fini, xe);
 }
 
-void xe_mmio_probe_tiles(struct xe_device *xe)
+static void tiles_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+	struct xe_tile *tile;
+	int id;
+
+	for_each_tile(tile, xe, id)
+		tile->mmio.regs = NULL;
+}
+
+int xe_mmio_probe_tiles(struct xe_device *xe)
 {
 	size_t tile_mmio_size = SZ_16M, tile_mmio_ext_size = xe->info.tile_mmio_ext_size;
 	u8 id, tile_count = xe->info.tile_count;
@@ -384,6 +409,8 @@ void xe_mmio_probe_tiles(struct xe_device *xe)
 			regs += tile_mmio_ext_size;
 		}
 	}
+
+	return devm_add_action_or_reset(xe->drm.dev, tiles_fini, xe);
 }
 
 static void mmio_fini(void *arg)
@@ -391,10 +418,6 @@ static void mmio_fini(void *arg)
 	struct xe_device *xe = arg;
 
 	pci_iounmap(to_pci_dev(xe->drm.dev), xe->mmio.regs);
-	if (xe->mem.vram.mapping)
-		iounmap(xe->mem.vram.mapping);
-
-	xe->mem.vram.mapping = NULL;
 	xe->mmio.regs = NULL;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_mmio.h b/drivers/gpu/drm/xe/xe_mmio.h
index a3cd7b3036c73..a929d090bb2f1 100644
--- a/drivers/gpu/drm/xe/xe_mmio.h
+++ b/drivers/gpu/drm/xe/xe_mmio.h
@@ -21,7 +21,7 @@ struct xe_device;
 #define LMEM_BAR		2
 
 int xe_mmio_init(struct xe_device *xe);
-void xe_mmio_probe_tiles(struct xe_device *xe);
+int xe_mmio_probe_tiles(struct xe_device *xe);
 
 u8 xe_mmio_read8(struct xe_gt *gt, struct xe_reg reg);
 u16 xe_mmio_read16(struct xe_gt *gt, struct xe_reg reg);
-- 
2.43.0


