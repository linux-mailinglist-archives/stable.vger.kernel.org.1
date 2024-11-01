Return-Path: <stable+bounces-89461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47689B8860
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC29282B41
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F652837A;
	Fri,  1 Nov 2024 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7kyfqjT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4E4D8D1;
	Fri,  1 Nov 2024 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424391; cv=none; b=N/1Lvi9Xjd4wy0jajMsTPtaOrvJddfG/VEQOHCCNH+DJl1udcFHU5joN1Q5ArRuD683nzNA9klTDypTRfAgygb3l6SBrTBSkcYvmReXLHOgh/+v/2mHJ0eGh4Kc3stcpw51sarPVkuCMK44WdxUSY89bKe1eZmo5PKnUN96RlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424391; c=relaxed/simple;
	bh=FuLS2SMAwU1nE3TP3kYpkZKnyQwZyL8rhGaN4s2C47s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUL7h/UpMwpzPao0KXScvGr18grS8wh8YBAidUsapQYQVa+8cnmrx4xQbnfttKbngADRo5devqPCxlRrdAdY1hEDHUoFUE1eZrOyMiTTdJ+4bmVy/niIghHV/dZZJaullIkCyf/3kzRJlchYn/4rLIRkeyGPiEPvw45H+KWqoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7kyfqjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63CAC4CEC3;
	Fri,  1 Nov 2024 01:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424391;
	bh=FuLS2SMAwU1nE3TP3kYpkZKnyQwZyL8rhGaN4s2C47s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7kyfqjTpQxsh3wAoM+7Bd7JeYGe90F3uwjn1LVQxIYlxoVNj6+hnzMjyBjyVr3i0
	 82dS3mnFVjn8H4ua5ssZQ5VdmXI4PnB0tXkDa9gbGb+xjUmycbQ6nIWd4HoZBCnPqV
	 gA26hxEXebtSVLgZyc78q+CzPWTebhdu/FpKEmM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.170
Date: Fri,  1 Nov 2024 02:26:07 +0100
Message-ID: <2024110107-slingshot-stand-543d@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110107-epidermis-exonerate-e12b@gregkh>
References: <2024110107-epidermis-exonerate-e12b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 8c97377cd56e..e0680ae9db6b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 169
+SUBLEVEL = 170
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
index 3dfce4312dfc..a2ef43c2105a 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
@@ -77,7 +77,7 @@ &gpio {
 };
 
 &hdmi {
-	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
 };
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index c744b1e7b356..29eed96fe0e7 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=--no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X --pic-veneer
 
 ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
index 315eef654e39..014b02897f8e 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -10,21 +10,19 @@
 #include <asm/insn.h>
 #include <asm/probes.h>
 
-#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
-
-#define UPROBE_SWBP_INSN	BRK64_OPCODE_UPROBES
+#define UPROBE_SWBP_INSN	cpu_to_le32(BRK64_OPCODE_UPROBES)
 #define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
-#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+#define UPROBE_XOL_SLOT_BYTES	AARCH64_INSN_SIZE
 
-typedef u32 uprobe_opcode_t;
+typedef __le32 uprobe_opcode_t;
 
 struct arch_uprobe_task {
 };
 
 struct arch_uprobe {
 	union {
-		u8 insn[MAX_UINSN_BYTES];
-		u8 ixol[MAX_UINSN_BYTES];
+		__le32 insn;
+		__le32 ixol;
 	};
 	struct arch_probe_insn api;
 	bool simulate;
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..a2f137a595fc 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -42,7 +42,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 
 	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
@@ -108,7 +108,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	if (!auprobe->simulate)
 		return false;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index b9da71632827..ea340b901839 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -75,6 +75,7 @@ struct perf_sf_sde_regs {
 #define SAMPLE_FREQ_MODE(hwc)	(SAMPL_FLAGS(hwc) & PERF_CPUM_SF_FREQ_MODE)
 
 #define perf_arch_fetch_caller_regs(regs, __ip) do {			\
+	(regs)->psw.mask = 0;						\
 	(regs)->psw.addr = (__ip);					\
 	(regs)->gprs[15] = (unsigned long)__builtin_frame_address(0) -	\
 		offsetof(struct stack_frame, back_chain);		\
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6af59c59cc1b..98979db1cde7 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -794,46 +794,102 @@ static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
-			    unsigned long *pages, unsigned long nr_pages,
-			    const union asce asce, enum gacc_mode mode)
+/**
+ * guest_range_to_gpas() - Calculate guest physical addresses of page fragments
+ * covering a logical range
+ * @vcpu: virtual cpu
+ * @ga: guest address, start of range
+ * @ar: access register
+ * @gpas: output argument, may be NULL
+ * @len: length of range in bytes
+ * @asce: address-space-control element to use for translation
+ * @mode: access mode
+ *
+ * Translate a logical range to a series of guest absolute addresses,
+ * such that the concatenation of page fragments starting at each gpa make up
+ * the whole range.
+ * The translation is performed as if done by the cpu for the given @asce, @ar,
+ * @mode and state of the @vcpu.
+ * If the translation causes an exception, its program interruption code is
+ * returned and the &struct kvm_s390_pgm_info pgm member of @vcpu is modified
+ * such that a subsequent call to kvm_s390_inject_prog_vcpu() will inject
+ * a correct exception into the guest.
+ * The resulting gpas are stored into @gpas, unless it is NULL.
+ *
+ * Note: All fragments except the first one start at the beginning of a page.
+ *	 When deriving the boundaries of a fragment from a gpa, all but the last
+ *	 fragment end at the end of the page.
+ *
+ * Return:
+ * * 0		- success
+ * * <0		- translation could not be performed, for example if  guest
+ *		  memory could not be accessed
+ * * >0		- an access exception occurred. In this case the returned value
+ *		  is the program interruption code and the contents of pgm may
+ *		  be used to inject an exception into the guest.
+ */
+static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
+			       unsigned long *gpas, unsigned long len,
+			       const union asce asce, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	unsigned int offset = offset_in_page(ga);
+	unsigned int fragment_len;
 	int lap_enabled, rc = 0;
 	enum prot_type prot;
+	unsigned long gpa;
 
 	lap_enabled = low_address_protection_enabled(vcpu, asce);
-	while (nr_pages) {
+	while (min(PAGE_SIZE - offset, len) > 0) {
+		fragment_len = min(PAGE_SIZE - offset, len);
 		ga = kvm_s390_logical_to_effective(vcpu, ga);
 		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
 			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
 					 PROT_TYPE_LA);
-		ga &= PAGE_MASK;
 		if (psw_bits(*psw).dat) {
-			rc = guest_translate(vcpu, ga, pages, asce, mode, &prot);
+			rc = guest_translate(vcpu, ga, &gpa, asce, mode, &prot);
 			if (rc < 0)
 				return rc;
 		} else {
-			*pages = kvm_s390_real_to_abs(vcpu, ga);
-			if (kvm_is_error_gpa(vcpu->kvm, *pages))
+			gpa = kvm_s390_real_to_abs(vcpu, ga);
+			if (kvm_is_error_gpa(vcpu->kvm, gpa))
 				rc = PGM_ADDRESSING;
 		}
 		if (rc)
 			return trans_exc(vcpu, rc, ga, ar, mode, prot);
-		ga += PAGE_SIZE;
-		pages++;
-		nr_pages--;
+		if (gpas)
+			*gpas++ = gpa;
+		offset = 0;
+		ga += fragment_len;
+		len -= fragment_len;
 	}
 	return 0;
 }
 
+static int access_guest_page(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
+			     void *data, unsigned int len)
+{
+	const unsigned int offset = offset_in_page(gpa);
+	const gfn_t gfn = gpa_to_gfn(gpa);
+	int rc;
+
+	if (!gfn_to_memslot(kvm, gfn))
+		return PGM_ADDRESSING;
+	if (mode == GACC_STORE)
+		rc = kvm_write_guest_page(kvm, gfn, data, offset, len);
+	else
+		rc = kvm_read_guest_page(kvm, gfn, data, offset, len);
+	return rc;
+}
+
 int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		 unsigned long len, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	unsigned long _len, nr_pages, gpa, idx;
-	unsigned long pages_array[2];
-	unsigned long *pages;
+	unsigned long nr_pages, idx;
+	unsigned long gpa_array[2];
+	unsigned int fragment_len;
+	unsigned long *gpas;
 	int need_ipte_lock;
 	union asce asce;
 	int rc;
@@ -845,50 +901,45 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 	if (rc)
 		return rc;
 	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
-	pages = pages_array;
-	if (nr_pages > ARRAY_SIZE(pages_array))
-		pages = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
-	if (!pages)
+	gpas = gpa_array;
+	if (nr_pages > ARRAY_SIZE(gpa_array))
+		gpas = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
+	if (!gpas)
 		return -ENOMEM;
 	need_ipte_lock = psw_bits(*psw).dat && !asce.r;
 	if (need_ipte_lock)
 		ipte_lock(vcpu);
-	rc = guest_page_range(vcpu, ga, ar, pages, nr_pages, asce, mode);
+	rc = guest_range_to_gpas(vcpu, ga, ar, gpas, len, asce, mode);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
-		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
-		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-		if (mode == GACC_STORE)
-			rc = kvm_write_guest(vcpu->kvm, gpa, data, _len);
-		else
-			rc = kvm_read_guest(vcpu->kvm, gpa, data, _len);
-		len -= _len;
-		ga += _len;
-		data += _len;
+		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
+		rc = access_guest_page(vcpu->kvm, mode, gpas[idx], data, fragment_len);
+		len -= fragment_len;
+		data += fragment_len;
 	}
 	if (need_ipte_lock)
 		ipte_unlock(vcpu);
-	if (nr_pages > ARRAY_SIZE(pages_array))
-		vfree(pages);
+	if (nr_pages > ARRAY_SIZE(gpa_array))
+		vfree(gpas);
 	return rc;
 }
 
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		      void *data, unsigned long len, enum gacc_mode mode)
 {
-	unsigned long _len, gpa;
+	unsigned int fragment_len;
+	unsigned long gpa;
 	int rc = 0;
 
 	while (len && !rc) {
 		gpa = kvm_s390_real_to_abs(vcpu, gra);
-		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-		if (mode)
-			rc = write_guest_abs(vcpu, gpa, data, _len);
-		else
-			rc = read_guest_abs(vcpu, gpa, data, _len);
-		len -= _len;
-		gra += _len;
-		data += _len;
+		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), len);
+		rc = access_guest_page(vcpu->kvm, mode, gpa, data, fragment_len);
+		len -= fragment_len;
+		gra += fragment_len;
+		data += fragment_len;
 	}
+	if (rc > 0)
+		vcpu->arch.pgm.code = rc;
 	return rc;
 }
 
