Return-Path: <stable+bounces-91950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A89C215C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD681C23CDD
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7F21F4A9;
	Fri,  8 Nov 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OvY53SDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DF21C19B;
	Fri,  8 Nov 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081598; cv=none; b=nBrnPj1A+VgPBh1Nnmm+uO7bkqQ5njx3v2CB385FAUd7sfBV4EHgfA6rPHje57vs8gYJD/xOy9GkYFWic5URJk0Btp8XaY9SA8UTCRF56iR8kTOI/yOd/iDagRl8nXj2B9Z0s7Jr65XGwHgzFBn00s0SRRGnTUkyExIeYhHv5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081598; c=relaxed/simple;
	bh=FOJOLfwMWsOu1+n/LYsGOL9WNVZT9A1hCLeGWXS44So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqL4mFpm69Y3S12d1DwNAaXrnEcF4iyqSR9rq66LHpajjj677l0bSZAvWyOmTsKJNSHiWbpE0lOc8XqicRXq91Do8KMT9cLAPiHDhDYc0oF28BN6jRb/rc6HUiSRbEg/ywR+gd+JJGxJlKQZpBHGejz6CzSYKOIGH5r9ojtig5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OvY53SDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03347C4CECD;
	Fri,  8 Nov 2024 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081597;
	bh=FOJOLfwMWsOu1+n/LYsGOL9WNVZT9A1hCLeGWXS44So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvY53SDIOTdhhC66AdxdkoDVozAMFQiO7xP0FYsLirJaWiAhQ5tj7x4RLcAr4MfYD
	 xnfgYqaVEuVGiQ7gAUVTQcggQbWLLCvLr+e2XNAdOhD/4de0vi0PSKrn3h56LexO/n
	 9CtJsAKZUIgZey5xGg04nqQG/GQI4ZwaEAotUvSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.171
Date: Fri,  8 Nov 2024 16:59:29 +0100
Message-ID: <2024110829-synopses-motto-69be@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110829-sibling-charter-755e@gregkh>
References: <2024110829-sibling-charter-755e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index e0680ae9db6b..1081b50f0932 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 170
+SUBLEVEL = 171
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 90f8ce64fa6f..0b6064fec9e0 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2017 SiFive
  */
 
-#define GENERATING_ASM_OFFSETS
-
 #include <linux/kbuild.h>
 #include <linux/sched.h>
 #include <asm/thread_info.h>
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 66ddfba1cfbe..28a3fa6e67d7 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -71,7 +71,7 @@ void __cpu_die(unsigned int cpu)
 	if (cpu_ops[cpu]->cpu_is_stopped)
 		ret = cpu_ops[cpu]->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 8e733aa48ba6..c306f3a6a800 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -59,7 +59,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	0					// DllCharacteristics
+	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b246c3dc6993..d548d6992d98 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -131,8 +131,6 @@
 #define REG_PTR(insn, pos, regs)	\
 	(ulong *)((ulong)(regs) + REG_OFFSET(insn, pos))
 
-#define GET_RM(insn)			(((insn) >> 12) & 7)
-
 #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
 #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
 #define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 06e6b27f3bcc..c1b68f962bad 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-builtin
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ed582fa98cb2..bdf22582a8c0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -199,7 +199,16 @@
  */
 .macro CLEAR_CPU_BUFFERS
 	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
-	verw _ASM_RIP(mds_verw_sel)
+#ifdef CONFIG_X86_64
+	verw mds_verw_sel(%rip)
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	verw %cs:mds_verw_sel
+#endif
 .Lskip_verw_\@:
 .endm
 
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8d14e6c70535..0e9ccedb08da 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -813,7 +813,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
-	spin_lock_init(&cpc_ptr->rmw_lock);
+	raw_spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1020,6 +1020,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 	struct cpc_desc *cpc_desc;
+	unsigned long flags;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1047,7 +1048,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -ENODEV;
 		}
 
-		spin_lock(&cpc_desc->rmw_lock);
+		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
 		switch (size) {
 		case 8:
 			prev_val = readb_relaxed(vaddr);
@@ -1062,7 +1063,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			prev_val = readq_relaxed(vaddr);
 			break;
 		default:
-			spin_unlock(&cpc_desc->rmw_lock);
+			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 			return -EFAULT;
 		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
@@ -1095,7 +1096,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		spin_unlock(&cpc_desc->rmw_lock);
+		raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 
 	return ret_val;
 }
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 09c0af8a46f0..63ead3f1d294 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -49,12 +49,11 @@ struct prm_context_buffer {
 };
 #pragma pack()
 
-
 static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
 	guid_t guid;
-	u64 handler_addr;
+	void *handler_addr;
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;
 
@@ -73,22 +72,24 @@ struct prm_module_info {
 	struct prm_handler_info handlers[];
 };
 
-
-static u64 efi_pa_va_lookup(u64 pa)
+static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 {
 	efi_memory_desc_t *md;
 	u64 pa_offset = pa & ~PAGE_MASK;
 	u64 page = pa & PAGE_MASK;
 
 	for_each_efi_memory_desc(md) {
-		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+		if ((md->attribute & EFI_MEMORY_RUNTIME) &&
+		    (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
+		}
 	}
 
+	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+
 	return 0;
 }
 
-
 #define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *) (a) + a->handler_info_offset))
 #define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(struct acpi_prmt_handler_info) + (char *) a))
 
@@ -139,9 +140,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-		th->handler_addr = efi_pa_va_lookup(handler_info->handler_address);
-		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
-		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+		th->handler_addr =
+			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+
+		th->static_data_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+
+		th->acpi_param_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -171,7 +178,6 @@ static void *find_guid_info(const guid_t *guid, u8 mode)
 	return NULL;
 }
 
