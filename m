Return-Path: <stable+bounces-104339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C299F30CE
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE91886069
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DA2381B9;
	Mon, 16 Dec 2024 12:47:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 53A12201253;
	Mon, 16 Dec 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353230; cv=none; b=Og8xHgmUMKAboM0exHLJXmmfx/FChSH5fFbNeMsSHATPaBWXYVF+EtGfEP9J7ST/YK/FHdmb7wMJzn1gsRVGpviuuf5XY03G/9IQAhAqGS5TPPd8oca08WPHSCYzBtpXDzZ7P9ZrqzlXeuHkvp2M2HTjBDyBFC31/lcZJ0NRpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353230; c=relaxed/simple;
	bh=buBlJ6UJtroc/F4KzWXn7VsSOU+y458A9/OxJJDAG0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=k6J8dR3psgd2BdTGGr3p4oN6/9McOqSosLGGvYnWWBWacc6U1F3WFBlroO3vBvY1DZSCq5ZYdz8M5dVBZn7/pnizawPGIM7JXJieItwSRJkDYA5aE77AZ7E+N4UWFxa5vXP545vdBJLhgHVv1CWlihY5LkMOb5y8WsHIo+E6sD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.3])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 297C1602A5E6F;
	Mon, 16 Dec 2024 20:47:01 +0800 (CST)
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
Date: Mon, 16 Dec 2024 20:46:52 +0800
Message-Id: <20241216124652.244776-1-zhanxin@nfschina.com>
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


