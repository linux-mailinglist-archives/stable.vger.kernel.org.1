Return-Path: <stable+bounces-69443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A795626F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC084B2109F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7AF14A4DD;
	Mon, 19 Aug 2024 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIeH0L+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3AC140E38;
	Mon, 19 Aug 2024 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040793; cv=none; b=ZjEVLCilS4j+rn6pY9wMXQbwvrA1jI/xSWolUub+DYtR/MrJl3NZD9wBU50qt2Njz/BRT6W4Hucj7oGvao2uPKGzRh32DSgZF5dLFq4aGxs2wSAqTn07g2cM57LP93net5597K63v6KGcK+BomGOuMHYwSD+uWGdxNChX0/w+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040793; c=relaxed/simple;
	bh=7weB/3INcjsi1mcWxyh/o0OJTMN/GPa9/brKFo0b0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5rAWE1hUbhR9ybUOYyn32TG8s8dd4StErM9/lm1qPPvfTcN0B/JB0z7xH2GJJCX+llKLm5/JHQZzIldPkb7RJU8zRljNFIgQDWEkyYTgOYphtm+BwEYX7i4g0AnfMoIdgQiW26BzHwhgJeTdNs7uMKaK7ICR9c8iCYvtks9Kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIeH0L+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3722EC4AF0C;
	Mon, 19 Aug 2024 04:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040792;
	bh=7weB/3INcjsi1mcWxyh/o0OJTMN/GPa9/brKFo0b0EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIeH0L+EVgp9u4RWTXKxjHgsNrSUWeKqg03MW65TkGJQ+aHRJlUIsvUNl6zX2F1GV
	 wTwiOf6V2CB9WsYpHu1UkErGVhFQsHeh8+rKemwntdvolJ9t8Mktxtk+27a7mxz0I4
	 FjBBDsYATYWKOAU+VdkXVf/6LG5lHI6+SzxbcKy8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.106
Date: Mon, 19 Aug 2024 06:13:02 +0200
Message-ID: <2024081902-bondless-degrading-44ca@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081902-glowworm-troubling-7825@gregkh>
References: <2024081902-glowworm-troubling-7825@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 08ca316cb46d..f0fd656e9da3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 105
+SUBLEVEL = 106
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index ae5f6b5ac80f..f0167dc7438f 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -475,7 +475,7 @@ static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 		kvm_clear_pte(ptep);
 		dsb(ishst);
