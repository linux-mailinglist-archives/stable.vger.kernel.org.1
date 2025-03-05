Return-Path: <stable+bounces-120753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0ABA50828
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6C8163D8F
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54F21FC7D0;
	Wed,  5 Mar 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PVighNum"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A714B075;
	Wed,  5 Mar 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197873; cv=none; b=LA9MRtmthzgESTX+NRXQNDWjqYCQMmoe4VAFm6ab4dCWu/b24zaDRQi28CGv/H2zkbKqgmRphpIMLYFwP5MB+NK7QMHmOhCMRDVsXJRQTGoqyyPO5tEnkGyv2juwx219OOocKuj4FFSo/E5PkpZjT8EQAv40WOhKJ+8+QrAPVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197873; c=relaxed/simple;
	bh=g2qSubXm/le7N8mehLXZow5xKi2RJgn4T8ybhFan7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaI+TJv2qrAuedNPDVG8FNO4zy+GCCeyBGzieiQyw6YBUzilLKbA/YwHrIDvoAfajpN6PMPk2+dBs37FUvAb6tF2zvWJruSLa20lusf/ISucMBO6GQ/haFRHo59AnK2iu5i2wVmjbPMJ8bUgO/xKlB5PyfFCVXLHTo6aywcJpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PVighNum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1754CC4CED1;
	Wed,  5 Mar 2025 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197873;
	bh=g2qSubXm/le7N8mehLXZow5xKi2RJgn4T8ybhFan7UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVighNumQvYfIHPQvy8EtdwF+jYe+7ctlrtOeq8RexlEZq4slS/YqnHrUkZ8fI8Ss
	 XQU4CrmMOmk6k5m5w/kzPhuVTfUHS9Zrt/mzxpDYmTMjQhOpWOfcRAXT8oiw2uZfSv
	 4r0g76QiqbN6IFuoddIl1fIluK//JnFV3Z/Xy4pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.6 129/142] x86/microcode: Rework early revisions reporting
Date: Wed,  5 Mar 2025 18:49:08 +0100
Message-ID: <20250305174505.519636201@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Borislav Petkov (AMD)" <bp@alien8.de>

commit 080990aa3344123673f686cda2df0d1b0deee046 upstream

The AMD side of the loader issues the microcode revision for each
logical thread on the system, which can become really noisy on huge
machines. And doing that doesn't make a whole lot of sense - the
microcode revision is already in /proc/cpuinfo.

So in case one is interested in the theoretical support of mixed silicon
steppings on AMD, one can check there.

What is also missing on the AMD side - something which people have
requested before - is showing the microcode revision the CPU had
*before* the early update.

So abstract that up in the main code and have the BSP on each vendor
provide those revision numbers.

Then, dump them only once on driver init.

On Intel, do not dump the patch date - it is not needed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/CAHk-=wg=%2B8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c      |   39 ++++++++-----------------------
 arch/x86/kernel/cpu/microcode/core.c     |   11 +++++++-
 arch/x86/kernel/cpu/microcode/intel.c    |   17 +++++--------
 arch/x86/kernel/cpu/microcode/internal.h |   14 +++++++----
 4 files changed, 37 insertions(+), 44 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -104,8 +104,6 @@ struct cont_desc {
 	size_t		     size;
 };
 
-static u32 ucode_new_rev;
-
 /*
  * Microcode patch container file is prepended to the initrd in cpio
  * format. See Documentation/arch/x86/microcode.rst
@@ -442,12 +440,11 @@ static int __apply_microcode_amd(struct
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
+static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
 	bool ret = false;
-	u32 rev, dummy;
 
 	desc.cpuid_1_eax = cpuid_1_eax;
 
@@ -457,22 +454,15 @@ static bool early_apply_microcode(u32 cp
 	if (!mc)
 		return ret;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/*
 	 * Allow application of the same revision to pick up SMT-specific
 	 * changes even if the revision of the other SMT thread is already
 	 * up-to-date.
 	 */
-	if (rev > mc->hdr.patch_id)
+	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
-	if (!__apply_microcode_amd(mc)) {
-		ucode_new_rev = mc->hdr.patch_id;
-		ret = true;
-	}
-
-	return ret;
+	return !__apply_microcode_amd(mc);
 }
 
 static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
@@ -506,9 +496,12 @@ static void __init find_blobs_in_contain
 	*ret = cp;
 }
 
