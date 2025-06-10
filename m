Return-Path: <stable+bounces-152355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78DAD4587
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 00:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8933A4A9B
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07357288C1C;
	Tue, 10 Jun 2025 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BV2IIeDg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTcVTgil"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41A288C00;
	Tue, 10 Jun 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592840; cv=none; b=AL9+pcRCHsZoqFpXeiklo+sKre8SVFPdCSw4DvTf1bqQyU0f9fn2MCa1PKccGTRa/onjd3WlEMiQDWXnZffQ/4SdXadGVZszdXV2NcRlAkeMcognjKmiVQY3DbqAGk3dpLvbQWVxQVH42JCr93uq47QZ97ZZvH59jJub8sftAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592840; c=relaxed/simple;
	bh=FnrGA5lxkPuqlYIs8QGMviRg4MaEfAXrtzR7YXE3u4g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=E6cZvps4skWmUXUbr6DoSnCUXWFflsxF3zRW3roOJ8hxgC6He/0lRK5FCD2hlifGDZzZMPJfOqNuAMOYjOHS2NxK0sfJkxTHkKfrSvS7U3mmONgKIITdZIey1TdR4D/pEIu+0QjixcZhl3XO7W9Vl6COUfIy2DnEtY615xX2NtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BV2IIeDg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTcVTgil; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 22:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749592836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZdS3BZQLcu/5nmH72ukL8l+dA44/cwpXTCneWcSu5Lw=;
	b=BV2IIeDgKiy5hB7RWkWwdotjjQ6ZIYryNRhl8KjB8oviNZNtwoDdZ0ETpY8DFQK+4jMVQz
	AZl2SDeiAVkYMT2Q5gwaGkIc0xL/qBm8kM0Mnz+ndl5Vh22wc8p27v0SzU3oFchvrtoqxo
	fqoNO0C3casIu9k8JA1+08yj5g7pG4k9kptr0MWzDjNKbqqrfznyTegxSHpyMtoBAhd93U
	oTdvl48vQ5lro9JrF6Toyi/1tQraJ/F5M7V3Ya5S1x7Gz6oA53ftEc3wJv/59QBmWwihFv
	B3J9CdPHfr7DDvh12lwdcPpx7BWdvb6qLy7auGn4jmlzPBCrTolGpH3xOY8xig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749592836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZdS3BZQLcu/5nmH72ukL8l+dA44/cwpXTCneWcSu5Lw=;
	b=BTcVTgilFHi4/oVwQrfbn3FqA6Xy3KJIidHlUe7la7aOdxy43clEGao3TzlwEYWxA12MZ2
	QwA4YARhSFuoEnCA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/virt/tdx: Avoid indirect calls to TDX assembly
 functions
Cc: Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174959283534.406.15846779981936679822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0b3bc018e86afdc0cbfef61328c63d5c08f8b370
Gitweb:        https://git.kernel.org/tip/0b3bc018e86afdc0cbfef61328c63d5c08f8b370
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sat, 07 Jun 2025 01:07:37 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 10 Jun 2025 12:32:52 -07:00

x86/virt/tdx: Avoid indirect calls to TDX assembly functions

Two 'static inline' TDX helper functions (sc_retry() and
sc_retry_prerr()) take function pointer arguments which refer to
assembly functions.  Normally, the compiler inlines the TDX helper,
realizes that the function pointer targets are completely static --
thus can be resolved at compile time -- and generates direct call
instructions.

But, other times (like when CONFIG_CC_OPTIMIZE_FOR_SIZE=y), the
compiler declines to inline the helpers and will instead generate
indirect call instructions.

Indirect calls to assembly functions require special annotation (for
various Control Flow Integrity mechanisms).  But TDX assembly
functions lack the special annotations and can only be called
directly.

Annotate both the helpers as '__always_inline' to prod the compiler
into maintaining the direct calls. There is no guarantee here, but
Peter has volunteered to report the compiler bug if this assumption
ever breaks[1].

Fixes: 1e66a7e27539 ("x86/virt/tdx: Handle SEAMCALL no entropy error in common code")
Fixes: df01f5ae07dd ("x86/virt/tdx: Add SEAMCALL error printing for module initialization")
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/20250605145914.GW39944@noisy.programming.kicks-ass.net/ [1]
Link: https://lore.kernel.org/all/20250606130737.30713-1-kai.huang%40intel.com
---
 arch/x86/include/asm/tdx.h  | 2 +-
 arch/x86/virt/vmx/tdx/tdx.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8b19294..7ddef3a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -106,7 +106,7 @@ void tdx_init(void);
 
 typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
 
-static inline u64 sc_retry(sc_func_t func, u64 fn,
+static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 			   struct tdx_module_args *args)
 {
 	int retry = RDRAND_RETRY_LOOPS;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2457d13..c7a9a08 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -75,8 +75,9 @@ static inline void seamcall_err_ret(u64 fn, u64 err,
 			args->r9, args->r10, args->r11);
 }
 
-static inline int sc_retry_prerr(sc_func_t func, sc_err_func_t err_func,
-				 u64 fn, struct tdx_module_args *args)
+static __always_inline int sc_retry_prerr(sc_func_t func,
+					  sc_err_func_t err_func,
+					  u64 fn, struct tdx_module_args *args)
 {
 	u64 sret = sc_retry(func, fn, args);
 