-
 static struct prm_module_info *find_prm_module(const guid_t *guid)
 {
 	return (struct prm_module_info *)find_guid_info(guid, GET_MODULE);
@@ -236,6 +242,13 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
+		if (!handler->handler_addr ||
+		    !handler->static_data_buffer_addr ||
+		    !handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			return AE_OK;
+		}
+
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
 		context.reserved = 0x0;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 81572c081333..d995d768c362 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,7 +25,6 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
-#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/swiotlb.h>
@@ -2306,7 +2305,6 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 		      struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2335,12 +2333,8 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	/* Synchronize with module_remove_driver() */
-	rcu_read_lock();
-	driver = READ_ONCE(dev->driver);
-	if (driver)
-		add_uevent_var(env, "DRIVER=%s", driver->name);
-	rcu_read_unlock();
+	if (dev->driver)
+		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2410,8 +2404,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 851cc5367c04..46ad4d636731 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,7 +7,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -78,9 +77,6 @@ void module_remove_driver(struct device_driver *drv)
 	if (!drv)
 		return;
 
-	/* Synchronize with dev_uevent() */
-	synchronize_rcu();
-
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..3e8051fe8296 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
 
 	err = sdei_unregister_shared();
 	if (err)
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 24606b632009..468a3a7cb6a5 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 		return dsi;
 	}
 
-	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
+	dsi->dev.of_node = info->node;
 	dsi->channel = info->channel;
 	strlcpy(dsi->name, info->type, sizeof(dsi->name));
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 0eb4a0739fa2..0a7c4548b77f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1436,6 +1436,10 @@ void i915_gem_init__contexts(struct drm_i915_private *i915)
 	init_contexts(&i915->gem.contexts);
 }
 
+/*
+ * Note that this implicitly consumes the ctx reference, by placing
+ * the ctx in the context_xa.
+ */
 static void gem_context_register(struct i915_gem_context *ctx,
 				 struct drm_i915_file_private *fpriv,
 				 u32 id)
@@ -1449,13 +1453,13 @@ static void gem_context_register(struct i915_gem_context *ctx,
 	snprintf(ctx->name, sizeof(ctx->name), "%s[%d]",
 		 current->comm, pid_nr(ctx->pid));
 
-	/* And finally expose ourselves to userspace via the idr */
-	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
-	WARN_ON(old);
-
 	spin_lock(&i915->gem.contexts.lock);
 	list_add_tail(&ctx->link, &i915->gem.contexts.list);
 	spin_unlock(&i915->gem.contexts.lock);
+
+	/* And finally expose ourselves to userspace via the idr */
+	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
+	WARN_ON(old);
 }
 
 int i915_gem_context_open(struct drm_i915_private *i915,
@@ -1932,14 +1936,22 @@ finalize_create_context_locked(struct drm_i915_file_private *file_priv,
 	if (IS_ERR(ctx))
 		return ctx;
 
+	/*
+	 * One for the xarray and one for the caller.  We need to grab
+	 * the reference *prior* to making the ctx visble to userspace
+	 * in gem_context_register(), as at any point after that
+	 * userspace can try to race us with another thread destroying
+	 * the context under our feet.
+	 */
+	i915_gem_context_get(ctx);
+
 	gem_context_register(ctx, file_priv, id);
 
 	old = xa_erase(&file_priv->proto_context_xa, id);
 	GEM_BUG_ON(old != pc);
 	proto_context_close(pc);
 
-	/* One for the xarray and one for the caller */
-	return i915_gem_context_get(ctx);
+	return ctx;
 }
 
 struct i915_gem_context *
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 471e1311e007..06a541fa3cfe 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -596,7 +596,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0) {
+		if (val2 != 0 || val == 0) {
 			ret = -EINVAL;
 			break;
 		}
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 9b9697d67850..1b895bad8148 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -522,7 +522,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 			}
 			if (mask == IIO_CHAN_INFO_PROCESSED) {
 				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000;
+				*val2 = (reg * data->cur_resolution) % 10000 * 100;
 				return IIO_VAL_INT_PLUS_MICRO;
 			}
 			*val = reg;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index f1aa3e19b6de..dea70db9ee97 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1494,9 +1494,11 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	u32 tbl_indx;
 	int rc;
 
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	RCFW_CMD_PREP(req, DESTROY_QP, cmd_flags);
 
