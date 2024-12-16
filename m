Return-Path: <stable+bounces-104342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A20B9F311A
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230E91887F9C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D6205515;
	Mon, 16 Dec 2024 13:04:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3C19C148FF2;
	Mon, 16 Dec 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354282; cv=none; b=XR34Tr+BkjCbY3DEUZyUbUPZZjl/wUTCOcOmK3JNcgvIV2ZCW3Acd2ETMfAx4mqBn1PAzNnPOVkjbAzqYfbm++edCdDAnyXrZvTJNPAxwSp2BhectXJ0WqOHGcCOyLFJsAcy+fGDnLj8208uzbKqd/A38lWK+6JvZjLefsRCY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354282; c=relaxed/simple;
	bh=vqxXOFHRl25qENardnOS297fxLEdufccVSUcODPUPks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=H4tRQM7z5vOd8x7EcZq/VYmfRvTAAXvEJjvK7IUwtaQKjfBfkBPGOyQeylOWBbfT25LRoWG2DxUvJLKAGHCtELj29AYhxcPI1g/4HL7BLAxr2sVB7T/63FrWr6tJvMyKulFf+Y68HZnc/AGqesXC6YeuiAjtTveMT+oyHnSqiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.3])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 635BE602A5E7F;
	Mon, 16 Dec 2024 21:04:26 +0800 (CST)
X-MD-Sfrom: zhanxin@nfschina.com
X-MD-SrcIP: 103.163.180.3
From: Zhanxin Qi <zhanxin@nfschina.com>
To: kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhanxin Qi <zhanxin@nfschina.com>,
	Duanjun Li <duanjun@nfschina.com>
Subject: [PATCH v1 v1] drm/nouveau: Fix memory leak in nvbios_iccsense_parse
Date: Mon, 16 Dec 2024 21:03:03 +0800
Message-Id: <20241216130303.246223-1-zhanxin@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Z1_2sugsla44LgIz@cassiopeiae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nvbios_iccsense_parse function allocates memory for sensor data
but fails to free it when the function exits, leading to a memory
leak. Add proper cleanup to free the allocated memory.

Fixes: 39b7e6e547ff ("drm/nouveau/nvbios/iccsense: add parsing of the SENSE table")

Cc: stable@vger.kernel.org
Signed-off-by: Zhanxin Qi <zhanxin@nfschina.com>
Signed-off-by: Duanjun Li <duanjun@nfschina.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 .../include/nvkm/subdev/bios/iccsense.h       |  2 ++
 .../drm/nouveau/nvkm/subdev/bios/iccsense.c   | 20 +++++++++++++++++++
 .../drm/nouveau/nvkm/subdev/iccsense/base.c   |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h
index 4c108fd2c805..8bfc28c3f7a7 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h
@@ -20,4 +20,6 @@ struct nvbios_iccsense {
 };
 
 int nvbios_iccsense_parse(struct nvkm_bios *, struct nvbios_iccsense *);
+
+void nvbios_iccsense_cleanup(struct nvbios_iccsense *iccsense);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c
index dea444d48f94..38fcc91ffea6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c
@@ -56,6 +56,19 @@ nvbios_iccsense_table(struct nvkm_bios *bios, u8 *ver, u8 *hdr, u8 *cnt,
 	return 0;
 }
 
+/**
+ * nvbios_iccsense_parse - Parse ICCSENSE table from VBIOS
+ * @bios: VBIOS base pointer
+ * @iccsense: ICCSENSE table structure to fill
+ *
+ * Parses the ICCSENSE table from VBIOS and fills the provided structure.
+ * The caller must invoke nvbios_iccsense_cleanup() after successful parsing
+ * to free the allocated rail resources.
+ *
+ * Returns:
+ *   0        - Success
+ *   -ENODEV  - Table not found
+ */
 int
 nvbios_iccsense_parse(struct nvkm_bios *bios, struct nvbios_iccsense *iccsense)
 {
@@ -127,3 +140,10 @@ nvbios_iccsense_parse(struct nvkm_bios *bios, struct nvbios_iccsense *iccsense)
 
 	return 0;
 }
+
+void
+nvbios_iccsense_cleanup(struct nvbios_iccsense *iccsense)
+{
+	kfree(iccsense->rail);
+	iccsense->rail = NULL;
+}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 8f0ccd3664eb..4c1759ecce38 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -291,6 +291,9 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
+
+	nvbios_iccsense_cleanup(&stbl);
+
 	return 0;
 }
 
-- 
2.30.2


