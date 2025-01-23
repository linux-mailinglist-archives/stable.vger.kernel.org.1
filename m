Return-Path: <stable+bounces-110310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83616A1A8B7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112C418916DD
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B415A843;
	Thu, 23 Jan 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9lLAuMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F1156F55;
	Thu, 23 Jan 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652355; cv=none; b=BOVwrNby/ou9boitI7GdaMnIkUL9B2gM/oOUmpSJKSmLkTWtXyrWYhY4YAqWP0xKVCYxaQo94hmOo8Em6zbjYfAeBbbqRDeDOAMRPV0LMbsxn8+u08EXDiD+qBvJUdK3ykNxdlaRnIt4EfIZ0sEhSzC6dvyTja9sbfANxnpZj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652355; c=relaxed/simple;
	bh=ySGcjPWTeZurpK1GSpSN0j42lJkGK+00xGG2Mi/OfLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpLR11qaU1FrK4nY03GFoIG8gYt9FdxhNaA2bZA7ur8It1Oh4FQXQK6oVI8xima1lblhJfjuovt8o2rminNxqun1Hs+0Is0yvqL1scU5j/hjZEfdqnckz+rgWggw6XPYz9ybRr1eWOYQ/un1ByIjIal/noQRSUOdGuEVrSFiYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9lLAuMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE214C4CEE1;
	Thu, 23 Jan 2025 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737652354;
	bh=ySGcjPWTeZurpK1GSpSN0j42lJkGK+00xGG2Mi/OfLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9lLAuMrxDPrM45C996X/EKLi+6cAocXtGEUVynJTPEr48eCYL5i6z3brVLfGGppx
	 NDlN8FrLkq+IamlK/IyTzvQnzf8Kizfa8ToWvE5cgxG2Naf5R8Z9IU66N2ZVTofJUm
	 3tWpWCE3ItAMQj9eegGvxkdeuvEpfQ+AFteCG9AM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.11
Date: Thu, 23 Jan 2025 18:12:22 +0100
Message-ID: <2025012322-scrooge-emphasize-df13@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012322-scuff-culminate-51b4@gregkh>
References: <2025012322-scuff-culminate-51b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 233e9e88e402..7cf8f11975f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d3aa1d..98bfc097389c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -217,7 +217,7 @@ static inline int write_user_shstk_64(u64 __user *addr, u64 val)
 
 #define nop() asm volatile ("nop")
 
-static inline void serialize(void)
+static __always_inline void serialize(void)
 {
 	/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
 	asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 8d32c3f48abc..5e2cd1004980 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -50,7 +50,13 @@ void cpu_init_fred_exceptions(void)
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
 	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
-	wrmsrl(MSR_IA32_FRED_RSP0, 0);
+
+	/*
+	 * Ater a CPU offline/online cycle, the FRED RSP0 MSR should be
+	 * resynchronized with its per-CPU cache.
+	 */
+	wrmsrl(MSR_IA32_FRED_RSP0, __this_cpu_read(fred_rsp0));
+
 	wrmsrl(MSR_IA32_FRED_RSP1, 0);
 	wrmsrl(MSR_IA32_FRED_RSP2, 0);
 	wrmsrl(MSR_IA32_FRED_RSP3, 0);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d27a3bf96f80..90aaec923889 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -689,11 +689,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
 		const struct irq_override_cmp *entry = &override_table[i];
 
-		if (dmi_check_system(entry->system) &&
-		    entry->irq == gsi &&
+		if (entry->irq == gsi &&
 		    entry->triggering == triggering &&
 		    entry->polarity == polarity &&
-		    entry->shareable == shareable)
+		    entry->shareable == shareable &&
+		    dmi_check_system(entry->system))
 			return entry->override;
 	}
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bf83a104086c..76b326ddd75c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1349,6 +1349,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
+		zram->table = NULL;
 		return false;
 	}
 
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2561b215432a..588ab1cc6d55 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -311,8 +311,6 @@ config QORIQ_CPUFREQ
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
 	  which are capable of changing the CPU's frequency dynamically.
 
-endif
-
 config ACPI_CPPC_CPUFREQ
 	tristate "CPUFreq driver based on the ACPI CPPC spec"
 	depends on ACPI_PROCESSOR
@@ -341,4 +339,6 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
+endif
+
 endmenu
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index f2992f92d8db..173ddcac540a 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -10,25 +10,27 @@
  * DOC: teo-description
  *
  * The idea of this governor is based on the observation that on many systems
- * timer events are two or more orders of magnitude more frequent than any
- * other interrupts, so they are likely to be the most significant cause of CPU
- * wakeups from idle states.  Moreover, information about what happened in the
- * (relatively recent) past can be used to estimate whether or not the deepest
- * idle state with target residency within the (known) time till the closest
- * timer event, referred to as the sleep length, is likely to be suitable for
- * the upcoming CPU idle period and, if not, then which of the shallower idle
- * states to choose instead of it.
+ * timer interrupts are two or more orders of magnitude more frequent than any
+ * other interrupt types, so they are likely to dominate CPU wakeup patterns.
+ * Moreover, in principle, the time when the next timer event is going to occur
+ * can be determined at the idle state selection time, although doing that may
+ * be costly, so it can be regarded as the most reliable source of information
+ * for idle state selection.
  *
- * Of course, non-timer wakeup sources are more important in some use cases
- * which can be covered by taking a few most recent idle time intervals of the
- * CPU into account.  However, even in that context it is not necessary to
- * consider idle duration values greater than the sleep length, because the
- * closest timer will ultimately wake up the CPU anyway unless it is woken up
- * earlier.
+ * Of course, non-timer wakeup sources are more important in some use cases,
+ * but even then it is generally unnecessary to consider idle duration values
+ * greater than the time time till the next timer event, referred as the sleep
+ * length in what follows, because the closest timer will ultimately wake up the
+ * CPU anyway unless it is woken up earlier.
  *
- * Thus this governor estimates whether or not the prospective idle duration of
- * a CPU is likely to be significantly shorter than the sleep length and selects
- * an idle state for it accordingly.
+ * However, since obtaining the sleep length may be costly, the governor first
+ * checks if it can select a shallow idle state using wakeup pattern information
+ * from recent times, in which case it can do without knowing the sleep length
+ * at all.  For this purpose, it counts CPU wakeup events and looks for an idle
+ * state whose target residency has not exceeded the idle duration (measured
+ * after wakeup) in the majority of relevant recent cases.  If the target
+ * residency of that state is small enough, it may be used right away and the
+ * sleep length need not be determined.
  *
  * The computations carried out by this governor are based on using bins whose
  * boundaries are aligned with the target residency parameter values of the CPU
@@ -39,7 +41,11 @@
  * idle state 2, the third bin spans from the target residency of idle state 2
  * up to, but not including, the target residency of idle state 3 and so on.
  * The last bin spans from the target residency of the deepest idle state
- * supplied by the driver to infinity.
+ * supplied by the driver to the scheduler tick period length or to infinity if
+ * the tick period length is less than the target residency of that state.  In
+ * the latter case, the governor also counts events with the measured idle
+ * duration between the tick period length and the target residency of the
+ * deepest idle state.
  *
  * Two metrics called "hits" and "intercepts" are associated with each bin.
  * They are updated every time before selecting an idle state for the given CPU
@@ -49,47 +55,46 @@
  * sleep length and the idle duration measured after CPU wakeup fall into the
  * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
  * length).  In turn, the "intercepts" metric reflects the relative frequency of
- * situations in which the measured idle duration is so much shorter than the
- * sleep length that the bin it falls into corresponds to an idle state
- * shallower than the one whose bin is fallen into by the sleep length (these
- * situations are referred to as "intercepts" below).
+ * non-timer wakeup events for which the measured idle duration falls into a bin
+ * that corresponds to an idle state shallower than the one whose bin is fallen
+ * into by the sleep length (these events are also referred to as "intercepts"
+ * below).
  *
  * In order to select an idle state for a CPU, the governor takes the following
  * steps (modulo the possible latency constraint that must be taken into account
  * too):
  *
- * 1. Find the deepest CPU idle state whose target residency does not exceed
- *    the current sleep length (the candidate idle state) and compute 2 sums as
- *    follows:
+ * 1. Find the deepest enabled CPU idle state (the candidate idle state) and
+ *    compute 2 sums as follows:
  *
- *    - The sum of the "hits" and "intercepts" metrics for the candidate state
- *      and all of the deeper idle states (it represents the cases in which the
- *      CPU was idle long enough to avoid being intercepted if the sleep length
- *      had been equal to the current one).
+ *    - The sum of the "hits" metric for all of the idle states shallower than
+ *      the candidate one (it represents the cases in which the CPU was likely
+ *      woken up by a timer).
  *
- *    - The sum of the "intercepts" metrics for all of the idle states shallower
- *      than the candidate one (it represents the cases in which the CPU was not
- *      idle long enough to avoid being intercepted if the sleep length had been
- *      equal to the current one).
+ *    - The sum of the "intercepts" metric for all of the idle states shallower
+ *      than the candidate one (it represents the cases in which the CPU was
+ *      likely woken up by a non-timer wakeup source).
  *
- * 2. If the second sum is greater than the first one the CPU is likely to wake
- *    up early, so look for an alternative idle state to select.
+ * 2. If the second sum computed in step 1 is greater than a half of the sum of
+ *    both metrics for the candidate state bin and all subsequent bins(if any),
+ *    a shallower idle state is likely to be more suitable, so look for it.
  *
- *    - Traverse the idle states shallower than the candidate one in the
+ *    - Traverse the enabled idle states shallower than the candidate one in the
  *      descending order.
  *
  *    - For each of them compute the sum of the "intercepts" metrics over all
  *      of the idle states between it and the candidate one (including the
  *      former and excluding the latter).
  *
- *    - If each of these sums that needs to be taken into account (because the
- *      check related to it has indicated that the CPU is likely to wake up
- *      early) is greater than a half of the corresponding sum computed in step
- *      1 (which means that the target residency of the state in question had
- *      not exceeded the idle duration in over a half of the relevant cases),
- *      select the given idle state instead of the candidate one.
+ *    - If this sum is greater than a half of the second sum computed in step 1,
+ *      use the given idle state as the new candidate one.
  *
- * 3. By default, select the candidate state.
+ * 3. If the current candidate state is state 0 or its target residency is short
+ *    enough, return it and prevent the scheduler tick from being stopped.
+ *
+ * 4. Obtain the sleep length value and check if it is below the target
+ *    residency of the current candidate state, in which case a new shallower
+ *    candidate state needs to be found, so look for it.
  */
 
 #include <linux/cpuidle.h>
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..f45c70154a93 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -76,10 +76,6 @@ config EFI_ZBOOT
 	bool "Enable the generic EFI decompressor"
 	depends on EFI_GENERIC_STUB && !ARM
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
-	select HAVE_KERNEL_LZO
-	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
 	help
 	  Create the bootable image as an EFI application that carries the
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 65ffd0b760b2..48842b5c106b 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -12,22 +12,16 @@ quiet_cmd_copy_and_pad = PAD     $@
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
 	$(call if_changed,copy_and_pad)
 
-comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
-comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
-comp-type-$(CONFIG_KERNEL_LZMA)		:= lzma
-comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
-comp-type-$(CONFIG_KERNEL_XZ)		:= xzkern
-comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd22
-
 # in GZIP, the appended le32 carrying the uncompressed size is part of the
 # format, but in other cases, we just append it at the end for convenience,
 # causing the original tools to complain when checking image integrity.
-# So disregard it when calculating the payload size in the zimage header.
-zboot-method-y                         := $(comp-type-y)_with_size
-zboot-size-len-y                       := 4
+comp-type-y				:= gzip
+zboot-method-y				:= gzip
+zboot-size-len-y			:= 0
 
-zboot-method-$(CONFIG_KERNEL_GZIP)     := gzip
-zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
+comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd
+zboot-method-$(CONFIG_KERNEL_ZSTD)	:= zstd22_with_size
+zboot-size-len-$(CONFIG_KERNEL_ZSTD)	:= 4
 
 $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(zboot-method-y))
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index dcca1d7f173e..deedacdeb239 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1030,6 +1030,30 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
 	dev->pdev = NULL;
 }
 
+static void
+gpio_sim_device_lockup_configfs(struct gpio_sim_device *dev, bool lock)
+{
+	struct configfs_subsystem *subsys = dev->group.cg_subsys;
+	struct gpio_sim_bank *bank;
+	struct gpio_sim_line *line;
+
+	/*
+	 * The device only needs to depend on leaf line entries. This is
+	 * sufficient to lock up all the configfs entries that the
+	 * instantiated, alive device depends on.
+	 */
+	list_for_each_entry(bank, &dev->bank_list, siblings) {
+		list_for_each_entry(line, &bank->line_list, siblings) {
+			if (lock)
+				WARN_ON(configfs_depend_item_unlocked(
+						subsys, &line->group.cg_item));
+			else
+				configfs_undepend_item_unlocked(
+						&line->group.cg_item);
+		}
+	}
+}
+
 static ssize_t
 gpio_sim_device_config_live_store(struct config_item *item,
 				  const char *page, size_t count)
@@ -1042,14 +1066,24 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	guard(mutex)(&dev->lock);
+	if (live)
+		gpio_sim_device_lockup_configfs(dev, true);
 
-	if (live == gpio_sim_device_is_live(dev))
-		ret = -EPERM;
-	else if (live)
-		ret = gpio_sim_device_activate(dev);
-	else
-		gpio_sim_device_deactivate(dev);
+	scoped_guard(mutex, &dev->lock) {
+		if (live == gpio_sim_device_is_live(dev))
+			ret = -EPERM;
+		else if (live)
+			ret = gpio_sim_device_activate(dev);
+		else
+			gpio_sim_device_deactivate(dev);
+	}
+
+	/*
+	 * Undepend is required only if device disablement (live == 0)
+	 * succeeds or if device enablement (live == 1) fails.
+	 */
+	if (live == !!ret)
+		gpio_sim_device_lockup_configfs(dev, false);
 
 	return ret ?: count;
 }
diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index d6244f0d3bc7..e89f299f2140 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -1546,6 +1546,30 @@ gpio_virtuser_device_deactivate(struct gpio_virtuser_device *dev)
 	dev->pdev = NULL;
 }
 
+static void
+gpio_virtuser_device_lockup_configfs(struct gpio_virtuser_device *dev, bool lock)
+{
+	struct configfs_subsystem *subsys = dev->group.cg_subsys;
+	struct gpio_virtuser_lookup_entry *entry;
+	struct gpio_virtuser_lookup *lookup;
+
+	/*
+	 * The device only needs to depend on leaf lookup entries. This is
+	 * sufficient to lock up all the configfs entries that the
+	 * instantiated, alive device depends on.
+	 */
+	list_for_each_entry(lookup, &dev->lookup_list, siblings) {
+		list_for_each_entry(entry, &lookup->entry_list, siblings) {
+			if (lock)
+				WARN_ON(configfs_depend_item_unlocked(
+						subsys, &entry->group.cg_item));
+			else
+				configfs_undepend_item_unlocked(
+						&entry->group.cg_item);
+		}
+	}
+}
+
 static ssize_t
 gpio_virtuser_device_config_live_store(struct config_item *item,
 				       const char *page, size_t count)
@@ -1558,15 +1582,24 @@ gpio_virtuser_device_config_live_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	guard(mutex)(&dev->lock);
+	if (live)
+		gpio_virtuser_device_lockup_configfs(dev, true);
 
-	if (live == gpio_virtuser_device_is_live(dev))
-		return -EPERM;
+	scoped_guard(mutex, &dev->lock) {
+		if (live == gpio_virtuser_device_is_live(dev))
+			ret = -EPERM;
+		else if (live)
+			ret = gpio_virtuser_device_activate(dev);
+		else
+			gpio_virtuser_device_deactivate(dev);
+	}
 
-	if (live)
-		ret = gpio_virtuser_device_activate(dev);
-	else
-		gpio_virtuser_device_deactivate(dev);
+	/*
+	 * Undepend is required only if device disablement (live == 0)
+	 * succeeds or if device enablement (live == 1) fails.
+	 */
+	if (live == !!ret)
+		gpio_virtuser_device_lockup_configfs(dev, false);
 
 	return ret ?: count;
 }
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index afcf432a1573..2ea8ccfbdccd 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -65,7 +65,7 @@ struct xgpio_instance {
 	DECLARE_BITMAP(state, 64);
 	DECLARE_BITMAP(last_irq_read, 64);
 	DECLARE_BITMAP(dir, 64);
-	spinlock_t gpio_lock;	/* For serializing operations */
+	raw_spinlock_t gpio_lock;	/* For serializing operations */
 	int irq;
 	DECLARE_BITMAP(enable, 64);
 	DECLARE_BITMAP(rising_edge, 64);
@@ -179,14 +179,14 @@ static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write to GPIO signal and set its direction to output */
 	__assign_bit(bit, chip->state, val);
 
 	xgpio_write_ch(chip, XGPIO_DATA_OFFSET, bit, chip->state);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -210,7 +210,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	bitmap_remap(hw_mask, mask, chip->sw_map, chip->hw_map, 64);
 	bitmap_remap(hw_bits, bits, chip->sw_map, chip->hw_map, 64);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	bitmap_replace(state, chip->state, hw_bits, hw_mask, 64);
 
@@ -218,7 +218,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 
 	bitmap_copy(chip->state, state, 64);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -236,13 +236,13 @@ static int xgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Set the GPIO bit in shadow register and set direction as input */
 	__set_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -265,7 +265,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write state of GPIO signal */
 	__assign_bit(bit, chip->state, val);
@@ -275,7 +275,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	__clear_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -398,7 +398,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 	int bit = xgpio_to_bit(chip, irq_offset);
 	u32 mask = BIT(bit / 32), temp;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__clear_bit(bit, chip->enable);
 
@@ -408,7 +408,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 		temp &= ~mask;
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, temp);
 	}
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	gpiochip_disable_irq(&chip->gc, irq_offset);
 }
@@ -428,7 +428,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 
 	gpiochip_enable_irq(&chip->gc, irq_offset);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__set_bit(bit, chip->enable);
 
@@ -447,7 +447,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, val);
 	}
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -512,7 +512,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 
 	chained_irq_enter(irqchip, desc);
 