@@ -909,8 +960,6 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 			    unsigned long *gpa, enum gacc_mode mode)
 {
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	enum prot_type prot;
 	union asce asce;
 	int rc;
 
@@ -918,23 +967,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
 	if (rc)
 		return rc;
-	if (is_low_address(gva) && low_address_protection_enabled(vcpu, asce)) {
-		if (mode == GACC_STORE)
-			return trans_exc(vcpu, PGM_PROTECTION, gva, 0,
-					 mode, PROT_TYPE_LA);
-	}
-
-	if (psw_bits(*psw).dat && !asce.r) {	/* Use DAT? */
-		rc = guest_translate(vcpu, gva, gpa, asce, mode, &prot);
-		if (rc > 0)
-			return trans_exc(vcpu, rc, gva, 0, mode, prot);
-	} else {
-		*gpa = kvm_s390_real_to_abs(vcpu, gva);
-		if (kvm_is_error_gpa(vcpu->kvm, *gpa))
-			return trans_exc(vcpu, rc, gva, PGM_ADDRESSING, mode, 0);
-	}
-
-	return rc;
+	return guest_range_to_gpas(vcpu, gva, ar, gpa, 1, asce, mode);
 }
 
 /**
@@ -948,17 +981,14 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 		    unsigned long length, enum gacc_mode mode)
 {
-	unsigned long gpa;
-	unsigned long currlen;
+	union asce asce;
 	int rc = 0;
 
+	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
+	if (rc)
+		return rc;
 	ipte_lock(vcpu);
-	while (length > 0 && !rc) {
-		currlen = min(length, PAGE_SIZE - (gva % PAGE_SIZE));
-		rc = guest_translate_address(vcpu, gva, ar, &gpa, mode);
-		gva += currlen;
-		length -= currlen;
-	}
+	rc = guest_range_to_gpas(vcpu, gva, ar, NULL, length, asce, mode);
 	ipte_unlock(vcpu);
 
 	return rc;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 7c72a5e3449f..8ed2d6c7404f 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -344,11 +344,12 @@ int read_guest_abs(struct kvm_vcpu *vcpu, unsigned long gpa, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @data (kernel space) to @gra (guest real address).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest low address and key protection are not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying from @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to guest memory.
  */
@@ -367,11 +368,12 @@ int write_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @gra (guest real address) to @data (kernel space).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest key protection is not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying to @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to kernel space.
  */
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 000e1467b4cd..d00909428b43 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -27,10 +27,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -40,16 +40,21 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->default_ctrl);
 		return false;
 	}
 
@@ -62,7 +67,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e0b4f88b04b3..c24d7860bd53 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -77,8 +77,12 @@ static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
 	u64 pdpte;
 	int ret;
 
+	/*
+	 * Note, nCR3 is "assumed" to be 32-byte aligned, i.e. the CPU ignores
+	 * nCR3[4:0] when loading PDPTEs from memory.
+	 */
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
-				       offset_in_page(cr3) + index * 8, 8);
+				       (cr3 & GENMASK(11, 5)) + index * 8, 8);
 	if (ret)
 		return 0;
 	return pdpte;
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b0bdb5197530..c985c944fa65 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2981,10 +2981,12 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-static void
-bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
-		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
+static struct bfq_queue *bfq_merge_bfqqs(struct bfq_data *bfqd,
+					 struct bfq_io_cq *bic,
+					 struct bfq_queue *bfqq)
 {
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+
 	bfq_log_bfqq(bfqd, bfqq, "merging with queue %lu",
 		(unsigned long)new_bfqq->pid);
 	/* Save weight raising and idle window of the merged queues */
@@ -3078,6 +3080,8 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	bfq_reassign_last_bfqq(bfqq, new_bfqq);
 
 	bfq_release_process_ref(bfqd, bfqq);
+
+	return new_bfqq;
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -3113,14 +3117,8 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 		 * fulfilled, i.e., bic can be redirected to new_bfqq
 		 * and bfqq can be put.
 		 */
-		bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq,
-				new_bfqq);
-		/*
-		 * If we get here, bio will be queued into new_queue,
-		 * so use new_bfqq to decide whether bio and rq can be
-		 * merged.
-		 */
-		bfqq = new_bfqq;
+		while (bfqq != new_bfqq)
+			bfqq = bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq);
 
 		/*
 		 * Change also bqfd->bio_bfqq, as
@@ -5482,9 +5480,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * state before killing it.
 	 */
 	bfqq->bic = bic;
-	bfq_merge_bfqqs(bfqd, bic, bfqq, new_bfqq);
-
-	return new_bfqq;
+	return bfq_merge_bfqqs(bfqd, bic, bfqq);
 }
 
 /*
@@ -5916,6 +5912,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bool waiting, idle_timer_disabled = false;
 
 	if (new_bfqq) {
+		struct bfq_queue *old_bfqq = bfqq;
 		/*
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
@@ -5931,18 +5928,18 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * then complete the merge and redirect it to
 		 * new_bfqq.
 		 */
-		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq)
-			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
-					bfqq, new_bfqq);
+		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq) {
+			while (bfqq != new_bfqq)
+				bfqq = bfq_merge_bfqqs(bfqd, RQ_BIC(rq), bfqq);
+		}
 
-		bfq_clear_bfqq_just_created(bfqq);
+		bfq_clear_bfqq_just_created(old_bfqq);
 		/*
 		 * rq is about to be enqueued into new_bfqq,
 		 * release rq reference on bfqq
 		 */
-		bfq_put_queue(bfqq);
+		bfq_put_queue(old_bfqq);
 		rq->elv.priv[1] = new_bfqq;
-		bfqq = new_bfqq;
 	}
 
 	bfq_update_io_thinktime(bfqd, bfqq);
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d8b148114138..067affd5d739 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -130,6 +130,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Samsung galaxybook2 ,initial _LID device notification returns
+		 * lid closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 397aa007d093..3c9f93981523 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -505,6 +505,13 @@ static const struct dmi_system_id tongfang_gm_rg[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
+	{
+		/* LG Electronics 16T90SP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 6cded09d5878..2f250dc86194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -108,6 +108,7 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
+	union acpi_object *obj;
 	union acpi_object atif_arg_elements[2];
 	struct acpi_object_list atif_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -130,16 +131,24 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 
 	status = acpi_evaluate_object(atif->handle, NULL, &atif_arg,
 				      &buffer);
+	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail only if calling the method fails and ATIF is supported */
+	/* Fail if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
-		kfree(buffer.pointer);
+		kfree(obj);
 		return NULL;
 	}
 
-	return buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		DRM_DEBUG_DRIVER("bad object returned from ATIF: %d\n",
+				 obj->type);
+		kfree(obj);
+		return NULL;
+	}
+
+	return obj;
 }
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 8746ceae8fca..badafcd61998 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -24,7 +24,7 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	end_addr = base_addr + aligned_len;
 
 	if (!(*reg))
-		*reg = kzalloc(len_padded, GFP_KERNEL);
+		*reg = kvzalloc(len_padded, GFP_KERNEL);
 
 	if (*reg)
 		dump_addr = *reg;
@@ -46,20 +46,21 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	}
 }
 
-static void msm_disp_state_print_regs(u32 **reg, u32 len, void __iomem *base_addr,
-		struct drm_printer *p)
+static void msm_disp_state_print_regs(const u32 *dump_addr, u32 len,
+		void __iomem *base_addr, struct drm_printer *p)
 {
 	int i;
-	u32 *dump_addr = NULL;
 	void __iomem *addr;
 	u32 num_rows;
 
+	if (!dump_addr) {
+		drm_printf(p, "Registers not stored\n");
+		return;
+	}
+
 	addr = base_addr;
 	num_rows = len / REG_DUMP_ALIGN;
 
-	if (*reg)
-		dump_addr = *reg;
-
 	for (i = 0; i < num_rows; i++) {
 		drm_printf(p, "0x%lx : %08x %08x %08x %08x\n",
 				(unsigned long)(addr - base_addr),
@@ -86,7 +87,7 @@ void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
 
 	list_for_each_entry_safe(block, tmp, &state->blocks, node) {
 		drm_printf(p, "====================%s================\n", block->name);
-		msm_disp_state_print_regs(&block->state, block->size, block->base_addr, p);
+		msm_disp_state_print_regs(block->state, block->size, block->base_addr, p);
 	}
 
 	drm_printf(p, "===================dpu drm state================\n");
@@ -154,7 +155,7 @@ void msm_disp_state_free(void *data)
 
 	list_for_each_entry_safe(block, tmp, &disp_state->blocks, node) {
 		list_del(&block->node);
-		kfree(block->state);
+		kvfree(block->state);
 		kfree(block);
 	}
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index c563ecf6e7b9..eb7cd96d9ece 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -678,7 +678,7 @@ static unsigned long dsi_get_pclk_rate(struct msm_dsi_host *msm_host, bool is_bo
 	struct drm_display_mode *mode = msm_host->mode;
 	unsigned long pclk_rate;
 
-	pclk_rate = mode->clock * 1000;
+	pclk_rate = mode->clock * 1000u;
 
 	/*
 	 * For bonded DSI mode, the current DRM mode has the complete width of the
diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
index 8c041d7ce4f1..87dccaecc3e5 100644
--- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
+++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
@@ -139,7 +139,15 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
 		flags |= VBOX_MOUSE_POINTER_VISIBLE;
 	}
 
-	p = hgsmi_buffer_alloc(ctx, sizeof(*p) + pixel_len, HGSMI_CH_VBVA,
+	/*
+	 * The 4 extra bytes come from switching struct vbva_mouse_pointer_shape
+	 * from having a 4 bytes fixed array at the end to using a proper VLA
+	 * at the end. These 4 extra bytes were not subtracted from sizeof(*p)
+	 * before the switch to the VLA, so this way the behavior is unchanged.
+	 * Chances are these 4 extra bytes are not necessary but they are kept
+	 * to avoid regressions.
+	 */
+	p = hgsmi_buffer_alloc(ctx, sizeof(*p) + pixel_len + 4, HGSMI_CH_VBVA,
 			       VBVA_MOUSE_POINTER_SHAPE);
 	if (!p)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
index a5de40fe1a76..bed285fe083c 100644
--- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
+++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
@@ -351,10 +351,8 @@ struct vbva_mouse_pointer_shape {
 	 * Bytes in the gap between the AND and the XOR mask are undefined.
 	 * XOR mask scanlines have no gap between them and size of XOR mask is:
 	 * xor_len = width * 4 * height.
-	 *
-	 * Preallocate 4 bytes for accessing actual data as p->data.
 	 */
-	u8 data[4];
+	u8 data[];
 } __packed;
 
 /* pointer is visible */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 4f1a845f9be6..57a3dae87f65 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -169,7 +169,7 @@ struct bnxt_qplib_swqe {
 			};
 			u32		q_key;
 			u32		dst_qp;
-			u16		avid;
+			u32		avid;
 		} send;
 
 		/* Send Raw Ethernet and QP1 */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3b8cb46551bf..8d5557e3056c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -249,7 +249,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
 			cookie, opcode, evnt->status);
-		rc = -EFAULT;
+		rc = -EIO;
 	}
 
 	return rc;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 384d41072c63..401cb3e22f31 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -243,6 +243,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			sginfo.pgsize = npde * pg_size;
 			sginfo.npages = 1;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
 
 			/* Alloc PBL pages */
 			sginfo.npages = npbl;
@@ -254,22 +256,9 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			dst_virt_ptr =
 				(dma_addr_t **)hwq->pbl[PBL_LVL_0].pg_arr;
 			src_phys_ptr = hwq->pbl[PBL_LVL_1].pg_map_arr;