-void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
+void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
+	u32 dummy;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
@@ -517,7 +510,8 @@ void __init load_ucode_amd_bsp(unsigned
 	if (!(cp.data && cp.size))
 		return;
 
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
+	if (early_apply_microcode(cpuid_1_eax, ed->old_rev, cp.data, cp.size))
+		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
@@ -625,10 +619,8 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev = mc->hdr.patch_id;
-			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
-		}
+		if (!__apply_microcode_amd(mc))
+			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
 
@@ -649,8 +641,6 @@ static int collect_cpu_info_amd(int cpu,
 	if (p && (p->patch_id == csig->rev))
 		uci->mc = p->data;
 
-	pr_info("CPU%d: patch_level=0x%08x\n", cpu, csig->rev);
-
 	return 0;
 }
 
@@ -691,8 +681,6 @@ static enum ucode_state apply_microcode_
 	rev = mc_amd->hdr.patch_id;
 	ret = UCODE_UPDATED;
 
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
-
 out:
 	uci->cpu_sig.rev = rev;
 	c->microcode	 = rev;
@@ -935,11 +923,6 @@ struct microcode_ops * __init init_amd_m
 		pr_warn("AMD CPU family 0x%x not supported\n", c->x86);
 		return NULL;
 	}
-
-	if (ucode_new_rev)
-		pr_info_once("microcode updated early to new patch_level=0x%08x\n",
-			     ucode_new_rev);
-
 	return &microcode_amd_ops;
 }
 
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -77,6 +77,8 @@ static u32 final_levels[] = {
 	0, /* T-101 terminator */
 };
 
+struct early_load_data early_data;
+
 /*
  * Check the current patch level on this CPU.
  *
@@ -155,9 +157,9 @@ void __init load_ucode_bsp(void)
 		return;
 
 	if (intel)
-		load_ucode_intel_bsp();
+		load_ucode_intel_bsp(&early_data);
 	else
-		load_ucode_amd_bsp(cpuid_1_eax);
+		load_ucode_amd_bsp(&early_data, cpuid_1_eax);
 }
 
 void load_ucode_ap(void)
@@ -828,6 +830,11 @@ static int __init microcode_init(void)
 	if (!microcode_ops)
 		return -ENODEV;
 
+	pr_info_once("Current revision: 0x%08x\n", (early_data.new_rev ?: early_data.old_rev));
+
+	if (early_data.new_rev)
+		pr_info_once("Updated early from: 0x%08x\n", early_data.old_rev);
+
 	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -339,16 +339,9 @@ static enum ucode_state __apply_microcod
 static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc = uci->mc;
-	enum ucode_state ret;
-	u32 cur_rev, date;
+	u32 cur_rev;
 
-	ret = __apply_microcode(uci, mc, &cur_rev);
-	if (ret == UCODE_UPDATED) {
-		date = mc->hdr.date;
-		pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
-			     cur_rev, mc->hdr.rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
-	}
-	return ret;
+	return __apply_microcode(uci, mc, &cur_rev);
 }
 
 static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
@@ -413,13 +406,17 @@ static int __init save_builtin_microcode
 early_initcall(save_builtin_microcode);
 
 /* Load microcode on BSP from initrd or builtin blobs */
-void __init load_ucode_intel_bsp(void)
+void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
 	struct ucode_cpu_info uci;
 
+	ed->old_rev = intel_get_microcode_revision();
+
 	uci.mc = get_microcode_blob(&uci, false);
 	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
 		ucode_patch_va = UCODE_BSP_LOADED;
+
+	ed->new_rev = uci.cpu_sig.rev;
 }
 
 void load_ucode_intel_ap(void)
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -37,6 +37,12 @@ struct microcode_ops {
 				use_nmi		: 1;
 };
 
+struct early_load_data {
+	u32 old_rev;
+	u32 new_rev;
+};
+
+extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path);
 
@@ -92,14 +98,14 @@ extern bool dis_ucode_ldr;
 extern bool force_minrev;
 
 #ifdef CONFIG_CPU_SUP_AMD
-void load_ucode_amd_bsp(unsigned int family);
+void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
 int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
 void exit_amd_microcode(void);
 #else /* CONFIG_CPU_SUP_AMD */
-static inline void load_ucode_amd_bsp(unsigned int family) { }
+static inline void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
 static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) { }
@@ -108,12 +114,12 @@ static inline void exit_amd_microcode(vo
 #endif /* !CONFIG_CPU_SUP_AMD */
 
 #ifdef CONFIG_CPU_SUP_INTEL
-void load_ucode_intel_bsp(void);
+void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
 #else /* CONFIG_CPU_SUP_INTEL */
-static inline void load_ucode_intel_bsp(void) { }
+static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
 static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }



