Return-Path: <stable+bounces-140368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC9AAA821
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BE0985452
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D0295505;
	Mon,  5 May 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNMLBjVy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20194343D9D;
	Mon,  5 May 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484708; cv=none; b=iGA5KhD1ye09GpctJsPji0BzJ3E4oR+LP0aNJ0sKo3xBWCld1bedIEPV3oJF8ujOBmlw/+42VMXJSmpllYw+zg02kv+v9lTdPrJno9G0XNjMmaNf+cUlkCQy0DvDs+Bi6yb9IzXXzETAZtJ8nKsJ/e+ME1KUZUerydFoqKX/Hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484708; c=relaxed/simple;
	bh=IUdGjnromgbeJlmYT/AyUMVbmHTRTPIlMYJFH5aqnUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJezEsjXl0PUMpD5l10ZXLyu6vkc5o+bq9716q1HeJ+jOZSeWbX4rj3SIV9JFnJA5ZrnMzefiQP6Zz7NdsdXv7vmpYrRZ6mzuh3GHZpC9fRxKk1+R66Xs2GxmkBlHh90aJcNLfRlKsRnN4h+O67VTu+iB7vKTYGck/B7QKN68pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNMLBjVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2A2C4CEE4;
	Mon,  5 May 2025 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484707;
	bh=IUdGjnromgbeJlmYT/AyUMVbmHTRTPIlMYJFH5aqnUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNMLBjVyXEMonwFozipcPZYx346qEMCZVbBAKZzPEN6G4TN6sR5KTeKgxBh9P4+Bx
	 CMlSz6wVFIhmEm4fZCFfqXRhkCviGlXOQ6U4llkF/1f2cJ2cPihJAgEZcDZNFuAiDs
	 /YL4J2yw8/xMfBFEfLAvSNl3CjEgWd60vlPc0Q6gzF09C+fLnrAWpoS2XCNO21La1r
	 3A7CkeSTN2oWagWyJu4B3m8YI1pfvNlxrbSkcDkkO3bT5+m8wOeW9uuRGgkEXsIIba
	 oxck1abGf8OnX43OOCTGnMLAqTyVlHZlWYqGwAJzz/EL8ks/nAlFZaqltLHQ3KNaMW
	 qrtcVvNOUPsMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 619/642] accel/ivpu: Dump only first MMU fault from single context
Date: Mon,  5 May 2025 18:13:55 -0400
Message-Id: <20250505221419.2672473-619-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

[ Upstream commit 0240fa18d247c99a1967f2fed025296a89a1c5f5 ]

Stop dumping consecutive faults from an already faulty context immediately,
instead of waiting for the context abort thread handler (IRQ handler bottom
half) to abort currently executing jobs.

Remove 'R' (record events) bit from context descriptor of a faulty
context to prevent future faults generation.

This change speeds up the IRQ handler by eliminating the need to print the
fault content repeatedly. Additionally, it prevents flooding dmesg with
errors, which was occurring due to the delay in the bottom half of the
handler stopping fault-generating jobs.

Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-7-maciej.falkowski@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_mmu.c         | 51 ++++++++++++++++++++++++---
 drivers/accel/ivpu/ivpu_mmu_context.c | 13 -------
 drivers/accel/ivpu/ivpu_mmu_context.h |  2 --
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 26ef52fbb93e5..41482666cbcae 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -870,23 +870,64 @@ static u32 *ivpu_mmu_get_event(struct ivpu_device *vdev)
 	return evt;
 }
 