-			if (hwq_attr->type == HWQ_TYPE_MR) {
-			/* For MR it is expected that we supply only 1 contigous
-			 * page i.e only 1 entry in the PDL that will contain
-			 * all the PBLs for the user supplied memory region
-			 */
-				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
-				     i++)
-					dst_virt_ptr[0][i] = src_phys_ptr[i] |
-						flag;
-			} else {
-				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
-				     i++)
-					dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
-						src_phys_ptr[i] |
-						PTU_PDE_VALID;
-			}
+			for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[0][i] = src_phys_ptr[i] | flag;
+
 			/* Alloc or init PTEs */
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_2],
 					 hwq_attr->sginfo);
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index e6343c89c892..3efd06d5f7e7 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2086,7 +2086,7 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 	err = -ENOMEM;
 	if (n->dev->flags & IFF_LOOPBACK) {
 		if (iptype == 4)
-			pdev = ip_dev_find(&init_net, *(__be32 *)peer_ip);
+			pdev = __ip_dev_find(&init_net, *(__be32 *)peer_ip, false);
 		else if (IS_ENABLED(CONFIG_IPV6))
 			for_each_netdev(&init_net, pdev) {
 				if (ipv6_chk_addr(&init_net,
@@ -2101,12 +2101,12 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 			err = -ENODEV;
 			goto out;
 		}
+		if (is_vlan_dev(pdev))
+			pdev = vlan_dev_real_dev(pdev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
 					n, pdev, rt_tos2priority(tos));
-		if (!ep->l2t) {
-			dev_put(pdev);
+		if (!ep->l2t)
 			goto out;
-		}
 		ep->mtu = pdev->mtu;
 		ep->tx_chan = cxgb4_port_chan(pdev);
 		ep->smac_idx = ((struct port_info *)netdev_priv(pdev))->smt_idx;
@@ -2119,7 +2119,6 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 		ep->rss_qid = cdev->rdev.lldi.rxq_ids[
 			cxgb4_port_idx(pdev) * step];
 		set_tcp_window(ep, (struct port_info *)netdev_priv(pdev));
-		dev_put(pdev);
 	} else {
 		pdev = get_real_dev(n->dev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 64d4bb0e9a12..d2c6a1bcf1de 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3582,7 +3582,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
 /**
  * irdma_accept - registered call for connection to be accepted
  * @cm_id: cm information for passive connection
- * @conn_param: accpet parameters
+ * @conn_param: accept parameters
  */
 int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 {
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index ab41619a809b..c94f2de6401c 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1699,6 +1699,7 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 	ptr = shift / 8;
 	shift %= 8;
 	mask >>= ptr * 8;
+	ptr <<= 8;
 
 	err = mv88e6393x_port_policy_read(chip, port, ptr, &reg);
 	if (err)
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index a95bac4e14f6..538043cd9e24 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -484,7 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 
 	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
 		dev->stats.tx_errors++;
-		goto out;
+		goto len_error;
 	}
 
 	/* Save skb pointer. */
@@ -575,6 +575,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 map_error:
 	if (net_ratelimit())
 		dev_warn(greth->dev, "Could not create TX DMA mapping\n");
+len_error:
 	dev_kfree_skb(skb);
 out:
 	return err;
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 93c965bcdb6c..8962bd6349d4 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1348,6 +1348,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buff *skb,
 		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=%d)\n",
 			  skb->data, skb_len);
 		ret = NETDEV_TX_OK;
+		dev_kfree_skb_any(skb);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index b91029db1f21..13d5fe324d6c 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1382,10 +1382,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	be_get_wrb_params_from_skb(adapter, skb, &wrb_params);
 
 	wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-	if (unlikely(!wrb_cnt)) {
-		dev_kfree_skb_any(skb);
-		goto drop;
-	}
+	if (unlikely(!wrb_cnt))
+		goto drop_skb;
 
 	/* if os2bmc is enabled and if the pkt is destined to bmc,
 	 * enqueue the pkt a 2nd time with mgmt bit set.
@@ -1394,7 +1392,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
 		if (unlikely(!wrb_cnt))
-			goto drop;
+			goto drop_skb;
 		else
 			skb_get(skb);
 	}
@@ -1408,6 +1406,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		be_xmit_flush(adapter, txo);
 
 	return NETDEV_TX_OK;
+drop_skb:
+	dev_kfree_skb_any(skb);
 drop:
 	tx_stats(txo)->tx_drv_drops++;
 	/* Flush the already enqueued tx requests */
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 6c89aa7eaa22..95a6bbfa013e 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -1012,6 +1012,7 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 	if(skb->len > XMIT_BUFF_SIZE)
 	{
 		printk("%s: Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",dev->name,XMIT_BUFF_SIZE,skb->len);
+		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index f2e1c63035e8..8bdde74b34b6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2239,7 +2239,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
 		if (!(cfg & BIT_ULL(12)))
 			continue;
-		bmap |= (1 << i);
+		bmap |= BIT_ULL(i);
 		cfg &= ~BIT_ULL(12);
 		rvu_write64(rvu, blkaddr,
 			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
@@ -2260,7 +2260,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 
 	/* Set NIX_AF_TL3_TL2_LINKX_CFG[ENA] for the TL3/TL2 queue */
 	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
-		if (!(bmap & (1 << i)))
+		if (!(bmap & BIT_ULL(i)))
 			continue;
 		cfg = rvu_read64(rvu, blkaddr,
 				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7ce11c9529c5..8e910f3349b2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4627,7 +4627,9 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
 
-	if (unlikely(status & SYSErr)) {
+	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
+	if (unlikely(status & SYSErr &&
+	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
 		rtl8169_pcierr_interrupt(tp->dev);
 		goto out;
 	}
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f9921e372a2f..56a970357f45 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -868,6 +868,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (net_ratelimit())
 			netdev_err(ndev, "TX DMA mapping error\n");
 		ndev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	desc_set_phys_addr(lp, phys, cur_p);
@@ -888,6 +889,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			ndev->stats.tx_dropped++;
 			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
 					      true, NULL, 0);
+			dev_kfree_skb_any(skb);
 			return NETDEV_TX_OK;
 		}
 		desc_set_phys_addr(lp, phys, cur_p);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 804c11cbccff..ff5b14210aef 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2813,6 +2813,31 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
+/* Set VF's namespace same as the synthetic NIC */
+static void netvsc_event_set_vf_ns(struct net_device *ndev)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct net_device *vf_netdev;
+	int ret;
+
+	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	if (!vf_netdev)
+		return;
+
+	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
+		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
+					       "eth%d");
+		if (ret)
+			netdev_err(vf_netdev,
+				   "Cannot move to same namespace as %s: %d\n",
+				   ndev->name, ret);
+		else
+			netdev_info(vf_netdev,
+				    "Moved VF to namespace with: %s\n",
+				    ndev->name);
+	}
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2825,6 +2850,11 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
 	int ret = 0;
 
+	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
+		netvsc_event_set_vf_ns(event_dev);
+		return NOTIFY_DONE;
+	}
+
 	ret = check_dev_is_matching_vf(event_dev);
 	if (ret != 0)
 		return NOTIFY_DONE;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ab134fe1fda6..a91c409958ff 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -160,19 +160,6 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
-static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
-{
-	struct macsec_rx_sa *sa = NULL;
-	int an;
-
-	for (an = 0; an < MACSEC_NUM_AN; an++)	{
-		sa = macsec_rxsa_get(rx_sc->sa[an]);
-		if (sa)
-			break;
-	}
-	return sa;
-}
-
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -1192,15 +1179,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
-		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
 			DEV_STATS_INC(secy->netdev, rx_errors);
-			if (active_rx_sa)
-				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1210,8 +1194,6 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
-		if (active_rx_sa)
-			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 57411ee1d837..317357c43c9a 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -40,8 +40,8 @@
 /* Control Register 2 bits */
 #define DP83822_FX_ENABLE	BIT(14)
 
-#define DP83822_HW_RESET	BIT(15)
-#define DP83822_SW_RESET	BIT(14)
+#define DP83822_SW_RESET	BIT(15)
+#define DP83822_DIG_RESTART	BIT(14)
 
 /* PHY STS bits */
 #define DP83822_PHYSTS_DUPLEX			BIT(2)
diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index b1776116f9f7..bea741afe78b 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -811,7 +811,7 @@ plip_send_packet(struct net_device *dev, struct net_local *nl,
 				return HS_TIMEOUT;
 			}
 		}
-		break;
+		fallthrough;
 
 	case PLIP_PK_LENGTH_LSB:
 		if (plip_send(nibble_timeout, dev,
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 47a587dae746..f66975c452aa 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1769,7 +1769,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		// can rename the link if it knows better.
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
 		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     (net->dev_addr [0] & 0x02) == 0))
+		     /* somebody touched it*/
+		     !is_zero_ether_addr(net->dev_addr)))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
@@ -1872,6 +1873,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	 * may trigger an error resubmitting itself and, worse,
 	 * schedule a timer. So we kill it all just in case.
 	 */
+	usbnet_mark_going_away(dev);
 	cancel_work_sync(&dev->kevent);
 	del_timer_sync(&dev->delay);
 	free_percpu(net->tstats);
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index d293ab688044..a83de4e3c189 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -927,7 +927,7 @@ static const struct nla_policy wwan_rtnl_policy[IFLA_WWAN_MAX + 1] = {
 
 static struct rtnl_link_ops wwan_rtnl_link_ops __read_mostly = {
 	.kind = "wwan",
-	.maxtype = __IFLA_WWAN_MAX,
+	.maxtype = IFLA_WWAN_MAX,
 	.alloc = wwan_rtnl_alloc,
 	.validate = wwan_rtnl_validate,
 	.newlink = wwan_rtnl_newlink,
diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index b83d6fa6e39b..b12e6ebd10dd 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -263,6 +263,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	/*Speaker Mute*/
 	{ KE_KEY, 0x109, { KEY_MUTE} },
 
+	/* S2Idle screen off */
+	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
+
+	/* Leaving S4 or S2Idle suspend */
+	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
+
+	/* Entering S2Idle suspend */
+	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 907fde53e95c..47f8c5a63343 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -524,6 +524,7 @@ static int __init sysman_init(void)
 	int ret = 0;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index d4185c1bed8a..1fcac654cfaa 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -724,7 +724,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 
 	dev->queues = kcalloc(nr_cpu_ids, sizeof(*dev->queues), GFP_KERNEL);
 	if (!dev->queues) {
-		dev->transport->free_device(dev);
+		hba->backend->ops->free_device(dev);
 		return NULL;
 	}
 
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 1e8e9dd3f482..7a467b1f9099 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -2129,7 +2129,7 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	}
 
 	ret = genlmsg_multicast_allns(&tcmu_genl_family, skb, 0,
-				      TCMU_MCGRP_CONFIG, GFP_KERNEL);
+				      TCMU_MCGRP_CONFIG);
 
 	/* Wait during an add as the listener may not be up yet */
 	if (ret == 0 ||
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7cd12ea88c0b..404354727d19 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -286,14 +286,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty) {
-			uport->cons->cflag = tty->termios.c_cflag;
-			uport->cons->ispeed = tty->termios.c_ispeed;
-			uport->cons->ospeed = tty->termios.c_ospeed;
-		}
+		if (uport) {
+			if (uart_console(uport) && tty) {
+				uport->cons->cflag = tty->termios.c_cflag;
+				uport->cons->ispeed = tty->termios.c_ispeed;
+				uport->cons->ospeed = tty->termios.c_ospeed;
+			}
 
-		if (!tty || C_HUPCL(tty))
-			uart_port_dtr_rts(uport, 0);
+			if (!tty || C_HUPCL(tty))
+				uart_port_dtr_rts(uport, 0);
+		}
 
 		uart_port_shutdown(port);
 	}
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6c740dc633e7..0ca06a3ab717 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1796,6 +1796,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
 
