Return-Path: <stable+bounces-36886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2432989C32B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03847B29A3C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF08120D;
	Mon,  8 Apr 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hascb9EJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF9811E8;
	Mon,  8 Apr 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582629; cv=none; b=WebIdDl3Lr5x7xi830AvDrgyzzGntbmTS1pfE1fq4LGPu9RVKlaj4HluqoO0YoVrCoXKmwiGBc+YIy3La0Ambjn0BkmOkyD7O/uVCCZwdlYGLBxaOahZlz/QQ2/V4cVzWw35Sod18q6fi+LlGNQMVBxGKIb7L38z3E1lTUeKmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582629; c=relaxed/simple;
	bh=URsG9oxHMq3SFHwI5elFPm7kcguJbJEq+m3tEGzic3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgqxozsim0LA9EO+bciT5K3fEPBvEbuDHj8GjRmsntsy194KTV7EV044z15ysyiXcm2MM2n0RCwbnquts8euCKSn0hLerh60yFfxwlIPy0DV3Ex3xEkDeAYGb2QnUzzuuH38GV2SemZg18OXLrOEXYXGQp7FObOwhCHSn33A7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hascb9EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C14AC43390;
	Mon,  8 Apr 2024 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582629;
	bh=URsG9oxHMq3SFHwI5elFPm7kcguJbJEq+m3tEGzic3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hascb9EJvEeZ3vcF/hRO8++3pHJhCD9O/Va/u3EDKabK5bpUFejq4xbvOx8D9jpf4
	 ki1JeU+o0YEAsJjD60obvEqtNzPH0jZtXZLGP+oI6cpzsSn+byoEZ4vyUg0EDqyqvy
	 pKIvBxvOlIh6hSvbP3euPQ1qGaFv/Tch3tOlyrms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 121/138] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Date: Mon,  8 Apr 2024 14:58:55 +0200
Message-ID: <20240408125259.996156439@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 99485c4c026f024e7cb82da84c7951dbe3deb584 upstream.

There are few uses of CoCo that don't rely on working cryptography and
hence a working RNG. Unfortunately, the CoCo threat model means that the
VM host cannot be trusted and may actively work against guests to
extract secrets or manipulate computation. Since a malicious host can
modify or observe nearly all inputs to guests, the only remaining source
of entropy for CoCo guests is RDRAND.

If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
is meant to gracefully continue on gathering entropy from other sources,
but since there aren't other sources on CoCo, this is catastrophic.
This is mostly a concern at boot time when initially seeding the RNG, as
after that the consequences of a broken RDRAND are much more
theoretical.

So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
fails, panic(). This will also trigger if the system is booted without
RDRAND, as RDRAND is essential for a safe CoCo boot.

Add this deliberately to be "just a CoCo x86 driver feature" and not
part of the RNG itself. Many device drivers and platforms have some
desire to contribute something to the RNG, and add_device_randomness()
is specifically meant for this purpose.

Any driver can call it with seed data of any quality, or even garbage
quality, and it can only possibly make the quality of the RNG better or
have no effect, but can never make it worse.

Rather than trying to build something into the core of the RNG, consider
the particular CoCo issue just a CoCo issue, and therefore separate it
all out into driver (well, arch/platform) code.

  [ bp: Massage commit message. ]

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240326160735.73531-1-Jason@zx2c4.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/coco/core.c        |   41 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h |    2 ++
 arch/x86/kernel/setup.c     |    2 ++
 3 files changed, 45 insertions(+)

--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -3,13 +3,17 @@
  * Confidential Computing Platform Capability checks
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
+#include <linux/string.h>
+#include <linux/random.h>
 
+#include <asm/archrandom.h>
 #include <asm/coco.h>
 #include <asm/processor.h>
 
@@ -128,3 +132,40 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
+
+__init void cc_random_init(void)
+{
+	/*
+	 * The seed is 32 bytes (in units of longs), which is 256 bits, which
+	 * is the security level that the RNG is targeting.
+	 */
+	unsigned long rng_seed[32 / sizeof(long)];
+	size_t i, longs;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * Since the CoCo threat model includes the host, the only reliable
+	 * source of entropy that can be neither observed nor manipulated is
+	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since
+	 * CoCo guests have no other unobservable source of entropy, it's
+	 * important to at least ensure the RNG gets some initial random seeds.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
+		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
+
+		/*
+		 * A zero return value means that the guest doesn't have RDRAND
+		 * or the CPU is physically broken, and in both cases that
+		 * means most crypto inside of the CoCo instance will be
+		 * broken, defeating the purpose of CoCo in the first place. So
+		 * just panic here because it's absolutely unsafe to continue
+		 * executing.
+		 */
+		if (longs == 0)
+			panic("RDRAND is defective.");
+	}
+	add_device_randomness(rng_seed, sizeof(rng_seed));
+	memzero_explicit(rng_seed, sizeof(rng_seed));
+}
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -23,6 +23,7 @@ static inline void cc_set_mask(u64 mask)
 
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void cc_random_init(void);
 #else
 static inline u64 cc_mkenc(u64 val)
 {
@@ -33,6 +34,7 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+static inline void cc_random_init(void) { }
 #endif
 
 #endif /* _ASM_X86_COCO_H */
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <asm/numa.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
+#include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -1132,6 +1133,7 @@ void __init setup_arch(char **cmdline_p)
 	 * memory size.
 	 */
 	sev_setup_arch();
+	cc_random_init();
 
 	efi_fake_memmap();
 	efi_find_mirror();