-	spin_lock(&chip->gpio_lock);
+	raw_spin_lock(&chip->gpio_lock);
 
 	xgpio_read_ch_all(chip, XGPIO_DATA_OFFSET, all);
 
@@ -529,7 +529,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 	bitmap_copy(chip->last_irq_read, all, 64);
 	bitmap_or(all, rising, falling, 64);
 
-	spin_unlock(&chip->gpio_lock);
+	raw_spin_unlock(&chip->gpio_lock);
 
 	dev_dbg(gc->parent, "IRQ rising %*pb falling %*pb\n", 64, rising, 64, falling);
 
@@ -620,7 +620,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	bitmap_set(chip->hw_map,  0, width[0]);
 	bitmap_set(chip->hw_map, 32, width[1]);
 
-	spin_lock_init(&chip->gpio_lock);
+	raw_spin_lock_init(&chip->gpio_lock);
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = bitmap_weight(chip->hw_map, 64);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e41318bfbf45..84e5364d1f67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -715,8 +715,9 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
-	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) {
+	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) ||
+		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 12)) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index 2d4b67175b55..328a1b963548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -122,6 +122,10 @@ static int amdgpu_is_fw_attestation_supported(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return 0;
 
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(14, 0, 2) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(14, 0, 3))
+		return 0;
+
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID)
 		return 1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 8b512dc28df8..071f187f5e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -193,8 +193,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
-	     amdgpu_vm_need_pipeline_sync(ring, job))) {
+	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
+
 		need_pipe_sync = true;
 
 		if (tmp)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ea403fece839..08c58d0315de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8889,6 +8889,7 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
 	struct amdgpu_dm_connector *aconn =
 		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
+	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
 
 	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
 		if (pr->config.replay_supported && !pr->replay_feature_enabled)
@@ -8915,14 +8916,15 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		 * adequate number of fast atomic commits to notify KMD
 		 * of update events. See `vblank_control_worker()`.
 		 */
-		if (acrtc_attach->dm_irq_params.allow_sr_entry &&
+		if (!vrr_active &&
+		    acrtc_attach->dm_irq_params.allow_sr_entry &&
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 		    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
 #endif
 		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
 			if (pr->replay_feature_enabled && !pr->replay_allow_active)
 				amdgpu_dm_replay_enable(acrtc_state->stream, true);
-			if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
+			if (psr->psr_version == DC_PSR_VERSION_SU_1 &&
 			    !psr->psr_allow_active && !aconn->disallow_edp_enter_psr)
 				amdgpu_dm_psr_enable(acrtc_state->stream);
 		}
@@ -9093,7 +9095,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
 				timestamp_ns;
 				if (acrtc_state->stream->link->psr_settings.psr_allow_active)
-					amdgpu_dm_psr_disable(acrtc_state->stream);
+					amdgpu_dm_psr_disable(acrtc_state->stream, true);
 				mutex_unlock(&dm->dc_lock);
 			}
 		}
@@ -9259,11 +9261,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
 		mutex_lock(&dm->dc_lock);
-		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
 			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
 				amdgpu_dm_replay_disable(acrtc_state->stream);
 			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
-				amdgpu_dm_psr_disable(acrtc_state->stream);
+				amdgpu_dm_psr_disable(acrtc_state->stream, true);
 		}
 		mutex_unlock(&dm->dc_lock);
 