-		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), level);
+		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), 0);
 	} else {
 		if (end - addr < granule)
 			return -EINVAL;
@@ -699,8 +699,14 @@ static void stage2_put_pte(kvm_pte_t *ptep, struct kvm_s2_mmu *mmu, u64 addr,
 	 * Clear the existing PTE, and perform break-before-make with
 	 * TLB maintenance if it was valid.
 	 */
-	if (kvm_pte_valid(*ptep)) {
+	kvm_pte_t pte = *ptep;
+
+	if (kvm_pte_valid(pte)) {
 		kvm_clear_pte(ptep);
+
+		if (kvm_pte_table(pte, level))
+			level = 0;
+
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
 	}
 
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index fcb668984f03..b344b1f91715 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c8970453b4d9..0e71b8763c4c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -900,8 +900,19 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq, verbose);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
-		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
+		/*
+		 * ATA PASS-THROUGH INFORMATION AVAILABLE
+		 *
+		 * Note: we are supposed to call ata_scsi_set_sense(), which
+		 * respects the D_SENSE bit, instead of unconditionally
+		 * generating the sense data in descriptor format. However,
+		 * because hdparm, hddtemp, and udisks incorrectly assume sense
+		 * data in descriptor format, without even looking at the
+		 * RESPONSE CODE field in the returned sense data (to see which
+		 * format the returned sense data is in), we are stuck with
+		 * being bug compatible with older kernels.
+		 */
+		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
 
 	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index d7e30d889a5c..7e9310d01dfd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -290,6 +290,41 @@ static vm_fault_t vm_fault_cpu(struct vm_fault *vmf)
 	return i915_error_to_vmf_fault(err);
 }
 
+static void set_address_limits(struct vm_area_struct *area,
+			       struct i915_vma *vma,
+			       unsigned long obj_offset,
+			       unsigned long *start_vaddr,
+			       unsigned long *end_vaddr)
+{
+	unsigned long vm_start, vm_end, vma_size; /* user's memory parameters */
+	long start, end; /* memory boundaries */
+
+	/*
+	 * Let's move into the ">> PAGE_SHIFT"
+	 * domain to be sure not to lose bits
+	 */
+	vm_start = area->vm_start >> PAGE_SHIFT;
+	vm_end = area->vm_end >> PAGE_SHIFT;
+	vma_size = vma->size >> PAGE_SHIFT;
+
+	/*
+	 * Calculate the memory boundaries by considering the offset
+	 * provided by the user during memory mapping and the offset
+	 * provided for the partial mapping.
+	 */
+	start = vm_start;
+	start -= obj_offset;
+	start += vma->gtt_view.partial.offset;
+	end = start + vma_size;
+
+	start = max_t(long, start, vm_start);
+	end = min_t(long, end, vm_end);
+
+	/* Let's move back into the "<< PAGE_SHIFT" domain */
+	*start_vaddr = (unsigned long)start << PAGE_SHIFT;
+	*end_vaddr = (unsigned long)end << PAGE_SHIFT;
+}
+
 static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 {
 #define MIN_CHUNK_PAGES (SZ_1M >> PAGE_SHIFT)
@@ -302,14 +337,18 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 	bool write = area->vm_flags & VM_WRITE;
 	struct i915_gem_ww_ctx ww;
+	unsigned long obj_offset;
+	unsigned long start, end; /* memory boundaries */
 	intel_wakeref_t wakeref;
 	struct i915_vma *vma;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	int srcu;
 	int ret;
 
-	/* We don't use vmf->pgoff since that has the fake offset */
+	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
 	page_offset = (vmf->address - area->vm_start) >> PAGE_SHIFT;
+	page_offset += obj_offset;
 
 	trace_i915_gem_object_fault(obj, page_offset, true, write);
 
@@ -393,12 +432,14 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	if (ret)
 		goto err_unpin;
 
+	set_address_limits(area, vma, obj_offset, &start, &end);
+
+	pfn = (ggtt->gmadr.start + i915_ggtt_offset(vma)) >> PAGE_SHIFT;
+	pfn += (start - area->vm_start) >> PAGE_SHIFT;
+	pfn += obj_offset - vma->gtt_view.partial.offset;
+
 	/* Finally, remap it using the new GTT offset */
-	ret = remap_io_mapping(area,
-			       area->vm_start + (vma->gtt_view.partial.offset << PAGE_SHIFT),
-			       (ggtt->gmadr.start + vma->node.start) >> PAGE_SHIFT,
-			       min_t(u64, vma->size, area->vm_end - area->vm_start),
-			       &ggtt->iomap);
+	ret = remap_io_mapping(area, start, pfn, end - start, &ggtt->iomap);
 	if (ret)
 		goto err_fence;
 
@@ -928,53 +969,15 @@ static struct file *mmap_singleton(struct drm_i915_private *i915)
 	return file;
 }
 
-/*
- * This overcomes the limitation in drm_gem_mmap's assignment of a
- * drm_gem_object as the vma->vm_private_data. Since we need to
- * be able to resolve multiple mmap offsets which could be tied
- * to a single gem object.
- */
-int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+static int
+i915_gem_object_mmap(struct drm_i915_gem_object *obj,
+		     struct i915_mmap_offset *mmo,
+		     struct vm_area_struct *vma)
 {
-	struct drm_vma_offset_node *node;
-	struct drm_file *priv = filp->private_data;
-	struct drm_device *dev = priv->minor->dev;
-	struct drm_i915_gem_object *obj = NULL;
-	struct i915_mmap_offset *mmo = NULL;
+	struct drm_i915_private *i915 = to_i915(obj->base.dev);
+	struct drm_device *dev = &i915->drm;
 	struct file *anon;
 
-	if (drm_dev_is_unplugged(dev))
-		return -ENODEV;
-
-	rcu_read_lock();
-	drm_vma_offset_lock_lookup(dev->vma_offset_manager);
-	node = drm_vma_offset_exact_lookup_locked(dev->vma_offset_manager,
-						  vma->vm_pgoff,
-						  vma_pages(vma));
-	if (node && drm_vma_node_is_allowed(node, priv)) {
-		/*
-		 * Skip 0-refcnted objects as it is in the process of being
-		 * destroyed and will be invalid when the vma manager lock
-		 * is released.
-		 */
-		if (!node->driver_private) {
-			mmo = container_of(node, struct i915_mmap_offset, vma_node);
-			obj = i915_gem_object_get_rcu(mmo->obj);
-
-			GEM_BUG_ON(obj && obj->ops->mmap_ops);
-		} else {
-			obj = i915_gem_object_get_rcu
-				(container_of(node, struct drm_i915_gem_object,
-					      base.vma_node));
-
-			GEM_BUG_ON(obj && !obj->ops->mmap_ops);
-		}
-	}
-	drm_vma_offset_unlock_lookup(dev->vma_offset_manager);
-	rcu_read_unlock();
-	if (!obj)
-		return node ? -EACCES : -EINVAL;
-
 	if (i915_gem_object_is_readonly(obj)) {
 		if (vma->vm_flags & VM_WRITE) {
 			i915_gem_object_put(obj);
@@ -1006,7 +1009,7 @@ int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (obj->ops->mmap_ops) {
 		vma->vm_page_prot = pgprot_decrypted(vm_get_page_prot(vma->vm_flags));
 		vma->vm_ops = obj->ops->mmap_ops;
-		vma->vm_private_data = node->driver_private;
+		vma->vm_private_data = obj->base.vma_node.driver_private;
 		return 0;
 	}
 
@@ -1044,6 +1047,93 @@ int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * This overcomes the limitation in drm_gem_mmap's assignment of a
+ * drm_gem_object as the vma->vm_private_data. Since we need to
+ * be able to resolve multiple mmap offsets which could be tied
+ * to a single gem object.
+ */
+int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct drm_vma_offset_node *node;
+	struct drm_file *priv = filp->private_data;
+	struct drm_device *dev = priv->minor->dev;
+	struct drm_i915_gem_object *obj = NULL;
+	struct i915_mmap_offset *mmo = NULL;
+
+	if (drm_dev_is_unplugged(dev))
+		return -ENODEV;
+
+	rcu_read_lock();
+	drm_vma_offset_lock_lookup(dev->vma_offset_manager);
+	node = drm_vma_offset_exact_lookup_locked(dev->vma_offset_manager,
+						  vma->vm_pgoff,
+						  vma_pages(vma));
+	if (node && drm_vma_node_is_allowed(node, priv)) {
+		/*
+		 * Skip 0-refcnted objects as it is in the process of being
+		 * destroyed and will be invalid when the vma manager lock
+		 * is released.
+		 */
+		if (!node->driver_private) {
+			mmo = container_of(node, struct i915_mmap_offset, vma_node);
+			obj = i915_gem_object_get_rcu(mmo->obj);
+
+			GEM_BUG_ON(obj && obj->ops->mmap_ops);
+		} else {
+			obj = i915_gem_object_get_rcu
+				(container_of(node, struct drm_i915_gem_object,
+					      base.vma_node));
+
+			GEM_BUG_ON(obj && !obj->ops->mmap_ops);
+		}
+	}
+	drm_vma_offset_unlock_lookup(dev->vma_offset_manager);
+	rcu_read_unlock();
+	if (!obj)
+		return node ? -EACCES : -EINVAL;
+
+	return i915_gem_object_mmap(obj, mmo, vma);
+}
+
+int i915_gem_fb_mmap(struct drm_i915_gem_object *obj, struct vm_area_struct *vma)
+{
+	struct drm_i915_private *i915 = to_i915(obj->base.dev);
+	struct drm_device *dev = &i915->drm;
+	struct i915_mmap_offset *mmo = NULL;
+	enum i915_mmap_type mmap_type;
+	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
+
+	if (drm_dev_is_unplugged(dev))
+		return -ENODEV;
+
+	/* handle ttm object */
+	if (obj->ops->mmap_ops) {
+		/*
+		 * ttm fault handler, ttm_bo_vm_fault_reserved() uses fake offset
+		 * to calculate page offset so set that up.
+		 */
+		vma->vm_pgoff += drm_vma_node_start(&obj->base.vma_node);
+	} else {
+		/* handle stolen and smem objects */
+		mmap_type = i915_ggtt_has_aperture(ggtt) ? I915_MMAP_TYPE_GTT : I915_MMAP_TYPE_WC;
+		mmo = mmap_offset_attach(obj, mmap_type, NULL);
+		if (IS_ERR(mmo))
+			return PTR_ERR(mmo);
+
+		vma->vm_pgoff += drm_vma_node_start(&mmo->vma_node);
+	}
+
+	/*
+	 * When we install vm_ops for mmap we are too late for
+	 * the vm_ops->open() which increases the ref_count of
+	 * this obj and then it gets decreased by the vm_ops->close().
+	 * To balance this increase the obj ref_count here.
+	 */
+	obj = i915_gem_object_get(obj);
+	return i915_gem_object_mmap(obj, mmo, vma);
+}
+
 #if IS_ENABLED(CONFIG_DRM_I915_SELFTEST)
 #include "selftests/i915_gem_mman.c"
 #endif
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.h b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
index 1fa91b3033b3..196417fd0f5c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
@@ -29,5 +29,5 @@ void i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
 
 void i915_gem_object_runtime_pm_release_mmap_offset(struct drm_i915_gem_object *obj);
 void i915_gem_object_release_mmap_offset(struct drm_i915_gem_object *obj);
-
+int i915_gem_fb_mmap(struct drm_i915_gem_object *obj, struct vm_area_struct *vma);
 #endif
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 6cf6d08cc4ec..58eea8ab5477 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -23,40 +23,11 @@ static int dvb_usb_force_pid_filter_usage;
 module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
 MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
 
-static int dvb_usb_check_bulk_endpoint(struct dvb_usb_device *d, u8 endpoint)
-{
-	if (endpoint) {
-		int ret;
-
-		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
-		if (ret)
-			return ret;
-		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static void dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)
-{
-	if (endpoint) {
-		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
-		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
-	}
-}
-
 static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 {
 	struct dvb_usb_adapter *adap;
 	int ret, n, o;
 
-	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint);
-	if (ret)
-		return ret;
-	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint_response);
-	if (ret)
-		return ret;
 	for (n = 0; n < d->props.num_adapters; n++) {
 		adap = &d->adapter[n];
 		adap->dev = d;
@@ -132,8 +103,10 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	 * when reloading the driver w/o replugging the device
 	 * sometimes a timeout occurs, this helps
 	 */
-	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
-	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
+	if (d->props.generic_bulk_ctrl_endpoint != 0) {
+		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
+		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
+	}
 
 	return 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6f648b58cbd4..c309709ac9b5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3109,6 +3109,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c26545d71d39..cd6d5bbb4b9d 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -72,8 +72,10 @@
 
 #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
 #define DATA_START_OFFSET_WORDS		(0)
+#define MAX_SHARED_LIBS_UPDATE		(0)
 #else
 #define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
+#define MAX_SHARED_LIBS_UPDATE		(MAX_SHARED_LIBS)
 #endif
 
 struct lib_info {
@@ -880,7 +882,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		return res;
 
 	/* Update data segment pointers for all libraries */
-	for (i = 0; i < MAX_SHARED_LIBS; i++) {
+	for (i = 0; i < MAX_SHARED_LIBS_UPDATE; i++) {
 		if (!libinfo.lib_list[i].loaded)
 			continue;
 		for (j = 0; j < MAX_SHARED_LIBS; j++) {
diff --git a/fs/exec.c b/fs/exec.c
index b01434d6a512..481b6e7df6ae 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1603,6 +1603,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	unsigned int mode;
 	kuid_t uid;
 	kgid_t gid;
+	int err;
 
 	if (!mnt_may_suid(file->f_path.mnt))
 		return;
@@ -1619,12 +1620,17 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
-	/* reload atomically mode/uid/gid now that lock held */
+	/* Atomically reload and check mode/uid/gid now that lock held. */
 	mode = inode->i_mode;
 	uid = i_uid_into_mnt(mnt_userns, inode);
 	gid = i_gid_into_mnt(mnt_userns, inode);
+	err = inode_permission(mnt_userns, inode, MAY_EXEC);
 	inode_unlock(inode);
 
+	/* Did the exec bit vanish out from under us? Give up. */
+	if (err)
+		return;
+
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
 		 !kgid_has_mapping(bprm->cred->user_ns, gid))
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 5579e67da17d..c33f78513f00 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -759,8 +759,6 @@ static const struct svc_version *nlmsvc_version[] = {
 #endif
 };
 
-static struct svc_stat		nlmsvc_stats;
-
 #define NLM_NRVERS	ARRAY_SIZE(nlmsvc_version)
 static struct svc_program	nlmsvc_program = {
 	.pg_prog		= NLM_PROGRAM,		/* program number */
@@ -768,7 +766,6 @@ static struct svc_program	nlmsvc_program = {
 	.pg_vers		= nlmsvc_version,	/* version table */
 	.pg_name		= "lockd",		/* service name */
 	.pg_class		= "nfsd",		/* share authentication with nfsd */
-	.pg_stats		= &nlmsvc_stats,	/* stats table */
 	.pg_authenticate	= &lockd_authenticate,	/* export authentication */
 	.pg_init_request	= svc_generic_init_request,
 	.pg_rpcbind_set		= svc_generic_rpcbind_set,
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 46a0a2d6962e..e6445b556ce1 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -407,15 +407,12 @@ static const struct svc_version *nfs4_callback_version[] = {
 	[4] = &nfs4_callback_version4,
 };
 
-static struct svc_stat nfs4_callback_stats;
-
 static struct svc_program nfs4_callback_program = {
 	.pg_prog = NFS4_CALLBACK,			/* RPC service number */
 	.pg_nvers = ARRAY_SIZE(nfs4_callback_version),	/* Number of entries */
 	.pg_vers = nfs4_callback_version,		/* version table */
 	.pg_name = "NFSv4 callback",			/* service name */
 	.pg_class = "nfs",				/* authentication class */
-	.pg_stats = &nfs4_callback_stats,
 	.pg_authenticate = nfs_callback_authenticate,
 	.pg_init_request = svc_generic_init_request,
 	.pg_rpcbind_set	= svc_generic_rpcbind_set,
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..16fadade86cc 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -339,12 +339,16 @@ static int export_stats_init(struct export_stats *stats)
 
 static void export_stats_reset(struct export_stats *stats)
 {
-	nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
+	if (stats)
+		nfsd_percpu_counters_reset(stats->counter,
+					   EXP_STATS_COUNTERS_NUM);
 }
 
 static void export_stats_destroy(struct export_stats *stats)
 {
-	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
+	if (stats)
+		nfsd_percpu_counters_destroy(stats->counter,
+					     EXP_STATS_COUNTERS_NUM);
 }
 
 static void svc_export_put(struct kref *ref)
@@ -353,7 +357,8 @@ static void svc_export_put(struct kref *ref)
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
-	export_stats_destroy(&exp->ex_stats);
+	export_stats_destroy(exp->ex_stats);
+	kfree(exp->ex_stats);
 	kfree(exp->ex_uuid);
 	kfree_rcu(exp, ex_rcu);
 }
@@ -744,13 +749,15 @@ static int svc_export_show(struct seq_file *m,
 	seq_putc(m, '\t');
 	seq_escape(m, exp->ex_client->name, " \t\n\\");
 	if (export_stats) {
-		seq_printf(m, "\t%lld\n", exp->ex_stats.start_time);
+		struct percpu_counter *counter = exp->ex_stats->counter;
+
+		seq_printf(m, "\t%lld\n", exp->ex_stats->start_time);
 		seq_printf(m, "\tfh_stale: %lld\n",
-			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_FH_STALE]));
+			   percpu_counter_sum_positive(&counter[EXP_STATS_FH_STALE]));
 		seq_printf(m, "\tio_read: %lld\n",
-			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_READ]));
+			   percpu_counter_sum_positive(&counter[EXP_STATS_IO_READ]));
 		seq_printf(m, "\tio_write: %lld\n",
-			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_WRITE]));
+			   percpu_counter_sum_positive(&counter[EXP_STATS_IO_WRITE]));
 		seq_putc(m, '\n');
 		return 0;
 	}
@@ -796,7 +803,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
 	new->ex_layout_types = 0;
 	new->ex_uuid = NULL;
 	new->cd = item->cd;
-	export_stats_reset(&new->ex_stats);
+	export_stats_reset(new->ex_stats);
 }
 
 static void export_update(struct cache_head *cnew, struct cache_head *citem)