@@ -1504,8 +1506,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
 					  (void *)&resp, NULL, 0);
 	if (rc) {
+		spin_lock_bh(&rcfw->tbl_lock);
 		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
+		spin_unlock_bh(&rcfw->tbl_lock);
 		return rc;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 8d5557e3056c..2394dcc0338c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -320,17 +320,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
+		spin_lock(&rcfw->tbl_lock);
 		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
 		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
+		if (!qp) {
+			spin_unlock(&rcfw->tbl_lock);
+			break;
+		}
+		bnxt_qplib_mark_qp_error(qp);
+		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
+		spin_unlock(&rcfw->tbl_lock);
 		dev_dbg(&pdev->dev, "Received QP error notification\n");
 		dev_dbg(&pdev->dev,
 			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
 			qp_id, err_event->req_err_state_reason,
 			err_event->res_err_state_reason);
-		if (!qp)
-			break;
-		bnxt_qplib_mark_qp_error(qp);
-		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
 		break;
 	default:
 		/*
@@ -631,6 +635,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 			       GFP_KERNEL);
 	if (!rcfw->qp_tbl)
 		goto fail;
+	spin_lock_init(&rcfw->tbl_lock);
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 2acdec55a667..aaf06cd939e6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -186,6 +186,8 @@ struct bnxt_qplib_rcfw {
 	struct bnxt_qplib_crsqe		*crsqe_tbl;
 	int qp_tbl_size;
 	struct bnxt_qplib_qp_node *qp_tbl;
+	/* To synchronize the qp-handle hash table */
+	spinlock_t			tbl_lock;
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index e7337662aff8..8cbbef770086 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -469,6 +469,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
 	.fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
+	.fill_res_qp_entry = c4iw_fill_res_qp_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = c4iw_get_dma_mr,
 	.get_hw_stats = c4iw_get_mib,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d4b5ce37c2cb..d2b4db783b25 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4182,14 +4182,14 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		MLX5_SET(qpc, qpc, retry_count, attr->retry_cnt);
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC && attr->max_rd_atomic)
-		MLX5_SET(qpc, qpc, log_sra_max, ilog2(attr->max_rd_atomic));
+		MLX5_SET(qpc, qpc, log_sra_max, fls(attr->max_rd_atomic - 1));
 
 	if (attr_mask & IB_QP_SQ_PSN)
 		MLX5_SET(qpc, qpc, next_send_psn, attr->sq_psn);
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC && attr->max_dest_rd_atomic)
 		MLX5_SET(qpc, qpc, log_rra_max,
-			 ilog2(attr->max_dest_rd_atomic));
+			 fls(attr->max_dest_rd_atomic - 1));
 
 	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC)) {
 		err = set_qpc_atomic_flags(qp, attr, attr_mask, qpc);
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 0ea923fe6371..e2bdba474293 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -258,7 +258,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -272,7 +271,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 3a16eb8e03f7..9b8bdd57ec85 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -941,10 +941,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 
 again:
 	mutex_lock(&gts->ts_ctxlock);
-	preempt_disable();
 
 	if (gru_check_context_placement(gts)) {
-		preempt_enable();
 		mutex_unlock(&gts->ts_ctxlock);
 		gru_unload_context(gts, 1);
 		return VM_FAULT_NOPAGE;
@@ -953,7 +951,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
 		if (!gru_assign_gru_context(gts)) {
-			preempt_enable();
 			mutex_unlock(&gts->ts_ctxlock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(GRU_ASSIGN_DELAY);  /* true hack ZZZ */
@@ -969,7 +966,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 				vma->vm_page_prot);
 	}
 
-	preempt_enable();
 	mutex_unlock(&gts->ts_ctxlock);
 
 	return VM_FAULT_NOPAGE;
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608d..1107dd3e2e9f 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -65,7 +65,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 	struct gru_tlb_global_handle *tgh;
 	int n;
 
-	preempt_disable();
 	if (uv_numa_blade_id() == gru->gs_blade_id)
 		n = get_on_blade_tgh(gru);
 	else
@@ -79,7 +78,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 static void get_unlock_tgh_handle(struct gru_tlb_global_handle *tgh)
 {
 	unlock_tgh_handle(tgh);
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index da97fccea9ea..769355824b7e 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -103,10 +103,6 @@ static struct net_device * __init mvme147lance_probe(void)
 	address = address >> 8;
 	dev->dev_addr[3] = address&0xff;
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -136,6 +132,9 @@ static struct net_device * __init mvme147lance_probe(void)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b62d153f1676..4a194f30f4a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4110,11 +4110,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
-	tx_q->tx_skbuff_dma[first_entry].buf = des;
-	tx_q->tx_skbuff_dma[first_entry].len = skb_headlen(skb);
-	tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
-	tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
-
 	if (priv->dma_cap.addr64 <= 32) {
 		first->des0 = cpu_to_le32(des);
 
@@ -4133,6 +4128,23 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
 
+	/* In case two or more DMA transmit descriptors are allocated for this
+	 * non-paged SKB data, the DMA buffer address should be saved to
+	 * tx_q->tx_skbuff_dma[].buf corresponding to the last descriptor,
+	 * and leave the other tx_q->tx_skbuff_dma[].buf as NULL to guarantee
+	 * that stmmac_tx_clean() does not unmap the entire DMA buffer too early
+	 * since the tail areas of the DMA buffer can be accessed by DMA engine
+	 * sooner or later.
+	 * By saving the DMA buffer address to tx_q->tx_skbuff_dma[].buf
+	 * corresponding to the last descriptor, stmmac_tx_clean() will unmap
+	 * this DMA buffer right after the DMA engine completely finishes the
+	 * full buffer transmission.
+	 */
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 40c94df382e5..2509d7bccb2b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -858,20 +858,24 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 	unsigned int role = GTP_ROLE_GGSN;
 
 	if (data[IFLA_GTP_FD0]) {
-		u32 fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
+		int fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
 
-		sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
-		if (IS_ERR(sk0))
-			return PTR_ERR(sk0);
+		if (fd0 >= 0) {
+			sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
+			if (IS_ERR(sk0))
+				return PTR_ERR(sk0);
+		}
 	}
 
 	if (data[IFLA_GTP_FD1]) {
-		u32 fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
+		int fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
 
-		sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
-		if (IS_ERR(sk1u)) {
-			gtp_encap_disable_sock(sk0);
-			return PTR_ERR(sk1u);
+		if (fd1 >= 0) {
+			sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
+			if (IS_ERR(sk1u)) {
+				gtp_encap_disable_sock(sk0);
+				return PTR_ERR(sk1u);
+			}
 		}
 	}
 
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 14787d17f703..b71414b3a1d4 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1366,10 +1366,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 
 	if (pos != 0)
 		return -EINVAL;
-	if (size > sizeof(buf))
+	if (size > sizeof(buf) - 1)
 		return -EINVAL;
 	if (copy_from_user(buf, user_buf, size))
 		return -EFAULT;
+	buf[size] = 0;
+
 	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index d5dafbecc184..117616ac6b2f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3035,9 +3035,14 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(struct ath10k *ar,
 				       struct sk_buff *msdu)
 {
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(msdu);
+	struct ath10k_mgmt_tx_pkt_addr *pkt_addr;
 	struct ath10k_wmi *wmi = &ar->wmi;
 
-	idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_lock_bh(&ar->data_lock);
+	pkt_addr = idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_unlock_bh(&ar->data_lock);
+
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index c8ccea542fec..572aabc0541c 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2440,6 +2440,7 @@ wmi_process_mgmt_tx_comp(struct ath10k *ar, struct mgmt_tx_compl_params *param)
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
+	kfree(pkt_addr);
 
 	if (param->status) {
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
@@ -9581,6 +9582,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_pending(int msdu_id, void *ptr,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 5bf2318763c5..8f51099e15c9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -23,6 +23,7 @@ source "drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig"
 config BRCM_TRACING
 	bool "Broadcom device tracing"
 	depends on BRCMSMAC || BRCMFMAC
+	depends on TRACING
 	help
 	  If you say Y here, the Broadcom wireless drivers will register
 	  with ftrace to dump event information into the trace ringbuffer.
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 83c1ff0d660f..8c6c153c455b 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4960,6 +4960,8 @@ il_pci_resume(struct device *device)
 	 */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
 
+	_il_wr(il, CSR_INT, 0xffffffff);
+	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
 	il_enable_interrupts(il);
 
 	if (!(_il_rd(il, CSR_GP_CNTRL) & CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 578956032e08..3009fff9086f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1272,11 +1272,18 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 }
 #endif /* CONFIG_ACPI */
 
+static void iwl_mvm_disconnect_iterator(void *data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_hw_restart_disconnect(vif);
+}
+
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 {
 	u32 error_log_size = mvm->fw->ucode_capa.error_log_size;
+	u32 status = 0;
 	int ret;
-	u32 resp;
 
 	struct iwl_fw_error_recovery_cmd recovery_cmd = {
 		.flags = cpu_to_le32(flags),
@@ -1284,7 +1291,6 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 	};
 	struct iwl_host_cmd host_cmd = {
 		.id = WIDE_ID(SYSTEM_GROUP, FW_ERROR_RECOVERY_CMD),
-		.flags = CMD_WANT_SKB,
 		.data = {&recovery_cmd, },
 		.len = {sizeof(recovery_cmd), },
 	};
@@ -1304,7 +1310,7 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 		recovery_cmd.buf_size = cpu_to_le32(error_log_size);
 	}
 
-	ret = iwl_mvm_send_cmd(mvm, &host_cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &host_cmd, &status);
 	kfree(mvm->error_recovery_buf);
 	mvm->error_recovery_buf = NULL;
 
@@ -1315,11 +1321,15 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 
 	/* skb respond is only relevant in ERROR_RECOVERY_UPDATE_DB */
 	if (flags & ERROR_RECOVERY_UPDATE_DB) {
-		resp = le32_to_cpu(*(__le32 *)host_cmd.resp_pkt->data);
-		if (resp)
+		if (status) {
 			IWL_ERR(mvm,
 				"Failed to send recovery cmd blob was invalid %d\n",
-				resp);
+				status);
+
+			ieee80211_iterate_interfaces(mvm->hw, 0,
+						     iwl_mvm_disconnect_iterator,
+						     mvm);
+		}
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index aa6ef6491205..16818dcdae22 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1753,7 +1753,8 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 			&cp->channel_config[i];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		u8 k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		u32 j;
 		bool force_passive, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index a2524106206d..fbe2036ca619 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1250,7 +1250,7 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 		 */
 		if (rport->port_state == FC_PORTSTATE_ONLINE)
 			rport->port_state = port_state;
-		else
+		else if (port_state != rport->port_state)
 			return -EINVAL;
 	} else if (port_state == FC_PORTSTATE_ONLINE) {
 		/*
@@ -1260,7 +1260,7 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 		 */
 		if (rport->port_state == FC_PORTSTATE_MARGINAL)
 			rport->port_state = port_state;
-		else
+		else if (port_state != rport->port_state)
 			return -EINVAL;
 	} else
 		return -EINVAL;
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 3f1981e287f5..60f4f57aab57 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9832_write_frequency(struct ad9832_state *st,
 				  unsigned int addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (clk_get_rate(st->mclk) / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
+	regval = ad9832_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3dc2124bd02a..bd125ea5c51f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4594,7 +4594,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 	int c;
 
 	if (op->data) {
-		font.data = kmalloc(max_font_size, GFP_KERNEL);
+		font.data = kzalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 3332b31a1354..d358d30569e5 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -527,7 +527,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	pm_runtime_put_noidle(&dev->dev);
 
 	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
-		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get(&dev->dev);
 	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
@@ -554,7 +554,9 @@ static void xhci_pci_remove(struct pci_dev *dev)
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
+		pm_runtime_put(&dev->dev);
+	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_forbid(&dev->dev);
 
 	if (xhci->shared_hcd) {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 15ffa16ba447..ad045eecc658 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1769,6 +1769,14 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
 
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
+
+	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
+	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
+		complete_all(&xhci->cmd_ring_stop_completion);
+		return;
+	}
+
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			cmd_trb);
 	/*
@@ -1785,14 +1793,6 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	cancel_delayed_work(&xhci->cmd_timer);
 
-	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
-
-	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
-	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
-		complete_all(&xhci->cmd_ring_stop_completion);
-		return;
-	}
-
 	if (cmd->command_trb != xhci->cmd_ring->dequeue) {
 		xhci_err(xhci,
 			 "Command completion event does not match command\n");
diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 1b24492bb4e5..da2546b17bec 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -628,7 +628,7 @@ void devm_usb_put_phy(struct device *dev, struct usb_phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
+	r = devres_release(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_usb_put_phy);
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index af75911899f5..7c6f0de5cd97 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2026,6 +2026,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 15f68ee05089..844db95e6651 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -176,9 +176,10 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 
 	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
-		if (sess->state != SMB2_SESSION_VALID ||
-		    time_after(jiffies,
-			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+		if (atomic_read(&sess->refcnt) == 0 &&
+		    (sess->state != SMB2_SESSION_VALID ||
+		     time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT))) {
 			xa_erase(&conn->sessions, sess->id);
 			hash_del(&sess->hlist);
 			ksmbd_session_destroy(sess);
@@ -268,8 +269,6 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
-	if (sess)
-		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -288,6 +287,22 @@ struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
 	return sess;
 }
 
+void ksmbd_user_session_get(struct ksmbd_session *sess)
+{
+	atomic_inc(&sess->refcnt);
+}
+
+void ksmbd_user_session_put(struct ksmbd_session *sess)
+{
+	if (!sess)
+		return;
+
+	if (atomic_read(&sess->refcnt) <= 0)
+		WARN_ON(1);
+	else
+		atomic_dec(&sess->refcnt);
+}
+
 struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
 						    u64 sess_id)
 {
@@ -356,6 +371,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
+	atomic_set(&sess->refcnt, 1);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 63cb08fffde8..ce91b1d698e7 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -61,6 +61,8 @@ struct ksmbd_session {
 	struct ksmbd_file_table		file_table;
 	unsigned long			last_active;
 	rwlock_t			tree_conns_lock;
+
+	atomic_t			refcnt;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
@@ -101,4 +103,6 @@ void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
 void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
+void ksmbd_user_session_get(struct ksmbd_session *sess);
+void ksmbd_user_session_put(struct ksmbd_session *sess);
 #endif /* __USER_SESSION_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 63b01f7d9703..09ebcf39d5bc 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -238,6 +238,8 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	} while (is_chained == true);
 
 send:
+	if (work->sess)
+		ksmbd_user_session_put(work->sess);
 	if (work->tcon)
 		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 089dc2f51229..54f7cf7a98b2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -606,8 +606,10 @@ int smb2_check_user_session(struct ksmbd_work *work)
 
 	/* Check for validity of user session */
 	work->sess = ksmbd_session_lookup_all(conn, sess_id);
-	if (work->sess)
+	if (work->sess) {
+		ksmbd_user_session_get(work->sess);
 		return 1;
+	}
 	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
 	return -ENOENT;
 }
@@ -1761,6 +1763,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		conn->binding = true;
+		ksmbd_user_session_get(sess);
 	} else if ((conn->dialect < SMB30_PROT_ID ||
 		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
@@ -1787,6 +1790,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		}
 
 		conn->binding = false;
+		ksmbd_user_session_get(sess);
 	}
 	work->sess = sess;
 
@@ -2235,7 +2239,9 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	}
 
 	ksmbd_destroy_file_table(&sess->file_table);
+	down_write(&conn->session_lock);
 	sess->state = SMB2_SESSION_EXPIRED;
+	up_write(&conn->session_lock);
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 8124d4f8b29a..ac79ef0d43a7 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -981,6 +981,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	}
 
 	nfs_mark_delegation_revoked(delegation);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	spin_unlock(&delegation->lock);
+	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
+		nfs_put_delegation(delegation);
+	goto out_rcu_unlock;
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index af3a74bd0fbd..e7596701f14f 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -157,6 +157,9 @@ static int nilfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	/* slow symlink */
 	inode->i_op = &nilfs_symlink_inode_operations;
 	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping,
+			     mapping_gfp_constraint(inode->i_mapping,
+						    ~__GFP_FS));
 	inode->i_mapping->a_ops = &nilfs_aops;
 	err = page_symlink(inode, symname, l);
 	if (err)
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 98be72e93b40..7adf74b52550 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -404,6 +404,7 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *bh, *head;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7a1f57dc58df..a74bbfec8e3a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -101,7 +101,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 28f654561f27..09db01c1098c 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bff1934e044e..c1bce9d656cf 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -79,7 +79,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index b4c09b99edd1..7b46926e920c 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -328,7 +328,7 @@ struct mft_inode {
 
 /* Nested class for ntfs_inode::ni_lock. */
 enum ntfs_inode_mutex_lock_class {
-	NTFS_INODE_MUTEX_DIRTY,
+	NTFS_INODE_MUTEX_DIRTY = 1,
 	NTFS_INODE_MUTEX_SECURITY,
 	NTFS_INODE_MUTEX_OBJID,
 	NTFS_INODE_MUTEX_REPARSE,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 403c71a485c7..fc1e929ae038 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1787,6 +1787,14 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		int id_count = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);
+
+		if (byte_start > id_count || byte_start + byte_len > id_count) {
+			ret = -EINVAL;
+			mlog_errno(ret);
+			goto out;
+		}
+
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 0fed87e2a895..28179bb794b2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -65,7 +65,7 @@ struct cpc_desc {
 	int write_cmd_status;
 	int write_cmd_id;
 	/* Lock used for RMW operations in cpc_write() */
-	spinlock_t rmw_lock;
+	raw_spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 0a0de98c0b7f..d8b9942f1afd 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -247,7 +247,7 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	memset(fl4, 0, sizeof(*fl4));
 
 	if (oif) {
-		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index_rcu(net, oif);
+		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index(net, oif);
 		/* Legacy VRF/l3mdev use case */
 		fl4->flowi4_oif = fl4->flowi4_l3mdev ? 0 : oif;
 	}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 618d1f427cb2..c713edfbe2b6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6009,6 +6009,16 @@ void ieee80211_disconnect(struct ieee80211_vif *vif, bool reconnect);
  */
 void ieee80211_resume_disconnect(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_hw_restart_disconnect - disconnect from AP after
+ * hardware restart
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ *
+ * Instructs mac80211 to disconnect from the AP after
+ * hardware restart.
+ */
+void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif);
+
 /**
  * ieee80211_cqm_rssi_notify - inform a configured connection quality monitoring
  *	rssi threshold triggered
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ddc8c944f417..f89fb3afcd46 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -229,20 +229,23 @@ TRACE_EVENT(mm_page_alloc,
 
 DECLARE_EVENT_CLASS(mm_page,
 
-	TP_PROTO(struct page *page, unsigned int order, int migratetype),
+	TP_PROTO(struct page *page, unsigned int order, int migratetype,
+		 int percpu_refill),
 
-	TP_ARGS(page, order, migratetype),
+	TP_ARGS(page, order, migratetype, percpu_refill),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	pfn		)
 		__field(	unsigned int,	order		)
 		__field(	int,		migratetype	)
+		__field(	int,		percpu_refill	)
 	),
 
 	TP_fast_assign(
 		__entry->pfn		= page ? page_to_pfn(page) : -1UL;
 		__entry->order		= order;
 		__entry->migratetype	= migratetype;
+		__entry->percpu_refill	= percpu_refill;
 	),
 
 	TP_printk("page=%p pfn=0x%lx order=%u migratetype=%d percpu_refill=%d",
@@ -250,14 +253,15 @@ DECLARE_EVENT_CLASS(mm_page,
 		__entry->pfn != -1UL ? __entry->pfn : 0,
 		__entry->order,
 		__entry->migratetype,
-		__entry->order == 0)
+		__entry->percpu_refill)
 );
 
 DEFINE_EVENT(mm_page, mm_page_alloc_zone_locked,
 
-	TP_PROTO(struct page *page, unsigned int order, int migratetype),
+	TP_PROTO(struct page *page, unsigned int order, int migratetype,
+		 int percpu_refill),
 
-	TP_ARGS(page, order, migratetype)
+	TP_ARGS(page, order, migratetype, percpu_refill)
 );
 
 TRACE_EVENT(mm_page_pcpu_drain,
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 4ea7fb0ca1ad..6b2bf71f8de4 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -644,7 +644,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	if (!key || key->prefixlen > trie->max_prefixlen)
 		goto find_leftmost;
 
-	node_stack = kmalloc_array(trie->max_prefixlen,
+	node_stack = kmalloc_array(trie->max_prefixlen + 1,
 				   sizeof(struct lpm_trie_node *),
 				   GFP_ATOMIC | __GFP_NOWARN);
 	if (!node_stack)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 999fef6d1228..9ba87c5de1a8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5527,7 +5527,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 {
 	struct cgroup *cgroup;
 	int ret = false;
-	int level = 1;
+	int level = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -5535,7 +5535,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
 
-		if (level > cgroup->max_depth)
+		if (level >= cgroup->max_depth)
 			goto fail;
 
 		level++;
diff --git a/mm/internal.h b/mm/internal.h
index cf3cb933eba3..cd444aa7a10a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -592,8 +592,13 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_HARDER		 0x10 /* try to alloc harder */
-#define ALLOC_HIGH		 0x20 /* __GFP_HIGH set */
+#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
+				       * to 25% of the min watermark or
+				       * 62.5% if __GFP_HIGH is set.
+				       */
+#define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
+				       * of the min watermark.
+				       */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
 #ifdef CONFIG_ZONE_DMA32
@@ -601,8 +606,12 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #else
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
+#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
+/* Flags that allow allocations below the min watermark. */
+#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 264efa022fa9..6a64a7518488 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2461,6 +2461,9 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
 		set_pcppage_migratetype(page, migratetype);
+		trace_mm_page_alloc_zone_locked(page, order, migratetype,
+				pcp_allowed_order(order) &&
+				migratetype < MIGRATE_PCPTYPES);
 		return page;
 	}
 
@@ -2988,7 +2991,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page)
-				goto out;
+				return page;
 		}
 	}
 retry:
@@ -3001,9 +3004,6 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 								alloc_flags))
 			goto retry;
 	}