+	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+			    DWC3_GUSB2PHYCFG_SUSPHY) ||
+			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+			    DWC3_GUSB3PIPECTL_SUSPHY);
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
@@ -1843,6 +1848,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	return 0;
 }
 
@@ -1905,6 +1919,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/* restore SUSPHY state to that before system suspend. */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 7e7820ce21bf..3d434c110bdb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1085,6 +1085,8 @@ struct dwc3_scratchpad_array {
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
  * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ *		  before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1300,6 +1302,7 @@ struct dwc3 {
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
 	unsigned		suspended:1;
+	unsigned		susphy_state:1;
 
 	u16			imod_interval;
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 3f035e905b24..1052ca4e29bc 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -477,6 +477,46 @@ int usb_interface_id(struct usb_configuration *config,
 }
 EXPORT_SYMBOL_GPL(usb_interface_id);
 
+/**
+ * usb_func_wakeup - sends function wake notification to the host.
+ * @func: function that sends the remote wakeup notification.
+ *
+ * Applicable to devices operating at enhanced superspeed when usb
+ * functions are put in function suspend state and armed for function
+ * remote wakeup. On completion, function wake notification is sent. If
+ * the device is in low power state it tries to bring the device to active
+ * state before sending the wake notification. Since it is a synchronous
+ * call, caller must take care of not calling it in interrupt context.
+ * For devices operating at lower speeds  returns negative errno.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_func_wakeup(struct usb_function *func)
+{
+	struct usb_gadget	*gadget = func->config->cdev->gadget;
+	int			id;
+
+	if (!gadget->ops->func_wakeup)
+		return -EOPNOTSUPP;
+
+	if (!func->func_wakeup_armed) {
+		ERROR(func->config->cdev, "not armed for func remote wakeup\n");
+		return -EINVAL;
+	}
+
+	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
+		if (func->config->interface[id] == func)
+			break;
+
+	if (id == MAX_CONFIG_INTERFACES) {
+		ERROR(func->config->cdev, "Invalid function\n");
+		return -EINVAL;
+	}
+
+	return gadget->ops->func_wakeup(gadget, id);
+}
+EXPORT_SYMBOL_GPL(usb_func_wakeup);
+
 static u8 encode_bMaxPower(enum usb_device_speed speed,
 		struct usb_configuration *c)
 {
diff --git a/drivers/usb/host/xhci-caps.h b/drivers/usb/host/xhci-caps.h
new file mode 100644
index 000000000000..9e94cebf4a56
--- /dev/null
+++ b/drivers/usb/host/xhci-caps.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* hc_capbase bitmasks */
+/* bits 7:0 - how long is the Capabilities register */
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+/* bits 31:16	*/
+#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
+
+/* HCSPARAMS1 - hcs_params1 - bitmasks */
+/* bits 0:7, Max Device Slots */
+#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
+#define HCS_SLOTS_MASK		0xff
+/* bits 8:18, Max Interrupters */
+#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
+/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+
+/* HCSPARAMS2 - hcs_params2 - bitmasks */
+/* bits 0:3, frames or uframes that SW needs to queue transactions
+ * ahead of the HW to meet periodic deadlines */
+#define HCS_IST(p)		(((p) >> 0) & 0xf)
+/* bits 4:7, max number of Event Ring segments */
+#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
+/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
+/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
+/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
+#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
+
+/* HCSPARAMS3 - hcs_params3 - bitmasks */
+/* bits 0:7, Max U1 to U0 latency for the roothub ports */
+#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
+/* bits 16:31, Max U2 to U0 latency for the roothub ports */
+#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
+
+/* HCCPARAMS - hcc_params - bitmasks */
+/* true: HC can use 64-bit address pointers */
+#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
+/* true: HC can do bandwidth negotiation */
+#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
+/* true: HC uses 64-byte Device Context structures
+ * FIXME 64-byte context structures aren't supported yet.
+ */
+#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
+/* true: HC has port power switches */
+#define HCC_PPC(p)		((p) & (1 << 3))
+/* true: HC has port indicators */
+#define HCS_INDICATOR(p)	((p) & (1 << 4))
+/* true: HC has Light HC Reset Capability */
+#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
+/* true: HC supports latency tolerance messaging */
+#define HCC_LTC(p)		((p) & (1 << 6))
+/* true: no secondary Stream ID Support */
+#define HCC_NSS(p)		((p) & (1 << 7))
+/* true: HC supports Stopped - Short Packet */
+#define HCC_SPC(p)		((p) & (1 << 9))
+/* true: HC has Contiguous Frame ID Capability */
+#define HCC_CFC(p)		((p) & (1 << 11))
+/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
+#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
+/* Extended Capabilities pointer from PCI base - section 5.3.6 */
+#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
+
+#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
+
+/* db_off bitmask - bits 0:1 reserved */
+#define	DBOFF_MASK	(~0x3)
+
+/* run_regs_off bitmask - bits 0:4 reserved */
+#define	RTSOFF_MASK	(~0x1f)
+
+/* HCCPARAMS2 - hcc_params2 - bitmasks */
+/* true: HC supports U3 entry Capability */
+#define	HCC2_U3C(p)		((p) & (1 << 0))
+/* true: HC supports Configure endpoint command Max exit latency too large */
+#define	HCC2_CMC(p)		((p) & (1 << 1))
+/* true: HC supports Force Save context Capability */
+#define	HCC2_FSC(p)		((p) & (1 << 2))
+/* true: HC supports Compliance Transition Capability */
+#define	HCC2_CTC(p)		((p) & (1 << 3))
+/* true: HC support Large ESIT payload Capability > 48k */
+#define	HCC2_LEC(p)		((p) & (1 << 4))
+/* true: HC support Configuration Information Capability */
+#define	HCC2_CIC(p)		((p) & (1 << 5))
+/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
+#define	HCC2_ETC(p)		((p) & (1 << 6))
diff --git a/drivers/usb/host/xhci-port.h b/drivers/usb/host/xhci-port.h
new file mode 100644
index 000000000000..f19efb966d18
--- /dev/null
+++ b/drivers/usb/host/xhci-port.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
+/* true: device connected */
+#define PORT_CONNECT	(1 << 0)
+/* true: port enabled */
+#define PORT_PE		(1 << 1)
+/* bit 2 reserved and zeroed */
+/* true: port has an over-current condition */
+#define PORT_OC		(1 << 3)
+/* true: port reset signaling asserted */
+#define PORT_RESET	(1 << 4)
+/* Port Link State - bits 5:8
+ * A read gives the current link PM state of the port,
+ * a write with Link State Write Strobe set sets the link state.
+ */
+#define PORT_PLS_MASK	(0xf << 5)
+#define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
+#define XDEV_U2		(0x2 << 5)
+#define XDEV_U3		(0x3 << 5)
+#define XDEV_DISABLED	(0x4 << 5)
+#define XDEV_RXDETECT	(0x5 << 5)
+#define XDEV_INACTIVE	(0x6 << 5)
+#define XDEV_POLLING	(0x7 << 5)
+#define XDEV_RECOVERY	(0x8 << 5)
+#define XDEV_HOT_RESET	(0x9 << 5)
+#define XDEV_COMP_MODE	(0xa << 5)
+#define XDEV_TEST_MODE	(0xb << 5)
+#define XDEV_RESUME	(0xf << 5)
+
+/* true: port has power (see HCC_PPC) */
+#define PORT_POWER	(1 << 9)
+/* bits 10:13 indicate device speed:
+ * 0 - undefined speed - port hasn't be initialized by a reset yet
+ * 1 - full speed
+ * 2 - low speed
+ * 3 - high speed
+ * 4 - super speed
+ * 5-15 reserved
+ */
+#define DEV_SPEED_MASK		(0xf << 10)
+#define	XDEV_FS			(0x1 << 10)
+#define	XDEV_LS			(0x2 << 10)
+#define	XDEV_HS			(0x3 << 10)
+#define	XDEV_SS			(0x4 << 10)
+#define	XDEV_SSP		(0x5 << 10)
+#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
+#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
+#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
+#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
+#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
+#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
+#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
+
+/* Bits 20:23 in the Slot Context are the speed for the device */
+#define	SLOT_SPEED_FS		(XDEV_FS << 10)
+#define	SLOT_SPEED_LS		(XDEV_LS << 10)
+#define	SLOT_SPEED_HS		(XDEV_HS << 10)
+#define	SLOT_SPEED_SS		(XDEV_SS << 10)
+#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
+/* Port Indicator Control */
+#define PORT_LED_OFF	(0 << 14)
+#define PORT_LED_AMBER	(1 << 14)
+#define PORT_LED_GREEN	(2 << 14)
+#define PORT_LED_MASK	(3 << 14)
+/* Port Link State Write Strobe - set this when changing link state */
+#define PORT_LINK_STROBE	(1 << 16)
+/* true: connect status change */
+#define PORT_CSC	(1 << 17)
+/* true: port enable change */
+#define PORT_PEC	(1 << 18)
+/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
+ * into an enabled state, and the device into the default state.  A "warm" reset
+ * also resets the link, forcing the device through the link training sequence.
+ * SW can also look at the Port Reset register to see when warm reset is done.
+ */
+#define PORT_WRC	(1 << 19)
+/* true: over-current change */
+#define PORT_OCC	(1 << 20)
+/* true: reset change - 1 to 0 transition of PORT_RESET */
+#define PORT_RC		(1 << 21)
+/* port link status change - set on some port link state transitions:
+ *  Transition				Reason
+ *  ------------------------------------------------------------------------------
+ *  - U3 to Resume			Wakeup signaling from a device
+ *  - Resume to Recovery to U0		USB 3.0 device resume
+ *  - Resume to U0			USB 2.0 device resume
+ *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
+ *  - U3 to U0				Software resume of USB 2.0 device complete
+ *  - U2 to U0				L1 resume of USB 2.1 device complete
+ *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
+ *  - U0 to disabled			L1 entry error with USB 2.1 device
+ *  - Any state to inactive		Error on USB 3.0 port
+ */
+#define PORT_PLC	(1 << 22)
+/* port configure error change - port failed to configure its link partner */
+#define PORT_CEC	(1 << 23)
+#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
+				 PORT_RC | PORT_PLC | PORT_CEC)
+
+
+/* Cold Attach Status - xHC can set this bit to report device attached during
+ * Sx state. Warm port reset should be perfomed to clear this bit and move port
+ * to connected state.
+ */
+#define PORT_CAS	(1 << 24)
+/* wake on connect (enable) */
+#define PORT_WKCONN_E	(1 << 25)
+/* wake on disconnect (enable) */
+#define PORT_WKDISC_E	(1 << 26)
+/* wake on over-current (enable) */
+#define PORT_WKOC_E	(1 << 27)
+/* bits 28:29 reserved */
+/* true: device is non-removable - for USB 3.0 roothub emulation */
+#define PORT_DEV_REMOVE	(1 << 30)
+/* Initiate a warm port reset - complete when PORT_WRC is '1' */
+#define PORT_WR		(1 << 31)
+
+/* We mark duplicate entries with -1 */
+#define DUPLICATE_ENTRY ((u8)(-1))
+
+/* Port Power Management Status and Control - port_power_base bitmasks */
+/* Inactivity timer value for transitions into U1, in microseconds.
+ * Timeout can be up to 127us.  0xFF means an infinite timeout.
+ */
+#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
+#define PORT_U1_TIMEOUT_MASK	0xff
+/* Inactivity timer value for transitions into U2 */
+#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
+#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
+/* Bits 24:31 for port testing */
+
+/* USB2 Protocol PORTSPMSC */
+#define	PORT_L1S_MASK		7
+#define	PORT_L1S_SUCCESS	1
+#define	PORT_RWE		(1 << 3)
+#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
+#define	PORT_HIRD_MASK		(0xf << 4)
+#define	PORT_L1DS_MASK		(0xff << 8)
+#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
+#define	PORT_HLE		(1 << 16)
+#define PORT_TEST_MODE_SHIFT	28
+
+/* USB3 Protocol PORTLI  Port Link Information */
+#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
+#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
+
+/* USB2 Protocol PORTHLPMC */
+#define PORT_HIRDM(p)((p) & 3)
+#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
+#define PORT_BESLD(p)(((p) & 0xf) << 10)
+
+/* use 512 microseconds as USB2 LPM L1 default timeout. */
+#define XHCI_L1_TIMEOUT		512
+
+/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
+ * Safe to use with mixed HIRD and BESL systems (host and device) and is used
+ * by other operating systems.
+ *
+ * XHCI 1.0 errata 8/14/12 Table 13 notes:
+ * "Software should choose xHC BESL/BESLD field values that do not violate a
+ * device's resume latency requirements,
+ * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
+ * or not program values < '4' if BLC = '0' and a BESL device is attached.
+ */
+#define XHCI_DEFAULT_BESL	4
+
+/*
+ * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
+ * to complete link training. usually link trainig completes much faster
+ * so check status 10 times with 36ms sleep in places we need to wait for
+ * polling to complete.
+ */
+#define XHCI_PORT_POLLING_LFPS_TIME  36
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index f2133f2a1767..298938eca163 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -23,6 +23,9 @@
 #include	"xhci-ext-caps.h"
 #include "pci-quirks.h"
 
+#include "xhci-port.h"
+#include "xhci-caps.h"
+
 /* max buffer size for trace and debug messages */
 #define XHCI_MSG_MAX		500
 
@@ -63,90 +66,6 @@ struct xhci_cap_regs {
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
-/* hc_capbase bitmasks */
-/* bits 7:0 - how long is the Capabilities register */
-#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
-/* bits 31:16	*/
-#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
-
-/* HCSPARAMS1 - hcs_params1 - bitmasks */
-/* bits 0:7, Max Device Slots */
-#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
-#define HCS_SLOTS_MASK		0xff
-/* bits 8:18, Max Interrupters */
-#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
-/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
-#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
-
-/* HCSPARAMS2 - hcs_params2 - bitmasks */
-/* bits 0:3, frames or uframes that SW needs to queue transactions
- * ahead of the HW to meet periodic deadlines */
-#define HCS_IST(p)		(((p) >> 0) & 0xf)
-/* bits 4:7, max number of Event Ring segments */
-#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
-/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
-/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
-/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
-#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
-
-/* HCSPARAMS3 - hcs_params3 - bitmasks */
-/* bits 0:7, Max U1 to U0 latency for the roothub ports */
-#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
-/* bits 16:31, Max U2 to U0 latency for the roothub ports */
-#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
-
-/* HCCPARAMS - hcc_params - bitmasks */
-/* true: HC can use 64-bit address pointers */
-#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
-/* true: HC can do bandwidth negotiation */
-#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
-/* true: HC uses 64-byte Device Context structures
- * FIXME 64-byte context structures aren't supported yet.
- */
-#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
-/* true: HC has port power switches */
-#define HCC_PPC(p)		((p) & (1 << 3))
-/* true: HC has port indicators */
-#define HCS_INDICATOR(p)	((p) & (1 << 4))
-/* true: HC has Light HC Reset Capability */
-#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
-/* true: HC supports latency tolerance messaging */
-#define HCC_LTC(p)		((p) & (1 << 6))
-/* true: no secondary Stream ID Support */
-#define HCC_NSS(p)		((p) & (1 << 7))
-/* true: HC supports Stopped - Short Packet */
-#define HCC_SPC(p)		((p) & (1 << 9))
-/* true: HC has Contiguous Frame ID Capability */
-#define HCC_CFC(p)		((p) & (1 << 11))
-/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
-#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
-/* Extended Capabilities pointer from PCI base - section 5.3.6 */
-#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
-
-#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
-
-/* db_off bitmask - bits 0:1 reserved */
-#define	DBOFF_MASK	(~0x3)
-
-/* run_regs_off bitmask - bits 0:4 reserved */
-#define	RTSOFF_MASK	(~0x1f)
-
-/* HCCPARAMS2 - hcc_params2 - bitmasks */
-/* true: HC supports U3 entry Capability */
-#define	HCC2_U3C(p)		((p) & (1 << 0))
-/* true: HC supports Configure endpoint command Max exit latency too large */
-#define	HCC2_CMC(p)		((p) & (1 << 1))
-/* true: HC supports Force Save context Capability */
-#define	HCC2_FSC(p)		((p) & (1 << 2))
-/* true: HC supports Compliance Transition Capability */
-#define	HCC2_CTC(p)		((p) & (1 << 3))
-/* true: HC support Large ESIT payload Capability > 48k */
-#define	HCC2_LEC(p)		((p) & (1 << 4))
-/* true: HC support Configuration Information Capability */
-#define	HCC2_CIC(p)		((p) & (1 << 5))
-/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
-#define	HCC2_ETC(p)		((p) & (1 << 6))
-
 /* Number of registers per port */
 #define	NUM_PORT_REGS	4
 
@@ -292,181 +211,6 @@ struct xhci_op_regs {
 #define CONFIG_CIE		(1 << 9)
 /* bits 10:31 - reserved and should be preserved */
 
-/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
-/* true: device connected */
-#define PORT_CONNECT	(1 << 0)
-/* true: port enabled */
-#define PORT_PE		(1 << 1)
-/* bit 2 reserved and zeroed */
-/* true: port has an over-current condition */
-#define PORT_OC		(1 << 3)
-/* true: port reset signaling asserted */
-#define PORT_RESET	(1 << 4)
-/* Port Link State - bits 5:8
- * A read gives the current link PM state of the port,
- * a write with Link State Write Strobe set sets the link state.
- */
-#define PORT_PLS_MASK	(0xf << 5)
-#define XDEV_U0		(0x0 << 5)
-#define XDEV_U1		(0x1 << 5)
-#define XDEV_U2		(0x2 << 5)
-#define XDEV_U3		(0x3 << 5)
-#define XDEV_DISABLED	(0x4 << 5)
-#define XDEV_RXDETECT	(0x5 << 5)
-#define XDEV_INACTIVE	(0x6 << 5)
-#define XDEV_POLLING	(0x7 << 5)
-#define XDEV_RECOVERY	(0x8 << 5)
-#define XDEV_HOT_RESET	(0x9 << 5)
-#define XDEV_COMP_MODE	(0xa << 5)
-#define XDEV_TEST_MODE	(0xb << 5)
-#define XDEV_RESUME	(0xf << 5)
-
-/* true: port has power (see HCC_PPC) */
-#define PORT_POWER	(1 << 9)
-/* bits 10:13 indicate device speed:
- * 0 - undefined speed - port hasn't be initialized by a reset yet
- * 1 - full speed
- * 2 - low speed
- * 3 - high speed
- * 4 - super speed
- * 5-15 reserved
- */
-#define DEV_SPEED_MASK		(0xf << 10)
-#define	XDEV_FS			(0x1 << 10)
-#define	XDEV_LS			(0x2 << 10)
-#define	XDEV_HS			(0x3 << 10)
-#define	XDEV_SS			(0x4 << 10)
-#define	XDEV_SSP		(0x5 << 10)
-#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
-#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
-#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
-#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
-#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
-#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
-#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
-#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
-
-/* Bits 20:23 in the Slot Context are the speed for the device */
-#define	SLOT_SPEED_FS		(XDEV_FS << 10)
-#define	SLOT_SPEED_LS		(XDEV_LS << 10)
-#define	SLOT_SPEED_HS		(XDEV_HS << 10)
-#define	SLOT_SPEED_SS		(XDEV_SS << 10)
-#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
-/* Port Indicator Control */
-#define PORT_LED_OFF	(0 << 14)
-#define PORT_LED_AMBER	(1 << 14)
-#define PORT_LED_GREEN	(2 << 14)
-#define PORT_LED_MASK	(3 << 14)
-/* Port Link State Write Strobe - set this when changing link state */
-#define PORT_LINK_STROBE	(1 << 16)
-/* true: connect status change */
-#define PORT_CSC	(1 << 17)
-/* true: port enable change */
-#define PORT_PEC	(1 << 18)
-/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
- * into an enabled state, and the device into the default state.  A "warm" reset
- * also resets the link, forcing the device through the link training sequence.
- * SW can also look at the Port Reset register to see when warm reset is done.
- */
-#define PORT_WRC	(1 << 19)
-/* true: over-current change */
-#define PORT_OCC	(1 << 20)
-/* true: reset change - 1 to 0 transition of PORT_RESET */
-#define PORT_RC		(1 << 21)
-/* port link status change - set on some port link state transitions:
- *  Transition				Reason
- *  ------------------------------------------------------------------------------
- *  - U3 to Resume			Wakeup signaling from a device
- *  - Resume to Recovery to U0		USB 3.0 device resume
- *  - Resume to U0			USB 2.0 device resume
- *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
- *  - U3 to U0				Software resume of USB 2.0 device complete
- *  - U2 to U0				L1 resume of USB 2.1 device complete
- *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
- *  - U0 to disabled			L1 entry error with USB 2.1 device
- *  - Any state to inactive		Error on USB 3.0 port
- */
-#define PORT_PLC	(1 << 22)
-/* port configure error change - port failed to configure its link partner */
-#define PORT_CEC	(1 << 23)
-#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
-				 PORT_RC | PORT_PLC | PORT_CEC)
-
-
-/* Cold Attach Status - xHC can set this bit to report device attached during
- * Sx state. Warm port reset should be perfomed to clear this bit and move port
- * to connected state.
- */
-#define PORT_CAS	(1 << 24)
-/* wake on connect (enable) */
-#define PORT_WKCONN_E	(1 << 25)
-/* wake on disconnect (enable) */
-#define PORT_WKDISC_E	(1 << 26)
-/* wake on over-current (enable) */
-#define PORT_WKOC_E	(1 << 27)
-/* bits 28:29 reserved */
-/* true: device is non-removable - for USB 3.0 roothub emulation */
-#define PORT_DEV_REMOVE	(1 << 30)
-/* Initiate a warm port reset - complete when PORT_WRC is '1' */
-#define PORT_WR		(1 << 31)
-
-/* We mark duplicate entries with -1 */
-#define DUPLICATE_ENTRY ((u8)(-1))
-
-/* Port Power Management Status and Control - port_power_base bitmasks */
-/* Inactivity timer value for transitions into U1, in microseconds.
- * Timeout can be up to 127us.  0xFF means an infinite timeout.
- */
-#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
-#define PORT_U1_TIMEOUT_MASK	0xff
-/* Inactivity timer value for transitions into U2 */
-#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
-#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
-/* Bits 24:31 for port testing */
-
-/* USB2 Protocol PORTSPMSC */
-#define	PORT_L1S_MASK		7
-#define	PORT_L1S_SUCCESS	1
-#define	PORT_RWE		(1 << 3)
-#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
-#define	PORT_HIRD_MASK		(0xf << 4)
-#define	PORT_L1DS_MASK		(0xff << 8)
-#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
-#define	PORT_HLE		(1 << 16)
-#define PORT_TEST_MODE_SHIFT	28
-
-/* USB3 Protocol PORTLI  Port Link Information */
-#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
-#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
-
-/* USB2 Protocol PORTHLPMC */
-#define PORT_HIRDM(p)((p) & 3)
-#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
-#define PORT_BESLD(p)(((p) & 0xf) << 10)
-
-/* use 512 microseconds as USB2 LPM L1 default timeout. */
-#define XHCI_L1_TIMEOUT		512
-
-/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
- * Safe to use with mixed HIRD and BESL systems (host and device) and is used
- * by other operating systems.
- *
- * XHCI 1.0 errata 8/14/12 Table 13 notes:
- * "Software should choose xHC BESL/BESLD field values that do not violate a
- * device's resume latency requirements,
- * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
- * or not program values < '4' if BLC = '0' and a BESL device is attached.
- */
-#define XHCI_DEFAULT_BESL	4
-
-/*
- * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
- * to complete link training. usually link trainig completes much faster
- * so check status 10 times with 36ms sleep in places we need to wait for
- * polling to complete.
- */
-#define XHCI_PORT_POLLING_LFPS_TIME  36
-
 /**
  * struct xhci_intr_reg - Interrupt Register Set
  * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 173d86d120da..af75911899f5 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -501,6 +501,7 @@ static void typec_altmode_release(struct device *dev)
 		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
+	put_device(alt->adev.dev.parent);
 	kfree(alt);
 }
 
@@ -550,6 +551,8 @@ typec_register_altmode(struct device *parent,
 	alt->adev.dev.type = &typec_altmode_dev_type;
 	dev_set_name(&alt->adev.dev, "%s.%u", dev_name(parent), id);
 
+	get_device(alt->adev.dev.parent);
+
 	/* Link partners and plugs with the ports */
 	if (!is_port)
 		typec_altmode_set_partner(alt);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6bc31fcaa657..2c5bd2ad69f3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3386,6 +3386,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	spin_lock(&cache->lock);
 	if (cache->ro)
 		space_info->bytes_readonly += num_bytes;
+	else if (btrfs_is_zoned(cache->fs_info))
+		space_info->bytes_zone_unusable += num_bytes;
 	cache->reserved -= num_bytes;
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 61b18f802048..bd7aeb4dcacf 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3028,6 +3028,15 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		return rc;
 
 	if (indatalen) {
+		unsigned int len;
+
+		if (WARN_ON_ONCE(smb3_encryption_required(tcon) &&
+				 (check_add_overflow(total_len - 1,
+						     ALIGN(indatalen, 8), &len) ||
+				  len > MAX_CIFS_SMALL_BUFFER_SIZE))) {
+			cifs_small_buf_release(req);
+			return -EIO;
+		}
 		/*
 		 * indatalen is usually small at a couple of bytes max, so
 		 * just allocate through generic pool
diff --git a/fs/exec.c b/fs/exec.c
index 26f0b79cb4f9..8395e7ff7b94 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -142,13 +142,11 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 		goto out;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * Check do_open_execat() for an explanation.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	fsnotify_open(file);
@@ -919,16 +917,16 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
-		goto out;
+		return file;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * In the past the regular type check was here. It moved to may_open() in
+	 * 633fb6ac3980 ("exec: move S_ISREG() check earlier"). Since then it is
+	 * an invariant that all non-regular files error out before we get here.
 	 */
 	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	err = deny_write_access(file);
@@ -938,7 +936,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (name->name[0] != '\0')
 		fsnotify_open(file);
 
-out:
 	return file;
 
 exit:
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 2c8905391ad3..3fa78e5f9b21 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -187,7 +187,7 @@ int dbMount(struct inode *ipbmap)
 	}
 
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag || bmp->db_numag >= MAXAG) {
+	if (!bmp->db_numag || bmp->db_numag > MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 81992b9a219b..98be72e93b40 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -77,7 +77,8 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 	const unsigned long clear_bits =
 		(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 		 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+		 BIT(BH_Delay));
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
@@ -409,7 +410,8 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+			 BIT(BH_Delay));
 
 		bh = head = page_buffers(page);
 		do {
diff --git a/fs/open.c b/fs/open.c
index 97932af49071..84e5dcc31c0e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1296,6 +1296,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
 
 	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
 	if (err)
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e68490991f5c..4983abca7397 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2100,12 +2100,15 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 		alen = udf_file_entry_alloc_offset(inode) +
 							iinfo->i_lenAlloc;
 	} else {
+		struct allocExtDesc *header =
+			(struct allocExtDesc *)epos->bh->b_data;
+
 		if (!epos->offset)
 			epos->offset = sizeof(struct allocExtDesc);
 		ptr = epos->bh->b_data + epos->offset;
-		alen = sizeof(struct allocExtDesc) +
-			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
-							lengthAllocDescs);
+		if (check_add_overflow(sizeof(struct allocExtDesc),
+				le32_to_cpu(header->lengthAllocDescs), &alen))
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 0399d1226323..456fca4d6a25 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -163,6 +163,9 @@ struct usb_os_desc_table {
  *	GetStatus() request when the recipient is Interface.
  * @func_suspend: callback to be called when
  *	SetFeature(FUNCTION_SUSPEND) is reseived
+ * @func_suspended: Indicates whether the function is in function suspend state.
+ * @func_wakeup_armed: Indicates whether the function is armed by the host for
+ *	wakeup signaling.
  *
  * A single USB function uses one or more interfaces, and should in most
  * cases support operation at both full and high speeds.  Each function is
@@ -233,6 +236,8 @@ struct usb_function {
 	int			(*get_status)(struct usb_function *);
 	int			(*func_suspend)(struct usb_function *,
 						u8 suspend_opt);
+	bool			func_suspended;
+	bool			func_wakeup_armed;
 	/* private: */
 	/* internals */
 	struct list_head		list;
@@ -254,6 +259,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
+int usb_func_wakeup(struct usb_function *func);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c5bc739266ed..e4feeaa8bab3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -311,6 +311,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*func_wakeup)(struct usb_gadget *gadget, int intf_id);
 	int	(*set_remote_wakeup)(struct usb_gadget *, int set);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 8043594a7f84..3cfa33a0aa16 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -336,13 +336,12 @@ static inline int genlmsg_multicast(const struct genl_family *family,
  * @skb: netlink message as socket buffer
  * @portid: own netlink portid to avoid sending to yourself
  * @group: offset of multicast group in groups array
- * @flags: allocation flags
  *
  * This function must hold the RTNL or rcu_read_lock().
  */
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags);
+			    unsigned int group);
 
 /**
  * genlmsg_unicast - unicast a netlink message
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 2e2e30d31a76..20ce2e1b3f61 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -315,20 +315,25 @@ struct xfrm_if_cb {
 void xfrm_if_register_cb(const struct xfrm_if_cb *ifcb);
 void xfrm_if_unregister_cb(void);
 
+struct xfrm_dst_lookup_params {
+	struct net *net;
+	int tos;
+	int oif;
+	xfrm_address_t *saddr;
+	xfrm_address_t *daddr;
+	u32 mark;
+	__u8 ipproto;
+	union flowi_uli uli;
+};
+
 struct net_device;
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
 	struct dst_ops		*dst_ops;
-	struct dst_entry	*(*dst_lookup)(struct net *net,
-					       int tos, int oif,
-					       const xfrm_address_t *saddr,
-					       const xfrm_address_t *daddr,
-					       u32 mark);
-	int			(*get_saddr)(struct net *net, int oif,
-					     xfrm_address_t *saddr,
-					     xfrm_address_t *daddr,
-					     u32 mark);
+	struct dst_entry	*(*dst_lookup)(const struct xfrm_dst_lookup_params *params);
+	int			(*get_saddr)(xfrm_address_t *saddr,
+					     const struct xfrm_dst_lookup_params *params);
 	int			(*fill_dst)(struct xfrm_dst *xdst,
 					    struct net_device *dev,
 					    const struct flowi *fl);
@@ -1645,10 +1650,7 @@ static inline int xfrm_user_policy(struct sock *sk, int optname,
 }
 #endif
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark);
+struct dst_entry *__xfrm_dst_lookup(int family, const struct xfrm_dst_lookup_params *params);
 
 struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6bfb510656ab..0bdeeabbc5a8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5108,11 +5108,6 @@ enum {
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
 };
 
-/* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
-enum {
-	BPF_F_INGRESS			= (1ULL << 0),
-};
-
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
 enum {
 	BPF_F_TUNINFO_IPV6		= (1ULL << 0),
@@ -5251,10 +5246,12 @@ enum {
 	BPF_F_BPRM_SECUREEXEC	= (1ULL << 0),
 };
 
-/* Flags for bpf_redirect_map helper */
+/* Flags for bpf_redirect and bpf_redirect_map helpers */
 enum {
-	BPF_F_BROADCAST		= (1ULL << 3),
-	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
+	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
+	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
+	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
+#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
 };
 
 #define __bpf_md_ptr(type, name)	\
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index bbf3ec03aa59..4118978951bb 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -325,9 +325,11 @@ static int dev_map_hash_get_next_key(struct bpf_map *map, void *key,
 
 static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 				struct xdp_frame **frames, int n,
-				struct net_device *dev)
+				struct net_device *tx_dev,
+				struct net_device *rx_dev)
 {
-	struct xdp_txq_info txq = { .dev = dev };
+	struct xdp_txq_info txq = { .dev = tx_dev };
+	struct xdp_rxq_info rxq = { .dev = rx_dev };
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
@@ -338,6 +340,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		switch (act) {
@@ -352,7 +355,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 			bpf_warn_invalid_xdp_action(act);
 			fallthrough;
 		case XDP_ABORTED:
-			trace_xdp_exception(dev, xdp_prog, act);
+			trace_xdp_exception(tx_dev, xdp_prog, act);
 			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame_rx_napi(xdpf);
@@ -380,7 +383,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	}
 
 	if (bq->xdp_prog) {
-		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
+		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev, bq->dev_rx);
 		if (!to_send)
 			goto out;
 	}
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 8127673bfc45..05e73d209aa8 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -290,6 +290,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 	struct posix_clock_desc cd;
 	int err;
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
@@ -299,9 +302,6 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
-	if (!timespec64_valid_strict(ts))
-		return -EINVAL;
-
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a1dc0ff1962e..126754b61edc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1790,8 +1790,6 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
-	if (ret == -ENOENT)
-		goto unlock;
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
 	} else {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 0888f0644d25..d2a1b7f03068 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -261,7 +261,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 	if (len == 0) {
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
-	} else if (len > MAX_EVENT_NAME_LEN) {
+	} else if (len >= MAX_EVENT_NAME_LEN) {
 		trace_probe_log_err(offset, EVENT_TOO_LONG);
 		return -EINVAL;
 	}
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 8bb6c8ad1131..ca46441d0657 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -745,8 +745,7 @@ static int __init bnep_init(void)
 	if (flt[0])
 		BT_INFO("BNEP filters: %s", flt);
 
-	bnep_sock_init();
-	return 0;
+	return bnep_sock_init();
 }
 
 static void __exit bnep_exit(void)
diff --git a/net/core/filter.c b/net/core/filter.c
index a92a35c0f1e7..b5e1e087a2b9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2405,9 +2405,9 @@ static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 
 /* Internal, non-exposed redirect flags. */
 enum {
-	BPF_F_NEIGH	= (1ULL << 1),
-	BPF_F_PEER	= (1ULL << 2),
-	BPF_F_NEXTHOP	= (1ULL << 3),
+	BPF_F_NEIGH	= (1ULL << 16),
+	BPF_F_PEER	= (1ULL << 17),
+	BPF_F_NEXTHOP	= (1ULL << 18),
 #define BPF_F_REDIRECT_INTERNAL	(BPF_F_NEIGH | BPF_F_PEER | BPF_F_NEXTHOP)
 };
 
@@ -2417,6 +2417,8 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 	struct sk_buff *clone;
 	int ret;
 
+	BUILD_BUG_ON(BPF_F_REDIRECT_INTERNAL & BPF_F_REDIRECT_FLAGS);
+
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return -EINVAL;
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index da0f49d77c01..dcbc087fff17 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -273,17 +273,19 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	/* Account for reference dev->ip_ptr (below) */
 	refcount_set(&in_dev->refcnt, 1);
 
-	err = devinet_sysctl_register(in_dev);
-	if (err) {
-		in_dev->dead = 1;
-		neigh_parms_release(&arp_tbl, in_dev->arp_parms);
-		in_dev_put(in_dev);
-		in_dev = NULL;
-		goto out;
+	if (dev != blackhole_netdev) {
+		err = devinet_sysctl_register(in_dev);
+		if (err) {
+			in_dev->dead = 1;
+			neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+			in_dev_put(in_dev);
+			in_dev = NULL;
+			goto out;
+		}
+		ip_mc_init_dev(in_dev);
+		if (dev->flags & IFF_UP)
+			ip_mc_up(in_dev);
 	}
-	ip_mc_init_dev(in_dev);
-	if (dev->flags & IFF_UP)
-		ip_mc_up(in_dev);
 
 	/* we can receive as soon as ip_ptr is set -- do this last */
 	rcu_assign_pointer(dev->ip_ptr, in_dev);
@@ -328,6 +330,19 @@ static void inetdev_destroy(struct in_device *in_dev)
 	call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
 }
 
+static int __init inet_blackhole_dev_init(void)
+{
+	int err = 0;
+
+	rtnl_lock();
+	if (!inetdev_init(blackhole_netdev))
+		err = -ENOMEM;
+	rtnl_unlock();
+
+	return err;
+}
+late_initcall(inet_blackhole_dev_init);
+
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
 {
 	const struct in_ifaddr *ifa;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 75c2f7ffe5be..63e5aa6d4b0b 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -791,21 +791,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(req_to_sk(req));
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
+	if (!from_timer && timer_delete_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	if (unlinked) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -898,7 +908,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
 			/* delete timer */
-			inet_csk_reqsk_queue_drop(sk_listener, nreq);
+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
 			goto no_ownership;
 		}
 
@@ -924,7 +934,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
+	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
+	reqsk_put(req);
 }
 
 static bool reqsk_queue_hash_req(struct request_sock *req,
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 4548a91acdc8..5d8e38f4ecc0 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -17,47 +17,43 @@
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
-					    int tos, int oif,
-					    const xfrm_address_t *saddr,
-					    const xfrm_address_t *daddr,
-					    u32 mark)
+static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
+					    const struct xfrm_dst_lookup_params *params)
 {
 	struct rtable *rt;
 
 	memset(fl4, 0, sizeof(*fl4));
-	fl4->daddr = daddr->a4;
-	fl4->flowi4_tos = tos;
-	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl4->flowi4_mark = mark;
-	if (saddr)
-		fl4->saddr = saddr->a4;
-
-	rt = __ip_route_output_key(net, fl4);
+	fl4->daddr = params->daddr->a4;
+	fl4->flowi4_tos = params->tos;
+	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							    params->oif);
+	fl4->flowi4_mark = params->mark;
+	if (params->saddr)
+		fl4->saddr = params->saddr->a4;
+	fl4->flowi4_proto = params->ipproto;
+	fl4->uli = params->uli;
+
+	rt = __ip_route_output_key(params->net, fl4);
 	if (!IS_ERR(rt))
 		return &rt->dst;
 
 	return ERR_CAST(rt);
 }
 