@@ -832,7 +839,14 @@ static struct cache_head *svc_export_alloc(void)
 	if (!i)
 		return NULL;
 
-	if (export_stats_init(&i->ex_stats)) {
+	i->ex_stats = kmalloc(sizeof(*(i->ex_stats)), GFP_KERNEL);
+	if (!i->ex_stats) {
+		kfree(i);
+		return NULL;
+	}
+
+	if (export_stats_init(i->ex_stats)) {
+		kfree(i->ex_stats);
 		kfree(i);
 		return NULL;
 	}
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d03f7f6a8642..f73e23bb24a1 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -64,10 +64,10 @@ struct svc_export {
 	struct cache_head	h;
 	struct auth_domain *	ex_client;
 	int			ex_flags;
+	int			ex_fsid;
 	struct path		ex_path;
 	kuid_t			ex_anon_uid;
 	kgid_t			ex_anon_gid;
-	int			ex_fsid;
 	unsigned char *		ex_uuid; /* 16 byte fsid */
 	struct nfsd4_fs_locations ex_fslocs;
 	uint32_t		ex_nflavors;
@@ -76,7 +76,7 @@ struct svc_export {
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
 	struct rcu_head		ex_rcu;
-	struct export_stats	ex_stats;
+	struct export_stats	*ex_stats;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 51a4b7885cae..548422b24a7d 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,8 +10,10 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
+#include <linux/sunrpc/stats.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -25,10 +27,22 @@ struct nfsd4_client_tracking_ops;
 
 enum {
 	/* cache misses due only to checksum comparison failures */
-	NFSD_NET_PAYLOAD_MISSES,
+	NFSD_STATS_PAYLOAD_MISSES,
 	/* amount of memory (in bytes) currently consumed by the DRC */
-	NFSD_NET_DRC_MEM_USAGE,
-	NFSD_NET_COUNTERS_NUM
+	NFSD_STATS_DRC_MEM_USAGE,
+	NFSD_STATS_RC_HITS,		/* repcache hits */
+	NFSD_STATS_RC_MISSES,		/* repcache misses */
+	NFSD_STATS_RC_NOCACHE,		/* uncached reqs */
+	NFSD_STATS_FH_STALE,		/* FH stale error */
+	NFSD_STATS_IO_READ,		/* bytes returned to read requests */
+	NFSD_STATS_IO_WRITE,		/* bytes passed in write requests */
+#ifdef CONFIG_NFSD_V4
+	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
+	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
+#define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
+	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
+#endif
+	NFSD_STATS_COUNTERS_NUM
 };
 
 /*
@@ -168,7 +182,10 @@ struct nfsd_net {
 	atomic_t                 num_drc_entries;
 
 	/* Per-netns stats counters */
-	struct percpu_counter    counter[NFSD_NET_COUNTERS_NUM];
+	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
+
+	/* sunrpc svc stats */
+	struct svc_stat          nfsd_svcstats;
 
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b6d768bd5ccc..7451cd34710d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2430,10 +2430,10 @@ nfsd4_proc_null(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-static inline void nfsd4_increment_op_stats(u32 opnum)
+static inline void nfsd4_increment_op_stats(struct nfsd_net *nn, u32 opnum)
 {
 	if (opnum >= FIRST_NFS4_OP && opnum <= LAST_NFS4_OP)
-		percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_NFS4_OP(opnum)]);
+		percpu_counter_inc(&nn->counter[NFSD_STATS_NFS4_OP(opnum)]);
 }
 
 static const struct nfsd4_operation nfsd4_ops[];
@@ -2708,7 +2708,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 					   status, nfsd4_op_name(op->opnum));
 
 		nfsd4_cstate_clear_replay(cstate);
-		nfsd4_increment_op_stats(op->opnum);
+		nfsd4_increment_op_stats(nn, op->opnum);
 	}
 
 	fh_put(current_fh);
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index f53335ae0ab2..50ed64a51551 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -85,8 +85,8 @@ nfsd_hashsize(unsigned int limit)
 }
 
 static struct svc_cacherep *
-nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
-			struct nfsd_net *nn)
+nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum,
+		    struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp;
 
@@ -110,21 +110,48 @@ nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
 	return rp;
 }
 
-static void
-nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
-				struct nfsd_net *nn)
+static void nfsd_cacherep_free(struct svc_cacherep *rp)
 {
-	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
-		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
+	if (rp->c_type == RC_REPLBUFF)
 		kfree(rp->c_replvec.iov_base);
+	kmem_cache_free(drc_slab, rp);
+}
+
+static unsigned long
+nfsd_cacherep_dispose(struct list_head *dispose)
+{
+	struct svc_cacherep *rp;
+	unsigned long freed = 0;
+
+	while (!list_empty(dispose)) {
+		rp = list_first_entry(dispose, struct svc_cacherep, c_lru);
+		list_del(&rp->c_lru);
+		nfsd_cacherep_free(rp);
+		freed++;
 	}
+	return freed;
+}
+
+static void
+nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
+			    struct svc_cacherep *rp)
+{
+	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base)
+		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
 	if (rp->c_state != RC_UNUSED) {
 		rb_erase(&rp->c_node, &b->rb_head);
 		list_del(&rp->c_lru);
 		atomic_dec(&nn->num_drc_entries);
 		nfsd_stats_drc_mem_usage_sub(nn, sizeof(*rp));
 	}
-	kmem_cache_free(drc_slab, rp);
+}
+
+static void
+nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+				struct nfsd_net *nn)
+{
+	nfsd_cacherep_unlink_locked(nn, b, rp);
+	nfsd_cacherep_free(rp);
 }
 
 static void
@@ -132,8 +159,9 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 			struct nfsd_net *nn)
 {
 	spin_lock(&b->cache_lock);
-	nfsd_reply_cache_free_locked(b, rp, nn);
+	nfsd_cacherep_unlink_locked(nn, b, rp);
 	spin_unlock(&b->cache_lock);
+	nfsd_cacherep_free(rp);
 }
 
 int nfsd_drc_slab_create(void)
@@ -148,16 +176,6 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
-{
-	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
-}
-
-static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
-{
-	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
-}
-
 int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
@@ -169,17 +187,13 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	status = nfsd_reply_cache_stats_init(nn);
-	if (status)
-		goto out_nomem;
-
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
 				   "nfsd-reply:%s", nn->nfsd_name);
 	if (status)
-		goto out_stats_destroy;
+		return status;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -195,9 +209,6 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
-out_stats_destroy:
-	nfsd_reply_cache_stats_destroy(nn);
-out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -217,7 +228,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 									rp, nn);
 		}
 	}
-	nfsd_reply_cache_stats_destroy(nn);
 
 	kvfree(nn->drc_hashtbl);
 	nn->drc_hashtbl = NULL;
@@ -244,12 +254,21 @@ nfsd_cache_bucket_find(__be32 xid, struct nfsd_net *nn)
 	return &nn->drc_hashtbl[hash];
 }
 
-static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
-			 unsigned int max)
+/*
+ * Remove and return no more than @max expired entries in bucket @b.
+ * If @max is zero, do not limit the number of removed entries.
+ */
+static void
+nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
+			 unsigned int max, struct list_head *dispose)
 {
+	unsigned long expiry = jiffies - RC_EXPIRE;
 	struct svc_cacherep *rp, *tmp;
-	long freed = 0;
+	unsigned int freed = 0;
+
+	lockdep_assert_held(&b->cache_lock);
 
+	/* The bucket LRU is ordered oldest-first. */
 	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
 		/*
 		 * Don't free entries attached to calls that are still
@@ -257,43 +276,29 @@ static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
 		 */
 		if (rp->c_state == RC_INPROG)
 			continue;
+
 		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
-		    time_before(jiffies, rp->c_timestamp + RC_EXPIRE))
+		    time_before(expiry, rp->c_timestamp))
 			break;
-		nfsd_reply_cache_free_locked(b, rp, nn);
-		if (max && freed++ > max)
-			break;
-	}
-	return freed;
-}
-
-static long nfsd_prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn)
-{
-	return prune_bucket(b, nn, 3);
-}
-
-/*
- * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
- * Also prune the oldest ones when the total exceeds the max number of entries.
- */
-static long
-prune_cache_entries(struct nfsd_net *nn)
-{
-	unsigned int i;
-	long freed = 0;
 
-	for (i = 0; i < nn->drc_hashsize; i++) {
-		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
+		nfsd_cacherep_unlink_locked(nn, b, rp);
+		list_add(&rp->c_lru, dispose);
 
-		if (list_empty(&b->lru_head))
-			continue;
-		spin_lock(&b->cache_lock);
-		freed += prune_bucket(b, nn, 0);
-		spin_unlock(&b->cache_lock);
+		if (max && ++freed > max)
+			break;
 	}
-	return freed;
 }
 
+/**
+ * nfsd_reply_cache_count - count_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Returns the total number of entries in the duplicate reply cache. To
+ * keep things simple and quick, this is not the number of expired entries
+ * in the cache (ie, the number that would be removed by a call to
+ * nfsd_reply_cache_scan).
+ */
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -303,13 +308,43 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 	return atomic_read(&nn->num_drc_entries);
 }
 
+/**
+ * nfsd_reply_cache_scan - scan_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Free expired entries on each bucket's LRU list until we've released
+ * nr_to_scan freed objects. Nothing will be released if the cache
+ * has not exceeded it's max_drc_entries limit.
+ *
+ * Returns the number of entries released by this call.
+ */
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct nfsd_net *nn = container_of(shrink,
 				struct nfsd_net, nfsd_reply_cache_shrinker);
+	unsigned long freed = 0;
+	LIST_HEAD(dispose);
+	unsigned int i;
+
+	for (i = 0; i < nn->drc_hashsize; i++) {
+		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
 
-	return prune_cache_entries(nn);
+		if (list_empty(&b->lru_head))
+			continue;
+
+		spin_lock(&b->cache_lock);
+		nfsd_prune_bucket_locked(nn, b, 0, &dispose);
+		spin_unlock(&b->cache_lock);
+
+		freed += nfsd_cacherep_dispose(&dispose);
+		if (freed > sc->nr_to_scan)
+			break;
+	}
+
+	trace_nfsd_drc_gc(nn, freed);
+	return freed;
 }
 
 /**
@@ -445,16 +480,18 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
 int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 		      unsigned int len)
 {
-	struct nfsd_net		*nn;
+	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep	*rp, *found;
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
 	int type = rqstp->rq_cachetype;
+	unsigned long freed;
+	LIST_HEAD(dispose);
 	int rtn = RC_DOIT;
 
 	rqstp->rq_cacherep = NULL;
 	if (type == RC_NOCACHE) {
-		nfsd_stats_rc_nocache_inc();
+		nfsd_stats_rc_nocache_inc(nn);
 		goto out;
 	}
 
@@ -464,8 +501,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 	 * Since the common case is a cache miss followed by an insert,
 	 * preallocate an entry.
 	 */
-	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
+	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 
@@ -474,25 +510,23 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 	found = nfsd_cache_insert(b, rp, nn);
 	if (found != rp)
 		goto found_entry;
-
-	nfsd_stats_rc_misses_inc();
 	rqstp->rq_cacherep = rp;
 	rp->c_state = RC_INPROG;