-out:
-	if (page)
-		trace_mm_page_alloc_zone_locked(page, order, migratetype);
 	return page;
 }
 
@@ -3597,6 +3597,53 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 #endif
 }
 
+static __always_inline
+struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
+			   unsigned int order, unsigned int alloc_flags,
+			   int migratetype)
+{
+	struct page *page;
+	unsigned long flags;
+
+	do {
+		page = NULL;
+		spin_lock_irqsave(&zone->lock, flags);
+		/*
+		 * order-0 request can reach here when the pcplist is skipped
+		 * due to non-CMA allocation context. HIGHATOMIC area is
+		 * reserved for high-order atomic allocation, so order-0
+		 * request should skip it.
+		 */
+		if (alloc_flags & ALLOC_HIGHATOMIC)
+			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+		if (!page) {
+			page = __rmqueue(zone, order, migratetype, alloc_flags);
+
+			/*
+			 * If the allocation fails, allow OOM handling and
+			 * order-0 (atomic) allocs access to HIGHATOMIC
+			 * reserves as failing now is worse than failing a
+			 * high-order atomic allocation in the future.
+			 */
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+
+			if (!page) {
+				spin_unlock_irqrestore(&zone->lock, flags);
+				return NULL;
+			}
+		}
+		__mod_zone_freepage_state(zone, -(1 << order),
+					  get_pcppage_migratetype(page));
+		spin_unlock_irqrestore(&zone->lock, flags);
+	} while (check_new_pages(page, order));
+
+	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
+	zone_statistics(preferred_zone, zone, 1);
+
+	return page;
+}
+
 /* Remove page from the per-cpu list, caller must protect the list */
 static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
@@ -3677,9 +3724,14 @@ struct page *rmqueue(struct zone *preferred_zone,
 			gfp_t gfp_flags, unsigned int alloc_flags,
 			int migratetype)
 {
-	unsigned long flags;
 	struct page *page;
 
+	/*
+	 * We most definitely don't want callers attempting to
+	 * allocate greater than order-1 page units with __GFP_NOFAIL.
+	 */
+	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
+
 	if (likely(pcp_allowed_order(order))) {
 		/*
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
@@ -3693,38 +3745,10 @@ struct page *rmqueue(struct zone *preferred_zone,
 		}
 	}
 
-	/*
-	 * We most definitely don't want callers attempting to
-	 * allocate greater than order-1 page units with __GFP_NOFAIL.
-	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-	spin_lock_irqsave(&zone->lock, flags);
-
-	do {
-		page = NULL;
-		/*
-		 * order-0 request can reach here when the pcplist is skipped
-		 * due to non-CMA allocation context. HIGHATOMIC area is
-		 * reserved for high-order atomic allocation, so order-0
-		 * request should skip it.
-		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER) {
-			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-			if (page)
-				trace_mm_page_alloc_zone_locked(page, order, migratetype);
-		}
-		if (!page)
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
-	} while (page && check_new_pages(page, order));
-	if (!page)
-		goto failed;
-
-	__mod_zone_freepage_state(zone, -(1 << order),
-				  get_pcppage_migratetype(page));
-	spin_unlock_irqrestore(&zone->lock, flags);
-
-	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
-	zone_statistics(preferred_zone, zone, 1);
+	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
+							migratetype);
+	if (unlikely(!page))
+		return NULL;
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3735,10 +3759,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
 	return page;
-
-failed:
-	spin_unlock_irqrestore(&zone->lock, flags);
-	return NULL;
 }
 
 #ifdef CONFIG_FAIL_PAGE_ALLOC
@@ -3818,15 +3838,14 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 	long unusable_free = (1 << order) - 1;
 
 	/*
-	 * If the caller does not have rights to ALLOC_HARDER then subtract
-	 * the high-atomic reserves. This will over-estimate the size of the
-	 * atomic reserve but it avoids a search.
+	 * If the caller does not have rights to reserves below the min
+	 * watermark then subtract the high-atomic reserves. This will
+	 * over-estimate the size of the atomic reserve but it avoids a search.
 	 */
-	if (likely(!alloc_harder))
+	if (likely(!(alloc_flags & ALLOC_RESERVES)))
 		unusable_free += z->nr_reserved_highatomic;
 
 #ifdef CONFIG_CMA
@@ -3850,25 +3869,37 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 {
 	long min = mark;
 	int o;
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
-	if (alloc_flags & ALLOC_HIGH)
-		min -= min / 2;
+	if (unlikely(alloc_flags & ALLOC_RESERVES)) {
+		/*
+		 * __GFP_HIGH allows access to 50% of the min reserve as well
+		 * as OOM.
+		 */
+		if (alloc_flags & ALLOC_MIN_RESERVE) {
+			min -= min / 2;
+
+			/*
+			 * Non-blocking allocations (e.g. GFP_ATOMIC) can
+			 * access more reserves than just __GFP_HIGH. Other
+			 * non-blocking allocations requests such as GFP_NOWAIT
+			 * or (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) do not get
+			 * access to the min reserve.
+			 */
+			if (alloc_flags & ALLOC_NON_BLOCK)
+				min -= min / 4;
+		}
 
-	if (unlikely(alloc_harder)) {
 		/*
-		 * OOM victims can try even harder than normal ALLOC_HARDER
+		 * OOM victims can try even harder than the normal reserve
 		 * users on the grounds that it's definitely going to be in
 		 * the exit path shortly and free memory. Any allocation it
 		 * makes during the free path will be small and short-lived.
 		 */
 		if (alloc_flags & ALLOC_OOM)
 			min -= min / 2;
-		else
-			min -= min / 4;
 	}
 
 	/*
@@ -3902,8 +3933,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
-		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
+		if ((alloc_flags & (ALLOC_HIGHATOMIC|ALLOC_OOM)) &&
+		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -4162,7 +4195,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
+			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
 				reserve_highatomic_pageblock(page, zone, order);
 
 			return page;
@@ -4681,41 +4714,48 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 }
 
 static inline unsigned int
-gfp_to_alloc_flags(gfp_t gfp_mask)
+gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 {
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
 	/*
-	 * __GFP_HIGH is assumed to be the same as ALLOC_HIGH
+	 * __GFP_HIGH is assumed to be the same as ALLOC_MIN_RESERVE
 	 * and __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
 	 * to save two branches.
 	 */
-	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_HIGH);
+	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
 	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
+	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
-	if (gfp_mask & __GFP_ATOMIC) {
+	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.
 		 */
-		if (!(gfp_mask & __GFP_NOMEMALLOC))
-			alloc_flags |= ALLOC_HARDER;
+		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
+			alloc_flags |= ALLOC_NON_BLOCK;
+
+			if (order > 0)
+				alloc_flags |= ALLOC_HIGHATOMIC;
+		}
+
 		/*
-		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
-		 * comment for __cpuset_node_allowed().
+		 * Ignore cpuset mems for non-blocking __GFP_HIGH (probably
+		 * GFP_ATOMIC) rather than fail, see the comment for
+		 * __cpuset_node_allowed().
 		 */
-		alloc_flags &= ~ALLOC_CPUSET;
+		if (alloc_flags & ALLOC_MIN_RESERVE)
+			alloc_flags &= ~ALLOC_CPUSET;
 	} else if (unlikely(rt_task(current)) && in_task())
-		alloc_flags |= ALLOC_HARDER;
+		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
@@ -4936,7 +4976,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
 	 */
-	alloc_flags = gfp_to_alloc_flags(gfp_mask);
+	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
@@ -5151,12 +5191,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
 
 		/*
-		 * Help non-failing allocations by giving them access to memory
-		 * reserves but do not use ALLOC_NO_WATERMARKS because this
+		 * Help non-failing allocations by giving some access to memory
+		 * reserves normally used for high priority non-blocking
+		 * allocations but do not use ALLOC_NO_WATERMARKS because this
 		 * could deplete whole memory reserves which would just make
-		 * the situation worse
+		 * the situation worse.
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);
 		if (page)
 			goto got_pg;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 663fb117cd87..cdb169348ba9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1077,7 +1077,9 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
+	inode_lock_shared(inode);
 	generic_fillattr(&init_user_ns, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
diff --git a/net/core/dev.c b/net/core/dev.c
index 8a22ce15b7f5..15ed4a79be46 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3668,6 +3668,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			goto sw_checksum;
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
@@ -3675,6 +3678,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		}
 	}
 
+sw_checksum:
 	return skb_checksum_help(skb);
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 51ec8256b7fa..8278221a36a1 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -86,7 +86,7 @@ config MAC80211_DEBUGFS
 
 config MAC80211_MESSAGE_TRACING
 	bool "Trace all mac80211 debug messages"
-	depends on MAC80211
+	depends on MAC80211 && TRACING
 	help
 	  Select this option to have mac80211 register the
 	  mac80211_msg trace subsystem with tracepoints to
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c54b3be62c0a..2b77cb290788 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2757,7 +2757,8 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-	if (local->ops->get_txpower)
+	if (local->ops->get_txpower &&
+	    (sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 		return drv_get_txpower(local, sdata, dbm);
 
 	if (!local->use_chanctx)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 03c238e68038..3b5350cfc0ee 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -765,6 +765,8 @@ struct ieee80211_if_mesh {
  *	back to wireless media and to the local net stack.
  * @IEEE80211_SDATA_DISCONNECT_RESUME: Disconnect after resume.
  * @IEEE80211_SDATA_IN_DRIVER: indicates interface was added to driver
+ * @IEEE80211_SDATA_DISCONNECT_HW_RESTART: Disconnect after hardware restart
+ *  recovery
  */
 enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_ALLMULTI		= BIT(0),
@@ -772,6 +774,7 @@ enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_DONT_BRIDGE_PACKETS	= BIT(3),
 	IEEE80211_SDATA_DISCONNECT_RESUME	= BIT(4),
 	IEEE80211_SDATA_IN_DRIVER		= BIT(5),
+	IEEE80211_SDATA_DISCONNECT_HW_RESTART	= BIT(6),
 };
 
 /**
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 7b427e39831b..c755e3b332de 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -918,6 +918,26 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->key_mtx);
 }
 
+static void
+ieee80211_key_iter(struct ieee80211_hw *hw,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_key *key,
+		   void (*iter)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct ieee80211_key_conf *key,
+				void *data),
+		   void *iter_data)
+{
+	/* skip keys of station in removal process */
+	if (key->sta && key->sta->removed)
+		return;
+	if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+		return;
+	iter(hw, vif, key->sta ? &key->sta->sta : NULL,
+	     &key->conf, iter_data);
+}
+
 void ieee80211_iter_keys(struct ieee80211_hw *hw,
 			 struct ieee80211_vif *vif,
 			 void (*iter)(struct ieee80211_hw *hw,
@@ -937,16 +957,13 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		list_for_each_entry_safe(key, tmp, &sdata->key_list, list)
-			iter(hw, &sdata->vif,
-			     key->sta ? &key->sta->sta : NULL,
-			     &key->conf, iter_data);
+			ieee80211_key_iter(hw, vif, key, iter, iter_data);
 	} else {
 		list_for_each_entry(sdata, &local->interfaces, list)
 			list_for_each_entry_safe(key, tmp,
 						 &sdata->key_list, list)
-				iter(hw, &sdata->vif,
-				     key->sta ? &key->sta->sta : NULL,
-				     &key->conf, iter_data);
+				ieee80211_key_iter(hw, &sdata->vif, key,
+						   iter, iter_data);
 	}
 	mutex_unlock(&local->key_mtx);
 }
@@ -964,17 +981,8 @@ _ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
 {
 	struct ieee80211_key *key;
 
-	list_for_each_entry_rcu(key, &sdata->key_list, list) {
-		/* skip keys of station in removal process */
-		if (key->sta && key->sta->removed)
-			continue;
-		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
-			continue;
-
-		iter(hw, &sdata->vif,
-		     key->sta ? &key->sta->sta : NULL,
-		     &key->conf, iter_data);
-	}
+	list_for_each_entry_rcu(key, &sdata->key_list, list)
+		ieee80211_key_iter(hw, &sdata->vif, key, iter, iter_data);
 }
 
 void ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5da0c2a2e293..b71d3a03032e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4832,6 +4832,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 
 	sdata_unlock(sdata);
 }
+#endif
 
 void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 {
@@ -4853,9 +4854,20 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata_unlock(sdata);
 		return;
 	}
+
+	if (sdata->flags & IEEE80211_SDATA_DISCONNECT_HW_RESTART) {
+		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_HW_RESTART;
+		mlme_dbg(sdata, "driver requested disconnect after hardware restart\n");
+		ieee80211_sta_connection_lost(sdata,
+					      ifmgd->associated->bssid,
+					      WLAN_REASON_UNSPECIFIED,
+					      true);
+		sdata_unlock(sdata);
+		return;
+	}
+
 	sdata_unlock(sdata);
 }