-static struct dst_entry *xfrm4_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm4_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi4 fl4;
 
-	return __xfrm4_dst_lookup(net, &fl4, tos, oif, saddr, daddr, mark);
+	return __xfrm4_dst_lookup(&fl4, params);
 }
 
-static int xfrm4_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm4_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct flowi4 fl4;
 
-	dst = __xfrm4_dst_lookup(net, &fl4, 0, oif, NULL, daddr, mark);
+	dst = __xfrm4_dst_lookup(&fl4, params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 492b9692c0dc..f5ef5e4c88df 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -23,23 +23,24 @@
 #include <net/ip6_route.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm6_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi6 fl6;
 	struct dst_entry *dst;
 	int err;
 
 	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl6.flowi6_mark = mark;
-	memcpy(&fl6.daddr, daddr, sizeof(fl6.daddr));
-	if (saddr)
-		memcpy(&fl6.saddr, saddr, sizeof(fl6.saddr));
+	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							   params->oif);
+	fl6.flowi6_mark = params->mark;
+	memcpy(&fl6.daddr, params->daddr, sizeof(fl6.daddr));
+	if (params->saddr)
+		memcpy(&fl6.saddr, params->saddr, sizeof(fl6.saddr));
 
-	dst = ip6_route_output(net, NULL, &fl6);
+	fl6.flowi4_proto = params->ipproto;
+	fl6.uli = params->uli;
+
+	dst = ip6_route_output(params->net, NULL, &fl6);
 
 	err = dst->error;
 	if (dst->error) {
@@ -50,15 +51,14 @@ static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
 	return dst;
 }
 
-static int xfrm6_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm6_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
 
-	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
+	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
@@ -68,7 +68,8 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
+	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+			   &saddr->in6);
 	dst_release(dst);
 	return 0;
 }
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 96eb91be9238..f34ca225c219 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -115,7 +115,7 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -143,7 +143,7 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index d80abd6ccaf8..6dcf4bc7e30b 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -79,7 +79,7 @@ static struct xt_target nflog_tg_reg[] __read_mostly = {
 	{
 		.name       = "NFLOG",
 		.revision   = 0,
-		.family     = NFPROTO_IPV4,
+		.family     = NFPROTO_IPV6,
 		.checkentry = nflog_tg_check,
 		.destroy    = nflog_tg_destroy,
 		.target     = nflog_tg,
diff --git a/net/netfilter/xt_TRACE.c b/net/netfilter/xt_TRACE.c
index f3fa4f11348c..a642ff09fc8e 100644
--- a/net/netfilter/xt_TRACE.c
+++ b/net/netfilter/xt_TRACE.c
@@ -49,6 +49,7 @@ static struct xt_target trace_tg_reg[] __read_mostly = {
 		.target		= trace_tg,
 		.checkentry	= trace_tg_check,
 		.destroy	= trace_tg_destroy,
+		.me		= THIS_MODULE,
 	},
 #endif
 };
diff --git a/net/netfilter/xt_mark.c b/net/netfilter/xt_mark.c
index f76fe04fc9a4..65b965ca40ea 100644
--- a/net/netfilter/xt_mark.c
+++ b/net/netfilter/xt_mark.c
@@ -62,7 +62,7 @@ static struct xt_target mark_tg_reg[] __read_mostly = {
 	{
 		.name           = "MARK",
 		.revision       = 2,
-		.family         = NFPROTO_IPV4,
+		.family         = NFPROTO_IPV6,
 		.target         = mark_tg,
 		.targetsize     = sizeof(struct xt_mark_tginfo2),
 		.me             = THIS_MODULE,
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 69b3a6b82f68..789cdc1dbcdf 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1089,15 +1089,11 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if (!family->netnsok) {
+	if (!family->netnsok)
 		genlmsg_multicast_netns(&genl_ctrl, &init_net, msg, 0,
 					0, GFP_KERNEL);
-	} else {
-		rcu_read_lock();
-		genlmsg_multicast_allns(&genl_ctrl, msg, 0,
-					0, GFP_ATOMIC);
-		rcu_read_unlock();
-	}
+	else
+		genlmsg_multicast_allns(&genl_ctrl, msg, 0, 0);
 
 	return 0;
 }
@@ -1441,23 +1437,23 @@ static int __init genl_init(void)
 
 core_initcall(genl_init);
 
-static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
-			 gfp_t flags)
+static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group)
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
 	bool delivered = false;
 	int err;
 
+	rcu_read_lock();
 	for_each_net_rcu(net) {
 		if (prev) {
-			tmp = skb_clone(skb, flags);
+			tmp = skb_clone(skb, GFP_ATOMIC);
 			if (!tmp) {
 				err = -ENOMEM;
 				goto error;
 			}
 			err = nlmsg_multicast(prev->genl_sock, tmp,
-					      portid, group, flags);
+					      portid, group, GFP_ATOMIC);
 			if (!err)
 				delivered = true;
 			else if (err != -ESRCH)
@@ -1466,27 +1462,31 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
 
 		prev = net;
 	}
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, GFP_ATOMIC);
+
+	rcu_read_unlock();
 
-	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
 		return err;
 	return delivered ? 0 : -ESRCH;
  error:
+	rcu_read_unlock();
+
 	kfree_skb(skb);
 	return err;
 }
 
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags)
+			    unsigned int group)
 {
 	if (WARN_ON_ONCE(group >= family->n_mcgrps))
 		return -EINVAL;
 
 	group = family->mcgrp_offset + group;
-	return genlmsg_mcast(skb, portid, group, flags);
+	return genlmsg_mcast(skb, portid, group);
 }
 EXPORT_SYMBOL(genlmsg_multicast_allns);
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 49831bd6a37d..44b971ef343c 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1612,7 +1612,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 		taprio_start_sched(sch, start, new_admin);
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index c9e4b37e6577..a895d1379801 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -743,7 +743,7 @@ static int smc_pnet_add_pnetid(struct net *net, u8 *pnetid)
 
 	write_lock(&sn->pnetids_ndev.lock);
 	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