+	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
+	spin_unlock(&b->cache_lock);
 
+	freed = nfsd_cacherep_dispose(&dispose);
+	trace_nfsd_drc_gc(nn, freed);
+
+	nfsd_stats_rc_misses_inc(nn);
 	atomic_inc(&nn->num_drc_entries);
 	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
-
-	nfsd_prune_bucket(b, nn);
-
-out_unlock:
-	spin_unlock(&b->cache_lock);
-out:
-	return rtn;
+	goto out;
 
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
 	nfsd_reply_cache_free_locked(NULL, rp, nn);
-	nfsd_stats_rc_hits_inc();
+	nfsd_stats_rc_hits_inc(nn);
 	rtn = RC_DROPIT;
 	rp = found;
 
@@ -525,7 +559,10 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 
 out_trace:
 	trace_nfsd_drc_found(nn, rqstp, rtn);
-	goto out_unlock;
+out_unlock:
+	spin_unlock(&b->cache_lock);
+out:
+	return rtn;
 }
 
 /**
@@ -637,15 +674,15 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
 	seq_printf(m, "mem usage:             %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_DRC_MEM_USAGE]));
 	seq_printf(m, "cache hits:            %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]));
 	seq_printf(m, "cache misses:          %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]));
 	seq_printf(m, "not cached:            %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_NOCACHE]));
 	seq_printf(m, "payload misses:        %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_PAYLOAD_MISSES]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 76a60e7a7509..813ae75e7128 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1450,18 +1450,21 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_stat_counters_init(nn);
+	if (retval)
+		goto out_repcache_error;
+	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
+	nn->nfsd_svcstats.program = &nfsd_program;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
-	retval = nfsd_reply_cache_init(nn);
-	if (retval)
-		goto out_cache_error;
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
+	nfsd_proc_stat_init(net);
 
 	return 0;
 
-out_cache_error:
+out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
@@ -1473,10 +1476,11 @@ static __net_exit void nfsd_exit_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nfsd_reply_cache_shutdown(nn);
+	nfsd_proc_stat_shutdown(net);
+	nfsd_stat_counters_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
-	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd_netns_free_versions(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
@@ -1496,12 +1500,9 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_stat_init();	/* Statistics */
-	if (retval)
-		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
 	if (retval)
-		goto out_free_stat;
+		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
 	retval = create_proc_exports_entry();
 	if (retval)
@@ -1531,8 +1532,6 @@ static int __init init_nfsd(void)
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
-out_free_stat:
-	nfsd_stat_shutdown();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1549,7 +1548,6 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_shutdown();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index fa0144a74267..0e557fb60a0e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -69,6 +69,7 @@ extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
 extern unsigned long		nfsd_drc_mem_used;
+extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 3a2ad88ae648..e73e9d44f1b0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -327,6 +327,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
@@ -395,7 +396,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
-		nfsd_stats_fh_stale_inc(exp);
+		nfsd_stats_fh_stale_inc(nn, exp);
 	return error;
 }
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a8190caf77f1..9eb529969b22 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
+atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -89,7 +90,6 @@ unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-static struct svc_stat	nfsd_acl_svcstats;
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
 	[2] = &nfsd_acl_version2,
@@ -108,15 +108,11 @@ static struct svc_program	nfsd_acl_program = {
 	.pg_vers		= nfsd_acl_version,
 	.pg_name		= "nfsacl",
 	.pg_class		= "nfsd",
-	.pg_stats		= &nfsd_acl_svcstats,
 	.pg_authenticate	= &svc_set_client,
 	.pg_init_request	= nfsd_acl_init_request,
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 };
 
-static struct svc_stat	nfsd_acl_svcstats = {
-	.program	= &nfsd_acl_program,
-};
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {
@@ -141,7 +137,6 @@ struct svc_program		nfsd_program = {
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_stats		= &nfsd_svcstats,	/* version table */
 	.pg_authenticate	= &svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
@@ -427,16 +422,23 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	ret = nfsd_file_cache_start_net(net);
 	if (ret)
 		goto out_lockd;
-	ret = nfs4_state_start_net(net);
+
+	ret = nfsd_reply_cache_init(nn);
 	if (ret)
 		goto out_filecache;
 
+	ret = nfs4_state_start_net(net);
+	if (ret)
+		goto out_reply_cache;
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
 
+out_reply_cache:
+	nfsd_reply_cache_shutdown(nn);
 out_filecache:
 	nfsd_file_cache_shutdown_net(net);
 out_lockd:
@@ -454,6 +456,7 @@ static void nfsd_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfs4_state_shutdown_net(net);
+	nfsd_reply_cache_shutdown(nn);
 	nfsd_file_cache_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
@@ -654,7 +657,8 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
+	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
+				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
 
@@ -952,7 +956,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nfsd_th_cnt);
 
 	set_freezable();
 
@@ -976,7 +980,7 @@ nfsd(void *vrqstp)
 		validate_process_creds();
 	}
 
-	atomic_dec(&nfsdstats.th_cnt);
+	atomic_dec(&nfsd_th_cnt);
 
 out:
 	/* Take an extra ref so that the svc_put in svc_exit_thread()
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 777e24e5da33..36f1373bbe3f 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,25 +27,22 @@
 
 #include "nfsd.h"
 
-struct nfsd_stats	nfsdstats;
-struct svc_stat		nfsd_svcstats = {
-	.program	= &nfsd_program,
-};
-
 static int nfsd_show(struct seq_file *seq, void *v)
 {
+	struct net *net = pde_data(file_inode(seq->file));
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int i;
 
 	seq_printf(seq, "rc %lld %lld %lld\nfh %lld 0 0 0 0\nio %lld %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_FH_STALE]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_READ]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_WRITE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_NOCACHE]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_FH_STALE]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_READ]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
-	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
+	seq_printf(seq, "th %u 0", atomic_read(&nfsd_th_cnt));
 
 	/* deprecated thread usage histogram stats */
 	for (i = 0; i < 10; i++)
@@ -55,7 +52,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "\nra 0 0 0 0 0 0 0 0 0 0 0 0\n");
 
 	/* show my rpc info */
-	svc_seq_show(seq, &nfsd_svcstats);
+	svc_seq_show(seq, &nn->nfsd_svcstats);
 
 #ifdef CONFIG_NFSD_V4
 	/* Show count for individual nfsv4 operations */
@@ -63,7 +60,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_printf(seq,"proc4ops %u", LAST_NFS4_OP + 1);
 	for (i = 0; i <= LAST_NFS4_OP; i++) {
 		seq_printf(seq, " %lld",
-			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
+			   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_NFS4_OP(i)]));
 	}
 
 	seq_putc(seq, '\n');
@@ -74,7 +71,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
 {
 	int i, err = 0;
 
@@ -106,31 +103,24 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
 		percpu_counter_destroy(&counters[i]);
 }
 
-static int nfsd_stat_counters_init(void)
+int nfsd_stat_counters_init(struct nfsd_net *nn)
 {
-	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-static void nfsd_stat_counters_destroy(void)
+void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 {
-	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-int nfsd_stat_init(void)
+void nfsd_proc_stat_init(struct net *net)
 {
-	int err;
-
-	err = nfsd_stat_counters_init();
-	if (err)
-		return err;
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
-
-	return 0;
+	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
-void nfsd_stat_shutdown(void)
+void nfsd_proc_stat_shutdown(struct net *net)
 {
-	nfsd_stat_counters_destroy();
-	svc_proc_unregister(&init_net, "nfsd");
+	svc_proc_unregister(net, "nfsd");
 }
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b43dc3d9991..14525e854cba 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,87 +10,66 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-
-enum {
-	NFSD_STATS_RC_HITS,		/* repcache hits */
-	NFSD_STATS_RC_MISSES,		/* repcache misses */
-	NFSD_STATS_RC_NOCACHE,		/* uncached reqs */
-	NFSD_STATS_FH_STALE,		/* FH stale error */
-	NFSD_STATS_IO_READ,		/* bytes returned to read requests */
-	NFSD_STATS_IO_WRITE,		/* bytes passed in write requests */
-#ifdef CONFIG_NFSD_V4
-	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
-	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
-#define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
-#endif
-	NFSD_STATS_COUNTERS_NUM
-};
-
-struct nfsd_stats {
-	struct percpu_counter	counter[NFSD_STATS_COUNTERS_NUM];
-
-	atomic_t	th_cnt;		/* number of available threads */
-};
-
-extern struct nfsd_stats	nfsdstats;
-
-extern struct svc_stat		nfsd_svcstats;
-
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
-int nfsd_stat_init(void);
-void nfsd_stat_shutdown(void);
-
-static inline void nfsd_stats_rc_hits_inc(void)
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
+int nfsd_stat_counters_init(struct nfsd_net *nn);
+void nfsd_stat_counters_destroy(struct nfsd_net *nn);
+void nfsd_proc_stat_init(struct net *net);
+void nfsd_proc_stat_shutdown(struct net *net);
+
+static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_HITS]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_RC_HITS]);
 }
 
-static inline void nfsd_stats_rc_misses_inc(void)
+static inline void nfsd_stats_rc_misses_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_MISSES]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_RC_MISSES]);
 }
 
-static inline void nfsd_stats_rc_nocache_inc(void)
+static inline void nfsd_stats_rc_nocache_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_RC_NOCACHE]);
 }
 
-static inline void nfsd_stats_fh_stale_inc(struct svc_export *exp)
+static inline void nfsd_stats_fh_stale_inc(struct nfsd_net *nn,
+					   struct svc_export *exp)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
-	if (exp)
-		percpu_counter_inc(&exp->ex_stats.counter[EXP_STATS_FH_STALE]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_FH_STALE]);
+	if (exp && exp->ex_stats)
+		percpu_counter_inc(&exp->ex_stats->counter[EXP_STATS_FH_STALE]);
 }
 
-static inline void nfsd_stats_io_read_add(struct svc_export *exp, s64 amount)
+static inline void nfsd_stats_io_read_add(struct nfsd_net *nn,
+					  struct svc_export *exp, s64 amount)
 {
-	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
-	if (exp)
-		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_READ], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_IO_READ], amount);
+	if (exp && exp->ex_stats)
+		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_READ], amount);
 }
 
-static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
+static inline void nfsd_stats_io_write_add(struct nfsd_net *nn,
+					   struct svc_export *exp, s64 amount)
 {
-	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
-	if (exp)
-		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_WRITE], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_IO_WRITE], amount);
+	if (exp && exp->ex_stats)
+		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_WRITE], amount);
 }
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]);
 }
 
 static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_sub(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 #endif /* _NFSD_STATS_H */
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 84f26f281fe9..447b3483f94b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1261,6 +1261,28 @@ TRACE_EVENT(nfsd_drc_mismatch,
 		__entry->ingress)
 );
 
+TRACE_EVENT_CONDITION(nfsd_drc_gc,
+	TP_PROTO(
+		const struct nfsd_net *nn,
+		unsigned long freed
+	),
+	TP_ARGS(nn, freed),
+	TP_CONDITION(freed > 0),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+		__field(unsigned long, freed)
+		__field(int, total)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+		__entry->freed = freed;
+		__entry->total = atomic_read(&nn->num_drc_entries);
+	),
+	TP_printk("boot_time=%16llx total=%d freed=%lu",
+		__entry->boot_time, __entry->total, __entry->freed
+	)
+);
+
 TRACE_EVENT(nfsd_cb_args,
 	TP_PROTO(
 		const struct nfs4_client *clp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5d6a61d47a90..17e96e58e772 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -983,7 +983,9 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsd_stats_io_read_add(fhp->fh_export, host_err);
+		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+
+		nfsd_stats_io_read_add(nn, fhp->fh_export, host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1126,7 +1128,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsd_stats_io_write_add(exp, *cnt);
+	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
 	if (host_err < 0)
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6e01f10f0d88..be8980b02355 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -525,6 +525,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;	/* Must be near the top */
+
 	/*
 	 * The root cgroup. The containing cgroup_root will be destroyed on its
 	 * release. cgrp->ancestors[0] will be used overflowing into the
@@ -538,9 +542,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 88de45491376..912da376ef9b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -422,7 +422,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	int			(*pg_authenticate)(struct svc_rqst *);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
@@ -493,7 +492,9 @@ void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
-struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
+struct svc_serv *  svc_create_pooled(struct svc_program *prog,
+				     struct svc_stat *stats,
+				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 367b0a42ada9..2fbd29a1c1e7 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -170,7 +170,8 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1e008ea467c0..489c25713edc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1346,7 +1346,7 @@ static void cgroup_exit_root_id(struct cgroup_root *root)
 
 void cgroup_free_root(struct cgroup_root *root)
 {
-	kfree(root);
+	kfree_rcu(root, rcu);
 }
 
 static void cgroup_destroy_root(struct cgroup_root *root)
@@ -1379,7 +1379,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1419,7 +1419,15 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res_cgroup);
+	/*
+	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
+	 * before we remove the cgroup root from the root_list. Consequently,
+	 * when accessing a cgroup root, the cset_link may have already been
+	 * freed, resulting in a NULL res_cgroup. However, by holding the
+	 * cgroup_mutex, we ensure that res_cgroup can't be NULL.
+	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
+	 * check.
+	 */
 	return res_cgroup;
 }
 
@@ -1468,7 +1476,6 @@ static struct cgroup *current_cgns_cgroup_dfl(void)
 static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 					    struct cgroup_root *root)
 {
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	return __cset_cgroup_from_root(cset, root);
@@ -1476,7 +1483,9 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2037,7 +2046,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2120,7 +2129,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index daf53d685b5f..d469ad6c6a0b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -950,7 +950,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	}
 
 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	     (!mp_opt->echo || subflow->mp_join))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2b5a5680f09a..368886d3faac 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -352,7 +352,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -360,10 +360,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -377,7 +377,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -524,8 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -567,8 +567,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -579,16 +577,26 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		local = select_signal_address(pernet, msk);