-#endif
 
 /* interface setup */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ef7b6d88ee00..85d3d2034d43 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2313,6 +2313,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	struct cfg80211_sched_scan_request *sched_scan_req;
 	bool sched_scan_stopped = false;
 	bool suspended = local->suspended;
+	bool in_reconfig = false;
 
 	/* nothing to do if HW shouldn't run */
 	if (!local->open_count)
@@ -2656,7 +2657,15 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		mutex_unlock(&local->sta_mtx);
 	}
 
+	/*
+	 * If this is for hw restart things are still running.
+	 * We may want to change that later, however.
+	 */
+	if (local->open_count && (!suspended || reconfig_due_to_wowlan))
+		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
+
 	if (local->in_reconfig) {
+		in_reconfig = local->in_reconfig;
 		local->in_reconfig = false;
 		barrier();
 
@@ -2674,12 +2683,14 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					IEEE80211_QUEUE_STOP_REASON_SUSPEND,
 					false);
 
-	/*
-	 * If this is for hw restart things are still running.
-	 * We may want to change that later, however.
-	 */
-	if (local->open_count && (!suspended || reconfig_due_to_wowlan))
-		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
+	if (in_reconfig) {
+		list_for_each_entry(sdata, &local->interfaces, list) {
+			if (!ieee80211_sdata_running(sdata))
+				continue;
+			if (sdata->vif.type == NL80211_IFTYPE_STATION)
+				ieee80211_sta_restart(sdata);
+		}
+	}
 
 	if (!suspended)
 		return 0;