+static int ivpu_mmu_disable_events(struct ivpu_device *vdev, u32 ssid)
+{
+	struct ivpu_mmu_info *mmu = vdev->mmu;
+	struct ivpu_mmu_cdtab *cdtab = &mmu->cdtab;
+	u64 *entry;
+	u64 val;
+
+	if (ssid > IVPU_MMU_CDTAB_ENT_COUNT)
+		return -EINVAL;
+
+	entry = cdtab->base + (ssid * IVPU_MMU_CDTAB_ENT_SIZE);
+
+	val = READ_ONCE(entry[0]);
+	val &= ~IVPU_MMU_CD_0_R;
+	WRITE_ONCE(entry[0], val);
+
+	if (!ivpu_is_force_snoop_enabled(vdev))
+		clflush_cache_range(entry, IVPU_MMU_CDTAB_ENT_SIZE);
+
+	ivpu_mmu_cmdq_write_cfgi_all(vdev);
+
+	return 0;
+}
+
 void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
 {
+	struct ivpu_file_priv *file_priv;
+	u32 last_ssid = -1;
 	u32 *event;
 	u32 ssid;
 
 	ivpu_dbg(vdev, IRQ, "MMU event queue\n");
 
-	while ((event = ivpu_mmu_get_event(vdev)) != NULL) {
-		ivpu_mmu_dump_event(vdev, event);
-
+	while ((event = ivpu_mmu_get_event(vdev))) {
 		ssid = FIELD_GET(IVPU_MMU_EVT_SSID_MASK, event[0]);
+
+		if (ssid == last_ssid)
+			continue;
+
+		xa_lock(&vdev->context_xa);
+		file_priv = xa_load(&vdev->context_xa, ssid);
+		if (file_priv) {
+			if (file_priv->has_mmu_faults) {
+				event = NULL;
+			} else {
+				ivpu_mmu_disable_events(vdev, ssid);
+				file_priv->has_mmu_faults = true;
+			}
+		}
+		xa_unlock(&vdev->context_xa);
+
+		if (event)
+			ivpu_mmu_dump_event(vdev, event);
+
 		if (ssid == IVPU_GLOBAL_CONTEXT_MMU_SSID) {
 			ivpu_pm_trigger_recovery(vdev, "MMU event");
 			return;
 		}
-
-		ivpu_mmu_user_context_mark_invalid(vdev, ssid);
 		REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, vdev->mmu->evtq.cons);
 	}
 
diff --git a/drivers/accel/ivpu/ivpu_mmu_context.c b/drivers/accel/ivpu/ivpu_mmu_context.c
index 0af614dfb6f92..f0267efa55aa8 100644
--- a/drivers/accel/ivpu/ivpu_mmu_context.c
+++ b/drivers/accel/ivpu/ivpu_mmu_context.c
@@ -635,16 +635,3 @@ void ivpu_mmu_reserved_context_fini(struct ivpu_device *vdev)
 	ivpu_mmu_cd_clear(vdev, vdev->rctx.id);
 	ivpu_mmu_context_fini(vdev, &vdev->rctx);
 }
-
-void ivpu_mmu_user_context_mark_invalid(struct ivpu_device *vdev, u32 ssid)
-{
-	struct ivpu_file_priv *file_priv;
-
-	xa_lock(&vdev->context_xa);
-
-	file_priv = xa_load(&vdev->context_xa, ssid);
-	if (file_priv)
-		file_priv->has_mmu_faults = true;
-
-	xa_unlock(&vdev->context_xa);
-}
diff --git a/drivers/accel/ivpu/ivpu_mmu_context.h b/drivers/accel/ivpu/ivpu_mmu_context.h
index 8042fc0670622..f255310968cfe 100644
--- a/drivers/accel/ivpu/ivpu_mmu_context.h
+++ b/drivers/accel/ivpu/ivpu_mmu_context.h
@@ -37,8 +37,6 @@ void ivpu_mmu_global_context_fini(struct ivpu_device *vdev);
 int ivpu_mmu_reserved_context_init(struct ivpu_device *vdev);
 void ivpu_mmu_reserved_context_fini(struct ivpu_device *vdev);
 
-void ivpu_mmu_user_context_mark_invalid(struct ivpu_device *vdev, u32 ssid);
-
 int ivpu_mmu_context_insert_node(struct ivpu_mmu_context *ctx, const struct ivpu_addr_range *range,
 				 u64 size, struct drm_mm_node *node);
 void ivpu_mmu_context_remove_node(struct ivpu_mmu_context *ctx, struct drm_mm_node *node);
-- 
2.39.5