-		if (smc_pnet_match(pnetid, pe->pnetid)) {
+		if (smc_pnet_match(pnetid, pi->pnetid)) {
 			refcount_inc(&pi->refcnt);
 			kfree(pe);
 			goto unlock;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d286a10f3552..457b197e3172 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16262,10 +16262,8 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
@@ -16779,10 +16777,8 @@ void nl80211_send_beacon_hint_event(struct wiphy *wiphy,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 8b8e957a69c3..4d13f7a372ab 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -241,6 +241,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
+		struct xfrm_dst_lookup_params params;
+
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
 			saddr = &x->props.saddr;
 			daddr = &x->id.daddr;
@@ -249,9 +251,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 			daddr = &x->props.saddr;
 		}
 
-		dst = __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
-					x->props.family,
-					xfrm_smark_get(0, x));
+		memset(&params, 0, sizeof(params));
+		params.net = net;
+		params.saddr = saddr;
+		params.daddr = daddr;
+		params.mark = xfrm_smark_get(0, x);
+		dst = __xfrm_dst_lookup(x->props.family, &params);
 		if (IS_ERR(dst))
 			return 0;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bc867d1905f5..55ef8e832924 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -251,10 +251,8 @@ static const struct xfrm_if_cb *xfrm_if_get_cb(void)
 	return rcu_dereference(xfrm_if_cb);
 }
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark)
+struct dst_entry *__xfrm_dst_lookup(int family,
+				    const struct xfrm_dst_lookup_params *params)
 {
 	const struct xfrm_policy_afinfo *afinfo;
 	struct dst_entry *dst;
@@ -263,7 +261,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
 	if (unlikely(afinfo == NULL))
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	dst = afinfo->dst_lookup(net, tos, oif, saddr, daddr, mark);
+	dst = afinfo->dst_lookup(params);
 
 	rcu_read_unlock();
 
@@ -277,6 +275,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
 {
+	struct xfrm_dst_lookup_params params;
 	struct net *net = xs_net(x);
 	xfrm_address_t *saddr = &x->props.saddr;
 	xfrm_address_t *daddr = &x->id.daddr;
@@ -291,7 +290,29 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 		daddr = x->coaddr;
 	}
 
-	dst = __xfrm_dst_lookup(net, tos, oif, saddr, daddr, family, mark);
+	params.net = net;
+	params.saddr = saddr;
+	params.daddr = daddr;
+	params.tos = tos;
+	params.oif = oif;
+	params.mark = mark;
+	params.ipproto = x->id.proto;
+	if (x->encap) {
+		switch (x->encap->encap_type) {
+		case UDP_ENCAP_ESPINUDP:
+			params.ipproto = IPPROTO_UDP;
+			params.uli.ports.sport = x->encap->encap_sport;
+			params.uli.ports.dport = x->encap->encap_dport;
+			break;
+		case TCP_ENCAP_ESPINTCP:
+			params.ipproto = IPPROTO_TCP;
+			params.uli.ports.sport = x->encap->encap_sport;
+			params.uli.ports.dport = x->encap->encap_dport;
+			break;
+		}
+	}
+
+	dst = __xfrm_dst_lookup(family, &params);
 
 	if (!IS_ERR(dst)) {
 		if (prev_saddr != saddr)
@@ -2342,15 +2363,15 @@ int __xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk)
 }
 
 static int
-xfrm_get_saddr(struct net *net, int oif, xfrm_address_t *local,
-	       xfrm_address_t *remote, unsigned short family, u32 mark)
+xfrm_get_saddr(unsigned short family, xfrm_address_t *saddr,
+	       const struct xfrm_dst_lookup_params *params)
 {
 	int err;
 	const struct xfrm_policy_afinfo *afinfo = xfrm_policy_get_afinfo(family);
 
 	if (unlikely(afinfo == NULL))
 		return -EINVAL;
-	err = afinfo->get_saddr(net, oif, local, remote, mark);
+	err = afinfo->get_saddr(saddr, params);
 	rcu_read_unlock();
 	return err;
 }
@@ -2379,9 +2400,14 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 			remote = &tmpl->id.daddr;
 			local = &tmpl->saddr;
 			if (xfrm_addr_any(local, tmpl->encap_family)) {
-				error = xfrm_get_saddr(net, fl->flowi_oif,
-						       &tmp, remote,
-						       tmpl->encap_family, 0);
+				struct xfrm_dst_lookup_params params;
+
+				memset(&params, 0, sizeof(params));
+				params.net = net;
+				params.oif = fl->flowi_oif;
+				params.daddr = remote;
+				error = xfrm_get_saddr(tmpl->encap_family, &tmp,
+						       &params);
 				if (error)
 					goto fail;
 				local = &tmp;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d65f781f7a36..1ebd54afe34c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -149,6 +149,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct nlattr **attrs)
 {
 	int err;
+	u16 family = p->sel.family;
 
 	err = -EINVAL;
 	switch (p->family) {
@@ -167,7 +168,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	}
 
-	switch (p->sel.family) {
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	switch (family) {
 	case AF_UNSPEC:
 		break;
 
@@ -887,7 +891,9 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	ap = nla_data(nla);
-	memcpy(ap, auth, sizeof(struct xfrm_algo_auth));
+	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(ap->alg_name));
+	ap->alg_key_len = auth->alg_key_len;
+	ap->alg_trunc_len = auth->alg_trunc_len;
 	if (redact_secret && auth->alg_key_len)
 		memset(ap->alg_key, 0, (auth->alg_key_len + 7) / 8);
 	else
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f2f6203e0fff..13be7826ae80 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -619,6 +619,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
 	mutex_lock(&fsi->state->policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -627,26 +634,21 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(fsi->state, data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
-
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
@@ -655,13 +657,12 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	}
 
 	selinux_policy_commit(fsi->state, &load_state);
-
 	length = count;
-
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->state->policy_mutex);
 	vfree(data);
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 842fe127c537..b5b3b4d177aa 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -172,6 +172,9 @@ static int apply_constraint_to_size(struct snd_pcm_hw_params *params,
 			step = max(step, amdtp_syt_intervals[i]);
 	}
 
+	if (step == 0)
+		return -EINVAL;
+
 	t.min = roundup(s->min, step);
 	t.max = rounddown(s->max, step);
 	t.integer = 1;
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index abf4eef9afa0..7285220c36f0 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1237,8 +1237,9 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		kctrl = snd_hda_gen_add_kctl(&spec->gen, "Line Out Playback Volume",
 					     &cs42l42_dac_volume_mixer);
 		/* Update Line Out kcontrol template */
-		kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
-				       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
+		if (kctrl)
+			kctrl->private_value = HDA_COMPOSE_AMP_VAL_OFS(DOLPHIN_HP_PIN_NID, 3, CS8409_CODEC1,
+					       HDA_OUTPUT, CS42L42_VOL_DAC) | HDA_AMP_VAL_MIN_MUTE;
 		cs8409_enable_ur(codec, 0);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d76e0a2618af..6b0d9e006f2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3848,20 +3848,18 @@ static void alc_default_init(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
 
-	if (hp_pin_sense)
-		msleep(100);
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		msleep(75);
+	}
 }
 
 static void alc_default_shutup(struct hda_codec *codec)
@@ -3877,22 +3875,20 @@ static void alc_default_shutup(struct hda_codec *codec)
 
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
-	if (hp_pin_sense)
+	if (hp_pin_sense) {
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-
-	if (hp_pin_sense)
-		msleep(85);
-
-	if (!spec->no_shutup_pins)
 		snd_hda_codec_write(codec, hp_pin, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	if (hp_pin_sense)
-		msleep(100);
+		msleep(75);
 
+		if (!spec->no_shutup_pins)
+			snd_hda_codec_write(codec, hp_pin, 0,
+					    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
 	alc_auto_setup_eapd(codec, false);
 	alc_shutup_pins(codec);
 }
@@ -7028,6 +7024,7 @@ enum {
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+	ALC255_FIXUP_PREDATOR_SUBWOOFER,
 	ALC299_FIXUP_PREDATOR_SPK,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
 	ALC289_FIXUP_DELL_SPK2,
@@ -8263,6 +8260,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC255_FIXUP_PREDATOR_SUBWOOFER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x17, 0x90170151 }, /* use as internal speaker (LFE) */
+			{ 0x1b, 0x90170152 } /* use as internal speaker (back) */
+		}
+	},
 	[ALC299_FIXUP_PREDATOR_SPK] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9001,6 +9005,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1166, "Acer Veriton N4640G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x1167, "Acer Veriton N6640G", ALC269_FIXUP_LIFEBOOK),
+	SND_PCI_QUIRK(0x1025, 0x1177, "Acer Predator G9-593", ALC255_FIXUP_PREDATOR_SUBWOOFER),
+	SND_PCI_QUIRK(0x1025, 0x1178, "Acer Predator G9-593", ALC255_FIXUP_PREDATOR_SUBWOOFER),
 	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
 	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 72a0db09c713..ac195e3b8c46 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -907,7 +907,7 @@ static const struct reg_default rx_defaults[] = {
 	{ CDC_RX_BCL_VBAT_PK_EST2, 0x01 },
 	{ CDC_RX_BCL_VBAT_PK_EST3, 0x40 },
 	{ CDC_RX_BCL_VBAT_RF_PROC1, 0x2A },
-	{ CDC_RX_BCL_VBAT_RF_PROC1, 0x00 },
+	{ CDC_RX_BCL_VBAT_RF_PROC2, 0x00 },
 	{ CDC_RX_BCL_VBAT_TAC1, 0x00 },
 	{ CDC_RX_BCL_VBAT_TAC2, 0x18 },
 	{ CDC_RX_BCL_VBAT_TAC3, 0x18 },
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 59dffa5ff34f..87d324927cd9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -498,6 +498,9 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
+	/* Set to avoid channel swap */
+	val_cr4 |= FSL_SAI_CR4_FCONT;
+
 	/* Set to output mode to avoid tri-stated data pins */
 	if (tx)
 		val_cr4 |= FSL_SAI_CR4_CHMOD;
@@ -523,7 +526,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 			   FSL_SAI_CR3_TRCE((1 << pins) - 1));
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
-			   FSL_SAI_CR4_CHMOD_MASK,
+			   FSL_SAI_CR4_CHMOD_MASK | FSL_SAI_CR4_FCONT_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index f8c9a8fb7898..0a03e68aadc1 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -132,6 +132,7 @@
 
 /* SAI Transmit and Receive Configuration 4 Register */
 
+#define FSL_SAI_CR4_FCONT_MASK	BIT(28)
 #define FSL_SAI_CR4_FCONT	BIT(28)
 #define FSL_SAI_CR4_FCOMB_SHIFT BIT(26)
 #define FSL_SAI_CR4_FCOMB_SOFT  BIT(27)
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 9f5e3e1dfd94..17fc844182d8 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -975,6 +975,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	/* Allocation for i2sctl regmap fields */
 	drvdata->i2sctl = devm_kzalloc(&pdev->dev, sizeof(struct lpaif_i2sctl),
 					GFP_KERNEL);
+	if (!drvdata->i2sctl)
+		return -ENOMEM;
 
 	/* Initialize bitfields for dai I2SCTL register */
 	ret = lpass_cpu_init_i2sctl_bitfields(dev, drvdata->i2sctl,
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index feb6589171ca..a38a741ace37 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -211,6 +211,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{.compatible = "qcom,sm8250-sndcard"},
+	{.compatible = "qcom,qrb4210-rb2-sndcard"},
 	{.compatible = "qcom,qrb5165-rb5-sndcard"},
 	{}
 };