@@ -11370,6 +11372,25 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
+					    struct drm_atomic_state *state,
+					    struct drm_crtc_state *crtc_state)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state, *old_plane_state;
+
+	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
+		new_plane_state = drm_atomic_get_plane_state(state, plane);
+		old_plane_state = drm_atomic_get_plane_state(state, plane);
+
+		if (old_plane_state->fb && new_plane_state->fb &&
+		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
  *
@@ -11567,10 +11588,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, new_plane_state) {
-		if (old_plane_state->fb && new_plane_state->fb &&
-		    get_mem_type(old_plane_state->fb) !=
-		    get_mem_type(new_plane_state->fb))
-			lock_and_validation_needed = true;
 
 		ret = dm_update_plane_state(dc, state, plane,
 					    old_plane_state,
@@ -11865,9 +11882,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		/*
 		 * Only allow async flips for fast updates that don't change
-		 * the FB pitch, the DCC state, rotation, etc.
+		 * the FB pitch, the DCC state, rotation, mem_type, etc.
 		 */
-		if (new_crtc_state->async_flip && lock_and_validation_needed) {
+		if (new_crtc_state->async_flip &&
+		    (lock_and_validation_needed ||
+		     amdgpu_dm_crtc_mem_type_changed(dev, state, new_crtc_state))) {
 			drm_dbg_atomic(crtc->dev,
 				       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
 				       crtc->base.id, crtc->name);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index f936a35fa9eb..0f6ba7b1575d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -30,6 +30,7 @@
 #include "amdgpu_dm.h"
 #include "dc.h"
 #include "amdgpu_securedisplay.h"
+#include "amdgpu_dm_psr.h"
 
 static const char *const pipe_crc_sources[] = {
 	"none",
@@ -224,6 +225,10 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	mutex_lock(&adev->dm.dc_lock);
 
+	/* For PSR1, check that the panel has exited PSR */
+	if (stream_state->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
+		amdgpu_dm_psr_wait_disable(stream_state);
+
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
@@ -357,6 +362,17 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	}
 
+	/*
+	 * Reading the CRC requires the vblank interrupt handler to be
+	 * enabled. Keep a reference until CRC capture stops.
+	 */
+	enabled = amdgpu_dm_is_valid_crc_source(cur_crc_src);
+	if (!enabled && enable) {
+		ret = drm_crtc_vblank_get(crtc);
+		if (ret)
+			goto cleanup;
+	}
+
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/* Reset secure_display when we change crc source from debugfs */
 	amdgpu_dm_set_crc_window_default(crtc, crtc_state->stream);
@@ -367,16 +383,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		goto cleanup;
 	}
 
-	/*
-	 * Reading the CRC requires the vblank interrupt handler to be
-	 * enabled. Keep a reference until CRC capture stops.
-	 */
-	enabled = amdgpu_dm_is_valid_crc_source(cur_crc_src);
 	if (!enabled && enable) {
-		ret = drm_crtc_vblank_get(crtc);
-		if (ret)
-			goto cleanup;
-
 		if (dm_is_crc_source_dprx(source)) {
 			if (drm_dp_start_crc(aux, crtc)) {
 				DRM_DEBUG_DRIVER("dp start crc failed\n");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 9be87b532517..70fcfae8e4c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -93,7 +93,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 	return rc;
 }
 
-bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
+bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 {
 	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
 	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
@@ -142,7 +142,7 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 		amdgpu_dm_replay_enable(vblank_work->stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
-			amdgpu_dm_psr_disable(vblank_work->stream);
+			amdgpu_dm_psr_disable(vblank_work->stream, false);
 	} else if (link->psr_settings.psr_feature_enabled &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 17e948753f59..c1212947a77b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -37,7 +37,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
 
 bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
 
-bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state);
+bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
 
 int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index db56b0aa5454..98e88903d07d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3638,7 +3638,7 @@ static int crc_win_update_set(void *data, u64 val)
 		/* PSR may write to OTG CRC window control register,
 		 * so close it before starting secure_display.
 		 */
-		amdgpu_dm_psr_disable(acrtc->dm_irq_params.stream);
+		amdgpu_dm_psr_disable(acrtc->dm_irq_params.stream, true);
 
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 32b025c92c63..3d624ae6d9bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1831,11 +1831,15 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			if (immediate_upstream_port) {
 				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
 				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
-				if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
-					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
-							 "Max dsc compression can't fit into MST available bw\n");
-					return DC_FAIL_BANDWIDTH_VALIDATE;
-				}
+			} else {
+				/* For topology LCT 1 case - only one mstb*/
+				virtual_channel_bw_in_kbps = root_link_bw_in_kbps;
+			}
+
+			if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
+				DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
+						 "Max dsc compression can't fit into MST available bw\n");
+				return DC_FAIL_BANDWIDTH_VALIDATE;
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index f40240aafe98..45858bf1523d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -201,14 +201,13 @@ void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
  *
  * Return: true if success
  */
-bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
+bool amdgpu_dm_psr_disable(struct dc_stream_state *stream, bool wait)
 {
-	unsigned int power_opt = 0;
 	bool psr_enable = false;
 
 	DRM_DEBUG_DRIVER("Disabling psr...\n");
 
-	return dc_link_set_psr_allow_active(stream->link, &psr_enable, true, false, &power_opt);
+	return dc_link_set_psr_allow_active(stream->link, &psr_enable, wait, false, NULL);
 }
 
 /*
@@ -251,3 +250,33 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 
 	return allow_active;
 }
+
+/**
+ * amdgpu_dm_psr_wait_disable() - Wait for eDP panel to exit PSR
+ * @stream: stream state attached to the eDP link
+ *
+ * Waits for a max of 500ms for the eDP panel to exit PSR.
+ *
+ * Return: true if panel exited PSR, false otherwise.
+ */
+bool amdgpu_dm_psr_wait_disable(struct dc_stream_state *stream)
+{
+	enum dc_psr_state psr_state = PSR_STATE0;
+	struct dc_link *link = stream->link;
+	int retry_count;
+
+	if (link == NULL)
+		return false;
+
+	for (retry_count = 0; retry_count <= 1000; retry_count++) {
+		dc_link_get_psr_state(link, &psr_state);
+		if (psr_state == PSR_STATE0)
+			break;
+		udelay(500);
+	}
+
+	if (retry_count == 1000)
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index cd2d45c2b5ef..e2366321a3c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -34,8 +34,9 @@
 void amdgpu_dm_set_psr_caps(struct dc_link *link);
 void amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
-bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
+bool amdgpu_dm_psr_disable(struct dc_stream_state *stream, bool wait);
 bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
 bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm);
+bool amdgpu_dm_psr_wait_disable(struct dc_stream_state *stream);
 
 #endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index beed7adbbd43..47d785204f29 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -195,9 +195,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.dcn_downspread_percent = 0.5,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = 1,
+	.do_urgent_latency_adjustment = 0,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index cd2cf0ffc0f5..5a0a10144a73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2549,11 +2549,12 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					  &backend_workload_mask);
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
-	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
-	     ((smu->adev->pm.fw_version == 0x004e6601) ||
-	      (smu->adev->pm.fw_version >= 0x004e7300))) ||
-	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
-	     smu->adev->pm.fw_version >= 0x00504500)) {
+	if ((workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE)) &&
+	    ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
+	      ((smu->adev->pm.fw_version == 0x004e6601) ||
+	       (smu->adev->pm.fw_version >= 0x004e7300))) ||
+	     (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
+	      smu->adev->pm.fw_version >= 0x00504500))) {
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 35557d98d7a7..3d16e9406dc6 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -1613,7 +1613,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
 		 * arithmetic related to alignment and offset calculation.
 		 */
 		if (is_gen12_ccs_cc_plane(&fb->base, i)) {
-			if (IS_ALIGNED(fb->base.offsets[i], PAGE_SIZE))
+			if (IS_ALIGNED(fb->base.offsets[i], 64))
 				continue;
 			else
 				return -EINVAL;
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 09686d038d60..7cc84472cece 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -387,11 +387,13 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct nouveau_channel *chan,
 			if (f) {
 				struct nouveau_channel *prev;
 				bool must_wait = true;
+				bool local;
 
 				rcu_read_lock();
 				prev = rcu_dereference(f->channel);
-				if (prev && (prev == chan ||
-					     fctx->sync(f, prev, chan) == 0))
+				local = prev && prev->cli->drm == chan->cli->drm;
+				if (local && (prev == chan ||
+					      fctx->sync(f, prev, chan) == 0))
 					must_wait = false;
 				rcu_read_unlock();
 				if (!must_wait)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c
index 841e3b69fcaf..5a0c9b8a79f3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c
@@ -31,6 +31,7 @@ mcp77_sor = {
 	.state = g94_sor_state,
 	.power = nv50_sor_power,
 	.clock = nv50_sor_clock,
+	.bl = &nv50_sor_bl,
 	.hdmi = &g84_sor_hdmi,
 	.dp = &g94_sor_dp,
 };
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 04a6b8cc62ac..3c0b7824c0be 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -320,8 +320,7 @@ static void kunit_action_drm_mode_destroy(void *ptr)
 }
 
 /**
- * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC
-					   for a KUnit test
+ * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC for a KUnit test
  * @test: The test context object
  * @dev: DRM device
  * @video_code: CEA VIC of the mode
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 20bf33702c3c..da203045df9b 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -108,6 +108,7 @@ v3d_irq(int irq, void *arg)
 		v3d_job_update_stats(&v3d->bin_job->base, V3D_BIN);
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->bin_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
@@ -118,6 +119,7 @@ v3d_irq(int irq, void *arg)
 		v3d_job_update_stats(&v3d->render_job->base, V3D_RENDER);
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->render_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
@@ -128,6 +130,7 @@ v3d_irq(int irq, void *arg)
 		v3d_job_update_stats(&v3d->csd_job->base, V3D_CSD);
 		trace_v3d_csd_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->csd_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
@@ -165,6 +168,7 @@ v3d_hub_irq(int irq, void *arg)
 		v3d_job_update_stats(&v3d->tfu_job->base, V3D_TFU);
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->tfu_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index a0e433fbcba6..183cda50094c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -443,7 +443,8 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
 
 	if (params->pin)
 		ttm_bo_pin(&vmw_bo->tbo);
-	ttm_bo_unreserve(&vmw_bo->tbo);
+	if (!params->keep_resv)
+		ttm_bo_unreserve(&vmw_bo->tbo);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index 43b5439ec9f7..c21ba7ff7736 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -56,8 +56,9 @@ struct vmw_bo_params {
 	u32 domain;
 	u32 busy_domain;
 	enum ttm_bo_type bo_type;
-	size_t size;
 	bool pin;
+	bool keep_resv;
+	size_t size;
 	struct dma_resv *resv;
 	struct sg_table *sg;
 };
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 2825dd3149ed..2e84e1029732 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -401,7 +401,8 @@ static int vmw_dummy_query_bo_create(struct vmw_private *dev_priv)
 		.busy_domain = VMW_BO_DOMAIN_SYS,
 		.bo_type = ttm_bo_type_kernel,
 		.size = PAGE_SIZE,
-		.pin = true
+		.pin = true,
+		.keep_resv = true,
 	};
 
 	/*
@@ -413,10 +414,6 @@ static int vmw_dummy_query_bo_create(struct vmw_private *dev_priv)
 	if (unlikely(ret != 0))
 		return ret;
 
-	ret = ttm_bo_reserve(&vbo->tbo, false, true, NULL);
-	BUG_ON(ret != 0);
-	vmw_bo_pin_reserved(vbo, true);
-
 	ret = ttm_bo_kmap(&vbo->tbo, 0, 1, &map);
 	if (likely(ret == 0)) {
 		result = ttm_kmap_obj_virtual(&map, &dummy);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index b9857f37ca1a..ed5015ced392 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -206,6 +206,7 @@ struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
 		.bo_type = ttm_bo_type_sg,
 		.size = attach->dmabuf->size,
 		.pin = false,
+		.keep_resv = true,
 		.resv = attach->dmabuf->resv,
 		.sg = table,
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 10d596cb4b40..5f99f7437ae6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -750,6 +750,7 @@ vmw_du_cursor_plane_atomic_update(struct drm_plane *plane,
 	struct vmw_plane_state *old_vps = vmw_plane_state_to_vps(old_state);
 	struct vmw_bo *old_bo = NULL;
 	struct vmw_bo *new_bo = NULL;
+	struct ww_acquire_ctx ctx;
 	s32 hotspot_x, hotspot_y;
 	int ret;
 
@@ -769,9 +770,11 @@ vmw_du_cursor_plane_atomic_update(struct drm_plane *plane,
 	if (du->cursor_surface)
 		du->cursor_age = du->cursor_surface->snooper.age;
 
+	ww_acquire_init(&ctx, &reservation_ww_class);
+
 	if (!vmw_user_object_is_null(&old_vps->uo)) {
 		old_bo = vmw_user_object_buffer(&old_vps->uo);
-		ret = ttm_bo_reserve(&old_bo->tbo, false, false, NULL);
+		ret = ttm_bo_reserve(&old_bo->tbo, false, false, &ctx);
 		if (ret != 0)
 			return;
 	}
@@ -779,9 +782,14 @@ vmw_du_cursor_plane_atomic_update(struct drm_plane *plane,
 	if (!vmw_user_object_is_null(&vps->uo)) {
 		new_bo = vmw_user_object_buffer(&vps->uo);
 		if (old_bo != new_bo) {
-			ret = ttm_bo_reserve(&new_bo->tbo, false, false, NULL);
-			if (ret != 0)
+			ret = ttm_bo_reserve(&new_bo->tbo, false, false, &ctx);
+			if (ret != 0) {
+				if (old_bo) {
+					ttm_bo_unreserve(&old_bo->tbo);
+					ww_acquire_fini(&ctx);
+				}
 				return;
+			}
 		} else {
 			new_bo = NULL;
 		}
@@ -803,10 +811,12 @@ vmw_du_cursor_plane_atomic_update(struct drm_plane *plane,
 						hotspot_x, hotspot_y);
 	}
 
-	if (old_bo)
-		ttm_bo_unreserve(&old_bo->tbo);
 	if (new_bo)
 		ttm_bo_unreserve(&new_bo->tbo);
+	if (old_bo)
+		ttm_bo_unreserve(&old_bo->tbo);
+
+	ww_acquire_fini(&ctx);
 
 	du->cursor_x = new_state->crtc_x + du->set_gui_x;
 	du->cursor_y = new_state->crtc_y + du->set_gui_y;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index a01ca3226d0a..7fb1c88bcc47 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -896,7 +896,8 @@ int vmw_compat_shader_add(struct vmw_private *dev_priv,
 		.busy_domain = VMW_BO_DOMAIN_SYS,
 		.bo_type = ttm_bo_type_device,
 		.size = size,
-		.pin = true
+		.pin = true,
+		.keep_resv = true,
 	};
 
 	if (!vmw_shader_id_ok(user_key, shader_type))
@@ -906,10 +907,6 @@ int vmw_compat_shader_add(struct vmw_private *dev_priv,
 	if (unlikely(ret != 0))
 		goto out;
 
-	ret = ttm_bo_reserve(&buf->tbo, false, true, NULL);
-	if (unlikely(ret != 0))
-		goto no_reserve;
-
 	/* Map and copy shader bytecode. */
 	ret = ttm_bo_kmap(&buf->tbo, 0, PFN_UP(size), &map);
 	if (unlikely(ret != 0)) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index 621d98b376bb..5553892d7c3e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -572,15 +572,14 @@ int vmw_bo_create_and_populate(struct vmw_private *dev_priv,
 		.busy_domain = domain,
 		.bo_type = ttm_bo_type_kernel,
 		.size = bo_size,
-		.pin = true
+		.pin = true,
+		.keep_resv = true,
 	};
 
 	ret = vmw_bo_create(dev_priv, &bo_params, &vbo);
 	if (unlikely(ret != 0))
 		return ret;
 
-	ret = ttm_bo_reserve(&vbo->tbo, false, true, NULL);
-	BUG_ON(ret != 0);
 	ret = vmw_ttm_populate(vbo->tbo.bdev, vbo->tbo.ttm, &ctx);
 	if (likely(ret == 0)) {
 		struct vmw_ttm_tt *vmw_tt =
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 547919e8ce9e..b11bc0f00dfd 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -417,7 +417,7 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 	 * Bspec: 72161
 	 */
 	const u8 mocs_write_idx = gt->mocs.uc_index;
-	const u8 mocs_read_idx = hwe->class == XE_ENGINE_CLASS_COMPUTE &&
+	const u8 mocs_read_idx = hwe->class == XE_ENGINE_CLASS_COMPUTE && IS_DGFX(xe) &&
 				 (GRAPHICS_VER(xe) >= 20 || xe->info.platform == XE_PVC) ?
 				 gt->mocs.wb_index : gt->mocs.uc_index;
 	u32 ring_cmd_cctl_val = REG_FIELD_PREP(CMD_CCTL_WRITE_OVERRIDE_MASK, mocs_write_idx) |
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 78823f53d290..6fc00d63b285 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1980,6 +1980,7 @@ static const struct xe_mmio_range xe2_oa_mux_regs[] = {
 	{ .start = 0x5194, .end = 0x5194 },	/* SYS_MEM_LAT_MEASURE_MERTF_GRP_3D */
 	{ .start = 0x8704, .end = 0x8704 },	/* LMEM_LAT_MEASURE_MCFG_GRP */
 	{ .start = 0xB1BC, .end = 0xB1BC },	/* L3_BANK_LAT_MEASURE_LBCF_GFX */
+	{ .start = 0xD0E0, .end = 0xD0F4 },	/* VISACTL */
 	{ .start = 0xE18C, .end = 0xE18C },	/* SAMPLER_MODE */
 	{ .start = 0xE590, .end = 0xE590 },	/* TDL_LSC_LAT_MEASURE_TDL_GFX */
 	{ .start = 0x13000, .end = 0x137FC },	/* PES_0_PESL0 - PES_63_UPPER_PESL3 */
diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
index 7ca139e4b6af..6d5d4cb846da 100644
--- a/drivers/hwmon/ltc2991.c
+++ b/drivers/hwmon/ltc2991.c
@@ -125,7 +125,7 @@ static int ltc2991_get_curr(struct ltc2991_state *st, u32 reg, int channel,
 
 	/* Vx-Vy, 19.075uV/LSB */
 	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 19075,
-				 st->r_sense_uohm[channel]);
+				 (s32)st->r_sense_uohm[channel]);
 
 	return 0;
 }
diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 1c2cb12071b8..5acbfd7d088d 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -207,7 +207,8 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		*val = sign_extend32(regval,
 				     reg == TMP51X_SHUNT_CURRENT_RESULT ?
 				     16 - tmp51x_get_pga_shift(data) : 15);
-		*val = DIV_ROUND_CLOSEST(*val * 10 * MILLI, data->shunt_uohms);
+		*val = DIV_ROUND_CLOSEST(*val * 10 * (long)MILLI, (long)data->shunt_uohms);
+
 		break;
 	case TMP51X_BUS_VOLTAGE_RESULT:
 	case TMP51X_BUS_VOLTAGE_H_LIMIT:
@@ -223,7 +224,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 	case TMP51X_BUS_CURRENT_RESULT:
 		// Current = (ShuntVoltage * CalibrationRegister) / 4096
 		*val = sign_extend32(regval, 15) * (long)data->curr_lsb_ua;
-		*val = DIV_ROUND_CLOSEST(*val, MILLI);
+		*val = DIV_ROUND_CLOSEST(*val, (long)MILLI);
 		break;
 	case TMP51X_LOCAL_TEMP_RESULT:
 	case TMP51X_REMOTE_TEMP_RESULT_1:
@@ -263,7 +264,7 @@ static int tmp51x_set_value(struct tmp51x_data *data, u8 reg, long val)
 		 * The user enter current value and we convert it to
 		 * voltage. 1lsb = 10uV
 		 */
-		val = DIV_ROUND_CLOSEST(val * data->shunt_uohms, 10 * MILLI);
+		val = DIV_ROUND_CLOSEST(val * (long)data->shunt_uohms, 10 * (long)MILLI);
 		max_val = U16_MAX >> tmp51x_get_pga_shift(data);
 		regval = clamp_val(val, -max_val, max_val);
 		break;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 9267df38c2d0..399122414821 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -130,6 +130,8 @@
 #define ID_P_PM_BLOCKED		BIT(31)
 #define ID_P_MASK		GENMASK(31, 27)
 
+#define ID_SLAVE_NACK		BIT(0)
+
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
 	I2C_RCAR_GEN2,
@@ -166,6 +168,7 @@ struct rcar_i2c_priv {
 	int irq;
 
 	struct i2c_client *host_notify_client;
+	u8 slave_flags;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -655,6 +658,7 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 {
 	u32 ssr_raw, ssr_filtered;
 	u8 value;
+	int ret;
 
 	ssr_raw = rcar_i2c_read(priv, ICSSR) & 0xff;
 	ssr_filtered = ssr_raw & rcar_i2c_read(priv, ICSIER);
@@ -670,7 +674,10 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 			rcar_i2c_write(priv, ICRXTX, value);
 			rcar_i2c_write(priv, ICSIER, SDE | SSR | SAR);
 		} else {
-			i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+			ret = i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+			if (ret)
+				priv->slave_flags |= ID_SLAVE_NACK;
+
 			rcar_i2c_read(priv, ICRXTX);	/* dummy read */
 			rcar_i2c_write(priv, ICSIER, SDR | SSR | SAR);
 		}
@@ -683,18 +690,21 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 	if (ssr_filtered & SSR) {
 		i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
 		rcar_i2c_write(priv, ICSCR, SIE | SDBS); /* clear our NACK */
+		priv->slave_flags &= ~ID_SLAVE_NACK;
 		rcar_i2c_write(priv, ICSIER, SAR);
 		rcar_i2c_write(priv, ICSSR, ~SSR & 0xff);
 	}
 
 	/* master wants to write to us */
 	if (ssr_filtered & SDR) {
-		int ret;
-
 		value = rcar_i2c_read(priv, ICRXTX);
 		ret = i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
-		/* Send NACK in case of error */
-		rcar_i2c_write(priv, ICSCR, SIE | SDBS | (ret < 0 ? FNA : 0));
+		if (ret)
+			priv->slave_flags |= ID_SLAVE_NACK;
+
+		/* Send NACK in case of error, but it will come 1 byte late :( */
+		rcar_i2c_write(priv, ICSCR, SIE | SDBS |
+			       (priv->slave_flags & ID_SLAVE_NACK ? FNA : 0));
 		rcar_i2c_write(priv, ICSSR, ~SDR & 0xff);
 	}
 
diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index f21475ae5921..0d54d0b5e327 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -412,7 +412,7 @@ static int i2c_atr_bus_notifier_call(struct notifier_block *nb,
 				dev_name(dev), ret);
 		break;
 
-	case BUS_NOTIFY_DEL_DEVICE:
+	case BUS_NOTIFY_REMOVED_DEVICE:
 		i2c_atr_detach_client(client->adapter, client);
 		break;
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7c810893bfa3..75d30861ffe2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,6 +1562,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
+		put_device(&adap->dev);
 		goto out_list;
 	}
 
diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index 9fe3150378e8..7ae0c7902f67 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -38,6 +38,7 @@ enum testunit_regs {
 
 enum testunit_flags {
 	TU_FLAG_IN_PROCESS,
+	TU_FLAG_NACK,
 };
 
 struct testunit_data {
@@ -90,8 +91,10 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 
 	switch (event) {
 	case I2C_SLAVE_WRITE_REQUESTED:
-		if (test_bit(TU_FLAG_IN_PROCESS, &tu->flags))
-			return -EBUSY;
+		if (test_bit(TU_FLAG_IN_PROCESS | TU_FLAG_NACK, &tu->flags)) {
+			ret = -EBUSY;
+			break;
+		}
 
 		memset(tu->regs, 0, TU_NUM_REGS);
 		tu->reg_idx = 0;
@@ -99,8 +102,10 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 		break;
 
 	case I2C_SLAVE_WRITE_RECEIVED:
-		if (test_bit(TU_FLAG_IN_PROCESS, &tu->flags))
-			return -EBUSY;
+		if (test_bit(TU_FLAG_IN_PROCESS | TU_FLAG_NACK, &tu->flags)) {
+			ret = -EBUSY;
+			break;
+		}
 
 		if (tu->reg_idx < TU_NUM_REGS)
 			tu->regs[tu->reg_idx] = *val;
@@ -129,6 +134,8 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 		 * here because we still need them in the workqueue!
 		 */
 		tu->reg_idx = 0;
+
+		clear_bit(TU_FLAG_NACK, &tu->flags);
 		break;
 
 	case I2C_SLAVE_READ_PROCESSED:
@@ -151,6 +158,10 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 		break;
 	}
 
+	/* If an error occurred somewhen, we NACK everything until next STOP */
+	if (ret)
+		set_bit(TU_FLAG_NACK, &tu->flags);
+
 	return ret;
 }
 
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 7e2686b606c0..cec7f3447e19 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -261,7 +261,9 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 	pm_runtime_no_callbacks(&pdev->dev);
 
 	/* switch to first parent as active master */
-	i2c_demux_activate_master(priv, 0);
+	err = i2c_demux_activate_master(priv, 0);
+	if (err)
+		goto err_rollback;
 
 	err = device_create_file(&pdev->dev, &dev_attr_available_masters);
 	if (err)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b20cffcc3e7d..14e434ff51ed 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2269,6 +2269,7 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	qp_attr->retry_cnt = qplib_qp->retry_cnt;
 	qp_attr->rnr_retry = qplib_qp->rnr_retry;
 	qp_attr->min_rnr_timer = qplib_qp->min_rnr_timer;
+	qp_attr->port_num = __to_ib_port_num(qplib_qp->port_id);
 	qp_attr->rq_psn = qplib_qp->rq.psn;
 	qp_attr->max_rd_atomic = qplib_qp->max_rd_atomic;
 	qp_attr->sq_psn = qplib_qp->sq.psn;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b789e47ec97a..9cd8f770d1b2 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -264,6 +264,10 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 
+static inline u32 __to_ib_port_num(u16 port_id)
+{
+	return (u32)port_id + 1;
+}
 
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp);
 void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 828e2f980801..613b5fc70e13 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1479,6 +1479,7 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	qp->dest_qpn = le32_to_cpu(sb->dest_qp_id);
 	memcpy(qp->smac, sb->src_mac, 6);
 	qp->vlan_id = le16_to_cpu(sb->vlan_pcp_vlan_dei_vlan_id);
+	qp->port_id = le16_to_cpu(sb->port_id);
 bail:
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
 			  sbuf.sb, sbuf.dma_addr);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index d8c71c024613..6f02954eb142 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -298,6 +298,7 @@ struct bnxt_qplib_qp {
 	u32				dest_qpn;
 	u8				smac[6];
 	u16				vlan_id;
+	u16				port_id;
 	u8				nw_type;
 	struct bnxt_qplib_ah		ah;
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d9b6ec844cdd..0d3a889b1905 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1961,7 +1961,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
-	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+	guard(raw_spinlock)(&its_dev->event_map.vlpi_lock);
 
 	/* Unmap request? */
 	if (!info)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b0bfb61539c2..8fdee511bc0f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1522,7 +1522,7 @@ static int gic_retrigger(struct irq_data *data)
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_enable();
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 1eeb0d0156ce..0ee7b6b71f5f 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -35,11 +35,10 @@ void __init irqchip_init(void)
 int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *par_np = of_irq_find_parent(np);
+	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
 	if (!irq_init_cb) {
-		of_node_put(par_np);
 		return -EINVAL;
 	}
 
@@ -55,7 +54,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller can check for specific domains as necessary.
 	 */
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
-		of_node_put(par_np);
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8c57df44c40f..9d6e85bf227b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 6a716337f48b..268399dfcf22 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -923,7 +923,6 @@ static void xgbe_phy_free_phy_device(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	unsigned int phy_id = phy_data->phydev->phy_id;
 
@@ -945,14 +944,7 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 	phy_write(phy_data->phydev, 0x04, 0x0d01);
 	phy_write(phy_data->phydev, 0x00, 0x9140);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 
 	phy_support_asym_pause(phy_data->phydev);
 
@@ -964,7 +956,6 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	struct xgbe_sfp_eeprom *sfp_eeprom = &phy_data->sfp_eeprom;
 	unsigned int phy_id = phy_data->phydev->phy_id;
@@ -1028,13 +1019,7 @@ static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 	reg = phy_read(phy_data->phydev, 0x00);
 	phy_write(phy_data->phydev, 0x00, reg & ~0x00800);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 	phy_support_asym_pause(phy_data->phydev);
 
 	netif_dbg(pdata, drv, pdata->netdev,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c255445e97f3..603e9c968c44 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4558,7 +4558,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 /* Changing allocation mode of RX rings.
  * TODO: Update when extending xdp_rxq_info to support allocation modes.
  */
-int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
+static void __bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 {
 	struct net_device *dev = bp->dev;
 
@@ -4579,15 +4579,30 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 			bp->rx_skb_func = bnxt_rx_page_skb;
 		}
 		bp->rx_dir = DMA_BIDIRECTIONAL;
-		/* Disable LRO or GRO_HW */
-		netdev_update_features(dev);
 	} else {
 		dev->max_mtu = bp->max_mtu;
 		bp->flags &= ~BNXT_FLAG_RX_PAGE_MODE;
 		bp->rx_dir = DMA_FROM_DEVICE;
 		bp->rx_skb_func = bnxt_rx_skb;
 	}
-	return 0;
+}
+
+void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
+{
+	__bnxt_set_rx_skb_mode(bp, page_mode);
+
+	if (!page_mode) {
+		int rx, tx;
+
+		bnxt_get_max_rings(bp, &rx, &tx, true);
+		if (rx > 1) {
+			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
+			bp->dev->hw_features |= NETIF_F_LRO;
+		}
+	}
+
+	/* Update LRO and GRO_HW availability */
+	netdev_update_features(bp->dev);
 }
 
 static void bnxt_free_vnic_attributes(struct bnxt *bp)
@@ -15909,7 +15924,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (bp->max_fltr < BNXT_MAX_FLTR)
 		bp->max_fltr = BNXT_MAX_FLTR;
 	bnxt_init_l2_fltr_tbl(bp);
-	bnxt_set_rx_skb_mode(bp, false);
+	__bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9e05704d9445..bee645f58d0b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2796,7 +2796,7 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
-int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
+void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
 void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index f88b641533fc..dc51dce209d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -422,15 +422,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 		bnxt_set_rx_skb_mode(bp, true);
 		xdp_features_set_redirect_target(dev, true);
 	} else {
-		int rx, tx;
-
 		xdp_features_clear_redirect_target(dev);
 		bnxt_set_rx_skb_mode(bp, false);
-		bnxt_get_max_rings(bp, &rx, &tx, true);
-		if (rx > 1) {
-			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
-			bp->dev->hw_features |= NETIF_F_LRO;
-		}
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9d9fcec41488..49d1748e0c04 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1591,19 +1591,22 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 		fec_enet_tx_queue(ndev, i, budget);
 }
 
-static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
+static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 				struct bufdesc *bdp, int index)
 {
 	struct page *new_page;
 	dma_addr_t phys_addr;
 
 	new_page = page_pool_dev_alloc_pages(rxq->page_pool);
-	WARN_ON(!new_page);
-	rxq->rx_skb_info[index].page = new_page;
+	if (unlikely(!new_page))
+		return -ENOMEM;
 
+	rxq->rx_skb_info[index].page = new_page;
 	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
 }
 
 static u32
@@ -1698,6 +1701,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
+	__fec32 cbd_bufaddr;
 	u32 sub_len = 4;
 
 #if !defined(CONFIG_M5272)
@@ -1766,12 +1770,17 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_skb_info[index].page;
+		cbd_bufaddr = bdp->cbd_bufaddr;
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
 		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(bdp->cbd_bufaddr),
+					fec32_to_cpu(cbd_bufaddr),
 					pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
-		fec_enet_update_cbd(rxq, bdp, index);
 
 		if (xdp_prog) {
 			xdp_buff_clear_frags_flag(&xdp);
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d6f80da30dec..558cda577191 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1047,5 +1047,10 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
 }
 
+static inline enum ice_phy_model ice_get_phy_model(const struct ice_hw *hw)
+{
+	return hw->ptp.phy_model;
+}
+
 extern const struct xdp_metadata_ops ice_xdp_md_ops;
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index ad84d8ad49a6..f3e195974a8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -40,11 +40,17 @@ static struct ice_adapter *ice_adapter_new(void)
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	refcount_set(&adapter->refcount, 1);
 
+	mutex_init(&adapter->ports.lock);
+	INIT_LIST_HEAD(&adapter->ports.ports);
+
 	return adapter;
 }
 
 static void ice_adapter_free(struct ice_adapter *adapter)
 {
+	WARN_ON(!list_empty(&adapter->ports.ports));
+	mutex_destroy(&adapter->ports.lock);
+
 	kfree(adapter);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 9d11014ec02f..e233225848b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -4,22 +4,42 @@
 #ifndef _ICE_ADAPTER_H_
 #define _ICE_ADAPTER_H_
 
+#include <linux/types.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
 struct pci_dev;
+struct ice_pf;
+
+/**
+ * struct ice_port_list - data used to store the list of adapter ports
+ *
+ * This structure contains data used to maintain a list of adapter ports
+ *
+ * @ports: list of ports
+ * @lock: protect access to the ports list
+ */
+struct ice_port_list {
+	struct list_head ports;
+	/* To synchronize the ports list operations */
+	struct mutex lock;
+};
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @refcount: Reference count. struct ice_pf objects hold the references.
+ * @ctrl_pf: Control PF of the adapter
+ * @ports: Ports list
  */
 struct ice_adapter {
+	refcount_t refcount;
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 
-	refcount_t refcount;
+	struct ice_pf *ctrl_pf;
+	struct ice_port_list ports;
 };
 
 struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 79a6edd0be0e..80f3dfd27124 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1648,6 +1648,7 @@ struct ice_aqc_get_port_options_elem {
 #define ICE_AQC_PORT_OPT_MAX_LANE_25G	5
 #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
 #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
+#define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
 
 	u8 global_scid[2];
 	u8 phy_scid[2];
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f1324e25b2af..068a467de1d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4074,6 +4074,57 @@ ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
 
+/**
+ * ice_get_phy_lane_number - Get PHY lane number for current adapter
+ * @hw: pointer to the hw struct
+ *
+ * Return: PHY lane number on success, negative error code otherwise.
+ */
+int ice_get_phy_lane_number(struct ice_hw *hw)
+{
+	struct ice_aqc_get_port_options_elem *options;
+	unsigned int lport = 0;
+	unsigned int lane;
+	int err;
+
+	options = kcalloc(ICE_AQC_PORT_OPT_MAX, sizeof(*options), GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	for (lane = 0; lane < ICE_MAX_PORT_PER_PCI_DEV; lane++) {
+		u8 options_count = ICE_AQC_PORT_OPT_MAX;
+		u8 speed, active_idx, pending_idx;
+		bool active_valid, pending_valid;
+
+		err = ice_aq_get_port_options(hw, options, &options_count, lane,
+					      true, &active_idx, &active_valid,
+					      &pending_idx, &pending_valid);
+		if (err)
+			goto err;
+
+		if (!active_valid)
+			continue;
+
+		speed = options[active_idx].max_lane_speed;
+		/* If we don't get speed for this lane, it's unoccupied */
+		if (speed > ICE_AQC_PORT_OPT_MAX_LANE_200G)
+			continue;
+
+		if (hw->pf_id == lport) {
+			kfree(options);
+			return lane;
+		}
+
+		lport++;
+	}
+
+	/* PHY lane not found */
+	err = -ENXIO;
+err:
+	kfree(options);
+	return err;
+}
+
 /**
  * ice_aq_sff_eeprom
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 27208a60cece..fe6f88cfd948 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -193,6 +193,7 @@ ice_aq_get_port_options(struct ice_hw *hw,
 int
 ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
 		       u8 new_option);
+int ice_get_phy_lane_number(struct ice_hw *hw);
 int
 ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,
 		  u16 mem_addr, u8 page, u8 set_page, u8 *data, u8 length,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8f2e758c3942..45eefe22fb5b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1144,7 +1144,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
 
-	ice_ptp_link_change(pf, pf->hw.pf_id, link_up);
+	ice_ptp_link_change(pf, link_up);
 
 	if (ice_is_dcb_active(pf)) {
 		if (test_bit(ICE_FLAG_DCB_ENA, pf->flags))
@@ -6744,7 +6744,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, pf->hw.pf_id, true);
+		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7214,7 +7214,7 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false);
+		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ef2e858f49bb..7c6f81beaee4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -16,6 +16,18 @@ static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
 	{ "U.FL2", UFL2, PTP_PF_NONE, 2, { 0, } },
 };
 
+static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
+{
+	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+}
+
+static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
+{
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+
+	return !ctrl_pf ? NULL : &ctrl_pf->ptp;
+}
+
 /**
  * ice_get_sma_config_e810t
  * @hw: pointer to the hw struct
@@ -800,8 +812,8 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 	struct ice_ptp_port *port;
 	unsigned int i;
 
-	mutex_lock(&pf->ptp.ports_owner.lock);
-	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member) {
+	mutex_lock(&pf->adapter->ports.lock);
+	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
 		struct ice_ptp_tx *tx = &port->tx;
 
 		if (!tx || !tx->init)
@@ -809,7 +821,7 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 
 		ice_ptp_process_tx_tstamp(tx);
 	}
-	mutex_unlock(&pf->ptp.ports_owner.lock);
+	mutex_unlock(&pf->adapter->ports.lock);
 
 	for (i = 0; i < ICE_GET_QUAD_NUM(pf->hw.ptp.num_lports); i++) {
 		u64 tstamp_ready;
@@ -974,7 +986,7 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
 
-	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member)
+	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
 }
 
@@ -1363,7 +1375,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 
 	mutex_lock(&ptp_port->ps_lock);
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		err = ice_stop_phy_timer_eth56g(hw, port, true);
 		break;
@@ -1409,7 +1421,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 	mutex_lock(&ptp_port->ps_lock);
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		err = ice_start_phy_timer_eth56g(hw, port);
 		break;
@@ -1454,10 +1466,9 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 /**
  * ice_ptp_link_change - Reconfigure PTP after link status change
  * @pf: Board private structure
- * @port: Port for which the PHY start is set
  * @linkup: Link is up or down
  */
-void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
+void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
@@ -1465,14 +1476,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
-	if (WARN_ON_ONCE(port >= hw->ptp.num_lports))
-		return;
-
 	ptp_port = &pf->ptp.port;
-	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
-		port *= 2;
-	if (WARN_ON_ONCE(ptp_port->port_num != port))
-		return;
 
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
@@ -1480,8 +1484,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
 		return;
-
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_E810:
 		/* Do not reconfigure E810 PHY */
 		return;
@@ -1514,7 +1517,7 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 
 	ice_ptp_reset_ts_memory(hw);
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G: {
 		int port;
 
@@ -1553,7 +1556,7 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 	case ICE_PHY_UNSUP:
 	default:
 		dev_warn(dev, "%s: Unexpected PHY model %d\n", __func__,
-			 hw->ptp.phy_model);
+			 ice_get_phy_model(hw));
 		return -EOPNOTSUPP;
 	}
 }
@@ -1575,10 +1578,10 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
 	struct list_head *entry;
 
-	list_for_each(entry, &pf->ptp.ports_owner.ports) {
+	list_for_each(entry, &pf->adapter->ports.ports) {
 		struct ice_ptp_port *port = list_entry(entry,
 						       struct ice_ptp_port,
-						       list_member);
+						       list_node);
 
 		if (port->link_up)
 			ice_ptp_port_phy_restart(port);
@@ -2059,7 +2062,7 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* For Vernier mode on E82X, we need to recalibrate after new settime.
 	 * Start with marking timestamps as invalid.
 	 */
-	if (hw->ptp.phy_model == ICE_PHY_E82X) {
+	if (ice_get_phy_model(hw) == ICE_PHY_E82X) {
 		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
 		if (err)
 			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
@@ -2083,7 +2086,7 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	ice_ptp_enable_all_clkout(pf);
 
 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
-	if (hw->ptp.phy_model == ICE_PHY_E82X)
+	if (ice_get_phy_model(hw) == ICE_PHY_E82X)
 		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
@@ -2895,6 +2898,50 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
+static bool ice_is_primary(struct ice_hw *hw)
+{
+	return ice_is_e825c(hw) && ice_is_dual(hw) ?
+		!!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M) : true;
+}
+
+static int ice_ptp_setup_adapter(struct ice_pf *pf)
+{
+	if (!ice_pf_src_tmr_owned(pf) || !ice_is_primary(&pf->hw))
+		return -EPERM;
+
+	pf->adapter->ctrl_pf = pf;
+
+	return 0;
+}
+
+static int ice_ptp_setup_pf(struct ice_pf *pf)
+{
+	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
+	struct ice_ptp *ptp = &pf->ptp;
+
+	if (WARN_ON(!ctrl_ptp) || ice_get_phy_model(&pf->hw) == ICE_PHY_UNSUP)
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&ptp->port.list_node);
+	mutex_lock(&pf->adapter->ports.lock);
+
+	list_add(&ptp->port.list_node,
+		 &pf->adapter->ports.ports);
+	mutex_unlock(&pf->adapter->ports.lock);
+
+	return 0;
+}
+
+static void ice_ptp_cleanup_pf(struct ice_pf *pf)
+{
+	struct ice_ptp *ptp = &pf->ptp;
+
+	if (ice_get_phy_model(&pf->hw) != ICE_PHY_UNSUP) {
+		mutex_lock(&pf->adapter->ports.lock);
+		list_del(&ptp->port.list_node);
+		mutex_unlock(&pf->adapter->ports.lock);
+	}
+}
 /**
  * ice_ptp_aux_dev_to_aux_pf - Get auxiliary PF handle for the auxiliary device
  * @aux_dev: auxiliary device to get the auxiliary PF for
@@ -2946,9 +2993,9 @@ static int ice_ptp_auxbus_probe(struct auxiliary_device *aux_dev,
 	if (WARN_ON(!owner_pf))
 		return -ENODEV;
 
-	INIT_LIST_HEAD(&aux_pf->ptp.port.list_member);
+	INIT_LIST_HEAD(&aux_pf->ptp.port.list_node);
 	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_add(&aux_pf->ptp.port.list_member,
+	list_add(&aux_pf->ptp.port.list_node,
 		 &owner_pf->ptp.ports_owner.ports);
 	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
 
@@ -2965,7 +3012,7 @@ static void ice_ptp_auxbus_remove(struct auxiliary_device *aux_dev)
 	struct ice_pf *aux_pf = ice_ptp_aux_dev_to_aux_pf(aux_dev);
 
 	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_del(&aux_pf->ptp.port.list_member);
+	list_del(&aux_pf->ptp.port.list_node);
 	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
 }
 
@@ -3025,7 +3072,7 @@ ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
  * ice_ptp_register_auxbus_driver - Register PTP auxiliary bus driver
  * @pf: Board private structure
  */
-static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
+static int __always_unused ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver;
 	struct ice_ptp *ptp;
@@ -3068,7 +3115,7 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
  * ice_ptp_unregister_auxbus_driver - Unregister PTP auxiliary bus driver
  * @pf: Board private structure
  */
-static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
+static void __always_unused ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver = &pf->ptp.ports_owner.aux_driver;
 
@@ -3087,15 +3134,12 @@ static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
  */
 int ice_ptp_clock_index(struct ice_pf *pf)
 {
-	struct auxiliary_device *aux_dev;
-	struct ice_pf *owner_pf;
+	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ptp_clock *clock;
 
-	aux_dev = &pf->ptp.port.aux_dev;
-	owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
-	if (!owner_pf)
+	if (!ctrl_ptp)
 		return -1;
-	clock = owner_pf->ptp.clock;
+	clock = ctrl_ptp->clock;
 
 	return clock ? ptp_clock_index(clock) : -1;
 }
@@ -3155,15 +3199,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	if (err)
 		goto err_clk;
 
-	err = ice_ptp_register_auxbus_driver(pf);
-	if (err) {
-		dev_err(ice_pf_to_dev(pf), "Failed to register PTP auxbus driver");
-		goto err_aux;
-	}
-
 	return 0;
-err_aux:
-	ptp_clock_unregister(pf->ptp.clock);
 err_clk:
 	pf->ptp.clock = NULL;
 err_exit:
@@ -3209,7 +3245,7 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 
 	mutex_init(&ptp_port->ps_lock);
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
 					      ptp_port->port_num);
@@ -3239,7 +3275,7 @@ static void ice_ptp_release_auxbus_device(struct device *dev)
  * ice_ptp_create_auxbus_device - Create PTP auxiliary bus device
  * @pf: Board private structure
  */
-static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
+static __always_unused int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev;
 	struct ice_ptp *ptp;
@@ -3286,7 +3322,7 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
  * ice_ptp_remove_auxbus_device - Remove PTP auxiliary bus device
  * @pf: Board private structure
  */
-static void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
+static __always_unused void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev = &pf->ptp.port.aux_dev;
 
@@ -3307,7 +3343,7 @@ static void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
  */
 static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
 {
-	switch (pf->hw.ptp.phy_model) {
+	switch (ice_get_phy_model(&pf->hw)) {
 	case ICE_PHY_E82X:
 		/* E822 based PHY has the clock owner process the interrupt
 		 * for all ports.
@@ -3339,10 +3375,17 @@ void ice_ptp_init(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
-	int err;
+	int lane_num, err;
 
 	ptp->state = ICE_PTP_INITIALIZING;
 
+	lane_num = ice_get_phy_lane_number(hw);
+	if (lane_num < 0) {
+		err = lane_num;
+		goto err_exit;
+	}
+
+	ptp->port.port_num = (u8)lane_num;
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
@@ -3350,19 +3393,22 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
-	if (ice_pf_src_tmr_owned(pf)) {
+	if (ice_pf_src_tmr_owned(pf) && ice_is_primary(hw)) {
+		err = ice_ptp_setup_adapter(pf);
+		if (err)
+			goto err_exit;
 		err = ice_ptp_init_owner(pf);
 		if (err)
-			goto err;
+			goto err_exit;
 	}
 
-	ptp->port.port_num = hw->pf_id;
-	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
-		ptp->port.port_num = hw->pf_id * 2;
+	err = ice_ptp_setup_pf(pf);
+	if (err)
+		goto err_exit;
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err;
+		goto err_exit;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
@@ -3370,20 +3416,16 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
 
-	err = ice_ptp_create_auxbus_device(pf);
-	if (err)
-		goto err;
-
 	ptp->state = ICE_PTP_READY;
 
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
-		goto err;
+		goto err_exit;
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
-err:
+err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3410,7 +3452,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_disable_timestamp_mode(pf);
 
-	ice_ptp_remove_auxbus_device(pf);
+	ice_ptp_cleanup_pf(pf);
 
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
@@ -3425,9 +3467,6 @@ void ice_ptp_release(struct ice_pf *pf)
 		pf->ptp.kworker = NULL;
 	}
 
-	if (ice_pf_src_tmr_owned(pf))
-		ice_ptp_unregister_auxbus_driver(pf);
-
 	if (!pf->ptp.clock)
 		return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 2db2257a0fb2..f1cfa6aa4e76 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -169,7 +169,7 @@ struct ice_ptp_tx {
  * ready for PTP functionality. It is used to track the port initialization
  * and determine when the port's PHY offset is valid.
  *
- * @list_member: list member structure of auxiliary device
+ * @list_node: list member structure
  * @tx: Tx timestamp tracking for this port
  * @aux_dev: auxiliary device associated with this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
@@ -179,7 +179,7 @@ struct ice_ptp_tx {
  * @port_num: the port number this structure represents
  */
 struct ice_ptp_port {
-	struct list_head list_member;
+	struct list_head list_node;
 	struct ice_ptp_tx tx;
 	struct auxiliary_device aux_dev;
 	struct kthread_delayed_work ov_work;
@@ -205,6 +205,7 @@ enum ice_ptp_tx_interrupt {
  * @ports: list of porst handled by this port owner
  * @lock: protect access to ports list
  */
+
 struct ice_ptp_port_owner {
 	struct auxiliary_driver aux_driver;
 	struct list_head ports;
@@ -331,7 +332,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 			       enum ice_reset_req reset_type);
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
-void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup);
+void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 {
@@ -379,7 +380,7 @@ static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 }
 static inline void ice_ptp_init(struct ice_pf *pf) { }
 static inline void ice_ptp_release(struct ice_pf *pf) { }
-static inline void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
+static inline void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 3005dd252a10..bdb1020147d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -131,7 +131,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3816e45b6ab4..7190fde16c86 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -804,7 +804,7 @@ static u32 ice_ptp_tmr_cmd_to_port_reg(struct ice_hw *hw,
 	/* Certain hardware families share the same register values for the
 	 * port register and source timer register.
 	 */
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_E810:
 		return ice_ptp_tmr_cmd_to_src_reg(hw, cmd) & TS_CMD_MASK_E810;
 	default:
@@ -877,31 +877,46 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
  * The following functions operate on devices with the ETH 56G PHY.
  */
 
+/**
+ * ice_ptp_get_dest_dev_e825 - get destination PHY for given port number
+ * @hw: pointer to the HW struct
+ * @port: destination port
+ *
+ * Return: destination sideband queue PHY device.
+ */
+static enum ice_sbq_msg_dev ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
+						      u8 port)
+{
+	/* On a single complex E825, PHY 0 is always destination device phy_0
+	 * and PHY 1 is phy_0_peer.
+	 */
+	if (port >= hw->ptp.ports_per_phy)
+		return eth56g_phy_1;
+	else
+		return eth56g_phy_0;
+}
+
 /**
  * ice_write_phy_eth56g - Write a PHY port register
  * @hw: pointer to the HW struct
- * @phy_idx: PHY index
+ * @port: destination port
  * @addr: PHY register address
  * @val: Value to write
  *
  * Return: 0 on success, other error codes when failed to write to PHY
  */
-static int ice_write_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
-				u32 val)
+static int ice_write_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 val)
 {
-	struct ice_sbq_msg_input phy_msg;
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
+		.opcode = ice_sbq_msg_wr,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+		.data = val
+	};
 	int err;
 
-	phy_msg.opcode = ice_sbq_msg_wr;
-
-	phy_msg.msg_addr_low = lower_16_bits(addr);
-	phy_msg.msg_addr_high = upper_16_bits(addr);
-
-	phy_msg.data = val;
-	phy_msg.dest_dev = hw->ptp.phy.eth56g.phy_addr[phy_idx];
-
-	err = ice_sbq_rw_reg(hw, &phy_msg, ICE_AQ_FLAG_RD);
-
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err)
 		ice_debug(hw, ICE_DBG_PTP, "PTP failed to send msg to phy %d\n",
 			  err);
@@ -912,41 +927,36 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
 /**
  * ice_read_phy_eth56g - Read a PHY port register
  * @hw: pointer to the HW struct
- * @phy_idx: PHY index
+ * @port: destination port
  * @addr: PHY register address
  * @val: Value to write
  *
  * Return: 0 on success, other error codes when failed to read from PHY
  */
-static int ice_read_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
-			       u32 *val)
+static int ice_read_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 *val)
 {
-	struct ice_sbq_msg_input phy_msg;
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
+		.opcode = ice_sbq_msg_rd,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr)
+	};
 	int err;
 
