Return-Path: <stable+bounces-139500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14BAA756A
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CD16C3B6
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AFA256C66;
	Fri,  2 May 2025 14:58:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57519B5B4;
	Fri,  2 May 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197884; cv=none; b=p3Sw2VMdUqHW+trdIuOuM6CYDo0ORA82ZMfPgSOApRsxb/UkwagYqAfJ/K8+gQv6YKZTs+PcPL+e7tLp2b+HKGZS4FBYXS4CKuTngT62E5zj678TSBHrKl+rVzXMayrKS8tND09EMhJ23CBcKDf9z4B7b/6Sq1OOHSMKeTLlTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197884; c=relaxed/simple;
	bh=joLM/u39YqBQ3W0TxpsBGRYa+ZZYfB/buBDGV5XcTuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gBNwFz4Qa8RiY5oq2R4H0vpyd8wM1q3y8VtHEK0DmBql0xbjKmlT5yfqnp2AHjF4vPPkZJq5iPUvTAoE/IQ7ipKsfmgYP25EJ+joMFc88xWfcPwG1/MP5zLqr7a2u94IZ05pfIzYrv0ULIJO4QHltRA8lcX7IN8iCF3/7xw+PwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A701688;
	Fri,  2 May 2025 07:57:52 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78B843F66E;
	Fri,  2 May 2025 07:57:57 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	broonie@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	joey.gouly@arm.com,
	james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com,
	ardb@kernel.org,
	ryan.roberts@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
Date: Fri,  2 May 2025 15:57:55 +0100
Message-Id: <20250502145755.3751405-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_init_idmap() could be called before .bss section initialization
which is done in early_map_kernel() since data/test_prot could be set
wrong for PTE_MAYBE_NG macro.

PTE_MAYBE_NG macro is set according to value of "arm64_use_ng_mappings".
and this variable is located in .bss section.

   # llvm-objdump-21 --syms vmlinux-gcc | grep arm64_use_ng_mappings
     ffff800082f242a8 g O .bss    0000000000000001 arm64_use_ng_mappings

If .bss section doesn't initialized, "arm64_use_ng_mappings" would be set
with garbage value ant then the text_prot or data_prot could be set
with garbgae value.

Here is what i saw with kernel compiled via llvm-21

  // create_init_idmap()
  ffff80008255c058: d10103ff     	sub	sp, sp, #0x40
  ffff80008255c05c: a9017bfd     	stp	x29, x30, [sp, #0x10]
  ffff80008255c060: a90257f6     	stp	x22, x21, [sp, #0x20]
  ffff80008255c064: a9034ff4     	stp	x20, x19, [sp, #0x30]
  ffff80008255c068: 910043fd     	add	x29, sp, #0x10
  ffff80008255c06c: 90003fc8     	adrp	x8, 0xffff800082d54000
  ffff80008255c070: d280e06a     	mov	x10, #0x703     // =1795
  ffff80008255c074: 91400409     	add	x9, x0, #0x1, lsl #12 // =0x1000
  ffff80008255c078: 394a4108     	ldrb	w8, [x8, #0x290] ------------- (1)
  ffff80008255c07c: f2e00d0a     	movk	x10, #0x68, lsl #48
  ffff80008255c080: f90007e9     	str	x9, [sp, #0x8]
  ffff80008255c084: aa0103f3     	mov	x19, x1
  ffff80008255c088: aa0003f4     	mov	x20, x0
  ffff80008255c08c: 14000000     	b	0xffff80008255c08c <__pi_create_init_idmap+0x34>
  ffff80008255c090: aa082d56     	orr	x22, x10, x8, lsl #11 -------- (2)

Note (1) is load the arm64_use_ng_mappings value in w8.
and (2) is set the text or data prot with the w8 value to set PTE_NG bit.
If .bss section doesn't initialized, x8 can include garbage value
-- In case of some platform, x8 loaded with 0xcf -- it could generate
wrong mapping. (i.e) text_prot is expected with
PAGE_KERNEL_ROX(0x0040000000000F83) but
with garbage x8 -- 0xcf, it sets with (0x0040000000067F83)
and This makes boot failure with translation fault.

This error cannot happen according to code generated by compiler.
here is the case of gcc:

   ffff80008260a940 <__pi_create_init_idmap>:
   ffff80008260a940: d100c3ff      sub     sp, sp, #0x30
   ffff80008260a944: aa0003ed      mov     x13, x0
   ffff80008260a948: 91400400      add     x0, x0, #0x1, lsl #12 // =0x1000
   ffff80008260a94c: a9017bfd      stp     x29, x30, [sp, #0x10]
   ffff80008260a950: 910043fd      add     x29, sp, #0x10
   ffff80008260a954: f90017e0      str     x0, [sp, #0x28]
   ffff80008260a958: d00048c0      adrp    x0, 0xffff800082f24000 <reset_devices>
   ffff80008260a95c: 394aa000      ldrb    w0, [x0, #0x2a8]
   ffff80008260a960: 37000640      tbnz    w0, #0x0, 0xffff80008260aa28 <__pi_create_init_idmap+0xe8> ---(3)
   ffff80008260a964: d280f060      mov     x0, #0x783      // =1923
   ffff80008260a968: d280e062      mov     x2, #0x703      // =1795
   ffff80008260a96c: f2e00800      movk    x0, #0x40, lsl #48
   ffff80008260a970: f2e00d02      movk    x2, #0x68, lsl #48
   ffff80008260a974: aa2103e4      mvn     x4, x1
   ffff80008260a978: 8a210049      bic     x9, x2, x1
   ...
   ffff80008260aa28: d281f060      mov     x0, #0xf83      // =3971
   ffff80008260aa2c: d281e062      mov     x2, #0xf03      // =3843
   ffff80008260aa30: f2e00800      movk    x0, #0x40, lsl #48

In case of gcc, according to value of arm64_use_ng_mappings (annoated as(3)),
it branches to each prot settup code.
However this is also problem since it branches according to garbage
value too -- idmapping with wrong pgprot.

To resolve this, annotate arm64_use_ng_mappings as ro_after_init.

Fixes: 84b04d3e6bdb ("arm64: kernel: Create initial ID map from C code")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
There is another way to solve this problem by setting
test/data_prot with _PAGE_DEFAULT which doesn't include PTE_MAYBE_NG
with constanst check in create_init_idmap() to be free from
arm64_use_ng_mappings. but i think it would be better to change
arm64_use_ng_mappings as ro_after_init because it doesn't change after
init phase and solve this problem too.
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d2104a1e7843..967ffb1cbd52 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -114,7 +114,7 @@ static struct arm64_cpu_capabilities const __ro_after_init *cpucap_ptrs[ARM64_NC

 DECLARE_BITMAP(boot_cpucaps, ARM64_NCAPS);

-bool arm64_use_ng_mappings = false;
+bool arm64_use_ng_mappings __ro_after_init = false;
 EXPORT_SYMBOL(arm64_use_ng_mappings);

 DEFINE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector) = vectors;
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