+		if (!local)
+			goto subflow;
+
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			return;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {
@@ -596,9 +604,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 278ba5955dfd..f2b90053ecae 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -225,7 +225,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9e582725ccb4..4515cc6b649f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -812,7 +812,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 52908f9e6eab..9a0b3e8cc62d 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 666d738bcf07..9ae85347ab39 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -453,8 +453,8 @@ __svc_init_bc(struct svc_serv *serv)
  * Create an RPC service
  */
 static struct svc_serv *
-__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
-	     int (*threadfn)(void *data))
+__svc_create(struct svc_program *prog, struct svc_stat *stats,
+	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
 	unsigned int vers;
@@ -466,7 +466,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
 	kref_init(&serv->sv_refcnt);
-	serv->sv_stats     = prog->pg_stats;
+	serv->sv_stats     = stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
 	serv->sv_max_payload = bufsize? bufsize : 4096;
@@ -528,26 +528,28 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
 			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, bufsize, 1, threadfn);
+	return __svc_create(prog, NULL, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
 /**
  * svc_create_pooled - Create an RPC service with pooled threads
  * @prog: the RPC program the new service will handle
+ * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
  *
  * Returns an instantiated struct svc_serv object or NULL.
  */
 struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   struct svc_stat *stats,
 				   unsigned int bufsize,
 				   int (*threadfn)(void *data))
 {
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, bufsize, npools, threadfn);
+	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	return serv;
@@ -1324,7 +1326,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto err_bad_proc;
 
 	/* Syntactic check complete */
-	serv->sv_stats->rpccnt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
 	/* Build the reply header. */
@@ -1377,7 +1380,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto close_xprt;
 
 err_bad_rpc:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, 1);	/* REJECT */
 	svc_putnl(resv, 0);	/* RPC_MISMATCH */
 	svc_putnl(resv, 2);	/* Only RPCv2 supported */
@@ -1387,7 +1391,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));
-	serv->sv_stats->rpcbadauth++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
 	xdr_ressize_check(rqstp, reply_statp);
 	svc_putnl(resv, 1);	/* REJECT */
@@ -1397,7 +1402,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", prog);
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_UNAVAIL);
 	goto sendit;
 
@@ -1405,7 +1411,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_printk(rqstp, "unknown version (%d for prog %d, %s)\n",
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_MISMATCH);
 	svc_putnl(resv, process.mismatch.lovers);
 	svc_putnl(resv, process.mismatch.hivers);
@@ -1414,7 +1421,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 err_bad_proc:
 	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROC_UNAVAIL);
 	goto sendit;
 
@@ -1423,7 +1431,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 	rpc_stat = rpc_garbage_args;
 err_bad:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, ntohl(rpc_stat));
 	goto sendit;
 }
@@ -1469,7 +1478,8 @@ svc_process(struct svc_rqst *rqstp)
 out_baddir:
 	svc_printk(rqstp, "bad direction 0x%08x, dropping request\n",
 		   be32_to_cpu(dir));
-	rqstp->rq_server->sv_stats->rpcbadfmt++;
+	if (rqstp->rq_server->sv_stats)
+		rqstp->rq_server->sv_stats->rpcbadfmt++;
 out_drop:
 	svc_drop(rqstp);
 	return 0;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 214eee6105c7..dd9695306fb8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -463,6 +463,10 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
+static struct netlink_range_validation q_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -745,7 +749,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
-	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
+	[NL80211_ATTR_TXQ_QUANTUM] = NLA_POLICY_FULL_RANGE(NLA_U32, &q_range),
 	[NL80211_ATTR_HE_CAPABILITY] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_he_capa,
 				       NL80211_HE_MAX_CAPABILITY_LEN),
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d3cbfa6a704f..fcb8a36d4a06 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1062,6 +1062,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
+	const size_t maxlen = SNDRV_CTL_ELEM_ID_NAME_MAXLEN;
 	struct snd_soc_tplg_dapm_graph_elem *elem;
 	struct snd_soc_dapm_route *route;
 	int count, i;
@@ -1085,39 +1086,22 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		tplg->pos += sizeof(struct snd_soc_tplg_dapm_graph_elem);
 
 		/* validate routes */
-		if (strnlen(elem->source, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
-			ret = -EINVAL;
-			break;
-		}
-		if (strnlen(elem->sink, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
-			ret = -EINVAL;
-			break;
-		}
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
+		if ((strnlen(elem->source, maxlen) == maxlen) ||
+		    (strnlen(elem->sink, maxlen) == maxlen) ||
+		    (strnlen(elem->control, maxlen) == maxlen)) {
 			ret = -EINVAL;
 			break;
 		}
 
-		route->source = devm_kmemdup(tplg->dev, elem->source,
-					     min(strlen(elem->source),
-						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
-					     GFP_KERNEL);
-		route->sink = devm_kmemdup(tplg->dev, elem->sink,
-					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
-					   GFP_KERNEL);
+		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
+		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
 		if (!route->source || !route->sink) {
 			ret = -ENOMEM;
 			break;
 		}
 
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) != 0) {
-			route->control = devm_kmemdup(tplg->dev, elem->control,
-						      min(strlen(elem->control),
-							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
-						      GFP_KERNEL);
+		if (strnlen(elem->control, maxlen) != 0) {
+			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
 			if (!route->control) {
 				ret = -ENOMEM;
 				break;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a28310764654..a73358d753aa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2090,6 +2090,20 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3

