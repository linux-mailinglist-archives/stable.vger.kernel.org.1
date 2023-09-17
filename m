Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631D7A38BB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjIQTjo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbjIQTjN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:39:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E524103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:39:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE7BC433C8;
        Sun, 17 Sep 2023 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979547;
        bh=jrAa2La0ek9WwlO+z0FJ2jz9Nh/J+dy+uac7CySN/Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APJws9w47IvpCoEgdVlKhOWfiq7uASZlB/cWw1XJgtN/6+v1h1GfjTHApRQOPz5yW
         ypTTtdWCJVHyrU9pxGoaGygd9AGFQwedzoC6pZraTSoUSgVoPU2pM020icagouilJj
         Rq8Jkk1N26HXZ+YeXD+pO+56GhibNAfw7tTheYOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhenyu Wang <zhenyuw@linux.intel.com>,
        Hang Yuan <hang.yuan@linux.intel.com>,
        Colin Xu <colin.xu@intel.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 345/406] drm/i915/gvt: Save/restore HW status to support GVT suspend/resume
Date:   Sun, 17 Sep 2023 21:13:19 +0200
Message-ID: <20230917191110.386938233@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Xu <colin.xu@intel.com>

[ Upstream commit 5f60b12edcd0c2e83650a6f9aa4a969bd9fc5732 ]

This patch save/restore necessary GVT info during i915 suspend/resume so
that GVT enabled QEMU VM can continue running.

Only GGTT and fence regs are saved/restored now. GVT will save GGTT
entries on each host_entry update, restore the saved dirty entries
and re-init fence regs in resume routine.

V2:
- Change kzalloc/kfree to vzalloc/vfree since the space allocated
from kmalloc may not enough for all saved GGTT entries.
- Keep gvt suspend/resume wrapper in intel_gvt.h/intel_gvt.c and
move the actual implementation to gvt.h/gvt.c. (zhenyu)
- Check gvt config on and active with intel_gvt_active(). (zhenyu)

V3: (zhenyu)
- Incorrect copy length. Should be num entries * entry size.
- Use memcpy_toio()/memcpy_fromio() instead of memcpy for iomem.
- Add F_PM_SAVE flags to indicate which MMIOs to save/restore for PM.

V4:
Rebase.

V5:
Fail intel_gvt_save_ggtt as -ENOMEM if fail to alloc memory to save
ggtt. Free allocated ggtt_entries on failure.

V6:
Save host entry to per-vGPU gtt.ggtt_mm on each host_entry update.

V7:
Restore GGTT entry based on present bit.
Split fence restore and mmio restore in different functions.

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Hang Yuan <hang.yuan@linux.intel.com>
Signed-off-by: Colin Xu <colin.xu@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20201027045308.158955-1-colin.xu@intel.com
Stable-dep-of: a90c367e5af6 ("drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gvt/gtt.c      | 64 +++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/gtt.h      |  4 ++
 drivers/gpu/drm/i915/gvt/gvt.c      |  9 ++++
 drivers/gpu/drm/i915/gvt/gvt.h      |  3 ++
 drivers/gpu/drm/i915/gvt/handlers.c | 44 ++++++++++++++++++--
 drivers/gpu/drm/i915/gvt/mmio.h     |  4 ++
 drivers/gpu/drm/i915/intel_gvt.c    | 15 +++++++
 drivers/gpu/drm/i915/intel_gvt.h    |  5 +++
 8 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 0201f9b5f87e7..2029f8521a5dc 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -636,9 +636,18 @@ static void ggtt_set_host_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
 	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	unsigned long offset = index;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_GGTT);
 
+	if (vgpu_gmadr_is_aperture(mm->vgpu, index << I915_GTT_PAGE_SHIFT)) {
+		offset -= (vgpu_aperture_gmadr_base(mm->vgpu) >> PAGE_SHIFT);
+		mm->ggtt_mm.host_ggtt_aperture[offset] = entry->val64;
+	} else if (vgpu_gmadr_is_hidden(mm->vgpu, index << I915_GTT_PAGE_SHIFT)) {
+		offset -= (vgpu_hidden_gmadr_base(mm->vgpu) >> PAGE_SHIFT);
+		mm->ggtt_mm.host_ggtt_hidden[offset] = entry->val64;
+	}
+
 	pte_ops->set_entry(NULL, entry, index, false, 0, mm->vgpu);
 }
 
@@ -1953,6 +1962,21 @@ static struct intel_vgpu_mm *intel_vgpu_create_ggtt_mm(struct intel_vgpu *vgpu)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	mm->ggtt_mm.host_ggtt_aperture = vzalloc((vgpu_aperture_sz(vgpu) >> PAGE_SHIFT) * sizeof(u64));
+	if (!mm->ggtt_mm.host_ggtt_aperture) {
+		vfree(mm->ggtt_mm.virtual_ggtt);
+		vgpu_free_mm(mm);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mm->ggtt_mm.host_ggtt_hidden = vzalloc((vgpu_hidden_sz(vgpu) >> PAGE_SHIFT) * sizeof(u64));
+	if (!mm->ggtt_mm.host_ggtt_hidden) {
+		vfree(mm->ggtt_mm.host_ggtt_aperture);
+		vfree(mm->ggtt_mm.virtual_ggtt);
+		vgpu_free_mm(mm);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return mm;
 }
 
@@ -1980,6 +2004,8 @@ void _intel_vgpu_mm_release(struct kref *mm_ref)
 		invalidate_ppgtt_mm(mm);
 	} else {
 		vfree(mm->ggtt_mm.virtual_ggtt);
+		vfree(mm->ggtt_mm.host_ggtt_aperture);
+		vfree(mm->ggtt_mm.host_ggtt_hidden);
 	}
 
 	vgpu_free_mm(mm);
@@ -2861,3 +2887,41 @@ void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu)
 	intel_vgpu_destroy_all_ppgtt_mm(vgpu);
 	intel_vgpu_reset_ggtt(vgpu, true);
 }