-	phy_msg.opcode = ice_sbq_msg_rd;
-
-	phy_msg.msg_addr_low = lower_16_bits(addr);
-	phy_msg.msg_addr_high = upper_16_bits(addr);
-
-	phy_msg.data = 0;
-	phy_msg.dest_dev = hw->ptp.phy.eth56g.phy_addr[phy_idx];
-
-	err = ice_sbq_rw_reg(hw, &phy_msg, ICE_AQ_FLAG_RD);
-	if (err) {
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
+	if (err)
 		ice_debug(hw, ICE_DBG_PTP, "PTP failed to send msg to phy %d\n",
 			  err);
-		return err;
-	}
-
-	*val = phy_msg.data;
+	else
+		*val = msg.data;
 
-	return 0;
+	return err;
 }
 
 /**
  * ice_phy_res_address_eth56g - Calculate a PHY port register address
- * @port: Port number to be written
+ * @hw: pointer to the HW struct
+ * @lane: Lane number to be written
  * @res_type: resource type (register/memory)
  * @offset: Offset from PHY port register base
  * @addr: The result address
@@ -955,17 +965,19 @@ static int ice_read_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
  * * %0      - success
  * * %EINVAL - invalid port number or resource type
  */
-static int ice_phy_res_address_eth56g(u8 port, enum eth56g_res_type res_type,
-				      u32 offset, u32 *addr)
+static int ice_phy_res_address_eth56g(struct ice_hw *hw, u8 lane,
+				      enum eth56g_res_type res_type,
+				      u32 offset,
+				      u32 *addr)
 {
-	u8 lane = port % ICE_PORTS_PER_QUAD;
-	u8 phy = ICE_GET_QUAD_NUM(port);
-
 	if (res_type >= NUM_ETH56G_PHY_RES)
 		return -EINVAL;
 
-	*addr = eth56g_phy_res[res_type].base[phy] +
+	/* Lanes 4..7 are in fact 0..3 on a second PHY */
+	lane %= hw->ptp.ports_per_phy;
+	*addr = eth56g_phy_res[res_type].base[0] +
 		lane * eth56g_phy_res[res_type].step + offset;
+
 	return 0;
 }
 
@@ -985,19 +997,17 @@ static int ice_phy_res_address_eth56g(u8 port, enum eth56g_res_type res_type,
 static int ice_write_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
 				 u32 val, enum eth56g_res_type res_type)
 {
-	u8 phy_port = port % hw->ptp.ports_per_phy;
-	u8 phy_idx = port / hw->ptp.ports_per_phy;
 	u32 addr;
 	int err;
 
 	if (port >= hw->ptp.num_lports)
 		return -EINVAL;
 
-	err = ice_phy_res_address_eth56g(phy_port, res_type, offset, &addr);
+	err = ice_phy_res_address_eth56g(hw, port, res_type, offset, &addr);
 	if (err)
 		return err;
 
-	return ice_write_phy_eth56g(hw, phy_idx, addr, val);
+	return ice_write_phy_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -1016,19 +1026,17 @@ static int ice_write_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
 static int ice_read_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
 				u32 *val, enum eth56g_res_type res_type)
 {
-	u8 phy_port = port % hw->ptp.ports_per_phy;
-	u8 phy_idx = port / hw->ptp.ports_per_phy;
 	u32 addr;
 	int err;
 
 	if (port >= hw->ptp.num_lports)
 		return -EINVAL;
 
-	err = ice_phy_res_address_eth56g(phy_port, res_type, offset, &addr);
+	err = ice_phy_res_address_eth56g(hw, port, res_type, offset, &addr);
 	if (err)
 		return err;
 
-	return ice_read_phy_eth56g(hw, phy_idx, addr, val);
+	return ice_read_phy_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -1177,6 +1185,56 @@ static int ice_write_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
 	return ice_write_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
 }
 
+/**
+ * ice_write_quad_ptp_reg_eth56g - Write a PHY quad register
+ * @hw: pointer to the HW struct
+ * @offset: PHY register offset
+ * @port: Port number
+ * @val: Value to write
+ *
+ * Return:
+ * * %0     - success
+ * * %EIO  - invalid port number or resource type
+ * * %other - failed to write to PHY
+ */
+static int ice_write_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
+					 u32 offset, u32 val)
+{
+	u32 addr;
+
+	if (port >= hw->ptp.num_lports)
+		return -EIO;
+
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+
+	return ice_write_phy_eth56g(hw, port, addr, val);
+}
+
+/**
+ * ice_read_quad_ptp_reg_eth56g - Read a PHY quad register
+ * @hw: pointer to the HW struct
+ * @offset: PHY register offset
+ * @port: Port number
+ * @val: Value to read
+ *
+ * Return:
+ * * %0     - success
+ * * %EIO  - invalid port number or resource type
+ * * %other - failed to read from PHY
+ */
+static int ice_read_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
+					u32 offset, u32 *val)
+{
+	u32 addr;
+
+	if (port >= hw->ptp.num_lports)
+		return -EIO;
+
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+
+	return ice_read_phy_eth56g(hw, port, addr, val);
+}
+
 /**
  * ice_is_64b_phy_reg_eth56g - Check if this is a 64bit PHY register
  * @low_addr: the low address to check
@@ -1896,7 +1954,6 @@ ice_phy_get_speed_eth56g(struct ice_link_status *li)
  */
 static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 {
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
 	u32 val;
 	int err;
 
@@ -1911,8 +1968,8 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 	switch (ice_phy_get_speed_eth56g(&hw->port_info->phy.link_info)) {
 	case ICE_ETH56G_LNK_SPD_1G:
 	case ICE_ETH56G_LNK_SPD_2_5G:
-		err = ice_read_ptp_reg_eth56g(hw, port_blk,
-					      PHY_GPCS_CONFIG_REG0, &val);
+		err = ice_read_quad_ptp_reg_eth56g(hw, port,
+						   PHY_GPCS_CONFIG_REG0, &val);
 		if (err) {
 			ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_GPCS_CONFIG_REG0, status: %d",
 				  err);
@@ -1923,8 +1980,8 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 		val |= FIELD_PREP(PHY_GPCS_CONFIG_REG0_TX_THR_M,
 				  ICE_ETH56G_NOMINAL_TX_THRESH);
 
-		err = ice_write_ptp_reg_eth56g(hw, port_blk,
-					       PHY_GPCS_CONFIG_REG0, val);
+		err = ice_write_quad_ptp_reg_eth56g(hw, port,
+						    PHY_GPCS_CONFIG_REG0, val);
 		if (err) {
 			ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_GPCS_CONFIG_REG0, status: %d",
 				  err);
@@ -1965,50 +2022,47 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
  */
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port)
 {
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
-	u8 blk_port = port & (ICE_PORTS_PER_QUAD - 1);
+	u8 quad_lane = port % ICE_PORTS_PER_QUAD;
+	u32 addr, val, peer_delay;
 	bool enable, sfd_ena;
-	u32 val, peer_delay;
 	int err;
 
 	enable = hw->ptp.phy.eth56g.onestep_ena;
 	peer_delay = hw->ptp.phy.eth56g.peer_delay;
 	sfd_ena = hw->ptp.phy.eth56g.sfd_ena;
 
-	/* PHY_PTP_1STEP_CONFIG */
-	err = ice_read_ptp_reg_eth56g(hw, port_blk, PHY_PTP_1STEP_CONFIG, &val);
+	addr = PHY_PTP_1STEP_CONFIG;
+	err = ice_read_quad_ptp_reg_eth56g(hw, port, addr, &val);
 	if (err)
 		return err;
 
 	if (enable)
-		val |= blk_port;
+		val |= BIT(quad_lane);
 	else
-		val &= ~blk_port;
+		val &= ~BIT(quad_lane);
 
 	val &= ~(PHY_PTP_1STEP_T1S_UP64_M | PHY_PTP_1STEP_T1S_DELTA_M);
 
-	err = ice_write_ptp_reg_eth56g(hw, port_blk, PHY_PTP_1STEP_CONFIG, val);
+	err = ice_write_quad_ptp_reg_eth56g(hw, port, addr, val);
 	if (err)
 		return err;
 
-	/* PHY_PTP_1STEP_PEER_DELAY */
+	addr = PHY_PTP_1STEP_PEER_DELAY(quad_lane);
 	val = FIELD_PREP(PHY_PTP_1STEP_PD_DELAY_M, peer_delay);
 	if (peer_delay)
 		val |= PHY_PTP_1STEP_PD_ADD_PD_M;
 	val |= PHY_PTP_1STEP_PD_DLY_V_M;
-	err = ice_write_ptp_reg_eth56g(hw, port_blk,
-				       PHY_PTP_1STEP_PEER_DELAY(blk_port), val);
+	err = ice_write_quad_ptp_reg_eth56g(hw, port, addr, val);
 	if (err)
 		return err;
 
 	val &= ~PHY_PTP_1STEP_PD_DLY_V_M;
-	err = ice_write_ptp_reg_eth56g(hw, port_blk,
-				       PHY_PTP_1STEP_PEER_DELAY(blk_port), val);
+	err = ice_write_quad_ptp_reg_eth56g(hw, port, addr, val);
 	if (err)
 		return err;
 
-	/* PHY_MAC_XIF_MODE */
-	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	addr = PHY_MAC_XIF_MODE;
+	err = ice_read_mac_reg_eth56g(hw, port, addr, &val);
 	if (err)
 		return err;
 
@@ -2028,7 +2082,7 @@ int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port)
 	       FIELD_PREP(PHY_MAC_XIF_TS_BIN_MODE_M, enable) |
 	       FIELD_PREP(PHY_MAC_XIF_TS_SFD_ENA_M, sfd_ena);
 
-	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
+	return ice_write_mac_reg_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -2070,21 +2124,22 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
 				       bool fc, bool rs,
 				       enum ice_eth56g_link_spd spd)
 {
-	u8 port_offset = port & (ICE_PORTS_PER_QUAD - 1);
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
 	u32 bitslip;
 	int err;
 
 	if (!bs || rs)
 		return 0;
 
-	if (spd == ICE_ETH56G_LNK_SPD_1G || spd == ICE_ETH56G_LNK_SPD_2_5G)
+	if (spd == ICE_ETH56G_LNK_SPD_1G || spd == ICE_ETH56G_LNK_SPD_2_5G) {
 		err = ice_read_gpcs_reg_eth56g(hw, port, PHY_GPCS_BITSLIP,
 					       &bitslip);
-	else
-		err = ice_read_ptp_reg_eth56g(hw, port_blk,
-					      PHY_REG_SD_BIT_SLIP(port_offset),
-					      &bitslip);
+	} else {
+		u8 quad_lane = port % ICE_PORTS_PER_QUAD;
+		u32 addr;
+
+		addr = PHY_REG_SD_BIT_SLIP(quad_lane);
+		err = ice_read_quad_ptp_reg_eth56g(hw, port, addr, &bitslip);
+	}
 	if (err)
 		return 0;
 
@@ -2644,59 +2699,29 @@ static int ice_get_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw, u8 port,
 }
 
 /**
- * ice_is_muxed_topo - detect breakout 2x50G topology for E825C
- * @hw: pointer to the HW struct
- *
- * Return: true if it's 2x50 breakout topology, false otherwise
- */
-static bool ice_is_muxed_topo(struct ice_hw *hw)
-{
-	u8 link_topo;
-	bool mux;
-	u32 val;
-
-	val = rd32(hw, GLGEN_SWITCH_MODE_CONFIG);
-	mux = FIELD_GET(GLGEN_SWITCH_MODE_CONFIG_25X4_QUAD_M, val);
-	val = rd32(hw, GLGEN_MAC_LINK_TOPO);
-	link_topo = FIELD_GET(GLGEN_MAC_LINK_TOPO_LINK_TOPO_M, val);
-
-	return (mux && link_topo == ICE_LINK_TOPO_UP_TO_2_LINKS);
-}
-
-/**
- * ice_ptp_init_phy_e825c - initialize PHY parameters
+ * ice_ptp_init_phy_e825 - initialize PHY parameters
  * @hw: pointer to the HW struct
  */
-static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
+static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 {
 	struct ice_ptp_hw *ptp = &hw->ptp;
 	struct ice_eth56g_params *params;
-	u8 phy;
+	u32 phy_rev;
+	int err;
 
 	ptp->phy_model = ICE_PHY_ETH56G;
 	params = &ptp->phy.eth56g;
 	params->onestep_ena = false;
 	params->peer_delay = 0;
 	params->sfd_ena = false;
-	params->phy_addr[0] = eth56g_phy_0;
-	params->phy_addr[1] = eth56g_phy_1;
 	params->num_phys = 2;
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
 
 	ice_sb_access_ena_eth56g(hw, true);
-	for (phy = 0; phy < params->num_phys; phy++) {
-		u32 phy_rev;
-		int err;
-
-		err = ice_read_phy_eth56g(hw, phy, PHY_REG_REVISION, &phy_rev);
-		if (err || phy_rev != PHY_REVISION_ETH56G) {
-			ptp->phy_model = ICE_PHY_UNSUP;
-			return;
-		}
-	}
-
-	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
+	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
+	if (err || phy_rev != PHY_REVISION_ETH56G)
+		ptp->phy_model = ICE_PHY_UNSUP;
 }
 
 /* E822 family functions
@@ -2715,10 +2740,9 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 				  struct ice_sbq_msg_input *msg, u8 port,
 				  u16 offset)
 {
-	int phy_port, phy, quadtype;
+	int phy_port, quadtype;
 
 	phy_port = port % hw->ptp.ports_per_phy;
-	phy = port / hw->ptp.ports_per_phy;
 	quadtype = ICE_GET_QUAD_NUM(port) %
 		   ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy);
 
@@ -2730,12 +2754,7 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 		msg->msg_addr_high = P_Q1_H(P_4_BASE + offset, phy_port);
 	}
 
-	if (phy == 0)
-		msg->dest_dev = rmn_0;
-	else if (phy == 1)
-		msg->dest_dev = rmn_1;
-	else
-		msg->dest_dev = rmn_2;
+	msg->dest_dev = rmn_0;
 }
 
 /**
@@ -5395,7 +5414,7 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 	else if (ice_is_e810(hw))
 		ice_ptp_init_phy_e810(ptp);
 	else if (ice_is_e825c(hw))
-		ice_ptp_init_phy_e825c(hw);
+		ice_ptp_init_phy_e825(hw);
 	else
 		ptp->phy_model = ICE_PHY_UNSUP;
 }
@@ -5418,7 +5437,7 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 static int ice_ptp_write_port_cmd(struct ice_hw *hw, u8 port,
 				  enum ice_ptp_tmr_cmd cmd)
 {
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		return ice_ptp_write_port_cmd_eth56g(hw, port, cmd);
 	case ICE_PHY_E82X:
@@ -5483,7 +5502,7 @@ static int ice_ptp_port_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	u32 port;
 
 	/* PHY models which can program all ports simultaneously */
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_E810:
 		return ice_ptp_port_cmd_e810(hw, cmd);
 	default:
@@ -5562,7 +5581,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 
 	/* PHY timers */
 	/* Fill Rx and Tx ports and send msg to PHY */
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		err = ice_ptp_prep_phy_time_eth56g(hw,
 						   (u32)(time & 0xFFFFFFFF));
@@ -5608,7 +5627,7 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), lower_32_bits(incval));
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), upper_32_bits(incval));
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		err = ice_ptp_prep_phy_incval_eth56g(hw, incval);
 		break;
@@ -5677,7 +5696,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), 0);
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), adj);
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		err = ice_ptp_prep_phy_adj_eth56g(hw, adj);
 		break;
@@ -5710,7 +5729,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
  */
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
 {
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		return ice_read_ptp_tstamp_eth56g(hw, block, idx, tstamp);
 	case ICE_PHY_E810:
@@ -5740,7 +5759,7 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
  */
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 {
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
 	case ICE_PHY_E810:
@@ -5803,7 +5822,7 @@ static int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
  */
 void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 {
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		ice_ptp_reset_ts_memory_eth56g(hw);
 		break;
@@ -5832,7 +5851,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	/* Clear event err indications for auxiliary pins */
 	(void)rd32(hw, GLTSYN_STAT(src_idx));
 
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		return ice_ptp_init_phc_eth56g(hw);
 	case ICE_PHY_E810:
@@ -5857,7 +5876,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
  */
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
 {
-	switch (hw->ptp.phy_model) {
+	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_ETH56G:
 		return ice_get_phy_tx_tstamp_ready_eth56g(hw, block,
 							  tstamp_ready);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 4c8b84571344..3499062218b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -452,6 +452,11 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 	}
 }
 
+static inline bool ice_is_dual(struct ice_hw *hw)
+{
+	return !!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_DUAL_M);
+}
+
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 45768796691f..609f31e0dfde 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -850,7 +850,6 @@ struct ice_mbx_data {
 
 struct ice_eth56g_params {
 	u8 num_phys;
-	u8 phy_addr[2];
 	bool onestep_ena;
 	bool sfd_ena;
 	u32 peer_delay;
@@ -881,7 +880,6 @@ struct ice_ptp_hw {
 	union ice_phy_params phy;
 	u8 num_lports;
 	u8 ports_per_phy;
-	bool is_2x50g_muxed_topo;
 };
 
 /* Port hardware description */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index ca92e518be76..1baf8933a07c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -724,6 +724,12 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	/* check esn */
 	if (x->props.flags & XFRM_STATE_ESN)
 		mlx5e_ipsec_update_esn_state(sa_entry);
+	else
+		/* According to RFC4303, section "3.3.3. Sequence Number Generation",
+		 * the first packet sent using a given SA will contain a sequence
+		 * number of 1.
+		 */
+		sa_entry->esn_state.esn = 1;
 
 	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &sa_entry->attrs);
 
@@ -768,9 +774,12 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 				   MLX5_IPSEC_RESCHED);
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
-	    x->props.mode == XFRM_MODE_TUNNEL)
-		xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
-			    MLX5E_IPSEC_TUNNEL_SA);
+	    x->props.mode == XFRM_MODE_TUNNEL) {
+		xa_lock_bh(&ipsec->sadb);
+		__xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
+			      MLX5E_IPSEC_TUNNEL_SA);
+		xa_unlock_bh(&ipsec->sadb);
+	}
 
 out:
 	x->xso.offload_handle = (unsigned long)sa_entry;
@@ -797,7 +806,6 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
-	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
 	struct mlx5e_ipsec_sa_entry *old;
 
@@ -806,12 +814,6 @@ static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 
 	old = xa_erase_bh(&ipsec->sadb, sa_entry->ipsec_obj_id);
 	WARN_ON(old != sa_entry);
-
-	if (attrs->mode == XFRM_MODE_TUNNEL &&
-	    attrs->type == XFRM_DEV_OFFLOAD_PACKET)
-		/* Make sure that no ARP requests are running in parallel */
-		flush_workqueue(ipsec->wq);
-
 }
 
 static void mlx5e_xfrm_free_state(struct xfrm_state *x)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e51b03d4c717..57861d34d46f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1718,23 +1718,21 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		goto err_alloc;
 	}
 
-	if (attrs->family == AF_INET)
-		setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
-	else
-		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
-
 	setup_fte_no_frags(spec);
 	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
 	switch (attrs->type) {
 	case XFRM_DEV_OFFLOAD_CRYPTO:
+		if (attrs->family == AF_INET)
+			setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
+		else
+			setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
 		setup_fte_spi(spec, attrs->spi, false);
 		setup_fte_esp(spec);
 		setup_fte_reg_a(spec);
 		break;
 	case XFRM_DEV_OFFLOAD_PACKET:
-		if (attrs->reqid)
-			setup_fte_reg_c4(spec, attrs->reqid);
+		setup_fte_reg_c4(spec, attrs->reqid);
 		err = setup_pkt_reformat(ipsec, attrs, &flow_act);
 		if (err)
 			goto err_pkt_reformat;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 53cfa39188cb..820debf3fbbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -91,8 +91,9 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 EXPORT_SYMBOL_GPL(mlx5_ipsec_device_caps);
 
 static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
-				     struct mlx5_accel_esp_xfrm_attrs *attrs)
+				     struct mlx5e_ipsec_sa_entry *sa_entry)
 {
+	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
 	void *aso_ctx;
 
 	aso_ctx = MLX5_ADDR_OF(ipsec_obj, obj, ipsec_aso);
@@ -120,8 +121,12 @@ static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
 	 * active.
 	 */
 	MLX5_SET(ipsec_obj, obj, aso_return_reg, MLX5_IPSEC_ASO_REG_C_4_5);
-	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
+	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT) {
 		MLX5_SET(ipsec_aso, aso_ctx, mode, MLX5_IPSEC_ASO_INC_SN);
+		if (!attrs->replay_esn.trigger)
+			MLX5_SET(ipsec_aso, aso_ctx, mode_parameter,
+				 sa_entry->esn_state.esn);
+	}
 
 	if (attrs->lft.hard_packet_limit != XFRM_INF) {
 		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_pkt_cnt,
@@ -175,7 +180,7 @@ static int mlx5_create_ipsec_obj(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	res = &mdev->mlx5e_res.hw_objs;
 	if (attrs->type == XFRM_DEV_OFFLOAD_PACKET)
-		mlx5e_ipsec_packet_setup(obj, res->pdn, attrs);
+		mlx5e_ipsec_packet_setup(obj, res->pdn, sa_entry);
 
 	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 	if (!err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2eabfcc247c6..0ce999706d41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2709,6 +2709,7 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		root_ns = steering->rdma_tx_root_ns;
+		prio = RDMA_TX_BYPASS_PRIO;
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS:
 		root_ns = steering->rdma_rx_root_ns;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index ab2717012b79..39e80704b1c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -530,7 +530,7 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 	set_tt_map(port_sel, hash_type);
 	err = mlx5_lag_create_definers(ldev, hash_type, ports);
 	if (err)
-		return err;
+		goto clear_port_sel;
 
 	if (port_sel->tunnel) {
 		err = mlx5_lag_create_inner_ttc_table(ldev);
@@ -549,6 +549,8 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 		mlx5_destroy_ttc_table(port_sel->inner.ttc);
 destroy_definers:
 	mlx5_lag_destroy_definers(ldev);
+clear_port_sel:
+	memset(port_sel, 0, sizeof(*port_sel));
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index a96be98be032..b96909fbeb12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -257,6 +257,7 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 	return 0;
 
 esw_err:
+	mlx5_sf_function_id_erase(table, sf);
 	mlx5_sf_free(table, sf);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 1bed75eca97d..740b719e7072 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -382,6 +382,7 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 
 bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
 {
+	struct mutex *wc_state_lock = &mdev->wc_state_lock;
 	struct mlx5_core_dev *parent = NULL;
 
 	if (!MLX5_CAP_GEN(mdev, bf)) {
@@ -400,32 +401,31 @@ bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
 		 */
 		goto out;
 
-	mutex_lock(&mdev->wc_state_lock);
-
-	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
-		goto unlock;
-
 #ifdef CONFIG_MLX5_SF
-	if (mlx5_core_is_sf(mdev))
+	if (mlx5_core_is_sf(mdev)) {
 		parent = mdev->priv.parent_mdev;
+		wc_state_lock = &parent->wc_state_lock;
+	}
 #endif
 
-	if (parent) {
-		mutex_lock(&parent->wc_state_lock);
+	mutex_lock(wc_state_lock);
 
+	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
+		goto unlock;
+
+	if (parent) {
 		mlx5_core_test_wc(parent);
 
 		mlx5_core_dbg(mdev, "parent set wc_state=%d\n",
 			      parent->wc_state);
 		mdev->wc_state = parent->wc_state;
 
-		mutex_unlock(&parent->wc_state_lock);
+	} else {
+		mlx5_core_test_wc(mdev);
 	}
 
-	mlx5_core_test_wc(mdev);
-
 unlock:
-	mutex_unlock(&mdev->wc_state_lock);
+	mutex_unlock(wc_state_lock);
 out:
 	mlx5_core_dbg(mdev, "wc_state=%d\n", mdev->wc_state);
 
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index 9d97cd281f18..c03558adda91 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -458,7 +458,8 @@ int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
 	map_id_full = be64_to_cpu(cbe->map_ptr);
 	map_id = map_id_full;
 
-	if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
+	if (size_add(pkt_size, data_size) > INT_MAX ||
+	    len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
 		return -EINVAL;
 	if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 907af4651c55..6f6b0566c65b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2756,6 +2756,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
+	.tx_max_frame_size = SZ_2K,
 	.rx_max_frame_size = SZ_2K,
 	.rx_buffer_size = SZ_2K +
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 8d02d2b21429..dc5e247ca5d1 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -127,15 +127,15 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 	u32 hi_val = 0;
 
 	idx    = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be fetched exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+		index = 2 - idx2; /* flip */
+		hi_val = ale_entry[index] << ((idx2 * 32) - start);
 	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
@@ -145,16 +145,16 @@ static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 
 	value &= BITMASK(bits);
 	idx = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be set exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
-		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+		index = 2 - idx2; /* flip */
+		ale_entry[index] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[index] |= (value >> ((idx2 * 32) - start));
 	}
 	start -= idx * 32;
 	idx = 2 - idx; /* flip */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1fcbcaa85ebd..de10a2d08c42 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2056,6 +2056,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EBUSY;
 	}
 
+	if (ecoalesce->rx_max_coalesced_frames > 255 ||
+	    ecoalesce->tx_max_coalesced_frames > 255) {
+		NL_SET_ERR_MSG(extack, "frames must be less than 256");
+		return -EINVAL;
+	}
+
 	if (ecoalesce->rx_max_coalesced_frames)
 		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
 	if (ecoalesce->rx_coalesce_usecs)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 70f981887518..47406ce99016 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1526,8 +1526,8 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		goto out_encap;
 	}
 
-	gn = net_generic(dev_net(dev), gtp_net_id);
-	list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+	gn = net_generic(src_net, gtp_net_id);
+	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
 	netdev_dbg(dev, "registered new GTP interface\n");
@@ -1553,7 +1553,7 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
-	list_del_rcu(&gtp->list);
+	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -2279,16 +2279,19 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
-	struct gtp_net *gn;
-
-	gn = net_generic(net, gtp_net_id);
 
 	if (cb->args[4])
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
+		gtp = netdev_priv(dev);
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
@@ -2483,9 +2486,14 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
-		struct gtp_dev *gtp;
+		struct gtp_dev *gtp, *gtp_next;
+		struct net_device *dev;
+
+		for_each_netdev(net, dev)
+			if (dev->rtnl_link_ops == &gtp_link_ops)
+				gtp_dellink(dev, dev_to_kill);
 
-		list_for_each_entry(gtp, &gn->gtp_dev_list, list)
+		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
 	}
 }
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..68d0d9e92a22 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -206,8 +206,8 @@ static int pfcp_newlink(struct net *net, struct net_device *dev,
 		goto exit_del_pfcp_sock;
 	}
 
-	pn = net_generic(dev_net(dev), pfcp_net_id);
-	list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
+	pn = net_generic(net, pfcp_net_id);
+	list_add(&pfcp->list, &pn->pfcp_dev_list);
 
 	netdev_dbg(dev, "registered new PFCP interface\n");
 
@@ -224,7 +224,7 @@ static void pfcp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 
-	list_del_rcu(&pfcp->list);
+	list_del(&pfcp->list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -247,11 +247,16 @@ static int __net_init pfcp_net_init(struct net *net)
 static void __net_exit pfcp_net_exit(struct net *net)
 {
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
-	struct pfcp_dev *pfcp;
+	struct pfcp_dev *pfcp, *pfcp_next;
+	struct net_device *dev;
 	LIST_HEAD(list);
 
 	rtnl_lock();
-	list_for_each_entry(pfcp, &pn->pfcp_dev_list, list)
+	for_each_netdev(net, dev)
+		if (dev->rtnl_link_ops == &pfcp_link_ops)
+			pfcp_dellink(dev, &list);
+
+	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
 		pfcp_dellink(pfcp->dev, &list);
 
 	unregister_netdevice_many(&list);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..eaf31c823cbe 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index 3995f90add45..c45bc332af7a 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -283,6 +283,9 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	init_waitqueue_head(&dell_bl->wait_queue);
 	dell_bl->dev = dev;
 
+	serdev_device_set_drvdata(serdev, dell_bl);
+	serdev_device_set_client_ops(serdev, &dell_uart_bl_serdev_ops);
+
 	ret = devm_serdev_device_open(dev, serdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "opening UART device\n");
@@ -290,8 +293,6 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	/* 9600 bps, no flow control, these are the default but set them to be sure */
 	serdev_device_set_baudrate(serdev, 9600);
 	serdev_device_set_flow_control(serdev, false);
-	serdev_device_set_drvdata(serdev, dell_bl);
-	serdev_device_set_client_ops(serdev, &dell_uart_bl_serdev_ops);
 
 	get_version[0] = DELL_SOF(GET_CMD_LEN);
 	get_version[1] = CMD_GET_VERSION;
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 1e46e30dae96..dbcd3087aaa4 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -804,6 +804,7 @@ EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
 static const struct x86_cpu_id isst_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	0),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 0609a8320f7e..12fb0943b5dc 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -81,6 +81,7 @@ static const struct x86_cpu_id tpmi_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	NULL),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	NULL),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	NULL),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	NULL),
 	X86_MATCH_VFM(INTEL_PANTHERCOVE_X,	NULL),
 	{}
diff --git a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
index d525bdc8ca9b..32d9b6009c42 100644
--- a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
@@ -199,14 +199,15 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	if (ret)
 		return ret;
 
+	serdev_device_set_drvdata(serdev, fc);
+	serdev_device_set_client_ops(serdev, &yt2_1380_fc_serdev_ops);
+
 	ret = devm_serdev_device_open(dev, serdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "opening UART device\n");
 
 	serdev_device_set_baudrate(serdev, 600);
 	serdev_device_set_flow_control(serdev, false);
-	serdev_device_set_drvdata(serdev, fc);
-	serdev_device_set_client_ops(serdev, &yt2_1380_fc_serdev_ops);
 
 	ret = devm_extcon_register_notifier_all(dev, fc->extcon, &fc->nb);
 	if (ret)
diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index 77e889165eed..a19e806bb147 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 1cd157f4f03b..4e2ac1f0060c 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -176,6 +176,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
+	device_set_of_node_from_dev(&vdev->dev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 05b936ad353b..6cc9e61cca07 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10589,14 +10589,17 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	}
 
 	/*
-	 * Set the default power management level for runtime and system PM.
+	 * Set the default power management level for runtime and system PM if
+	 * not set by the host controller drivers.
 	 * Default power saving mode is to keep UFS link in Hibern8 state
 	 * and UFS device in sleep state.
 	 */
-	hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
+	if (!hba->rpm_lvl)
+		hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
 						UFS_SLEEP_PWR_MODE,
 						UIC_LINK_HIBERN8_STATE);
-	hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
+	if (!hba->spm_lvl)
+		hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
 						UFS_SLEEP_PWR_MODE,
 						UIC_LINK_HIBERN8_STATE);
 
diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index a189ff8a5034..c0384201b8fe 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -413,8 +413,10 @@ int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size)
 
 	do {
 		argc = afs_split_string(&buf, argv, ARRAY_SIZE(argv));
-		if (argc < 0)
-			return argc;
+		if (argc < 0) {
+			ret = argc;
+			goto done;
+		}
 		if (argc < 2)
 			goto inval;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0c4d14c59ebe..395b8b880ce7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -797,6 +797,10 @@ static int get_canonical_dev_path(const char *dev_path, char *canonical)
 	if (ret)
 		goto out;
 	resolved_path = d_path(&path, path_buf, PATH_MAX);
+	if (IS_ERR(resolved_path)) {
+		ret = PTR_ERR(resolved_path);
+		goto out;
+	}
 	ret = strscpy(canonical, resolved_path, PATH_MAX);
 out:
 	kfree(path_buf);
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..1806bff8e59b 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 #include <linux/statfs.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -576,7 +577,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 {
-	char *secctx;
+	int err;
 
 	_enter(",%s", args);
 
@@ -585,16 +586,16 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 		return -EINVAL;
 	}
 
-	if (cache->secctx) {
+	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
 		return -EINVAL;
 	}
 
-	secctx = kstrdup(args, GFP_KERNEL);
-	if (!secctx)
-		return -ENOMEM;
+	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
+	if (err)
+		return err;
 
-	cache->secctx = secctx;
+	cache->have_secid = true;
 	return 0;
 }
 
@@ -820,7 +821,6 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
-	kfree(cache->secctx);
 	kfree(cache->tag);
 
 	_leave("");
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7b99bd98de75..38c236e38cef 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -122,7 +122,6 @@ struct cachefiles_cache {
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
 #define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
-	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
@@ -130,6 +129,8 @@ struct cachefiles_cache {
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 	u32				msg_id_next;
+	u32				secid;		/* LSM security id */
+	bool				have_secid;	/* whether "secid" was set */
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d8..fc6611886b3b 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -18,7 +18,7 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 	struct cred *new;
 	int ret;
 
-	_enter("{%s}", cache->secctx);
+	_enter("{%u}", cache->have_secid ? cache->secid : 0);
 
 	new = prepare_kernel_cred(current);
 	if (!new) {
@@ -26,8 +26,8 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 		goto error;
 	}
 
-	if (cache->secctx) {
-		ret = set_security_override_from_ctx(new, cache->secctx);
+	if (cache->have_secid) {
+		ret = set_security_override(new, cache->secid);
 		if (ret < 0) {
 			put_cred(new);
 			pr_err("Security denies permission to nominate security context: error %d\n",
diff --git a/fs/file.c b/fs/file.c
index eb093e736972..4cb952541dd0 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
 #include <net/sock.h>
+#include <linux/init_task.h>
 
 #include "internal.h"
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index eeac99765f0d..cf13b5cc1084 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -419,11 +419,13 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto bail_no_root;
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
-		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
+		if (fd.entrylength != sizeof(rec.dir)) {
 			res =  -EIO;
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 25d1ede6bb0e..1bad460275eb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
 				start_byte, end_byte, iomap, punch);
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index e70eb4ea21c0..a44132c98653 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -249,16 +249,17 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 
 	/* Deal with the trickiest case: that this subreq is in the middle of a
 	 * folio, not touching either edge, but finishes first.  In such a
-	 * case, we donate to the previous subreq, if there is one, so that the
-	 * donation is only handled when that completes - and remove this
-	 * subreq from the list.
+	 * case, we donate to the previous subreq, if there is one and if it is
+	 * contiguous, so that the donation is only handled when that completes
+	 * - and remove this subreq from the list.
 	 *
 	 * If the previous subreq finished first, we will have acquired their
 	 * donation and should be able to unlock folios and/or donate nextwards.
 	 */
 	if (!subreq->consumed &&
 	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
+	    subreq->start == prev->start + prev->len) {
 		prev = list_prev_entry(subreq, rreq_link);
 		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
 		subreq->start += subreq->len;
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b4521b096058..387a7a176ad8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -404,6 +404,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			if (!iov_iter_count(iter))
 				return acc;
 		}
+
+		cond_resched();
 	}
 
 	return acc;
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 85925ec0051a..3310d1ad4d0e 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -179,8 +179,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
  */
 static const char *qnx6_checkroot(struct super_block *s)
 {
-	static char match_root[2][3] = {".\0\0", "..\0"};
-	int i, error = 0;
+	int error = 0;
 	struct qnx6_dir_entry *dir_entry;
 	struct inode *root = d_inode(s->s_root);
 	struct address_space *mapping = root->i_mapping;
@@ -189,11 +188,9 @@ static const char *qnx6_checkroot(struct super_block *s)
 	if (IS_ERR(folio))
 		return "error reading root directory";
 	dir_entry = kmap_local_folio(folio, 0);
-	for (i = 0; i < 2; i++) {
-		/* maximum 3 bytes - due to match_root limitation */
-		if (strncmp(dir_entry[i].de_fname, match_root[i], 3))
-			error = 1;
-	}
+	if (memcmp(dir_entry[0].de_fname, ".", 2) ||
+	    memcmp(dir_entry[1].de_fname, "..", 3))
+		error = 1;
 	folio_release_kmap(folio, dir_entry);
 	if (error)
 		return "error reading root directory.";
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index fe40152b915d..fb51cdf55206 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1044,6 +1044,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	/* Release netns reference for this server. */
 	put_net(cifs_net_ns(server));
 	kfree(server->leaf_fullpath);
+	kfree(server->hostname);
 	kfree(server);
 
 	length = atomic_dec_return(&tcpSesAllocCount);
@@ -1670,8 +1671,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	kfree_sensitive(server->session_key.response);
 	server->session_key.response = NULL;
 	server->session_key.len = 0;
-	kfree(server->hostname);
-	server->hostname = NULL;
 
 	task = xchg(&server->tsk, NULL);
 	if (task)
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb615..6caaa62d2b1f 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -379,6 +379,7 @@ extern void __init hrtimers_init(void);
 extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
+int hrtimers_cpu_starting(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 int hrtimers_cpu_dying(unsigned int cpu);
 #else
diff --git a/include/linux/poll.h b/include/linux/poll.h
index d1ea4f3714a8..fc641b50f129 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -41,8 +41,16 @@ typedef struct poll_table_struct {
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	if (p && p->_qproc && wait_address)
+	if (p && p->_qproc && wait_address) {
 		p->_qproc(filp, wait_address, p);
+		/*
+		 * This memory barrier is paired in the wq_has_sleeper().
+		 * See the comment above prepare_to_wait(), we need to
+		 * ensure that subsequent tests in this thread can't be
+		 * reordered with __add_wait_queue() in _qproc() paths.
+		 */
+		smp_mb();
+	}
 }
 
 /*
diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index c9a31c567e85..2e18fef1a2e1 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -144,32 +144,32 @@ static inline int pruss_release_mem_region(struct pruss *pruss,
 static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
 				      enum pruss_pru_id pru_id, u8 *mux)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
 				      enum pruss_pru_id pru_id, u8 mux)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_gpimode(struct pruss *pruss,
 				    enum pruss_pru_id pru_id,
 				    enum pruss_gpi_mode mode)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_xfr_enable(struct pruss *pruss,
 				       enum pru_type pru_type,
-				       bool enable);
+				       bool enable)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 #endif /* CONFIG_TI_PRUSS */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index cb40f1a1d081..75342022d144 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -247,6 +247,13 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	    vma_is_shmem(vma);
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
+
+	return uffd_ctx && (uffd_ctx->features & UFFD_FEATURE_EVENT_REMAP) == 0;
+}
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 void dup_userfaultfd_fail(struct list_head *);
@@ -402,6 +409,11 @@ static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..60a5347922be 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -294,7 +294,7 @@ static inline long page_pool_unref_page(struct page *page, long nr)
 
 static inline void page_pool_ref_netmem(netmem_ref netmem)
 {
-	atomic_long_inc(&netmem_to_page(netmem)->pp_ref_count);
+	atomic_long_inc(netmem_get_pp_ref_count_ref(netmem));
 }
 
 static inline void page_pool_ref_page(struct page *page)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..d36c857dd249 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -13,6 +13,69 @@
  * Thus most bits set go first.
  */
 
+/* These define the values that are enums (the bits) */
+#define TRACE_GFP_FLAGS_GENERAL			\
+	TRACE_GFP_EM(DMA)			\
+	TRACE_GFP_EM(HIGHMEM)			\
+	TRACE_GFP_EM(DMA32)			\
+	TRACE_GFP_EM(MOVABLE)			\
+	TRACE_GFP_EM(RECLAIMABLE)		\
+	TRACE_GFP_EM(HIGH)			\
+	TRACE_GFP_EM(IO)			\
+	TRACE_GFP_EM(FS)			\
+	TRACE_GFP_EM(ZERO)			\
+	TRACE_GFP_EM(DIRECT_RECLAIM)		\
+	TRACE_GFP_EM(KSWAPD_RECLAIM)		\
+	TRACE_GFP_EM(WRITE)			\
+	TRACE_GFP_EM(NOWARN)			\
+	TRACE_GFP_EM(RETRY_MAYFAIL)		\
+	TRACE_GFP_EM(NOFAIL)			\
+	TRACE_GFP_EM(NORETRY)			\
+	TRACE_GFP_EM(MEMALLOC)			\
+	TRACE_GFP_EM(COMP)			\
+	TRACE_GFP_EM(NOMEMALLOC)		\
+	TRACE_GFP_EM(HARDWALL)			\
+	TRACE_GFP_EM(THISNODE)			\
+	TRACE_GFP_EM(ACCOUNT)			\
+	TRACE_GFP_EM(ZEROTAGS)
+
+#ifdef CONFIG_KASAN_HW_TAGS
+# define TRACE_GFP_FLAGS_KASAN			\
+	TRACE_GFP_EM(SKIP_ZERO)			\
+	TRACE_GFP_EM(SKIP_KASAN)
+#else
+# define TRACE_GFP_FLAGS_KASAN
+#endif
+
+#ifdef CONFIG_LOCKDEP
+# define TRACE_GFP_FLAGS_LOCKDEP		\
+	TRACE_GFP_EM(NOLOCKDEP)
+#else
+# define TRACE_GFP_FLAGS_LOCKDEP
+#endif
+
+#ifdef CONFIG_SLAB_OBJ_EXT
+# define TRACE_GFP_FLAGS_SLAB			\
+	TRACE_GFP_EM(NO_OBJ_EXT)
+#else
+# define TRACE_GFP_FLAGS_SLAB
+#endif
+
+#define TRACE_GFP_FLAGS				\
+	TRACE_GFP_FLAGS_GENERAL			\
+	TRACE_GFP_FLAGS_KASAN			\
+	TRACE_GFP_FLAGS_LOCKDEP			\
+	TRACE_GFP_FLAGS_SLAB
+
+#undef TRACE_GFP_EM
+#define TRACE_GFP_EM(a) TRACE_DEFINE_ENUM(___GFP_##a##_BIT);
+
+TRACE_GFP_FLAGS
+
+/* Just in case these are ever used */
+TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);
+TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
+
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
 
 #define __def_gfpflag_names			\
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52a3e00..9ee6c9145b1d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2179,7 +2179,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	},
 	[CPUHP_AP_HRTIMERS_DYING] = {
 		.name			= "hrtimers:dying",
-		.startup.single		= NULL,
+		.startup.single		= hrtimers_cpu_starting,
 		.teardown.single	= hrtimers_cpu_dying,
 	},
 	[CPUHP_AP_TICK_DYING] = {
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 383fd43ac612..7e1340da5aca 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -89,6 +89,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=".__afs*" --exclude=".nfs*" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f928a67a07d2..4c4681cb9337 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2630,6 +2630,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	bool prev_on_rq = prev->scx.flags & SCX_TASK_QUEUED;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 
 	lockdep_assert_rq_held(rq);
@@ -2662,8 +2663,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * bypassing test.
 		 */
-		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-		    prev->scx.slice && !scx_rq_bypassing(rq)) {
+		if (prev_on_rq && prev->scx.slice && !scx_rq_bypassing(rq)) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
 		}
@@ -2696,6 +2696,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 
 		flush_dispatch_buf(rq);
 
+		if (prev_on_rq && prev->scx.slice) {
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			goto has_tasks;
+		}
 		if (rq->scx.local_dsq.nr)
 			goto has_tasks;
 		if (consume_global_dsq(rq))
@@ -2721,8 +2725,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	 * Didn't find another task to run. Keep running @prev unless
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
-	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!static_branch_unlikely(&scx_ops_enq_last) ||
+	if (prev_on_rq && (!static_branch_unlikely(&scx_ops_enq_last) ||
 	     scx_rq_bypassing(rq))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		goto has_tasks;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ca96c99872f..60be5f8bbe71 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4065,7 +4065,11 @@ static void update_cfs_group(struct sched_entity *se)
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
 	long shares;
 
-	if (!gcfs_rq)
+	/*
+	 * When a group becomes empty, preserve its weight. This matters for
+	 * DELAY_DEQUEUE.
+	 */
+	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
 
 	if (throttled_hierarchy(gcfs_rq))
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cddcd08ea827..ee20f5032a03 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2156,6 +2156,15 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	}
 
 	cpu_base->cpu = cpu;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
+	return 0;
+}
+
+int hrtimers_cpu_starting(unsigned int cpu)
+{
+	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
+
+	/* Clear out any left over state from a CPU down operation */
 	cpu_base->active_bases = 0;
 	cpu_base->hres_active = 0;
 	cpu_base->hang_detected = 0;
@@ -2164,7 +2173,6 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
 	cpu_base->online = 1;
-	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 
@@ -2240,6 +2248,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 void __init hrtimers_init(void)
 {
 	hrtimers_prepare_cpu(smp_processor_id());
+	hrtimers_cpu_starting(smp_processor_id());
 	open_softirq(HRTIMER_SOFTIRQ, hrtimer_run_softirq);
 }
 
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8d57f7686bb0..371a62a749aa 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -534,8 +534,13 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 			break;
 
 		child = group;
-		group = group->parent;
+		/*
+		 * Pairs with the store release on group connection
+		 * to make sure group initialization is visible.
+		 */
+		group = READ_ONCE(group->parent);
 		data->childmask = child->groupmask;
+		WARN_ON_ONCE(!data->childmask);
 	} while (group);
 }
 
@@ -1487,6 +1492,21 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	s.seq = 0;
 	atomic_set(&group->migr_state, s.state);
 
+	/*
+	 * If this is a new top-level, prepare its groupmask in advance.
+	 * This avoids accidents where yet another new top-level is
+	 * created in the future and made visible before the current groupmask.
+	 */
+	if (list_empty(&tmigr_level_list[lvl])) {
+		group->groupmask = BIT(0);
+		/*
+		 * The previous top level has prepared its groupmask already,
+		 * simply account it as the first child.
+		 */
+		if (lvl > 0)
+			group->num_children = 1;
+	}
+
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires = KTIME_MAX;
@@ -1550,8 +1570,25 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_lock_irq(&child->lock);
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
 
-	child->parent = parent;
-	child->groupmask = BIT(parent->num_children++);
+	if (activate) {
+		/*
+		 * @child is the old top and @parent the new one. In this
+		 * case groupmask is pre-initialized and @child already
+		 * accounted, along with its new sibling corresponding to the
+		 * CPU going up.
+		 */
+		WARN_ON_ONCE(child->groupmask != BIT(0) || parent->num_children != 2);
+	} else {
+		/* Adding @child for the CPU going up to @parent. */
+		child->groupmask = BIT(parent->num_children++);
+	}
+
+	/*
+	 * Make sure parent initialization is visible before publishing it to a
+	 * racing CPU entering/exiting idle. This RELEASE barrier enforces an
+	 * address dependency that pairs with the READ_ONCE() in __walk_groups().
+	 */
+	smp_store_release(&child->parent, parent);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
diff --git a/mm/filemap.c b/mm/filemap.c
index 56fa431c52af..dc83baab85a1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3004,7 +3004,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		if (ops->is_partially_uptodate(folio, offset, bsz) ==
 							seek_data)
 			break;
-		start = (start + bsz) & ~(bsz - 1);
+		start = (start + bsz) & ~((u64)bsz - 1);
 		offset += bsz;
 	} while (offset < folio_size(folio));
 unlock:
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7e0f72cd9fd4..f127b61f04a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2132,6 +2132,16 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 	return pmd;
 }
 
+static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
+{
+	if (pmd_present(pmd))
+		pmd = pmd_clear_uffd_wp(pmd);
+	else if (is_swap_pmd(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+
+	return pmd;
+}
+
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
@@ -2170,6 +2180,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		pmd = move_soft_dirty_pmd(pmd);
+		if (vma_has_uffd_without_event_remap(vma))
+			pmd = clear_uffd_wp_pmd(pmd);
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
 		if (force_flush)
 			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2fa87b9ecec6..4a8a4f3535ca 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5395,6 +5395,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
 			  unsigned long sz)
 {
+	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -5411,7 +5412,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
-	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
+
+	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+		huge_pte_clear(mm, new_addr, dst_pte, sz);
+	else {
+		if (need_clear_uffd_wp) {
+			if (pte_present(pte))
+				pte = huge_pte_clear_uffd_wp(pte);
+			else if (is_swap_pte(pte))
+				pte = pte_swp_clear_uffd_wp(pte);
+		}
+		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
+	}
 
 	if (src_ptl != dst_ptl)
 		spin_unlock(src_ptl);
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 74f5f4c51ab8..5f878ee05ff8 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1071,7 +1071,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
 
 	if (kmemleak_enabled && ptr && !IS_ERR_PCPU(ptr))
-		create_object_percpu((__force unsigned long)ptr, size, 0, gfp);
+		create_object_percpu((__force unsigned long)ptr, size, 1, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
diff --git a/mm/mremap.c b/mm/mremap.c
index dee98ff2bbd6..1b2edd65c2a1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -138,6 +138,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		struct vm_area_struct *new_vma, pmd_t *new_pmd,
 		unsigned long new_addr, bool need_rmap_locks)
 {
+	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	spinlock_t *old_ptl, *new_ptl;
@@ -207,7 +208,18 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 			force_flush = true;
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
-		set_pte_at(mm, new_addr, new_pte, pte);
+
+		if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+			pte_clear(mm, new_addr, new_pte);
+		else {
+			if (need_clear_uffd_wp) {
+				if (pte_present(pte))
+					pte = pte_clear_uffd_wp(pte);
+				else if (is_swap_pte(pte))
+					pte = pte_swp_clear_uffd_wp(pte);
+			}
+			set_pte_at(mm, new_addr, new_pte, pte);
+		}
 	}
 
 	arch_leave_lazy_mmu_mode();
@@ -269,6 +281,15 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
 		return false;
 
+	/* If this pmd belongs to a uffd vma with remap events disabled, we need
+	 * to ensure that the uffd-wp state is cleared from all pgtables. This
+	 * means recursing into lower page tables in move_page_tables(), and we
+	 * can reuse the existing code if we simply treat the entry as "not
+	 * moved".
+	 */
+	if (vma_has_uffd_without_event_remap(vma))
+		return false;
+
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
@@ -324,6 +345,15 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
 		return false;
 
+	/* If this pud belongs to a uffd vma with remap events disabled, we need
+	 * to ensure that the uffd-wp state is cleared from all pgtables. This
+	 * means recursing into lower page tables in move_page_tables(), and we
+	 * can reuse the existing code if we simply treat the entry as "not
+	 * moved".
+	 */
+	if (vma_has_uffd_without_event_remap(vma))
+		return false;
+
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 67a680e4b484..d81d66790744 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4637,6 +4637,9 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		reset_batch_size(walk);
 	}
 
+	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
+					stat.nr_demoted);
+
 	item = PGSTEAL_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, reclaimed);
diff --git a/net/core/filter.c b/net/core/filter.c
index 54a53fae9e98..46da488ff070 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11263,6 +11263,7 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 	bool is_sockarray = map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
 	struct sock_reuseport *reuse;
 	struct sock *selected_sk;
+	int err;
 
 	selected_sk = map->ops->map_lookup_elem(map, key);
 	if (!selected_sk)
@@ -11270,10 +11271,6 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 
 	reuse = rcu_dereference(selected_sk->sk_reuseport_cb);
 	if (!reuse) {
-		/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
-		if (sk_is_refcounted(selected_sk))
-			sock_put(selected_sk);
-
 		/* reuseport_array has only sk with non NULL sk_reuseport_cb.
 		 * The only (!reuse) case here is - the sk has already been
 		 * unhashed (e.g. by close()), so treat it as -ENOENT.
@@ -11281,24 +11278,33 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 		 * Other maps (e.g. sock_map) do not provide this guarantee and
 		 * the sk may never be in the reuseport group to begin with.
 		 */
-		return is_sockarray ? -ENOENT : -EINVAL;
+		err = is_sockarray ? -ENOENT : -EINVAL;
+		goto error;
 	}
 
 	if (unlikely(reuse->reuseport_id != reuse_kern->reuseport_id)) {
 		struct sock *sk = reuse_kern->sk;
 
-		if (sk->sk_protocol != selected_sk->sk_protocol)
-			return -EPROTOTYPE;
-		else if (sk->sk_family != selected_sk->sk_family)
-			return -EAFNOSUPPORT;
-
-		/* Catch all. Likely bound to a different sockaddr. */
-		return -EBADFD;
+		if (sk->sk_protocol != selected_sk->sk_protocol) {
+			err = -EPROTOTYPE;
+		} else if (sk->sk_family != selected_sk->sk_family) {
+			err = -EAFNOSUPPORT;
+		} else {
+			/* Catch all. Likely bound to a different sockaddr. */
+			err = -EBADFD;
+		}
+		goto error;
 	}
 
 	reuse_kern->selected_sk = selected_sk;
 
 	return 0;
+error:
+	/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
+	if (sk_is_refcounted(selected_sk))
+		sock_put(selected_sk);
+
+	return err;
 }
 
 static const struct bpf_func_proto sk_select_reuseport_proto = {
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index b28424ae06d5..8614988fc67b 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -178,6 +178,16 @@ static const struct genl_multicast_group netdev_nl_mcgrps[] = {
 	[NETDEV_NLGRP_PAGE_POOL] = { "page-pool", },
 };
 
+static void __netdev_nl_sock_priv_init(void *priv)
+{
+	netdev_nl_sock_priv_init(priv);
+}
+
+static void __netdev_nl_sock_priv_destroy(void *priv)
+{
+	netdev_nl_sock_priv_destroy(priv);
+}
+
 struct genl_family netdev_nl_family __ro_after_init = {
 	.name		= NETDEV_FAMILY_NAME,
 	.version	= NETDEV_FAMILY_VERSION,
@@ -189,6 +199,6 @@ struct genl_family netdev_nl_family __ro_after_init = {
 	.mcgrps		= netdev_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(netdev_nl_mcgrps),
 	.sock_priv_size	= sizeof(struct list_head),
-	.sock_priv_init	= (void *)netdev_nl_sock_priv_init,
-	.sock_priv_destroy = (void *)netdev_nl_sock_priv_destroy,
+	.sock_priv_init	= __netdev_nl_sock_priv_init,
+	.sock_priv_destroy = __netdev_nl_sock_priv_destroy,
 };
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..b6db4910359b 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -851,6 +851,9 @@ static ssize_t get_imix_entries(const char __user *buffer,
 		unsigned long weight;
 		unsigned long size;
 
+		if (pkt_dev->n_imix_entries >= MAX_IMIX_ENTRIES)
+			return -E2BIG;
+
 		len = num_arg(&buffer[i], max_digits, &size);
 		if (len < 0)
 			return len;
@@ -880,9 +883,6 @@ static ssize_t get_imix_entries(const char __user *buffer,
 
 		i++;
 		pkt_dev->n_imix_entries++;
-
-		if (pkt_dev->n_imix_entries > MAX_IMIX_ENTRIES)
-			return -E2BIG;
 	} while (c == ' ');
 
 	return i;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..9e4631fade90 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -684,6 +684,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
+	if (list_empty(&sdata->local->interfaces)) {
+		mutex_unlock(&sdata->local->iflist_mtx);
+		return;
+	}
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a62bc874bf1e..123f3f297284 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -607,7 +607,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
@@ -1288,7 +1287,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 		}
-		return;
+		goto update_wspace;
 	}
 
 	if (rcv_wnd_new != rcv_wnd_old) {
@@ -1313,6 +1312,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		th->window = htons(new_win);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
+
+update_wspace:
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a93e661ef5c4..73526f1d768f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -760,10 +760,15 @@ static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 
 static inline bool mptcp_epollin_ready(const struct sock *sk)
 {
+	u64 data_avail = mptcp_data_avail(mptcp_sk(sk));
+
+	if (!data_avail)
+		return false;
+
 	/* mptcp doesn't have to deal with small skbs in the receive queue,
-	 * at it can always coalesce them
+	 * as it can always coalesce them
 	 */
-	return (mptcp_data_avail(mptcp_sk(sk)) >= sk->sk_rcvlowat) ||
+	return (data_avail >= sk->sk_rcvlowat) ||
 	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
 		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
 	       READ_ONCE(tcp_memory_pressure);
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ef0f8f73826f..4e0842df5234 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -289,6 +289,7 @@ enum {
 	ncsi_dev_state_config_sp	= 0x0301,
 	ncsi_dev_state_config_cis,
 	ncsi_dev_state_config_oem_gma,
+	ncsi_dev_state_config_apply_mac,
 	ncsi_dev_state_config_clear_vids,
 	ncsi_dev_state_config_svf,
 	ncsi_dev_state_config_ev,
@@ -322,6 +323,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_RESHUFFLE	4
 #define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
+	struct sockaddr     pending_mac;     /* MAC address received from GMA */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5cf55bde366d..bf276eaf9330 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1038,7 +1038,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
-		nd->state = ncsi_dev_state_config_clear_vids;
+		nd->state = ncsi_dev_state_config_apply_mac;
 
 		nca.package = np->id;
 		nca.channel = nc->id;
@@ -1050,10 +1050,22 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_OEM;
 			ret = ncsi_gma_handler(&nca, nc->version.mf_id);
 		}
-		if (ret < 0)
+		if (ret < 0) {
+			nd->state = ncsi_dev_state_config_clear_vids;
 			schedule_work(&ndp->work);
+		}
 
 		break;
+	case ncsi_dev_state_config_apply_mac:
+		rtnl_lock();
+		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
+		rtnl_unlock();
+		if (ret < 0)
+			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
+
+		nd->state = ncsi_dev_state_config_clear_vids;
+
+		fallthrough;
 	case ncsi_dev_state_config_clear_vids:
 	case ncsi_dev_state_config_svf:
 	case ncsi_dev_state_config_ev:
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c..14bd66909ca4 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -628,16 +628,14 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
-	int ret = 0;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
 
-	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
 		mac_addr_off = BCM_MAC_ADDR_OFFSET;
@@ -646,22 +644,17 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
-	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	saddr->sa_family = ndev->type;
+	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		eth_addr_inc((u8 *)saddr->sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
 		return -ENXIO;
 
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	rtnl_lock();
-	ret = dev_set_mac_address(ndev, &saddr, NULL);
-	rtnl_unlock();
-	if (ret < 0)
-		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
+	return 0;
 }
 
 /* Response handler for Mellanox card */
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 16e260014684..704c858cf209 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -934,7 +934,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport && netif_carrier_ok(vport->dev))) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index b52b798aa4c2..15724f171b0f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		vsk->transport->release(vsk);
 		vsock_deassign_transport(vsk);
+
+		/* transport's release() and destruct() can touch some socket
+		 * state, since we are reassigning the socket to a new transport
+		 * during vsock_connect(), let's reset these fields to have a
+		 * clean state.
+		 */
+		sock_reset_flag(sk, SOCK_DONE);
+		sk->sk_state = TCP_CLOSE;
+		vsk->peer_shutdown = 0;
 	}
 
 	/* We increase the module refcnt to prevent the transport unloading
@@ -870,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
@@ -878,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
 {
 	struct sock *sk = sk_vsock(vsk);
 
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	if (sk->sk_type == SOCK_SEQPACKET)
 		return vsk->transport->seqpacket_has_data(vsk);
 	else
@@ -887,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
 
 s64 vsock_stream_has_space(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_space(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..7f7de6d88096 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,9 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
+	virtio_transport_cancel_close_work(vsk, true);
+
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 	}
 }
 
-static void virtio_transport_do_close(struct vsock_sock *vsk,
-				      bool cancel_timeout)
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout)
 {
 	struct sock *sk = sk_vsock(vsk);
 
-	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
-	if (vsock_stream_has_data(vsk) <= 0)
-		sk->sk_state = TCP_CLOSING;
-	sk->sk_state_change(sk);
-
 	if (vsk->close_work_scheduled &&
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	}
 }
 
+static void virtio_transport_do_close(struct vsock_sock *vsk,
+				      bool cancel_timeout)
+{
+	struct sock *sk = sk_vsock(vsk);
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	if (vsock_stream_has_data(vsk) <= 0)
+		sk->sk_state = TCP_CLOSING;
+	sk->sk_state_change(sk);
+
+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
+}
+
 static void virtio_transport_close_timeout(struct work_struct *work)
 {
 	struct vsock_sock *vsk =
@@ -1628,8 +1641,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 4aa6e74ec295..f201d9eca1df 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -77,6 +77,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 			     size_t len, int flags, int *addr_len)
 {
 	struct sk_psock *psock;
+	struct vsock_sock *vsk;
 	int copied;
 
 	psock = sk_psock_get(sk);
@@ -84,6 +85,13 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		return __vsock_recvmsg(sk, msg, len, flags);
 
 	lock_sock(sk);
+	vsk = vsock_sk(sk);
+
+	if (!vsk->transport) {
+		copied = -ENODEV;
+		goto out;
+	}
+
 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
 		release_sock(sk);
 		sk_psock_put(sk, psock);
@@ -108,6 +116,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	}
 
+out:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 14df15e35695..105706abf281 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -626,6 +626,7 @@ struct aa_profile *aa_alloc_null(struct aa_profile *parent, const char *name,
 
 	/* TODO: ideally we should inherit abi from parent */
 	profile->label.flags |= FLAG_NULL;
+	profile->attach.xmatch = aa_get_pdb(nullpdb);
 	rules = list_first_entry(&profile->rules, typeof(*rules), list);
 	rules->file = aa_get_pdb(nullpdb);
 	rules->policy = aa_get_pdb(nullpdb);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3ed82f98e2de..a9f6138b59b0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10625,6 +10625,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e1f, "ASUS Vivobook 15 X1504VAP", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
+	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1eb3, "ASUS Ally RCLA72", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1ed3, "ASUS HN7306W", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10979,6 +10981,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 717530bc9c52..463f1394ab97 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2361,6 +2361,17 @@ def print_kernel_family_struct_src(family, cw):
     if not kernel_can_gen_family_struct(family):
         return
 
+    if 'sock-priv' in family.kernel_family:
+        # Generate "trampolines" to make CFI happy
+        cw.write_func("static void", f"__{family.c_name}_nl_sock_priv_init",
+                      [f"{family.c_name}_nl_sock_priv_init(priv);"],
+                      ["void *priv"])
+        cw.nl()
+        cw.write_func("static void", f"__{family.c_name}_nl_sock_priv_destroy",
+                      [f"{family.c_name}_nl_sock_priv_destroy(priv);"],
+                      ["void *priv"])
+        cw.nl()
+
     cw.block_start(f"struct genl_family {family.ident_name}_nl_family __ro_after_init =")
     cw.p('.name\t\t= ' + family.fam_key + ',')
     cw.p('.version\t= ' + family.ver_key + ',')
@@ -2378,9 +2389,8 @@ def print_kernel_family_struct_src(family, cw):
         cw.p(f'.n_mcgrps\t= ARRAY_SIZE({family.c_name}_nl_mcgrps),')
     if 'sock-priv' in family.kernel_family:
         cw.p(f'.sock_priv_size\t= sizeof({family.kernel_family["sock-priv"]}),')
-        # Force cast here, actual helpers take pointer to the real type.
-        cw.p(f'.sock_priv_init\t= (void *){family.c_name}_nl_sock_priv_init,')
-        cw.p(f'.sock_priv_destroy = (void *){family.c_name}_nl_sock_priv_destroy,')
+        cw.p(f'.sock_priv_init\t= __{family.c_name}_nl_sock_priv_init,')
+        cw.p(f'.sock_priv_destroy = __{family.c_name}_nl_sock_priv_destroy,')
     cw.block_end(';')
 
 
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 32c6ccc2a6be..1238e1c5aae1 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -758,7 +758,7 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
 	}
 
 	/* Populate a base page. */
-	memset(mem, 0, pagesize);
+	memset(mem, 1, pagesize);
 
 	if (swapout) {
 		madvise(mem, pagesize, MADV_PAGEOUT);
@@ -824,12 +824,12 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 	 * Try to populate a THP. Touch the first sub-page and test if
 	 * we get the last sub-page populated automatically.
 	 */
-	mem[0] = 0;
+	mem[0] = 1;
 	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
 		ksft_test_result_skip("Did not get a THP populated\n");
 		goto munmap;
 	}
-	memset(mem, 0, thpsize);
+	memset(mem, 1, thpsize);
 
 	size = thpsize;
 	switch (thp_run) {
@@ -1012,7 +1012,7 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
 	}
 
 	/* Populate an huge page. */
-	memset(mem, 0, hugetlbsize);
+	memset(mem, 1, hugetlbsize);
 
 	/*
 	 * We need a total of two hugetlb pages to handle COW/unsharing
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4209b9569039..414addef9a45 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -25,6 +25,8 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 
+#include <arpa/inet.h>
+
 #include <netdb.h>
 #include <netinet/in.h>
 
@@ -1211,23 +1213,42 @@ static void parse_setsock_options(const char *name)
 	exit(1);
 }
 
-void xdisconnect(int fd, int addrlen)
+void xdisconnect(int fd)
 {
-	struct sockaddr_storage empty;
+	socklen_t addrlen = sizeof(struct sockaddr_storage);
+	struct sockaddr_storage addr, empty;
 	int msec_sleep = 10;
-	int queued = 1;
-	int i;
+	void *raw_addr;
+	int i, cmdlen;
+	char cmd[128];
+
+	/* get the local address and convert it to string */
+	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0)
+		xerror("getsockname");
+
+	if (addr.ss_family == AF_INET)
+		raw_addr = &(((struct sockaddr_in *)&addr)->sin_addr);
+	else if (addr.ss_family == AF_INET6)
+		raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
+	else
+		xerror("bad family");
+
+	strcpy(cmd, "ss -M | grep -q ");
+	cmdlen = strlen(cmd);
+	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
+		       sizeof(cmd) - cmdlen))
+		xerror("inet_ntop");
 
 	shutdown(fd, SHUT_WR);
 
-	/* while until the pending data is completely flushed, the later
+	/*
+	 * wait until the pending data is completely flushed and all
+	 * the MPTCP sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {
-		if (ioctl(fd, SIOCOUTQ, &queued) < 0)
-			xerror("can't query out socket queue: %d", errno);
-
-		if (!queued)
+		/* closed socket are not listed by 'ss' */
+		if (system(cmd) != 0)
 			break;
 
 		if (i > poll_timeout)
@@ -1281,9 +1302,9 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 	} else if (--cfg_repeat > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
 		 * connect to be blocking
diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
index 37d9bf6fb745..6f4c3f5a1c5d 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct task_struct *p,
 		 * If we dispatch to a bogus DSQ that will fall back to the
 		 * builtin global DSQ, we fail gracefully.
 		 */
-		scx_bpf_dispatch_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
+		scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
 				       p->scx.dsq_vtime, 0);
 		return cpu;
 	}
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
index dffc97d9cdf1..e4a55027778f 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -17,8 +17,8 @@ s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struct task_struct *p,
 
 	if (cpu >= 0) {
 		/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
-		scx_bpf_dispatch_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
-				       p->scx.dsq_vtime, 0);
+		scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+					 p->scx.dsq_vtime, 0);
 		return cpu;
 	}
 
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index 6a7db1502c29..fbda6bf54671 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -43,9 +43,12 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 	if (!p)
 		return;
 
-	target = bpf_get_prandom_u32() % nr_cpus;
+	if (p->nr_cpus_allowed == nr_cpus)
+		target = bpf_get_prandom_u32() % nr_cpus;
+	else
+		target = scx_bpf_task_cpu(p);
 
-	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
 	bpf_task_release(p);
 }
 
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.c b/tools/testing/selftests/sched_ext/dsp_local_on.c
index 472851b56854..0ff27e57fe43 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.c
@@ -34,9 +34,10 @@ static enum scx_test_status run(void *ctx)
 	/* Just sleeping is fine, plenty of scheduling events happening */
 	sleep(1);
 
-	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
 	bpf_link__destroy(link);
 
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
 	return SCX_TEST_PASS;
 }
 
@@ -50,7 +51,7 @@ static void cleanup(void *ctx)
 struct scx_test dsp_local_on = {
 	.name = "dsp_local_on",
 	.description = "Verify we can directly dispatch tasks to a local DSQs "
-		       "from osp.dispatch()",
+		       "from ops.dispatch()",
 	.setup = setup,
 	.run = run,
 	.cleanup = cleanup,
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index 1efb50d61040..a7cf868d5e31 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -31,7 +31,7 @@ void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 	/* Can only call from ops.select_cpu() */
 	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
 
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index d75d4faf07f6..4bc36182d3ff 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -33,7 +33,7 @@ void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
 	if (exit_point == EXIT_ENQUEUE)
 		EXIT_CLEANLY();
 
-	scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
@@ -41,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
 	if (exit_point == EXIT_DISPATCH)
 		EXIT_CLEANLY();
 
-	scx_bpf_consume(DSQ_ID);
+	scx_bpf_dsq_move_to_local(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 4d4cd8d966db..430f5e13bf55 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -12,6 +12,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+#define DSQ_ID 0
+
 s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 		   u64 wake_flags)
 {
@@ -20,7 +22,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 
 void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
@@ -28,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
 
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_consume(SCX_DSQ_GLOBAL);
+	scx_bpf_dsq_move_to_local(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
@@ -123,7 +125,7 @@ void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
 {
-	return 0;
+	return scx_bpf_create_dsq(DSQ_ID, -1);
 }
 
 void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
index f171ac470970..13d0f5be788d 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
@@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_struct *p,
 	}
 	scx_bpf_put_idle_cpumask(idle_mask);
 
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 9efdbb7da928..815f1d5d61ac 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -67,7 +67,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
 		saw_local = true;
 	}
 
-	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, enq_flags);
 }
 
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
index 59bfc4f36167..4bb99699e920 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
@@ -29,7 +29,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct task_struct *p,
 	cpu = prev_cpu;
 
 dispatch:
-	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, 0);
 	return cpu;
 }
 
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
index 3bbd5fcdfb18..2a75de11b2cf 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
@@ -18,7 +18,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_select_cpu, struct task_struct *p
 		   s32 prev_cpu, u64 wake_flags)
 {
 	/* Dispatching to a random DSQ should fail. */
-	scx_bpf_dispatch(p, 0xcafef00d, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, 0xcafef00d, SCX_SLICE_DFL, 0);
 
 	return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
index 0fda57fe0ecf..99d075695c97 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
@@ -18,8 +18,8 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_select_cpu, struct task_struct *p
 		   s32 prev_cpu, u64 wake_flags)
 {
 	/* Dispatching twice in a row is disallowed. */
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
 
 	return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index e6c67bcf5e6e..bfcb96cd4954 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -2,8 +2,8 @@
 /*
  * A scheduler that validates that enqueue flags are properly stored and
  * applied at dispatch time when a task is directly dispatched from
- * ops.select_cpu(). We validate this by using scx_bpf_dispatch_vtime(), and
- * making the test a very basic vtime scheduler.
+ * ops.select_cpu(). We validate this by using scx_bpf_dsq_insert_vtime(),
+ * and making the test a very basic vtime scheduler.
  *
  * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2024 David Vernet <dvernet@meta.com>
@@ -47,13 +47,13 @@ s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct task_struct *p,
 	cpu = prev_cpu;
 	scx_bpf_test_and_clear_cpu_idle(cpu);
 ddsp:
-	scx_bpf_dispatch_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
+	scx_bpf_dsq_insert_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
 	return cpu;
 }
 
 void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct *p)
 {
-	if (scx_bpf_consume(VTIME_DSQ))
+	if (scx_bpf_dsq_move_to_local(VTIME_DSQ))
 		consumed = true;
 }
 
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f644..383fbda07245 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -78,10 +78,10 @@
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0xff",
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0x1f",
         "expExitCode": "0",
         "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 protocol ip prio 1 flow",
-        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 255 baseclass",
+        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 31 baseclass",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
diff --git a/tools/testing/shared/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
index 06c89bdcc515..f67d47d32857 100644
--- a/tools/testing/shared/linux/maple_tree.h
+++ b/tools/testing/shared/linux/maple_tree.h
@@ -2,6 +2,6 @@
 #define atomic_t int32_t
 #define atomic_inc(x) uatomic_inc(x)
 #define atomic_read(x) uatomic_read(x)
-#define atomic_set(x, y) do {} while (0)
+#define atomic_set(x, y) uatomic_set(x, y)
 #define U8_MAX UCHAR_MAX
 #include "../../../../include/linux/maple_tree.h"
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
index e01f66f98982..3e1b6adc027b 100644
--- a/tools/testing/vma/linux/atomic.h
+++ b/tools/testing/vma/linux/atomic.h
@@ -6,7 +6,7 @@
 #define atomic_t int32_t
 #define atomic_inc(x) uatomic_inc(x)
 #define atomic_read(x) uatomic_read(x)
-#define atomic_set(x, y) do {} while (0)
+#define atomic_set(x, y) uatomic_set(x, y)
 #define U8_MAX UCHAR_MAX
 
 #endif	/* _LINUX_ATOMIC_H */

