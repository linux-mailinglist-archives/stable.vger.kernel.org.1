Return-Path: <stable+bounces-5615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E880D59E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305FF28220C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62DF5101E;
	Mon, 11 Dec 2023 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tx/ZCXrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145F2D045;
	Mon, 11 Dec 2023 18:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05226C433C8;
	Mon, 11 Dec 2023 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319198;
	bh=Zi+cFCXqcqlx/sGqiKZXH3TyZ1p68L2gHFCfr8v5BRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tx/ZCXrWtT2DfrlcQdjzyjX6jO3DB4NphQe2xDO4KSW5MhFQohcNmDHdrXDDfACXW
	 zPY2SQFqoTkVR6buraZaiccvKNh13yQ64giEKIMA7BxLa9xxzX1idRTiyvOVbyxhHW
	 d0e/QoPgMMTCYD6cgiDZzs0p9Swa7vpwrPLkPq0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Supraja Sridhara <supraja.sridhara@inf.ethz.ch>,
	=?UTF-8?q?Benedict=20Schl=C3=BCter?= <benedict.schlueter@inf.ethz.ch>,
	Mark Kuhne <mark.kuhne@inf.ethz.ch>,
	Andrin Bertschi <andrin.bertschi@inf.ethz.ch>,
	Shweta Shinde <shweta.shinde@inf.ethz.ch>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.6 018/244] x86/coco: Disable 32-bit emulation by default on TDX and SEV
Date: Mon, 11 Dec 2023 19:18:31 +0100
Message-ID: <20231211182046.601520348@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

[ upstream commit b82a8dbd3d2f4563156f7150c6f2ecab6e960b30 ]

The INT 0x80 instruction is used for 32-bit x86 Linux syscalls. The
kernel expects to receive a software interrupt as a result of the INT
0x80 instruction. However, an external interrupt on the same vector
triggers the same handler.

The kernel interprets an external interrupt on vector 0x80 as a 32-bit
system call that came from userspace.

A VMM can inject external interrupts on any arbitrary vector at any
time.  This remains true even for TDX and SEV guests where the VMM is
untrusted.

Put together, this allows an untrusted VMM to trigger int80 syscall
handling at any given point. The content of the guest register file at
that moment defines what syscall is triggered and its arguments. It
opens the guest OS to manipulation from the VMM side.

Disable 32-bit emulation by default for TDX and SEV. User can override
it with the ia32_emulation=y command line option.

[ dhansen: reword the changelog ]

Reported-by: Supraja Sridhara <supraja.sridhara@inf.ethz.ch>
Reported-by: Benedict Schlüter <benedict.schlueter@inf.ethz.ch>
Reported-by: Mark Kuhne <mark.kuhne@inf.ethz.ch>
Reported-by: Andrin Bertschi <andrin.bertschi@inf.ethz.ch>
Reported-by: Shweta Shinde <shweta.shinde@inf.ethz.ch>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@vger.kernel.org> # 6.0+: 1da5c9b x86: Introduce ia32_enabled()
Cc: <stable@vger.kernel.org> # 6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/coco/tdx/tdx.c       |   10 ++++++++++
 arch/x86/include/asm/ia32.h   |    7 +++++++
 arch/x86/mm/mem_encrypt_amd.c |   11 +++++++++++
 3 files changed, 28 insertions(+)

--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -10,6 +10,7 @@
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
@@ -820,5 +821,14 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
+	/*
+	 * The VMM is capable of injecting interrupt 0x80 and triggering the
+	 * compatibility syscall path.
+	 *
+	 * By default, the 32-bit emulation is disabled in order to ensure
+	 * the safety of the VM.
+	 */
+	ia32_disable();
+
 	pr_info("Guest detected\n");
 }
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -75,6 +75,11 @@ static inline bool ia32_enabled(void)
 	return __ia32_enabled;
 }
 
+static inline void ia32_disable(void)
+{
+	__ia32_enabled = false;
+}
+
 #else /* !CONFIG_IA32_EMULATION */
 
 static inline bool ia32_enabled(void)
@@ -82,6 +87,8 @@ static inline bool ia32_enabled(void)
 	return IS_ENABLED(CONFIG_X86_32);
 }
 
+static inline void ia32_disable(void) {}
+
 #endif
 
 #endif /* _ASM_X86_IA32_H */
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -34,6 +34,7 @@
 #include <asm/msr.h>
 #include <asm/cmdline.h>
 #include <asm/sev.h>
+#include <asm/ia32.h>
 
 #include "mm_internal.h"
 
@@ -517,6 +518,16 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
 		x86_cpuinit.parallel_bringup = false;
+
+	/*
+	 * The VMM is capable of injecting interrupt 0x80 and triggering the
+	 * compatibility syscall path.
+	 *
+	 * By default, the 32-bit emulation is disabled in order to ensure
+	 * the safety of the VM.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ENABLED)
+		ia32_disable();
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)