@@ -2710,7 +2721,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	return 0;
 }
 
-void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
+static void ieee80211_reconfig_disconnect(struct ieee80211_vif *vif, u8 flag)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_local *local;
@@ -2722,19 +2733,35 @@ void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
 	sdata = vif_to_sdata(vif);
 	local = sdata->local;
 
-	if (WARN_ON(!local->resuming))
+	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_RESUME &&
+		    !local->resuming))
+		return;
+
+	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_HW_RESTART &&
+		    !local->in_reconfig))
 		return;
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
-	sdata->flags |= IEEE80211_SDATA_DISCONNECT_RESUME;
+	sdata->flags |= flag;
 
 	mutex_lock(&local->key_mtx);
 	list_for_each_entry(key, &sdata->key_list, list)
 		key->flags |= KEY_FLAG_TAINTED;
 	mutex_unlock(&local->key_mtx);
 }
+
+void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif)
+{
+	ieee80211_reconfig_disconnect(vif, IEEE80211_SDATA_DISCONNECT_HW_RESTART);
+}
+EXPORT_SYMBOL_GPL(ieee80211_hw_restart_disconnect);
+
+void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
+{
+	ieee80211_reconfig_disconnect(vif, IEEE80211_SDATA_DISCONNECT_RESUME);
+}
 EXPORT_SYMBOL_GPL(ieee80211_resume_disconnect);
 
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata)
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 55237d8a3d88..49a1cf53064f 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -749,6 +749,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
+		if (offset + priv->len > skb->len)
+			goto err;
+
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
 
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 25524e393349..9a579217763d 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1268,7 +1268,7 @@ struct xt_table *xt_find_table_lock(struct net *net, u_int8_t af,
 
 	/* and once again: */
 	list_for_each_entry(t, &xt_net->tables[af], list)
-		if (strcmp(t->name, name) == 0)
+		if (strcmp(t->name, name) == 0 && owner == t->me)
 			return t;
 
 	module_put(owner);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 724bfeccc6e7..bf8af9f3f3dc 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -780,7 +780,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
-		if (TC_H_MAJ(parentid) == TC_H_MAJ(TC_H_INGRESS))
+		if (parentid == TC_H_ROOT)
 			break;
 
 		if (sch->flags & TCQ_F_NOPARENT)
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 4b026e1c3fe3..09445db29aa1 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -754,8 +754,10 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						      GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l51->reset_gpio))
-		return PTR_ERR(cs42l51->reset_gpio);
+	if (IS_ERR(cs42l51->reset_gpio)) {
+		ret = PTR_ERR(cs42l51->reset_gpio);
+		goto error;
+	}
 
 	if (cs42l51->reset_gpio) {
 		dev_dbg(dev, "Release reset gpio\n");
@@ -787,6 +789,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	return 0;
 
 error:
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 			       cs42l51->supplies);
 	return ret;
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 203323967b50..a8f69d991243 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1482,7 +1482,7 @@ TEST_F(hmm2, double_map)
 
 	buffer->fd = -1;
 	buffer->size = size;
-	buffer->mirror = malloc(npages);
+	buffer->mirror = malloc(size);
 	ASSERT_NE(buffer->mirror, NULL);
 
 	/* Reserve a range of addresses. */
diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index aec993159036..bc663ca79c74 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;

