Return-Path: <stable+bounces-104596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C85D9F51FF
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BE0188766D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EB1F76B1;
	Tue, 17 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+G0Rgev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BC1F757B;
	Tue, 17 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455532; cv=none; b=R/SD+qH7EyiYqZR/oaNXtuxwl4rAI7vPy+amyHJfJg2u2e3AlohLpqKWPUmeVc5lHhMj5q5rsz2JKUk9XANTxRKD5asqBLjMve+2Zw1svVAEswdMcu3jyXr8w956yekNzgjQwC7WkL/PZyC8zKCiiT/PbszhbVTzs7F1/KACdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455532; c=relaxed/simple;
	bh=hby9I9wrnU62BIsCDZssdIrRyXrYQZfOLQmCRtOpiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARRhzRTRe1BcNMmKCe9jPAlwfQlohw5cMynExhrIlNscRQu9YejXKJLN+WsfuVwmJ/asVIHJtOwc7OOjE0et4IpkELJSyUmnhWxRY7+0j083IFQG1xLJPnCpsNOGiBwFnvG8/1BlwzDHaFzcWuDDc2hUkx0QC3NvFzivMMOR1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+G0Rgev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02EAC4CED3;
	Tue, 17 Dec 2024 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455532;
	bh=hby9I9wrnU62BIsCDZssdIrRyXrYQZfOLQmCRtOpiCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0+G0RgevvRwebbjkDLd/A55XJUCy8yMNyRzJ7tfSO8bX9N9GJXs2ALy9PjhusRr4O
	 3M+7Oz1zD4Z0jtnK1PY6GsUzP94ZNkpSapwUp+S9w2uMaYpFC07G2n2hQaB8JfVVb2
	 7lovKQbS01rTOtkkCyItagLWAWJvetD6Y+OaFYPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 5.10 42/43] x86/xen: remove hypercall page
Date: Tue, 17 Dec 2024 18:07:33 +0100
Message-ID: <20241217170522.400810406@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
References: <20241217170520.459491270@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 7fa0da5373685e7ed249af3fa317ab1e1ba8b0a6 upstream.

The hypercall page is no longer needed. It can be removed, as from the
Xen perspective it is optional.

But, from Linux's perspective, it removes naked RET instructions that
escape the speculative protections that Call Depth Tracking and/or
Untrain Ret are trying to achieve.

This is part of XSA-466 / CVE-2024-53241.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/xen/hypercall.h |    2 --
 arch/x86/xen/enlighten.c             |    2 --
 arch/x86/xen/enlighten_hvm.c         |    9 +--------
 arch/x86/xen/enlighten_pvh.c         |    7 -------
 arch/x86/xen/xen-head.S              |   19 -------------------
 5 files changed, 1 insertion(+), 38 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -88,8 +88,6 @@ struct xen_dm_op_buf;
  * there aren't more than 5 arguments...)
  */
 
-extern struct { char _entry[32]; } hypercall_page[];
-
 void xen_hypercall_func(void);
 DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -21,8 +21,6 @@
 #include "smp.h"
 #include "pmu.h"
 
-EXPORT_SYMBOL_GPL(hypercall_page);
-
 DEFINE_STATIC_CALL(xen_hypercall, xen_hypercall_hvm);
 EXPORT_STATIC_CALL_TRAMP(xen_hypercall);
 
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -101,15 +101,8 @@ static void __init init_hvm_pv_info(void
 	/* PVH set up hypercall page in xen_prepare_pvh(). */
 	if (xen_pvh_domain())
 		pv_info.name = "Xen PVH";
-	else {
-		u64 pfn;
-		uint32_t msr;
-
+	else
 		pv_info.name = "Xen HVM";
-		msr = cpuid_ebx(base + 2);
-		pfn = __pa(hypercall_page);
-		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-	}
 
 	xen_setup_features();
 
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -25,17 +25,10 @@ bool xen_pvh __section(".data") = 0;
 
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
-	u32 msr;
-	u64 pfn;
-
 	xen_pvh = 1;
 	xen_domain_type = XEN_HVM_DOMAIN;
 	xen_start_flags = pvh_start_info.flags;
 
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-
 	xen_efi_init(boot_params);
 }
 
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -146,24 +146,6 @@ SYM_FUNC_START(xen_hypercall_intel)
 SYM_FUNC_END(xen_hypercall_intel)
 	.popsection
 
-.pushsection .text
-	.balign PAGE_SIZE
-SYM_CODE_START(hypercall_page)
-	.rept (PAGE_SIZE / 32)
-		UNWIND_HINT_FUNC
-		ANNOTATE_UNRET_SAFE
-		ret
-		.skip 31, 0xcc
-	.endr
-
-#define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
-	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
-#include <asm/xen-hypercalls.h>
-#undef HYPERCALL
-SYM_CODE_END(hypercall_page)
-.popsection
-
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
@@ -177,7 +159,6 @@ SYM_CODE_END(hypercall_page)
 #ifdef CONFIG_XEN_PV
 	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
 #endif
-	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,
 		.ascii "!writable_page_tables|pae_pgdir_above_4gb")
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,



