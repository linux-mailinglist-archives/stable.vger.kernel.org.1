Return-Path: <stable+bounces-120772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64668A50845
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE6A3AED6F
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62D1FC7D0;
	Wed,  5 Mar 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2T3vYSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860C1ACEDD;
	Wed,  5 Mar 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197928; cv=none; b=qZL95dXFwwPlphchWjCoc32cSFATSCZsr3Gy9TA0tx7XZnd5E98HC36gExqhKSSHqk03b67hDEKHH0xWctfOXX6BEeIgtSR51edNRup0pSzcVDW3lzgBVJirt0nml5qE2Rz6OZJWMRAoIbzvaPYwU1bnS73YlEc/atpR2wVwMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197928; c=relaxed/simple;
	bh=TY4f8Ir3472wZHa3/aa1HXd4U6ZdjcESb98ac5kchM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieezgZ/i+vtb93myHhAxIwctmkm3jrKLHIsHGay5m5Sb4UG6JY29VpB0UEjxGhqRKKzytJ0YoSu46HUac4u+7s366M9QFYK8PbUuFiBvCLr6MhM35Z7JP3EyRKaY5BKZBzRGgj0hcs4x9aCVlkusJuB1Ss0aKdmjtLA0ll087DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2T3vYSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CD7C4CED1;
	Wed,  5 Mar 2025 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197928;
	bh=TY4f8Ir3472wZHa3/aa1HXd4U6ZdjcESb98ac5kchM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2T3vYSPt286d5LbqvG8SzT625DCbLCEwJPXHeXPsJgPvK1PpIQhFnhFjhAdaZ7hm
	 p/39hwCpU/ZDsPRCq5Ne23L8oB5RdQBayqXk5+XCqiB7vEwc84AjlmB+zmlKRC3gBg
	 FOLGN3qmQ579KsqK/JGoj2zm7szDDk2t7Jm7g9Ag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.6 141/142] x86/microcode/AMD: Add get_patch_level()
Date: Wed,  5 Mar 2025 18:49:20 +0100
Message-ID: <20250305174506.001354051@linuxfoundation.org>
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

commit 037e81fb9d2dfe7b31fd97e5f578854e38f09887 upstream

Put the MSR_AMD64_PATCH_LEVEL reading of the current microcode revision
the hw has, into a separate function.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-6-bp@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c |   46 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -147,6 +147,15 @@ ucode_path[] __maybe_unused = "kernel/x8
  */
 static u32 bsp_cpuid_1_eax __ro_after_init;
 
+static u32 get_patch_level(void)
+{
+	u32 rev, dummy __always_unused;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	return rev;
+}
+
 static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 {
 	union zen_patch_rev p;
@@ -486,10 +495,10 @@ static void scan_containers(u8 *ucode, s
 	}
 }
 
-static bool __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
+static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
+				  unsigned int psize)
 {
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
-	u32 rev, dummy;
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
 
@@ -507,9 +516,8 @@ static bool __apply_microcode_amd(struct
 	}
 
 	/* verify patch application was successful */
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev != mc->hdr.patch_id)
+	*cur_rev = get_patch_level();
+	if (*cur_rev != mc->hdr.patch_id)
 		return false;
 
 	return true;
@@ -567,11 +575,12 @@ void __init load_ucode_amd_bsp(struct ea
 	struct cont_desc desc = { };
 	struct microcode_amd *mc;
 	struct cpio_data cp = { };
-	u32 dummy;
+	u32 rev;
 
 	bsp_cpuid_1_eax = cpuid_1_eax;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
+	rev = get_patch_level();
+	ed->old_rev = rev;
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
@@ -593,8 +602,8 @@ void __init load_ucode_amd_bsp(struct ea
 	if (ed->old_rev > mc->hdr.patch_id)
 		return;
 
-	if (__apply_microcode_amd(mc, desc.psize))
-		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
+	if (__apply_microcode_amd(mc, &rev, desc.psize))
+		ed->new_rev = rev;
 }
 
 static inline bool patch_cpus_equivalent(struct ucode_patch *p,
@@ -696,14 +705,9 @@ static void free_cache(void)
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u32 rev, dummy __always_unused;
 	u16 equiv_id;
 
-	/* fetch rev if not populated yet: */
-	if (!uci->cpu_sig.rev) {
-		rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-		uci->cpu_sig.rev = rev;
-	}
+	uci->cpu_sig.rev = get_patch_level();
 
 	if (x86_family(bsp_cpuid_1_eax) < 0x17) {
 		equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
@@ -726,22 +730,20 @@ void reload_ucode_amd(unsigned int cpu)
 
 	mc = p->data;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
+	rev = get_patch_level();
 	if (rev < mc->hdr.patch_id) {
-		if (__apply_microcode_amd(mc, p->size))
-			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
+		if (__apply_microcode_amd(mc, &rev, p->size))
+			pr_info_once("reload revision: 0x%08x\n", rev);
 	}
 }
 
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct ucode_patch *p;
 
 	csig->sig = cpuid_eax(0x00000001);
-	csig->rev = c->microcode;
+	csig->rev = get_patch_level();
 
 	/*
 	 * a patch could have been loaded early, set uci->mc so that
@@ -782,7 +784,7 @@ static enum ucode_state apply_microcode_
 		goto out;
 	}
 
-	if (!__apply_microcode_amd(mc_amd, p->size)) {
+	if (!__apply_microcode_amd(mc_amd, &rev, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;



