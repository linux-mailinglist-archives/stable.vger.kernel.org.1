Return-Path: <stable+bounces-71520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B7964B02
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDC2288F38
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB711B3749;
	Thu, 29 Aug 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYsvuuGj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67231B0120;
	Thu, 29 Aug 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947587; cv=none; b=uBVHH2FMDOOBj5gITZj1PXha5715nn2Muttkz0DKYwPVzQTPPiplEsTTX0NDKgZEW1XN7i65LlIAoY1xyDvhQAT+GFlE4avsrYk0cimOWw8Vd2Kgb+tqqa9X9lEer/MZm9sbcQs2L7J7PLAb7EJo0fnP1l8gqEZV3v2SguN+z+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947587; c=relaxed/simple;
	bh=ydQbgR5NEAWrdtFKXr/peKL8/wAmZbhCDB1rJbHD/a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4k7roxGzNd8NDuJakPXn81xwAnzytUQHASQPtEkZcWLxdbbFBCjiQU9JZ53Gu31CS76eBhWDmGfeHkXu/l9A5y0hV+8W2QdtyuGj1cYKkkVrRBG1HQ10FWM0FtC5RmBw6ia29QMcYqMgFtGd41BVKO+IOVmS7UXN16gyrfQ/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYsvuuGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F1DC4CEC2;
	Thu, 29 Aug 2024 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724947586;
	bh=ydQbgR5NEAWrdtFKXr/peKL8/wAmZbhCDB1rJbHD/a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYsvuuGjagU0q2gJKi/xVI5Fsg9a7csEvZ6EwUG3SKl+GZ2Qm5+Xe78d1zMiF3P2g
	 fzXC/hlJwePHyBpXc1E/PrTQl/xXoRx7VJBsJyBdFTiakj6SqxOAyfyyA1VQzL/M5h
	 Aa8IMOd6o1I3GLKg0uebx0bBCfMEkN5Bw3WxPT74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.107
Date: Thu, 29 Aug 2024 18:05:57 +0200
Message-ID: <2024082956-unhappily-deacon-a93b@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024082955-void-splendor-20fd@gregkh>
References: <2024082955-void-splendor-20fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
new file mode 100644
index 000000000000..b4fce3f7c98f
--- /dev/null
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=====================
+BPF_MAP_TYPE_LPM_TRIE
+=====================
+
+.. note::
+   - ``BPF_MAP_TYPE_LPM_TRIE`` was introduced in kernel version 4.11
+
+``BPF_MAP_TYPE_LPM_TRIE`` provides a longest prefix match algorithm that
+can be used to match IP addresses to a stored set of prefixes.
+Internally, data is stored in an unbalanced trie of nodes that uses
+``prefixlen,data`` pairs as its keys. The ``data`` is interpreted in
+network byte order, i.e. big endian, so ``data[0]`` stores the most
+significant byte.
+
+LPM tries may be created with a maximum prefix length that is a multiple
+of 8, in the range from 8 to 2048. The key used for lookup and update
+operations is a ``struct bpf_lpm_trie_key_u8``, extended by
+``max_prefixlen/8`` bytes.
+
+- For IPv4 addresses the data length is 4 bytes
+- For IPv6 addresses the data length is 16 bytes
+
+The value type stored in the LPM trie can be any user defined type.
+
+.. note::
+   When creating a map of type ``BPF_MAP_TYPE_LPM_TRIE`` you must set the
+   ``BPF_F_NO_PREALLOC`` flag.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+The longest prefix entry for a given data value can be found using the
+``bpf_map_lookup_elem()`` helper. This helper returns a pointer to the
+value associated with the longest matching ``key``, or ``NULL`` if no
+entry was found.
+
+The ``key`` should have ``prefixlen`` set to ``max_prefixlen`` when
+performing longest prefix lookups. For example, when searching for the
+longest prefix match for an IPv4 address, ``prefixlen`` should be set to
+``32``.
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+Prefix entries can be added or updated using the ``bpf_map_update_elem()``
+helper. This helper replaces existing elements atomically.
+
+``bpf_map_update_elem()`` returns ``0`` on success, or negative error in
+case of failure.
+
+ .. note::
+    The flags parameter must be one of BPF_ANY, BPF_NOEXIST or BPF_EXIST,
+    but the value is ignored, giving BPF_ANY semantics.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+Prefix entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case
+of failure.
+
+Userspace
+---------
+
+Access from userspace uses libbpf APIs with the same names as above, with
+the map identified by ``fd``.
+
+.. c:function::
+   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
+
+A userspace program can iterate through the entries in an LPM trie using
+libbpf's ``bpf_map_get_next_key()`` function. The first key can be
+fetched by calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
+``NULL``. Subsequent calls will fetch the next key that follows the
+current key. ``bpf_map_get_next_key()`` returns ``0`` on success,
+``-ENOENT`` if ``cur_key`` is the last key in the trie, or negative
+error in case of failure.
+
+``bpf_map_get_next_key()`` will iterate through the LPM trie elements
+from leftmost leaf first. This means that iteration will return more
+specific keys before less specific ones.
+
+Examples
+========
+
+Please see ``tools/testing/selftests/bpf/test_lpm_map.c`` for examples
+of LPM trie usage from userspace. The code snippets below demonstrate
+API usage.
+
+Kernel BPF
+----------
+
+The following BPF code snippet shows how to declare a new LPM trie for IPv4
+address prefixes:
+
+.. code-block:: c
+
+    #include <linux/bpf.h>
+    #include <bpf/bpf_helpers.h>
+
+    struct ipv4_lpm_key {
+            __u32 prefixlen;
+            __u32 data;
+    };
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_LPM_TRIE);
+            __type(key, struct ipv4_lpm_key);
+            __type(value, __u32);
+            __uint(map_flags, BPF_F_NO_PREALLOC);
+            __uint(max_entries, 255);
+    } ipv4_lpm_map SEC(".maps");
+
+The following BPF code snippet shows how to lookup by IPv4 address:
+
+.. code-block:: c
+
+    void *lookup(__u32 ipaddr)
+    {
+            struct ipv4_lpm_key key = {
+                    .prefixlen = 32,
+                    .data = ipaddr
+            };
+
+            return bpf_map_lookup_elem(&ipv4_lpm_map, &key);
+    }
+
+Userspace
+---------
+
+The following snippet shows how to insert an IPv4 prefix entry into an
+LPM trie:
+
+.. code-block:: c
+
+    int add_prefix_entry(int lpm_fd, __u32 addr, __u32 prefixlen, struct value *value)
+    {
+            struct ipv4_lpm_key ipv4_key = {
+                    .prefixlen = prefixlen,
+                    .data = addr
+            };
+            return bpf_map_update_elem(lpm_fd, &ipv4_key, value, BPF_ANY);
+    }
+
+The following snippet shows a userspace program walking through the entries
+of an LPM trie:
+
+
+.. code-block:: c
+
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    void iterate_lpm_trie(int map_fd)
+    {
+            struct ipv4_lpm_key *cur_key = NULL;
+            struct ipv4_lpm_key next_key;
+            struct value value;
+            int err;
+
+            for (;;) {
+                    err = bpf_map_get_next_key(map_fd, cur_key, &next_key);
+                    if (err)
+                            break;
+
+                    bpf_map_lookup_elem(map_fd, &next_key, &value);
+
+                    /* Use key and value here */
+
+                    cur_key = &next_key;
+            }
+    }
diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2-glocks.rst
index d14f230f0b12..93a690b9bcf2 100644
--- a/Documentation/filesystems/gfs2-glocks.rst
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -20,8 +20,7 @@ The gl_holders list contains all the queued lock requests (not
 just the holders) associated with the glock. If there are any
 held locks, then they will be contiguous entries at the head
 of the list. Locks are granted in strictly the order that they
-are queued, except for those marked LM_FLAG_PRIORITY which are
-used only during recovery, and even then only for journal locks.
+are queued.
 
 There are three lock states that users of the glock layer can request,
 namely shared (SH), deferred (DF) and exclusive (EX). Those translate
diff --git a/Makefile b/Makefile
index f0fd656e9da3..4c0fc0e5e002 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 106
+SUBLEVEL = 107
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index e51535a5f939..ccbff21ce1fa 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -27,7 +27,7 @@
 
 #include <asm/numa.h>
 
-static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
 
 int __init acpi_numa_get_nid(unsigned int cpu)
 {
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index fea3223704b6..44c4d79bd914 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -360,9 +360,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	smp_init_cpus();
 	smp_build_mpidr_hash();
 
-	/* Init percpu seeds for random tags after cpus are set up. */
-	kasan_init_sw_tags();
-
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
 	 * Make sure init_thread_info.ttbr0 always generates translation
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d323621d14a5..b606093a5596 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -464,6 +464,8 @@ void __init smp_prepare_boot_cpu(void)
 		init_gic_priority_masking();
 
 	kasan_init_hw_tags();
+	/* Init percpu seeds for random tags after cpus are set up. */
+	kasan_init_sw_tags();
 }
 
 /*
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 457e74f1f671..974b94ad7952 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -30,6 +30,7 @@
 #include <trace/events/kvm.h>
 
 #include "sys_regs.h"
+#include "vgic/vgic.h"
 
 #include "trace.h"
 
@@ -200,6 +201,11 @@ static bool access_gic_sgi(struct kvm_vcpu *vcpu,
 {
 	bool g1;
 
+	if (!kvm_has_gicv3(vcpu->kvm)) {
+		kvm_inject_undefined(vcpu);
+		return false;
+	}
+
 	if (!p->is_write)
 		return read_from_write_only(vcpu, p, r);
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 5fb0bfc07d85..bc898229167b 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -334,4 +334,11 @@ void vgic_v4_configure_vsgis(struct kvm *kvm);
 void vgic_v4_get_vlpi_state(struct vgic_irq *irq, bool *val);
 int vgic_v4_request_vpe_irq(struct kvm_vcpu *vcpu, int irq);
 
+static inline bool kvm_has_gicv3(struct kvm *kvm)
+{
+	return (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif) &&
+		irqchip_in_kernel(kvm) &&
+		kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3);
+}
+
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 482af80b8179..fdf00c228b67 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1723,12 +1723,16 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_CAM |
 			MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
+		change_c0_config6(LOONGSON_CONF6_EXTIMER | LOONGSON_CONF6_INTIMER,
+				  LOONGSON_CONF6_INTIMER);
 		break;
 	case PRID_IMP_LOONGSON_64G:
 		__cpu_name[cpu] = "ICT Loongson-3";
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
 		decode_cpucfg(c);
+		change_c0_config6(LOONGSON_CONF6_EXTIMER | LOONGSON_CONF6_INTIMER,
+				  LOONGSON_CONF6_INTIMER);
 		break;
 	default:
 		panic("Unknown Loongson Processor ID!");
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 0cd04d936a7a..f2fe45d3094d 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -270,6 +270,9 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	/* setup memblock allocator */
+	setup_memory();
+
 	unflatten_and_copy_device_tree();
 
 	setup_cpuinfo();
@@ -293,9 +296,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-	/* setup memblock allocator */
-	setup_memory();
-
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 9ddb2e397058..b481cde6bfb6 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -501,7 +501,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 
 	old_regs = set_irq_regs(regs);
 	local_irq_disable();
-	irq_enter();
+	irq_enter_rcu();
 
 	eirr_val = mfctl(23) & cpu_eiem & per_cpu(local_ack_eiem, cpu);
 	if (!eirr_val)
@@ -536,7 +536,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 #endif /* CONFIG_IRQSTACKS */
 
  out:
-	irq_exit();
+	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	return;
 
diff --git a/arch/powerpc/boot/simple_alloc.c b/arch/powerpc/boot/simple_alloc.c
index 267d6524caac..d07796fdf91a 100644
--- a/arch/powerpc/boot/simple_alloc.c
+++ b/arch/powerpc/boot/simple_alloc.c
@@ -112,8 +112,11 @@ static void *simple_realloc(void *ptr, unsigned long size)
 		return ptr;
 
 	new = simple_malloc(size);
-	memcpy(new, ptr, p->size);
-	simple_free(ptr);
+	if (new) {
+		memcpy(new, ptr, p->size);
+		simple_free(ptr);
+	}
+
 	return new;
 }
 
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index edc17b6b1cc2..9b2238d73003 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -236,6 +236,8 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	rname = kasprintf(GFP_KERNEL, "CPU %d [0x%x] Interrupt Presentation",
 			  cpu, hw_id);
 
+	if (!rname)
+		return -ENOMEM;
 	if (!request_mem_region(addr, size, rname)) {
 		pr_warn("icp_native: Could not reserve ICP MMIO for CPU %d, interrupt server #0x%x\n",
 			cpu, hw_id);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7ba5c244f3a0..ba2210b553f9 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -816,7 +816,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 				   PMD_SIZE, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
-	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
+	end_va = kernel_map.virt_addr + kernel_map.size;
 	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
 				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
@@ -947,7 +947,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
-	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
+	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index be3ef9dd6972..6abcb46a8dfe 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -387,7 +387,10 @@ static inline int share(unsigned long addr, u16 cmd)
 
 	if (!uv_call(0, (u64)&uvcb))
 		return 0;
-	return -EINVAL;
+	pr_err("%s UVC failed (rc: 0x%x, rrc: 0x%x), possible hypervisor bug.\n",
+	       uvcb.header.cmd == UVC_CMD_SET_SHARED_ACCESS ? "Share" : "Unshare",
+	       uvcb.header.rc, uvcb.header.rrc);
+	panic("System security cannot be guaranteed unless the system panics now.\n");
 }
 
 /*
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9693c8630e73..b3cb256ec669 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -237,15 +237,9 @@ static inline void save_vector_registers(void)
 #endif
 }
 
-static inline void setup_control_registers(void)
+static inline void setup_low_address_protection(void)
 {
-	unsigned long reg;
-
-	__ctl_store(reg, 0, 0);
-	reg |= CR0_LOW_ADDRESS_PROTECTION;
-	reg |= CR0_EMERGENCY_SIGNAL_SUBMASK;
-	reg |= CR0_EXTERNAL_CALL_SUBMASK;
-	__ctl_load(reg, 0, 0);
+	__ctl_set_bit(0, 28);
 }
 
 static inline void setup_access_registers(void)
@@ -304,7 +298,7 @@ void __init startup_init(void)
 	save_vector_registers();
 	setup_topology();
 	sclp_early_detect();
-	setup_control_registers();
+	setup_low_address_protection();
 	setup_access_registers();
 	lockdep_on();
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0031325ce4bc..436dbf4d743d 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1007,12 +1007,12 @@ void __init smp_fill_possible_mask(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	/* request the 0x1201 emergency signal external interrupt */
 	if (register_external_irq(EXT_IRQ_EMERGENCY_SIG, do_ext_call_interrupt))
 		panic("Couldn't request external interrupt 0x1201");
-	/* request the 0x1202 external call external interrupt */
+	ctl_set_bit(0, 14);
 	if (register_external_irq(EXT_IRQ_EXTERNAL_CALL, do_ext_call_interrupt))
 		panic("Couldn't request external interrupt 0x1202");
+	ctl_set_bit(0, 13);
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 279b5e9be80f..acc83738bf5b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -991,7 +991,10 @@ unsigned long arch_align_stack(unsigned long sp)
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-	return randomize_page(mm->brk, 0x02000000);
+	if (mmap_is_ia32())
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
 }
 
 /*
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index c90fef0258c5..3cd590ace95a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1843,8 +1843,12 @@ static bool set_target_expiration(struct kvm_lapic *apic, u32 count_reg)
 		if (unlikely(count_reg != APIC_TMICT)) {
 			deadline = tmict_to_ns(apic,
 				     kvm_lapic_get_reg(apic, count_reg));
-			if (unlikely(deadline <= 0))
-				deadline = apic->lapic_timer.period;
+			if (unlikely(deadline <= 0)) {
+				if (apic_lvtt_period(apic))
+					deadline = apic->lapic_timer.period;
+				else
+					deadline = 0;
+			}
 			else if (unlikely(deadline > apic->lapic_timer.period)) {
 				pr_info_ratelimited(
 				    "kvm: vcpu %i: requested lapic timer restore with "
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 100889c276c3..dcd620422d01 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -40,6 +40,7 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
+	unsigned long flags;
 	struct blk_mq_tags *tags = hctx->tags;
 
 	/*
@@ -58,11 +59,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	spin_lock_irq(&tags->lock);
+	spin_lock_irqsave(&tags->lock, flags);
 	users = tags->active_queues + 1;
 	WRITE_ONCE(tags->active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
-	spin_unlock_irq(&tags->lock);
+	spin_unlock_irqrestore(&tags->lock, flags);
 }
 
 /*
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 2daf50d4cd47..7810f974b2ca 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1118,8 +1118,8 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 	rpp->len += skb->len;
 
 	if (stat & SAR_RSQE_EPDU) {
+		unsigned int len, truesize;
 		unsigned char *l1l2;
-		unsigned int len;
 
 		l1l2 = (unsigned char *) ((unsigned long) skb->data + skb->len - 6);
 
@@ -1189,14 +1189,15 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 		ATM_SKB(skb)->vcc = vcc;
 		__net_timestamp(skb);
 
+		truesize = skb->truesize;
 		vcc->push(vcc, skb);
 		atomic_inc(&vcc->stats->rx);
 
-		if (skb->truesize > SAR_FB_SIZE_3)
+		if (truesize > SAR_FB_SIZE_3)
 			add_rx_skb(card, 3, SAR_FB_SIZE_3, 1);
-		else if (skb->truesize > SAR_FB_SIZE_2)
+		else if (truesize > SAR_FB_SIZE_2)
 			add_rx_skb(card, 2, SAR_FB_SIZE_2, 1);
-		else if (skb->truesize > SAR_FB_SIZE_1)
+		else if (truesize > SAR_FB_SIZE_1)
 			add_rx_skb(card, 1, SAR_FB_SIZE_1, 1);
 		else
 			add_rx_skb(card, 0, SAR_FB_SIZE_0, 1);
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 865112e96ff9..c1feebd9e3a0 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -770,7 +770,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 
 	case HCIUARTGETPROTO:
-		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
+		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			err = hu->proto->id;
 		else
 			err = -EUNATCH;
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 39bcbfd908b4..3a2a0fb3d928 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -50,6 +50,7 @@ MODULE_LICENSE("GPL v2");
 static const char xillyname[] = "xillyusb";
 
 static unsigned int fifo_buf_order;
+static struct workqueue_struct *wakeup_wq;
 
 #define USB_VENDOR_ID_XILINX		0x03fd
 #define USB_VENDOR_ID_ALTERA		0x09fb
@@ -561,10 +562,6 @@ static void cleanup_dev(struct kref *kref)
  * errors if executed. The mechanism relies on that xdev->error is assigned
  * a non-zero value by report_io_error() prior to queueing wakeup_all(),
  * which prevents bulk_in_work() from calling process_bulk_in().
- *
- * The fact that wakeup_all() and bulk_in_work() are queued on the same
- * workqueue makes their concurrent execution very unlikely, however the
- * kernel's API doesn't seem to ensure this strictly.
  */
 
 static void wakeup_all(struct work_struct *work)
@@ -619,7 +616,7 @@ static void report_io_error(struct xillyusb_dev *xdev,
 
 	if (do_once) {
 		kref_get(&xdev->kref); /* xdev is used by work item */
-		queue_work(xdev->workq, &xdev->wakeup_workitem);
+		queue_work(wakeup_wq, &xdev->wakeup_workitem);
 	}
 }
 
@@ -1892,6 +1889,13 @@ static const struct file_operations xillyusb_fops = {
 
 static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
 {
+	struct usb_device *udev = xdev->udev;
+
+	/* Verify that device has the two fundamental bulk in/out endpoints */
+	if (usb_pipe_type_check(udev, usb_sndbulkpipe(udev, MSG_EP_NUM)) ||
+	    usb_pipe_type_check(udev, usb_rcvbulkpipe(udev, IN_EP_NUM)))
+		return -ENODEV;
+
 	xdev->msg_ep = endpoint_alloc(xdev, MSG_EP_NUM | USB_DIR_OUT,
 				      bulk_out_work, 1, 2);
 	if (!xdev->msg_ep)
@@ -1921,14 +1925,15 @@ static int setup_channels(struct xillyusb_dev *xdev,
 			  __le16 *chandesc,
 			  int num_channels)
 {
-	struct xillyusb_channel *chan;
+	struct usb_device *udev = xdev->udev;
+	struct xillyusb_channel *chan, *new_channels;
 	int i;
 
 	chan = kcalloc(num_channels, sizeof(*chan), GFP_KERNEL);
 	if (!chan)
 		return -ENOMEM;
 
-	xdev->channels = chan;
+	new_channels = chan;
 
 	for (i = 0; i < num_channels; i++, chan++) {
 		unsigned int in_desc = le16_to_cpu(*chandesc++);
@@ -1957,6 +1962,15 @@ static int setup_channels(struct xillyusb_dev *xdev,
 		 */
 
 		if ((out_desc & 0x80) && i < 14) { /* Entry is valid */
+			if (usb_pipe_type_check(udev,
+						usb_sndbulkpipe(udev, i + 2))) {
+				dev_err(xdev->dev,
+					"Missing BULK OUT endpoint %d\n",
+					i + 2);
+				kfree(new_channels);
+				return -ENODEV;
+			}
+
 			chan->writable = 1;
 			chan->out_synchronous = !!(out_desc & 0x40);
 			chan->out_seekable = !!(out_desc & 0x20);
@@ -1966,6 +1980,7 @@ static int setup_channels(struct xillyusb_dev *xdev,
 		}
 	}
 
+	xdev->channels = new_channels;
 	return 0;
 }
 
@@ -2082,9 +2097,11 @@ static int xillyusb_discovery(struct usb_interface *interface)
 	 * just after responding with the IDT, there is no reason for any
 	 * work item to be running now. To be sure that xdev->channels
 	 * is updated on anything that might run in parallel, flush the
-	 * workqueue, which rarely does anything.
+	 * device's workqueue and the wakeup work item. This rarely
+	 * does anything.
 	 */
 	flush_workqueue(xdev->workq);
+	flush_work(&xdev->wakeup_workitem);
 
 	xdev->num_channels = num_channels;
 
@@ -2242,6 +2259,10 @@ static int __init xillyusb_init(void)
 {
 	int rc = 0;
 
+	wakeup_wq = alloc_workqueue(xillyname, 0, 0);
+	if (!wakeup_wq)
+		return -ENOMEM;
+
 	if (LOG2_INITIAL_FIFO_BUF_SIZE > PAGE_SHIFT)
 		fifo_buf_order = LOG2_INITIAL_FIFO_BUF_SIZE - PAGE_SHIFT;
 	else
@@ -2249,12 +2270,17 @@ static int __init xillyusb_init(void)
 
 	rc = usb_register(&xillyusb_driver);
 
+	if (rc)
+		destroy_workqueue(wakeup_wq);
+
 	return rc;
 }
 
 static void __exit xillyusb_exit(void)
 {
 	usb_deregister(&xillyusb_driver);
+
+	destroy_workqueue(wakeup_wq);
 }
 
 module_init(xillyusb_init);
diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 1f3234f22667..e9cd80e085dc 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -329,12 +329,12 @@ struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < nr_plls; ++i)
-		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	ctx->node = np;
 	ctx->reg_base = base;
 	ctx->clk_data.num = nr_plls;
 
+	for (i = 0; i < nr_plls; ++i)
+		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	return ctx;
 }
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e1c773bb5535..22a58d35a41f 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -290,18 +290,17 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 	{
-		int psv;
+		unsigned long psv;
 
-		psv = DIV_ROUND_CLOSEST(ndata->new_rate,
-					gt_target_rate);
-
-		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+		psv = DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
+		if (!psv ||
+		    abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
 			return NOTIFY_BAD;
 
 		psv--;
 
 		/* prescaler within legal range? */
-		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+		if (psv > GT_CONTROL_PRESCALER_MAX)
 			return NOTIFY_BAD;
 
 		/*
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index ee4c32669607..68005cce0136 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -490,7 +490,7 @@ void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp)
 {
 	cs_dsp_debugfs_clear(dsp);
 	debugfs_remove_recursive(dsp->debugfs_root);
-	dsp->debugfs_root = NULL;
+	dsp->debugfs_root = ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(cs_dsp_cleanup_debugfs);
 #else
@@ -2300,6 +2300,11 @@ static int cs_dsp_common_init(struct cs_dsp *dsp)
 
 	mutex_init(&dsp->pwr_lock);
 
+#ifdef CONFIG_DEBUG_FS
+	/* Ensure this is invalid if client never provides a debugfs root */
+	dsp->debugfs_root = ERR_PTR(-ENODEV);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index dbc842590b25..4b694886715c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -286,6 +286,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7d5fbaaba72f..d486f5dc052e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -719,7 +719,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
 	enum dma_data_direction dir;
 
 	if (unlikely(!ttm->sg)) {
-		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
+		pr_debug("SG Table of BO is NULL");
 		return;
 	}
 
@@ -1226,8 +1226,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	amdgpu_sync_fence(sync, bo_va->last_pt_update);
-
-	kfd_mem_dmaunmap_attachment(mem, entry);
 }
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
@@ -1282,6 +1280,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 
 update_gpuvm_pte_failed:
 	unmap_bo_from_gpuvm(mem, entry, sync);
+	kfd_mem_dmaunmap_attachment(mem, entry);
 	return ret;
 }
 
@@ -1852,8 +1851,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue));
 
 	/* Remove from VM internal data structures */
-	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
+	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
+		kfd_mem_dmaunmap_attachment(mem, entry);
 		kfd_mem_detach(entry);
+	}
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -2024,6 +2025,37 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
+int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+{
+	struct kfd_mem_attachment *entry;
+	struct amdgpu_vm *vm;
+	int ret;
+
+	vm = drm_priv_to_vm(drm_priv);
+
+	mutex_lock(&mem->lock);
+
+	ret = amdgpu_bo_reserve(mem->bo, true);
+	if (ret)
+		goto out;
+
+	list_for_each_entry(entry, &mem->attachments, list) {
+		if (entry->bo_va->base.vm != vm)
+			continue;
+		if (entry->bo_va->base.bo->tbo.ttm &&
+		    !entry->bo_va->base.bo->tbo.ttm->sg)
+			continue;
+
+		kfd_mem_dmaunmap_attachment(mem, entry);
+	}
+
+	amdgpu_bo_unreserve(mem->bo);
+out:
+	mutex_unlock(&mem->lock);
+
+	return ret;
+}
+
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 1ed2142a6e7b..3898b67c35bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -656,16 +656,24 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_CTX_OP_ALLOC_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_alloc(adev, fpriv, filp, priority, &id);
 		args->out.alloc.ctx_id = id;
 		break;
 	case AMDGPU_CTX_OP_FREE_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_free(fpriv, id);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE2:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_GET_STABLE_PSTATE:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 0988e00612e5..09a995df95e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -148,6 +148,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	if (ret)
 		return -EINVAL;
 
+	if (ta_bin_len > PSP_1_MEG)
+		return -EINVAL;
+
 	copy_pos += sizeof(uint32_t);
 
 	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 48e612023d0c..e2475f656ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -239,6 +239,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* from vcn4 and above, only unified queue is used */
+	adev->vcn.using_unified_queue =
+		adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0);
+
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
@@ -357,18 +361,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-/* from vcn4 and above, only unified queue is used */
-static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	bool ret = false;
-
-	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0))
-		ret = true;
-
-	return ret;
-}
-
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -480,7 +472,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 		}
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !adev->vcn.using_unified_queue) {
 			struct dpg_pause_state new_state;
 
 			if (fence[j] ||
@@ -526,7 +520,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -552,8 +548,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
@@ -806,12 +806,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
@@ -823,7 +822,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw = 0;
 
 	/* single queue headers */
-	if (sq) {
+	if (adev->vcn.using_unified_queue) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
 						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
@@ -842,7 +841,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -932,15 +931,15 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
@@ -953,7 +952,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -975,7 +974,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -998,15 +997,15 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
@@ -1019,7 +1018,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -1041,7 +1040,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 253ea6b159df..165d841e0aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -271,6 +271,7 @@ struct amdgpu_vcn {
 
 	struct ras_common_if    *ras_if;
 	struct amdgpu_vcn_ras   *ras;
+	bool using_unified_queue;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 69b3829bbe53..370d02bdde86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -754,11 +754,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->bo, *pbo;
+	struct amdgpu_bo *bo, *pbo;
 	struct amdgpu_vm *vm = params->vm;
 	uint64_t pde, pt, flags;
 	unsigned int level;
 
+	if (WARN_ON(!parent))
+		return -EINVAL;
+
+	bo = parent->bo;
 	for (level = 0, pbo = bo->parent; pbo; ++level)
 		pbo = pbo->parent;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 95548c512f4f..3c21128fa1d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -38,7 +38,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
+	char fw_name[45];
 	char ucode_prefix[30];
 	int err;
 	const struct imu_firmware_header_v1_0 *imu_hdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index f3c1af5130ab..3301ad980f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -541,11 +541,11 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring,	PACKETJ(mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b0f475d51ae7..e3cd66c4d95d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1400,17 +1400,23 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			goto sync_memory_failed;
 		}
 	}
-	mutex_unlock(&p->mutex);
 
-	if (flush_tlb) {
-		/* Flush TLBs after waiting for the page table updates to complete */
-		for (i = 0; i < args->n_devices; i++) {
-			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
-			if (WARN_ON_ONCE(!peer_pdd))
-				continue;
+	/* Flush TLBs after waiting for the page table updates to complete */
+	for (i = 0; i < args->n_devices; i++) {
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		if (flush_tlb)
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
-		}
+
+		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
+		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
+		if (err)
+			goto sync_memory_failed;
 	}
+
+	mutex_unlock(&p->mutex);
+
 	kfree(devices_arr);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index d6c5d48c878e..416168c7dcc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3633,7 +3633,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 						(int)hubp->curs_attr.width || pos_cpy.x
 						<= (int)hubp->curs_attr.width +
 						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = 2 * viewport_width - temp_x;
+						pos_cpy.x = temp_x + viewport_width;
 					}
 				}
 			} else {
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 8429b6518b50..aabdb5c74d93 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/media-bus-format.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -158,6 +159,7 @@ struct tc358768_priv {
 	u32 frs;	/* PLL Freqency range for HSCK (post divider) */
 
 	u32 dsiclk;	/* pll_clk / 2 */
+	u32 pclk;	/* incoming pclk rate */
 };
 
 static inline struct tc358768_priv *dsi_host_to_tc358768(struct mipi_dsi_host
@@ -381,6 +383,7 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
 	priv->prd = best_prd;
 	priv->frs = frs;
 	priv->dsiclk = best_pll / 2;
+	priv->pclk = mode->clock * 1000;
 
 	return 0;
 }
@@ -639,6 +642,28 @@ static u32 tc358768_ps_to_ns(u32 ps)
 	return ps / 1000;
 }
 
+static u32 tc358768_dpi_to_ns(u32 val, u32 pclk)
+{
+	return (u32)div_u64((u64)val * NANO, pclk);
+}
+
+/* Convert value in DPI pixel clock units to DSI byte count */
+static u32 tc358768_dpi_to_dsi_bytes(struct tc358768_priv *priv, u32 val)
+{
+	u64 m = (u64)val * priv->dsiclk / 4 * priv->dsi_lanes;
+	u64 n = priv->pclk;
+
+	return (u32)div_u64(m + n - 1, n);
+}
+
+static u32 tc358768_dsi_bytes_to_ns(struct tc358768_priv *priv, u32 val)
+{
+	u64 m = (u64)val * NANO;
+	u64 n = priv->dsiclk / 4 * priv->dsi_lanes;
+
+	return (u32)div_u64(m, n);
+}
+
 static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
@@ -648,11 +673,19 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	s32 raw_val;
 	const struct drm_display_mode *mode;
 	u32 hsbyteclk_ps, dsiclk_ps, ui_ps;
-	u32 dsiclk, hsbyteclk, video_start;
-	const u32 internal_delay = 40;
+	u32 dsiclk, hsbyteclk;
 	int ret, i;
 	struct videomode vm;
 	struct device *dev = priv->dev;
+	/* In pixelclock units */
+	u32 dpi_htot, dpi_data_start;
+	/* In byte units */
+	u32 dsi_dpi_htot, dsi_dpi_data_start;
+	u32 dsi_hsw, dsi_hbp, dsi_hact, dsi_hfp;
+	const u32 dsi_hss = 4; /* HSS is a short packet (4 bytes) */
+	/* In hsbyteclk units */
+	u32 dsi_vsdly;
+	const u32 internal_dly = 40;
 
 	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
 		dev_warn_once(dev, "Non-continuous mode unimplemented, falling back to continuous\n");
@@ -687,27 +720,23 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	case MIPI_DSI_FMT_RGB888:
 		val |= (0x3 << 4);
 		hact = vm.hactive * 3;
-		video_start = (vm.hsync_len + vm.hback_porch) * 3;
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		break;
 	case MIPI_DSI_FMT_RGB666:
 		val |= (0x4 << 4);
 		hact = vm.hactive * 3;
-		video_start = (vm.hsync_len + vm.hback_porch) * 3;
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		break;
 
 	case MIPI_DSI_FMT_RGB666_PACKED:
 		val |= (0x4 << 4) | BIT(3);
 		hact = vm.hactive * 18 / 8;
-		video_start = (vm.hsync_len + vm.hback_porch) * 18 / 8;
 		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		break;
 
 	case MIPI_DSI_FMT_RGB565:
 		val |= (0x5 << 4);
 		hact = vm.hactive * 2;
-		video_start = (vm.hsync_len + vm.hback_porch) * 2;
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		break;
 	default:
@@ -717,9 +746,152 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		return;
 	}
 
+	/*
+	 * There are three important things to make TC358768 work correctly,
+	 * which are not trivial to manage:
+	 *
+	 * 1. Keep the DPI line-time and the DSI line-time as close to each
+	 *    other as possible.
+	 * 2. TC358768 goes to LP mode after each line's active area. The DSI
+	 *    HFP period has to be long enough for entering and exiting LP mode.
+	 *    But it is not clear how to calculate this.
+	 * 3. VSDly (video start delay) has to be long enough to ensure that the
+	 *    DSI TX does not start transmitting until we have started receiving
+	 *    pixel data from the DPI input. It is not clear how to calculate
+	 *    this either.
+	 */
+
+	dpi_htot = vm.hactive + vm.hfront_porch + vm.hsync_len + vm.hback_porch;
+	dpi_data_start = vm.hsync_len + vm.hback_porch;
+
+	dev_dbg(dev, "dpi horiz timing (pclk): %u + %u + %u + %u = %u\n",
+		vm.hsync_len, vm.hback_porch, vm.hactive, vm.hfront_porch,
+		dpi_htot);
+
+	dev_dbg(dev, "dpi horiz timing (ns): %u + %u + %u + %u = %u\n",
+		tc358768_dpi_to_ns(vm.hsync_len, vm.pixelclock),
+		tc358768_dpi_to_ns(vm.hback_porch, vm.pixelclock),
+		tc358768_dpi_to_ns(vm.hactive, vm.pixelclock),
+		tc358768_dpi_to_ns(vm.hfront_porch, vm.pixelclock),
+		tc358768_dpi_to_ns(dpi_htot, vm.pixelclock));
+
+	dev_dbg(dev, "dpi data start (ns): %u + %u = %u\n",
+		tc358768_dpi_to_ns(vm.hsync_len, vm.pixelclock),
+		tc358768_dpi_to_ns(vm.hback_porch, vm.pixelclock),
+		tc358768_dpi_to_ns(dpi_data_start, vm.pixelclock));
+
+	dsi_dpi_htot = tc358768_dpi_to_dsi_bytes(priv, dpi_htot);
+	dsi_dpi_data_start = tc358768_dpi_to_dsi_bytes(priv, dpi_data_start);
+
+	if (dsi_dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) {
+		dsi_hsw = tc358768_dpi_to_dsi_bytes(priv, vm.hsync_len);
+		dsi_hbp = tc358768_dpi_to_dsi_bytes(priv, vm.hback_porch);
+	} else {
+		/* HBP is included in HSW in event mode */
+		dsi_hbp = 0;
+		dsi_hsw = tc358768_dpi_to_dsi_bytes(priv,
+						    vm.hsync_len +
+						    vm.hback_porch);
+
+		/*
+		 * The pixel packet includes the actual pixel data, and:
+		 * DSI packet header = 4 bytes
+		 * DCS code = 1 byte
+		 * DSI packet footer = 2 bytes
+		 */
+		dsi_hact = hact + 4 + 1 + 2;
+
+		dsi_hfp = dsi_dpi_htot - dsi_hact - dsi_hsw - dsi_hss;
+
+		/*
+		 * Here we should check if HFP is long enough for entering LP
+		 * and exiting LP, but it's not clear how to calculate that.
+		 * Instead, this is a naive algorithm that just adjusts the HFP
+		 * and HSW so that HFP is (at least) roughly 2/3 of the total
+		 * blanking time.
+		 */
+		if (dsi_hfp < (dsi_hfp + dsi_hsw + dsi_hss) * 2 / 3) {
+			u32 old_hfp = dsi_hfp;
+			u32 old_hsw = dsi_hsw;
+			u32 tot = dsi_hfp + dsi_hsw + dsi_hss;
+
+			dsi_hsw = tot / 3;
+
+			/*
+			 * Seems like sometimes HSW has to be divisible by num-lanes, but
+			 * not always...
+			 */
+			dsi_hsw = roundup(dsi_hsw, priv->dsi_lanes);
+
+			dsi_hfp = dsi_dpi_htot - dsi_hact - dsi_hsw - dsi_hss;
+
+			dev_dbg(dev,
+				"hfp too short, adjusting dsi hfp and dsi hsw from %u, %u to %u, %u\n",
+				old_hfp, old_hsw, dsi_hfp, dsi_hsw);
+		}
+
+		dev_dbg(dev,
+			"dsi horiz timing (bytes): %u, %u + %u + %u + %u = %u\n",
+			dsi_hss, dsi_hsw, dsi_hbp, dsi_hact, dsi_hfp,
+			dsi_hss + dsi_hsw + dsi_hbp + dsi_hact + dsi_hfp);
+
+		dev_dbg(dev, "dsi horiz timing (ns): %u + %u + %u + %u + %u = %u\n",
+			tc358768_dsi_bytes_to_ns(priv, dsi_hss),
+			tc358768_dsi_bytes_to_ns(priv, dsi_hsw),
+			tc358768_dsi_bytes_to_ns(priv, dsi_hbp),
+			tc358768_dsi_bytes_to_ns(priv, dsi_hact),
+			tc358768_dsi_bytes_to_ns(priv, dsi_hfp),
+			tc358768_dsi_bytes_to_ns(priv, dsi_hss + dsi_hsw +
+						 dsi_hbp + dsi_hact + dsi_hfp));
+	}
+
+	/* VSDly calculation */
+
+	/* Start with the HW internal delay */
+	dsi_vsdly = internal_dly;
+
+	/* Convert to byte units as the other variables are in byte units */
+	dsi_vsdly *= priv->dsi_lanes;
+
+	/* Do we need more delay, in addition to the internal? */
+	if (dsi_dpi_data_start > dsi_vsdly + dsi_hss + dsi_hsw + dsi_hbp) {
+		dsi_vsdly = dsi_dpi_data_start - dsi_hss - dsi_hsw - dsi_hbp;
+		dsi_vsdly = roundup(dsi_vsdly, priv->dsi_lanes);
+	}
+
+	dev_dbg(dev, "dsi data start (bytes) %u + %u + %u + %u = %u\n",
+		dsi_vsdly, dsi_hss, dsi_hsw, dsi_hbp,
+		dsi_vsdly + dsi_hss + dsi_hsw + dsi_hbp);
+
+	dev_dbg(dev, "dsi data start (ns) %u + %u + %u + %u = %u\n",
+		tc358768_dsi_bytes_to_ns(priv, dsi_vsdly),
+		tc358768_dsi_bytes_to_ns(priv, dsi_hss),
+		tc358768_dsi_bytes_to_ns(priv, dsi_hsw),
+		tc358768_dsi_bytes_to_ns(priv, dsi_hbp),
+		tc358768_dsi_bytes_to_ns(priv, dsi_vsdly + dsi_hss + dsi_hsw + dsi_hbp));
+
+	/* Convert back to hsbyteclk */
+	dsi_vsdly /= priv->dsi_lanes;
+
+	/*
+	 * The docs say that there is an internal delay of 40 cycles.
+	 * However, we get underflows if we follow that rule. If we
+	 * instead ignore the internal delay, things work. So either
+	 * the docs are wrong or the calculations are wrong.
+	 *
+	 * As a temporary fix, add the internal delay here, to counter
+	 * the subtraction when writing the register.
+	 */
+	dsi_vsdly += internal_dly;
+
+	/* Clamp to the register max */
+	if (dsi_vsdly - internal_dly > 0x3ff) {
+		dev_warn(dev, "VSDly too high, underflows likely\n");
+		dsi_vsdly = 0x3ff + internal_dly;
+	}
+
 	/* VSDly[9:0] */
-	video_start = max(video_start, internal_delay + 1) - internal_delay;
-	tc358768_write(priv, TC358768_VSDLY, video_start);
+	tc358768_write(priv, TC358768_VSDLY, dsi_vsdly - internal_dly);
 
 	tc358768_write(priv, TC358768_DATAFMT, val);
 	tc358768_write(priv, TC358768_DSITX_DT, data_type);
@@ -827,18 +999,6 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 		/* vbp */
 		tc358768_write(priv, TC358768_DSI_VBPR, vm.vback_porch);
-
-		/* hsw * byteclk * ndl / pclk */
-		val = (u32)div_u64(vm.hsync_len *
-				   (u64)hsbyteclk * priv->dsi_lanes,
-				   vm.pixelclock);
-		tc358768_write(priv, TC358768_DSI_HSW, val);
-
-		/* hbp * byteclk * ndl / pclk */
-		val = (u32)div_u64(vm.hback_porch *
-				   (u64)hsbyteclk * priv->dsi_lanes,
-				   vm.pixelclock);
-		tc358768_write(priv, TC358768_DSI_HBPR, val);
 	} else {
 		/* Set event mode */
 		tc358768_write(priv, TC358768_DSI_EVENT, 1);
@@ -852,16 +1012,13 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 		/* vbp (not used in event mode) */
 		tc358768_write(priv, TC358768_DSI_VBPR, 0);
+	}
 
-		/* (hsw + hbp) * byteclk * ndl / pclk */
-		val = (u32)div_u64((vm.hsync_len + vm.hback_porch) *
-				   (u64)hsbyteclk * priv->dsi_lanes,
-				   vm.pixelclock);
-		tc358768_write(priv, TC358768_DSI_HSW, val);
+	/* hsw (bytes) */
+	tc358768_write(priv, TC358768_DSI_HSW, dsi_hsw);
 
-		/* hbp (not used in event mode) */
-		tc358768_write(priv, TC358768_DSI_HBPR, 0);
-	}
+	/* hbp (bytes) */
+	tc358768_write(priv, TC358768_DSI_HBPR, dsi_hbp);
 
 	/* hact (bytes) */
 	tc358768_write(priv, TC358768_DSI_HACT, hact);
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index ca3842f71984..82071835ec9e 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -166,6 +166,11 @@ static void lima_gp_task_run(struct lima_sched_pipe *pipe,
 	gp_write(LIMA_GP_CMD, cmd);
 }
 
+static int lima_gp_bus_stop_poll(struct lima_ip *ip)
+{
+	return !!(gp_read(LIMA_GP_STATUS) & LIMA_GP_STATUS_BUS_STOPPED);
+}
+
 static int lima_gp_hard_reset_poll(struct lima_ip *ip)
 {
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0xC01A0000);
@@ -179,6 +184,13 @@ static int lima_gp_hard_reset(struct lima_ip *ip)
 
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0xC0FFE000);
 	gp_write(LIMA_GP_INT_MASK, 0);
+
+	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_STOP_BUS);
+	ret = lima_poll_timeout(ip, lima_gp_bus_stop_poll, 10, 100);
+	if (ret) {
+		dev_err(dev->dev, "%s bus stop timeout\n", lima_ip_name(ip));
+		return ret;
+	}
 	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_RESET);
 	ret = lima_poll_timeout(ip, lima_gp_hard_reset_poll, 10, 100);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index bb35aa5f5709..41e44a77c2be 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -31,24 +31,14 @@
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG(fmt, ...)                                                \
-	do {                                                               \
-		if (drm_debug_enabled(DRM_UT_KMS))                         \
-			DRM_DEBUG(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 /**
  * DPU_DEBUG_DRIVER - macro for hardware driver logging
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG_DRIVER(fmt, ...)                                         \
-	do {                                                               \
-		if (drm_debug_enabled(DRM_UT_DRIVER))                      \
-			DRM_ERROR(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
 #define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 62d48c0f905e..61c456c5015a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -889,6 +889,9 @@ static int dpu_plane_prepare_fb(struct drm_plane *plane,
 			new_state->fb, &layout);
 	if (ret) {
 		DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
+		if (pstate->aspace)
+			msm_framebuffer_cleanup(new_state->fb, pstate->aspace,
+						pstate->needs_dirtyfb);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index bd1343602f55..3c001b792423 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1248,6 +1248,8 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
 	link_info.rate = ctrl->link->link_params.rate;
 	link_info.capabilities = DP_LINK_CAP_ENHANCED_FRAMING;
 
+	dp_link_reset_phy_params_vx_px(ctrl->link);
+
 	dp_aux_link_configure(ctrl->aux, &link_info);
 
 	if (drm_dp_max_downspread(dpcd))
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index d38086650fcf..f2cc0cc0b66b 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -113,22 +113,22 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 static u32 dp_panel_get_supported_bpp(struct dp_panel *dp_panel,
 		u32 mode_edid_bpp, u32 mode_pclk_khz)
 {
-	struct dp_link_info *link_info;
+	const struct dp_link_info *link_info;
 	const u32 max_supported_bpp = 30, min_supported_bpp = 18;
-	u32 bpp = 0, data_rate_khz = 0;
+	u32 bpp, data_rate_khz;
 
-	bpp = min_t(u32, mode_edid_bpp, max_supported_bpp);
+	bpp = min(mode_edid_bpp, max_supported_bpp);
 
 	link_info = &dp_panel->link_info;
 	data_rate_khz = link_info->num_lanes * link_info->rate * 8;
 
-	while (bpp > min_supported_bpp) {
+	do {
 		if (mode_pclk_khz * bpp <= data_rate_khz)
-			break;
+			return bpp;
 		bpp -= 6;
-	}
+	} while (bpp > min_supported_bpp);
 
-	return bpp;
+	return min_supported_bpp;
 }
 
 static int dp_panel_update_modes(struct drm_connector *connector,
@@ -421,8 +421,9 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
 				drm_mode->clock);
 	drm_dbg_dp(panel->drm_dev, "bpp = %d\n", dp_panel->dp_mode.bpp);
 
-	dp_panel->dp_mode.bpp = max_t(u32, 18,
-				min_t(u32, dp_panel->dp_mode.bpp, 30));
+	dp_panel->dp_mode.bpp = dp_panel_get_mode_bpp(dp_panel, dp_panel->dp_mode.bpp,
+						      dp_panel->dp_mode.drm_mode.clock);
+
 	drm_dbg_dp(panel->drm_dev, "updated bpp = %d\n",
 				dp_panel->dp_mode.bpp);
 
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 31f054c903a4..a35c98306f1e 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -76,7 +76,7 @@ static bool
 wait_for_idle(struct drm_gem_object *obj)
 {
 	enum dma_resv_usage usage = dma_resv_usage_rw(true);
-	return dma_resv_wait_timeout(obj->resv, usage, false, 1000) > 0;
+	return dma_resv_wait_timeout(obj->resv, usage, false, 10) > 0;
 }
 
 static bool
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 80b8c8334284..a6071464a543 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1258,6 +1258,11 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		vop2_win_write(win, VOP2_WIN_AFBC_ROTATE_270, rotate_270);
 		vop2_win_write(win, VOP2_WIN_AFBC_ROTATE_90, rotate_90);
 	} else {
+		if (vop2_cluster_window(win)) {
+			vop2_win_write(win, VOP2_WIN_AFBC_ENABLE, 0);
+			vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, 0);
+		}
+
 		vop2_win_write(win, VOP2_WIN_YRGB_VIR, DIV_ROUND_UP(fb->pitches[0], 4));
 	}
 
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 81991090adcc..cd06f2549954 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -175,7 +175,7 @@ static void tegra_bo_unpin(struct host1x_bo_mapping *map)
 static void *tegra_bo_mmap(struct host1x_bo *bo)
 {
 	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
-	struct iosys_map map;
+	struct iosys_map map = { 0 };
 	int ret;
 
 	if (obj->vaddr) {
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0e5b2b3dea4d..1395270a30cb 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -924,7 +924,15 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 #define USB_DEVICE_ID_MS_SURFACE3_COVER		0x07de
-#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
+/*
+ * For a description of the Xbox controller models, refer to:
+ * https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
+ */
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708	0x02fd
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE	0x0b20
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914	0x0b13
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797	0x0b05
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE	0x0b22
 #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
 #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
 #define USB_DEVICE_ID_MS_MOUSE_0783      0x0783
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..9345e2bfd56e 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -446,7 +446,16 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_PRESENTER },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
 		.driver_data = MS_SURFACE_DIAL },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
+
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
 		.driver_data = MS_QUIRK_FF },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
 		.driver_data = MS_QUIRK_FF },
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 05e40880e7d4..82f171f6d0c5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1921,12 +1921,14 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
-	int resolution = hidinput_calc_abs_res(field, resolution_code);
+	int resolution;
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
 	}
 
+	resolution = hidinput_calc_abs_res(field, resolution_code);
+
 	if (equivalent_usage == HID_GD_X) {
 		fmin += features->offset_left;
 		fmax -= features->offset_right;
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index d88e883c7492..b5dc0b7d25ae 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -875,8 +875,14 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
 		}
 
 		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
-		if (!ret)
+		if (!ret) {
+			if (!val) {
+				fwnode_handle_put(child);
+				return dev_err_probe(&st->client->dev, -EINVAL,
+						     "shunt resistor value cannot be zero\n");
+			}
 			st->r_sense_uohm[addr] = val;
+		}
 	}
 
 	return 0;
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index a4adc8bd531f..534a6072036c 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -323,7 +323,11 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
 		}
 
 		/* Voltages */
-		for (i = 0; i < data->innr; i++) {
+		/*
+		 * The min() below does not have any practical meaning and is
+		 * only needed to silence a warning observed with gcc 12+.
+		 */
+		for (i = 0; i < min(data->innr, ARRAY_SIZE(data->in)); i++) {
 			data->in_status[i] = pc87360_read_value(data, LD_IN, i,
 					     PC87365_REG_IN_STATUS);
 			/* Clear bits */
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index cc957655cec2..471279bd7006 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -990,8 +990,10 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_prepare_enable(gi2c->core_clk);
-	if (ret)
+	if (ret) {
+		geni_icc_disable(&gi2c->se);
 		return ret;
+	}
 
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 849848ccb080..b9959621cc5d 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -314,7 +314,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	 * frequency with only 62 clock ticks max (31 high, 31 low).
 	 * Aim for a duty of 60% LOW, 40% HIGH.
 	 */
-	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz);
+	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz ?: 1);
 
 	for (cks = 0; cks < 7; cks++) {
 		/*
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index aa469b33ee2e..f7b4977d6649 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -298,6 +298,9 @@ struct tegra_i2c_dev {
 	bool is_vi;
 };
 
+#define IS_DVC(dev) (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && (dev)->is_dvc)
+#define IS_VI(dev)  (IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC) && (dev)->is_vi)
+
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
 		       unsigned int reg)
 {
@@ -315,9 +318,9 @@ static u32 dvc_readl(struct tegra_i2c_dev *i2c_dev, unsigned int reg)
  */
 static u32 tegra_i2c_reg_addr(struct tegra_i2c_dev *i2c_dev, unsigned int reg)
 {
-	if (i2c_dev->is_dvc)
+	if (IS_DVC(i2c_dev))
 		reg += (reg >= I2C_TX_FIFO) ? 0x10 : 0x40;
-	else if (i2c_dev->is_vi)
+	else if (IS_VI(i2c_dev))
 		reg = 0xc00 + (reg << 2);
 
 	return reg;
@@ -330,7 +333,7 @@ static void i2c_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsigned int reg)
 	/* read back register to make sure that register writes completed */
 	if (reg != I2C_TX_FIFO)
 		readl_relaxed(i2c_dev->base + tegra_i2c_reg_addr(i2c_dev, reg));
-	else if (i2c_dev->is_vi)
+	else if (IS_VI(i2c_dev))
 		readl_relaxed(i2c_dev->base + tegra_i2c_reg_addr(i2c_dev, I2C_INT_STATUS));
 }
 
@@ -446,7 +449,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	u32 *dma_buf;
 	int err;
 
-	if (i2c_dev->is_vi)
+	if (IS_VI(i2c_dev))
 		return 0;
 
 	if (i2c_dev->hw->has_apb_dma) {
@@ -639,7 +642,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 
 	WARN_ON_ONCE(err);
 
-	if (i2c_dev->is_dvc)
+	if (IS_DVC(i2c_dev))
 		tegra_dvc_init(i2c_dev);
 
 	val = I2C_CNFG_NEW_MASTER_FSM | I2C_CNFG_PACKET_MODE_EN |
@@ -651,7 +654,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	i2c_writel(i2c_dev, val, I2C_CNFG);
 	i2c_writel(i2c_dev, 0, I2C_INT_MASK);
 
-	if (i2c_dev->is_vi)
+	if (IS_VI(i2c_dev))
 		tegra_i2c_vi_init(i2c_dev);
 
 	switch (t->bus_freq_hz) {
@@ -703,7 +706,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 		return err;
 	}
 
-	if (!i2c_dev->is_dvc && !i2c_dev->is_vi) {
+	if (!IS_DVC(i2c_dev) && !IS_VI(i2c_dev)) {
 		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
 
 		sl_cfg |= I2C_SL_CNFG_NACK | I2C_SL_CNFG_NEWSL;
@@ -846,7 +849,7 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 		i2c_dev->msg_buf_remaining = buf_remaining;
 		i2c_dev->msg_buf = buf + words_to_transfer * BYTES_PER_FIFO_WORD;
 
-		if (i2c_dev->is_vi)
+		if (IS_VI(i2c_dev))
 			i2c_writesl_vi(i2c_dev, buf, I2C_TX_FIFO, words_to_transfer);
 		else
 			i2c_writesl(i2c_dev, buf, I2C_TX_FIFO, words_to_transfer);
@@ -933,7 +936,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	}
 
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
-	if (i2c_dev->is_dvc)
+	if (IS_DVC(i2c_dev))
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
 	/*
@@ -972,7 +975,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 
-	if (i2c_dev->is_dvc)
+	if (IS_DVC(i2c_dev))
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 
 	if (i2c_dev->dma_mode) {
@@ -1654,13 +1657,17 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra194-i2c", .data = &tegra194_i2c_hw, },
 	{ .compatible = "nvidia,tegra186-i2c", .data = &tegra186_i2c_hw, },
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-i2c-vi", .data = &tegra210_i2c_hw, },
+#endif
 	{ .compatible = "nvidia,tegra210-i2c", .data = &tegra210_i2c_hw, },
 	{ .compatible = "nvidia,tegra124-i2c", .data = &tegra124_i2c_hw, },
 	{ .compatible = "nvidia,tegra114-i2c", .data = &tegra114_i2c_hw, },
 	{ .compatible = "nvidia,tegra30-i2c", .data = &tegra30_i2c_hw, },
 	{ .compatible = "nvidia,tegra20-i2c", .data = &tegra20_i2c_hw, },
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC)
 	{ .compatible = "nvidia,tegra20-i2c-dvc", .data = &tegra20_i2c_hw, },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
@@ -1675,10 +1682,12 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 	multi_mode = device_property_read_bool(i2c_dev->dev, "multi-master");
 	i2c_dev->multimaster_mode = multi_mode;
 
-	if (of_device_is_compatible(np, "nvidia,tegra20-i2c-dvc"))
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
+	    of_device_is_compatible(np, "nvidia,tegra20-i2c-dvc"))
 		i2c_dev->is_dvc = true;
 
-	if (of_device_is_compatible(np, "nvidia,tegra210-i2c-vi"))
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC) &&
+	    of_device_is_compatible(np, "nvidia,tegra210-i2c-vi"))
 		i2c_dev->is_vi = true;
 }
 
@@ -1707,7 +1716,7 @@ static int tegra_i2c_init_clocks(struct tegra_i2c_dev *i2c_dev)
 	if (i2c_dev->hw == &tegra20_i2c_hw || i2c_dev->hw == &tegra30_i2c_hw)
 		i2c_dev->clocks[i2c_dev->nclocks++].id = "fast-clk";
 
-	if (i2c_dev->is_vi)
+	if (IS_VI(i2c_dev))
 		i2c_dev->clocks[i2c_dev->nclocks++].id = "slow";
 
 	err = devm_clk_bulk_get(i2c_dev->dev, i2c_dev->nclocks,
@@ -1823,9 +1832,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	 * domain.
 	 *
 	 * VI I2C device shouldn't be marked as IRQ-safe because VI I2C won't
-	 * be used for atomic transfers.
+	 * be used for atomic transfers. ACPI device is not IRQ safe also.
 	 */
-	if (!i2c_dev->is_vi)
+	if (!IS_VI(i2c_dev) && !has_acpi_companion(i2c_dev->dev))
 		pm_runtime_irq_safe(i2c_dev->dev);
 
 	pm_runtime_enable(i2c_dev->dev);
@@ -1898,7 +1907,7 @@ static int __maybe_unused tegra_i2c_runtime_resume(struct device *dev)
 	 * power ON/OFF during runtime PM resume/suspend, meaning that
 	 * controller needs to be re-initialized after power ON.
 	 */
-	if (i2c_dev->is_vi) {
+	if (IS_VI(i2c_dev)) {
 		err = tegra_i2c_init(i2c_dev);
 		if (err)
 			goto disable_clocks;
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 71b5dbe45c45..337c95d43f3f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -345,6 +345,8 @@ static void hci_dma_unmap_xfer(struct i3c_hci *hci,
 
 	for (i = 0; i < n; i++) {
 		xfer = xfer_list + i;
+		if (!xfer->data)
+			continue;
 		dma_unmap_single(&hci->master.dev,
 				 xfer->data_dma, xfer->data_len,
 				 xfer->rnw ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
@@ -450,10 +452,9 @@ static bool hci_dma_dequeue_xfer(struct i3c_hci *hci,
 		/*
 		 * We're deep in it if ever this condition is ever met.
 		 * Hardware might still be writing to memory, etc.
-		 * Better suspend the world than risking silent corruption.
 		 */
 		dev_crit(&hci->master.dev, "unable to abort the ring\n");
-		BUG();
+		WARN_ON(1);
 	}
 
 	for (i = 0; i < n; i++) {
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 194cac40da65..c560552244ae 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13183,15 +13183,16 @@ static void read_mod_write(struct hfi1_devdata *dd, u16 src, u64 bits,
 {
 	u64 reg;
 	u16 idx = src / BITS_PER_REGISTER;
+	unsigned long flags;
 
-	spin_lock(&dd->irq_src_lock);
+	spin_lock_irqsave(&dd->irq_src_lock, flags);
 	reg = read_csr(dd, CCE_INT_MASK + (8 * idx));
 	if (set)
 		reg |= bits;
 	else
 		reg &= ~bits;
 	write_csr(dd, CCE_INT_MASK + (8 * idx), reg);
-	spin_unlock(&dd->irq_src_lock);
+	spin_unlock_irqrestore(&dd->irq_src_lock, flags);
 }
 
 /**
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 716ec7baddef..d71b1d83e9ff 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -255,7 +255,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
 {
-	struct ib_qp_init_attr init_attr = {NULL};
+	struct ib_qp_init_attr init_attr = {};
 	struct rdma_cm_id *cm_id = con->cm_id;
 	int ret;
 
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 14b53dac1253..6b04a674f832 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -46,6 +46,9 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
 		return 0;
 	if (mt)
 		return mt->num_slots != num_slots ? -EINVAL : 0;
+	/* Arbitrary limit for avoiding too large memory allocation. */
+	if (num_slots > 1024)
+		return -EINVAL;
 
 	mt = kzalloc(struct_size(mt, slots, num_slots), GFP_KERNEL);
 	if (!mt)
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 5b50475ec414..e9eb9554dd7b 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -83,6 +83,7 @@ static inline void i8042_write_command(int val)
 #define SERIO_QUIRK_KBDRESET		BIT(12)
 #define SERIO_QUIRK_DRITEK		BIT(13)
 #define SERIO_QUIRK_NOPNP		BIT(14)
+#define SERIO_QUIRK_FORCENORESTORE	BIT(15)
 
 /* Quirk table for different mainboards. Options similar or identical to i8042
  * module parameters.
@@ -1149,18 +1150,10 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
 	{
-		/*
-		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
-		 * the keyboard very laggy for ~5 seconds after boot and
-		 * sometimes also after resume.
-		 * However both are required for the keyboard to not fail
-		 * completely sometimes after boot or resume.
-		 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
@@ -1685,6 +1678,8 @@ static void __init i8042_check_quirks(void)
 	if (quirks & SERIO_QUIRK_NOPNP)
 		i8042_nopnp = true;
 #endif
+	if (quirks & SERIO_QUIRK_FORCENORESTORE)
+		i8042_forcenorestore = true;
 }
 #else
 static inline void i8042_check_quirks(void) {}
@@ -1718,7 +1713,7 @@ static int __init i8042_platform_init(void)
 
 	i8042_check_quirks();
 
-	pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+	pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
 		i8042_nokbd ? " nokbd" : "",
 		i8042_noaux ? " noaux" : "",
 		i8042_nomux ? " nomux" : "",
@@ -1738,10 +1733,11 @@ static int __init i8042_platform_init(void)
 		"",
 #endif
 #ifdef CONFIG_PNP
-		i8042_nopnp ? " nopnp" : "");
+		i8042_nopnp ? " nopnp" : "",
 #else
-		"");
+		"",
 #endif
+		i8042_forcenorestore ? " forcenorestore" : "");
 
 	retval = i8042_pnp_init();
 	if (retval)
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 6dac7c1853a5..29340f8095bb 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -115,6 +115,10 @@ module_param_named(nopnp, i8042_nopnp, bool, 0);
 MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 #endif
 
+static bool i8042_forcenorestore;
+module_param_named(forcenorestore, i8042_forcenorestore, bool, 0);
+MODULE_PARM_DESC(forcenorestore, "Force no restore on s3 resume, copying s2idle behaviour");
+
 #define DEBUG
 #ifdef DEBUG
 static bool i8042_debug;
@@ -1232,7 +1236,7 @@ static int i8042_pm_suspend(struct device *dev)
 {
 	int i;
 
-	if (pm_suspend_via_firmware())
+	if (!i8042_forcenorestore && pm_suspend_via_firmware())
 		i8042_controller_reset(true);
 
 	/* Set up serio interrupts for system wakeup. */
@@ -1248,7 +1252,7 @@ static int i8042_pm_suspend(struct device *dev)
 
 static int i8042_pm_resume_noirq(struct device *dev)
 {
-	if (!pm_resume_via_firmware())
+	if (i8042_forcenorestore || !pm_resume_via_firmware())
 		i8042_interrupt(0, NULL);
 
 	return 0;
@@ -1271,7 +1275,7 @@ static int i8042_pm_resume(struct device *dev)
 	 * not restore the controller state to whatever it had been at boot
 	 * time, so we do not need to do anything.
 	 */
-	if (!pm_suspend_via_firmware())
+	if (i8042_forcenorestore || !pm_suspend_via_firmware())
 		return 0;
 
 	/*
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3620bdb5200f..a7a952bbfdc2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4476,8 +4476,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	struct page *vprop_page;
 	int base, nr_ids, i, err = 0;
 
-	BUG_ON(!vm);
-
 	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index be71459c7465..70279ca7e627 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -132,7 +132,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -145,7 +145,6 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		unsigned long tint = (uintptr_t)d->chip_data;
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
@@ -153,7 +152,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
index c43d55672bce..47c1fa7aad8b 100644
--- a/drivers/md/dm-clone-metadata.c
+++ b/drivers/md/dm-clone-metadata.c
@@ -465,11 +465,6 @@ static void __destroy_persistent_data_structures(struct dm_clone_metadata *cmd)
 
 /*---------------------------------------------------------------------------*/
 
-static size_t bitmap_size(unsigned long nr_bits)
-{
-	return BITS_TO_LONGS(nr_bits) * sizeof(long);
-}
-
 static int __dirty_map_init(struct dirty_map *dmap, unsigned long nr_words,
 			    unsigned long nr_regions)
 {
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 4376754816ab..f9df723866da 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1156,8 +1156,26 @@ static int do_resume(struct dm_ioctl *param)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
-		if (!dm_suspended_md(md))
-			dm_suspend(md, suspend_flags);
+		if (!dm_suspended_md(md)) {
+			r = dm_suspend(md, suspend_flags);
+			if (r) {
+				down_write(&_hash_lock);
+				hc = dm_get_mdptr(md);
+				if (hc && !hc->new_map) {
+					hc->new_map = new_map;
+					new_map = NULL;
+				} else {
+					r = -ENXIO;
+				}
+				up_write(&_hash_lock);
+				if (new_map) {
+					dm_sync_table(md);
+					dm_table_destroy(new_map);
+				}
+				dm_put(md);
+				return r;
+			}
+		}
 
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 29270f6f272f..ddd44a7f79db 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2511,7 +2511,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int ta
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2536,7 +2536,7 @@ static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_st
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b87c6ef0da8a..297c86f5c70b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7614,11 +7614,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 
 	mddev = bdev->bd_disk->private_data;
 
-	if (!mddev) {
-		BUG();
-		goto out;
-	}
-
 	/* Some actions do not requires the mutex */
 	switch (cmd) {
 	case GET_ARRAY_INFO:
diff --git a/drivers/md/persistent-data/dm-space-map-metadata.c b/drivers/md/persistent-data/dm-space-map-metadata.c
index 0d1fcdf29c83..769bb70d37d5 100644
--- a/drivers/md/persistent-data/dm-space-map-metadata.c
+++ b/drivers/md/persistent-data/dm-space-map-metadata.c
@@ -274,7 +274,7 @@ static void sm_metadata_destroy(struct dm_space_map *sm)
 {
 	struct sm_metadata *smm = container_of(sm, struct sm_metadata, sm);
 
-	kfree(smm);
+	kvfree(smm);
 }
 
 static int sm_metadata_get_nr_blocks(struct dm_space_map *sm, dm_block_t *count)
@@ -768,7 +768,7 @@ struct dm_space_map *dm_sm_metadata_init(void)
 {
 	struct sm_metadata *smm;
 
-	smm = kmalloc(sizeof(*smm), GFP_KERNEL);
+	smm = kvmalloc(sizeof(*smm), GFP_KERNEL);
 	if (!smm)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index eb66d0bfe39d..4b9585875a66 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -327,8 +327,9 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space);
 void r5c_check_stripe_cache_usage(struct r5conf *conf)
 {
 	int total_cached;
+	struct r5l_log *log = READ_ONCE(conf->log);
 
-	if (!r5c_is_writeback(conf->log))
+	if (!r5c_is_writeback(log))
 		return;
 
 	total_cached = atomic_read(&conf->r5c_cached_partial_stripes) +
@@ -344,7 +345,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
 	 */
 	if (total_cached > conf->min_nr_stripes * 1 / 2 ||
 	    atomic_read(&conf->empty_inactive_list_nr) > 0)
-		r5l_wake_reclaim(conf->log, 0);
+		r5l_wake_reclaim(log, 0);
 }
 
 /*
@@ -353,7 +354,9 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
  */
 void r5c_check_cached_full_stripe(struct r5conf *conf)
 {
-	if (!r5c_is_writeback(conf->log))
+	struct r5l_log *log = READ_ONCE(conf->log);
+
+	if (!r5c_is_writeback(log))
 		return;
 
 	/*
@@ -363,7 +366,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
 	if (atomic_read(&conf->r5c_cached_full_stripes) >=
 	    min(R5C_FULL_STRIPE_FLUSH_BATCH(conf),
 		conf->chunk_sectors >> RAID5_STRIPE_SHIFT(conf)))
-		r5l_wake_reclaim(conf->log, 0);
+		r5l_wake_reclaim(log, 0);
 }
 
 /*
@@ -396,7 +399,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
  */
 static sector_t r5c_log_required_to_flush_cache(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 
 	if (!r5c_is_writeback(log))
 		return 0;
@@ -449,7 +452,7 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 void r5c_make_stripe_write_out(struct stripe_head *sh)
 {
 	struct r5conf *conf = sh->raid_conf;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 
 	BUG_ON(!r5c_is_writeback(log));
 
@@ -491,7 +494,7 @@ static void r5c_handle_parity_cached(struct stripe_head *sh)
  */
 static void r5c_finish_cache_stripe(struct stripe_head *sh)
 {
-	struct r5l_log *log = sh->raid_conf->log;
+	struct r5l_log *log = READ_ONCE(sh->raid_conf->log);
 
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH) {
 		BUG_ON(test_bit(STRIPE_R5C_CACHING, &sh->state));
@@ -692,7 +695,7 @@ static void r5c_disable_writeback_async(struct work_struct *work)
 
 	/* wait superblock change before suspend */
 	wait_event(mddev->sb_wait,
-		   conf->log == NULL ||
+		   !READ_ONCE(conf->log) ||
 		   (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) &&
 		    (locked = mddev_trylock(mddev))));
 	if (locked) {
@@ -1151,7 +1154,7 @@ static void r5l_run_no_space_stripes(struct r5l_log *log)
 static sector_t r5c_calculate_new_cp(struct r5conf *conf)
 {
 	struct stripe_head *sh;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 	sector_t new_cp;
 	unsigned long flags;
 
@@ -1159,12 +1162,12 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
 		return log->next_checkpoint;
 
 	spin_lock_irqsave(&log->stripe_in_journal_lock, flags);
-	if (list_empty(&conf->log->stripe_in_journal_list)) {
+	if (list_empty(&log->stripe_in_journal_list)) {
 		/* all stripes flushed */
 		spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
 		return log->next_checkpoint;
 	}
-	sh = list_first_entry(&conf->log->stripe_in_journal_list,
+	sh = list_first_entry(&log->stripe_in_journal_list,
 			      struct stripe_head, r5c);
 	new_cp = sh->log_start;
 	spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
@@ -1399,7 +1402,7 @@ void r5c_flush_cache(struct r5conf *conf, int num)
 	struct stripe_head *sh, *next;
 
 	lockdep_assert_held(&conf->device_lock);
-	if (!conf->log)
+	if (!READ_ONCE(conf->log))
 		return;
 
 	count = 0;
@@ -1420,7 +1423,7 @@ void r5c_flush_cache(struct r5conf *conf, int num)
 
 static void r5c_do_reclaim(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 	struct stripe_head *sh;
 	int count = 0;
 	unsigned long flags;
@@ -1549,7 +1552,7 @@ static void r5l_reclaim_thread(struct md_thread *thread)
 {
 	struct mddev *mddev = thread->mddev;
 	struct r5conf *conf = mddev->private;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 
 	if (!log)
 		return;
@@ -1589,7 +1592,7 @@ void r5l_quiesce(struct r5l_log *log, int quiesce)
 
 bool r5l_log_disk_error(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 
 	/* don't allow write if journal disk is missing */
 	if (!log)
@@ -2633,7 +2636,7 @@ int r5c_try_caching_write(struct r5conf *conf,
 			  struct stripe_head_state *s,
 			  int disks)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 	int i;
 	struct r5dev *dev;
 	int to_cache = 0;
@@ -2800,7 +2803,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 				 struct stripe_head *sh,
 				 struct stripe_head_state *s)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 	int i;
 	int do_wakeup = 0;
 	sector_t tree_index;
@@ -2939,7 +2942,7 @@ int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh)
 /* check whether this big stripe is in write back cache. */
 bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 	sector_t tree_index;
 	void *slot;
 
@@ -3047,14 +3050,14 @@ int r5l_start(struct r5l_log *log)
 void r5c_update_on_rdev_error(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r5conf *conf = mddev->private;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = READ_ONCE(conf->log);
 
 	if (!log)
 		return;
 
 	if ((raid5_calc_degraded(conf) > 0 ||
 	     test_bit(Journal, &rdev->flags)) &&
-	    conf->log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK)
+	    log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK)
 		schedule_work(&log->disable_writeback_work);
 }
 
@@ -3143,7 +3146,7 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	spin_lock_init(&log->stripe_in_journal_lock);
 	atomic_set(&log->stripe_in_journal_count, 0);
 
-	conf->log = log;
+	WRITE_ONCE(conf->log, log);
 
 	set_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
 	return 0;
@@ -3171,7 +3174,7 @@ void r5l_exit_log(struct r5conf *conf)
 	 * 'reconfig_mutex' is held by caller, set 'confg->log' to NULL to
 	 * ensure disable_writeback_work wakes up and exits.
 	 */
-	conf->log = NULL;
+	WRITE_ONCE(conf->log, NULL);
 	wake_up(&conf->mddev->sb_wait);
 	flush_work(&log->disable_writeback_work);
 
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index fce0e2094078..a1a3dbb0e738 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2160,7 +2160,8 @@ static int dvb_frontend_handle_compat_ioctl(struct file *file, unsigned int cmd,
 		if (!tvps->num || (tvps->num > DTV_IOCTL_MAX_MSGS))
 			return -EINVAL;
 
-		tvp = memdup_user(compat_ptr(tvps->props), tvps->num * sizeof(*tvp));
+		tvp = memdup_array_user(compat_ptr(tvps->props),
+					tvps->num, sizeof(*tvp));
 		if (IS_ERR(tvp))
 			return PTR_ERR(tvp);
 
@@ -2191,7 +2192,8 @@ static int dvb_frontend_handle_compat_ioctl(struct file *file, unsigned int cmd,
 		if (!tvps->num || (tvps->num > DTV_IOCTL_MAX_MSGS))
 			return -EINVAL;
 
-		tvp = memdup_user(compat_ptr(tvps->props), tvps->num * sizeof(*tvp));
+		tvp = memdup_array_user(compat_ptr(tvps->props),
+					tvps->num, sizeof(*tvp));
 		if (IS_ERR(tvp))
 			return PTR_ERR(tvp);
 
@@ -2368,7 +2370,8 @@ static int dvb_get_property(struct dvb_frontend *fe, struct file *file,
 	if (!tvps->num || tvps->num > DTV_IOCTL_MAX_MSGS)
 		return -EINVAL;
 
-	tvp = memdup_user((void __user *)tvps->props, tvps->num * sizeof(*tvp));
+	tvp = memdup_array_user((void __user *)tvps->props,
+				tvps->num, sizeof(*tvp));
 	if (IS_ERR(tvp))
 		return PTR_ERR(tvp);
 
@@ -2446,7 +2449,8 @@ static int dvb_frontend_handle_ioctl(struct file *file,
 		if (!tvps->num || (tvps->num > DTV_IOCTL_MAX_MSGS))
 			return -EINVAL;
 
-		tvp = memdup_user((void __user *)tvps->props, tvps->num * sizeof(*tvp));
+		tvp = memdup_array_user((void __user *)tvps->props,
+					tvps->num, sizeof(*tvp));
 		if (IS_ERR(tvp))
 			return PTR_ERR(tvp);
 
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 9af2c5596121..51d7d720ec48 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1354,6 +1354,10 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register Video device */
 	dev->video_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_video_template, "video");
+	if (!dev->video_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
 	dev->video_dev->queue = &dev->vb2_vidq;
 	dev->video_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
 				      V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
@@ -1382,6 +1386,10 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register VBI device */
 	dev->vbi_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_vbi_template, "vbi");
+	if (!dev->vbi_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
 	dev->vbi_dev->queue = &dev->vb2_vbiq;
 	dev->vbi_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
 				    V4L2_CAP_AUDIO | V4L2_CAP_VBI_CAPTURE;
diff --git a/drivers/media/pci/solo6x10/solo6x10-offsets.h b/drivers/media/pci/solo6x10/solo6x10-offsets.h
index f414ee1316f2..fdbb817e6360 100644
--- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
+++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
@@ -57,16 +57,16 @@
 #define SOLO_MP4E_EXT_ADDR(__solo) \
 	(SOLO_EREF_EXT_ADDR(__solo) + SOLO_EREF_EXT_AREA(__solo))
 #define SOLO_MP4E_EXT_SIZE(__solo) \
-	max((__solo->nr_chans * 0x00080000),				\
-	    min(((__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo)) -	\
-		 __SOLO_JPEG_MIN_SIZE(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo) -	\
+	      __SOLO_JPEG_MIN_SIZE(__solo),			\
+	      __solo->nr_chans * 0x00080000, 0x00ff0000)
 
 #define __SOLO_JPEG_MIN_SIZE(__solo)		(__solo->nr_chans * 0x00080000)
 #define SOLO_JPEG_EXT_ADDR(__solo) \
 		(SOLO_MP4E_EXT_ADDR(__solo) + SOLO_MP4E_EXT_SIZE(__solo))
 #define SOLO_JPEG_EXT_SIZE(__solo) \
-	max(__SOLO_JPEG_MIN_SIZE(__solo),				\
-	    min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo),	\
+	      __SOLO_JPEG_MIN_SIZE(__solo), 0x00ff0000)
 
 #define SOLO_SDRAM_END(__solo) \
 	(SOLO_JPEG_EXT_ADDR(__solo) + SOLO_JPEG_EXT_SIZE(__solo))
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 48c9084bb4db..a1b127caa90a 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -870,7 +870,7 @@ static int vcodec_domains_get(struct venus_core *core)
 		pd = dev_pm_domain_attach_by_name(dev,
 						  res->vcodec_pmdomains[i]);
 		if (IS_ERR_OR_NULL(pd))
-			return PTR_ERR(pd) ? : -ENODATA;
+			return pd ? PTR_ERR(pd) : -ENODATA;
 		core->pmdomains[i] = pd;
 	}
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index f62703cebb77..4b4c129c09e7 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1297,7 +1297,7 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 	if (ctx->state == MFCINST_FINISHING && ctx->ref_queue_cnt == 0)
 		src_ready = false;
 	if (!src_ready || ctx->dst_queue_cnt == 0)
-		clear_work_bit(ctx);
+		clear_work_bit_irqsave(ctx);
 
 	return 0;
 }
diff --git a/drivers/media/radio/radio-isa.c b/drivers/media/radio/radio-isa.c
index c591c0851fa2..ad49151f5ff0 100644
--- a/drivers/media/radio/radio-isa.c
+++ b/drivers/media/radio/radio-isa.c
@@ -36,7 +36,7 @@ static int radio_isa_querycap(struct file *file, void  *priv,
 
 	strscpy(v->driver, isa->drv->driver.driver.name, sizeof(v->driver));
 	strscpy(v->card, isa->drv->card, sizeof(v->card));
-	snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", isa->v4l2_dev.name);
+	snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", dev_name(isa->v4l2_dev.dev));
 	return 0;
 }
 
diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index ffec26a99313..5c387d32c078 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -179,8 +179,11 @@ static int stm32_fmc2_ebi_check_mux(struct stm32_fmc2_ebi *ebi,
 				    int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (bcr & FMC2_BCR_MTYP)
 		return 0;
@@ -193,8 +196,11 @@ static int stm32_fmc2_ebi_check_waitcfg(struct stm32_fmc2_ebi *ebi,
 					int cs)
 {
 	u32 bcr, val = FIELD_PREP(FMC2_BCR_MTYP, FMC2_BCR_MTYP_NOR);
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if ((bcr & FMC2_BCR_MTYP) == val && bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -207,8 +213,11 @@ static int stm32_fmc2_ebi_check_sync_trans(struct stm32_fmc2_ebi *ebi,
 					   int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -221,8 +230,11 @@ static int stm32_fmc2_ebi_check_async_trans(struct stm32_fmc2_ebi *ebi,
 					    int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (!(bcr & FMC2_BCR_BURSTEN) || !(bcr & FMC2_BCR_CBURSTRW))
 		return 0;
@@ -235,8 +247,11 @@ static int stm32_fmc2_ebi_check_cpsize(struct stm32_fmc2_ebi *ebi,
 				       int cs)
 {
 	u32 bcr, val = FIELD_PREP(FMC2_BCR_MTYP, FMC2_BCR_MTYP_PSRAM);
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if ((bcr & FMC2_BCR_MTYP) == val && bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -249,12 +264,18 @@ static int stm32_fmc2_ebi_check_address_hold(struct stm32_fmc2_ebi *ebi,
 					     int cs)
 {
 	u32 bcr, bxtr, val = FIELD_PREP(FMC2_BXTR_ACCMOD, FMC2_BXTR_EXTMOD_D);
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
 	if (prop->reg_type == FMC2_REG_BWTR)
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+	if (ret)
+		return ret;
 
 	if ((!(bcr & FMC2_BCR_BURSTEN) || !(bcr & FMC2_BCR_CBURSTRW)) &&
 	    ((bxtr & FMC2_BXTR_ACCMOD) == val || bcr & FMC2_BCR_MUXEN))
@@ -268,12 +289,19 @@ static int stm32_fmc2_ebi_check_clk_period(struct stm32_fmc2_ebi *ebi,
 					   int cs)
 {
 	u32 bcr, bcr1;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
-	if (cs)
-		regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
-	else
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
+
+	if (cs) {
+		ret = regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
+		if (ret)
+			return ret;
+	} else {
 		bcr1 = bcr;
+	}
 
 	if (bcr & FMC2_BCR_BURSTEN && (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
 		return 0;
@@ -305,12 +333,18 @@ static u32 stm32_fmc2_ebi_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
 {
 	u32 nb_clk_cycles = stm32_fmc2_ebi_ns_to_clock_cycles(ebi, cs, setup);
 	u32 bcr, btr, clk_period;
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
+	if (ret)
+		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
 	if (bcr & FMC2_BCR1_CCLKEN || !cs)
-		regmap_read(ebi->regmap, FMC2_BTR1, &btr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR1, &btr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+	if (ret)
+		return ret;
 
 	clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
 
@@ -569,11 +603,16 @@ static int stm32_fmc2_ebi_set_address_setup(struct stm32_fmc2_ebi *ebi,
 	if (ret)
 		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
+
 	if (prop->reg_type == FMC2_REG_BWTR)
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+	if (ret)
+		return ret;
 
 	if ((bxtr & FMC2_BXTR_ACCMOD) == val || bcr & FMC2_BCR_MUXEN)
 		val = clamp_val(setup, 1, FMC2_BXTR_ADDSET_MAX);
@@ -691,11 +730,14 @@ static int stm32_fmc2_ebi_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
 					    int cs, u32 setup)
 {
 	u32 old_val, new_val, pcscntr;
+	int ret;
 
 	if (setup < 1)
 		return 0;
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+	ret = regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+	if (ret)
+		return ret;
 
 	/* Enable counter for the bank */
 	regmap_update_bits(ebi->regmap, FMC2_PCSCNTR,
@@ -942,17 +984,20 @@ static void stm32_fmc2_ebi_disable_bank(struct stm32_fmc2_ebi *ebi, int cs)
 	regmap_update_bits(ebi->regmap, FMC2_BCR(cs), FMC2_BCR_MBKEN, 0);
 }
 
-static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
+static int stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 {
 	unsigned int cs;
+	int ret;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
-		regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
+		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
+		ret |= regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
+		ret |= regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
+		if (ret)
+			return ret;
 	}
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
+	return regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
 }
 
 static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
@@ -981,22 +1026,29 @@ static void stm32_fmc2_ebi_disable_banks(struct stm32_fmc2_ebi *ebi)
 }
 
 /* NWAIT signal can not be connected to EBI controller and NAND controller */
-static bool stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
+static int stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
 {
+	struct device *dev = ebi->dev;
 	unsigned int cs;
 	u32 bcr;
+	int ret;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
 		if (!(ebi->bank_assigned & BIT(cs)))
 			continue;
 
-		regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+		if (ret)
+			return ret;
+
 		if ((bcr & FMC2_BCR_WAITEN || bcr & FMC2_BCR_ASYNCWAIT) &&
-		    ebi->bank_assigned & BIT(FMC2_NAND))
-			return true;
+		    ebi->bank_assigned & BIT(FMC2_NAND)) {
+			dev_err(dev, "NWAIT signal connected to EBI and NAND controllers\n");
+			return -EINVAL;
+		}
 	}
 
-	return false;
+	return 0;
 }
 
 static void stm32_fmc2_ebi_enable(struct stm32_fmc2_ebi *ebi)
@@ -1083,10 +1135,9 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 		return -ENODEV;
 	}
 
-	if (stm32_fmc2_ebi_nwait_used_by_ctrls(ebi)) {
-		dev_err(dev, "NWAIT signal connected to EBI and NAND controllers\n");
-		return -EINVAL;
-	}
+	ret = stm32_fmc2_ebi_nwait_used_by_ctrls(ebi);
+	if (ret)
+		return ret;
 
 	stm32_fmc2_ebi_enable(ebi);
 
@@ -1131,7 +1182,10 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_release;
 
-	stm32_fmc2_ebi_save_setup(ebi);
+	ret = stm32_fmc2_ebi_save_setup(ebi);
+	if (ret)
+		goto err_release;
+
 	platform_set_drvdata(pdev, ebi);
 
 	return 0;
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 7bb73f06fad3..fd6f5e2e01a2 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -74,6 +74,9 @@ static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
 {
 	u32 value, old;
 
+	if (client->regs.sid.security == 0 && client->regs.sid.override == 0)
+		return;
+
 	value = readl(mc->regs + client->regs.sid.security);
 	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
 		/*
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 155ce2bdfe62..dbbcbdeab6c5 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3109,13 +3109,13 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
 #ifdef CONFIG_HIGHMEM
 	test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
+	if (!test->highmem) {
+		count = -ENOMEM;
+		goto free_test_buffer;
+	}
 #endif
 
-#ifdef CONFIG_HIGHMEM
-	if (test->buffer && test->highmem) {
-#else
 	if (test->buffer) {
-#endif
 		mutex_lock(&mmc_test_lock);
 		mmc_test_run(test, testcase);
 		mutex_unlock(&mmc_test_lock);
@@ -3123,6 +3123,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 #ifdef CONFIG_HIGHMEM
 	__free_pages(test->highmem, BUFFER_ORDER);
+free_test_buffer:
 #endif
 	kfree(test->buffer);
 	kfree(test);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c78bbc22e0d1..a0ccf88876f9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3295,6 +3295,10 @@ int dw_mci_probe(struct dw_mci *host)
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
+		ret = PTR_ERR(host->biu_clk);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
 	} else {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret) {
@@ -3306,6 +3310,10 @@ int dw_mci_probe(struct dw_mci *host)
 	host->ciu_clk = devm_clk_get(host->dev, "ciu");
 	if (IS_ERR(host->ciu_clk)) {
 		dev_dbg(host->dev, "ciu clock not available\n");
+		ret = PTR_ERR(host->ciu_clk);
+		if (ret == -EPROBE_DEFER)
+			goto err_clk_biu;
+
 		host->bus_hz = host->pdata->bus_hz;
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index be5348d0b22e..c21835281443 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -578,7 +578,6 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
 		}
-		ipsec->xs->xso.real_dev = NULL;
 	}
 	spin_unlock_bh(&bond->ipsec_lock);
 	rcu_read_unlock();
@@ -595,34 +594,30 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	struct net_device *real_dev;
 	struct slave *curr_active;
 	struct bonding *bond;
-	int err;
+	bool ok = false;
 
 	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
 	curr_active = rcu_dereference(bond->curr_active_slave);
+	if (!curr_active)
+		goto out;
 	real_dev = curr_active->dev;
 
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = false;
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		goto out;
-	}
 
-	if (!xs->xso.real_dev) {
-		err = false;
+	if (!xs->xso.real_dev)
 		goto out;
-	}
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
-	    netif_is_bond_master(real_dev)) {
-		err = false;
+	    netif_is_bond_master(real_dev))
 		goto out;
-	}
 
-	err = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
+	ok = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
 out:
 	rcu_read_unlock();
-	return err;
+	return ok;
 }
 
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 685fb4703ee1..06c4cd0f0002 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -932,7 +932,7 @@ static int bond_option_active_slave_set(struct bonding *bond,
 	/* check to see if we are clearing active */
 	if (!slave_dev) {
 		netdev_dbg(bond->dev, "Clearing current active slave\n");
-		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
+		bond_change_active_slave(bond, NULL);
 		bond_select_active_slave(bond);
 	} else {
 		struct slave *old_active = rtnl_dereference(bond->curr_active_slave);
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index 7c513a03789c..17fd62616ce6 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -453,7 +453,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
 						   entry.portvec, entry.mac,
 						   fid);
-		chip->ports[spid].atu_full_violation++;
+		if (spid < ARRAY_SIZE(chip->ports))
+			chip->ports[spid].atu_full_violation++;
 	}
 	mv88e6xxx_reg_unlock(chip);
 
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 2d2c6f941272..73da407bb068 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -528,7 +528,9 @@ static int felix_tag_8021q_setup(struct dsa_switch *ds)
 	 * so we need to be careful that there are no extra frames to be
 	 * dequeued over MMIO, since we would never know to discard them.
 	 */
+	ocelot_lock_xtr_grp_bh(ocelot, 0);
 	ocelot_drain_cpu_queue(ocelot, 0);
+	ocelot_unlock_xtr_grp_bh(ocelot, 0);
 
 	return 0;
 }
@@ -1493,6 +1495,8 @@ static void felix_port_deferred_xmit(struct kthread_work *work)
 	int port = xmit_work->dp->index;
 	int retries = 10;
 
+	ocelot_lock_inj_grp(ocelot, 0);
+
 	do {
 		if (ocelot_can_inject(ocelot, 0))
 			break;
@@ -1501,6 +1505,7 @@ static void felix_port_deferred_xmit(struct kthread_work *work)
 	} while (--retries);
 
 	if (!retries) {
+		ocelot_unlock_inj_grp(ocelot, 0);
 		dev_err(ocelot->dev, "port %d failed to inject skb\n",
 			port);
 		ocelot_port_purge_txtstamp_skb(ocelot, port, skb);
@@ -1510,6 +1515,8 @@ static void felix_port_deferred_xmit(struct kthread_work *work)
 
 	ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
 
+	ocelot_unlock_inj_grp(ocelot, 0);
+
 	consume_skb(skb);
 	kfree(xmit_work);
 }
@@ -1658,6 +1665,8 @@ static bool felix_check_xtr_pkt(struct ocelot *ocelot)
 	if (!felix->info->quirk_no_xtr_irq)
 		return false;
 
+	ocelot_lock_xtr_grp(ocelot, grp);
+
 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {
 		struct sk_buff *skb;
 		unsigned int type;
@@ -1694,6 +1703,8 @@ static bool felix_check_xtr_pkt(struct ocelot *ocelot)
 		ocelot_drain_cpu_queue(ocelot, 0);
 	}
 
+	ocelot_unlock_xtr_grp(ocelot, grp);
+
 	return true;
 }
 
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 3efd55669056..c8e9ca5d5c28 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
@@ -38,6 +39,10 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -196,6 +201,8 @@
 #define VSC73XX_MII_CMD		0x1
 #define VSC73XX_MII_DATA	0x2
 
+#define VSC73XX_MII_STAT_BUSY	BIT(3)
+
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
 #define VSC73XX_ARBDISC			0x0e
@@ -269,6 +276,10 @@
 #define IS_7398(a) ((a)->chipid == VSC73XX_CHIPID_ID_7398)
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
+#define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_MDIO_POLL_SLEEP_US	5
+#define VSC73XX_POLL_TIMEOUT_US		10000
+
 struct vsc73xx_counter {
 	u8 counter;
 	const char *name;
@@ -484,6 +495,22 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	return 0;
 }
 
+static int vsc73xx_mdio_busy_check(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || !(val & VSC73XX_MII_STAT_BUSY),
+				VSC73XX_MDIO_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false, vsc,
+				VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+				VSC73XX_MII_STAT, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
 static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -491,12 +518,20 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	u32 val;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* Setting bit 26 means "read" */
 	cmd = BIT(26) | (phy << 21) | (regnum << 16);
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
-	msleep(2);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
 	if (ret)
 		return ret;
@@ -520,6 +555,10 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	u32 cmd;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* It was found through tedious experiments that this router
 	 * chip really hates to have it's PHYs reset. They
 	 * never recover if that happens: autonegotiation stops
@@ -531,7 +570,7 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16);
+	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
@@ -780,7 +819,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -795,19 +834,17 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 				    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
 		/* Wait until queue is empty */
-		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
-		}
+		ret = read_poll_timeout(vsc73xx_read, err,
+					err < 0 || (val & BIT(port)),
+					VSC73XX_POLL_SLEEP_US,
+					VSC73XX_POLL_TIMEOUT_US, false,
+					vsc, VSC73XX_BLOCK_ARBITER, 0,
+					VSC73XX_ARBEMPTY, &val);
+		if (ret)
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+		else if (err < 0)
+			dev_err(vsc->dev, "error reading arbiter\n");
 
 		/* Put this port into reset */
 		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 786ceae34488..dd9e68465e69 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -1244,7 +1244,8 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
 	 * in the Compressed Filter Tuple.
 	 */
 	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
-		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
+		ntuple |= (u64)(FT_VLAN_VLD_F |
+				fs->val.ivlan) << tp->vlan_shift;
 
 	if (tp->port_shift >= 0 && fs->mask.iport)
 		ntuple |= (u64)fs->val.iport << tp->port_shift;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index b98ef4ba172f..d6c871f22794 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2583,13 +2583,14 @@ static int dpaa2_switch_refill_bp(struct ethsw_core *ethsw)
 
 static int dpaa2_switch_seed_bp(struct ethsw_core *ethsw)
 {
-	int *count, i;
+	int *count, ret, i;
 
 	for (i = 0; i < DPAA2_ETHSW_NUM_BUFS; i += BUFS_PER_CMD) {
+		ret = dpaa2_switch_add_bufs(ethsw, ethsw->bpid);
 		count = &ethsw->buf_count;
-		*count += dpaa2_switch_add_bufs(ethsw, ethsw->bpid);
+		*count += ret;
 
-		if (unlikely(*count < BUFS_PER_CMD))
+		if (unlikely(ret < BUFS_PER_CMD))
 			return -ENOMEM;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4ce43c3a00a3..0377a056aaec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5728,6 +5728,9 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	struct net_device *netdev = handle->kinfo.netdev;
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 
+	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		hns3_nic_net_stop(netdev);
+
 	if (!test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state)) {
 		netdev_warn(netdev, "already uninitialized\n");
 		return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 01e24b69e920..45bd5c79e4da 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2696,8 +2696,17 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	ret = hclge_cfg_mac_speed_dup(hdev, speed, duplex, lane_num);
+
+	if (ret)
+		return ret;
 
-	return hclge_cfg_mac_speed_dup(hdev, speed, duplex, lane_num);
+	hdev->hw.mac.req_speed = speed;
+	hdev->hw.mac.req_duplex = duplex;
+
+	return 0;
 }
 
 static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
@@ -2999,17 +3008,20 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
 		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
 
-	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
-					 hdev->hw.mac.duplex, hdev->hw.mac.lane_num);
-	if (ret)
-		return ret;
-
 	if (hdev->hw.mac.support_autoneg) {
 		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
 		if (ret)
 			return ret;
 	}
 
+	if (!hdev->hw.mac.autoneg) {
+		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
+						 hdev->hw.mac.req_duplex,
+						 hdev->hw.mac.lane_num);
+		if (ret)
+			return ret;
+	}
+
 	mac->link = 0;
 
 	if (mac->user_fec_mode & BIT(HNAE3_FEC_USER_DEF)) {
@@ -11538,8 +11550,8 @@ static void hclge_reset_done(struct hnae3_ae_dev *ae_dev)
 		dev_err(&hdev->pdev->dev, "fail to rebuild, ret=%d\n", ret);
 
 	hdev->reset_type = HNAE3_NONE_RESET;
-	clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
-	up(&hdev->reset_sem);
+	if (test_and_clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		up(&hdev->reset_sem);
 }
 
 static void hclge_clear_resetting_state(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 877feee53804..61e155c4d441 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -1124,10 +1124,11 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
-		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B))) {
+		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B) ||
+			     req->mbx_src_vfid > hdev->num_req_vfs)) {
 			dev_warn(&hdev->pdev->dev,
-				 "dropped invalid mailbox message, code = %u\n",
-				 req->msg.code);
+				 "dropped invalid mailbox message, code = %u, vfid = %u\n",
+				 req->msg.code, req->mbx_src_vfid);
 
 			/* dropping/not processing this invalid message */
 			crq->desc[crq->next_to_use].flag = 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 85fb11de43a1..80079657afeb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -191,6 +191,9 @@ static void hclge_mac_adjust_link(struct net_device *netdev)
 	if (ret)
 		netdev_err(netdev, "failed to adjust link.\n");
 
+	hdev->hw.mac.req_speed = (u32)speed;
+	hdev->hw.mac.req_duplex = (u8)duplex;
+
 	ret = hclge_cfg_flowctrl(hdev);
 	if (ret)
 		netdev_err(netdev, "failed to configure flow control.\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 1f5a27fb309a..aebb104f4c29 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1764,8 +1764,8 @@ static void hclgevf_reset_done(struct hnae3_ae_dev *ae_dev)
 			 ret);
 
 	hdev->reset_type = HNAE3_NONE_RESET;
-	clear_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state);
-	up(&hdev->reset_sem);
+	if (test_and_clear_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state))
+		up(&hdev->reset_sem);
 }
 
 static u32 hclgevf_get_fw_version(struct hnae3_handle *handle)
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 3909c6a0af89..72d3b5328ebb 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -986,7 +986,7 @@ static void sun3_82586_timeout(struct net_device *dev, unsigned int txqueue)
 	{
 #ifdef DEBUG
 		printk("%s: xmitter timed out, try to restart! stat: %02x\n",dev->name,p->scb->cus);
-		printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
+		printk("%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
 		printk("%s: check, whether you set the right interrupt number!\n",dev->name);
 #endif
 		sun3_82586_close(dev);
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 818eca6aa4a4..4db4ec4b8857 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -355,9 +355,6 @@ static unsigned int ice_rx_offset(struct ice_rx_ring *rx_ring)
 {
 	if (ice_ring_uses_build_skb(rx_ring))
 		return ICE_SKB_PAD;
-	else if (ice_is_xdp_ena_vsi(rx_ring->vsi))
-		return XDP_PACKET_HEADROOM;
-
 	return 0;
 }
 
@@ -537,6 +534,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
+	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
 	err = ice_setup_rx_ctx(ring);
 	if (err) {
 		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7661e735d099..347c6c23bfc1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1818,8 +1818,8 @@ void ice_update_eth_stats(struct ice_vsi *vsi)
 void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
 {
 	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		vsi->rx_buf_len = ICE_RXBUF_2048;
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
+		vsi->rx_buf_len = ICE_RXBUF_1664;
 #if (PAGE_SIZE < 8192)
 	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
 		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
@@ -1828,11 +1828,7 @@ void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
 #endif
 	} else {
 		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-#if (PAGE_SIZE < 8192)
 		vsi->rx_buf_len = ICE_RXBUF_3072;
-#else
-		vsi->rx_buf_len = ICE_RXBUF_2048;
-#endif
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6e55861dd86f..9dbfbc90485e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7328,8 +7328,8 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
  */
 static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
 {
-	if (PAGE_SIZE >= 8192 || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
-		return ICE_RXBUF_2048 - XDP_PACKET_HEADROOM;
+	if (test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
+		return ICE_RXBUF_1664;
 	else
 		return ICE_RXBUF_3072;
 }
@@ -7362,6 +7362,12 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 				   frame_size - ICE_ETH_PKT_HDR_PAD);
 			return -EINVAL;
 		}
+	} else if (test_bit(ICE_FLAG_LEGACY_RX, pf->flags)) {
+		if (new_mtu + ICE_ETH_PKT_HDR_PAD > ICE_MAX_FRAME_LEGACY_RX) {
+			netdev_err(netdev, "Too big MTU for legacy-rx; Max is %d\n",
+				   ICE_MAX_FRAME_LEGACY_RX - ICE_ETH_PKT_HDR_PAD);
+			return -EINVAL;
+		}
 	}
 
 	/* if a reset is in progress, wait for some time for it to complete */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index bd62781191b3..6172e0daa718 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -523,8 +523,16 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 	return -ENOMEM;
 }
 
+/**
+ * ice_rx_frame_truesize
+ * @rx_ring: ptr to Rx ring
+ * @size: size
+ *
+ * calculate the truesize with taking into the account PAGE_SIZE of
+ * underlying arch
+ */
 static unsigned int
-ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, unsigned int __maybe_unused size)
+ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
 {
 	unsigned int truesize;
 
@@ -783,7 +791,6 @@ ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
 /**
  * ice_can_reuse_rx_page - Determine if page can be reused for another Rx
  * @rx_buf: buffer containing the page
- * @rx_buf_pgcnt: rx_buf page refcount pre xdp_do_redirect() call
  *
  * If page is reusable, we have a green light for calling ice_reuse_rx_page,
  * which will assign the current buffer to the buffer that next_to_alloc is
@@ -791,7 +798,7 @@ ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
  * page freed
  */
 static bool
-ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf, int rx_buf_pgcnt)
+ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
 {
 	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
 	struct page *page = rx_buf->page;
@@ -800,16 +807,15 @@ ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf, int rx_buf_pgcnt)
 	if (!dev_page_is_reusable(page))
 		return false;
 
-#if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely((rx_buf_pgcnt - pagecnt_bias) > 1))
+	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
 		return false;
-#else
+#if (PAGE_SIZE >= 8192)
 #define ICE_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_2048)
+	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
 	if (rx_buf->page_offset > ICE_LAST_OFFSET)
 		return false;
-#endif /* PAGE_SIZE < 8192) */
+#endif /* PAGE_SIZE >= 8192) */
 
 	/* If we have drained the page fragment pool we need to update
 	 * the pagecnt_bias and page count so that we fully restock the
@@ -886,24 +892,19 @@ ice_reuse_rx_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *old_buf)
  * ice_get_rx_buf - Fetch Rx buffer and synchronize data for use
  * @rx_ring: Rx descriptor ring to transact packets on
  * @size: size of buffer to add to skb
- * @rx_buf_pgcnt: rx_buf page refcount
+ * @ntc: index of next to clean element
  *
  * This function will pull an Rx buffer from the ring and synchronize it
  * for use by the CPU.
  */
 static struct ice_rx_buf *
 ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
-	       int *rx_buf_pgcnt)
+	       const unsigned int ntc)
 {
 	struct ice_rx_buf *rx_buf;
 
-	rx_buf = &rx_ring->rx_buf[rx_ring->next_to_clean];
-	*rx_buf_pgcnt =
-#if (PAGE_SIZE < 8192)
-		page_count(rx_buf->page);
-#else
-		0;
-#endif
+	rx_buf = &rx_ring->rx_buf[ntc];
+	rx_buf->pgcnt = page_count(rx_buf->page);
 	prefetchw(rx_buf->page);
 
 	if (!size)
@@ -973,7 +974,6 @@ ice_build_skb(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf,
 /**
  * ice_construct_skb - Allocate skb and populate it
  * @rx_ring: Rx descriptor ring to transact packets on
- * @rx_buf: Rx buffer to pull data from
  * @xdp: xdp_buff pointing to the data
  *
  * This function allocates an skb. It then populates it with the page
@@ -984,17 +984,15 @@ static struct sk_buff *
 ice_construct_skb(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf,
 		  struct xdp_buff *xdp)
 {
-	unsigned int metasize = xdp->data - xdp->data_meta;
 	unsigned int size = xdp->data_end - xdp->data;
 	unsigned int headlen;
 	struct sk_buff *skb;
 
 	/* prefetch first cache line of first page */
-	net_prefetch(xdp->data_meta);
+	net_prefetch(xdp->data);
 
 	/* allocate a skb to store the frags */
-	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
-			       ICE_RX_HDR_SIZE + metasize,
+	skb = __napi_alloc_skb(&rx_ring->q_vector->napi, ICE_RX_HDR_SIZE,
 			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
@@ -1006,13 +1004,8 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf,
 		headlen = eth_get_headlen(skb->dev, xdp->data, ICE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, headlen + metasize), xdp->data_meta,
-	       ALIGN(headlen + metasize, sizeof(long)));
-
-	if (metasize) {
-		skb_metadata_set(skb, metasize);
-		__skb_pull(skb, metasize);
-	}
+	memcpy(__skb_put(skb, headlen), xdp->data, ALIGN(headlen,
+							 sizeof(long)));
 
 	/* if we exhaust the linear part then add what is left as a frag */
 	size -= headlen;
@@ -1041,26 +1034,17 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf,
  * ice_put_rx_buf - Clean up used buffer and either recycle or free
  * @rx_ring: Rx descriptor ring to transact packets on
  * @rx_buf: Rx buffer to pull data from
- * @rx_buf_pgcnt: Rx buffer page count pre xdp_do_redirect()
  *
- * This function will update next_to_clean and then clean up the contents
- * of the rx_buf. It will either recycle the buffer or unmap it and free
- * the associated resources.
+ * This function will clean up the contents of the rx_buf. It will either
+ * recycle the buffer or unmap it and free the associated resources.
  */
 static void
-ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf,
-	       int rx_buf_pgcnt)
+ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
 {
-	u16 ntc = rx_ring->next_to_clean + 1;
-
-	/* fetch, update, and store next to clean */
-	ntc = (ntc < rx_ring->count) ? ntc : 0;
-	rx_ring->next_to_clean = ntc;
-
 	if (!rx_buf)
 		return;
 
-	if (ice_can_reuse_rx_page(rx_buf, rx_buf_pgcnt)) {
+	if (ice_can_reuse_rx_page(rx_buf)) {
 		/* hand second half of page back to the ring */
 		ice_reuse_rx_page(rx_ring, rx_buf);
 	} else {
@@ -1110,21 +1094,22 @@ ice_is_non_eop(struct ice_rx_ring *rx_ring, union ice_32b_rx_flex_desc *rx_desc)
  */
 int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 {
-	unsigned int total_rx_bytes = 0, total_rx_pkts = 0, frame_sz = 0;
+	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
 	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
 	unsigned int offset = rx_ring->rx_offset;
+	struct xdp_buff *xdp = &rx_ring->xdp;
 	struct ice_tx_ring *xdp_ring = NULL;
 	unsigned int xdp_res, xdp_xmit = 0;
 	struct sk_buff *skb = rx_ring->skb;
 	struct bpf_prog *xdp_prog = NULL;
-	struct xdp_buff xdp;
+	u32 ntc = rx_ring->next_to_clean;
+	u32 cnt = rx_ring->count;
 	bool failure;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
-	frame_sz = ice_rx_frame_truesize(rx_ring, 0);
+	xdp->frame_sz = ice_rx_frame_truesize(rx_ring, 0);
 #endif
-	xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog)
@@ -1137,12 +1122,11 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		unsigned char *hard_start;
 		unsigned int size;
 		u16 stat_err_bits;
-		int rx_buf_pgcnt;
 		u16 vlan_tag = 0;
 		u16 rx_ptype;
 
 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
-		rx_desc = ICE_RX_DESC(rx_ring, rx_ring->next_to_clean);
+		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
 		/* status_error_len will always be zero for unused descriptors
 		 * because it's cleared in cleanup, and overlaps with hdr_addr
@@ -1166,7 +1150,9 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			if (rx_desc->wb.rxdid == FDIR_DESC_RXDID &&
 			    ctrl_vsi->vf)
 				ice_vc_fdir_irq_handler(ctrl_vsi, rx_desc);
-			ice_put_rx_buf(rx_ring, NULL, 0);
+			if (++ntc == cnt)
+				ntc = 0;
+			ice_put_rx_buf(rx_ring, NULL);
 			cleaned_count++;
 			continue;
 		}
@@ -1175,33 +1161,33 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			ICE_RX_FLX_DESC_PKT_LEN_M;
 
 		/* retrieve a buffer from the ring */
-		rx_buf = ice_get_rx_buf(rx_ring, size, &rx_buf_pgcnt);
+		rx_buf = ice_get_rx_buf(rx_ring, size, ntc);
 
 		if (!size) {
-			xdp.data = NULL;
-			xdp.data_end = NULL;
-			xdp.data_hard_start = NULL;
-			xdp.data_meta = NULL;
+			xdp->data = NULL;
+			xdp->data_end = NULL;
+			xdp->data_hard_start = NULL;
+			xdp->data_meta = NULL;
 			goto construct_skb;
 		}
 
 		hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
 			     offset;
-		xdp_prepare_buff(&xdp, hard_start, offset, size, true);
+		xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 #if (PAGE_SIZE > 4096)
 		/* At larger PAGE_SIZE, frame_sz depend on len size */
-		xdp.frame_sz = ice_rx_frame_truesize(rx_ring, size);
+		xdp->frame_sz = ice_rx_frame_truesize(rx_ring, size);
 #endif
 
 		if (!xdp_prog)
 			goto construct_skb;
 
-		xdp_res = ice_run_xdp(rx_ring, &xdp, xdp_prog, xdp_ring);
+		xdp_res = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring);
 		if (!xdp_res)
 			goto construct_skb;
 		if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR)) {
 			xdp_xmit |= xdp_res;
-			ice_rx_buf_adjust_pg_offset(rx_buf, xdp.frame_sz);
+			ice_rx_buf_adjust_pg_offset(rx_buf, xdp->frame_sz);
 		} else {
 			rx_buf->pagecnt_bias++;
 		}
@@ -1209,16 +1195,18 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_pkts++;
 
 		cleaned_count++;
-		ice_put_rx_buf(rx_ring, rx_buf, rx_buf_pgcnt);
+		if (++ntc == cnt)
+			ntc = 0;
+		ice_put_rx_buf(rx_ring, rx_buf);
 		continue;
 construct_skb:
 		if (skb) {
 			ice_add_rx_frag(rx_ring, rx_buf, skb, size);
-		} else if (likely(xdp.data)) {
+		} else if (likely(xdp->data)) {
 			if (ice_ring_uses_build_skb(rx_ring))
-				skb = ice_build_skb(rx_ring, rx_buf, &xdp);
+				skb = ice_build_skb(rx_ring, rx_buf, xdp);
 			else
-				skb = ice_construct_skb(rx_ring, rx_buf, &xdp);
+				skb = ice_construct_skb(rx_ring, rx_buf, xdp);
 		}
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
@@ -1228,7 +1216,9 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			break;
 		}
 
-		ice_put_rx_buf(rx_ring, rx_buf, rx_buf_pgcnt);
+		if (++ntc == cnt)
+			ntc = 0;
+		ice_put_rx_buf(rx_ring, rx_buf);
 		cleaned_count++;
 
 		/* skip if it is NOP desc */
@@ -1268,6 +1258,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_pkts++;
 	}
 
+	rx_ring->next_to_clean = ntc;
 	/* return up to cleaned_count buffers to hardware */
 	failure = ice_alloc_rx_bufs(rx_ring, cleaned_count);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 932b5661ec4d..c1d9b3cebb05 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -9,10 +9,12 @@
 #define ICE_DFLT_IRQ_WORK	256
 #define ICE_RXBUF_3072		3072
 #define ICE_RXBUF_2048		2048
+#define ICE_RXBUF_1664		1664
 #define ICE_RXBUF_1536		1536
 #define ICE_MAX_CHAINED_RX_BUFS	5
 #define ICE_MAX_BUF_TXD		8
 #define ICE_MIN_TX_LEN		17
+#define ICE_MAX_FRAME_LEGACY_RX 8320
 
 /* The size limit for a transmit buffer in a descriptor is (16K - 1).
  * In order to align with the read requests we will align the value to
@@ -170,7 +172,8 @@ struct ice_rx_buf {
 	dma_addr_t dma;
 	struct page *page;
 	unsigned int page_offset;
-	u16 pagecnt_bias;
+	unsigned int pgcnt;
+	unsigned int pagecnt_bias;
 };
 
 struct ice_q_stats {
@@ -293,6 +296,7 @@ struct ice_rx_ring {
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring *xdp_ring;
 	struct xsk_buff_pool *xsk_pool;
+	struct xdp_buff xdp;
 	struct sk_buff *skb;
 	dma_addr_t dma;			/* physical address of ring */
 	u64 cached_phctime;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 7ee38d02d1e5..d137b98d78eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -349,6 +349,7 @@ int ice_xmit_xdp_buff(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring)
  * ice_finalize_xdp_rx - Bump XDP Tx tail and/or flush redirect map
  * @xdp_ring: XDP ring
  * @xdp_res: Result of the receive batch
+ * @first_idx: index to write from caller
  *
  * This function bumps XDP Tx tail and/or flush redirect map, and
  * should be called when a batch of packets has been processed in the
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index efdabcbd66dd..8187a658dcbd 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -402,6 +402,21 @@
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
 
+/* Retry Buffer Control */
+#define IGC_RETX_CTL			0x041C
+#define IGC_RETX_CTL_WATERMARK_MASK	0xF
+#define IGC_RETX_CTL_QBVFULLTH_SHIFT	8 /* QBV Retry Buffer Full Threshold */
+#define IGC_RETX_CTL_QBVFULLEN	0x1000 /* Enable QBV Retry Buffer Full Threshold */
+
+/* Transmit Scheduling Latency */
+/* Latency between transmission scheduling (LaunchTime) and the time
+ * the packet is transmitted to the network in nanosecond.
+ */
+#define IGC_TXOFFSET_SPEED_10	0x000034BC
+#define IGC_TXOFFSET_SPEED_100	0x00000578
+#define IGC_TXOFFSET_SPEED_1000	0x0000012C
+#define IGC_TXOFFSET_SPEED_2500	0x00000578
+
 /* Time Sync Interrupt Causes */
 #define IGC_TSICR_SYS_WRAP	BIT(0) /* SYSTIM Wrap around. */
 #define IGC_TSICR_TXTS		BIT(1) /* Transmit Timestamp. */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e052f49cc08d..39f8f28288aa 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5586,6 +5586,13 @@ static void igc_watchdog_task(struct work_struct *work)
 				break;
 			}
 
+			/* Once the launch time has been set on the wire, there
+			 * is a delay before the link speed can be determined
+			 * based on link-up activity. Write into the register
+			 * as soon as we know the correct link speed.
+			 */
+			igc_tsn_adjust_txtime_offset(adapter);
+
 			if (adapter->link_speed != SPEED_1000)
 				goto no_wait;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index c0d8214148d1..01c86d36856d 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -224,6 +224,7 @@
 /* Transmit Scheduling Registers */
 #define IGC_TQAVCTRL		0x3570
 #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
+#define IGC_GTXOFFSET		0x3310
 #define IGC_BASET_L		0x3314
 #define IGC_BASET_H		0x3318
 #define IGC_QBVCYCLET		0x331C
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 31ea0781b65e..abdaaf7db412 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -49,6 +49,44 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	return new_flags;
 }
 
+void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u16 txoffset;
+
+	if (!is_any_launchtime(adapter))
+		return;
+
+	switch (adapter->link_speed) {
+	case SPEED_10:
+		txoffset = IGC_TXOFFSET_SPEED_10;
+		break;
+	case SPEED_100:
+		txoffset = IGC_TXOFFSET_SPEED_100;
+		break;
+	case SPEED_1000:
+		txoffset = IGC_TXOFFSET_SPEED_1000;
+		break;
+	case SPEED_2500:
+		txoffset = IGC_TXOFFSET_SPEED_2500;
+		break;
+	default:
+		txoffset = 0;
+		break;
+	}
+
+	wr32(IGC_GTXOFFSET, txoffset);
+}
+
+static void igc_tsn_restore_retx_default(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 retxctl;
+
+	retxctl = rd32(IGC_RETX_CTL) & IGC_RETX_CTL_WATERMARK_MASK;
+	wr32(IGC_RETX_CTL, retxctl);
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -58,9 +96,13 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	u32 tqavctrl;
 	int i;
 
+	wr32(IGC_GTXOFFSET, 0);
 	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_restore_retx_default(adapter);
+
 	tqavctrl = rd32(IGC_TQAVCTRL);
 	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
 		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
@@ -81,6 +123,25 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	return 0;
 }
 
+/* To partially fix i226 HW errata, reduce MAC internal buffering from 192 Bytes
+ * to 88 Bytes by setting RETX_CTL register using the recommendation from:
+ * a) Ethernet Controller I225/I226 Specification Update Rev 2.1
+ *    Item 9: TSN: Packet Transmission Might Cross the Qbv Window
+ * b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
+ */
+static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 retxctl, watermark;
+
+	retxctl = rd32(IGC_RETX_CTL);
+	watermark = retxctl & IGC_RETX_CTL_WATERMARK_MASK;
+	/* Set QBVFULLTH value using watermark and set QBVFULLEN */
+	retxctl |= (watermark << IGC_RETX_CTL_QBVFULLTH_SHIFT) |
+		   IGC_RETX_CTL_QBVFULLEN;
+	wr32(IGC_RETX_CTL, retxctl);
+}
+
 static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -94,6 +155,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	if (igc_is_device_id_i226(hw))
+		igc_tsn_set_retx_qbvfullthreshold(adapter);
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		u32 txqctl = 0;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index 1512307f5a52..b53e6af560b7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -6,5 +6,6 @@
 
 int igc_tsn_offload_apply(struct igc_adapter *adapter);
 int igc_tsn_reset(struct igc_adapter *adapter);
+void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
 
 #endif /* _IGC_BASE_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index b226a4d376aa..160e044c25c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -632,7 +632,9 @@ int rvu_mbox_handler_cpt_inline_ipsec_cfg(struct rvu *rvu,
 	return ret;
 }
 
-static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
+static bool validate_and_update_reg_offset(struct rvu *rvu,
+					   struct cpt_rd_wr_reg_msg *req,
+					   u64 *reg_offset)
 {
 	u64 offset = req->reg_offset;
 	int blkaddr, num_lfs, lf;
@@ -663,6 +665,11 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
 		if (lf < 0)
 			return false;
 
+		/* Translate local LF's offset to global CPT LF's offset to
+		 * access LFX register.
+		 */
+		*reg_offset = (req->reg_offset & 0xFF000) + (lf << 3);
+
 		return true;
 	} else if (!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK)) {
 		/* Registers that can be accessed from PF */
@@ -697,7 +704,7 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 					struct cpt_rd_wr_reg_msg *rsp)
 {
 	u64 offset = req->reg_offset;
-	int blkaddr, lf;
+	int blkaddr;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
@@ -708,18 +715,10 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	if (!is_valid_offset(rvu, req))
+	if (!validate_and_update_reg_offset(rvu, req, &offset))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	/* Translate local LF used by VFs to global CPT LF */
-	lf = rvu_get_lf(rvu, &rvu->hw->block[blkaddr], req->hdr.pcifunc,
-			(offset & 0xFFF) >> 3);
-
-	/* Translate local LF's offset to global CPT LF's offset */
-	offset &= 0xFF000;
-	offset += lf << 3;
-
-	rsp->reg_offset = offset;
+	rsp->reg_offset = req->reg_offset;
 	rsp->ret_val = req->ret_val;
 	rsp->is_write = req->is_write;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 60bc5b577ab9..02d9fb0c5ec2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -111,7 +111,9 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 		return err;
 	}
 
+	mutex_lock(&priv->state_lock);
 	err = mlx5e_safe_reopen_channels(priv);
+	mutex_unlock(&priv->state_lock);
 	if (!err) {
 		to_ctx->status = 1; /* all channels recovered */
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index aac32e505c14..a8870c6daec6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -738,7 +738,7 @@ mlx5e_ethtool_flow_replace(struct mlx5e_priv *priv,
 	if (num_tuples <= 0) {
 		netdev_warn(priv->netdev, "%s: flow is not valid %d\n",
 			    __func__, num_tuples);
-		return num_tuples;
+		return num_tuples < 0 ? num_tuples : -EINVAL;
 	}
 
 	eth_ft = get_flow_table(priv, fs, num_tuples);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h
index 5a1027b07215..bf1a2883f082 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h
@@ -39,6 +39,7 @@
  */
 #define MLXBF_GIGE_BCAST_MAC_FILTER_IDX 0
 #define MLXBF_GIGE_LOCAL_MAC_FILTER_IDX 1
+#define MLXBF_GIGE_MAX_FILTER_IDX       3
 
 /* Define for broadcast MAC literal */
 #define BCAST_MAC_ADDR 0xFFFFFFFFFFFF
@@ -148,9 +149,13 @@ enum mlxbf_gige_res {
 int mlxbf_gige_mdio_probe(struct platform_device *pdev,
 			  struct mlxbf_gige *priv);
 void mlxbf_gige_mdio_remove(struct mlxbf_gige *priv);
-irqreturn_t mlxbf_gige_mdio_handle_phy_interrupt(int irq, void *dev_id);
-void mlxbf_gige_mdio_enable_phy_int(struct mlxbf_gige *priv);
 
+void mlxbf_gige_enable_multicast_rx(struct mlxbf_gige *priv);
+void mlxbf_gige_disable_multicast_rx(struct mlxbf_gige *priv);
+void mlxbf_gige_enable_mac_rx_filter(struct mlxbf_gige *priv,
+				     unsigned int index);
+void mlxbf_gige_disable_mac_rx_filter(struct mlxbf_gige *priv,
+				      unsigned int index);
 void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
 				  unsigned int index, u64 dmac);
 void mlxbf_gige_get_mac_rx_filter(struct mlxbf_gige *priv,
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index d6b4d163bbbf..6d90576fda59 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -168,6 +168,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	if (err)
 		goto napi_deinit;
 
+	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_BCAST_MAC_FILTER_IDX);
+	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_LOCAL_MAC_FILTER_IDX);
+	mlxbf_gige_enable_multicast_rx(priv);
+
 	/* Set bits in INT_EN that we care about */
 	int_en = MLXBF_GIGE_INT_EN_HW_ACCESS_ERROR |
 		 MLXBF_GIGE_INT_EN_TX_CHECKSUM_INPUTS |
@@ -293,6 +297,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	void __iomem *plu_base;
 	void __iomem *base;
 	int addr, phy_irq;
+	unsigned int i;
 	int err;
 
 	base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_MAC);
@@ -335,6 +340,11 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->rx_q_entries = MLXBF_GIGE_DEFAULT_RXQ_SZ;
 	priv->tx_q_entries = MLXBF_GIGE_DEFAULT_TXQ_SZ;
 
+	for (i = 0; i <= MLXBF_GIGE_MAX_FILTER_IDX; i++)
+		mlxbf_gige_disable_mac_rx_filter(priv, i);
+	mlxbf_gige_disable_multicast_rx(priv);
+	mlxbf_gige_disable_promisc(priv);
+
 	/* Write initial MAC address to hardware */
 	mlxbf_gige_initial_mac(priv);
 
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
index 7be3a793984d..d27535a1fb86 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
@@ -59,6 +59,8 @@
 #define MLXBF_GIGE_TX_STATUS_DATA_FIFO_FULL           BIT(1)
 #define MLXBF_GIGE_RX_MAC_FILTER_DMAC_RANGE_START     0x0520
 #define MLXBF_GIGE_RX_MAC_FILTER_DMAC_RANGE_END       0x0528
+#define MLXBF_GIGE_RX_MAC_FILTER_GENERAL              0x0530
+#define MLXBF_GIGE_RX_MAC_FILTER_EN_MULTICAST         BIT(1)
 #define MLXBF_GIGE_RX_MAC_FILTER_COUNT_DISC           0x0540
 #define MLXBF_GIGE_RX_MAC_FILTER_COUNT_DISC_EN        BIT(0)
 #define MLXBF_GIGE_RX_MAC_FILTER_COUNT_PASS           0x0548
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 699984358493..eb62620b63c7 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -11,15 +11,31 @@
 #include "mlxbf_gige.h"
 #include "mlxbf_gige_regs.h"
 
-void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
-				  unsigned int index, u64 dmac)
+void mlxbf_gige_enable_multicast_rx(struct mlxbf_gige *priv)
 {
 	void __iomem *base = priv->base;
-	u64 control;
+	u64 data;
 
-	/* Write destination MAC to specified MAC RX filter */
-	writeq(dmac, base + MLXBF_GIGE_RX_MAC_FILTER +
-	       (index * MLXBF_GIGE_RX_MAC_FILTER_STRIDE));
+	data = readq(base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+	data |= MLXBF_GIGE_RX_MAC_FILTER_EN_MULTICAST;
+	writeq(data, base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+}
+
+void mlxbf_gige_disable_multicast_rx(struct mlxbf_gige *priv)
+{
+	void __iomem *base = priv->base;
+	u64 data;
+
+	data = readq(base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+	data &= ~MLXBF_GIGE_RX_MAC_FILTER_EN_MULTICAST;
+	writeq(data, base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+}
+
+void mlxbf_gige_enable_mac_rx_filter(struct mlxbf_gige *priv,
+				     unsigned int index)
+{
+	void __iomem *base = priv->base;
+	u64 control;
 
 	/* Enable MAC receive filter mask for specified index */
 	control = readq(base + MLXBF_GIGE_CONTROL);
@@ -27,6 +43,28 @@ void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
 	writeq(control, base + MLXBF_GIGE_CONTROL);
 }
 
+void mlxbf_gige_disable_mac_rx_filter(struct mlxbf_gige *priv,
+				      unsigned int index)
+{
+	void __iomem *base = priv->base;
+	u64 control;
+
+	/* Disable MAC receive filter mask for specified index */
+	control = readq(base + MLXBF_GIGE_CONTROL);
+	control &= ~(MLXBF_GIGE_CONTROL_EN_SPECIFIC_MAC << index);
+	writeq(control, base + MLXBF_GIGE_CONTROL);
+}
+
+void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
+				  unsigned int index, u64 dmac)
+{
+	void __iomem *base = priv->base;
+
+	/* Write destination MAC to specified MAC RX filter */
+	writeq(dmac, base + MLXBF_GIGE_RX_MAC_FILTER +
+	       (index * MLXBF_GIGE_RX_MAC_FILTER_STRIDE));
+}
+
 void mlxbf_gige_get_mac_rx_filter(struct mlxbf_gige *priv,
 				  unsigned int index, u64 *dmac)
 {
diff --git a/drivers/net/ethernet/microsoft/mana/mana.h b/drivers/net/ethernet/microsoft/mana/mana.h
index d58be64374c8..41c99eabf40a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana.h
+++ b/drivers/net/ethernet/microsoft/mana/mana.h
@@ -262,6 +262,7 @@ struct mana_cq {
 	/* NAPI data */
 	struct napi_struct napi;
 	int work_done;
+	int work_done_since_doorbell;
 	int budget;
 };
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b751b03eddfb..e7d1ce68f05e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1311,7 +1311,6 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
-	u8 arm_bit;
 	int w;
 
 	WARN_ON_ONCE(cq->gdma_cq != gdma_queue);
@@ -1322,16 +1321,23 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 		mana_poll_tx_cq(cq);
 
 	w = cq->work_done;
-
-	if (w < cq->budget &&
-	    napi_complete_done(&cq->napi, w)) {
-		arm_bit = SET_ARM_BIT;
-	} else {
-		arm_bit = 0;
+	cq->work_done_since_doorbell += w;
+
+	if (w < cq->budget) {
+		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
+		cq->work_done_since_doorbell = 0;
+		napi_complete_done(&cq->napi, w);
+	} else if (cq->work_done_since_doorbell >
+		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
+		/* MANA hardware requires at least one doorbell ring every 8
+		 * wraparounds of CQ even if there is no need to arm the CQ.
+		 * This driver rings the doorbell as soon as we have exceeded
+		 * 4 wraparounds.
+		 */
+		mana_gd_ring_cq(gdma_queue, 0);
+		cq->work_done_since_doorbell = 0;
 	}
 
-	mana_gd_ring_cq(gdma_queue, arm_bit);
-
 	return w;
 }
 
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 01b6e13f4692..310a36356f56 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -994,6 +994,48 @@ void ocelot_ptp_rx_timestamp(struct ocelot *ocelot, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(ocelot_ptp_rx_timestamp);
 
+void ocelot_lock_inj_grp(struct ocelot *ocelot, int grp)
+			 __acquires(&ocelot->inj_lock)
+{
+	spin_lock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_lock_inj_grp);
+
+void ocelot_unlock_inj_grp(struct ocelot *ocelot, int grp)
+			   __releases(&ocelot->inj_lock)
+{
+	spin_unlock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_unlock_inj_grp);
+
+void ocelot_lock_xtr_grp(struct ocelot *ocelot, int grp)
+			 __acquires(&ocelot->inj_lock)
+{
+	spin_lock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_lock_xtr_grp);
+
+void ocelot_unlock_xtr_grp(struct ocelot *ocelot, int grp)
+			   __releases(&ocelot->inj_lock)
+{
+	spin_unlock(&ocelot->inj_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_unlock_xtr_grp);
+
+void ocelot_lock_xtr_grp_bh(struct ocelot *ocelot, int grp)
+			    __acquires(&ocelot->xtr_lock)
+{
+	spin_lock_bh(&ocelot->xtr_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_lock_xtr_grp_bh);
+
+void ocelot_unlock_xtr_grp_bh(struct ocelot *ocelot, int grp)
+			      __releases(&ocelot->xtr_lock)
+{
+	spin_unlock_bh(&ocelot->xtr_lock);
+}
+EXPORT_SYMBOL_GPL(ocelot_unlock_xtr_grp_bh);
+
 int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **nskb)
 {
 	u64 timestamp, src_port, len;
@@ -1004,6 +1046,8 @@ int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **nskb)
 	u32 val, *buf;
 	int err;
 
+	lockdep_assert_held(&ocelot->xtr_lock);
+
 	err = ocelot_xtr_poll_xfh(ocelot, grp, xfh);
 	if (err)
 		return err;
@@ -1079,6 +1123,8 @@ bool ocelot_can_inject(struct ocelot *ocelot, int grp)
 {
 	u32 val = ocelot_read(ocelot, QS_INJ_STATUS);
 
+	lockdep_assert_held(&ocelot->inj_lock);
+
 	if (!(val & QS_INJ_STATUS_FIFO_RDY(BIT(grp))))
 		return false;
 	if (val & QS_INJ_STATUS_WMARK_REACHED(BIT(grp)))
@@ -1088,28 +1134,55 @@ bool ocelot_can_inject(struct ocelot *ocelot, int grp)
 }
 EXPORT_SYMBOL(ocelot_can_inject);
 
-void ocelot_ifh_port_set(void *ifh, int port, u32 rew_op, u32 vlan_tag)
+/**
+ * ocelot_ifh_set_basic - Set basic information in Injection Frame Header
+ * @ifh: Pointer to Injection Frame Header memory
+ * @ocelot: Switch private data structure
+ * @port: Egress port number
+ * @rew_op: Egress rewriter operation for PTP
+ * @skb: Pointer to socket buffer (packet)
+ *
+ * Populate the Injection Frame Header with basic information for this skb: the
+ * analyzer bypass bit, destination port, VLAN info, egress rewriter info.
+ */
+void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
+			  u32 rew_op, struct sk_buff *skb)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct net_device *dev = skb->dev;
+	u64 vlan_tci, tag_type;
+	int qos_class;
+
+	ocelot_xmit_get_vlan_info(skb, ocelot_port->bridge, &vlan_tci,
+				  &tag_type);
+
+	qos_class = netdev_get_num_tc(dev) ?
+		    netdev_get_prio_tc_map(dev, skb->priority) : skb->priority;
+
+	memset(ifh, 0, OCELOT_TAG_LEN);
 	ocelot_ifh_set_bypass(ifh, 1);
+	ocelot_ifh_set_src(ifh, BIT_ULL(ocelot->num_phys_ports));
 	ocelot_ifh_set_dest(ifh, BIT_ULL(port));
-	ocelot_ifh_set_tag_type(ifh, IFH_TAG_TYPE_C);
-	if (vlan_tag)
-		ocelot_ifh_set_vlan_tci(ifh, vlan_tag);
+	ocelot_ifh_set_qos_class(ifh, qos_class);
+	ocelot_ifh_set_tag_type(ifh, tag_type);
+	ocelot_ifh_set_vlan_tci(ifh, vlan_tci);
 	if (rew_op)
 		ocelot_ifh_set_rew_op(ifh, rew_op);
 }
-EXPORT_SYMBOL(ocelot_ifh_port_set);
+EXPORT_SYMBOL(ocelot_ifh_set_basic);
 
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb)
 {
-	u32 ifh[OCELOT_TAG_LEN / 4] = {0};
+	u32 ifh[OCELOT_TAG_LEN / 4];
 	unsigned int i, count, last;
 
+	lockdep_assert_held(&ocelot->inj_lock);
+
 	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
 			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
 
-	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));
+	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	for (i = 0; i < OCELOT_TAG_LEN / 4; i++)
 		ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
@@ -1142,6 +1215,8 @@ EXPORT_SYMBOL(ocelot_port_inject_frame);
 
 void ocelot_drain_cpu_queue(struct ocelot *ocelot, int grp)
 {
+	lockdep_assert_held(&ocelot->xtr_lock);
+
 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp))
 		ocelot_read_rix(ocelot, QS_XTR_RD, grp);
 }
@@ -2733,6 +2808,8 @@ int ocelot_init(struct ocelot *ocelot)
 	mutex_init(&ocelot->tas_lock);
 	spin_lock_init(&ocelot->ptp_clock_lock);
 	spin_lock_init(&ocelot->ts_id_lock);
+	spin_lock_init(&ocelot->inj_lock);
+	spin_lock_init(&ocelot->xtr_lock);
 
 	ocelot->owq = alloc_ordered_workqueue("ocelot-owq", 0);
 	if (!ocelot->owq)
diff --git a/drivers/net/ethernet/mscc/ocelot_fdma.c b/drivers/net/ethernet/mscc/ocelot_fdma.c
index 8e3894cf5f7c..cc9bce5a4dcd 100644
--- a/drivers/net/ethernet/mscc/ocelot_fdma.c
+++ b/drivers/net/ethernet/mscc/ocelot_fdma.c
@@ -665,8 +665,7 @@ static int ocelot_fdma_prepare_skb(struct ocelot *ocelot, int port, u32 rew_op,
 
 	ifh = skb_push(skb, OCELOT_TAG_LEN);
 	skb_put(skb, ETH_FCS_LEN);
-	memset(ifh, 0, OCELOT_TAG_LEN);
-	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));
+	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 6f22aea08a64..bf39a053dc82 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -159,6 +159,8 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 	struct ocelot *ocelot = arg;
 	int grp = 0, err;
 
+	ocelot_lock_xtr_grp(ocelot, grp);
+
 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {
 		struct sk_buff *skb;
 
@@ -177,6 +179,8 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 	if (err < 0)
 		ocelot_drain_cpu_queue(ocelot, 0);
 
+	ocelot_unlock_xtr_grp(ocelot, grp);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 6370c447ac5c..503c32413474 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -159,16 +159,17 @@
 #define XAE_RCW1_OFFSET		0x00000404 /* Rx Configuration Word 1 */
 #define XAE_TC_OFFSET		0x00000408 /* Tx Configuration */
 #define XAE_FCC_OFFSET		0x0000040C /* Flow Control Configuration */
-#define XAE_EMMC_OFFSET		0x00000410 /* EMAC mode configuration */
-#define XAE_PHYC_OFFSET		0x00000414 /* RGMII/SGMII configuration */
+#define XAE_EMMC_OFFSET		0x00000410 /* MAC speed configuration */
+#define XAE_PHYC_OFFSET		0x00000414 /* RX Max Frame Configuration */
 #define XAE_ID_OFFSET		0x000004F8 /* Identification register */
-#define XAE_MDIO_MC_OFFSET	0x00000500 /* MII Management Config */
-#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MII Management Control */
-#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MII Management Write Data */
-#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MII Management Read Data */
+#define XAE_MDIO_MC_OFFSET	0x00000500 /* MDIO Setup */
+#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MDIO Control */
+#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MDIO Write Data */
+#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MDIO Read Data */
 #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
 #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
-#define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
+#define XAE_FMI_OFFSET		0x00000708 /* Frame Filter Control */
+#define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
 
@@ -307,7 +308,7 @@
  */
 #define XAE_UAW1_UNICASTADDR_MASK	0x0000FFFF
 
-/* Bit masks for Axi Ethernet FMI register */
+/* Bit masks for Axi Ethernet FMC register */
 #define XAE_FMI_PM_MASK			0x80000000 /* Promis. mode enable */
 #define XAE_FMI_IND_MASK		0x00000003 /* Index Mask */
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ff777735be66..59d1cfbf7d6b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -411,7 +411,7 @@ static int netdev_set_mac_address(struct net_device *ndev, void *p)
  */
 static void axienet_set_multicast_list(struct net_device *ndev)
 {
-	int i;
+	int i = 0;
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
@@ -429,7 +429,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
-		i = 0;
+		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+		reg &= ~XAE_FMI_PM_MASK;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
 				break;
@@ -448,6 +451,7 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			axienet_iow(lp, XAE_FMI_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
+			axienet_iow(lp, XAE_FFE_OFFSET, 1);
 			i++;
 		}
 	} else {
@@ -455,18 +459,15 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-
-		for (i = 0; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
-			reg |= i;
-
-			axienet_iow(lp, XAE_FMI_OFFSET, reg);
-			axienet_iow(lp, XAE_AF0_OFFSET, 0);
-			axienet_iow(lp, XAE_AF1_OFFSET, 0);
-		}
-
 		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
+
+	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
+		reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+		reg |= i;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_FFE_OFFSET, 0);
+	}
 }
 
 /**
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 05b5914d8358..512daeb14e28 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -900,6 +900,9 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto tx_err;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	skb_reset_inner_headers(skb);
 
 	/* PDP context lookups in gtp_build_skb_*() need rcu read-side lock. */
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ce2cbb5903d7..c6f44af35889 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -1007,26 +1007,21 @@ static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
 	struct sk_buff *skb;
 	int error = 0;
 
-	if (sk->sk_state & PPPOX_BOUND) {
-		error = -EIO;
-		goto end;
-	}
+	if (sk->sk_state & PPPOX_BOUND)
+		return -EIO;
 
 	skb = skb_recv_datagram(sk, flags, &error);
-	if (error < 0)
-		goto end;
+	if (!skb)
+		return error;
 
-	if (skb) {
-		total_len = min_t(size_t, total_len, skb->len);
-		error = skb_copy_datagram_msg(skb, 0, m, total_len);
-		if (error == 0) {
-			consume_skb(skb);
-			return total_len;
-		}
+	total_len = min_t(size_t, total_len, skb->len);
+	error = skb_copy_datagram_msg(skb, 0, m, total_len);
+	if (error == 0) {
+		consume_skb(skb);
+		return total_len;
 	}
 
 	kfree_skb(skb);
-end:
 	return error;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 607e07ed2477..7d4340c56628 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -163,7 +163,11 @@ static int iwl_dbgfs_enabled_severities_write(struct iwl_fw_runtime *fwrt,
 
 	event_cfg.enabled_severities = cpu_to_le32(enabled_severities);
 
-	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+	if (fwrt->ops && fwrt->ops->send_hcmd)
+		ret = fwrt->ops->send_hcmd(fwrt->ops_ctx, &hcmd);
+	else
+		ret = -EPERM;
+
 	IWL_INFO(fwrt,
 		 "sent host event cfg with enabled_severities: %u, ret: %d\n",
 		 enabled_severities, ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 069bac72117f..b58441c2af73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3226,7 +3226,7 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	if (!(mvm->scan_status & type))
 		return 0;
 
-	if (iwl_mvm_is_radio_killed(mvm)) {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
 		ret = 0;
 		goto out;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 54ab8b54369b..4ab3a14567b6 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -33,7 +33,7 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifiex_private *priv,
 		skb_trim(skb, le16_to_cpu(local_rx_pd->rx_pkt_length));
 
 		ieee80211_amsdu_to_8023s(skb, &list, priv->curr_addr,
-					 priv->wdev.iftype, 0, NULL, NULL);
+					 priv->wdev.iftype, 0, NULL, NULL, false);
 
 		while (!skb_queue_empty(&list)) {
 			struct rx_packet_hdr *rx_hdr;
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index 6894b919ff94..e16e9ae90d20 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1166,7 +1166,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 		size_t ies_len = skb->len - (ies - (u8 *)(skb->data));
 
 		tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies, ies_len);
-		if (tim_ie) {
+		if (tim_ie && tim_ie[1] >= sizeof(struct ieee80211_tim_ie)) {
 			struct ieee80211_tim_ie *tim =
 				(struct ieee80211_tim_ie *)&tim_ie[2];
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1aff793a1d77..0729ab543072 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1366,8 +1366,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1496,6 +1498,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..a6d55ebb8238 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -473,12 +473,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 	return 0;
 
 out_free:
-	while (--i >= 0) {
-		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
-		list_del(&rsp->free_list);
-		nvmet_rdma_free_rsp(ndev, rsp);
-	}
+	while (--i >= 0)
+		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
 out:
 	return ret;
@@ -489,12 +485,8 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 	struct nvmet_rdma_device *ndev = queue->dev;
 	int i, nr_rsps = queue->recv_queue_size * 2;
 
-	for (i = 0; i < nr_rsps; i++) {
-		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
-		list_del(&rsp->free_list);
-		nvmet_rdma_free_rsp(ndev, rsp);
-	}
+	for (i = 0; i < nr_rsps; i++)
+		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
 }
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5556f5588041..76b9eb438268 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -836,6 +836,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
 		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
 	}
 
 	if (icreq->pfv != NVME_TCP_PFV_1_0) {
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index bff454d46255..6ee1f3db81d0 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -211,7 +211,7 @@ const char *nvmet_trace_disk_name(struct trace_seq *p, char *name)
 	return ret;
 }
 
-const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl)
+const char *nvmet_trace_ctrl_id(struct trace_seq *p, u16 ctrl_id)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
 
@@ -224,8 +224,8 @@ const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl)
 	 * If we can know the extra data of the connect command in this stage,
 	 * we can update this print statement later.
 	 */
-	if (ctrl)
-		trace_seq_printf(p, "%d", ctrl->cntlid);
+	if (ctrl_id)
+		trace_seq_printf(p, "%d", ctrl_id);
 	else
 		trace_seq_printf(p, "_");
 	trace_seq_putc(p, 0);
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 974d99d47f51..7f7ebf9558e5 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -32,18 +32,24 @@ const char *nvmet_trace_parse_fabrics_cmd(struct trace_seq *p, u8 fctype,
 	 nvmet_trace_parse_nvm_cmd(p, opcode, cdw10) :			\
 	 nvmet_trace_parse_admin_cmd(p, opcode, cdw10)))
 
-const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl);
-#define __print_ctrl_name(ctrl)				\
-	nvmet_trace_ctrl_name(p, ctrl)
+const char *nvmet_trace_ctrl_id(struct trace_seq *p, u16 ctrl_id);
+#define __print_ctrl_id(ctrl_id)			\
+	nvmet_trace_ctrl_id(p, ctrl_id)
 
 const char *nvmet_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
 	nvmet_trace_disk_name(p, name)
 
 #ifndef TRACE_HEADER_MULTI_READ
-static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
+static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
 {
-	return req->sq->ctrl;
+	/*
+	 * The queue and controller pointers are not valid until an association
+	 * has been established.
+	 */
+	if (!req->sq || !req->sq->ctrl)
+		return 0;
+	return req->sq->ctrl->cntlid;
 }
 
 static inline void __assign_req_name(char *name, struct nvmet_req *req)
@@ -62,7 +68,7 @@ TRACE_EVENT(nvmet_req_init,
 	TP_ARGS(req, cmd),
 	TP_STRUCT__entry(
 		__field(struct nvme_command *, cmd)
-		__field(struct nvmet_ctrl *, ctrl)
+		__field(u16, ctrl_id)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, qid)
 		__field(u16, cid)
@@ -75,7 +81,7 @@ TRACE_EVENT(nvmet_req_init,
 	),
 	TP_fast_assign(
 		__entry->cmd = cmd;
-		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
 		__assign_req_name(__entry->disk, req);
 		__entry->qid = req->sq->qid;
 		__entry->cid = cmd->common.command_id;
@@ -89,7 +95,7 @@ TRACE_EVENT(nvmet_req_init,
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
 		  "meta=%#llx, cmd=(%s, %s)",
-		__print_ctrl_name(__entry->ctrl),
+		__print_ctrl_id(__entry->ctrl_id),
 		__print_disk_name(__entry->disk),
 		__entry->qid, __entry->cid, __entry->nsid,
 		__entry->flags, __entry->metadata,
@@ -103,7 +109,7 @@ TRACE_EVENT(nvmet_req_complete,
 	TP_PROTO(struct nvmet_req *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__field(struct nvmet_ctrl *, ctrl)
+		__field(u16, ctrl_id)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, qid)
 		__field(int, cid)
@@ -111,7 +117,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__field(u16, status)
 	),
 	TP_fast_assign(
-		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
 		__entry->qid = req->cq->qid;
 		__entry->cid = req->cqe->command_id;
 		__entry->result = le64_to_cpu(req->cqe->result.u64);
@@ -119,7 +125,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__assign_req_name(__entry->disk, req);
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
-		__print_ctrl_name(__entry->ctrl),
+		__print_ctrl_id(__entry->ctrl_id),
 		__print_disk_name(__entry->disk),
 		__entry->qid, __entry->cid, __entry->result, __entry->status)
 
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 30cea324ff95..a6a8f4b1836a 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1354,7 +1354,8 @@ void ssam_controller_destroy(struct ssam_controller *ctrl)
 	if (ctrl->state == SSAM_CONTROLLER_UNINITIALIZED)
 		return;
 
-	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED);
+	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED &&
+		ctrl->state != SSAM_CONTROLLER_INITIALIZED);
 
 	/*
 	 * Note: New events could still have been received after the previous
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 2e1dc91bfc76..5704981d1848 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -715,7 +715,7 @@ static int acpi_add(struct acpi_device *device)
 		default:
 			year = 2019;
 		}
-	pr_info("product: %s  year: %d\n", product, year);
+	pr_info("product: %s  year: %d\n", product ?: "unknown", year);
 
 	if (year >= 2019)
 		battery_limit_use_wmbb = 1;
diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index d43acd3920ed..108eced8f003 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -99,6 +99,8 @@ static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *ala
 		if (flags < 0)
 			return flags;
 		*alarm_enable = flags & NCT3018Y_BIT_AIE;
+		dev_dbg(&client->dev, "%s:alarm_enable:%x\n", __func__, *alarm_enable);
+
 	}
 
 	if (alarm_flag) {
@@ -107,11 +109,9 @@ static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *ala
 		if (flags < 0)
 			return flags;
 		*alarm_flag = flags & NCT3018Y_BIT_AF;
+		dev_dbg(&client->dev, "%s:alarm_flag:%x\n", __func__, *alarm_flag);
 	}
 
-	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
-		__func__, *alarm_enable, *alarm_flag);
-
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 341d65acd715..4250671e4400 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1597,9 +1597,15 @@ static int dasd_ese_needs_format(struct dasd_block *block, struct irb *irb)
 	if (!sense)
 		return 0;
 
-	return !!(sense[1] & SNS1_NO_REC_FOUND) ||
-		!!(sense[1] & SNS1_FILE_PROTECTED) ||
-		scsw_cstat(&irb->scsw) == SCHN_STAT_INCORR_LEN;
+	if (sense[1] & SNS1_NO_REC_FOUND)
+		return 1;
+
+	if ((sense[1] & SNS1_INV_TRACK_FORMAT) &&
+	    scsw_is_tm(&irb->scsw) &&
+	    !(sense[2] & SNS2_ENV_DATA_PRESENT))
+		return 1;
+
+	return 0;
 }
 
 static int dasd_ese_oos_cond(u8 *sense)
@@ -1620,7 +1626,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	struct dasd_device *device;
 	unsigned long now;
 	int nrf_suppressed = 0;
-	int fp_suppressed = 0;
+	int it_suppressed = 0;
 	struct request *req;
 	u8 *sense = NULL;
 	int expires;
@@ -1675,8 +1681,9 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		 */
 		sense = dasd_get_sense(irb);
 		if (sense) {
-			fp_suppressed = (sense[1] & SNS1_FILE_PROTECTED) &&
-				test_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
+			it_suppressed =	(sense[1] & SNS1_INV_TRACK_FORMAT) &&
+				!(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+				test_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 			nrf_suppressed = (sense[1] & SNS1_NO_REC_FOUND) &&
 				test_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 
@@ -1691,7 +1698,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 				return;
 			}
 		}
-		if (!(fp_suppressed || nrf_suppressed))
+		if (!(it_suppressed || nrf_suppressed))
 			device->discipline->dump_sense_dbf(device, irb, "int");
 
 		if (device->features & DASD_FEATURE_ERPLOG)
@@ -2452,14 +2459,17 @@ static int _dasd_sleep_on_queue(struct list_head *ccw_queue, int interruptible)
 	rc = 0;
 	list_for_each_entry_safe(cqr, n, ccw_queue, blocklist) {
 		/*
-		 * In some cases the 'File Protected' or 'Incorrect Length'
-		 * error might be expected and error recovery would be
-		 * unnecessary in these cases.	Check if the according suppress
-		 * bit is set.
+		 * In some cases certain errors might be expected and
+		 * error recovery would be unnecessary in these cases.
+		 * Check if the according suppress bit is set.
 		 */
 		sense = dasd_get_sense(&cqr->irb);
-		if (sense && sense[1] & SNS1_FILE_PROTECTED &&
-		    test_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags))
+		if (sense && (sense[1] & SNS1_INV_TRACK_FORMAT) &&
+		    !(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+		    test_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags))
+			continue;
+		if (sense && (sense[1] & SNS1_NO_REC_FOUND) &&
+		    test_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags))
 			continue;
 		if (scsw_cstat(&cqr->irb.scsw) == 0x40 &&
 		    test_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags))
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 91cb9d52a425..b96044fb1a3a 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1406,14 +1406,8 @@ dasd_3990_erp_file_prot(struct dasd_ccw_req * erp)
 
 	struct dasd_device *device = erp->startdev;
 
-	/*
-	 * In some cases the 'File Protected' error might be expected and
-	 * log messages shouldn't be written then.
-	 * Check if the according suppress bit is set.
-	 */
-	if (!test_bit(DASD_CQR_SUPPRESS_FP, &erp->flags))
-		dev_err(&device->cdev->dev,
-			"Accessing the DASD failed because of a hardware error\n");
+	dev_err(&device->cdev->dev,
+		"Accessing the DASD failed because of a hardware error\n");
 
 	return dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index f956a4ac9881..5802aead09f3 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -639,7 +639,6 @@ static void dasd_diag_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 }
 
 static int dasd_diag_pe_handler(struct dasd_device *device,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index c5619751a065..67f04f0b3817 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2288,6 +2288,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
 	set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+	set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 
 	return cqr;
 }
@@ -2569,7 +2570,6 @@ dasd_eckd_build_check_tcw(struct dasd_device *base, struct format_data_t *fdata,
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
-	set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
 	set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 
 	return cqr;
@@ -4145,8 +4145,6 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 	}
 
@@ -4648,9 +4646,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+		set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 	}
 
 	return cqr;
@@ -5821,36 +5818,32 @@ static void dasd_eckd_dump_sense(struct dasd_device *device,
 {
 	u8 *sense = dasd_get_sense(irb);
 
-	if (scsw_is_tm(&irb->scsw)) {
-		/*
-		 * In some cases the 'File Protected' or 'Incorrect Length'
-		 * error might be expected and log messages shouldn't be written
-		 * then. Check if the according suppress bit is set.
-		 */
-		if (sense && (sense[1] & SNS1_FILE_PROTECTED) &&
-		    test_bit(DASD_CQR_SUPPRESS_FP, &req->flags))
-			return;
-		if (scsw_cstat(&irb->scsw) == 0x40 &&
-		    test_bit(DASD_CQR_SUPPRESS_IL, &req->flags))
-			return;
+	/*
+	 * In some cases certain errors might be expected and
+	 * log messages shouldn't be written then.
+	 * Check if the according suppress bit is set.
+	 */
+	if (sense && (sense[1] & SNS1_INV_TRACK_FORMAT) &&
+	    !(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+	    test_bit(DASD_CQR_SUPPRESS_IT, &req->flags))
+		return;
 
-		dasd_eckd_dump_sense_tcw(device, req, irb);
-	} else {
-		/*
-		 * In some cases the 'Command Reject' or 'No Record Found'
-		 * error might be expected and log messages shouldn't be
-		 * written then. Check if the according suppress bit is set.
-		 */
-		if (sense && sense[0] & SNS0_CMD_REJECT &&
-		    test_bit(DASD_CQR_SUPPRESS_CR, &req->flags))
-			return;
+	if (sense && sense[0] & SNS0_CMD_REJECT &&
+	    test_bit(DASD_CQR_SUPPRESS_CR, &req->flags))
+		return;
 
-		if (sense && sense[1] & SNS1_NO_REC_FOUND &&
-		    test_bit(DASD_CQR_SUPPRESS_NRF, &req->flags))
-			return;
+	if (sense && sense[1] & SNS1_NO_REC_FOUND &&
+	    test_bit(DASD_CQR_SUPPRESS_NRF, &req->flags))
+		return;
 
+	if (scsw_cstat(&irb->scsw) == 0x40 &&
+	    test_bit(DASD_CQR_SUPPRESS_IL, &req->flags))
+		return;
+
+	if (scsw_is_tm(&irb->scsw))
+		dasd_eckd_dump_sense_tcw(device, req, irb);
+	else
 		dasd_eckd_dump_sense_ccw(device, req, irb);
-	}
 }
 
 static int dasd_eckd_reload_device(struct dasd_device *device)
@@ -6896,7 +6889,6 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 }
 
 static struct ccw_driver dasd_eckd_driver = {
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 00bcd177264a..7823e6c06e29 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -225,7 +225,7 @@ struct dasd_ccw_req {
  * The following flags are used to suppress output of certain errors.
  */
 #define DASD_CQR_SUPPRESS_NRF	4	/* Suppress 'No Record Found' error */
-#define DASD_CQR_SUPPRESS_FP	5	/* Suppress 'File Protected' error*/
+#define DASD_CQR_SUPPRESS_IT	5	/* Suppress 'Invalid Track' error*/
 #define DASD_CQR_SUPPRESS_IL	6	/* Suppress 'Incorrect Length' error */
 #define DASD_CQR_SUPPRESS_CR	7	/* Suppress 'Command Reject' error */
 
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 45f9c0736be4..e5f28370a903 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -16,20 +16,21 @@ struct idset {
 	unsigned long bitmap[];
 };
 
-static inline unsigned long bitmap_size(int num_ssid, int num_id)
+static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
 {
-	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
+	return bitmap_size(size_mul(num_ssid, num_id));
 }
 
 static struct idset *idset_new(int num_ssid, int num_id)
 {
 	struct idset *set;
 
-	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
+	set = vmalloc(sizeof(struct idset) +
+		      idset_bitmap_size(num_ssid, num_id));
 	if (set) {
 		set->num_ssid = num_ssid;
 		set->num_id = num_id;
-		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
+		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
 	}
 	return set;
 }
@@ -41,7 +42,8 @@ void idset_free(struct idset *set)
 
 void idset_fill(struct idset *set)
 {
-	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
+	memset(set->bitmap, 0xff,
+	       idset_bitmap_size(set->num_ssid, set->num_id));
 }
 
 static inline void idset_add(struct idset *set, int ssid, int id)
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 47b8102a7063..587e3c2f7c48 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -7596,7 +7596,7 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 	struct lpfc_sglq *sglq_entry = NULL;
 	struct lpfc_sglq *sglq_entry_next = NULL;
 	struct lpfc_sglq *sglq_entry_first = NULL;
-	int status, total_cnt;
+	int status = 0, total_cnt;
 	int post_cnt = 0, num_posted = 0, block_cnt = 0;
 	int last_xritag = NO_XRI;
 	LIST_HEAD(prep_sgl_list);
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index f569cf0095c2..a95a35635c33 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -677,10 +677,10 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 	for (r = 0; r < retries; r++) {
 		result = spi_execute(sdev, spi_write_buffer, DMA_TO_DEVICE,
 				     buffer, len, &sshdr);
-		if(result || !scsi_device_online(sdev)) {
+		if (result || !scsi_device_online(sdev)) {
 
 			scsi_device_set_state(sdev, SDEV_QUIESCE);
-			if (scsi_sense_valid(&sshdr)
+			if (result > 0 && scsi_sense_valid(&sshdr)
 			    && sshdr.sense_key == ILLEGAL_REQUEST
 			    /* INVALID FIELD IN CDB */
 			    && sshdr.asc == 0x24 && sshdr.ascq == 0x00)
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
index 4d235c8c4924..46c47f645faf 100644
--- a/drivers/soc/imx/imx93-pd.c
+++ b/drivers/soc/imx/imx93-pd.c
@@ -20,6 +20,7 @@
 #define FUNC_STAT_PSW_STAT_MASK		BIT(0)
 #define FUNC_STAT_RST_STAT_MASK		BIT(2)
 #define FUNC_STAT_ISO_STAT_MASK		BIT(4)
+#define FUNC_STAT_SSAR_STAT_MASK	BIT(8)
 
 struct imx93_power_domain {
 	struct generic_pm_domain genpd;
@@ -50,7 +51,7 @@ static int imx93_pd_on(struct generic_pm_domain *genpd)
 	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
 
 	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
-				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
+				 !(val & FUNC_STAT_SSAR_STAT_MASK), 1, 10000);
 	if (ret) {
 		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
 		return ret;
@@ -72,7 +73,7 @@ static int imx93_pd_off(struct generic_pm_domain *genpd)
 	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
 
 	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
-				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
+				 val & FUNC_STAT_PSW_STAT_MASK, 1, 10000);
 	if (ret) {
 		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
 		return ret;
diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 8a93c83cb6f8..d52e91258e98 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -837,7 +837,7 @@ static u32 clkfactor_f6_resolve(u32 v)
 	case SSB_CHIPCO_CLK_F6_7:
 		return 7;
 	}
-	return 0;
+	return 1;
 }
 
 /* Calculate the speed the backplane would run at a given set of clockcontrol values */
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 636c45b12843..afe89c91c89e 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -657,9 +657,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
 
 	spi_set_drvdata(spi, indio_dev);
 
@@ -670,6 +667,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_gpios(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 9fb118e77a1f..f1d44e4955fc 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -395,9 +395,9 @@ int ks_wlan_hw_tx(struct ks_wlan_private *priv, void *p, unsigned long size,
 	priv->hostt.buff[priv->hostt.qtail] = le16_to_cpu(hdr->event);
 	priv->hostt.qtail = (priv->hostt.qtail + 1) % SME_EVENT_BUFF_SIZE;
 
-	spin_lock(&priv->tx_dev.tx_dev_lock);
+	spin_lock_bh(&priv->tx_dev.tx_dev_lock);
 	result = enqueue_txdev(priv, p, size, complete_handler, skb);
-	spin_unlock(&priv->tx_dev.tx_dev_lock);
+	spin_unlock_bh(&priv->tx_dev.tx_dev_lock);
 
 	if (txq_has_space(priv))
 		queue_delayed_work(priv->wq, &priv->rw_dwork, 0);
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index d3058ede5306..3c2035fc9cee 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -3086,6 +3086,7 @@ void tb_switch_remove(struct tb_switch *sw)
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 		} else if (port->xdomain) {
+			port->xdomain->is_unplugged = true;
 			tb_xdomain_remove(port->xdomain);
 			port->xdomain = NULL;
 		}
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index fbce8ef205ce..6a9310379dc2 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2539,7 +2539,7 @@ static const struct uart_ops atmel_pops = {
 };
 
 static const struct serial_rs485 atmel_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 94bc7786a3c4..4964fa7419ef 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -506,6 +506,13 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 {
 	struct dwc3_event_buffer *evt;
+	unsigned int hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		dwc->ev_buf = NULL;
+		return 0;
+	}
 
 	evt = dwc3_alloc_one_event_buffer(dwc, length);
 	if (IS_ERR(evt)) {
@@ -527,6 +534,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return 0;
+
 	evt = dwc->ev_buf;
 	evt->lpos = 0;
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
@@ -544,6 +554,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return;
+
 	evt = dwc->ev_buf;
 
 	evt->lpos = 0;
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index a67873a074b7..c1a62ebd78d6 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2487,7 +2487,7 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	/* setup the udc->eps[] for non-control endpoints and link
 	 * to gadget.ep_list */
 	for (i = 1; i < (int)(udc_controller->max_ep / 2); i++) {
-		char name[14];
+		char name[16];
 
 		sprintf(name, "ep%dout", i);
 		struct_ep_setup(udc_controller, i * 2, name, 1);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 505f45429c12..ec2f6bedf003 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2971,7 +2971,7 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 		return -ENOMEM;
 	}
-	if ((xhci->quirks & XHCI_SW_BW_CHECKING) &&
+	if ((xhci->quirks & XHCI_SW_BW_CHECKING) && !ctx_change &&
 	    xhci_reserve_bandwidth(xhci, virt_dev, command->in_ctx)) {
 		if ((xhci->quirks & XHCI_EP_LIMIT_QUIRK))
 			xhci_free_host_resources(xhci, ctrl_ctx);
@@ -4313,8 +4313,10 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		mutex_unlock(&xhci->mutex);
 		ret = xhci_disable_slot(xhci, udev->slot_id);
 		xhci_free_virt_device(xhci, udev->slot_id);
-		if (!ret)
-			xhci_alloc_dev(hcd, udev);
+		if (!ret) {
+			if (xhci_alloc_dev(hcd, udev) == 1)
+				xhci_setup_addressable_virt_dev(xhci, udev);
+		}
 		kfree(command->completion);
 		kfree(command);
 		return -EPROTO;
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 91001990e351..6f0a9851b092 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -355,7 +355,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 			par->cmap_type = cmap_gxt2000;
 	} else if (of_node_name_prefix(dp, "vga,Display-")) {
 		/* Look for AVIVO initialized by SLOF */
-		struct device_node *pciparent = of_get_parent(dp);
+		struct device_node *pciparent __free(device_node) = of_get_parent(dp);
 		const u32 *vid, *did;
 		vid = of_get_property(pciparent, "vendor-id", NULL);
 		did = of_get_property(pciparent, "device-id", NULL);
@@ -367,7 +367,6 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 			if (par->cmap_adr)
 				par->cmap_type = cmap_avivo;
 		}
-		of_node_put(pciparent);
 	} else if (dp && of_device_is_compatible(dp, "qemu,std-vga")) {
 #ifdef __BIG_ENDIAN
 		const __be32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 3b9aa61de8c2..2aac0e8c4835 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -34,10 +34,12 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 		return retval;
 	}
 	if (attr_size > buffer_size) {
-		if (!buffer_size) /* request to get the attr_size */
-			retval = attr_size;
-		else
+		if (buffer_size)
 			retval = -ERANGE;
+		else if (attr_size > SSIZE_MAX)
+			retval = -EOVERFLOW;
+		else /* request to get the attr_size */
+			retval = attr_size;
 	} else {
 		iov_iter_truncate(&to, attr_size);
 		retval = p9_client_read(attr_fid, 0, &to, &err);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 2eeab57df133..9051ed008554 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -525,13 +525,17 @@ static void afs_add_open_mmap(struct afs_vnode *vnode)
 
 static void afs_drop_open_mmap(struct afs_vnode *vnode)
 {
-	if (!atomic_dec_and_test(&vnode->cb_nr_mmap))
+	if (atomic_add_unless(&vnode->cb_nr_mmap, -1, 1))
 		return;
 
 	down_write(&vnode->volume->cell->fs_open_mmaps_lock);
 
-	if (atomic_read(&vnode->cb_nr_mmap) == 0)
+	read_seqlock_excl(&vnode->cb_lock);
+	// the only place where ->cb_nr_mmap may hit 0
+	// see __afs_break_callback() for the other side...
+	if (atomic_dec_and_test(&vnode->cb_nr_mmap))
 		list_del_init(&vnode->cb_mmap_link);
+	read_sequnlock_excl(&vnode->cb_lock);
 
 	up_write(&vnode->volume->cell->fs_open_mmaps_lock);
 	flush_work(&vnode->cb_work);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 2aecd4ffb13b..c71a40927315 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -320,7 +320,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	else
 		executable_stack = EXSTACK_DEFAULT;
 
-	if (stack_size == 0) {
+	if (stack_size == 0 && interp_params.flags & ELF_FDPIC_FLAG_PRESENT) {
 		stack_size = interp_params.stack_size;
 		if (interp_params.flags & ELF_FDPIC_FLAG_EXEC_STACK)
 			executable_stack = EXSTACK_ENABLE_X;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index bb202ad369d5..740dac1012ae 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -60,12 +60,11 @@ typedef struct {
 	char *name;
 	struct dentry *dentry;
 	struct file *interp_file;
+	refcount_t users;		/* sync removal with load_misc_binary() */
 } Node;
 
 static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
-static struct vfsmount *bm_mnt;
-static int entry_count;
 
 /*
  * Max length of the register string.  Determined by:
@@ -82,19 +81,23 @@ static int entry_count;
  */
 #define MAX_REGISTER_LENGTH 1920
 
-/*
- * Check if we support the binfmt
- * if we do, return the node, else NULL
- * locking is done in load_misc_binary
+/**
+ * search_binfmt_handler - search for a binary handler for @bprm
+ * @misc: handle to binfmt_misc instance
+ * @bprm: binary for which we are looking for a handler
+ *
+ * Search for a binary type handler for @bprm in the list of registered binary
+ * type handlers.
+ *
+ * Return: binary type list entry on success, NULL on failure
  */
-static Node *check_file(struct linux_binprm *bprm)
+static Node *search_binfmt_handler(struct linux_binprm *bprm)
 {
 	char *p = strrchr(bprm->interp, '.');
-	struct list_head *l;
+	Node *e;
 
 	/* Walk all the registered handlers. */
-	list_for_each(l, &entries) {
-		Node *e = list_entry(l, Node, list);
+	list_for_each_entry(e, &entries, list) {
 		char *s;
 		int j;
 
@@ -123,9 +126,49 @@ static Node *check_file(struct linux_binprm *bprm)
 		if (j == e->size)
 			return e;
 	}
+
 	return NULL;
 }
 
+/**
+ * get_binfmt_handler - try to find a binary type handler
+ * @misc: handle to binfmt_misc instance
+ * @bprm: binary for which we are looking for a handler
+ *
+ * Try to find a binfmt handler for the binary type. If one is found take a
+ * reference to protect against removal via bm_{entry,status}_write().
+ *
+ * Return: binary type list entry on success, NULL on failure
+ */
+static Node *get_binfmt_handler(struct linux_binprm *bprm)
+{
+	Node *e;
+
+	read_lock(&entries_lock);
+	e = search_binfmt_handler(bprm);
+	if (e)
+		refcount_inc(&e->users);
+	read_unlock(&entries_lock);
+	return e;
+}
+
+/**
+ * put_binfmt_handler - put binary handler node
+ * @e: node to put
+ *
+ * Free node syncing with load_misc_binary() and defer final free to
+ * load_misc_binary() in case it is using the binary type handler we were
+ * requested to remove.
+ */
+static void put_binfmt_handler(Node *e)
+{
+	if (refcount_dec_and_test(&e->users)) {
+		if (e->flags & MISC_FMT_OPEN_FILE)
+			filp_close(e->interp_file, NULL);
+		kfree(e);
+	}
+}
+
 /*
  * the loader itself
  */
@@ -139,12 +182,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (!enabled)
 		return retval;
 
-	/* to keep locking time low, we copy the interpreter string */
-	read_lock(&entries_lock);
-	fmt = check_file(bprm);
-	if (fmt)
-		dget(fmt->dentry);
-	read_unlock(&entries_lock);
+	fmt = get_binfmt_handler(bprm);
 	if (!fmt)
 		return retval;
 
@@ -198,7 +236,16 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	retval = 0;
 ret:
-	dput(fmt->dentry);
+
+	/*
+	 * If we actually put the node here all concurrent calls to
+	 * load_misc_binary() will have finished. We also know
+	 * that for the refcount to be zero ->evict_inode() must have removed
+	 * the node to be deleted from the list. All that is left for us is to
+	 * close and free.
+	 */
+	put_binfmt_handler(fmt);
+
 	return retval;
 }
 
@@ -553,30 +600,90 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	return inode;
 }
 
+/**
+ * bm_evict_inode - cleanup data associated with @inode
+ * @inode: inode to which the data is attached
+ *
+ * Cleanup the binary type handler data associated with @inode if a binary type
+ * entry is removed or the filesystem is unmounted and the super block is
+ * shutdown.
+ *
+ * If the ->evict call was not caused by a super block shutdown but by a write
+ * to remove the entry or all entries via bm_{entry,status}_write() the entry
+ * will have already been removed from the list. We keep the list_empty() check
+ * to make that explicit.
+*/
 static void bm_evict_inode(struct inode *inode)
 {
 	Node *e = inode->i_private;
 
-	if (e && e->flags & MISC_FMT_OPEN_FILE)
-		filp_close(e->interp_file, NULL);
-
 	clear_inode(inode);
-	kfree(e);
+
+	if (e) {
+		write_lock(&entries_lock);
+		if (!list_empty(&e->list))
+			list_del_init(&e->list);
+		write_unlock(&entries_lock);
+		put_binfmt_handler(e);
+	}
 }
 
-static void kill_node(Node *e)
+/**
+ * unlink_binfmt_dentry - remove the dentry for the binary type handler
+ * @dentry: dentry associated with the binary type handler
+ *
+ * Do the actual filesystem work to remove a dentry for a registered binary
+ * type handler. Since binfmt_misc only allows simple files to be created
+ * directly under the root dentry of the filesystem we ensure that we are
+ * indeed passed a dentry directly beneath the root dentry, that the inode
+ * associated with the root dentry is locked, and that it is a regular file we
+ * are asked to remove.
+ */
+static void unlink_binfmt_dentry(struct dentry *dentry)
 {
-	struct dentry *dentry;
+	struct dentry *parent = dentry->d_parent;
+	struct inode *inode, *parent_inode;
+
+	/* All entries are immediate descendants of the root dentry. */
+	if (WARN_ON_ONCE(dentry->d_sb->s_root != parent))
+		return;
 
+	/* We only expect to be called on regular files. */
+	inode = d_inode(dentry);
+	if (WARN_ON_ONCE(!S_ISREG(inode->i_mode)))
+		return;
+
+	/* The parent inode must be locked. */
+	parent_inode = d_inode(parent);
+	if (WARN_ON_ONCE(!inode_is_locked(parent_inode)))
+		return;
+
+	if (simple_positive(dentry)) {
+		dget(dentry);
+		simple_unlink(parent_inode, dentry);
+		d_delete(dentry);
+		dput(dentry);
+	}
+}
+
+/**
+ * remove_binfmt_handler - remove a binary type handler
+ * @misc: handle to binfmt_misc instance
+ * @e: binary type handler to remove
+ *
+ * Remove a binary type handler from the list of binary type handlers and
+ * remove its associated dentry. This is called from
+ * binfmt_{entry,status}_write(). In the future, we might want to think about
+ * adding a proper ->unlink() method to binfmt_misc instead of forcing caller's
+ * to use writes to files in order to delete binary type handlers. But it has
+ * worked for so long that it's not a pressing issue.
+ */
+static void remove_binfmt_handler(Node *e)
+{
 	write_lock(&entries_lock);
 	list_del_init(&e->list);
 	write_unlock(&entries_lock);
-
-	dentry = e->dentry;
-	drop_nlink(d_inode(dentry));
-	d_drop(dentry);
-	dput(dentry);
-	simple_release_fs(&bm_mnt, &entry_count);
+	unlink_binfmt_dentry(e->dentry);
 }
 
 /* /<entry> */
@@ -603,8 +710,8 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	struct dentry *root;
-	Node *e = file_inode(file)->i_private;
+	struct inode *inode = file_inode(file);
+	Node *e = inode->i_private;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -618,13 +725,22 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete this handler. */
-		root = file_inode(file)->i_sb->s_root;
-		inode_lock(d_inode(root));
+		inode = d_inode(inode->i_sb->s_root);
+		inode_lock(inode);
 
+		/*
+		 * In order to add new element or remove elements from the list
+		 * via bm_{entry,register,status}_write() inode_lock() on the
+		 * root inode must be held.
+		 * The lock is exclusive ensuring that the list can't be
+		 * modified. Only load_misc_binary() can access but does so
+		 * read-only. So we only need to take the write lock when we
+		 * actually remove the entry from the list.
+		 */
 		if (!list_empty(&e->list))
-			kill_node(e);
+			remove_binfmt_handler(e);
 
-		inode_unlock(d_inode(root));
+		inode_unlock(inode);
 		break;
 	default:
 		return res;
@@ -683,13 +799,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	if (!inode)
 		goto out2;
 
-	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out2;
-	}
-
+	refcount_set(&e->users, 1);
 	e->dentry = dget(dentry);
 	inode->i_private = e;
 	inode->i_fop = &bm_entry_operations;
@@ -733,7 +843,8 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	int res = parse_command(buffer, count);
-	struct dentry *root;
+	Node *e, *next;
+	struct inode *inode;
 
 	switch (res) {
 	case 1:
@@ -746,13 +857,22 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete all handlers. */
-		root = file_inode(file)->i_sb->s_root;
-		inode_lock(d_inode(root));
+		inode = d_inode(file_inode(file)->i_sb->s_root);
+		inode_lock(inode);
 
-		while (!list_empty(&entries))
-			kill_node(list_first_entry(&entries, Node, list));
+		/*
+		 * In order to add new element or remove elements from the list
+		 * via bm_{entry,register,status}_write() inode_lock() on the
+		 * root inode must be held.
+		 * The lock is exclusive ensuring that the list can't be
+		 * modified. Only load_misc_binary() can access but does so
+		 * read-only. So we only need to take the write lock when we
+		 * actually remove the entry from the list.
+		 */
+		list_for_each_entry_safe(e, next, &entries, list)
+			remove_binfmt_handler(e);
 
-		inode_unlock(d_inode(root));
+		inode_unlock(inode);
 		break;
 	default:
 		return res;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1494ce990d29..052112d0daa7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -420,8 +420,6 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 
 	delayed_root = delayed_node->root->fs_info->delayed_root;
 
-	BUG_ON(!delayed_root);
-
 	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
 	else
@@ -970,7 +968,7 @@ static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 
 	if (delayed_node &&
 	    test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		BUG_ON(!delayed_node->root);
+		ASSERT(delayed_node->root);
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c17232659942..9ebb7bb37a22 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3130,6 +3130,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	int ret;
 
 	fs_info->sb = sb;
+	/* Temporary fixed values for block size until we read the superblock. */
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
@@ -3628,6 +3629,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
+	/* Update the values for the current filesystem. */
 	sb->s_blocksize = sectorsize;
 	sb->s_blocksize_bits = blksize_bits(sectorsize);
 	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f923c9b773e..72227c0b4b5a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1748,7 +1748,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	int ret = 0;
 	size_t pg_offset = 0;
 	size_t iosize;
-	size_t blocksize = inode->i_sb->s_blocksize;
+	size_t blocksize = fs_info->sectorsize;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = set_page_extent_mapped(page);
@@ -3348,7 +3348,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	struct extent_state *cached_state = NULL;
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
-	size_t blocksize = folio->mapping->host->i_sb->s_blocksize;
+	size_t blocksize = btrfs_sb(folio->mapping->host->i_sb)->sectorsize;
 
 	/* This function is only called for the btree inode */
 	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 21d262da386d..75ad735322c4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1894,9 +1894,9 @@ static inline void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		ctl->free_space -= bytes;
 }
 
-static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
-			    struct btrfs_free_space *info, u64 offset,
-			    u64 bytes)
+static void btrfs_bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
+				  struct btrfs_free_space *info, u64 offset,
+				  u64 bytes)
 {
 	unsigned long start, count, end;
 	int extent_delta = 1;
@@ -2232,7 +2232,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bytes_to_set = min(end - offset, bytes);
 
-	bitmap_set_bits(ctl, info, offset, bytes_to_set);
+	btrfs_bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
 	return bytes_to_set;
 
@@ -2677,15 +2677,16 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	int bg_reclaim_threshold = 0;
-	bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	bool initial;
 	u64 reclaimable_unusable;
 
-	WARN_ON(!initial && offset + size > block_group->zone_capacity);
+	spin_lock(&block_group->lock);
 
+	initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
+	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 	if (!initial)
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
-	spin_lock(&ctl->tree_lock);
 	if (!used)
 		to_free = size;
 	else if (initial)
@@ -2698,7 +2699,9 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		to_free = offset + size - block_group->alloc_offset;
 	to_unusable = size - to_free;
 
+	spin_lock(&ctl->tree_lock);
 	ctl->free_space += to_free;
+	spin_unlock(&ctl->tree_lock);
 	/*
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
@@ -2707,11 +2710,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		block_group->zone_unusable += to_unusable;
 		WARN_ON(block_group->zone_unusable > block_group->length);
 	}
-	spin_unlock(&ctl->tree_lock);
 	if (!used) {
-		spin_lock(&block_group->lock);
 		block_group->alloc_offset -= size;
-		spin_unlock(&block_group->lock);
 	}
 
 	reclaimable_unusable = block_group->zone_unusable -
@@ -2726,6 +2726,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
+	spin_unlock(&block_group->lock);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 10ded9c2be03..934e360d1aef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4614,7 +4614,14 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret == 0);
+	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist a root
+		 * with such id, but this is out of valid range.
+		 */
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	ret = 0;
 	if (path->slots[0] > 0) {
@@ -9104,7 +9111,7 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 	u64 delalloc_bytes;
 	u64 inode_bytes;
 	struct inode *inode = d_inode(path->dentry);
-	u32 blocksize = inode->i_sb->s_blocksize;
+	u32 blocksize = btrfs_sb(inode->i_sb)->sectorsize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
 	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 64b37afb7c87..31f7fe31b607 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -517,7 +517,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	 * block group is in the logical address space, which can be any
 	 * sectorsize aligned bytenr in  the range [0, U64_MAX].
 	 */
-	if (range.len < fs_info->sb->s_blocksize)
+	if (range.len < fs_info->sectorsize)
 		return -EINVAL;
 
 	range.minlen = max(range.minlen, minlen);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e482889667ec..f3b066b44280 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2697,8 +2697,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (nr_old_roots == 0 && nr_new_roots == 0)
 		goto out_free;
 
-	BUG_ON(!fs_info->quota_root);
-
 	trace_btrfs_qgroup_account_extent(fs_info, trans->transid, bytenr,
 					num_bytes, nr_old_roots, nr_new_roots);
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f50586ff85c8..fc6e42852578 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -659,7 +659,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
-	const u64 bs = fs_info->sb->s_blocksize;
+	const u64 bs = fs_info->sectorsize;
 	int ret;
 
 	/*
@@ -726,7 +726,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	int ret;
 	int wb_ret;
 	u64 len = olen;
-	u64 bs = fs_info->sb->s_blocksize;
+	u64 bs = fs_info->sectorsize;
 
 	/*
 	 * VFS's generic_remap_file_range_prep() protects us from cloning the
@@ -792,7 +792,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
-	u64 bs = BTRFS_I(inode_out)->root->fs_info->sb->s_blocksize;
+	u64 bs = BTRFS_I(inode_out)->root->fs_info->sectorsize;
 	u64 wb_len;
 	int ret;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ec3db315f561..030edc1a9591 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -720,7 +720,12 @@ static int begin_cmd(struct send_ctx *sctx, int cmd)
 	if (WARN_ON(!sctx->send_buf))
 		return -EINVAL;
 
-	BUG_ON(sctx->send_size);
+	if (unlikely(sctx->send_size != 0)) {
+		btrfs_err(sctx->send_root->fs_info,
+			  "send: command header buffer not empty cmd %d offset %llu",
+			  cmd, sctx->send_off);
+		return -EINVAL;
+	}
 
 	sctx->send_size += sizeof(*hdr);
 	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
@@ -5905,26 +5910,52 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	int ret = 0;
 	u64 offset = key->offset;
 	u64 end;
-	u64 bs = sctx->send_root->fs_info->sb->s_blocksize;
+	u64 bs = sctx->send_root->fs_info->sectorsize;
+	struct btrfs_file_extent_item *ei;
+	u64 disk_byte;
+	u64 data_offset;
+	u64 num_bytes;
+	struct btrfs_inode_info info = { 0 };
 
 	end = min_t(u64, btrfs_file_extent_end(path), sctx->cur_inode_size);
 	if (offset >= end)
 		return 0;
 
-	if (clone_root && IS_ALIGNED(end, bs)) {
-		struct btrfs_file_extent_item *ei;
-		u64 disk_byte;
-		u64 data_offset;
+	num_bytes = end - offset;
 
-		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				    struct btrfs_file_extent_item);
-		disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
-		data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
-		ret = clone_range(sctx, path, clone_root, disk_byte,
-				  data_offset, offset, end - offset);
-	} else {
-		ret = send_extent_data(sctx, path, offset, end - offset);
-	}
+	if (!clone_root)
+		goto write_data;
+
+	if (IS_ALIGNED(end, bs))
+		goto clone_data;
+
+	/*
+	 * If the extent end is not aligned, we can clone if the extent ends at
+	 * the i_size of the inode and the clone range ends at the i_size of the
+	 * source inode, otherwise the clone operation fails with -EINVAL.
+	 */
+	if (end != sctx->cur_inode_size)
+		goto write_data;
+
+	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
+	if (ret < 0)
+		return ret;
+
+	if (clone_root->offset + num_bytes == info.size)
+		goto clone_data;
+
+write_data:
+	ret = send_extent_data(sctx, path, offset, num_bytes);
+	sctx->cur_inode_next_write_offset = end;
+	return ret;
+
+clone_data:
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
+	data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
+	ret = clone_range(sctx, path, clone_root, disk_byte, data_offset, offset,
+			  num_bytes);
 	sctx->cur_inode_next_write_offset = end;
 	return ret;
 }
@@ -7180,8 +7211,8 @@ static int tree_move_down(struct btrfs_path *path, int *level, u64 reada_min_gen
 	u64 reada_done = 0;
 
 	lockdep_assert_held_read(&parent->fs_info->commit_root_sem);
+	ASSERT(*level != 0);
 
-	BUG_ON(*level == 0);
 	eb = btrfs_read_node_slot(parent, slot);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6fc5fa18d1ee..d063379a031d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2426,7 +2426,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
-	buf->f_bsize = dentry->d_sb->s_blocksize;
+	buf->f_bsize = fs_info->sectorsize;
 	buf->f_namelen = BTRFS_NAME_LEN;
 
 	/* We treat it as constant endianness (it doesn't matter _which_)
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 350da449db08..d6a5e6afd5dc 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -11,6 +11,7 @@
 #include "btrfs-tests.h"
 #include "../ctree.h"
 #include "../extent_io.h"
+#include "../disk-io.h"
 #include "../btrfs_inode.h"
 
 #define PROCESS_UNLOCK		(1 << 0)
@@ -105,9 +106,11 @@ static void dump_extent_io_tree(const struct extent_io_tree *tree)
 	}
 }
 
-static int test_find_delalloc(u32 sectorsize)
+static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 {
-	struct inode *inode;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root = NULL;
+	struct inode *inode = NULL;
 	struct extent_io_tree *tmp;
 	struct page *page;
 	struct page *locked_page = NULL;
@@ -121,12 +124,27 @@ static int test_find_delalloc(u32 sectorsize)
 
 	test_msg("running find delalloc tests");
 
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	root = btrfs_alloc_dummy_root(fs_info);
+	if (IS_ERR(root)) {
+		test_std_err(TEST_ALLOC_ROOT);
+		ret = PTR_ERR(root);
+		goto out;
+	}
+
 	inode = btrfs_new_test_inode();
 	if (!inode) {
 		test_std_err(TEST_ALLOC_INODE);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	tmp = &BTRFS_I(inode)->io_tree;
+	BTRFS_I(inode)->root = root;
 
 	/*
 	 * Passing NULL as we don't have fs_info but tracepoints are not used
@@ -316,6 +334,8 @@ static int test_find_delalloc(u32 sectorsize)
 	process_page_range(inode, 0, total_dirty - 1,
 			   PROCESS_UNLOCK | PROCESS_RELEASE);
 	iput(inode);
+	btrfs_free_dummy_root(root);
+	btrfs_free_dummy_fs_info(fs_info);
 	return ret;
 }
 
@@ -598,7 +618,7 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 
 	test_msg("running extent I/O tests");
 
-	ret = test_find_delalloc(sectorsize);
+	ret = test_find_delalloc(sectorsize, nodesize);
 	if (ret)
 		goto out;
 
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 02e8398246ae..28f5df3b70c8 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1613,6 +1613,72 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_dev_extent_item(const struct extent_buffer *leaf,
+				 const struct btrfs_key *key,
+				 int slot,
+				 struct btrfs_key *prev_key)
+{
+	struct btrfs_dev_extent *de;
+	const u32 sectorsize = leaf->fs_info->sectorsize;
+
+	de = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+	/* Basic fixed member checks. */
+	if (unlikely(btrfs_dev_extent_chunk_tree(leaf, de) !=
+		     BTRFS_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk tree id, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_tree(leaf, de),
+			    BTRFS_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_dev_extent_chunk_objectid(leaf, de) !=
+		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk objectid, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	/* Alignment check. */
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent key.offset, has %llu not aligned to %u",
+			    key->offset, sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_chunk_offset(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk offset, has %llu not aligned to %u",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_length(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent length, has %llu not aligned to %u",
+			    btrfs_dev_extent_length(leaf, de), sectorsize);
+		return -EUCLEAN;
+	}
+	/* Overlap check with previous dev extent. */
+	if (slot && prev_key->objectid == key->objectid &&
+	    prev_key->type == key->type) {
+		struct btrfs_dev_extent *prev_de;
+		u64 prev_len;
+
+		prev_de = btrfs_item_ptr(leaf, slot - 1, struct btrfs_dev_extent);
+		prev_len = btrfs_dev_extent_length(leaf, prev_de);
+		if (unlikely(prev_key->offset + prev_len > key->offset)) {
+			generic_err(leaf, slot,
+		"dev extent overlap, prev offset %llu len %llu current offset %llu",
+				    prev_key->objectid, prev_len, key->offset);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1648,6 +1714,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_DEV_ITEM_KEY:
 		ret = check_dev_item(leaf, key, slot);
 		break;
+	case BTRFS_DEV_EXTENT_KEY:
+		ret = check_dev_extent_item(leaf, key, slot, prev_key);
+		break;
 	case BTRFS_INODE_ITEM_KEY:
 		ret = check_inode_item(leaf, key, slot);
 		break;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1eefa4411e06..708bf142b188 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -248,15 +248,9 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	if (ret != rq->outputsize) {
 		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
 			  ret, rq->inputsize, inputmargin, rq->outputsize);
-
-		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, src + inputmargin, rq->inputsize, true);
-		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
-
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
-		ret = -EIO;
+		ret = -EFSCORRUPTED;
 	} else {
 		ret = 0;
 	}
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 5cbe5ae5ad4a..92b540754799 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3404,9 +3404,10 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	struct ext4_extent *ex, *abut_ex;
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
-	int allocated = 0, max_zeroout = 0;
 	int err = 0;
 	int split_flag = EXT4_EXT_DATA_VALID2;
+	int allocated = 0;
+	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map_len);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 004ad321a45d..c723ee3e4995 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6483,6 +6483,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 	bool set_trimmed = false;
 	void *bitmap;
 
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		return 0;
+
 	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
 	if (start == 0 && max >= last)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 274542d869d0..3db39758486e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5752,6 +5752,28 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 	return journal_inode;
 }
 
+static int ext4_journal_bmap(journal_t *journal, sector_t *block)
+{
+	struct ext4_map_blocks map;
+	int ret;
+
+	if (journal->j_inode == NULL)
+		return 0;
+
+	map.m_lblk = *block;
+	map.m_len = 1;
+	ret = ext4_map_blocks(NULL, journal->j_inode, &map, 0);
+	if (ret <= 0) {
+		ext4_msg(journal->j_inode->i_sb, KERN_CRIT,
+			 "journal bmap failed: block %llu ret %d\n",
+			 *block, ret);
+		jbd2_journal_abort(journal, ret ? ret : -EIO);
+		return ret;
+	}
+	*block = map.m_pblk;
+	return 0;
+}
+
 static journal_t *ext4_get_journal(struct super_block *sb,
 				   unsigned int journal_inum)
 {
@@ -5772,6 +5794,7 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 		return NULL;
 	}
 	journal->j_private = sb;
+	journal->j_bmap = ext4_journal_bmap;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 }
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f0a45d3ec4eb..d94b1a6c60e2 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1522,45 +1522,49 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 /*
  * Add value of the EA in an inode.
  */
-static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
-					  const void *value, size_t value_len,
-					  struct inode **ret_inode)
+static struct inode *ext4_xattr_inode_lookup_create(handle_t *handle,
+		struct inode *inode, const void *value, size_t value_len)
 {
 	struct inode *ea_inode;
 	u32 hash;
 	int err;
 
+	/* Account inode & space to quota even if sharing... */
+	err = ext4_xattr_inode_alloc_quota(inode, value_len);
+	if (err)
+		return ERR_PTR(err);
+
 	hash = ext4_xattr_inode_hash(EXT4_SB(inode->i_sb), value, value_len);
 	ea_inode = ext4_xattr_inode_cache_find(inode, value, value_len, hash);
 	if (ea_inode) {
 		err = ext4_xattr_inode_inc_ref(handle, ea_inode);
-		if (err) {
-			iput(ea_inode);
-			return err;
-		}
-
-		*ret_inode = ea_inode;
-		return 0;
+		if (err)
+			goto out_err;
+		return ea_inode;
 	}
 
 	/* Create an inode for the EA value */
 	ea_inode = ext4_xattr_inode_create(handle, inode, hash);
-	if (IS_ERR(ea_inode))
-		return PTR_ERR(ea_inode);
+	if (IS_ERR(ea_inode)) {
+		ext4_xattr_inode_free_quota(inode, NULL, value_len);
+		return ea_inode;
+	}
 
 	err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
 	if (err) {
-		ext4_xattr_inode_dec_ref(handle, ea_inode);
-		iput(ea_inode);
-		return err;
+		if (ext4_xattr_inode_dec_ref(handle, ea_inode))
+			ext4_warning_inode(ea_inode, "cleanup dec ref error %d", err);
+		goto out_err;
 	}
 
 	if (EA_INODE_CACHE(inode))
 		mb_cache_entry_create(EA_INODE_CACHE(inode), GFP_NOFS, hash,
 				      ea_inode->i_ino, true /* reusable */);
-
-	*ret_inode = ea_inode;
-	return 0;
+	return ea_inode;
+out_err:
+	iput(ea_inode);
+	ext4_xattr_inode_free_quota(inode, NULL, value_len);
+	return ERR_PTR(err);
 }
 
 /*
@@ -1572,6 +1576,7 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 				struct ext4_xattr_search *s,
 				handle_t *handle, struct inode *inode,
+				struct inode *new_ea_inode,
 				bool is_block)
 {
 	struct ext4_xattr_entry *last, *next;
@@ -1579,7 +1584,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	size_t min_offs = s->end - s->base, name_len = strlen(i->name);
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
-	struct inode *new_ea_inode = NULL;
 	size_t old_size, new_size;
 	int ret;
 
@@ -1664,43 +1668,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 			old_ea_inode = NULL;
 			goto out;
 		}
-	}
-	if (i->value && in_inode) {
-		WARN_ON_ONCE(!i->value_len);
-
-		ret = ext4_xattr_inode_alloc_quota(inode, i->value_len);
-		if (ret)
-			goto out;
-
-		ret = ext4_xattr_inode_lookup_create(handle, inode, i->value,
-						     i->value_len,
-						     &new_ea_inode);
-		if (ret) {
-			new_ea_inode = NULL;
-			ext4_xattr_inode_free_quota(inode, NULL, i->value_len);
-			goto out;
-		}
-	}
 
-	if (old_ea_inode) {
 		/* We are ready to release ref count on the old_ea_inode. */
 		ret = ext4_xattr_inode_dec_ref(handle, old_ea_inode);
-		if (ret) {
-			/* Release newly required ref count on new_ea_inode. */
-			if (new_ea_inode) {
-				int err;
-
-				err = ext4_xattr_inode_dec_ref(handle,
-							       new_ea_inode);
-				if (err)
-					ext4_warning_inode(new_ea_inode,
-						  "dec ref new_ea_inode err=%d",
-						  err);
-				ext4_xattr_inode_free_quota(inode, new_ea_inode,
-							    i->value_len);
-			}
+		if (ret)
 			goto out;
-		}
 
 		ext4_xattr_inode_free_quota(inode, old_ea_inode,
 					    le32_to_cpu(here->e_value_size));
@@ -1824,7 +1796,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	ret = 0;
 out:
 	iput(old_ea_inode);
-	iput(new_ea_inode);
 	return ret;
 }
 
@@ -1887,9 +1858,21 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 	size_t old_ea_inode_quota = 0;
 	unsigned int ea_ino;
 
-
 #define header(x) ((struct ext4_xattr_header *)(x))
 
+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode) {
+		WARN_ON_ONCE(!i->value_len);
+
+		ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode)) {
+			error = PTR_ERR(ea_inode);
+			ea_inode = NULL;
+			goto cleanup;
+		}
+	}
+
 	if (s->base) {
 		int offset = (char *)s->here - bs->bh->b_data;
 
@@ -1898,6 +1881,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 						      EXT4_JTR_NONE);
 		if (error)
 			goto cleanup;
+
 		lock_buffer(bs->bh);
 
 		if (header(s->base)->h_refcount == cpu_to_le32(1)) {
@@ -1924,7 +1908,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
 			error = ext4_xattr_set_entry(i, s, handle, inode,
-						     true /* is_block */);
+					     ea_inode, true /* is_block */);
 			ext4_xattr_block_csum_set(inode, bs->bh);
 			unlock_buffer(bs->bh);
 			if (error == -EFSCORRUPTED)
@@ -1992,29 +1976,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */);
+	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
+				     true /* is_block */);
 	if (error == -EFSCORRUPTED)
 		goto bad_block;
 	if (error)
 		goto cleanup;
 
-	if (i->value && s->here->e_value_inum) {
-		/*
-		 * A ref count on ea_inode has been taken as part of the call to
-		 * ext4_xattr_set_entry() above. We would like to drop this
-		 * extra ref but we have to wait until the xattr block is
-		 * initialized and has its own ref count on the ea_inode.
-		 */
-		ea_ino = le32_to_cpu(s->here->e_value_inum);
-		error = ext4_xattr_inode_iget(inode, ea_ino,
-					      le32_to_cpu(s->here->e_hash),
-					      &ea_inode);
-		if (error) {
-			ea_inode = NULL;
-			goto cleanup;
-		}
-	}
-
 inserted:
 	if (!IS_LAST_ENTRY(s->first)) {
 		new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
@@ -2167,17 +2135,16 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 cleanup:
 	if (ea_inode) {
-		int error2;
-
-		error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
-		if (error2)
-			ext4_warning_inode(ea_inode, "dec ref error=%d",
-					   error2);
+		if (error) {
+			int error2;
 
-		/* If there was an error, revert the quota charge. */
-		if (error)
+			error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+			if (error2)
+				ext4_warning_inode(ea_inode, "dec ref error=%d",
+						   error2);
 			ext4_xattr_inode_free_quota(inode, ea_inode,
 						    i_size_read(ea_inode));
+		}
 		iput(ea_inode);
 	}
 	if (ce)
@@ -2235,14 +2202,38 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 {
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_search *s = &is->s;
+	struct inode *ea_inode = NULL;
 	int error;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
 		return -ENOSPC;
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
-	if (error)
+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode) {
+		WARN_ON_ONCE(!i->value_len);
+
+		ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode))
+			return PTR_ERR(ea_inode);
+	}
+	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
+				     false /* is_block */);
+	if (error) {
+		if (ea_inode) {
+			int error2;
+
+			error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+			if (error2)
+				ext4_warning_inode(ea_inode, "dec ref error=%d",
+						   error2);
+
+			ext4_xattr_inode_free_quota(inode, ea_inode,
+						    i_size_read(ea_inode));
+			iput(ea_inode);
+		}
 		return error;
+	}
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
@@ -2251,6 +2242,7 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 		header->h_magic = cpu_to_le32(0);
 		ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
 	}
+	iput(ea_inode);
 	return 0;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1264a350d4d7..947849e66b0a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2191,6 +2191,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 #endif
 
 	segno = GET_SEGNO(sbi, blkaddr);
+	if (segno == NULL_SEGNO)
+		return;
 
 	se = get_seg_entry(sbi, segno);
 	new_vblocks = se->valid_blocks + del;
@@ -3286,8 +3288,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * since SSR needs latest valid block information.
 	 */
 	update_sit_entry(sbi, *new_blkaddr, 1);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		update_sit_entry(sbi, old_blkaddr, -1);
+	update_sit_entry(sbi, old_blkaddr, -1);
 
 	if (!__has_curseg_space(sbi, curseg)) {
 		if (from_gc)
diff --git a/fs/file.c b/fs/file.c
index 82c5d2382082..50a019fd1726 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -46,27 +46,23 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
 #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
 #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
 
+#define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
 /*
  * Copy 'count' fd bits from the old table to the new table and clear the extra
  * space if any.  This does not copy the file pointers.  Called with the files
  * spinlock held for write.
  */
-static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
-			    unsigned int count)
+static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
+			    unsigned int copy_words)
 {
-	unsigned int cpy, set;
-
-	cpy = count / BITS_PER_BYTE;
-	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
-	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
-	memset((char *)nfdt->open_fds + cpy, 0, set);
-	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
-	memset((char *)nfdt->close_on_exec + cpy, 0, set);
-
-	cpy = BITBIT_SIZE(count);
-	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
-	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
-	memset((char *)nfdt->full_fds_bits + cpy, 0, set);
+	unsigned int nwords = fdt_words(nfdt);
+
+	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
+			copy_words, nwords);
 }
 
 /*
@@ -84,7 +80,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 /*
@@ -374,7 +370,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		open_files = sane_fdtable_size(old_fdt, max_fds);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index bce2492186d0..d4d4b3a8b106 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -741,6 +741,10 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
 			spin_lock(&cookie->lock);
 		}
 		if (test_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags)) {
+			if (atomic_read(&cookie->n_accesses) != 0)
+				/* still being accessed: postpone it */
+				break;
+
 			__fscache_set_cookie_state(cookie,
 						   FSCACHE_COOKIE_STATE_LRU_DISCARDING);
 			wake = true;
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index c7d882a9fe33..295344a462e1 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -474,8 +474,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 
 static void cuse_fc_release(struct fuse_conn *fc)
 {
-	struct cuse_conn *cc = fc_to_cc(fc);
-	kfree_rcu(cc, fc.rcu);
+	kfree(fc_to_cc(fc));
 }
 
 /**
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b4a6e0a1b945..96a717f73ce3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1615,9 +1615,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
-		if (!err && offset == 0 &&
-		    (this_num == PAGE_SIZE || file_size == end))
+		if (!PageUptodate(page) && !err && offset == 0 &&
+		    (this_num == PAGE_SIZE || file_size == end)) {
+			zero_user_segment(page, this_num, PAGE_SIZE);
 			SetPageUptodate(page);
+		}
 		unlock_page(page);
 		put_page(page);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 253b9b78d6f1..66c2a9999468 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -872,6 +872,7 @@ struct fuse_mount {
 
 	/* Entry on fc->mounts */
 	struct list_head fc_entry;
+	struct rcu_head rcu;
 };
 
 static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f19bdd7cbd77..64618548835b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -925,6 +925,14 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
+static void delayed_release(struct rcu_head *p)
+{
+	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
+
+	put_user_ns(fc->user_ns);
+	fc->release(fc);
+}
+
 void fuse_conn_put(struct fuse_conn *fc)
 {
 	if (refcount_dec_and_test(&fc->count)) {
@@ -936,13 +944,12 @@ void fuse_conn_put(struct fuse_conn *fc)
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
-		put_user_ns(fc->user_ns);
 		bucket = rcu_dereference_protected(fc->curr_bucket, 1);
 		if (bucket) {
 			WARN_ON(atomic_read(&bucket->count) != 1);
 			kfree(bucket);
 		}
-		fc->release(fc);
+		call_rcu(&fc->rcu, delayed_release);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
@@ -1356,7 +1363,7 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
-	kfree_rcu(fc, rcu);
+	kfree(fc);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
 
@@ -1895,7 +1902,7 @@ static void fuse_sb_destroy(struct super_block *sb)
 void fuse_mount_destroy(struct fuse_mount *fm)
 {
 	fuse_conn_put(fm->fc);
-	kfree(fm);
+	kfree_rcu(fm, rcu);
 }
 EXPORT_SYMBOL(fuse_mount_destroy);
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..92d41269f1d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -323,6 +323,16 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 		return -ENOMEM;
 	memcpy(fs->tag, tag_buf, len);
 	fs->tag[len] = '\0';
+
+	/* While the VIRTIO specification allows any character, newlines are
+	 * awkward on mount(8) command-lines and cause problems in the sysfs
+	 * "tag" attr and uevent TAG= properties. Forbid them.
+	 */
+	if (strchr(fs->tag, '\n')) {
+		dev_dbg(&vdev->dev, "refusing virtiofs tag with newline character\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 95353982e643..6ba8460f5331 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -146,8 +146,8 @@ static void gfs2_glock_dealloc(struct rcu_head *rcu)
  *
  * We need to allow some glocks to be enqueued, dequeued, promoted, and demoted
  * when we're withdrawn. For example, to maintain metadata integrity, we should
- * disallow the use of inode and rgrp glocks when withdrawn. Other glocks, like
- * iopen or the transaction glocks may be safely used because none of their
+ * disallow the use of inode and rgrp glocks when withdrawn. Other glocks like
+ * the iopen or freeze glock may be safely used because none of their
  * metadata goes through the journal. So in general, we should disallow all
  * glocks that are journaled, and allow all the others. One exception is:
  * we need to allow our active journal to be promoted and demoted so others
@@ -661,8 +661,7 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 		if (gh && !test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags)) {
 			/* move to back of queue and try next entry */
 			if (ret & LM_OUT_CANCELED) {
-				if ((gh->gh_flags & LM_FLAG_PRIORITY) == 0)
-					list_move_tail(&gh->gh_list, &gl->gl_holders);
+				list_move_tail(&gh->gh_list, &gl->gl_holders);
 				gh = find_first_waiter(gl);
 				gl->gl_target = gh->gh_state;
 				goto retry;
@@ -749,8 +748,7 @@ __acquires(&gl->gl_lockref.lock)
 	    gh && !(gh->gh_flags & LM_FLAG_NOEXP))
 		goto skip_inval;
 
-	lck_flags &= (LM_FLAG_TRY | LM_FLAG_TRY_1CB | LM_FLAG_NOEXP |
-		      LM_FLAG_PRIORITY);
+	lck_flags &= (LM_FLAG_TRY | LM_FLAG_TRY_1CB | LM_FLAG_NOEXP);
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
 	GLOCK_BUG_ON(gl, gl->gl_state == gl->gl_target);
 	if ((target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED) &&
@@ -1528,27 +1526,20 @@ __acquires(&gl->gl_lockref.lock)
 		}
 		if (test_bit(HIF_HOLDER, &gh2->gh_iflags))
 			continue;
-		if (unlikely((gh->gh_flags & LM_FLAG_PRIORITY) && !insert_pt))
-			insert_pt = &gh2->gh_list;
 	}
 	trace_gfs2_glock_queue(gh, 1);
 	gfs2_glstats_inc(gl, GFS2_LKS_QCOUNT);
 	gfs2_sbstats_inc(gl, GFS2_LKS_QCOUNT);
 	if (likely(insert_pt == NULL)) {
 		list_add_tail(&gh->gh_list, &gl->gl_holders);
-		if (unlikely(gh->gh_flags & LM_FLAG_PRIORITY))
-			goto do_cancel;
 		return;
 	}
 	list_add_tail(&gh->gh_list, insert_pt);
-do_cancel:
 	gh = list_first_entry(&gl->gl_holders, struct gfs2_holder, gh_list);
-	if (!(gh->gh_flags & LM_FLAG_PRIORITY)) {
-		spin_unlock(&gl->gl_lockref.lock);
-		if (sdp->sd_lockstruct.ls_ops->lm_cancel)
-			sdp->sd_lockstruct.ls_ops->lm_cancel(gl);
-		spin_lock(&gl->gl_lockref.lock);
-	}
+	spin_unlock(&gl->gl_lockref.lock);
+	if (sdp->sd_lockstruct.ls_ops->lm_cancel)
+		sdp->sd_lockstruct.ls_ops->lm_cancel(gl);
+	spin_lock(&gl->gl_lockref.lock);
 	return;
 
 trap_recursive:
@@ -2296,8 +2287,6 @@ static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 		*p++ = 'e';
 	if (flags & LM_FLAG_ANY)
 		*p++ = 'A';
-	if (flags & LM_FLAG_PRIORITY)
-		*p++ = 'p';
 	if (flags & LM_FLAG_NODE_SCOPE)
 		*p++ = 'n';
 	if (flags & GL_ASYNC)
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 0d068f4fd7d6..f6dd94ce7499 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -68,14 +68,6 @@ enum {
  * also be granted in SHARED.  The preferred state is whichever is compatible
  * with other granted locks, or the specified state if no other locks exist.
  *
- * LM_FLAG_PRIORITY
- * Override fairness considerations.  Suppose a lock is held in a shared state
- * and there is a pending request for the deferred state.  A shared lock
- * request with the priority flag would be allowed to bypass the deferred
- * request and directly join the other shared lock.  A shared lock request
- * without the priority flag might be forced to wait until the deferred
- * requested had acquired and released the lock.
- *
  * LM_FLAG_NODE_SCOPE
  * This holder agrees to share the lock within this node. In other words,
  * the glock is held in EX mode according to DLM, but local holders on the
@@ -86,7 +78,6 @@ enum {
 #define LM_FLAG_TRY_1CB		0x0002
 #define LM_FLAG_NOEXP		0x0004
 #define LM_FLAG_ANY		0x0008
-#define LM_FLAG_PRIORITY	0x0010
 #define LM_FLAG_NODE_SCOPE	0x0020
 #define GL_ASYNC		0x0040
 #define GL_EXACT		0x0080
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 91a542b9d81e..bb5bc32a5eea 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -555,47 +555,34 @@ static void inode_go_dump(struct seq_file *seq, struct gfs2_glock *gl,
 }
 
 /**
- * freeze_go_sync - promote/demote the freeze glock
+ * freeze_go_callback - A cluster node is requesting a freeze
  * @gl: the glock
+ * @remote: true if this came from a different cluster node
  */
 
-static int freeze_go_sync(struct gfs2_glock *gl)
+static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 {
-	int error = 0;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct super_block *sb = sdp->sd_vfs;
+
+	if (!remote ||
+	    (gl->gl_state != LM_ST_SHARED &&
+	     gl->gl_state != LM_ST_UNLOCKED) ||
+	    gl->gl_demote_state != LM_ST_UNLOCKED)
+		return;
 
 	/*
-	 * We need to check gl_state == LM_ST_SHARED here and not gl_req ==
-	 * LM_ST_EXCLUSIVE. That's because when any node does a freeze,
-	 * all the nodes should have the freeze glock in SH mode and they all
-	 * call do_xmote: One for EX and the others for UN. They ALL must
-	 * freeze locally, and they ALL must queue freeze work. The freeze_work
-	 * calls freeze_func, which tries to reacquire the freeze glock in SH,
-	 * effectively waiting for the thaw on the node who holds it in EX.
-	 * Once thawed, the work func acquires the freeze glock in
-	 * SH and everybody goes back to thawed.
+	 * Try to get an active super block reference to prevent racing with
+	 * unmount (see super_trylock_shared()).  But note that unmount isn't
+	 * the only place where a write lock on s_umount is taken, and we can
+	 * fail here because of things like remount as well.
 	 */
-	if (gl->gl_state == LM_ST_SHARED && !gfs2_withdrawn(sdp) &&
-	    !test_bit(SDF_NORECOVERY, &sdp->sd_flags)) {
-		atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
-		error = freeze_super(sdp->sd_vfs);
-		if (error) {
-			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
-				error);
-			if (gfs2_withdrawn(sdp)) {
-				atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
-				return 0;
-			}
-			gfs2_assert_withdraw(sdp, 0);
-		}
-		queue_work(gfs2_freeze_wq, &sdp->sd_freeze_work);
-		if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
-			gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
-				       GFS2_LFC_FREEZE_GO_SYNC);
-		else /* read-only mounts */
-			atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
+	if (down_read_trylock(&sb->s_umount)) {
+		atomic_inc(&sb->s_active);
+		up_read(&sb->s_umount);
+		if (!queue_work(gfs2_freeze_wq, &sdp->sd_freeze_work))
+			deactivate_super(sb);
 	}
-	return 0;
 }
 
 /**
@@ -625,18 +612,6 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 	return 0;
 }
 
-/**
- * freeze_go_demote_ok
- * @gl: the glock
- *
- * Always returns 0
- */
-
-static int freeze_go_demote_ok(const struct gfs2_glock *gl)
-{
-	return 0;
-}
-
 /**
  * iopen_go_callback - schedule the dcache entry for the inode to be deleted
  * @gl: the glock
@@ -760,9 +735,8 @@ const struct gfs2_glock_operations gfs2_rgrp_glops = {
 };
 
 const struct gfs2_glock_operations gfs2_freeze_glops = {
-	.go_sync = freeze_go_sync,
 	.go_xmote_bh = freeze_go_xmote_bh,
-	.go_demote_ok = freeze_go_demote_ok,
+	.go_callback = freeze_go_callback,
 	.go_type = LM_TYPE_NONDISK,
 	.go_flags = GLOF_NONDISK,
 };
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index d09d9892cd05..113aeb587702 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -600,7 +600,7 @@ enum {
 	SDF_RORECOVERY		= 7, /* read only recovery */
 	SDF_SKIP_DLM_UNLOCK	= 8,
 	SDF_FORCE_AIL_FLUSH     = 9,
-	SDF_FS_FROZEN           = 10,
+	SDF_FREEZE_INITIATOR	= 10,
 	SDF_WITHDRAWING		= 11, /* Will withdraw eventually */
 	SDF_WITHDRAW_IN_PROG	= 12, /* Withdraw is in progress */
 	SDF_REMOTE_WITHDRAW	= 13, /* Performing remote recovery */
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 23e6962cdd6e..04fc3e72a96e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1907,7 +1907,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
 	kuid_t ouid, nuid;
 	kgid_t ogid, ngid;
 	int error;
-	struct gfs2_alloc_parms ap;
+	struct gfs2_alloc_parms ap = {};
 
 	ouid = inode->i_uid;
 	ogid = inode->i_gid;
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 71911bf9ab34..884081730f9f 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -222,11 +222,6 @@ static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
 		lkf |= DLM_LKF_NOQUEUEBAST;
 	}
 
-	if (gfs_flags & LM_FLAG_PRIORITY) {
-		lkf |= DLM_LKF_NOORDER;
-		lkf |= DLM_LKF_HEADQUE;
-	}
-
 	if (gfs_flags & LM_FLAG_ANY) {
 		if (req == DLM_LOCK_PR)
 			lkf |= DLM_LKF_ALTCW;
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e021d5f50c23..8fd8bb860486 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1136,8 +1136,6 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		if (flags & (GFS2_LOG_HEAD_FLUSH_SHUTDOWN |
 			     GFS2_LOG_HEAD_FLUSH_FREEZE))
 			gfs2_log_shutdown(sdp);
-		if (flags & GFS2_LOG_HEAD_FLUSH_FREEZE)
-			atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
 	}
 
 out_end:
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c0cf1d2d0ef5..26a70b9676d5 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -434,7 +434,7 @@ static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
 	error = gfs2_glock_get(sdp, GFS2_FREEZE_LOCK, &gfs2_freeze_glops,
 			       CREATE, &sdp->sd_freeze_gl);
 	if (error) {
-		fs_err(sdp, "can't create transaction glock: %d\n", error);
+		fs_err(sdp, "can't create freeze glock: %d\n", error);
 		goto fail_rename;
 	}
 
@@ -1143,7 +1143,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
-	struct gfs2_holder freeze_gh;
 	int error;
 
 	sdp = init_sbd(sb);
@@ -1260,21 +1259,19 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (!sb_rdonly(sb)) {
 		error = init_threads(sdp);
-		if (error) {
-			gfs2_withdraw_delayed(sdp);
+		if (error)
 			goto fail_per_node;
-		}
 	}
 
-	error = gfs2_freeze_lock(sdp, &freeze_gh, 0);
+	error = gfs2_freeze_lock_shared(sdp, &sdp->sd_freeze_gh, 0);
 	if (error)
 		goto fail_per_node;
 
 	if (!sb_rdonly(sb))
 		error = gfs2_make_fs_rw(sdp);
 
-	gfs2_freeze_unlock(&freeze_gh);
 	if (error) {
+		gfs2_freeze_unlock(&sdp->sd_freeze_gh);
 		if (sdp->sd_quotad_process)
 			kthread_stop(sdp->sd_quotad_process);
 		sdp->sd_quotad_process = NULL;
@@ -1587,7 +1584,7 @@ static int gfs2_reconfigure(struct fs_context *fc)
 	if ((sb->s_flags ^ fc->sb_flags) & SB_RDONLY) {
 		struct gfs2_holder freeze_gh;
 
-		error = gfs2_freeze_lock(sdp, &freeze_gh, 0);
+		error = gfs2_freeze_lock_shared(sdp, &freeze_gh, 0);
 		if (error)
 			return -EINVAL;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 2bb085a72e8e..afeda936e2be 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -404,7 +404,7 @@ void gfs2_recover_func(struct work_struct *work)
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct gfs2_log_header_host head;
-	struct gfs2_holder j_gh, ji_gh, thaw_gh;
+	struct gfs2_holder j_gh, ji_gh;
 	ktime_t t_start, t_jlck, t_jhd, t_tlck, t_rep;
 	int ro = 0;
 	unsigned int pass;
@@ -420,10 +420,10 @@ void gfs2_recover_func(struct work_struct *work)
 	if (sdp->sd_args.ar_spectator)
 		goto fail;
 	if (jd->jd_jid != sdp->sd_lockstruct.ls_jid) {
-		fs_info(sdp, "jid=%u: Trying to acquire journal lock...\n",
+		fs_info(sdp, "jid=%u: Trying to acquire journal glock...\n",
 			jd->jd_jid);
 		jlocked = 1;
-		/* Acquire the journal lock so we can do recovery */
+		/* Acquire the journal glock so we can do recovery */
 
 		error = gfs2_glock_nq_num(sdp, jd->jd_jid, &gfs2_journal_glops,
 					  LM_ST_EXCLUSIVE,
@@ -465,14 +465,14 @@ void gfs2_recover_func(struct work_struct *work)
 		ktime_ms_delta(t_jhd, t_jlck));
 
 	if (!(head.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
-		fs_info(sdp, "jid=%u: Acquiring the transaction lock...\n",
-			jd->jd_jid);
-
-		/* Acquire a shared hold on the freeze lock */
+		mutex_lock(&sdp->sd_freeze_mutex);
 
-		error = gfs2_freeze_lock(sdp, &thaw_gh, LM_FLAG_PRIORITY);
-		if (error)
+		if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN) {
+			mutex_unlock(&sdp->sd_freeze_mutex);
+			fs_warn(sdp, "jid=%u: Can't replay: filesystem "
+				"is frozen\n", jd->jd_jid);
 			goto fail_gunlock_ji;
+		}
 
 		if (test_bit(SDF_RORECOVERY, &sdp->sd_flags)) {
 			ro = 1;
@@ -496,7 +496,7 @@ void gfs2_recover_func(struct work_struct *work)
 			fs_warn(sdp, "jid=%u: Can't replay: read-only block "
 				"device\n", jd->jd_jid);
 			error = -EROFS;
-			goto fail_gunlock_thaw;
+			goto fail_gunlock_nofreeze;
 		}
 
 		t_tlck = ktime_get();
@@ -514,7 +514,7 @@ void gfs2_recover_func(struct work_struct *work)
 			lops_after_scan(jd, error, pass);
 			if (error) {
 				up_read(&sdp->sd_log_flush_lock);
-				goto fail_gunlock_thaw;
+				goto fail_gunlock_nofreeze;
 			}
 		}
 
@@ -522,7 +522,7 @@ void gfs2_recover_func(struct work_struct *work)
 		clean_journal(jd, &head);
 		up_read(&sdp->sd_log_flush_lock);
 
-		gfs2_freeze_unlock(&thaw_gh);
+		mutex_unlock(&sdp->sd_freeze_mutex);
 		t_rep = ktime_get();
 		fs_info(sdp, "jid=%u: Journal replayed in %lldms [jlck:%lldms, "
 			"jhead:%lldms, tlck:%lldms, replay:%lldms]\n",
@@ -543,8 +543,8 @@ void gfs2_recover_func(struct work_struct *work)
 	fs_info(sdp, "jid=%u: Done\n", jd->jd_jid);
 	goto done;
 
-fail_gunlock_thaw:
-	gfs2_freeze_unlock(&thaw_gh);
+fail_gunlock_nofreeze:
+	mutex_unlock(&sdp->sd_freeze_mutex);
 fail_gunlock_ji:
 	if (jlocked) {
 		gfs2_glock_dq_uninit(&ji_gh);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6107cd680176..aff8cdc61eff 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -332,7 +332,12 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	struct lfcc *lfcc;
 	LIST_HEAD(list);
 	struct gfs2_log_header_host lh;
-	int error;
+	int error, error2;
+
+	/*
+	 * Grab all the journal glocks in SH mode.  We are *probably* doing
+	 * that to prevent recovery.
+	 */
 
 	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
 		lfcc = kmalloc(sizeof(struct lfcc), GFP_KERNEL);
@@ -349,11 +354,13 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 		list_add(&lfcc->list, &list);
 	}
 
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_EXCLUSIVE,
 				   LM_FLAG_NOEXP | GL_NOPID,
 				   &sdp->sd_freeze_gh);
 	if (error)
-		goto out;
+		goto relock_shared;
 
 	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
 		error = gfs2_jdesc_check(jd);
@@ -368,8 +375,14 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 		}
 	}
 
-	if (error)
-		gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+	if (!error)
+		goto out;  /* success */
+
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
+relock_shared:
+	error2 = gfs2_freeze_lock_shared(sdp, &sdp->sd_freeze_gh, 0);
+	gfs2_assert_withdraw(sdp, !error2);
 
 out:
 	while (!list_empty(&list)) {
@@ -463,7 +476,7 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
  * @flags: The type of dirty
  *
  * Unfortunately it can be called under any combination of inode
- * glock and transaction lock, so we have to check carefully.
+ * glock and freeze glock, so we have to check carefully.
  *
  * At the moment this deals only with atime - it should be possible
  * to expand that role in future, once a review of the locking has
@@ -550,15 +563,8 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 				   gfs2_log_is_empty(sdp),
 				   HZ * 5);
 		gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
-	} else {
-		wait_event_timeout(sdp->sd_log_waitq,
-				   gfs2_log_is_empty(sdp),
-				   HZ * 5);
 	}
 	gfs2_quota_cleanup(sdp);
-
-	if (!log_write_allowed)
-		sdp->sd_vfs->s_flags |= SB_RDONLY;
 }
 
 /**
@@ -594,12 +600,16 @@ static void gfs2_put_super(struct super_block *sb)
 	} else {
 		gfs2_quota_cleanup(sdp);
 	}
+	if (gfs2_withdrawn(sdp))
+		gfs2_quota_cleanup(sdp);
 	WARN_ON(gfs2_withdrawing(sdp));
 
 	/*  At this point, we're through modifying the disk  */
 
 	/*  Release stuff  */
 
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
 	iput(sdp->sd_jindex);
 	iput(sdp->sd_statfs_inode);
 	iput(sdp->sd_rindex);
@@ -654,59 +664,116 @@ static int gfs2_sync_fs(struct super_block *sb, int wait)
 	return sdp->sd_log_error;
 }
 
-void gfs2_freeze_func(struct work_struct *work)
+static int gfs2_freeze_locally(struct gfs2_sbd *sdp)
 {
-	int error;
-	struct gfs2_holder freeze_gh;
-	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
 	struct super_block *sb = sdp->sd_vfs;
+	int error;
 
-	atomic_inc(&sb->s_active);
-	error = gfs2_freeze_lock(sdp, &freeze_gh, 0);
-	if (error) {
-		gfs2_assert_withdraw(sdp, 0);
-	} else {
-		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
-		error = thaw_super(sb);
-		if (error) {
-			fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n",
-				error);
-			gfs2_assert_withdraw(sdp, 0);
+	atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
+
+	error = freeze_super(sb);
+	if (error)
+		goto fail;
+
+	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
+			       GFS2_LFC_FREEZE_GO_SYNC);
+		if (gfs2_withdrawn(sdp)) {
+			thaw_super(sb);
+			error = -EIO;
+			goto fail;
 		}
-		gfs2_freeze_unlock(&freeze_gh);
 	}
+	return 0;
+
+fail:
+	atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
+	return error;
+}
+
+static int gfs2_do_thaw(struct gfs2_sbd *sdp)
+{
+	struct super_block *sb = sdp->sd_vfs;
+	int error;
+
+	error = gfs2_freeze_lock_shared(sdp, &sdp->sd_freeze_gh, 0);
+	if (error)
+		goto fail;
+	error = thaw_super(sb);
+	if (!error)
+		return 0;
+
+fail:
+	fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n", error);
+	gfs2_assert_withdraw(sdp, 0);
+	return error;
+}
+
+void gfs2_freeze_func(struct work_struct *work)
+{
+	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
+	struct super_block *sb = sdp->sd_vfs;
+	int error;
+
+	mutex_lock(&sdp->sd_freeze_mutex);
+	error = -EBUSY;
+	if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN)
+		goto freeze_failed;
+
+	error = gfs2_freeze_locally(sdp);
+	if (error)
+		goto freeze_failed;
+
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+	atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
+
+	error = gfs2_do_thaw(sdp);
+	if (error)
+		goto out;
+
+	atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
+	goto out;
+
+freeze_failed:
+	fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n", error);
+
+out:
+	mutex_unlock(&sdp->sd_freeze_mutex);
 	deactivate_super(sb);
-	clear_bit_unlock(SDF_FS_FROZEN, &sdp->sd_flags);
-	wake_up_bit(&sdp->sd_flags, SDF_FS_FROZEN);
-	return;
 }
 
 /**
- * gfs2_freeze - prevent further writes to the filesystem
+ * gfs2_freeze_super - prevent further writes to the filesystem
  * @sb: the VFS structure for the filesystem
  *
  */
 
-static int gfs2_freeze(struct super_block *sb)
+static int gfs2_freeze_super(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
 
-	mutex_lock(&sdp->sd_freeze_mutex);
-	if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN) {
-		error = -EBUSY;
+	if (!mutex_trylock(&sdp->sd_freeze_mutex))
+		return -EBUSY;
+	error = -EBUSY;
+	if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN)
 		goto out;
-	}
 
 	for (;;) {
-		if (gfs2_withdrawn(sdp)) {
-			error = -EINVAL;
+		error = gfs2_freeze_locally(sdp);
+		if (error) {
+			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
+				error);
 			goto out;
 		}
 
 		error = gfs2_lock_fs_check_clean(sdp);
 		if (!error)
-			break;
+			break;  /* success */
+
+		error = gfs2_do_thaw(sdp);
+		if (error)
+			goto out;
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");
@@ -720,32 +787,60 @@ static int gfs2_freeze(struct super_block *sb)
 		fs_err(sdp, "retrying...\n");
 		msleep(1000);
 	}
-	set_bit(SDF_FS_FROZEN, &sdp->sd_flags);
+
 out:
+	if (!error) {
+		set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
+		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
+	}
 	mutex_unlock(&sdp->sd_freeze_mutex);
 	return error;
 }
 
 /**
- * gfs2_unfreeze - reallow writes to the filesystem
+ * gfs2_thaw_super - reallow writes to the filesystem
  * @sb: the VFS structure for the filesystem
  *
  */
 
-static int gfs2_unfreeze(struct super_block *sb)
+static int gfs2_thaw_super(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
+	int error;
 
-	mutex_lock(&sdp->sd_freeze_mutex);
-	if (atomic_read(&sdp->sd_freeze_state) != SFS_FROZEN ||
-	    !gfs2_holder_initialized(&sdp->sd_freeze_gh)) {
-		mutex_unlock(&sdp->sd_freeze_mutex);
-		return -EINVAL;
+	if (!mutex_trylock(&sdp->sd_freeze_mutex))
+		return -EBUSY;
+	error = -EINVAL;
+	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
+		goto out;
+
+	atomic_inc(&sb->s_active);
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
+	error = gfs2_do_thaw(sdp);
+
+	if (!error) {
+		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
+		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
 	}
+out:
+	mutex_unlock(&sdp->sd_freeze_mutex);
+	deactivate_super(sb);
+	return error;
+}
+
+void gfs2_thaw_freeze_initiator(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+
+	mutex_lock(&sdp->sd_freeze_mutex);
+	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
+		goto out;
 
 	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
+out:
 	mutex_unlock(&sdp->sd_freeze_mutex);
-	return wait_on_bit(&sdp->sd_flags, SDF_FS_FROZEN, TASK_INTERRUPTIBLE);
 }
 
 /**
@@ -1499,8 +1594,8 @@ const struct super_operations gfs2_super_ops = {
 	.evict_inode		= gfs2_evict_inode,
 	.put_super		= gfs2_put_super,
 	.sync_fs		= gfs2_sync_fs,
-	.freeze_super		= gfs2_freeze,
-	.thaw_super		= gfs2_unfreeze,
+	.freeze_super		= gfs2_freeze_super,
+	.thaw_super		= gfs2_thaw_super,
 	.statfs			= gfs2_statfs,
 	.drop_inode		= gfs2_drop_inode,
 	.show_options		= gfs2_show_options,
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 58d13fd77aed..bba58629bc45 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -46,6 +46,7 @@ extern void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc,
 extern void update_statfs(struct gfs2_sbd *sdp, struct buffer_head *m_bh);
 extern int gfs2_statfs_sync(struct super_block *sb, int type);
 extern void gfs2_freeze_func(struct work_struct *work);
+extern void gfs2_thaw_freeze_initiator(struct super_block *sb);
 
 extern void free_local_statfs_inodes(struct gfs2_sbd *sdp);
 extern struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp,
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index d87ea98cf535..e1fa76d4a7c2 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -110,7 +110,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     test_bit(SDF_RORECOVERY, &f),
 		     test_bit(SDF_SKIP_DLM_UNLOCK, &f),
 		     test_bit(SDF_FORCE_AIL_FLUSH, &f),
-		     test_bit(SDF_FS_FROZEN, &f),
+		     test_bit(SDF_FREEZE_INITIATOR, &f),
 		     test_bit(SDF_WITHDRAWING, &f),
 		     test_bit(SDF_WITHDRAW_IN_PROG, &f),
 		     test_bit(SDF_REMOTE_WITHDRAW, &f),
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 48c69aa60cd1..30b8821c54ad 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/buffer_head.h>
+#include <linux/kthread.h>
 #include <linux/crc32.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/delay.h>
@@ -93,13 +94,13 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 }
 
 /**
- * gfs2_freeze_lock - hold the freeze glock
+ * gfs2_freeze_lock_shared - hold the freeze glock
  * @sdp: the superblock
  * @freeze_gh: pointer to the requested holder
  * @caller_flags: any additional flags needed by the caller
  */
-int gfs2_freeze_lock(struct gfs2_sbd *sdp, struct gfs2_holder *freeze_gh,
-		     int caller_flags)
+int gfs2_freeze_lock_shared(struct gfs2_sbd *sdp, struct gfs2_holder *freeze_gh,
+			    int caller_flags)
 {
 	int flags = LM_FLAG_NOEXP | GL_EXACT | caller_flags;
 	int error;
@@ -107,7 +108,7 @@ int gfs2_freeze_lock(struct gfs2_sbd *sdp, struct gfs2_holder *freeze_gh,
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED, flags,
 				   freeze_gh);
 	if (error && error != GLR_TRYFAILED)
-		fs_err(sdp, "can't lock the freeze lock: %d\n", error);
+		fs_err(sdp, "can't lock the freeze glock: %d\n", error);
 	return error;
 }
 
@@ -124,7 +125,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	struct gfs2_inode *ip;
 	struct gfs2_glock *i_gl;
 	u64 no_formal_ino;
-	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	int ret = 0;
 	int tries;
 
@@ -152,24 +152,34 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 */
 	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	if (!sb_rdonly(sdp->sd_vfs)) {
-		struct gfs2_holder freeze_gh;
-
-		gfs2_holder_mark_uninitialized(&freeze_gh);
-		if (sdp->sd_freeze_gl &&
-		    !gfs2_glock_is_locked_by_me(sdp->sd_freeze_gl)) {
-			ret = gfs2_freeze_lock(sdp, &freeze_gh,
-				       log_write_allowed ? 0 : LM_FLAG_TRY);
-			if (ret == GLR_TRYFAILED)
-				ret = 0;
+		bool locked = mutex_trylock(&sdp->sd_freeze_mutex);
+
+		if (sdp->sd_quotad_process &&
+		    current != sdp->sd_quotad_process) {
+			kthread_stop(sdp->sd_quotad_process);
+			sdp->sd_quotad_process = NULL;
 		}
-		if (!ret)
-			gfs2_make_fs_ro(sdp);
+
+		if (sdp->sd_logd_process &&
+		    current != sdp->sd_logd_process) {
+			kthread_stop(sdp->sd_logd_process);
+			sdp->sd_logd_process = NULL;
+		}
+
+		wait_event_timeout(sdp->sd_log_waitq,
+				   gfs2_log_is_empty(sdp),
+				   HZ * 5);
+
+		sdp->sd_vfs->s_flags |= SB_RDONLY;
+
+		if (locked)
+			mutex_unlock(&sdp->sd_freeze_mutex);
+
 		/*
 		 * Dequeue any pending non-system glock holders that can no
 		 * longer be granted because the file system is withdrawn.
 		 */
 		gfs2_gl_dq_holders(sdp);
-		gfs2_freeze_unlock(&freeze_gh);
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_lock == NULL) { /* lock_nolock */
@@ -187,15 +197,8 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	}
 	sdp->sd_jinode_gh.gh_flags |= GL_NOCACHE;
 	gfs2_glock_dq(&sdp->sd_jinode_gh);
-	if (test_bit(SDF_FS_FROZEN, &sdp->sd_flags)) {
-		/* Make sure gfs2_unfreeze works if partially-frozen */
-		flush_work(&sdp->sd_freeze_work);
-		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
-		thaw_super(sdp->sd_vfs);
-	} else {
-		wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE,
-			    TASK_UNINTERRUPTIBLE);
-	}
+	gfs2_thaw_freeze_initiator(sdp->sd_vfs);
+	wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE, TASK_UNINTERRUPTIBLE);
 
 	/*
 	 * holder_uninit to force glock_put, to force dlm to let go
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 78ec190f4155..3291e33e81e9 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -149,8 +149,9 @@ int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function,
 
 extern int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 			       bool verbose);
-extern int gfs2_freeze_lock(struct gfs2_sbd *sdp,
-			    struct gfs2_holder *freeze_gh, int caller_flags);
+extern int gfs2_freeze_lock_shared(struct gfs2_sbd *sdp,
+				   struct gfs2_holder *freeze_gh,
+				   int caller_flags);
 extern void gfs2_freeze_unlock(struct gfs2_holder *freeze_gh);
 
 #define gfs2_io_error(sdp) \
diff --git a/fs/inode.c b/fs/inode.c
index 8cfda7a6d590..417ba66af4a3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -486,6 +486,39 @@ static void inode_lru_list_del(struct inode *inode)
 		this_cpu_dec(nr_unused);
 }
 
+static void inode_pin_lru_isolating(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	inode->i_state |= I_LRU_ISOLATING;
+}
+
+static void inode_unpin_lru_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
+	inode->i_state &= ~I_LRU_ISOLATING;
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	spin_unlock(&inode->i_lock);
+}
+
+static void inode_wait_for_lru_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (inode->i_state & I_LRU_ISOLATING) {
+		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
+		wait_queue_head_t *wqh;
+
+		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
+		spin_unlock(&inode->i_lock);
+		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
+		spin_lock(&inode->i_lock);
+		WARN_ON(inode->i_state & I_LRU_ISOLATING);
+	}
+	spin_unlock(&inode->i_lock);
+}
+
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
  * @inode: inode to add
@@ -654,6 +687,8 @@ static void evict(struct inode *inode)
 
 	inode_sb_list_del(inode);
 
+	inode_wait_for_lru_isolating(inode);
+
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
@@ -855,7 +890,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * be under pressure before the cache inside the highmem zone.
 	 */
 	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
-		__iget(inode);
+		inode_pin_lru_isolating(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(lru_lock);
 		if (remove_inode_buffers(inode)) {
@@ -868,7 +903,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 			if (current->reclaim_state)
 				current->reclaim_state->reclaimed_slab += reap;
 		}
-		iput(inode);
+		inode_unpin_lru_isolating(inode);
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c8d59f7c4745..d3d3ea439d29 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -971,10 +971,13 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 {
 	int err = 0;
 	unsigned long long ret;
-	sector_t block = 0;
+	sector_t block = blocknr;
 
-	if (journal->j_inode) {
-		block = blocknr;
+	if (journal->j_bmap) {
+		err = journal->j_bmap(journal, &block);
+		if (err == 0)
+			*retp = block;
+	} else if (journal->j_inode) {
 		ret = bmap(journal->j_inode, &block);
 
 		if (ret || !block) {
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 4462274e325a..d2df00676292 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1626,6 +1626,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 031d8f570f58..5d3127ca68a4 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -834,6 +834,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
+	if (p->header.freelist == 0)
+		return -EINVAL;
 
 	/*
 	 *	insert entry for new key
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e4a50e4ff0d2..adf3536cfec8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -532,9 +532,11 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out_put;
 
 	rc = 0;
-	of->mmapped = true;
-	of_on(of)->nr_mmapped++;
-	of->vm_ops = vma->vm_ops;
+	if (!of->mmapped) {
+		of->mmapped = true;
+		of_on(of)->nr_mmapped++;
+		of->vm_ops = vma->vm_ops;
+	}
 	vma->vm_ops = &kernfs_vm_ops;
 out_put:
 	kernfs_put_active(of->kn);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4448ff829cbb..8c1f47ca5dc5 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1997,6 +1997,14 @@ pnfs_update_layout(struct inode *ino,
 	}
 
 lookup_again:
+	if (!nfs4_valid_open_stateid(ctx->state)) {
+		trace_pnfs_update_layout(ino, pos, count,
+					 iomode, lo, lseg,
+					 PNFS_UPDATE_LAYOUT_INVALID_OPEN);
+		lseg = ERR_PTR(-EIO);
+		goto out;
+	}
+
 	lseg = ERR_PTR(nfs4_client_recover_expired_lease(clp));
 	if (IS_ERR(lseg))
 		goto out;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7451cd34710d..df9dbd93663e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1106,6 +1106,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	struct inode *inode;
 	__be32 status = nfs_ok;
+	bool save_no_wcc;
 	int err;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
@@ -1131,8 +1132,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (status)
 		goto out;
+	save_no_wcc = cstate->current_fh.fh_no_wcc;
+	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
 				0, (time64_t)0);
+	cstate->current_fh.fh_no_wcc = save_no_wcc;
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
 	if (!status)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8d15959004ad..f04de2553c90 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -318,6 +318,7 @@ free_nbl(struct kref *kref)
 	struct nfsd4_blocked_lock *nbl;
 
 	nbl = container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
+	locks_release_private(&nbl->nbl_lock);
 	kfree(nbl);
 }
 
@@ -325,7 +326,6 @@ static void
 free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 {
 	locks_delete_block(&nbl->nbl_lock);
-	locks_release_private(&nbl->nbl_lock);
 	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 813ae75e7128..2feaa49fb9fe 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -709,6 +709,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	char *mesg = buf;
 	int fd, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	err = get_int(&mesg, &fd);
 	if (err != 0 || fd < 0)
@@ -718,13 +719,15 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	serv = nn->nfsd_serv;
+	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err >= 0 &&
-	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+	else if (err >= 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
@@ -738,6 +741,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	struct svc_xprt *xprt;
 	int port, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
 		return -EINVAL;
@@ -749,29 +753,33 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err != 0)
 		return err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	serv = nn->nfsd_serv;
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0)
 		goto out_err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return 0;
 out_close:
-	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
+	xprt = svc_find_xprt(serv, transport, net, PF_INET, port);
 	if (xprt != NULL) {
 		svc_xprt_close(xprt);
 		svc_xprt_put(xprt);
 	}
 out_err:
-	nfsd_put(net);
+	if (!serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+
+	svc_put(serv);
 	return err;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 0e557fb60a0e..996f3f62335b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -97,8 +97,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-void		nfsd_put(struct net *net);
-
 bool		i_am_nfsd(void);
 
 struct nfsdfs_client {
@@ -134,6 +132,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
+void nfsd_last_thread(struct net *net);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9eb529969b22..80a2b3631adb 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -532,9 +532,14 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
+void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+
+	spin_lock(&nfsd_notifier_lock);
+	nn->nfsd_serv = NULL;
+	spin_unlock(&nfsd_notifier_lock);
 
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
@@ -544,6 +549,8 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 #endif
 	}
 
+	svc_xprt_destroy_all(serv, net);
+
 	/*
 	 * write_ports can create the server without actually starting
 	 * any threads--if we get shut down before any threads are
@@ -555,7 +562,6 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 		return;
 
 	nfsd_shutdown_net(net);
-	pr_info("nfsd: last server has exited, flushing export cache\n");
 	nfsd_export_flush(net);
 }
 
@@ -634,7 +640,8 @@ void nfsd_shutdown_threads(struct net *net)
 	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
-	nfsd_put(net);
+	nfsd_last_thread(net);
+	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -665,9 +672,6 @@ int nfsd_create_serv(struct net *net)
 	serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(serv, net);
 	if (error < 0) {
-		/* NOT nfsd_put() as notifiers (see below) haven't
-		 * been set up yet.
-		 */
 		svc_put(serv);
 		return error;
 	}
@@ -710,29 +714,6 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
-/* This is the callback for kref_put() below.
- * There is no code here as the first thing to be done is
- * call svc_shutdown_net(), but we cannot get the 'net' from
- * the kref.  So do all the work when kref_put returns true.
- */
-static void nfsd_noop(struct kref *ref)
-{
-}
-
-void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
-		svc_xprt_destroy_all(nn->nfsd_serv, net);
-		nfsd_last_thread(nn->nfsd_serv, net);
-		svc_destroy(&nn->nfsd_serv->sv_refcnt);
-		spin_lock(&nfsd_notifier_lock);
-		nn->nfsd_serv = NULL;
-		spin_unlock(&nfsd_notifier_lock);
-	}
-}
-
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 {
 	int i = 0;
@@ -783,7 +764,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	nfsd_put(net);
+	svc_put(nn->nfsd_serv);
 	return err;
 }
 
@@ -796,8 +777,8 @@ int
 nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 {
 	int	error;
-	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	mutex_lock(&nfsd_mutex);
 	dprintk("nfsd: creating service\n");
@@ -815,24 +796,23 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
-
-	nfsd_up_before = nn->nfsd_net_up;
+	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
-	error = svc_set_num_threads(nn->nfsd_serv, NULL, nrservs);
+	error = svc_set_num_threads(serv, NULL, nrservs);
 	if (error)
-		goto out_shutdown;
-	error = nn->nfsd_serv->sv_nrthreads;
-out_shutdown:
-	if (error < 0 && !nfsd_up_before)
-		nfsd_shutdown_net(net);
+		goto out_put;
+	error = serv->sv_nrthreads;
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
-		nfsd_put(net);
-	nfsd_put(net);
+		svc_put(serv);
+
+	if (serv->sv_nrthreads == 0)
+		nfsd_last_thread(net);
+	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
@@ -983,31 +963,8 @@ nfsd(void *vrqstp)
 	atomic_dec(&nfsd_th_cnt);
 
 out:
-	/* Take an extra ref so that the svc_put in svc_exit_thread()
-	 * doesn't call svc_destroy()
-	 */
-	svc_get(nn->nfsd_serv);
-
 	/* Release the thread */
 	svc_exit_thread(rqstp);
-
-	/* We need to drop a ref, but may not drop the last reference
-	 * without holding nfsd_mutex, and we cannot wait for nfsd_mutex as that
-	 * could deadlock with nfsd_shutdown_threads() waiting for us.
-	 * So three options are:
-	 * - drop a non-final reference,
-	 * - get the mutex without waiting
-	 * - sleep briefly andd try the above again
-	 */
-	while (!svc_put_not_last(nn->nfsd_serv)) {
-		if (mutex_trylock(&nfsd_mutex)) {
-			nfsd_put(net);
-			mutex_unlock(&nfsd_mutex);
-			break;
-		}
-		msleep(20);
-	}
-
 	return 0;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 17e96e58e772..8f6d611d1380 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -475,7 +475,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
-	int		host_err;
+	int		host_err = 0;
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
@@ -533,6 +533,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
+	fh_fill_pre_attrs(fhp);
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -560,13 +561,14 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&init_user_ns,
 						inode, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+	fh_fill_post_attrs(fhp);
 	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	return nfserrno(host_err);
+	return err != 0 ? err : nfserrno(host_err);
 }
 
 #if defined(CONFIG_NFSD_V4)
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index bd24a33fc72e..42617080a838 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2224,6 +2224,7 @@ static int nilfs_btree_assign_p(struct nilfs_bmap *btree,
 	/* on-disk format */
 	binfo->bi_dat.bi_blkoff = cpu_to_le64(key);
 	binfo->bi_dat.bi_level = level;
+	memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
 
 	return 0;
 }
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 242cc36bf1e9..351010828d88 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -158,6 +158,7 @@ void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
 int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 {
 	struct nilfs_dat_entry *entry;
+	__u64 start;
 	sector_t blocknr;
 	void *kaddr;
 	int ret;
@@ -169,6 +170,7 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
+	start = le64_to_cpu(entry->de_start);
 	blocknr = le64_to_cpu(entry->de_blocknr);
 	kunmap_atomic(kaddr);
 
@@ -179,6 +181,15 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 			return ret;
 		}
 	}
+	if (unlikely(start > nilfs_mdt_cno(dat))) {
+		nilfs_err(dat->i_sb,
+			  "vblocknr = %llu has abnormal lifetime: start cno (= %llu) > current cno (= %llu)",
+			  (unsigned long long)req->pr_entry_nr,
+			  (unsigned long long)start,
+			  (unsigned long long)nilfs_mdt_cno(dat));
+		nilfs_dat_abort_entry(dat, req);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 8f802f7b0840..893ab36824cc 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -319,6 +319,7 @@ static int nilfs_direct_assign_p(struct nilfs_bmap *direct,
 
 	binfo->bi_dat.bi_blkoff = cpu_to_le64(key);
 	binfo->bi_dat.bi_level = 0;
+	memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
 
 	return 0;
 }
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index dfe4930ccec6..70d9d08fc61b 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -656,7 +656,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 	wnd->total_zeroes = nbits;
 	wnd->extent_max = MINUS_ONE_T;
 	wnd->zone_bit = wnd->zone_end = 0;
-	wnd->nwnd = bytes_to_block(sb, bitmap_size(nbits));
+	wnd->nwnd = bytes_to_block(sb, ntfs3_bitmap_size(nbits));
 	wnd->bits_last = nbits & (wbits - 1);
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
@@ -1320,7 +1320,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		return -EINVAL;
 
 	/* Align to 8 byte boundary. */
-	new_wnd = bytes_to_block(sb, bitmap_size(new_bits));
+	new_wnd = bytes_to_block(sb, ntfs3_bitmap_size(new_bits));
 	new_last = new_bits & (wbits - 1);
 	if (!new_last)
 		new_last = wbits;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 02465ab3f398..6cce71cc750e 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1897,6 +1897,47 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return REPARSE_LINK;
 }
 
+/*
+ * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
+ * but it accepts kernel address for fi_extents_start
+ */
+static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
+				     u64 logical, u64 phys, u64 len, u32 flags)
+{
+	struct fiemap_extent extent;
+	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+
+	/* only count the extents */
+	if (fieinfo->fi_extents_max == 0) {
+		fieinfo->fi_extents_mapped++;
+		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+	}
+
+	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
+		return 1;
+
+	if (flags & FIEMAP_EXTENT_DELALLOC)
+		flags |= FIEMAP_EXTENT_UNKNOWN;
+	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
+		flags |= FIEMAP_EXTENT_ENCODED;
+	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
+		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
+
+	memset(&extent, 0, sizeof(extent));
+	extent.fe_logical = logical;
+	extent.fe_physical = phys;
+	extent.fe_length = len;
+	extent.fe_flags = flags;
+
+	dest += fieinfo->fi_extents_mapped;
+	memcpy(dest, &extent, sizeof(extent));
+
+	fieinfo->fi_extents_mapped++;
+	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
+		return 1;
+	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+}
+
 /*
  * ni_fiemap - Helper for file_fiemap().
  *
@@ -1907,6 +1948,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
+	struct fiemap_extent __user *fe_u = fieinfo->fi_extents_start;
+	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	struct runs_tree *run;
@@ -1954,6 +1997,18 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
+	/*
+	 * To avoid lock problems replace pointer to user memory by pointer to kernel memory.
+	 */
+	fe_k = kmalloc_array(fieinfo->fi_extents_max,
+			     sizeof(struct fiemap_extent),
+			     GFP_NOFS | __GFP_ZERO);
+	if (!fe_k) {
+		err = -ENOMEM;
+		goto out;
+	}
+	fieinfo->fi_extents_start = fe_k;
+
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (end > alloc_size)
@@ -2042,8 +2097,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+			err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, dlen,
+							flags);
+
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2063,7 +2119,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, bytes,
+						flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2076,7 +2133,19 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 
 	up_read(run_lock);
 
+	/*
+	 * Copy to user memory out of lock
+	 */
+	if (copy_to_user(fe_u, fe_k,
+			 fieinfo->fi_extents_max *
+				 sizeof(struct fiemap_extent))) {
+		err = -EFAULT;
+	}
+
 out:
+	/* Restore original pointer. */
+	fieinfo->fi_extents_start = fe_u;
+	kfree(fe_k);
 	return err;
 }
 
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 97723a839c81..a7e2009419c3 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -493,7 +493,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 	ni->mi.dirty = true;
 
 	/* Step 2: Resize $MFT::BITMAP. */
-	new_bitmap_bytes = bitmap_size(new_mft_total);
+	new_bitmap_bytes = ntfs3_bitmap_size(new_mft_total);
 
 	err = attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
 			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 9c36e0f3468d..2589f6d1215f 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1454,8 +1454,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	alloc->nres.valid_size = alloc->nres.data_size = cpu_to_le64(data_size);
 
-	err = ni_insert_resident(ni, bitmap_size(1), ATTR_BITMAP, in->name,
-				 in->name_len, &bitmap, NULL, NULL);
+	err = ni_insert_resident(ni, ntfs3_bitmap_size(1), ATTR_BITMAP,
+				 in->name, in->name_len, &bitmap, NULL, NULL);
 	if (err)
 		goto out2;
 
@@ -1516,8 +1516,9 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (bmp) {
 		/* Increase bitmap. */
 		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
-				    &indx->bitmap_run, bitmap_size(bit + 1),
-				    NULL, true, NULL);
+				    &indx->bitmap_run,
+				    ntfs3_bitmap_size(bit + 1), NULL, true,
+				    NULL);
 		if (err)
 			goto out1;
 	}
@@ -2080,7 +2081,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (err)
 		return err;
 
-	bpb = bitmap_size(bit);
+	bpb = ntfs3_bitmap_size(bit);
 	if (bpb * 8 == nbits)
 		return 0;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 3e65ccccdb89..a88f6879fcaa 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -951,9 +951,9 @@ static inline bool run_is_empty(struct runs_tree *run)
 }
 
 /* NTFS uses quad aligned bitmaps. */
-static inline size_t bitmap_size(size_t bits)
+static inline size_t ntfs3_bitmap_size(size_t bits)
 {
-	return ALIGN((bits + 7) >> 3, 8);
+	return BITS_TO_U64(bits) * sizeof(u64);
 }
 
 #define _100ns2seconds 10000000
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ab0711185b3d..667ff92f5afc 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1108,7 +1108,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Check bitmap boundary. */
 	tt = sbi->used.bitmap.nbits;
-	if (inode->i_size < bitmap_size(tt)) {
+	if (inode->i_size < ntfs3_bitmap_size(tt)) {
 		err = -EINVAL;
 		goto put_inode_out;
 	}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b67557647d61..f7ab6b44011b 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -995,9 +995,8 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * smp_mb__before_atomic() in dquot_acquire().
 	 */
 	smp_rmb();
-#ifdef CONFIG_QUOTA_DEBUG
-	BUG_ON(!dquot->dq_sb);	/* Has somebody invalidated entry under us? */
-#endif
+	/* Has somebody invalidated entry under us? */
+	WARN_ON_ONCE(hlist_unhashed(&dquot->dq_hash));
 out:
 	if (empty)
 		do_destroy_dquot(empty);
diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 0f1493e0f6d0..254f6359b287 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -21,6 +21,12 @@ MODULE_AUTHOR("Jan Kara");
 MODULE_DESCRIPTION("Quota trie support");
 MODULE_LICENSE("GPL");
 
+/*
+ * Maximum quota tree depth we support. Only to limit recursion when working
+ * with the tree.
+ */
+#define MAX_QTREE_DEPTH 6
+
 #define __QUOTA_QT_PARANOIA
 
 static int __get_index(struct qtree_mem_dqinfo *info, qid_t id, int depth)
@@ -327,27 +333,36 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 
 /* Insert reference to structure into the trie */
 static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
-			  uint *treeblk, int depth)
+			  uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0, newson = 0, newact = 0;
 	__le32 *ref;
 	uint newblk;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	if (!*treeblk) {
+	if (!blks[depth]) {
 		ret = get_free_dqblk(info);
 		if (ret < 0)
 			goto out_buf;
-		*treeblk = ret;
+		for (i = 0; i < depth; i++)
+			if (ret == blks[i]) {
+				quota_error(dquot->dq_sb,
+					"Free block already used in tree: block %u",
+					ret);
+				ret = -EIO;
+				goto out_buf;
+			}
+		blks[depth] = ret;
 		memset(buf, 0, info->dqi_usable_bs);
 		newact = 1;
 	} else {
-		ret = read_blk(info, *treeblk, buf);
+		ret = read_blk(info, blks[depth], buf);
 		if (ret < 0) {
 			quota_error(dquot->dq_sb, "Can't read tree quota "
-				    "block %u", *treeblk);
+				    "block %u", blks[depth]);
 			goto out_buf;
 		}
 	}
@@ -357,8 +372,20 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			     info->dqi_blocks - 1);
 	if (ret)
 		goto out_buf;
-	if (!newblk)
+	if (!newblk) {
 		newson = 1;
+	} else {
+		for (i = 0; i <= depth; i++)
+			if (newblk == blks[i]) {
+				quota_error(dquot->dq_sb,
+					"Cycle in quota tree detected: block %u index %u",
+					blks[depth],
+					get_index(info, dquot->dq_id, depth));
+				ret = -EIO;
+				goto out_buf;
+			}
+	}
+	blks[depth + 1] = newblk;
 	if (depth == info->dqi_qtree_depth - 1) {
 #ifdef __QUOTA_QT_PARANOIA
 		if (newblk) {
@@ -370,16 +397,16 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			goto out_buf;
 		}
 #endif
-		newblk = find_free_dqentry(info, dquot, &ret);
+		blks[depth + 1] = find_free_dqentry(info, dquot, &ret);
 	} else {
-		ret = do_insert_tree(info, dquot, &newblk, depth+1);
+		ret = do_insert_tree(info, dquot, blks, depth + 1);
 	}
 	if (newson && ret >= 0) {
 		ref[get_index(info, dquot->dq_id, depth)] =
-							cpu_to_le32(newblk);
-		ret = write_blk(info, *treeblk, buf);
+						cpu_to_le32(blks[depth + 1]);
+		ret = write_blk(info, blks[depth], buf);
 	} else if (newact && ret < 0) {
-		put_free_dqblk(info, buf, *treeblk);
+		put_free_dqblk(info, buf, blks[depth]);
 	}
 out_buf:
 	kfree(buf);
@@ -390,7 +417,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
 				 struct dquot *dquot)
 {
-	int tmp = QT_TREEOFF;
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
 
 #ifdef __QUOTA_QT_PARANOIA
 	if (info->dqi_blocks <= QT_TREEOFF) {
@@ -398,7 +425,11 @@ static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
 		return -EIO;
 	}
 #endif
-	return do_insert_tree(info, dquot, &tmp, 0);
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return do_insert_tree(info, dquot, blks, 0);
 }
 
 /*
@@ -511,19 +542,20 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 
 /* Remove reference to dquot from tree */
 static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
-		       uint *blk, int depth)
+		       uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0;
 	uint newblk;
 	__le32 *ref = (__le32 *)buf;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	ret = read_blk(info, *blk, buf);
+	ret = read_blk(info, blks[depth], buf);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota data block %u",
-			    *blk);
+			    blks[depth]);
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
@@ -532,29 +564,38 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 	if (ret)
 		goto out_buf;
 
+	for (i = 0; i <= depth; i++)
+		if (newblk == blks[i]) {
+			quota_error(dquot->dq_sb,
+				"Cycle in quota tree detected: block %u index %u",
+				blks[depth],
+				get_index(info, dquot->dq_id, depth));
+			ret = -EIO;
+			goto out_buf;
+		}
 	if (depth == info->dqi_qtree_depth - 1) {
 		ret = free_dqentry(info, dquot, newblk);
-		newblk = 0;
+		blks[depth + 1] = 0;
 	} else {
-		ret = remove_tree(info, dquot, &newblk, depth+1);
+		blks[depth + 1] = newblk;
+		ret = remove_tree(info, dquot, blks, depth + 1);
 	}
-	if (ret >= 0 && !newblk) {
-		int i;
+	if (ret >= 0 && !blks[depth + 1]) {
 		ref[get_index(info, dquot->dq_id, depth)] = cpu_to_le32(0);
 		/* Block got empty? */
 		for (i = 0; i < (info->dqi_usable_bs >> 2) && !ref[i]; i++)
 			;
 		/* Don't put the root block into the free block list */
 		if (i == (info->dqi_usable_bs >> 2)
-		    && *blk != QT_TREEOFF) {
-			put_free_dqblk(info, buf, *blk);
-			*blk = 0;
+		    && blks[depth] != QT_TREEOFF) {
+			put_free_dqblk(info, buf, blks[depth]);
+			blks[depth] = 0;
 		} else {
-			ret = write_blk(info, *blk, buf);
+			ret = write_blk(info, blks[depth], buf);
 			if (ret < 0)
 				quota_error(dquot->dq_sb,
 					    "Can't write quota tree block %u",
-					    *blk);
+					    blks[depth]);
 		}
 	}
 out_buf:
@@ -565,11 +606,15 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 /* Delete dquot from tree */
 int qtree_delete_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 {
-	uint tmp = QT_TREEOFF;
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
 
 	if (!dquot->dq_off)	/* Even not allocated? */
 		return 0;
-	return remove_tree(info, dquot, &tmp, 0);
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return remove_tree(info, dquot, blks, 0);
 }
 EXPORT_SYMBOL(qtree_delete_dquot);
 
@@ -613,18 +658,20 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 
 /* Find entry for given id in the tree */
 static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
-				struct dquot *dquot, uint blk, int depth)
+				struct dquot *dquot, uint *blks, int depth)
 {
 	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	loff_t ret = 0;
 	__le32 *ref = (__le32 *)buf;
+	uint blk;
+	int i;
 
 	if (!buf)
 		return -ENOMEM;
-	ret = read_blk(info, blk, buf);
+	ret = read_blk(info, blks[depth], buf);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
-			    blk);
+			    blks[depth]);
 		goto out_buf;
 	}
 	ret = 0;
@@ -636,8 +683,19 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	if (ret)
 		goto out_buf;
 
+	/* Check for cycles in the tree */
+	for (i = 0; i <= depth; i++)
+		if (blk == blks[i]) {
+			quota_error(dquot->dq_sb,
+				"Cycle in quota tree detected: block %u index %u",
+				blks[depth],
+				get_index(info, dquot->dq_id, depth));
+			ret = -EIO;
+			goto out_buf;
+		}
+	blks[depth + 1] = blk;
 	if (depth < info->dqi_qtree_depth - 1)
-		ret = find_tree_dqentry(info, dquot, blk, depth+1);
+		ret = find_tree_dqentry(info, dquot, blks, depth + 1);
 	else
 		ret = find_block_dqentry(info, dquot, blk);
 out_buf:
@@ -649,7 +707,13 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 static inline loff_t find_dqentry(struct qtree_mem_dqinfo *info,
 				  struct dquot *dquot)
 {
-	return find_tree_dqentry(info, dquot, QT_TREEOFF, 0);
+	uint blks[MAX_QTREE_DEPTH] = { QT_TREEOFF };
+
+	if (info->dqi_qtree_depth >= MAX_QTREE_DEPTH) {
+		quota_error(dquot->dq_sb, "Quota tree depth too big!");
+		return -EIO;
+	}
+	return find_tree_dqentry(info, dquot, blks, 0);
 }
 
 int qtree_read_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index b1467f3921c2..6921d40645a7 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -166,14 +166,17 @@ static int v2_read_file_info(struct super_block *sb, int type)
 		    i_size_read(sb_dqopt(sb)->files[type]));
 		goto out_free;
 	}
-	if (qinfo->dqi_free_blk >= qinfo->dqi_blocks) {
-		quota_error(sb, "Free block number too big (%u >= %u).",
-			    qinfo->dqi_free_blk, qinfo->dqi_blocks);
+	if (qinfo->dqi_free_blk && (qinfo->dqi_free_blk <= QT_TREEOFF ||
+	    qinfo->dqi_free_blk >= qinfo->dqi_blocks)) {
+		quota_error(sb, "Free block number %u out of range (%u, %u).",
+			    qinfo->dqi_free_blk, QT_TREEOFF, qinfo->dqi_blocks);
 		goto out_free;
 	}
-	if (qinfo->dqi_free_entry >= qinfo->dqi_blocks) {
-		quota_error(sb, "Block with free entry too big (%u >= %u).",
-			    qinfo->dqi_free_entry, qinfo->dqi_blocks);
+	if (qinfo->dqi_free_entry && (qinfo->dqi_free_entry <= QT_TREEOFF ||
+	    qinfo->dqi_free_entry >= qinfo->dqi_blocks)) {
+		quota_error(sb, "Block with free entry %u out of range (%u, %u).",
+			    qinfo->dqi_free_entry, QT_TREEOFF,
+			    qinfo->dqi_blocks);
 		goto out_free;
 	}
 	ret = 0;
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 84c12a1947b2..6ecf77291968 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1409,7 +1409,7 @@ void reiserfs_delete_solid_item(struct reiserfs_transaction_handle *th,
 	INITIALIZE_PATH(path);
 	int item_len = 0;
 	int tb_init = 0;
-	struct cpu_key cpu_key;
+	struct cpu_key cpu_key = {};
 	int retval;
 	int quota_cut_bytes = 0;
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4ba6bf1535da..7263889a772d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4169,7 +4169,8 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
-				       sizeof(struct smb2_query_directory_rsp));
+				       offsetof(struct smb2_query_directory_rsp, Buffer)
+				       + 1);
 		if (rc)
 			goto err_out;
 	} else {
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 833aca92301f..45ea5d62cef4 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -198,7 +198,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
 		      compressed ? "" : "un", length);
 	}
-	if (length < 0 || length > output->length ||
+	if (length <= 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
 		res = -EIO;
 		goto out;
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..e8df6430444b 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -544,7 +544,8 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	struct squashfs_page_actor *actor;
 	unsigned int nr_pages = 0;
 	struct page **pages;
-	int i, file_end = i_size_read(inode) >> msblk->block_log;
+	int i;
+	loff_t file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
 	readahead_expand(ractl, start, (len | mask) + 1);
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index f1ccad519e28..763a3f7a75f6 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -26,10 +26,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	struct inode *inode = target_page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 
-	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
+	loff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = target_page->index & ~mask;
-	int end_index = start_index | mask;
+	loff_t start_index = target_page->index & ~mask;
+	loff_t end_index = start_index | mask;
 	int i, n, pages, bytes, res = -ENOMEM;
 	struct page **page;
 	struct squashfs_page_actor *actor;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64..ded71044988a 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1183,7 +1183,6 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	if (dir_fi) {
 		dir_fi->icb.extLocation = cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)dir_fi, udf_dir_entry_len(dir_fi));
 		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 			mark_inode_dirty(old_inode);
 		else
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..3c8d2b87a9ed 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -237,9 +237,11 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = 0;
@@ -249,7 +251,7 @@ static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = ~0UL;
@@ -260,7 +262,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = *src;
@@ -279,6 +281,18 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
 		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
 }
 
+static inline void bitmap_copy_and_extend(unsigned long *to,
+					  const unsigned long *from,
+					  unsigned int count, unsigned int size)
+{
+	unsigned int copy = BITS_TO_LONGS(count);
+
+	memcpy(to, from, copy * sizeof(long));
+	if (count % BITS_PER_LONG)
+		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
+	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
+}
+
 /*
  * On 32-bit systems bitmaps are represented as u32 arrays internally. On LE64
  * machines the order of hi and lo parts of numbers match the bitmap structure.
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6a524c5462a6..33b073deb8c1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -445,11 +445,6 @@ struct bpf_verifier_log {
 	u32 len_total;
 };
 
-static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
-{
-	return log->len_used >= log->len_total - 1;
-}
-
 #define BPF_LOG_LEVEL1	1
 #define BPF_LOG_LEVEL2	2
 #define BPF_LOG_STATS	4
@@ -459,6 +454,11 @@ static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U
 
+static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
+{
+	return log->len_used >= log->len_total - 1;
+}
+
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 {
 	return log &&
@@ -466,13 +466,6 @@ static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 		 log->level == BPF_LOG_KERNEL);
 }
 
-static inline bool
-bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
-{
-	return log->len_total >= 128 && log->len_total <= UINT_MAX >> 2 &&
-	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
-}
-
 #define BPF_MAX_SUBPROGS 256
 
 struct bpf_subprog_info {
@@ -556,12 +549,14 @@ struct bpf_verifier_env {
 	char type_str_buf[TYPE_STR_BUF_LEN];
 };
 
+bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log);
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
+void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos);
 
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
@@ -645,8 +640,8 @@ static inline u32 type_flag(u32 type)
 /* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
-	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
-		prog->aux->dst_prog->type : prog->type;
+	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
+		prog->aux->saved_dst_prog_type : prog->type;
 }
 
 static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index c2aa0aa26b45..76e6d42beb71 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -769,7 +769,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
  */
 static inline unsigned int cpumask_size(void)
 {
-	return BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long);
+	return bitmap_size(nr_cpumask_bits);
 }
 
 /*
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index dca2969015d8..6fbfbde68a37 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -5,6 +5,8 @@
 #ifndef _NET_DSA_TAG_OCELOT_H
 #define _NET_DSA_TAG_OCELOT_H
 
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/kthread.h>
 #include <linux/packing.h>
 #include <linux/skbuff.h>
@@ -273,4 +275,49 @@ static inline u32 ocelot_ptp_rew_op(struct sk_buff *skb)
 	return rew_op;
 }
 
+/**
+ * ocelot_xmit_get_vlan_info: Determine VLAN_TCI and TAG_TYPE for injected frame
+ * @skb: Pointer to socket buffer
+ * @br: Pointer to bridge device that the port is under, if any
+ * @vlan_tci:
+ * @tag_type:
+ *
+ * If the port is under a VLAN-aware bridge, remove the VLAN header from the
+ * payload and move it into the DSA tag, which will make the switch classify
+ * the packet to the bridge VLAN. Otherwise, leave the classified VLAN at zero,
+ * which is the pvid of standalone ports (OCELOT_STANDALONE_PVID), although not
+ * of VLAN-unaware bridge ports (that would be ocelot_vlan_unaware_pvid()).
+ * Anyway, VID 0 is fine because it is stripped on egress for these port modes,
+ * and source address learning is not performed for packets injected from the
+ * CPU anyway, so it doesn't matter that the VID is "wrong".
+ */
+static inline void ocelot_xmit_get_vlan_info(struct sk_buff *skb,
+					     struct net_device *br,
+					     u64 *vlan_tci, u64 *tag_type)
+{
+	struct vlan_ethhdr *hdr;
+	u16 proto, tci;
+
+	if (!br || !br_vlan_enabled(br)) {
+		*vlan_tci = 0;
+		*tag_type = IFH_TAG_TYPE_C;
+		return;
+	}
+
+	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
+	br_vlan_get_proto(br, &proto);
+
+	if (ntohs(hdr->h_vlan_proto) == proto) {
+		vlan_remove_tag(skb, &tci);
+		*vlan_tci = tci;
+	} else {
+		rcu_read_lock();
+		br_vlan_get_pvid_rcu(br, &tci);
+		rcu_read_unlock();
+		*vlan_tci = tci;
+	}
+
+	*tag_type = (proto != ETH_P_8021Q) ? IFH_TAG_TYPE_S : IFH_TAG_TYPE_C;
+}
+
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 092d8fa10153..f2206c78755a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2507,6 +2507,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
  *
+ * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
+ *			i_count.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2530,6 +2533,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
 #define I_PINNING_FSCACHE_WB	(1 << 18)
+#define __I_LRU_ISOLATING	19
+#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index e0d0a645be7c..83266201746c 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -704,6 +704,27 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
 		skb->protocol = htons(ETH_P_802_2);
 }
 
+/**
+ * vlan_remove_tag - remove outer VLAN tag from payload
+ * @skb: skbuff to remove tag from
+ * @vlan_tci: buffer to store value
+ *
+ * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
+ * pointing at the MAC header.
+ *
+ * Returns a new pointer to skb->data, or NULL on failure to pull.
+ */
+static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+{
+	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
+
+	*vlan_tci = ntohs(vhdr->h_vlan_TCI);
+
+	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
+	vlan_set_encap_proto(skb, vhdr);
+	return __skb_pull(skb, VLAN_HLEN);
+}
+
 /**
  * skb_vlan_tagged - check if skb is vlan tagged.
  * @skb: skbuff to query
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index e301d323108d..5bf7ada754d7 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1302,6 +1302,14 @@ struct journal_s
 				    struct buffer_head *bh,
 				    enum passtype pass, int off,
 				    tid_t expected_commit_id);
+
+	/**
+	 * @j_bmap:
+	 *
+	 * Bmap function that should be used instead of the generic
+	 * VFS bmap function.
+	 */
+	int (*j_bmap)(struct journal_s *journal, sector_t *block);
 };
 
 #define jbd2_might_wait_for_commit(j) \
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..bf3af54de616 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -67,7 +67,7 @@ struct pid
 	/* wait queue for pidfd notifications */
 	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
-	struct upid numbers[1];
+	struct upid numbers[];
 };
 
 extern struct pid init_struct_pid;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 20099268fa25..669e8cff40c7 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -135,7 +135,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index b8e77ffc3892..64cb4e26c8a6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -215,8 +215,9 @@ DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
 size_t ksize(const void *objp);
 
 #ifdef CONFIG_PRINTK
-bool kmem_valid_obj(void *object);
-void kmem_dump_obj(void *object);
+bool kmem_dump_obj(void *object);
+#else
+static inline bool kmem_dump_obj(void *object) { return false; }
 #endif
 
 /*
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 912da376ef9b..49621cc4e01b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -123,19 +123,6 @@ static inline void svc_put(struct svc_serv *serv)
 	kref_put(&serv->sv_refcnt, svc_destroy);
 }
 
-/**
- * svc_put_not_last - decrement non-final reference count on SUNRPC serv
- * @serv:  the svc_serv to have count decremented
- *
- * Returns: %true is refcount was decremented.
- *
- * If the refcount is 1, it is not decremented and instead failure is reported.
- */
-static inline bool svc_put_not_last(struct svc_serv *serv)
-{
-	return refcount_dec_not_one(&serv->sv_refcnt.refcount);
-}
-
 /*
  * Maximum payload size supported by a kernel RPC server.
  * This is use to determine the max number of pages nfsd is
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 79a4eae6f1f8..e0bbc05f001a 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -102,7 +102,7 @@ struct udp_sock {
 #define udp_assign_bit(nr, sk, val)		\
 	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
 
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 
 static inline struct udp_sock *udp_sk(const struct sock *sk)
 {
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 29b19d0a324c..823e28042f41 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,8 +3,8 @@
 #define _LINUX_VIRTIO_NET_H
 
 #include <linux/if_vlan.h>
+#include <linux/udp.h>
 #include <uapi/linux/tcp.h>
-#include <uapi/linux/udp.h>
 #include <uapi/linux/virtio_net.h>
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
@@ -51,7 +51,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
-	u64 ret, remainder, gso_size;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -88,16 +87,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
 
-		if (hdr->gso_size) {
-			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
-			ret = div64_u64_rem(skb->len, gso_size, &remainder);
-			if (!(ret && (hdr->gso_size > needed) &&
-						((remainder > needed) || (remainder == 0)))) {
-				return -EINVAL;
-			}
-			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
-		}
-
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;
 
@@ -155,9 +144,27 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* UFO may not include transport header in gso_size. */
-		if (gso_type & SKB_GSO_UDP)
+		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		case SKB_GSO_UDP:
+			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
+			break;
+		case SKB_GSO_UDP_L4:
+			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+				return -EINVAL;
+			if (skb->csum_offset != offsetof(struct udphdr, check))
+				return -EINVAL;
+			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
+				return -EINVAL;
+			if (gso_type != SKB_GSO_UDP_L4)
+				return -EINVAL;
+			break;
+		case SKB_GSO_TCPV4:
+		case SKB_GSO_TCPV6:
+			if (skb->csum_offset != offsetof(struct tcphdr, check))
+				return -EINVAL;
+			break;
+		}
 
 		/* Kernel has a special handling for GSO_BY_FRAGS. */
 		if (gso_size == GSO_BY_FRAGS)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5bf5c1ab542c..2a0fc4a64af1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6301,6 +6301,19 @@ static inline int ieee80211_data_to_8023(struct sk_buff *skb, const u8 *addr,
 	return ieee80211_data_to_8023_exthdr(skb, NULL, addr, iftype, 0, false);
 }
 
+/**
+ * ieee80211_is_valid_amsdu - check if subframe lengths of an A-MSDU are valid
+ *
+ * This is used to detect non-standard A-MSDU frames, e.g. the ones generated
+ * by ath10k and ath11k, where the subframe length includes the length of the
+ * mesh control field.
+ *
+ * @skb: The input A-MSDU frame without any headers.
+ * @mesh_hdr: use standard compliant mesh A-MSDU subframe header
+ * Returns: true if subframe header lengths are valid for the @mesh_hdr mode
+ */
+bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr);
+
 /**
  * ieee80211_amsdu_to_8023s - decode an IEEE 802.11n A-MSDU frame
  *
@@ -6316,11 +6329,36 @@ static inline int ieee80211_data_to_8023(struct sk_buff *skb, const u8 *addr,
  * @extra_headroom: The hardware extra headroom for SKBs in the @list.
  * @check_da: DA to check in the inner ethernet header, or NULL
  * @check_sa: SA to check in the inner ethernet header, or NULL
+ * @mesh_control: A-MSDU subframe header includes the mesh control field
  */
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
-			      const u8 *check_da, const u8 *check_sa);
+			      const u8 *check_da, const u8 *check_sa,
+			      bool mesh_control);
+
+/**
+ * ieee80211_get_8023_tunnel_proto - get RFC1042 or bridge tunnel encap protocol
+ *
+ * Check for RFC1042 or bridge tunnel header and fetch the encapsulated
+ * protocol.
+ *
+ * @hdr: pointer to the MSDU payload
+ * @proto: destination pointer to store the protocol
+ * Return: true if encapsulation was found
+ */
+bool ieee80211_get_8023_tunnel_proto(const void *hdr, __be16 *proto);
+
+/**
+ * ieee80211_strip_8023_mesh_hdr - strip mesh header from converted 802.3 frames
+ *
+ * Strip the mesh header, which was left in by ieee80211_data_to_8023 as part
+ * of the MSDU data. Also move any source/destination addresses from the mesh
+ * header to the ethernet header (if present).
+ *
+ * @skb: The 802.3 frame with embedded mesh header
+ */
+int ieee80211_strip_8023_mesh_hdr(struct sk_buff *skb);
 
 /**
  * cfg80211_classify8021d - determine the 802.1p/1d tag for a data frame
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 4a8e578405cb..9365e5af8d6d 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -114,7 +114,7 @@ static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo
 
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw);
 
-void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family);
+void inet_twsk_purge(struct inet_hashinfo *hashinfo);
 
 static inline
 struct net *twsk_net(const struct inet_timewait_sock *twsk)
diff --git a/include/net/kcm.h b/include/net/kcm.h
index 2d704f8f4905..8e8252e08a9c 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -70,6 +70,7 @@ struct kcm_sock {
 	struct work_struct tx_work;
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
+	struct mutex tx_mutex;
 	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index cc314c383c53..c7501ca66dd3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -352,7 +352,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
-void tcp_twsk_purge(struct list_head *net_exit_list, int family);
+void tcp_twsk_purge(struct list_head *net_exit_list);
 ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 7d3622db38ed..3a92245fd845 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -228,7 +228,7 @@ static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
 
 static inline unsigned int scsi_logical_block_count(struct scsi_cmnd *scmd)
 {
-	unsigned int shift = ilog2(scmd->device->sector_size) - SECTOR_SHIFT;
+	unsigned int shift = ilog2(scmd->device->sector_size);
 
 	return blk_rq_bytes(scsi_cmd_to_rq(scmd)) >> shift;
 }
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 195ca8f0b6f9..9b5562f54548 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -977,6 +977,9 @@ struct ocelot {
 	const struct ocelot_stat_layout	*stats_layout;
 	struct list_head		stats_regions;
 
+	spinlock_t			inj_lock;
+	spinlock_t			xtr_lock;
+
 	u32				pool_size[OCELOT_SB_NUM][OCELOT_SB_POOL_NUM];
 	int				packet_buffer_size;
 	int				num_frame_refs;
@@ -1125,10 +1128,17 @@ void __ocelot_target_write_ix(struct ocelot *ocelot, enum ocelot_target target,
 			      u32 val, u32 reg, u32 offset);
 
 /* Packet I/O */
+void ocelot_lock_inj_grp(struct ocelot *ocelot, int grp);
+void ocelot_unlock_inj_grp(struct ocelot *ocelot, int grp);
+void ocelot_lock_xtr_grp(struct ocelot *ocelot, int grp);
+void ocelot_unlock_xtr_grp(struct ocelot *ocelot, int grp);
+void ocelot_lock_xtr_grp_bh(struct ocelot *ocelot, int grp);
+void ocelot_unlock_xtr_grp_bh(struct ocelot *ocelot, int grp);
 bool ocelot_can_inject(struct ocelot *ocelot, int grp);
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb);
-void ocelot_ifh_port_set(void *ifh, int port, u32 rew_op, u32 vlan_tag);
+void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
+			  u32 rew_op, struct sk_buff *skb);
 int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **skb);
 void ocelot_drain_cpu_queue(struct ocelot *ocelot, int grp);
 void ocelot_ptp_rx_timestamp(struct ocelot *ocelot, struct sk_buff *skb,
diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 760455dfa860..01591e799523 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -36,7 +36,8 @@
 	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
 	EM( SCAN_TRUNCATED,		"truncated")			\
-	EMe(SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
+	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
+	EMe(SCAN_STORE_FAILED,		"store_failed")
 
 #undef EM
 #undef EMe
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a17688011440..58c7fc75da75 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -76,12 +76,29 @@ struct bpf_insn {
 	__s32	imm;		/* signed immediate constant */
 };
 
-/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
+ * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
+ * the trailing flexible array member) instead.
+ */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* Header for bpf_lpm_trie_key structs */
+struct bpf_lpm_trie_key_hdr {
+	__u32	prefixlen;
+};
+
+/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
+struct bpf_lpm_trie_key_u8 {
+	union {
+		struct bpf_lpm_trie_key_hdr	hdr;
+		__u32				prefixlen;
+	};
+	__u8	data[];		/* Arbitrary size */
+};
+
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
diff --git a/init/Kconfig b/init/Kconfig
index 4cd3fc82b09e..2825c8cfde3b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1942,12 +1942,15 @@ config RUST
 config RUSTC_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version || echo n)
+	default "$(shell,$(RUSTC) --version 2>/dev/null)"
 
 config BINDGEN_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,command -v $(BINDGEN) >/dev/null 2>&1 && $(BINDGEN) --version || echo n)
+	# The dummy parameter `workaround-for-0.69.0` is required to support 0.69.0
+	# (https://github.com/rust-lang/rust-bindgen/pull/2678). It can be removed when
+	# the minimum version is upgraded past that (0.69.1 already fixed the issue).
+	default "$(shell,$(BINDGEN) --version workaround-for-0.69.0 2>/dev/null)"
 
 #
 # Place an empty function call at each tracepoint site. Can be
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 341c94f208f4..5b86ea9f09c4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,8 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
new file mode 100644
index 000000000000..cd1b7113fbfd
--- /dev/null
+++ b/kernel/bpf/log.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
+ * Copyright (c) 2016 Facebook
+ * Copyright (c) 2018 Covalent IO, Inc. http://covalent.io
+ */
+#include <uapi/linux/btf.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+
+bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
+{
+	return log->len_total >= 128 && log->len_total <= UINT_MAX >> 2 &&
+	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
+}
+
+void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
+		       va_list args)
+{
+	unsigned int n;
+
+	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
+
+	if (log->level == BPF_LOG_KERNEL) {
+		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
+
+		pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
+		return;
+	}
+
+	n = min(log->len_total - log->len_used - 1, n);
+	log->kbuf[n] = '\0';
+	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
+		log->len_used += n;
+	else
+		log->ubuf = NULL;
+}
+
+void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
+{
+	char zero = 0;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+
+	log->len_used = new_pos;
+	if (put_user(zero, log->ubuf + new_pos))
+		log->ubuf = NULL;
+}
+
+/* log_level controls verbosity level of eBPF verifier.
+ * bpf_verifier_log_write() is used to dump the verification trace to the log,
+ * so the user can figure out what's wrong with the program
+ */
+__printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
+					   const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_verifier_log_needed(&env->log))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
+
+__printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
+			    const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(log, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(bpf_log);
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index ce3a091d52e8..37b510d91b81 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -164,13 +164,13 @@ static inline int extract_bit(const u8 *data, size_t index)
  */
 static size_t longest_prefix_match(const struct lpm_trie *trie,
 				   const struct lpm_trie_node *node,
-				   const struct bpf_lpm_trie_key *key)
+				   const struct bpf_lpm_trie_key_u8 *key)
 {
 	u32 limit = min(node->prefixlen, key->prefixlen);
 	u32 prefixlen = 0, i = 0;
 
 	BUILD_BUG_ON(offsetof(struct lpm_trie_node, data) % sizeof(u32));
-	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key, data) % sizeof(u32));
+	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key_u8, data) % sizeof(u32));
 
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(CONFIG_64BIT)
 
@@ -229,7 +229,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *found = NULL;
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 
 	if (key->prefixlen > trie->max_prefixlen)
 		return NULL;
@@ -308,8 +308,9 @@ static int trie_update_elem(struct bpf_map *map,
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
+	struct lpm_trie_node *free_node = NULL;
 	struct lpm_trie_node __rcu **slot;
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 	unsigned long irq_flags;
 	unsigned int next_bit;
 	size_t matchlen = 0;
@@ -382,7 +383,7 @@ static int trie_update_elem(struct bpf_map *map,
 			trie->n_entries--;
 
 		rcu_assign_pointer(*slot, new_node);
-		kfree_rcu(node, rcu);
+		free_node = node;
 
 		goto out;
 	}
@@ -429,6 +430,7 @@ static int trie_update_elem(struct bpf_map *map,
 	}
 
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
@@ -437,7 +439,8 @@ static int trie_update_elem(struct bpf_map *map,
 static int trie_delete_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct bpf_lpm_trie_key *key = _key;
+	struct lpm_trie_node *free_node = NULL, *free_parent = NULL;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 	struct lpm_trie_node __rcu **trim, **trim2;
 	struct lpm_trie_node *node, *parent;
 	unsigned long irq_flags;
@@ -506,8 +509,8 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 		else
 			rcu_assign_pointer(
 				*trim2, rcu_access_pointer(parent->child[0]));
-		kfree_rcu(parent, rcu);
-		kfree_rcu(node, rcu);
+		free_parent = parent;
+		free_node = node;
 		goto out;
 	}
 
@@ -521,10 +524,12 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 		rcu_assign_pointer(*trim, rcu_access_pointer(node->child[1]));
 	else
 		RCU_INIT_POINTER(*trim, NULL);
-	kfree_rcu(node, rcu);
+	free_node = node;
 
 out:
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	kfree_rcu(free_parent, rcu);
+	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
@@ -536,7 +541,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 				 sizeof(struct lpm_trie_node))
 #define LPM_VAL_SIZE_MIN	1
 
-#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key) + (X))
+#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key_u8) + (X))
 #define LPM_KEY_SIZE_MAX	LPM_KEY_SIZE(LPM_DATA_SIZE_MAX)
 #define LPM_KEY_SIZE_MIN	LPM_KEY_SIZE(LPM_DATA_SIZE_MIN)
 
@@ -568,7 +573,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&trie->map, attr);
 	trie->data_size = attr->key_size -
-			  offsetof(struct bpf_lpm_trie_key, data);
+			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
 	spin_lock_init(&trie->lock);
@@ -619,7 +624,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 {
 	struct lpm_trie_node *node, *next_node = NULL, *parent, *search_root;
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct bpf_lpm_trie_key *key = _key, *next_key = _next_key;
+	struct bpf_lpm_trie_key_u8 *key = _key, *next_key = _next_key;
 	struct lpm_trie_node **node_stack = NULL;
 	int err = 0, stack_ptr = -1;
 	unsigned int next_bit;
@@ -706,7 +711,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	}
 do_copy:
 	next_key->prefixlen = next_node->prefixlen;
-	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key, data),
+	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key_u8, data),
 	       next_node->data, trie->data_size);
 free_stack:
 	kfree(node_stack);
@@ -718,7 +723,7 @@ static int trie_check_btf(const struct bpf_map *map,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
 {
-	/* Keys must have struct bpf_lpm_trie_key embedded. */
+	/* Keys must have struct bpf_lpm_trie_key_u8 embedded. */
 	return BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ?
 	       -EINVAL : 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8973d3c9597c..4efa50eb07d7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -291,61 +291,6 @@ find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
 	return &linfo[i - 1];
 }
 
-void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
-		       va_list args)
-{
-	unsigned int n;
-
-	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
-
-	WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
-		  "verifier log line truncated - local buffer too short\n");
-
-	if (log->level == BPF_LOG_KERNEL) {
-		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
-
-		pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
-		return;
-	}
-
-	n = min(log->len_total - log->len_used - 1, n);
-	log->kbuf[n] = '\0';
-	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
-		log->len_used += n;
-	else
-		log->ubuf = NULL;
-}
-
-static void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
-{
-	char zero = 0;
-
-	if (!bpf_verifier_log_needed(log))
-		return;
-
-	log->len_used = new_pos;
-	if (put_user(zero, log->ubuf + new_pos))
-		log->ubuf = NULL;
-}
-
-/* log_level controls verbosity level of eBPF verifier.
- * bpf_verifier_log_write() is used to dump the verification trace to the log,
- * so the user can figure out what's wrong with the program
- */
-__printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
-					   const char *fmt, ...)
-{
-	va_list args;
-
-	if (!bpf_verifier_log_needed(&env->log))
-		return;
-
-	va_start(args, fmt);
-	bpf_verifier_vlog(&env->log, fmt, args);
-	va_end(args);
-}
-EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
-
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 {
 	struct bpf_verifier_env *env = private_data;
@@ -359,20 +304,6 @@ __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
-__printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
-			    const char *fmt, ...)
-{
-	va_list args;
-
-	if (!bpf_verifier_log_needed(log))
-		return;
-
-	va_start(args, fmt);
-	bpf_verifier_vlog(log, fmt, args);
-	va_end(args);
-}
-EXPORT_SYMBOL_GPL(bpf_log);
-
 static const char *ltrim(const char *s)
 {
 	while (isspace(*s))
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 489c25713edc..455f67ff31b5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1751,13 +1751,13 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 
 	if (!css->ss) {
 		if (cgroup_on_dfl(cgrp)) {
-			ret = cgroup_addrm_files(&cgrp->self, cgrp,
+			ret = cgroup_addrm_files(css, cgrp,
 						 cgroup_base_files, true);
 			if (ret < 0)
 				return ret;
 
 			if (cgroup_psi_enabled()) {
-				ret = cgroup_addrm_files(&cgrp->self, cgrp,
+				ret = cgroup_addrm_files(css, cgrp,
 							 cgroup_psi_files, true);
 				if (ret < 0)
 					return ret;
diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..74834c04a081 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -661,8 +661,11 @@ void __init pid_idr_init(void)
 
 	idr_init(&init_pid_ns.idr);
 
-	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	init_pid_ns.pid_cachep = kmem_cache_create("pid",
+			struct_size((struct pid *)NULL, numbers, 1),
+			__alignof__(struct pid),
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
+			NULL);
 }
 
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 1daadbefcee3..a575fabf697e 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -47,7 +47,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 		return kc;
 
 	snprintf(name, sizeof(name), "pid_%u", level + 1);
-	len = sizeof(struct pid) + level * sizeof(struct upid);
+	len = struct_size((struct pid *)NULL, numbers, level + 1);
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 48d8f754b730..49ff955ed203 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_RCU_H
 #define __LINUX_RCU_H
 
+#include <linux/slab.h>
 #include <trace/events/rcu.h>
 
 /*
@@ -211,6 +212,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
+static inline void debug_rcu_head_callback(struct rcu_head *rhp)
+{
+	if (unlikely(!rhp->func))
+		kmem_dump_obj(rhp);
+}
+
 extern int rcu_cpu_stall_suppress_at_boot;
 
 static inline bool rcu_stall_is_suppressed_at_boot(void)
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 33adafdad261..5e7f336baa06 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 929dcbc04d29..f7825900bdfd 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1591,6 +1591,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
 		debug_rcu_head_unqueue(rhp);
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 456c956f481e..bb6b037ef30f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -487,6 +487,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index a33a8d4942c3..21c040cba4bd 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 
 	trace_rcu_invoke_callback("", head);
 	f = head->func;
+	debug_rcu_head_callback(head);
 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
 	f(head);
 	rcu_lock_release(&rcu_callback_map);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cd6144cea5a1..dd6e15ca63b0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1336,7 +1336,7 @@ EXPORT_SYMBOL_GPL(rcu_gp_slow_register);
 /* Unregister a counter, with NULL for not caring which. */
 void rcu_gp_slow_unregister(atomic_t *rgssp)
 {
-	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress);
+	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress && rcu_gp_slow_suppress != NULL);
 
 	WRITE_ONCE(rcu_gp_slow_suppress, NULL);
 }
@@ -2292,6 +2292,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
 		f = rhp->func;
+		debug_rcu_head_callback(rhp);
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
 		f(rhp);
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cd9a59011dee..a3650699463b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,16 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
 
+static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
+{
+	u64 delta = clocksource_delta(end, start, cs->mask);
+
+	if (likely(delta < cs->max_cycles))
+		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
+
+	return mul_u64_u32_shr(delta, cs->mult, cs->shift);
+}
+
 /**
  * clocks_calc_mult_shift - calculate mult/shift factors for scaled math of clocks
  * @mult:	pointer to mult variable
@@ -219,8 +229,8 @@ enum wd_read_status {
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries, max_retries;
-	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	u64 wd_end, wd_end2;
 
 	max_retries = clocksource_get_max_watchdog_retry();
 	for (nretries = 0; nretries <= max_retries; nretries++) {
@@ -231,9 +241,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
-		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
-		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
-					      watchdog->shift);
+		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
@@ -251,8 +259,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
-		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
-		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		wd_seq_delay = cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
 		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
 			goto skip_test;
 	}
@@ -363,8 +370,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		delta = (csnow_end - csnow_mid) & cs->mask;
 		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
-		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		cs_nsec = cycles_to_nsec_safe(cs, csnow_begin, csnow_end);
 		if (cs_nsec > cs_nsec_max)
 			cs_nsec_max = cs_nsec;
 		if (cs_nsec < cs_nsec_min)
@@ -395,8 +401,8 @@ static inline void clocksource_reset_watchdog(void)
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec, interval;
+	u64 csnow, wdnow, cslast, wdlast;
 	int next_cpu, reset_pending;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
@@ -453,12 +459,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
-		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
-					     watchdog->shift);
-
-		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		wd_nsec = cycles_to_nsec_safe(watchdog, cs->wd_last, wdnow);
+		cs_nsec = cycles_to_nsec_safe(cs, cs->cs_last, csnow);
 		wdlast = cs->wd_last; /* save these in case we print them */
 		cslast = cs->cs_last;
 		cs->cs_last = csnow;
@@ -821,7 +823,7 @@ void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
  */
 u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 {
-	u64 now, delta, nsec = 0;
+	u64 now, nsec = 0;
 
 	if (!suspend_clocksource)
 		return 0;
@@ -836,12 +838,8 @@ u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 	else
 		now = suspend_clocksource->read(suspend_clocksource);
 
-	if (now > suspend_start) {
-		delta = clocksource_delta(now, suspend_start,
-					  suspend_clocksource->mask);
-		nsec = mul_u64_u32_shr(delta, suspend_clocksource->mult,
-				       suspend_clocksource->shift);
-	}
+	if (now > suspend_start)
+		nsec = cycles_to_nsec_safe(suspend_clocksource, suspend_start, now);
 
 	/*
 	 * Disable the suspend timer to save power if current clocksource is
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 9bb88836c42e..f62cc13b5f14 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -38,6 +38,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
@@ -1284,6 +1285,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
@@ -2220,8 +2223,8 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
 
 	tick_cancel_sched_timer(dying_cpu);
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ed3c4a954398..2d6cf93ca370 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -140,25 +140,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	int first_free_id = sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret = -ENOENT;
+	unsigned int cnt, id;
 
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt = 0; cnt <= INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id = sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+
+		head = &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret = sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id = 0;
-		if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
-			/* Loop over all possible ids completed */
-			ret = -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret == -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index d42cebf7407f..d3b64b10da1c 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -6,8 +6,6 @@
 #include <linux/prime_numbers.h>
 #include <linux/slab.h>
 
-#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))
-
 struct primes {
 	struct rcu_head rcu;
 	unsigned long last, sz;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f97b221fb656..98a1a05f2db2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1492,7 +1492,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1525,23 +1525,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);
+		return 0;
 	}
 
-out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
-				flags);
-
-	return 0;
-
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
 out_map:
 	/* Restore the PMD */
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1551,7 +1544,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto out;
+
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 
 /*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 65bd0b105266..085fca1fa27a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -55,6 +55,7 @@ enum scan_result {
 	SCAN_CGROUP_CHARGE_FAIL,
 	SCAN_TRUNCATED,
 	SCAN_PAGE_HAS_PRIVATE,
+	SCAN_STORE_FAILED,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					goto xa_locked;
 				}
 				xas_store(&xas, hpage);
+				if (xas_error(&xas)) {
+					/* revert shmem_charge performed
+					 * in the previous condition
+					 */
+					mapping->nrpages--;
+					shmem_uncharge(mapping->host, 1);
+					result = SCAN_STORE_FAILED;
+					goto xa_locked;
+				}
 				nr_none++;
 				continue;
 			}
@@ -1991,6 +2001,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 		/* Finally, replace with the new page. */
 		xas_store(&xas, hpage);
+		/* We can't get an ENOMEM here (because the allocation happened before)
+		 * but let's check for errors (XArray implementation can be
+		 * changed in the future)
+		 */
+		WARN_ON_ONCE(xas_error(&xas));
 		continue;
 out_unlock:
 		unlock_page(page);
@@ -2028,6 +2043,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	/* Join all the small entries into a single multi-index entry */
 	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	xas_store(&xas, hpage);
+	/* Here we can't get an ENOMEM (because entries were
+	 * previously allocated) But let's check for errors
+	 * (XArray implementation can be changed in the future)
+	 */
+	WARN_ON_ONCE(xas_error(&xas));
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4570d3e315cf..4ad6e8345b36 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4857,9 +4857,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	buf = endp + 1;
 
 	cfd = simple_strtoul(buf, &endp, 10);
-	if ((*endp != ' ') && (*endp != '\0'))
+	if (*endp == '\0')
+		buf = endp;
+	else if (*endp == ' ')
+		buf = endp + 1;
+	else
 		return -EINVAL;
-	buf = endp + 1;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8067c1e22af9..56b2dcc2c0d6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2208,7 +2208,7 @@ struct memory_failure_entry {
 struct memory_failure_cpu {
 	DECLARE_KFIFO(fifo, struct memory_failure_entry,
 		      MEMORY_FAILURE_FIFO_SIZE);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct work_struct work;
 };
 
@@ -2234,20 +2234,22 @@ void memory_failure_queue(unsigned long pfn, int flags)
 {
 	struct memory_failure_cpu *mf_cpu;
 	unsigned long proc_flags;
+	bool buffer_overflow;
 	struct memory_failure_entry entry = {
 		.pfn =		pfn,
 		.flags =	flags,
 	};
 
 	mf_cpu = &get_cpu_var(memory_failure_cpu);
-	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
-	if (kfifo_put(&mf_cpu->fifo, entry))
+	raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+	buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
+	if (!buffer_overflow)
 		schedule_work_on(smp_processor_id(), &mf_cpu->work);
-	else
+	raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+	put_cpu_var(memory_failure_cpu);
+	if (buffer_overflow)
 		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
-	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
-	put_cpu_var(memory_failure_cpu);
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);
 
@@ -2260,9 +2262,9 @@ static void memory_failure_work_func(struct work_struct *work)
 
 	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
-		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+		raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
-		spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+		raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
@@ -2292,7 +2294,7 @@ static int __init memory_failure_init(void)
 
 	for_each_possible_cpu(cpu) {
 		mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-		spin_lock_init(&mf_cpu->lock);
+		raw_spin_lock_init(&mf_cpu->lock);
 		INIT_KFIFO(mf_cpu->fifo);
 		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 301c74c44438..73085e36aaba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4786,7 +4786,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	spin_lock(vmf->ptl);
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	/* Get the normal PTE  */
@@ -4841,21 +4841,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-		spin_lock(vmf->ptl);
-		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, page_nid, 1, flags);
+		return 0;
 	}
 
-out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, 1, flags);
-	return 0;
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+	spin_lock(vmf->ptl);
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
@@ -4869,7 +4865,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto out;
+
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, 1, flags);
+	return 0;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4736c0e6093f..2a66be8ffa6b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -523,26 +523,6 @@ bool slab_is_available(void)
 }
 
 #ifdef CONFIG_PRINTK
-/**
- * kmem_valid_obj - does the pointer reference a valid slab object?
- * @object: pointer to query.
- *
- * Return: %true if the pointer is to a not-yet-freed object from
- * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
- * is to an already-freed object, and %false otherwise.
- */
-bool kmem_valid_obj(void *object)
-{
-	struct folio *folio;
-
-	/* Some arches consider ZERO_SIZE_PTR to be a valid address. */
-	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
-		return false;
-	folio = virt_to_folio(object);
-	return folio_test_slab(folio);
-}
-EXPORT_SYMBOL_GPL(kmem_valid_obj);
-
 static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
 	if (__kfence_obj_info(kpp, object, slab))
@@ -561,11 +541,11 @@ static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *
  * and, if available, the slab name, return address, and stack trace from
  * the allocation and last free path of that object.
  *
- * This function will splat if passed a pointer to a non-slab object.
- * If you are not sure what type of object you have, you should instead
- * use mem_dump_obj().
+ * Return: %true if the pointer is to a not-yet-freed object from
+ * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
+ * is to an already-freed object, and %false otherwise.
  */
-void kmem_dump_obj(void *object)
+bool kmem_dump_obj(void *object)
 {
 	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
 	int i;
@@ -573,13 +553,13 @@ void kmem_dump_obj(void *object)
 	unsigned long ptroffset;
 	struct kmem_obj_info kp = { };
 
-	if (WARN_ON_ONCE(!virt_addr_valid(object)))
-		return;
+	/* Some arches consider ZERO_SIZE_PTR to be a valid address. */
+	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
+		return false;
 	slab = virt_to_slab(object);
-	if (WARN_ON_ONCE(!slab)) {
-		pr_cont(" non-slab memory.\n");
-		return;
-	}
+	if (!slab)
+		return false;
+
 	kmem_obj_info(&kp, object, slab);
 	if (kp.kp_slab_cache)
 		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
@@ -616,6 +596,7 @@ void kmem_dump_obj(void *object)
 		pr_info("    %pS\n", kp.kp_free_stack[i]);
 	}
 
+	return true;
 }
 EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
diff --git a/mm/util.c b/mm/util.c
index ce3bb17c97b9..aa4f8a45dd56 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1119,10 +1119,8 @@ void mem_dump_obj(void *object)
 {
 	const char *type;
 
-	if (kmem_valid_obj(object)) {
-		kmem_dump_obj(object);
+	if (kmem_dump_obj(object))
 		return;
-	}
 
 	if (vmalloc_dump_obj(object))
 		return;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c5e30b52844c..a0b650f50faa 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2992,15 +2992,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages(alloc_gfp, order);
 		else
 			page = alloc_pages_node(nid, alloc_gfp, order);
-		if (unlikely(!page)) {
-			if (!nofail)
-				break;
-
-			/* fall back to the zero order allocations */
-			alloc_gfp |= __GFP_NOFAIL;
-			order = 0;
-			continue;
-		}
+		if (unlikely(!page))
+			break;
 
 		/*
 		 * Higher order allocations must be able to be treated as
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5a6a49885ab6..a660c428e220 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -385,7 +385,8 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	case BNEP_COMPRESSED_DST_ONLY:
 		__skb_put_data(nskb, skb_mac_header(skb), ETH_ALEN);
-		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN + 2);
+		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN);
+		put_unaligned(s->eh.h_proto, (__be16 *)__skb_put(nskb, 2));
 		break;
 
 	case BNEP_GENERAL:
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bac5a369d2be..858c454e35e6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -293,6 +293,13 @@ static int configure_datapath_sync(struct hci_dev *hdev, struct bt_codec *codec)
 	__u8 vnd_len, *vnd_data = NULL;
 	struct hci_op_configure_data_path *cmd = NULL;
 
+	if (!codec->data_path || !hdev->get_codec_config_data)
+		return 0;
+
+	/* Do not take me as error */
+	if (!hdev->get_codec_config_data)
+		return 0;
+
 	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
 					  &vnd_data);
 	if (err < 0)
@@ -338,9 +345,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
-	/* for offload use case, codec needs to configured before opening SCO */
-	if (conn->codec.data_path)
-		configure_datapath_sync(hdev, &conn->codec);
+	configure_datapath_sync(hdev, &conn->codec);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 398a32465769..210e03a3609d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3419,7 +3419,12 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 		if (c->type == type && c->sent) {
 			bt_dev_err(hdev, "killing stalled connection %pMR",
 				   &c->dst);
+			/* hci_disconnect might sleep, so, we have to release
+			 * the RCU read lock before calling it.
+			 */
+			rcu_read_unlock();
 			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
+			rcu_read_lock();
 		}
 	}
 
@@ -3739,19 +3744,19 @@ static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt, tmp;
+	int quote, *cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+	cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 
-	__check_timeout(hdev, cnt, LE_LINK);
+	__check_timeout(hdev, *cnt, LE_LINK);
 
-	tmp = cnt;
-	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+	tmp = *cnt;
+	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -3766,7 +3771,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 			hci_send_frame(hdev, skb);
 			hdev->le_last_tx = jiffies;
 
-			cnt--;
+			(*cnt)--;
 			chan->sent++;
 			chan->conn->sent++;
 
@@ -3776,12 +3781,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 		}
 	}
 
-	if (hdev->le_pkts)
-		hdev->le_cnt = cnt;
-	else
-		hdev->acl_cnt = cnt;
-
-	if (cnt != tmp)
+	if (*cnt != tmp)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 76dac5a90aef..5b8adfb36e20 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3524,6 +3524,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * will be kept and this function does nothing.
 		 */
 		p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
+		if (!p) {
+			err = -EIO;
+			goto unlock;
+		}
 
 		if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT)
 			p->auto_connect = HCI_AUTO_CONN_DISABLED;
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b54e8a530f55..29aa07e9db9d 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,7 +629,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -664,7 +664,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -686,11 +685,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level > BT_SECURITY_HIGH) {
 			err = -EINVAL;
@@ -706,10 +703,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ecb005bce65a..d444fa1bd9f9 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -913,7 +913,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * Confirms and the responder Enters the passkey.
 	 */
 	if (smp->method == OVERLAP) {
-		if (hcon->role == HCI_ROLE_MASTER)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp->method = CFM_PASSKEY;
 		else
 			smp->method = REQ_PASSKEY;
@@ -963,7 +963,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 	else
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -979,7 +979,8 @@ static u8 smp_random(struct smp_chan *smp)
 	int ret;
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
-		   conn->hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -993,7 +994,7 @@ static u8 smp_random(struct smp_chan *smp)
 		return SMP_CONFIRM_FAILED;
 	}
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 stk[16];
 		__le64 rand = 0;
 		__le16 ediv = 0;
@@ -1250,14 +1251,15 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK)) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+	    (smp->remote_key_dist & KEY_DIST_MASK)) {
 		smp_allow_key_dist(smp);
 		return;
 	}
 
 	req = (void *) &smp->preq[1];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		keydist = &rsp->init_key_dist;
 		*keydist &= req->init_key_dist;
 	} else {
@@ -1426,7 +1428,7 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	struct hci_conn *hcon = smp->conn->hcon;
 	u8 *na, *nb, a[7], b[7];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		na   = smp->prnd;
 		nb   = smp->rrnd;
 	} else {
@@ -1454,7 +1456,7 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->preq[1], 3);
@@ -1533,7 +1535,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		/* The round is only complete when the initiator
 		 * receives pairing random.
 		 */
-		if (!hcon->out) {
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			if (smp->passkey_round == 20)
@@ -1561,7 +1563,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
 
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			return 0;
@@ -1572,7 +1574,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 	case SMP_CMD_PUBLIC_KEY:
 	default:
 		/* Initiating device starts the round */
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			return 0;
 
 		bt_dev_dbg(hdev, "Starting passkey round %u",
@@ -1617,7 +1619,7 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 	}
 
 	/* Initiator sends DHKey check first */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		sc_dhkey_check(smp);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 	} else if (test_and_clear_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags)) {
@@ -1740,7 +1742,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct hci_dev *hdev = conn->hcon->hdev;
-	struct smp_chan *smp;
+	struct smp_chan *smp = chan->data;
 	u8 key_size, auth, sec_level;
 	int ret;
 
@@ -1749,16 +1751,14 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_SLAVE)
+	if (smp && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
-	if (!chan->data)
+	if (!smp) {
 		smp = smp_chan_create(conn);
-	else
-		smp = chan->data;
-
-	if (!smp)
-		return SMP_UNSPECIFIED;
+		if (!smp)
+			return SMP_UNSPECIFIED;
+	}
 
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req & AUTH_REQ_MASK(hdev);
@@ -1940,7 +1940,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_MASTER)
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rsp));
@@ -2035,7 +2035,7 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2057,7 +2057,7 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 	u8 auth;
 
 	/* The issue is only observed when we're in responder role */
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_UNSPECIFIED;
 
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
@@ -2093,7 +2093,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_dev *hdev = hcon->hdev;
 
 	bt_dev_dbg(hdev, "conn %p %s", conn,
-		   hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2115,7 +2116,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 			return ret;
 	}
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2150,7 +2151,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		pkax = smp->local_pk;
 		pkbx = smp->remote_pk;
 		na   = smp->prnd;
@@ -2163,7 +2164,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2174,7 +2175,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_RANDOM);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 cfm[16];
 
 		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
@@ -2215,7 +2216,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_UNSPECIFIED;
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
@@ -2289,10 +2290,27 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 	return false;
 }
 
+static void smp_send_pairing_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_pairing cp;
+
+	if (smp->conn->hcon->type == ACL_LINK)
+		build_bredr_pairing_cmd(smp, &cp, NULL);
+	else
+		build_pairing_cmd(smp->conn, &cp, NULL, auth);
+
+	smp->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&smp->preq[1], &cp, sizeof(cp));
+
+	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+
+	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
+}
+
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
-	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct smp_chan *smp;
@@ -2341,16 +2359,20 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	memset(&cp, 0, sizeof(cp));
-	build_pairing_cmd(conn, &cp, NULL, auth);
+	smp_send_pairing_req(smp, auth);
 
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &cp, sizeof(cp));
+	return 0;
+}
 
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+static void smp_send_security_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_security_req cp;
 
-	return 0;
+	cp.auth_req = auth;
+	smp_send_cmd(smp->conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
+
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
 }
 
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
@@ -2421,23 +2443,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 			authreq |= SMP_AUTH_MITM;
 	}
 
-	if (hcon->role == HCI_ROLE_MASTER) {
-		struct smp_cmd_pairing cp;
-
-		build_pairing_cmd(conn, &cp, NULL, authreq);
-		smp->preq[0] = SMP_CMD_PAIRING_REQ;
-		memcpy(&smp->preq[1], &cp, sizeof(cp));
-
-		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
-	} else {
-		struct smp_cmd_security_req cp;
-		cp.auth_req = authreq;
-		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
-	}
+	if (hcon->role == HCI_ROLE_MASTER)
+		smp_send_pairing_req(smp, authreq);
+	else
+		smp_send_security_req(smp, authreq);
 
-	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
 	ret = 0;
 
 unlock:
@@ -2688,8 +2698,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 sc_select_method(struct smp_chan *smp)
 {
-	struct l2cap_conn *conn = smp->conn;
-	struct hci_conn *hcon = conn->hcon;
 	struct smp_cmd_pairing *local, *remote;
 	u8 local_mitm, remote_mitm, local_io, remote_io, method;
 
@@ -2702,7 +2710,7 @@ static u8 sc_select_method(struct smp_chan *smp)
 	 * the "struct smp_cmd_pairing" from them we need to skip the
 	 * first byte which contains the opcode.
 	 */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local = (void *) &smp->preq[1];
 		remote = (void *) &smp->prsp[1];
 	} else {
@@ -2771,7 +2779,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Non-initiating device sends its public key after receiving
 	 * the key from the initiating device.
 	 */
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		err = sc_send_public_key(smp);
 		if (err)
 			return err;
@@ -2833,7 +2841,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 
@@ -2842,7 +2850,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
 	if (smp->method == REQ_PASSKEY) {
@@ -2857,7 +2865,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* The Initiating device waits for the non-initiating device to
 	 * send the confirm value.
 	 */
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return 0;
 
 	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
@@ -2891,7 +2899,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->prsp[1], 3);
@@ -2916,7 +2924,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (crypto_memneq(check->e, e, 16))
 		return SMP_DHKEY_CHECK_FAILED;
 
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		if (test_bit(SMP_FLAG_WAIT_USER, &smp->flags)) {
 			set_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags);
 			return 0;
@@ -2928,7 +2936,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	sc_add_ltk(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
@@ -3077,7 +3085,6 @@ static void bredr_pairing(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	struct smp_cmd_pairing req;
 	struct smp_chan *smp;
 
 	bt_dev_dbg(hdev, "chan %p", chan);
@@ -3129,14 +3136,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	bt_dev_dbg(hdev, "starting SMP over BR/EDR");
 
-	/* Prepare and send the BR/EDR SMP Pairing Request */
-	build_bredr_pairing_cmd(smp, &req, NULL);
-
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &req, sizeof(req));
-
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(req), &req);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+	smp_send_pairing_req(smp, 0x00);
 }
 
 static void smp_resume_cb(struct l2cap_chan *chan)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 9ac70c27da83..9229300881b5 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -618,8 +618,12 @@ static unsigned int br_nf_local_in(void *priv,
 	if (likely(nf_ct_is_confirmed(ct)))
 		return NF_ACCEPT;
 
+	if (WARN_ON_ONCE(refcount_read(&nfct->use) != 1)) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
 	WARN_ON_ONCE(skb_shared(skb));
-	WARN_ON_ONCE(refcount_read(&nfct->use) != 1);
 
 	/* We can't call nf_confirm here, it would create a dependency
 	 * on nf_conntrack module.
diff --git a/net/core/filter.c b/net/core/filter.c
index 210b881cb50b..1cd5f146cafe 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2264,12 +2264,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
@@ -2371,12 +2371,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4d46788cd493..768b8d65a5ba 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5791,7 +5791,6 @@ EXPORT_SYMBOL(skb_ensure_writable);
  */
 int __skb_vlan_pop(struct sk_buff *skb, u16 *vlan_tci)
 {
-	struct vlan_hdr *vhdr;
 	int offset = skb->data - skb_mac_header(skb);
 	int err;
 
@@ -5807,13 +5806,8 @@ int __skb_vlan_pop(struct sk_buff *skb, u16 *vlan_tci)
 
 	skb_postpull_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 
-	vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
-	*vlan_tci = ntohs(vhdr->h_vlan_TCI);
-
-	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
-	__skb_pull(skb, VLAN_HLEN);
+	vlan_remove_tag(skb, vlan_tci);
 
-	vlan_set_encap_proto(skb, vhdr);
 	skb->mac_header += VLAN_HLEN;
 
 	if (skb_network_offset(skb) < ETH_HLEN)
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index f4a2dce3e104..db8d54fb8806 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1042,7 +1042,7 @@ static void __net_exit dccp_v4_exit_net(struct net *net)
 
 static void __net_exit dccp_v4_exit_batch(struct list_head *net_exit_list)
 {
-	inet_twsk_purge(&dccp_hashinfo, AF_INET);
+	inet_twsk_purge(&dccp_hashinfo);
 }
 
 static struct pernet_operations dccp_v4_ops = {
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 016af0301366..d90bb941f2ad 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1121,15 +1121,9 @@ static void __net_exit dccp_v6_exit_net(struct net *net)
 	inet_ctl_sock_destroy(pn->v6_ctl_sk);
 }
 
-static void __net_exit dccp_v6_exit_batch(struct list_head *net_exit_list)
-{
-	inet_twsk_purge(&dccp_hashinfo, AF_INET6);
-}
-
 static struct pernet_operations dccp_v6_ops = {
 	.init   = dccp_v6_init_net,
 	.exit   = dccp_v6_exit_net,
-	.exit_batch = dccp_v6_exit_batch,
 	.id	= &dccp_v6_pernet_id,
 	.size   = sizeof(struct dccp_v6_pernet),
 };
diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index 0d81f172b7a6..ce9d2b20d67a 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -4,40 +4,6 @@
 #include <linux/dsa/ocelot.h>
 #include "dsa_priv.h"
 
-/* If the port is under a VLAN-aware bridge, remove the VLAN header from the
- * payload and move it into the DSA tag, which will make the switch classify
- * the packet to the bridge VLAN. Otherwise, leave the classified VLAN at zero,
- * which is the pvid of standalone and VLAN-unaware bridge ports.
- */
-static void ocelot_xmit_get_vlan_info(struct sk_buff *skb, struct dsa_port *dp,
-				      u64 *vlan_tci, u64 *tag_type)
-{
-	struct net_device *br = dsa_port_bridge_dev_get(dp);
-	struct vlan_ethhdr *hdr;
-	u16 proto, tci;
-
-	if (!br || !br_vlan_enabled(br)) {
-		*vlan_tci = 0;
-		*tag_type = IFH_TAG_TYPE_C;
-		return;
-	}
-
-	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
-	br_vlan_get_proto(br, &proto);
-
-	if (ntohs(hdr->h_vlan_proto) == proto) {
-		__skb_vlan_pop(skb, &tci);
-		*vlan_tci = tci;
-	} else {
-		rcu_read_lock();
-		br_vlan_get_pvid_rcu(br, &tci);
-		rcu_read_unlock();
-		*vlan_tci = tci;
-	}
-
-	*tag_type = (proto != ETH_P_8021Q) ? IFH_TAG_TYPE_S : IFH_TAG_TYPE_C;
-}
-
 static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 			       __be32 ifh_prefix, void **ifh)
 {
@@ -49,7 +15,8 @@ static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 	u32 rew_op = 0;
 	u64 qos_class;
 
-	ocelot_xmit_get_vlan_info(skb, dp, &vlan_tci, &tag_type);
+	ocelot_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(dp), &vlan_tci,
+				  &tag_type);
 
 	qos_class = netdev_get_num_tc(netdev) ?
 		    netdev_get_prio_tc_map(netdev, skb->priority) : skb->priority;
diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 0c3c6d0cee29..358bff068eef 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -431,7 +431,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 340a8f0c2980..6356a8a47b34 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -282,14 +282,18 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 
 /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
-void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
+void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 {
+	struct inet_ehash_bucket *head = &hashinfo->ehash[0];
+	unsigned int ehash_mask = hashinfo->ehash_mask;
 	struct hlist_nulls_node *node;
 	unsigned int slot;
 	struct sock *sk;
 
-	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
-		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	for (slot = 0; slot <= ehash_mask; slot++, head++) {
+		if (hlist_nulls_empty(&head->chain))
+			continue;
+
 restart_rcu:
 		cond_resched();
 		rcu_read_lock();
@@ -301,15 +305,13 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 					     TCPF_NEW_SYN_RECV))
 				continue;
 
-			if (sk->sk_family != family ||
-			    refcount_read(&sock_net(sk)->ns.count))
+			if (refcount_read(&sock_net(sk)->ns.count))
 				continue;
 
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				continue;
 
-			if (unlikely(sk->sk_family != family ||
-				     refcount_read(&sock_net(sk)->ns.count))) {
+			if (refcount_read(&sock_net(sk)->ns.count)) {
 				sock_gen_put(sk);
 				goto restart;
 			}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c64ba4f8ddaa..1327447a3aad 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -93,6 +93,8 @@ EXPORT_SYMBOL(tcp_hashinfo);
 
 static DEFINE_PER_CPU(struct sock *, ipv4_tcp_sk);
 
+static DEFINE_MUTEX(tcp_exit_batch_mutex);
+
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 {
 	return secure_tcp_seq(ip_hdr(skb)->daddr,
@@ -3242,13 +3244,25 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 {
 	struct net *net;
 
-	tcp_twsk_purge(net_exit_list, AF_INET);
+	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
+	 * and failed setup_net error unwinding path are serialized.
+	 *
+	 * tcp_twsk_purge() handles twsk in any dead netns, not just those in
+	 * net_exit_list, the thread that dismantles a particular twsk must
+	 * do so without other thread progressing to refcount_dec_and_test() of
+	 * tcp_death_row.tw_refcount.
+	 */
+	mutex_lock(&tcp_exit_batch_mutex);
+
+	tcp_twsk_purge(net_exit_list);
 
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
 		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
 		tcp_fastopen_ctx_destroy(net);
 	}
+
+	mutex_unlock(&tcp_exit_batch_mutex);
 }
 
 static struct pernet_operations __net_initdata tcp_sk_ops = {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b3bfa1a09df6..c562cb965e74 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -347,7 +347,7 @@ void tcp_twsk_destructor(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
 
-void tcp_twsk_purge(struct list_head *net_exit_list, int family)
+void tcp_twsk_purge(struct list_head *net_exit_list)
 {
 	bool purged_once = false;
 	struct net *net;
@@ -355,14 +355,13 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
 			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
-			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
+			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo);
 		} else if (!purged_once) {
-			inet_twsk_purge(&tcp_hashinfo, family);
+			inet_twsk_purge(&tcp_hashinfo);
 			purged_once = true;
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(tcp_twsk_purge);
 
 /* Warning : This function is called without sk_listener being locked.
  * Be sure to read socket fields once, as their value could change under us.
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 4851211aa60d..72a645bf05c9 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -72,6 +72,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+	if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+		goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 794ea24292f6..84cc3f6e1472 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -273,13 +273,25 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (unlikely(skb_checksum_start(gso_skb) !=
+		     skb_transport_header(gso_skb) &&
+		     !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)))
+		return ERR_PTR(-EINVAL);
+
+	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
+							     mss);
+		return NULL;
+	}
+
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index df79044fbf3c..f2227e662d1c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -69,11 +69,15 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOMEM;
 		}
+		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
@@ -274,11 +278,15 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOBUFS;
 		}
+		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -1993,6 +2001,7 @@ int ip6_send_skb(struct sk_buff *skb)
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int err;
 
+	rcu_read_lock();
 	err = ip6_local_out(net, skb->sk, skb);
 	if (err) {
 		if (err > 0)
@@ -2002,6 +2011,7 @@ int ip6_send_skb(struct sk_buff *skb)
 				      IPSTATS_MIB_OUTDISCARDS);
 	}
 
+	rcu_read_unlock();
 	return err;
 }
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 2699915bb85b..f3324f2a4046 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1510,7 +1510,8 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->hard_header_len = tdev->hard_header_len + t_hlen;
+			dev->needed_headroom = tdev->hard_header_len +
+				tdev->needed_headroom + t_hlen;
 			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
 
 			mtu = mtu - t_hlen;
@@ -1734,7 +1735,9 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct ip6_tnl *tnl = netdev_priv(dev);
+	int t_hlen;
 
+	t_hlen = tnl->hlen + sizeof(struct ipv6hdr);
 	if (tnl->parms.proto == IPPROTO_IPV6) {
 		if (new_mtu < IPV6_MIN_MTU)
 			return -EINVAL;
@@ -1743,10 +1746,10 @@ int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 			return -EINVAL;
 	}
 	if (tnl->parms.proto == IPPROTO_IPV6 || tnl->parms.proto == 0) {
-		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	} else {
-		if (new_mtu > IP_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	}
 	dev->mtu = new_mtu;
@@ -1892,12 +1895,11 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	t_hlen = t->hlen + sizeof(struct ipv6hdr);
 
 	dev->type = ARPHRD_TUNNEL6;
-	dev->hard_header_len = LL_MAX_HEADER + t_hlen;
 	dev->mtu = ETH_DATA_LEN - t_hlen;
 	if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 		dev->mtu -= 8;
 	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
+	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	return 0;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 87a394179092..e4b45db8a399 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -154,6 +154,10 @@ static struct frag_queue *fq_find(struct net *net, __be32 id, u32 user,
 	};
 	struct inet_frag_queue *q;
 
+	if (!(ipv6_addr_type(&hdr->daddr) & (IPV6_ADDR_MULTICAST |
+					    IPV6_ADDR_LINKLOCAL)))
+		key.iif = 0;
+
 	q = inet_frag_find(nf_frag->fqdir, &key);
 	if (!q)
 		return NULL;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index eb6fc0e2a453..06b4acbfd314 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2217,15 +2217,9 @@ static void __net_exit tcpv6_net_exit(struct net *net)
 	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
 }
 
-static void __net_exit tcpv6_net_exit_batch(struct list_head *net_exit_list)
-{
-	tcp_twsk_purge(net_exit_list, AF_INET6);
-}
-
 static struct pernet_operations tcpv6_net_ops = {
 	.init	    = tcpv6_net_init,
 	.exit	    = tcpv6_net_exit,
-	.exit_batch = tcpv6_net_exit_batch,
 };
 
 int __init tcpv6_init(void)
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index db41eb2d977f..038e1ba9aec2 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1090,8 +1090,7 @@ static int iucv_message_receive_iprmdata(struct iucv_path *path,
 		size = (size < 8) ? size : 8;
 		for (array = buffer; size > 0; array++) {
 			copy = min_t(size_t, size, array->length);
-			memcpy((u8 *)(addr_t) array->address,
-				rmmsg, copy);
+			memcpy(phys_to_virt(array->address), rmmsg, copy);
 			rmmsg += copy;
 			size -= copy;
 		}
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 7d37bf4334d2..462bdb6bfa4d 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -912,6 +912,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);
 	int err = -EPIPE;
 
+	mutex_lock(&kcm->tx_mutex);
 	lock_sock(sk);
 
 	/* Per tcp_sendmsg this should be in poll */
@@ -1060,6 +1061,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	KCM_STATS_ADD(kcm->stats.tx_bytes, copied);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return copied;
 
 out_error:
@@ -1085,6 +1087,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		sk->sk_write_space(sk);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return err;
 }
 
@@ -1325,6 +1328,7 @@ static void init_kcm_sock(struct kcm_sock *kcm, struct kcm_mux *mux)
 	spin_unlock_bh(&mux->lock);
 
 	INIT_WORK(&kcm->tx_work, kcm_tx_work);
+	mutex_init(&kcm->tx_mutex);
 
 	spin_lock_bh(&mux->rx_lock);
 	kcm_rcv_ready(kcm);
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 85d2b9e4b51c..e26a72f3a104 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -491,7 +491,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_ampdu_params params = {
 		.sta = &sta->sta,
 		.action = IEEE80211_AMPDU_TX_START,
@@ -519,7 +519,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
-	sdata = sta->sdata;
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	tid_tx->ssn = params.ssn;
@@ -533,9 +532,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		 */
 		set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state);
 	} else if (ret) {
-		if (!sdata)
-			return;
-
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 08a1d7564b7f..8ced615add71 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -603,8 +603,6 @@ IEEE80211_IF_FILE(fwded_mcast, u.mesh.mshstats.fwded_mcast, DEC);
 IEEE80211_IF_FILE(fwded_unicast, u.mesh.mshstats.fwded_unicast, DEC);
 IEEE80211_IF_FILE(fwded_frames, u.mesh.mshstats.fwded_frames, DEC);
 IEEE80211_IF_FILE(dropped_frames_ttl, u.mesh.mshstats.dropped_frames_ttl, DEC);
-IEEE80211_IF_FILE(dropped_frames_congestion,
-		  u.mesh.mshstats.dropped_frames_congestion, DEC);
 IEEE80211_IF_FILE(dropped_frames_no_route,
 		  u.mesh.mshstats.dropped_frames_no_route, DEC);
 
@@ -741,7 +739,6 @@ static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
 	MESHSTATS_ADD(fwded_frames);
 	MESHSTATS_ADD(dropped_frames_ttl);
 	MESHSTATS_ADD(dropped_frames_no_route);
-	MESHSTATS_ADD(dropped_frames_congestion);
 #undef MESHSTATS_ADD
 }
 
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index c08d3c9a4a17..5392ffa18270 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -391,9 +391,6 @@ int drv_ampdu_action(struct ieee80211_local *local,
 
 	might_sleep();
 
-	if (!sdata)
-		return -EIO;
-
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 709eb7bfcf19..8a3af4144d3f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -327,7 +327,6 @@ struct mesh_stats {
 	__u32 fwded_frames;		/* Mesh total forwarded frames */
 	__u32 dropped_frames_ttl;	/* Not transmitted since mesh_ttl == 0*/
 	__u32 dropped_frames_no_route;	/* Not transmitted, no route found */
-	__u32 dropped_frames_congestion;/* Not forwarded due to congestion */
 };
 
 #define PREQ_Q_F_START		0x1
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e00e1bf0f754..6a9d81e9069c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -251,9 +251,9 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	return ret;
 }
 
-static int ieee80211_change_mac(struct net_device *dev, void *addr)
+static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
+				 void *addr)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 	struct sockaddr *sa = addr;
 	bool check_dup = true;
@@ -278,7 +278,7 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 
 	if (live)
 		drv_remove_interface(local, sdata);
-	ret = eth_mac_addr(dev, sa);
+	ret = eth_mac_addr(sdata->dev, sa);
 
 	if (ret == 0) {
 		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
@@ -294,6 +294,27 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	return ret;
 }
 
+static int ieee80211_change_mac(struct net_device *dev, void *addr)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	int ret;
+
+	/*
+	 * This happens during unregistration if there's a bond device
+	 * active (maybe other cases?) and we must get removed from it.
+	 * But we really don't care anymore if it's not registered now.
+	 */
+	if (!dev->ieee80211_ptr->registered)
+		return 0;
+
+	wiphy_lock(local->hw.wiphy);
+	ret = _ieee80211_change_mac(sdata, addr);
+	wiphy_unlock(local->hw.wiphy);
+
+	return ret;
+}
+
 static inline int identical_mac_addr_allowed(int type1, int type2)
 {
 	return type1 == NL80211_IFTYPE_MONITOR ||
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c4c80037df91..b6077a97af1d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2408,7 +2408,6 @@ static int ieee80211_802_1x_port_control(struct ieee80211_rx_data *rx)
 
 static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 {
-	struct ieee80211_hdr *hdr = (void *)rx->skb->data;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
@@ -2419,31 +2418,6 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		return 0;
 
-	/* check mesh EAPOL frames first */
-	if (unlikely(rx->sta && ieee80211_vif_is_mesh(&rx->sdata->vif) &&
-		     ieee80211_is_data(fc))) {
-		struct ieee80211s_hdr *mesh_hdr;
-		u16 hdr_len = ieee80211_hdrlen(fc);
-		u16 ethertype_offset;
-		__be16 ethertype;
-
-		if (!ether_addr_equal(hdr->addr1, rx->sdata->vif.addr))
-			goto drop_check;
-
-		/* make sure fixed part of mesh header is there, also checks skb len */
-		if (!pskb_may_pull(rx->skb, hdr_len + 6))
-			goto drop_check;
-
-		mesh_hdr = (struct ieee80211s_hdr *)(skb->data + hdr_len);
-		ethertype_offset = hdr_len + ieee80211_get_mesh_hdrlen(mesh_hdr) +
-				   sizeof(rfc1042_header);
-
-		if (skb_copy_bits(rx->skb, ethertype_offset, &ethertype, 2) == 0 &&
-		    ethertype == rx->sdata->control_port_protocol)
-			return 0;
-	}
-
-drop_check:
 	/* Drop unencrypted frames if key is set. */
 	if (unlikely(!ieee80211_has_protected(fc) &&
 		     !ieee80211_is_any_nullfunc(fc) &&
@@ -2751,6 +2725,177 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 	}
 }
 
+static ieee80211_rx_result
+ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta,
+		       struct sk_buff *skb)
+{
+#ifdef CONFIG_MAC80211_MESH
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct ieee80211_local *local = sdata->local;
+	uint16_t fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA;
+	struct ieee80211_hdr hdr = {
+		.frame_control = cpu_to_le16(fc)
+	};
+	struct ieee80211_hdr *fwd_hdr;
+	struct ieee80211s_hdr *mesh_hdr;
+	struct ieee80211_tx_info *info;
+	struct sk_buff *fwd_skb;
+	struct ethhdr *eth;
+	bool multicast;
+	int tailroom = 0;
+	int hdrlen, mesh_hdrlen;
+	u8 *qos;
+
+	if (!ieee80211_vif_is_mesh(&sdata->vif))
+		return RX_CONTINUE;
+
+	if (!pskb_may_pull(skb, sizeof(*eth) + 6))
+		return RX_DROP_MONITOR;
+
+	mesh_hdr = (struct ieee80211s_hdr *)(skb->data + sizeof(*eth));
+	mesh_hdrlen = ieee80211_get_mesh_hdrlen(mesh_hdr);
+
+	if (!pskb_may_pull(skb, sizeof(*eth) + mesh_hdrlen))
+		return RX_DROP_MONITOR;
+
+	eth = (struct ethhdr *)skb->data;
+	multicast = is_multicast_ether_addr(eth->h_dest);
+
+	mesh_hdr = (struct ieee80211s_hdr *)(eth + 1);
+	if (!mesh_hdr->ttl)
+		return RX_DROP_MONITOR;
+
+	/* frame is in RMC, don't forward */
+	if (is_multicast_ether_addr(eth->h_dest) &&
+	    mesh_rmc_check(sdata, eth->h_source, mesh_hdr))
+		return RX_DROP_MONITOR;
+
+	/* forward packet */
+	if (sdata->crypto_tx_tailroom_needed_cnt)
+		tailroom = IEEE80211_ENCRYPT_TAILROOM;
+
+	if (mesh_hdr->flags & MESH_FLAGS_AE) {
+		struct mesh_path *mppath;
+		char *proxied_addr;
+
+		if (multicast)
+			proxied_addr = mesh_hdr->eaddr1;
+		else if ((mesh_hdr->flags & MESH_FLAGS_AE) == MESH_FLAGS_AE_A5_A6)
+			/* has_a4 already checked in ieee80211_rx_mesh_check */
+			proxied_addr = mesh_hdr->eaddr2;
+		else
+			return RX_DROP_MONITOR;
+
+		rcu_read_lock();
+		mppath = mpp_path_lookup(sdata, proxied_addr);
+		if (!mppath) {
+			mpp_path_add(sdata, proxied_addr, eth->h_source);
+		} else {
+			spin_lock_bh(&mppath->state_lock);
+			if (!ether_addr_equal(mppath->mpp, eth->h_source))
+				memcpy(mppath->mpp, eth->h_source, ETH_ALEN);
+			mppath->exp_time = jiffies;
+			spin_unlock_bh(&mppath->state_lock);
+		}
+		rcu_read_unlock();
+	}
+
+	/* Frame has reached destination.  Don't forward */
+	if (ether_addr_equal(sdata->vif.addr, eth->h_dest))
+		goto rx_accept;
+
+	if (!--mesh_hdr->ttl) {
+		if (multicast)
+			goto rx_accept;
+
+		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
+		return RX_DROP_MONITOR;
+	}
+
+	if (!ifmsh->mshcfg.dot11MeshForwarding) {
+		if (is_multicast_ether_addr(eth->h_dest))
+			goto rx_accept;
+
+		return RX_DROP_MONITOR;
+	}
+
+	skb_set_queue_mapping(skb, ieee802_1d_to_ac[skb->priority]);
+
+	ieee80211_fill_mesh_addresses(&hdr, &hdr.frame_control,
+				      eth->h_dest, eth->h_source);
+	hdrlen = ieee80211_hdrlen(hdr.frame_control);
+	if (multicast) {
+		int extra_head = sizeof(struct ieee80211_hdr) - sizeof(*eth);
+
+		fwd_skb = skb_copy_expand(skb, local->tx_headroom + extra_head +
+					       IEEE80211_ENCRYPT_HEADROOM,
+					  tailroom, GFP_ATOMIC);
+		if (!fwd_skb)
+			goto rx_accept;
+	} else {
+		fwd_skb = skb;
+		skb = NULL;
+
+		if (skb_cow_head(fwd_skb, hdrlen - sizeof(struct ethhdr)))
+			return RX_DROP_UNUSABLE;
+
+		if (skb_linearize(fwd_skb))
+			return RX_DROP_UNUSABLE;
+	}
+
+	fwd_hdr = skb_push(fwd_skb, hdrlen - sizeof(struct ethhdr));
+	memcpy(fwd_hdr, &hdr, hdrlen - 2);
+	qos = ieee80211_get_qos_ctl(fwd_hdr);
+	qos[0] = qos[1] = 0;
+
+	skb_reset_mac_header(fwd_skb);
+	hdrlen += mesh_hdrlen;
+	if (ieee80211_get_8023_tunnel_proto(fwd_skb->data + hdrlen,
+					    &fwd_skb->protocol))
+		hdrlen += ETH_ALEN;
+	else
+		fwd_skb->protocol = htons(fwd_skb->len - hdrlen);
+	skb_set_network_header(fwd_skb, hdrlen + 2);
+
+	info = IEEE80211_SKB_CB(fwd_skb);
+	memset(info, 0, sizeof(*info));
+	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
+	info->control.vif = &sdata->vif;
+	info->control.jiffies = jiffies;
+	if (multicast) {
+		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_mcast);
+		memcpy(fwd_hdr->addr2, sdata->vif.addr, ETH_ALEN);
+		/* update power mode indication when forwarding */
+		ieee80211_mps_set_frame_flags(sdata, NULL, fwd_hdr);
+	} else if (!mesh_nexthop_lookup(sdata, fwd_skb)) {
+		/* mesh power mode flags updated in mesh_nexthop_lookup */
+		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_unicast);
+	} else {
+		/* unable to resolve next hop */
+		if (sta)
+			mesh_path_error_tx(sdata, ifmsh->mshcfg.element_ttl,
+					   hdr.addr3, 0,
+					   WLAN_REASON_MESH_PATH_NOFORWARD,
+					   sta->sta.addr);
+		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_no_route);
+		kfree_skb(fwd_skb);
+		goto rx_accept;
+	}
+
+	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
+	fwd_skb->dev = sdata->dev;
+	ieee80211_add_pending_skb(local, fwd_skb);
+
+rx_accept:
+	if (!skb)
+		return RX_QUEUED;
+
+	ieee80211_strip_8023_mesh_hdr(skb);
+#endif
+
+	return RX_CONTINUE;
+}
+
 static ieee80211_rx_result debug_noinline
 __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 {
@@ -2759,6 +2904,7 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	__le16 fc = hdr->frame_control;
 	struct sk_buff_head frame_list;
+	ieee80211_rx_result res;
 	struct ethhdr ethhdr;
 	const u8 *check_da = ethhdr.h_dest, *check_sa = ethhdr.h_source;
 
@@ -2777,6 +2923,7 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
 			check_sa = NULL;
+			check_da = NULL;
 			break;
 		default:
 			break;
@@ -2791,20 +2938,43 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 					  data_offset, true))
 		return RX_DROP_UNUSABLE;
 
+	if (rx->sta->amsdu_mesh_control < 0) {
+		bool valid_std = ieee80211_is_valid_amsdu(skb, true);
+		bool valid_nonstd = ieee80211_is_valid_amsdu(skb, false);
+
+		if (valid_std && !valid_nonstd)
+			rx->sta->amsdu_mesh_control = 1;
+		else if (valid_nonstd && !valid_std)
+			rx->sta->amsdu_mesh_control = 0;
+	}
+
 	ieee80211_amsdu_to_8023s(skb, &frame_list, dev->dev_addr,
 				 rx->sdata->vif.type,
 				 rx->local->hw.extra_tx_headroom,
-				 check_da, check_sa);
+				 check_da, check_sa,
+				 rx->sta->amsdu_mesh_control);
 
 	while (!skb_queue_empty(&frame_list)) {
 		rx->skb = __skb_dequeue(&frame_list);
 
-		if (!ieee80211_frame_allowed(rx, fc)) {
-			dev_kfree_skb(rx->skb);
+		res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
+		switch (res) {
+		case RX_QUEUED:
 			continue;
+		case RX_CONTINUE:
+			break;
+		default:
+			goto free;
 		}
 
+		if (!ieee80211_frame_allowed(rx, fc))
+			goto free;
+
 		ieee80211_deliver_skb(rx);
+		continue;
+
+free:
+		dev_kfree_skb(rx->skb);
 	}
 
 	return RX_QUEUED;
@@ -2837,12 +3007,14 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 			if (!rx->sdata->u.mgd.use_4addr)
 				return RX_DROP_UNUSABLE;
 			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			break;
 		default:
 			return RX_DROP_UNUSABLE;
 		}
 	}
 
-	if (is_multicast_ether_addr(hdr->addr1))
+	if (is_multicast_ether_addr(hdr->addr1) || !rx->sta)
 		return RX_DROP_UNUSABLE;
 
 	if (rx->key) {
@@ -2865,152 +3037,6 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 	return __ieee80211_rx_h_amsdu(rx, 0);
 }
 
-#ifdef CONFIG_MAC80211_MESH
-static ieee80211_rx_result
-ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
-{
-	struct ieee80211_hdr *fwd_hdr, *hdr;
-	struct ieee80211_tx_info *info;
-	struct ieee80211s_hdr *mesh_hdr;
-	struct sk_buff *skb = rx->skb, *fwd_skb;
-	struct ieee80211_local *local = rx->local;
-	struct ieee80211_sub_if_data *sdata = rx->sdata;
-	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	u16 ac, q, hdrlen;
-	int tailroom = 0;
-
-	hdr = (struct ieee80211_hdr *) skb->data;
-	hdrlen = ieee80211_hdrlen(hdr->frame_control);
-
-	/* make sure fixed part of mesh header is there, also checks skb len */
-	if (!pskb_may_pull(rx->skb, hdrlen + 6))
-		return RX_DROP_MONITOR;
-
-	mesh_hdr = (struct ieee80211s_hdr *) (skb->data + hdrlen);
-
-	/* make sure full mesh header is there, also checks skb len */
-	if (!pskb_may_pull(rx->skb,
-			   hdrlen + ieee80211_get_mesh_hdrlen(mesh_hdr)))
-		return RX_DROP_MONITOR;
-
-	/* reload pointers */
-	hdr = (struct ieee80211_hdr *) skb->data;
-	mesh_hdr = (struct ieee80211s_hdr *) (skb->data + hdrlen);
-
-	if (ieee80211_drop_unencrypted(rx, hdr->frame_control))
-		return RX_DROP_MONITOR;
-
-	/* frame is in RMC, don't forward */
-	if (ieee80211_is_data(hdr->frame_control) &&
-	    is_multicast_ether_addr(hdr->addr1) &&
-	    mesh_rmc_check(rx->sdata, hdr->addr3, mesh_hdr))
-		return RX_DROP_MONITOR;
-
-	if (!ieee80211_is_data(hdr->frame_control))
-		return RX_CONTINUE;
-
-	if (!mesh_hdr->ttl)
-		return RX_DROP_MONITOR;
-
-	if (mesh_hdr->flags & MESH_FLAGS_AE) {
-		struct mesh_path *mppath;
-		char *proxied_addr;
-		char *mpp_addr;
-
-		if (is_multicast_ether_addr(hdr->addr1)) {
-			mpp_addr = hdr->addr3;
-			proxied_addr = mesh_hdr->eaddr1;
-		} else if ((mesh_hdr->flags & MESH_FLAGS_AE) ==
-			    MESH_FLAGS_AE_A5_A6) {
-			/* has_a4 already checked in ieee80211_rx_mesh_check */
-			mpp_addr = hdr->addr4;
-			proxied_addr = mesh_hdr->eaddr2;
-		} else {
-			return RX_DROP_MONITOR;
-		}
-
-		rcu_read_lock();
-		mppath = mpp_path_lookup(sdata, proxied_addr);
-		if (!mppath) {
-			mpp_path_add(sdata, proxied_addr, mpp_addr);
-		} else {
-			spin_lock_bh(&mppath->state_lock);
-			if (!ether_addr_equal(mppath->mpp, mpp_addr))
-				memcpy(mppath->mpp, mpp_addr, ETH_ALEN);
-			mppath->exp_time = jiffies;
-			spin_unlock_bh(&mppath->state_lock);
-		}
-		rcu_read_unlock();
-	}
-
-	/* Frame has reached destination.  Don't forward */
-	if (!is_multicast_ether_addr(hdr->addr1) &&
-	    ether_addr_equal(sdata->vif.addr, hdr->addr3))
-		return RX_CONTINUE;
-
-	ac = ieee802_1d_to_ac[skb->priority];
-	q = sdata->vif.hw_queue[ac];
-	if (ieee80211_queue_stopped(&local->hw, q)) {
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_congestion);
-		return RX_DROP_MONITOR;
-	}
-	skb_set_queue_mapping(skb, ac);
-
-	if (!--mesh_hdr->ttl) {
-		if (!is_multicast_ether_addr(hdr->addr1))
-			IEEE80211_IFSTA_MESH_CTR_INC(ifmsh,
-						     dropped_frames_ttl);
-		goto out;
-	}
-
-	if (!ifmsh->mshcfg.dot11MeshForwarding)
-		goto out;
-
-	if (sdata->crypto_tx_tailroom_needed_cnt)
-		tailroom = IEEE80211_ENCRYPT_TAILROOM;
-
-	fwd_skb = skb_copy_expand(skb, local->tx_headroom +
-				       IEEE80211_ENCRYPT_HEADROOM,
-				  tailroom, GFP_ATOMIC);
-	if (!fwd_skb)
-		goto out;
-
-	fwd_skb->dev = sdata->dev;
-	fwd_hdr =  (struct ieee80211_hdr *) fwd_skb->data;
-	fwd_hdr->frame_control &= ~cpu_to_le16(IEEE80211_FCTL_RETRY);
-	info = IEEE80211_SKB_CB(fwd_skb);
-	memset(info, 0, sizeof(*info));
-	info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
-	info->control.vif = &rx->sdata->vif;
-	info->control.jiffies = jiffies;
-	if (is_multicast_ether_addr(fwd_hdr->addr1)) {
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_mcast);
-		memcpy(fwd_hdr->addr2, sdata->vif.addr, ETH_ALEN);
-		/* update power mode indication when forwarding */
-		ieee80211_mps_set_frame_flags(sdata, NULL, fwd_hdr);
-	} else if (!mesh_nexthop_lookup(sdata, fwd_skb)) {
-		/* mesh power mode flags updated in mesh_nexthop_lookup */
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_unicast);
-	} else {
-		/* unable to resolve next hop */
-		mesh_path_error_tx(sdata, ifmsh->mshcfg.element_ttl,
-				   fwd_hdr->addr3, 0,
-				   WLAN_REASON_MESH_PATH_NOFORWARD,
-				   fwd_hdr->addr2);
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_no_route);
-		kfree_skb(fwd_skb);
-		return RX_DROP_MONITOR;
-	}
-
-	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
-	ieee80211_add_pending_skb(local, fwd_skb);
- out:
-	if (is_multicast_ether_addr(hdr->addr1))
-		return RX_CONTINUE;
-	return RX_DROP_MONITOR;
-}
-#endif
-
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 {
@@ -3019,6 +3045,7 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 	struct net_device *dev = sdata->dev;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)rx->skb->data;
 	__le16 fc = hdr->frame_control;
+	ieee80211_rx_result res;
 	bool port_control;
 	int err;
 
@@ -3045,6 +3072,10 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 	if (unlikely(err))
 		return RX_DROP_UNUSABLE;
 
+	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
+	if (res != RX_CONTINUE)
+		return res;
+
 	if (!ieee80211_frame_allowed(rx, fc))
 		return RX_DROP_MONITOR;
 
@@ -4019,10 +4050,6 @@ static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 		CALL_RXH(ieee80211_rx_h_defragment);
 		CALL_RXH(ieee80211_rx_h_michael_mic_verify);
 		/* must be after MMIC verify so header is counted in MPDU mic */
-#ifdef CONFIG_MAC80211_MESH
-		if (ieee80211_vif_is_mesh(&rx->sdata->vif))
-			CALL_RXH(ieee80211_rx_h_mesh_fwding);
-#endif
 		CALL_RXH(ieee80211_rx_h_amsdu);
 		CALL_RXH(ieee80211_rx_h_data);
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f388b3953174..dd1864f6549f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -594,6 +594,9 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 	sta->sta_state = IEEE80211_STA_NONE;
 
+	if (sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
+		sta->amsdu_mesh_control = -1;
+
 	/* Mark TID as unreserved */
 	sta->reserved_tid = IEEE80211_TID_UNRESERVED;
 
@@ -1269,6 +1272,20 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	 *	 after _part1 and before _part2!
 	 */
 
+	/*
+	 * There's a potential race in _part1 where we set WLAN_STA_BLOCK_BA
+	 * but someone might have just gotten past a check, and not yet into
+	 * queuing the work/creating the data/etc.
+	 *
+	 * Do another round of destruction so that the worker is certainly
+	 * canceled before we later free the station.
+	 *
+	 * Since this is after synchronize_rcu()/synchronize_net() we're now
+	 * certain that nobody can actually hold a reference to the STA and
+	 * be calling e.g. ieee80211_start_tx_ba_session().
+	 */
+	ieee80211_sta_tear_down_BA_sessions(sta, AGG_STOP_DESTROY_STA);
+
 	might_sleep();
 	lockdep_assert_held(&local->sta_mtx);
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 4809756a43dd..09db542fd202 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -621,6 +621,8 @@ struct link_sta_info {
  *	taken from HT/VHT capabilities or VHT operating mode notification
  * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
+ * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer
+ *	(-1: not yet known, 0: non-standard [without mesh header], 1: standard)
  * @fast_tx: TX fastpath information
  * @fast_rx: RX fastpath information
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to
@@ -706,6 +708,7 @@ struct sta_info {
 	struct codel_params cparams;
 
 	u8 reserved_tid;
+	s8 amsdu_mesh_control;
 
 	struct cfg80211_chan_def tdls_chandef;
 
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 92ea4158f7fc..a944490a724d 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -354,7 +354,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 
 		skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
 		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, skb2);
-		KUNIT_EXPECT_EQ(test, skb->len, 1);
+		KUNIT_EXPECT_EQ(test, skb2->len, 1);
 
 		skb_free_datagram(sock->sk, skb2);
 
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 7017dd60659d..b2199cc28238 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -95,7 +95,7 @@ static size_t subflow_get_info_size(const struct sock *sk)
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
 		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
 		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 368886d3faac..2bce3a32bd88 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -834,7 +834,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -848,7 +848,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!mptcp_pm_is_kernel(msk))
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
+		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
@@ -1474,7 +1478,10 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= ret;
+		if (ret) {
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			msk->pm.add_addr_signaled--;
+		}
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1509,8 +1516,17 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-		if (remove_subflow)
+
+		if (remove_subflow) {
 			mptcp_pm_remove_subflow(msk, &list);
+		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			/* If the subflow has been used, but now closed */
+			spin_lock_bh(&msk->pm.lock);
+			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+				msk->pm.local_addr_used--;
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
 		release_sock(sk);
 
 next:
@@ -1654,8 +1670,15 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 6eef15648b7b..b0f199171932 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -17,6 +17,9 @@ nf_flow_offload_inet_hook(void *priv, struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_8021Q):
+		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
+			return NF_ACCEPT;
+
 		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 		proto = veth->h_vlan_encapsulated_proto;
 		break;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 22bc0e3d8a0b..34be2c9bc39d 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -275,6 +275,9 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_8021Q):
+		if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth)))
+			return false;
+
 		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 		if (veth->h_vlan_encapsulated_proto == proto) {
 			*offset += VLAN_HLEN;
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 1c26f03fc661..1904a4f295d4 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -841,8 +841,8 @@ static int nf_flow_offload_tuple(struct nf_flowtable *flowtable,
 				 struct list_head *block_cb_list)
 {
 	struct flow_cls_offload cls_flow = {};
+	struct netlink_ext_ack extack = {};
 	struct flow_block_cb *block_cb;
-	struct netlink_ext_ack extack;
 	__be16 proto = ETH_P_ALL;
 	int err, i = 0;
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 10180d280e79..63b7be0a95d0 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7416,28 +7416,26 @@ static void audit_log_obj_reset(const struct nft_table *table,
 	kfree(buf);
 }
 
-struct nft_obj_filter {
+struct nft_obj_dump_ctx {
+	unsigned int	s_idx;
 	char		*table;
 	u32		type;
+	bool		reset;
 };
 
 static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
-	const struct nft_table *table;
-	unsigned int idx = 0, s_idx = cb->args[0];
-	struct nft_obj_filter *filter = cb->data;
+	struct nft_obj_dump_ctx *ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nftables_pernet *nft_net;
+	const struct nft_table *table;
 	unsigned int entries = 0;
 	struct nft_object *obj;
-	bool reset = false;
+	unsigned int idx = 0;
 	int rc = 0;
 
-	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
-		reset = true;
-
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
 	cb->seq = READ_ONCE(nft_net->base_seq);
@@ -7450,17 +7448,12 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 		list_for_each_entry_rcu(obj, &table->objects, list) {
 			if (!nft_is_active(net, obj))
 				goto cont;
-			if (idx < s_idx)
+			if (idx < ctx->s_idx)
 				goto cont;
-			if (idx > s_idx)
-				memset(&cb->args[1], 0,
-				       sizeof(cb->args) - sizeof(cb->args[0]));
-			if (filter && filter->table &&
-			    strcmp(filter->table, table->name))
+			if (ctx->table && strcmp(ctx->table, table->name))
 				goto cont;
-			if (filter &&
-			    filter->type != NFT_OBJECT_UNSPEC &&
-			    obj->ops->type->type != filter->type)
+			if (ctx->type != NFT_OBJECT_UNSPEC &&
+			    obj->ops->type->type != ctx->type)
 				goto cont;
 
 			rc = nf_tables_fill_obj_info(skb, net,
@@ -7469,7 +7462,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 						     NFT_MSG_NEWOBJ,
 						     NLM_F_MULTI | NLM_F_APPEND,
 						     table->family, table,
-						     obj, reset);
+						     obj, ctx->reset);
 			if (rc < 0)
 				break;
 
@@ -7478,58 +7471,71 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 cont:
 			idx++;
 		}
-		if (reset && entries)
+		if (ctx->reset && entries)
 			audit_log_obj_reset(table, nft_net->base_seq, entries);
 		if (rc < 0)
 			break;
 	}
 	rcu_read_unlock();
 
-	cb->args[0] = idx;
+	ctx->s_idx = idx;
 	return skb->len;
 }
 
+static int nf_tables_dumpreset_obj(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	struct nftables_pernet *nft_net = nft_pernet(sock_net(skb->sk));
+	int ret;
+
+	mutex_lock(&nft_net->commit_mutex);
+	ret = nf_tables_dump_obj(skb, cb);
+	mutex_unlock(&nft_net->commit_mutex);
+
+	return ret;
+}
+
 static int nf_tables_dump_obj_start(struct netlink_callback *cb)
 {
+	struct nft_obj_dump_ctx *ctx = (void *)cb->ctx;
 	const struct nlattr * const *nla = cb->data;
-	struct nft_obj_filter *filter = NULL;
-
-	if (nla[NFTA_OBJ_TABLE] || nla[NFTA_OBJ_TYPE]) {
-		filter = kzalloc(sizeof(*filter), GFP_ATOMIC);
-		if (!filter)
-			return -ENOMEM;
 
-		if (nla[NFTA_OBJ_TABLE]) {
-			filter->table = nla_strdup(nla[NFTA_OBJ_TABLE], GFP_ATOMIC);
-			if (!filter->table) {
-				kfree(filter);
-				return -ENOMEM;
-			}
-		}
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
 
-		if (nla[NFTA_OBJ_TYPE])
-			filter->type = ntohl(nla_get_be32(nla[NFTA_OBJ_TYPE]));
+	if (nla[NFTA_OBJ_TABLE]) {
+		ctx->table = nla_strdup(nla[NFTA_OBJ_TABLE], GFP_ATOMIC);
+		if (!ctx->table)
+			return -ENOMEM;
 	}
 
-	cb->data = filter;
+	if (nla[NFTA_OBJ_TYPE])
+		ctx->type = ntohl(nla_get_be32(nla[NFTA_OBJ_TYPE]));
+
 	return 0;
 }
 
+static int nf_tables_dumpreset_obj_start(struct netlink_callback *cb)
+{
+	struct nft_obj_dump_ctx *ctx = (void *)cb->ctx;
+
+	ctx->reset = true;
+
+	return nf_tables_dump_obj_start(cb);
+}
+
 static int nf_tables_dump_obj_done(struct netlink_callback *cb)
 {
-	struct nft_obj_filter *filter = cb->data;
+	struct nft_obj_dump_ctx *ctx = (void *)cb->ctx;
 
-	if (filter) {
-		kfree(filter->table);
-		kfree(filter);
-	}
+	kfree(ctx->table);
 
 	return 0;
 }
 
 /* called with rcu_read_lock held */
-static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
-			    const struct nlattr * const nla[])
+static struct sk_buff *
+nf_tables_getobj_single(u32 portid, const struct nfnl_info *info,
+			const struct nlattr * const nla[], bool reset)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	u8 genmask = nft_genmask_cur(info->net);
@@ -7538,72 +7544,109 @@ static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
 	struct net *net = info->net;
 	struct nft_object *obj;
 	struct sk_buff *skb2;
-	bool reset = false;
 	u32 objtype;
 	int err;
 
-	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
-		struct netlink_dump_control c = {
-			.start = nf_tables_dump_obj_start,
-			.dump = nf_tables_dump_obj,
-			.done = nf_tables_dump_obj_done,
-			.module = THIS_MODULE,
-			.data = (void *)nla,
-		};
-
-		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
-	}
-
 	if (!nla[NFTA_OBJ_NAME] ||
 	    !nla[NFTA_OBJ_TYPE])
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	table = nft_table_lookup(net, nla[NFTA_OBJ_TABLE], family, genmask, 0);
 	if (IS_ERR(table)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_OBJ_TABLE]);
-		return PTR_ERR(table);
+		return ERR_CAST(table);
 	}
 
 	objtype = ntohl(nla_get_be32(nla[NFTA_OBJ_TYPE]));
 	obj = nft_obj_lookup(net, table, nla[NFTA_OBJ_NAME], objtype, genmask);
 	if (IS_ERR(obj)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_OBJ_NAME]);
-		return PTR_ERR(obj);
+		return ERR_CAST(obj);
 	}
 
 	skb2 = alloc_skb(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (!skb2)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
-		reset = true;
+	err = nf_tables_fill_obj_info(skb2, net, portid,
+				      info->nlh->nlmsg_seq, NFT_MSG_NEWOBJ, 0,
+				      family, table, obj, reset);
+	if (err < 0) {
+		kfree_skb(skb2);
+		return ERR_PTR(err);
+	}
 
-	if (reset) {
-		const struct nftables_pernet *nft_net;
-		char *buf;
+	return skb2;
+}
 
-		nft_net = nft_pernet(net);
-		buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name, nft_net->base_seq);
+static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
+			    const struct nlattr * const nla[])
+{
+	u32 portid = NETLINK_CB(skb).portid;
+	struct sk_buff *skb2;
 
-		audit_log_nfcfg(buf,
-				family,
-				1,
-				AUDIT_NFT_OP_OBJ_RESET,
-				GFP_ATOMIC);
-		kfree(buf);
+	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
+		struct netlink_dump_control c = {
+			.start = nf_tables_dump_obj_start,
+			.dump = nf_tables_dump_obj,
+			.done = nf_tables_dump_obj_done,
+			.module = THIS_MODULE,
+			.data = (void *)nla,
+		};
+
+		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
 	}
 
-	err = nf_tables_fill_obj_info(skb2, net, NETLINK_CB(skb).portid,
-				      info->nlh->nlmsg_seq, NFT_MSG_NEWOBJ, 0,
-				      family, table, obj, reset);
-	if (err < 0)
-		goto err_fill_obj_info;
+	skb2 = nf_tables_getobj_single(portid, info, nla, false);
+	if (IS_ERR(skb2))
+		return PTR_ERR(skb2);
 
-	return nfnetlink_unicast(skb2, net, NETLINK_CB(skb).portid);
+	return nfnetlink_unicast(skb2, info->net, portid);
+}
 
-err_fill_obj_info:
-	kfree_skb(skb2);
-	return err;
+static int nf_tables_getobj_reset(struct sk_buff *skb,
+				  const struct nfnl_info *info,
+				  const struct nlattr * const nla[])
+{
+	struct nftables_pernet *nft_net = nft_pernet(info->net);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct net *net = info->net;
+	struct sk_buff *skb2;
+	char *buf;
+
+	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
+		struct netlink_dump_control c = {
+			.start = nf_tables_dumpreset_obj_start,
+			.dump = nf_tables_dumpreset_obj,
+			.done = nf_tables_dump_obj_done,
+			.module = THIS_MODULE,
+			.data = (void *)nla,
+		};
+
+		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
+	}
+
+	if (!try_module_get(THIS_MODULE))
+		return -EINVAL;
+	rcu_read_unlock();
+	mutex_lock(&nft_net->commit_mutex);
+	skb2 = nf_tables_getobj_single(portid, info, nla, true);
+	mutex_unlock(&nft_net->commit_mutex);
+	rcu_read_lock();
+	module_put(THIS_MODULE);
+
+	if (IS_ERR(skb2))
+		return PTR_ERR(skb2);
+
+	buf = kasprintf(GFP_ATOMIC, "%.*s:%u",
+			nla_len(nla[NFTA_OBJ_TABLE]),
+			(char *)nla_data(nla[NFTA_OBJ_TABLE]),
+			nft_net->base_seq);
+	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
+			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
+	kfree(buf);
+
+	return nfnetlink_unicast(skb2, net, portid);
 }
 
 static void nft_obj_destroy(const struct nft_ctx *ctx, struct nft_object *obj)
@@ -8810,7 +8853,7 @@ static const struct nfnl_callback nf_tables_cb[NFT_MSG_MAX] = {
 		.policy		= nft_obj_policy,
 	},
 	[NFT_MSG_GETOBJ_RESET] = {
-		.call		= nf_tables_getobj,
+		.call		= nf_tables_getobj_reset,
 		.type		= NFNL_CB_RCU,
 		.attr_count	= NFTA_OBJ_MAX,
 		.policy		= nft_obj_policy,
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5bc342cb1376..f13eed826cbb 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -647,10 +647,41 @@ static bool nf_ct_drop_unconfirmed(const struct nf_queue_entry *entry)
 {
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	static const unsigned long flags = IPS_CONFIRMED | IPS_DYING;
-	const struct nf_conn *ct = (void *)skb_nfct(entry->skb);
+	struct nf_conn *ct = (void *)skb_nfct(entry->skb);
+	unsigned long status;
+	unsigned int use;
 
-	if (ct && ((ct->status & flags) == IPS_DYING))
+	if (!ct)
+		return false;
+
+	status = READ_ONCE(ct->status);
+	if ((status & flags) == IPS_DYING)
 		return true;
+
+	if (status & IPS_CONFIRMED)
+		return false;
+
+	/* in some cases skb_clone() can occur after initial conntrack
+	 * pickup, but conntrack assumes exclusive skb->_nfct ownership for
+	 * unconfirmed entries.
+	 *
+	 * This happens for br_netfilter and with ip multicast routing.
+	 * We can't be solved with serialization here because one clone could
+	 * have been queued for local delivery.
+	 */
+	use = refcount_read(&ct->ct_general.use);
+	if (likely(use == 1))
+		return false;
+
+	/* Can't decrement further? Exclusive ownership. */
+	if (!refcount_dec_not_one(&ct->ct_general.use))
+		return false;
+
+	skb_set_nfct(entry->skb, 0);
+	/* No nf_ct_put(): we already decremented .use and it cannot
+	 * drop down to 0.
+	 */
+	return true;
 #endif
 	return false;
 }
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index b5fe7fe4b60d..781d3a26f5df 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -107,11 +107,16 @@ static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
 			      struct nft_counter *total)
 {
 	struct nft_counter *this_cpu;
+	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
+	myseq = this_cpu_ptr(&nft_counter_seq);
+
+	write_seqcount_begin(myseq);
 	this_cpu->packets -= total->packets;
 	this_cpu->bytes -= total->bytes;
+	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
@@ -264,7 +269,7 @@ static void nft_counter_offload_stats(struct nft_expr *expr,
 	struct nft_counter *this_cpu;
 	seqcount_t *myseq;
 
-	preempt_disable();
+	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
 	myseq = this_cpu_ptr(&nft_counter_seq);
 
@@ -272,7 +277,7 @@ static void nft_counter_offload_stats(struct nft_expr *expr,
 	this_cpu->packets += stats->pkts;
 	this_cpu->bytes += stats->bytes;
 	write_seqcount_end(myseq);
-	preempt_enable();
+	local_bh_enable();
 }
 
 void nft_counter_init_seqcount(void)
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e9b81cba1e2b..8d26bd2ae3d5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -130,7 +130,7 @@ static const char *const nlk_cb_mutex_key_strings[MAX_LINKS + 1] = {
 	"nlk_cb_mutex-MAX_LINKS"
 };
 
-static int netlink_dump(struct sock *sk);
+static int netlink_dump(struct sock *sk, bool lock_taken);
 
 /* nl_table locking explained:
  * Lookup and traversal are protected with an RCU read-side lock. Insertion
@@ -1953,7 +1953,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
-		ret = netlink_dump(sk);
+		ret = netlink_dump(sk, false);
 		if (ret) {
 			WRITE_ONCE(sk->sk_err, -ret);
 			sk_error_report(sk);
@@ -2163,7 +2163,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	return 0;
 }
 
-static int netlink_dump(struct sock *sk)
+static int netlink_dump(struct sock *sk, bool lock_taken)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct netlink_ext_ack extack = {};
@@ -2175,7 +2175,8 @@ static int netlink_dump(struct sock *sk)
 	int alloc_min_size;
 	int alloc_size;
 
-	mutex_lock(nlk->cb_mutex);
+	if (!lock_taken)
+		mutex_lock(nlk->cb_mutex);
 	if (!nlk->cb_running) {
 		err = -EINVAL;
 		goto errout_skb;
@@ -2330,9 +2331,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
-	mutex_unlock(nlk->cb_mutex);
-
-	ret = netlink_dump(sk);
+	ret = netlink_dump(sk, true);
 
 	sock_put(sk);
 
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 5b426dc3634d..a316180d3c32 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -424,6 +424,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -434,11 +435,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 					      -be32_to_cpu(inc->i_hdr.h_len),
 					      inc->i_hdr.h_dport);
 			list_del_init(&inc->i_item);
-			rds_inc_put(inc);
+			to_drop = inc;
 		}
 	}
 	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
+	if (to_drop)
+		rds_inc_put(to_drop);
+
 	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret, drop);
 	return ret;
 }
@@ -757,16 +761,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
 	struct sock *sk = rds_rs_to_sk(rs);
 	struct rds_incoming *inc, *tmp;
 	unsigned long flags;
+	LIST_HEAD(to_drop);
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item) {
 		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
 				      -be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
+		list_move(&inc->i_item, &to_drop);
+	}
+	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
+
+	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
 		list_del_init(&inc->i_item);
 		rds_inc_put(inc);
 	}
-	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
 /*
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 7053c0292c33..6ab9359c1706 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -502,7 +502,7 @@ static void dev_watchdog(struct timer_list *t)
 		if (netif_device_present(dev) &&
 		    netif_running(dev) &&
 		    netif_carrier_ok(dev)) {
-			int some_queue_timedout = 0;
+			unsigned int timedout_ms = 0;
 			unsigned int i;
 			unsigned long trans_start;
 
@@ -514,16 +514,17 @@ static void dev_watchdog(struct timer_list *t)
 				if (netif_xmit_stopped(txq) &&
 				    time_after(jiffies, (trans_start +
 							 dev->watchdog_timeo))) {
-					some_queue_timedout = 1;
+					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
 					atomic_long_inc(&txq->trans_timeout);
 					break;
 				}
 			}
 
-			if (unlikely(some_queue_timedout)) {
+			if (unlikely(timedout_ms)) {
 				trace_net_dev_xmit_timeout(dev, i);
-				WARN_ONCE(1, KERN_INFO "NETDEV WATCHDOG: %s (%s): transmit queue %u timed out\n",
-				       dev->name, netdev_drivername(dev), i);
+				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
+					    raw_smp_processor_id(),
+					    i, timedout_ms);
 				netif_freeze_queues(dev);
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d0e045116d4e..a18b24c125f4 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -437,12 +437,10 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct netem_sched_data *q = qdisc_priv(sch);
 	/* We don't fill cb now as skb_unshare() may invalidate it */
 	struct netem_skb_cb *cb;
-	struct sk_buff *skb2;
+	struct sk_buff *skb2 = NULL;
 	struct sk_buff *segs = NULL;
 	unsigned int prev_len = qdisc_pkt_len(skb);
 	int count = 1;
-	int rc = NET_XMIT_SUCCESS;
-	int rc_drop = NET_XMIT_DROP;
 
 	/* Do not fool qdisc_drop_all() */
 	skb->prev = NULL;
@@ -471,19 +469,11 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		skb_orphan_partial(skb);
 
 	/*
-	 * If we need to duplicate packet, then re-insert at top of the
-	 * qdisc tree, since parent queuer expects that only one
-	 * skb will be queued.
+	 * If we need to duplicate packet, then clone it before
+	 * original is modified.
 	 */
-	if (count > 1 && (skb2 = skb_clone(skb, GFP_ATOMIC)) != NULL) {
-		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
-
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
-		rc_drop = NET_XMIT_SUCCESS;
-	}
+	if (count > 1)
+		skb2 = skb_clone(skb, GFP_ATOMIC);
 
 	/*
 	 * Randomized packet corruption.
@@ -495,7 +485,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
-				return rc_drop;
+				goto finish_segs;
+
 			segs = skb->next;
 			skb_mark_not_on_list(skb);
 			qdisc_skb_cb(skb)->pkt_len = skb->len;
@@ -521,7 +512,24 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-		return rc_drop;
+		if (skb2)
+			__qdisc_drop(skb2, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	/*
+	 * If doing duplication then re-insert at top of the
+	 * qdisc tree, since parent queuer expects that only one
+	 * skb will be queued.
+	 */
+	if (skb2) {
+		struct Qdisc *rootq = qdisc_root_bh(sch);
+		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
+
+		q->duplicate = 0;
+		rootq->enqueue(skb2, rootq, to_free);
+		q->duplicate = dupsave;
+		skb2 = NULL;
 	}
 
 	qdisc_qstats_backlog_inc(sch, skb);
@@ -592,9 +600,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 finish_segs:
+	if (skb2)
+		__qdisc_drop(skb2, to_free);
+
 	if (segs) {
 		unsigned int len, last_len;
-		int nb;
+		int rc, nb;
 
 		len = skb ? skb->len : 0;
 		nb = skb ? 1 : 0;
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7182c5a450fb..5c1652181805 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -38,6 +38,14 @@ void sctp_inq_init(struct sctp_inq *queue)
 	INIT_WORK(&queue->immediate, NULL);
 }
 
+/* Properly release the chunk which is being worked on. */
+static inline void sctp_inq_chunk_free(struct sctp_chunk *chunk)
+{
+	if (chunk->head_skb)
+		chunk->skb = chunk->head_skb;
+	sctp_chunk_free(chunk);
+}
+
 /* Release the memory associated with an SCTP inqueue.  */
 void sctp_inq_free(struct sctp_inq *queue)
 {
@@ -53,7 +61,7 @@ void sctp_inq_free(struct sctp_inq *queue)
 	 * free it as well.
 	 */
 	if (queue->in_progress) {
-		sctp_chunk_free(queue->in_progress);
+		sctp_inq_chunk_free(queue->in_progress);
 		queue->in_progress = NULL;
 	}
 }
@@ -130,9 +138,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				goto new_skb;
 			}
 
-			if (chunk->head_skb)
-				chunk->skb = chunk->head_skb;
-			sctp_chunk_free(chunk);
+			sctp_inq_chunk_free(chunk);
 			chunk = queue->in_progress = NULL;
 		} else {
 			/* Nothing to do. Next chunk in the packet, please. */
diff --git a/net/wireless/core.h b/net/wireless/core.h
index ee980965a7cf..8118b8614ac6 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -228,6 +228,7 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 static inline void wdev_lock(struct wireless_dev *wdev)
 	__acquires(wdev)
 {
+	lockdep_assert_held(&wdev->wiphy->mtx);
 	mutex_lock(&wdev->mtx);
 	__acquire(wdev->mtx);
 }
@@ -235,11 +236,16 @@ static inline void wdev_lock(struct wireless_dev *wdev)
 static inline void wdev_unlock(struct wireless_dev *wdev)
 	__releases(wdev)
 {
+	lockdep_assert_held(&wdev->wiphy->mtx);
 	__release(wdev->mtx);
 	mutex_unlock(&wdev->mtx);
 }
 
-#define ASSERT_WDEV_LOCK(wdev) lockdep_assert_held(&(wdev)->mtx)
+static inline void ASSERT_WDEV_LOCK(struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&wdev->wiphy->mtx);
+	lockdep_assert_held(&wdev->mtx);
+}
 
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1665320d2214..c71b85fd6052 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -542,6 +542,66 @@ unsigned int ieee80211_get_mesh_hdrlen(struct ieee80211s_hdr *meshhdr)
 }
 EXPORT_SYMBOL(ieee80211_get_mesh_hdrlen);
 
+bool ieee80211_get_8023_tunnel_proto(const void *hdr, __be16 *proto)
+{
+	const __be16 *hdr_proto = hdr + ETH_ALEN;
+
+	if (!(ether_addr_equal(hdr, rfc1042_header) &&
+	      *hdr_proto != htons(ETH_P_AARP) &&
+	      *hdr_proto != htons(ETH_P_IPX)) &&
+	    !ether_addr_equal(hdr, bridge_tunnel_header))
+		return false;
+
+	*proto = *hdr_proto;
+
+	return true;
+}
+EXPORT_SYMBOL(ieee80211_get_8023_tunnel_proto);
+
+int ieee80211_strip_8023_mesh_hdr(struct sk_buff *skb)
+{
+	const void *mesh_addr;
+	struct {
+		struct ethhdr eth;
+		u8 flags;
+	} payload;
+	int hdrlen;
+	int ret;
+
+	ret = skb_copy_bits(skb, 0, &payload, sizeof(payload));
+	if (ret)
+		return ret;
+
+	hdrlen = sizeof(payload.eth) + __ieee80211_get_mesh_hdrlen(payload.flags);
+
+	if (likely(pskb_may_pull(skb, hdrlen + 8) &&
+		   ieee80211_get_8023_tunnel_proto(skb->data + hdrlen,
+						   &payload.eth.h_proto)))
+		hdrlen += ETH_ALEN + 2;
+	else if (!pskb_may_pull(skb, hdrlen))
+		return -EINVAL;
+	else
+		payload.eth.h_proto = htons(skb->len - hdrlen);
+
+	mesh_addr = skb->data + sizeof(payload.eth) + ETH_ALEN;
+	switch (payload.flags & MESH_FLAGS_AE) {
+	case MESH_FLAGS_AE_A4:
+		memcpy(&payload.eth.h_source, mesh_addr, ETH_ALEN);
+		break;
+	case MESH_FLAGS_AE_A5_A6:
+		memcpy(&payload.eth, mesh_addr, 2 * ETH_ALEN);
+		break;
+	default:
+		break;
+	}
+
+	pskb_pull(skb, hdrlen - sizeof(payload.eth));
+	memcpy(skb->data, &payload.eth, sizeof(payload.eth));
+
+	return 0;
+}
+EXPORT_SYMBOL(ieee80211_strip_8023_mesh_hdr);
+
 int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 				  const u8 *addr, enum nl80211_iftype iftype,
 				  u8 data_offset, bool is_amsdu)
@@ -553,7 +613,6 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	} payload;
 	struct ethhdr tmp;
 	u16 hdrlen;
-	u8 mesh_flags = 0;
 
 	if (unlikely(!ieee80211_is_data_present(hdr->frame_control)))
 		return -1;
@@ -574,12 +633,6 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	memcpy(tmp.h_dest, ieee80211_get_DA(hdr), ETH_ALEN);
 	memcpy(tmp.h_source, ieee80211_get_SA(hdr), ETH_ALEN);
 
-	if (iftype == NL80211_IFTYPE_MESH_POINT &&
-	    skb_copy_bits(skb, hdrlen, &mesh_flags, 1) < 0)
-		return -1;
-
-	mesh_flags &= MESH_FLAGS_AE;
-
 	switch (hdr->frame_control &
 		cpu_to_le16(IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) {
 	case cpu_to_le16(IEEE80211_FCTL_TODS):
@@ -593,17 +646,6 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 			     iftype != NL80211_IFTYPE_AP_VLAN &&
 			     iftype != NL80211_IFTYPE_STATION))
 			return -1;
-		if (iftype == NL80211_IFTYPE_MESH_POINT) {
-			if (mesh_flags == MESH_FLAGS_AE_A4)
-				return -1;
-			if (mesh_flags == MESH_FLAGS_AE_A5_A6 &&
-			    skb_copy_bits(skb, hdrlen +
-					  offsetof(struct ieee80211s_hdr, eaddr1),
-					  tmp.h_dest, 2 * ETH_ALEN) < 0)
-				return -1;
-
-			hdrlen += __ieee80211_get_mesh_hdrlen(mesh_flags);
-		}
 		break;
 	case cpu_to_le16(IEEE80211_FCTL_FROMDS):
 		if ((iftype != NL80211_IFTYPE_STATION &&
@@ -612,16 +654,6 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		    (is_multicast_ether_addr(tmp.h_dest) &&
 		     ether_addr_equal(tmp.h_source, addr)))
 			return -1;
-		if (iftype == NL80211_IFTYPE_MESH_POINT) {
-			if (mesh_flags == MESH_FLAGS_AE_A5_A6)
-				return -1;
-			if (mesh_flags == MESH_FLAGS_AE_A4 &&
-			    skb_copy_bits(skb, hdrlen +
-					  offsetof(struct ieee80211s_hdr, eaddr1),
-					  tmp.h_source, ETH_ALEN) < 0)
-				return -1;
-			hdrlen += __ieee80211_get_mesh_hdrlen(mesh_flags);
-		}
 		break;
 	case cpu_to_le16(0):
 		if (iftype != NL80211_IFTYPE_ADHOC &&
@@ -631,15 +663,11 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		break;
 	}
 
-	if (likely(skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) == 0 &&
-	           ((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) &&
-		     payload.proto != htons(ETH_P_AARP) &&
-		     payload.proto != htons(ETH_P_IPX)) ||
-		    ether_addr_equal(payload.hdr, bridge_tunnel_header)))) {
-		/* remove RFC1042 or Bridge-Tunnel encapsulation and
-		 * replace EtherType */
+	if (likely(!is_amsdu && iftype != NL80211_IFTYPE_MESH_POINT &&
+		   skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) == 0 &&
+		   ieee80211_get_8023_tunnel_proto(&payload, &tmp.h_proto))) {
+		/* remove RFC1042 or Bridge-Tunnel encapsulation */
 		hdrlen += ETH_ALEN + 2;
-		tmp.h_proto = payload.proto;
 		skb_postpull_rcsum(skb, &payload, ETH_ALEN + 2);
 	} else {
 		tmp.h_proto = htons(skb->len - hdrlen);
@@ -711,7 +739,8 @@ __ieee80211_amsdu_copy_frag(struct sk_buff *skb, struct sk_buff *frame,
 
 static struct sk_buff *
 __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
-		       int offset, int len, bool reuse_frag)
+		       int offset, int len, bool reuse_frag,
+		       int min_len)
 {
 	struct sk_buff *frame;
 	int cur_len = len;
@@ -725,7 +754,7 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 	 * in the stack later.
 	 */
 	if (reuse_frag)
-		cur_len = min_t(int, len, 32);
+		cur_len = min_t(int, len, min_len);
 
 	/*
 	 * Allocate and reserve two bytes more for payload
@@ -735,6 +764,7 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 	if (!frame)
 		return NULL;
 
+	frame->priority = skb->priority;
 	skb_reserve(frame, hlen + sizeof(struct ethhdr) + 2);
 	skb_copy_bits(skb, offset, skb_put(frame, cur_len), cur_len);
 
@@ -748,46 +778,96 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 	return frame;
 }
 
+bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr)
+{
+	int offset = 0, subframe_len, padding;
+
+	for (offset = 0; offset < skb->len; offset += subframe_len + padding) {
+		int remaining = skb->len - offset;
+		struct {
+		    __be16 len;
+		    u8 mesh_flags;
+		} hdr;
+		u16 len;
+
+		if (sizeof(hdr) > remaining)
+			return false;
+
+		if (skb_copy_bits(skb, offset + 2 * ETH_ALEN, &hdr, sizeof(hdr)) < 0)
+			return false;
+
+		if (mesh_hdr)
+			len = le16_to_cpu(*(__le16 *)&hdr.len) +
+			      __ieee80211_get_mesh_hdrlen(hdr.mesh_flags);
+		else
+			len = ntohs(hdr.len);
+
+		subframe_len = sizeof(struct ethhdr) + len;
+		padding = (4 - subframe_len) & 0x3;
+
+		if (subframe_len > remaining)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(ieee80211_is_valid_amsdu);
+
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
-			      const u8 *check_da, const u8 *check_sa)
+			      const u8 *check_da, const u8 *check_sa,
+			      bool mesh_control)
 {
 	unsigned int hlen = ALIGN(extra_headroom, 4);
 	struct sk_buff *frame = NULL;
-	u16 ethertype;
-	u8 *payload;
-	int offset = 0, remaining;
-	struct ethhdr eth;
+	int offset = 0;
+	struct {
+		struct ethhdr eth;
+		uint8_t flags;
+	} hdr;
 	bool reuse_frag = skb->head_frag && !skb_has_frag_list(skb);
 	bool reuse_skb = false;
 	bool last = false;
+	int copy_len = sizeof(hdr.eth);
+
+	if (iftype == NL80211_IFTYPE_MESH_POINT)
+		copy_len = sizeof(hdr);
 
 	while (!last) {
+		int remaining = skb->len - offset;
 		unsigned int subframe_len;
-		int len;
+		int len, mesh_len = 0;
 		u8 padding;
 
-		skb_copy_bits(skb, offset, &eth, sizeof(eth));
-		len = ntohs(eth.h_proto);
+		if (copy_len > remaining)
+			goto purge;
+
+		skb_copy_bits(skb, offset, &hdr, copy_len);
+		if (iftype == NL80211_IFTYPE_MESH_POINT)
+			mesh_len = __ieee80211_get_mesh_hdrlen(hdr.flags);
+		if (mesh_control)
+			len = le16_to_cpu(*(__le16 *)&hdr.eth.h_proto) + mesh_len;
+		else
+			len = ntohs(hdr.eth.h_proto);
+
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
 
 		/* the last MSDU has no padding */
-		remaining = skb->len - offset;
 		if (subframe_len > remaining)
 			goto purge;
 		/* mitigate A-MSDU aggregation injection attacks */
-		if (ether_addr_equal(eth.h_dest, rfc1042_header))
+		if (ether_addr_equal(hdr.eth.h_dest, rfc1042_header))
 			goto purge;
 
 		offset += sizeof(struct ethhdr);
 		last = remaining <= subframe_len + padding;
 
 		/* FIXME: should we really accept multicast DA? */
-		if ((check_da && !is_multicast_ether_addr(eth.h_dest) &&
-		     !ether_addr_equal(check_da, eth.h_dest)) ||
-		    (check_sa && !ether_addr_equal(check_sa, eth.h_source))) {
+		if ((check_da && !is_multicast_ether_addr(hdr.eth.h_dest) &&
+		     !ether_addr_equal(check_da, hdr.eth.h_dest)) ||
+		    (check_sa && !ether_addr_equal(check_sa, hdr.eth.h_source))) {
 			offset += len + padding;
 			continue;
 		}
@@ -799,7 +879,7 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			reuse_skb = true;
 		} else {
 			frame = __ieee80211_amsdu_copy(skb, hlen, offset, len,
-						       reuse_frag);
+						       reuse_frag, 32 + mesh_len);
 			if (!frame)
 				goto purge;
 
@@ -810,16 +890,11 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		frame->dev = skb->dev;
 		frame->priority = skb->priority;
 
-		payload = frame->data;
-		ethertype = (payload[6] << 8) | payload[7];
-		if (likely((ether_addr_equal(payload, rfc1042_header) &&
-			    ethertype != ETH_P_AARP && ethertype != ETH_P_IPX) ||
-			   ether_addr_equal(payload, bridge_tunnel_header))) {
-			eth.h_proto = htons(ethertype);
+		if (likely(iftype != NL80211_IFTYPE_MESH_POINT &&
+			   ieee80211_get_8023_tunnel_proto(frame->data, &hdr.eth.h_proto)))
 			skb_pull(frame, ETH_ALEN + 2);
-		}
 
-		memcpy(skb_push(frame, sizeof(eth)), &eth, sizeof(eth));
+		memcpy(skb_push(frame, sizeof(hdr.eth)), &hdr.eth, sizeof(hdr.eth));
 		__skb_queue_tail(list, frame);
 	}
 
diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index 1bb53f4b29e1..cb5c776103b9 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -370,7 +370,7 @@ static void run_perf_test(int tasks)
 
 static void fill_lpm_trie(void)
 {
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	unsigned long value = 0;
 	unsigned int i;
 	int r;
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 683913bbf279..28bae295d0ed 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -91,7 +91,7 @@ static int recv_msg(struct sockaddr_nl sock_addr, int sock)
 static void read_route(struct nlmsghdr *nh, int nll)
 {
 	char dsts[24], gws[24], ifs[16], dsts_len[24], metrics[24];
-	struct bpf_lpm_trie_key *prefix_key;
+	struct bpf_lpm_trie_key_u8 *prefix_key;
 	struct rtattr *rt_attr;
 	struct rtmsg *rt_msg;
 	int rtm_family;
diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 7a925d2b20fc..141644c16463 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -38,10 +38,21 @@ fi
 # Check that the Rust compiler version is suitable.
 #
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
+rust_compiler_output=$( \
+	LC_ALL=C "$RUSTC" --version 2>/dev/null
+) || rust_compiler_code=$?
+if [ -n "$rust_compiler_code" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$RUSTC' to check the Rust compiler version failed with"
+	echo >&2 "*** code $rust_compiler_code. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$rust_compiler_output"
+	echo >&2 "***"
+	exit 1
+fi
 rust_compiler_version=$( \
-	LC_ALL=C "$RUSTC" --version 2>/dev/null \
-		| head -n 1 \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+	echo "$rust_compiler_output" \
+		| sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 rust_compiler_min_version=$($min_tool_version rustc)
 rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
@@ -65,10 +76,25 @@ fi
 # Check that the Rust bindings generator is suitable.
 #
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
+#
+# The dummy parameter `workaround-for-0.69.0` is required to support 0.69.0
+# (https://github.com/rust-lang/rust-bindgen/pull/2678). It can be removed when
+# the minimum version is upgraded past that (0.69.1 already fixed the issue).
+rust_bindings_generator_output=$( \
+	LC_ALL=C "$BINDGEN" --version workaround-for-0.69.0 2>/dev/null
+) || rust_bindings_generator_code=$?
+if [ -n "$rust_bindings_generator_code" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$BINDGEN' to check the Rust bindings generator version failed with"
+	echo >&2 "*** code $rust_bindings_generator_code. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$rust_bindings_generator_output"
+	echo >&2 "***"
+	exit 1
+fi
 rust_bindings_generator_version=$( \
-	LC_ALL=C "$BINDGEN" --version 2>/dev/null \
-		| head -n 1 \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+	echo "$rust_bindings_generator_output" \
+		| sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 rust_bindings_generator_min_version=$($min_tool_version bindgen)
 rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
@@ -110,6 +136,9 @@ fi
 
 # `bindgen` returned successfully, thus use the output to check that the version
 # of the `libclang` found by the Rust bindings generator is suitable.
+#
+# Unlike other version checks, note that this one does not necessarily appear
+# in the first line of the output, thus no `sed` address is provided.
 bindgen_libclang_version=$( \
 	echo "$bindgen_libclang_output" \
 		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..8984ba92676d 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -332,12 +332,12 @@ static int avc_add_xperms_decision(struct avc_node *node,
 {
 	struct avc_xperms_decision_node *dest_xpd;
 
-	node->ae.xp_node->xp.len++;
 	dest_xpd = avc_xperms_decision_alloc(src->used);
 	if (!dest_xpd)
 		return -ENOMEM;
 	avc_copy_xperms_decision(&dest_xpd->xpd, src);
 	list_add(&dest_xpd->xpd_list, &node->ae.xp_node->xpd_head);
+	node->ae.xp_node->xp.len++;
 	return 0;
 }
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 38f3b30efae7..ecad57a1bc5b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -556,7 +556,7 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 	/* check the actual time for the start tick;
 	 * bail out as error if it's way too low (< 100us)
 	 */
-	if (start) {
+	if (start && !(timer->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
 		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
 			result = -EINVAL;
 			goto unlock;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 93d65a1acc47..b942ed868070 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -583,7 +583,6 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
-	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
 	case 0x10ec0285:
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index 06e1872abfee..1449837b0fb2 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -616,7 +616,14 @@ static void sof_ipc4_rx_msg(struct snd_sof_dev *sdev)
 			return;
 
 		ipc4_msg->data_size = data_size;
-		snd_sof_ipc_msg_data(sdev, NULL, ipc4_msg->data_ptr, ipc4_msg->data_size);
+		err = snd_sof_ipc_msg_data(sdev, NULL, ipc4_msg->data_ptr, ipc4_msg->data_size);
+		if (err < 0) {
+			dev_err(sdev->dev, "failed to read IPC notification data: %d\n", err);
+			kfree(ipc4_msg->data_ptr);
+			ipc4_msg->data_ptr = NULL;
+			ipc4_msg->data_size = 0;
+			return;
+		}
 	}
 
 	sof_ipc4_log_header(sdev->dev, "ipc rx done ", ipc4_msg, true);
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5699a62d1767..34ded71cb807 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2023,6 +2023,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		bmaControls = ftr->bmaControls;
 	}
 
+	if (channels > 32) {
+		usb_audio_info(state->chip,
+			       "usbmixer: too many channels (%d) in unit %d\n",
+			       channels, unitid);
+		return -EINVAL;
+	}
+
 	/* parse the source unit */
 	err = parse_audio_unit(state, hdr->bSourceID);
 	if (err < 0)
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index af1b8cf5a988..d2aa97a5c438 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -273,6 +273,7 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
+YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 733a25275fe9..f9ba10d4f1e1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2179,6 +2179,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..14e34ace80dd
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_ALIGN_H
+#define _TOOLS_LINUX_ALIGN_H
+
+#include <uapi/linux/const.h>
+
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif /* _TOOLS_LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 65d0747c5205..2cbabc1dcf0f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/find.h>
 #include <stdlib.h>
@@ -25,13 +26,14 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = 0UL;
 	else {
-		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-		memset(dst, 0, len);
+		memset(dst, 0, bitmap_size(nbits));
 	}
 }
 
@@ -117,7 +119,7 @@ static inline int test_and_clear_bit(int nr, unsigned long *addr)
  */
 static inline unsigned long *bitmap_zalloc(int nbits)
 {
-	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+	return calloc(1, bitmap_size(nbits));
 }
 
 /*
@@ -160,7 +162,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline bool bitmap_equal(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index 2f401e8c6c0b..66ca5f9a0e09 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -2,8 +2,8 @@
 #ifndef _TOOLS_LINUX_MM_H
 #define _TOOLS_LINUX_MM_H
 
+#include <linux/align.h>
 #include <linux/mmzone.h>
-#include <uapi/linux/const.h>
 
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
@@ -11,9 +11,6 @@
 
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
-#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
-#define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))
-
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
 #define __va(x) ((void *)((unsigned long)(x)))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a17688011440..58c7fc75da75 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -76,12 +76,29 @@ struct bpf_insn {
 	__s32	imm;		/* signed immediate constant */
 };
 
-/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
+ * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
+ * the trailing flexible array member) instead.
+ */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* Header for bpf_lpm_trie_key structs */
+struct bpf_lpm_trie_key_hdr {
+	__u32	prefixlen;
+};
+
+/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
+struct bpf_lpm_trie_key_u8 {
+	union {
+		struct bpf_lpm_trie_key_hdr	hdr;
+		__u32				prefixlen;
+	};
+	__u8	data[];		/* Arbitrary size */
+};
+
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index db388f593d0a..96eed198af36 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -311,7 +311,7 @@ struct lpm_trie {
 } __attribute__((preserve_access_index));
 
 struct lpm_key {
-	struct bpf_lpm_trie_key trie_key;
+	struct bpf_lpm_trie_key_hdr trie_key;
 	__u32 data;
 };
 
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
index c028d621c744..d98c72dc563e 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -211,7 +211,7 @@ static void test_lpm_map(int keysize)
 	volatile size_t n_matches, n_matches_after_delete;
 	size_t i, j, n_nodes, n_lookups;
 	struct tlpm_node *t, *list = NULL;
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	uint8_t *data, *value;
 	int r, map;
 
@@ -331,8 +331,8 @@ static void test_lpm_map(int keysize)
 static void test_lpm_ipaddr(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key_ipv4;
-	struct bpf_lpm_trie_key *key_ipv6;
+	struct bpf_lpm_trie_key_u8 *key_ipv4;
+	struct bpf_lpm_trie_key_u8 *key_ipv6;
 	size_t key_size_ipv4;
 	size_t key_size_ipv6;
 	int map_fd_ipv4;
@@ -423,7 +423,7 @@ static void test_lpm_ipaddr(void)
 static void test_lpm_delete(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	size_t key_size;
 	int map_fd;
 	__u64 value;
@@ -532,7 +532,7 @@ static void test_lpm_delete(void)
 static void test_lpm_get_next_key(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key_p, *next_key_p;
+	struct bpf_lpm_trie_key_u8 *key_p, *next_key_p;
 	size_t key_size;
 	__u32 value = 0;
 	int map_fd;
@@ -693,9 +693,9 @@ static void *lpm_test_command(void *arg)
 {
 	int i, j, ret, iter, key_size;
 	struct lpm_mt_test_info *info = arg;
-	struct bpf_lpm_trie_key *key_p;
+	struct bpf_lpm_trie_key_u8 *key_p;
 
-	key_size = sizeof(struct bpf_lpm_trie_key) + sizeof(__u32);
+	key_size = sizeof(*key_p) + sizeof(__u32);
 	key_p = alloca(key_size);
 	for (iter = 0; iter < info->iter; iter++)
 		for (i = 0; i < MAX_TEST_KEYS; i++) {
@@ -717,7 +717,7 @@ static void *lpm_test_command(void *arg)
 				ret = bpf_map_lookup_elem(info->map_fd, key_p, &value);
 				assert(ret == 0 || errno == ENOENT);
 			} else {
-				struct bpf_lpm_trie_key *next_key_p = alloca(key_size);
+				struct bpf_lpm_trie_key_u8 *next_key_p = alloca(key_size);
 				ret = bpf_map_get_next_key(info->map_fd, key_p, next_key_p);
 				assert(ret == 0 || errno == ENOENT || errno == ENOMEM);
 			}
@@ -752,7 +752,7 @@ static void test_lpm_multi_thread(void)
 
 	/* create a trie */
 	value_size = sizeof(__u32);
-	key_size = sizeof(struct bpf_lpm_trie_key) + value_size;
+	key_size = sizeof(struct bpf_lpm_trie_key_hdr) + value_size;
 	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL, key_size, value_size, 100, &opts);
 
 	/* create 4 threads to test update, delete, lookup and get_next_key */
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 749239930ca8..190c57b0efeb 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -563,4 +563,39 @@ TEST(close_range_cloexec_unshare_syzbot)
 	EXPECT_EQ(close(fd3), 0);
 }
 
+TEST(close_range_bitmap_corruption)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	/* get the first 128 descriptors open */
+	for (int i = 2; i < 128; i++)
+		EXPECT_GE(dup2(0, i), 0);
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* unshare and truncate descriptor table down to 64 */
+		if (sys_close_range(64, ~0U, CLOSE_RANGE_UNSHARE))
+			exit(EXIT_FAILURE);
+
+		ASSERT_EQ(fcntl(64, F_GETFD), -1);
+		/* ... and verify that the range 64..127 is not
+		   stuck "fully used" according to secondary bitmap */
+		EXPECT_EQ(dup(0), 64)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
new file mode 100755
index 000000000000..6596fe03c77f
--- /dev/null
+++ b/tools/testing/selftests/net/net_helper.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Helper functions
+
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+	local protocol="${3}"
+	local pattern
+	local i
+
+	pattern=":$(printf "%04X" "${port}") "
+
+	# for tcp protocol additionally check the socket state
+	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
+	for i in $(seq 10); do
+		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
+		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
+			break
+		fi
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..241c6c37994d 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro functional tests.
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -44,18 +46,19 @@ run_one() {
 	local -r all="$@"
 	local -r tx_args=${all%rx*}
 	local -r rx_args=${all#*rx}
+	local ret=0
 
 	cfg_veth
 
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} && \
-		echo "ok" || \
-		echo "failed" &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
+	local PID1=$!
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen ${PEER_NS} 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
-	wait $(jobs -p)
+	check_err $?
+	wait ${PID1}
+	check_err $?
+	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
 	return $ret
 }
 
@@ -72,6 +75,7 @@ run_one_nat() {
 	local -r all="$@"
 	local -r tx_args=${all%rx*}
 	local -r rx_args=${all#*rx}
+	local ret=0
 
 	if [[ ${tx_args} = *-4* ]]; then
 		ipt_cmd=iptables
@@ -92,16 +96,17 @@ run_one_nat() {
 	# ... so that GRO will match the UDP_GRO enabled socket, but packets
 	# will land on the 'plain' one
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -G ${family} -b ${addr1} -n 0 &
-	pid=$!
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${family} -b ${addr2%/*} ${rx_args} && \
-		echo "ok" || \
-		echo "failed"&
+	local PID1=$!
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${family} -b ${addr2%/*} ${rx_args} &
+	local PID2=$!
 
-	sleep 0.1
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
-	kill -INT $pid
-	wait $(jobs -p)
+	check_err $?
+	kill -INT ${PID1}
+	wait ${PID2}
+	check_err $?
+	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
 	return $ret
 }
 
@@ -110,22 +115,26 @@ run_one_2sock() {
 	local -r all="$@"
 	local -r tx_args=${all%rx*}
 	local -r rx_args=${all#*rx}
+	local ret=0
 
 	cfg_veth
 
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} && \
-		echo "ok" || \
-		echo "failed" &
+	local PID1=$!
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} &
+	local PID2=$!
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 12345 udp
 	./udpgso_bench_tx ${tx_args} -p 12345
-	sleep 0.1
-	# first UDP GSO socket should be closed at this point
+	check_err $?
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
-	wait $(jobs -p)
+	check_err $?
+	wait ${PID1}
+	check_err $?
+	wait ${PID2}
+	check_err $?
+	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
 	return $ret
 }
 
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 894972877e8b..cb664679b434 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -40,8 +42,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 0a6359bed0b9..dd47fa96f6b3 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -45,8 +47,7 @@ run_one() {
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de2..b02080d09fbc 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -34,7 +34,7 @@
 #endif
 
 #ifndef UDP_MAX_SEGMENTS
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 #endif
 
 #define CONST_MTU_TEST	1500
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index ee22e3447ec7..4702c99c99d3 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -129,7 +129,6 @@ class PluginMgr:
             except Exception as ee:
                 print('exception {} in call to pre_case for {} plugin'.
                       format(ee, pgn_inst.__class__))
-                print('test_ordinal is {}'.format(test_ordinal))
                 print('testid is {}'.format(caseinfo['id']))
                 raise
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 6c07f360de72..2e3c70723fdc 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -520,8 +520,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 		return NULL;
 
 	tool->data = osnoise_alloc_top(nr_cpus);
-	if (!tool->data)
-		goto out_err;
+	if (!tool->data) {
+		osnoise_destroy_tool(tool);
+		return NULL;
+	}
 
 	tool->params = params;
 
@@ -529,11 +531,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 				   osnoise_top_handler, NULL);
 
 	return tool;
-
-out_err:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(tool);
-	return NULL;
 }
 
 static int stop_tracing;