+
+/**
+ * intel_gvt_restore_ggtt - restore all vGPU's ggtt entries
+ * @gvt: intel gvt device
+ *
+ * This function is called at driver resume stage to restore
+ * GGTT entries of every vGPU.
+ *
+ */
+void intel_gvt_restore_ggtt(struct intel_gvt *gvt)
+{
+	struct intel_vgpu *vgpu;
+	struct intel_vgpu_mm *mm;
+	int id;
+	gen8_pte_t pte;
+	u32 idx, num_low, num_hi, offset;
+
+	/* Restore dirty host ggtt for all vGPUs */
+	idr_for_each_entry(&(gvt)->vgpu_idr, vgpu, id) {
+		mm = vgpu->gtt.ggtt_mm;
+
+		num_low = vgpu_aperture_sz(vgpu) >> PAGE_SHIFT;
+		offset = vgpu_aperture_gmadr_base(vgpu) >> PAGE_SHIFT;
+		for (idx = 0; idx < num_low; idx++) {
+			pte = mm->ggtt_mm.host_ggtt_aperture[idx];
+			if (pte & _PAGE_PRESENT)
+				write_pte64(vgpu->gvt->gt->ggtt, offset + idx, pte);
+		}
+
+		num_hi = vgpu_hidden_sz(vgpu) >> PAGE_SHIFT;
+		offset = vgpu_hidden_gmadr_base(vgpu) >> PAGE_SHIFT;
+		for (idx = 0; idx < num_hi; idx++) {
+			pte = mm->ggtt_mm.host_ggtt_hidden[idx];
+			if (pte & _PAGE_PRESENT)
+				write_pte64(vgpu->gvt->gt->ggtt, offset + idx, pte);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index 52d0d88abd86a..b0e173f2d9904 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -164,6 +164,9 @@ struct intel_vgpu_mm {
 		} ppgtt_mm;
 		struct {
 			void *virtual_ggtt;
+			/* Save/restore for PM */
+			u64 *host_ggtt_aperture;
+			u64 *host_ggtt_hidden;
 			struct list_head partial_pte_list;
 		} ggtt_mm;
 	};
@@ -280,5 +283,6 @@ int intel_vgpu_emulate_ggtt_mmio_write(struct intel_vgpu *vgpu,
 	unsigned int off, void *p_data, unsigned int bytes);
 
 void intel_vgpu_destroy_all_ppgtt_mm(struct intel_vgpu *vgpu);
+void intel_gvt_restore_ggtt(struct intel_gvt *gvt);
 
 #endif /* _GVT_GTT_H_ */
diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 5c9ef8e58a087..87f22a88925ce 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -405,6 +405,15 @@ int intel_gvt_init_device(struct drm_i915_private *i915)
 	return ret;
 }
 
+int
+intel_gvt_pm_resume(struct intel_gvt *gvt)
+{
+	intel_gvt_restore_fence(gvt);
+	intel_gvt_restore_mmio(gvt);
+	intel_gvt_restore_ggtt(gvt);
+	return 0;
+}
+
 int
 intel_gvt_register_hypervisor(struct intel_gvt_mpt *m)
 {
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index a81cf0f01e78e..b3d6355dd797d 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -255,6 +255,8 @@ struct intel_gvt_mmio {
 #define F_CMD_ACCESS	(1 << 3)
 /* This reg has been accessed by a VM */
 #define F_ACCESSED	(1 << 4)
+/* This reg requires save & restore during host PM suspend/resume */
+#define F_PM_SAVE	(1 << 5)
 /* This reg could be accessed by unaligned address */
 #define F_UNALIGN	(1 << 6)
 /* This reg is in GVT's mmio save-restor list and in hardware
@@ -685,6 +687,7 @@ void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_debugfs_init(struct intel_gvt *gvt);
 void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
 
+int intel_gvt_pm_resume(struct intel_gvt *gvt);
 
 #include "trace.h"
 #include "mpt.h"
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index 606e6c315fe24..55ce7aaabf893 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -3135,9 +3135,10 @@ static int init_skl_mmio_info(struct intel_gvt *gvt)
 	MMIO_DFH(TRVATTL3PTRDW(2), D_SKL_PLUS, F_CMD_ACCESS, NULL, NULL);
 	MMIO_DFH(TRVATTL3PTRDW(3), D_SKL_PLUS, F_CMD_ACCESS, NULL, NULL);
 	MMIO_DFH(TRVADR, D_SKL_PLUS, F_CMD_ACCESS, NULL, NULL);
-	MMIO_DFH(TRTTE, D_SKL_PLUS, F_CMD_ACCESS,
-		NULL, gen9_trtte_write);
-	MMIO_DH(_MMIO(0x4dfc), D_SKL_PLUS, NULL, gen9_trtt_chicken_write);
+	MMIO_DFH(TRTTE, D_SKL_PLUS, F_CMD_ACCESS | F_PM_SAVE,
+		 NULL, gen9_trtte_write);
+	MMIO_DFH(_MMIO(0x4dfc), D_SKL_PLUS, F_PM_SAVE,
+		 NULL, gen9_trtt_chicken_write);
 
 	MMIO_D(_MMIO(0x46430), D_SKL_PLUS);
 
@@ -3686,3 +3687,40 @@ int intel_vgpu_mmio_reg_rw(struct intel_vgpu *vgpu, unsigned int offset,
 		intel_vgpu_default_mmio_read(vgpu, offset, pdata, bytes) :
 		intel_vgpu_default_mmio_write(vgpu, offset, pdata, bytes);
 }
+
+void intel_gvt_restore_fence(struct intel_gvt *gvt)
+{
+	struct intel_vgpu *vgpu;
+	int i, id;
+
+	idr_for_each_entry(&(gvt)->vgpu_idr, vgpu, id) {
+		mmio_hw_access_pre(gvt->gt);
+		for (i = 0; i < vgpu_fence_sz(vgpu); i++)
+			intel_vgpu_write_fence(vgpu, i, vgpu_vreg64(vgpu, fence_num_to_offset(i)));
+		mmio_hw_access_post(gvt->gt);
+	}
+}
+
+static inline int mmio_pm_restore_handler(struct intel_gvt *gvt,
+					  u32 offset, void *data)
+{
+	struct intel_vgpu *vgpu = data;
+	struct drm_i915_private *dev_priv = gvt->gt->i915;
+
+	if (gvt->mmio.mmio_attribute[offset >> 2] & F_PM_SAVE)
+		I915_WRITE(_MMIO(offset), vgpu_vreg(vgpu, offset));
+
+	return 0;
+}
+
+void intel_gvt_restore_mmio(struct intel_gvt *gvt)
+{
+	struct intel_vgpu *vgpu;
+	int id;
+
+	idr_for_each_entry(&(gvt)->vgpu_idr, vgpu, id) {
+		mmio_hw_access_pre(gvt->gt);
+		intel_gvt_for_each_tracked_mmio(gvt, mmio_pm_restore_handler, vgpu);
+		mmio_hw_access_post(gvt->gt);
+	}
+}
diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/mmio.h
index cc4812648bf4a..9e862dc73579b 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.h
+++ b/drivers/gpu/drm/i915/gvt/mmio.h
@@ -104,4 +104,8 @@ int intel_vgpu_mmio_reg_rw(struct intel_vgpu *vgpu, unsigned int offset,
 
 int intel_vgpu_mask_mmio_write(struct intel_vgpu *vgpu, unsigned int offset,
 				  void *p_data, unsigned int bytes);
+
+void intel_gvt_restore_fence(struct intel_gvt *gvt);
+void intel_gvt_restore_mmio(struct intel_gvt *gvt);
+
 #endif
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 99fe8aef1c67f..4e70c1a9ef2ed 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -24,6 +24,7 @@
 #include "i915_drv.h"
 #include "i915_vgpu.h"
 #include "intel_gvt.h"
+#include "gvt/gvt.h"
 
 /**
  * DOC: Intel GVT-g host support
@@ -147,3 +148,17 @@ void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 
 	intel_gvt_clean_device(dev_priv);
 }
+
+/**
+ * intel_gvt_resume - GVT resume routine wapper
+ *
+ * @dev_priv: drm i915 private *
+ *
+ * This function is called at the i915 driver resume stage to restore required
+ * HW status for GVT so that vGPU can continue running after resumed.
+ */
+void intel_gvt_resume(struct drm_i915_private *dev_priv)
+{
+	if (intel_gvt_active(dev_priv))
+		intel_gvt_pm_resume(dev_priv->gvt);
+}
diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/intel_gvt.h
index 502fad8a8652c..d7d3fb6186fdd 100644
--- a/drivers/gpu/drm/i915/intel_gvt.h
+++ b/drivers/gpu/drm/i915/intel_gvt.h
@@ -33,6 +33,7 @@ int intel_gvt_init_device(struct drm_i915_private *dev_priv);
 void intel_gvt_clean_device(struct drm_i915_private *dev_priv);
 int intel_gvt_init_host(void);
 void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
+void intel_gvt_resume(struct drm_i915_private *dev_priv);
 #else
 static inline int intel_gvt_init(struct drm_i915_private *dev_priv)
 {
@@ -46,6 +47,10 @@ static inline void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 static inline void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
 {
 }
+
+static inline void intel_gvt_resume(struct drm_i915_private *dev_priv)
+{
+}
 #endif
 
 #endif /* _INTEL_GVT_H_ */
-- 
2.40.1



