Return-Path: <stable+bounces-119932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C7A497B7
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A43AF3D2
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BF260385;
	Fri, 28 Feb 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vbrh2TX6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fcuDT7uF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27326036F;
	Fri, 28 Feb 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739654; cv=none; b=faOeC9VL/dVzAwgK+zVvzG9YqFQR3P/Ifq/DjFOSyhXF8ffSh0PRhR0AxZtGKY1xBN1c4vxzX50CDlzz7wcMjgDf8lGppRmh1iuz3srqLUJ+v1lHVw/DHiRBUKARd270moPqSDAhLVrbPRA2HhW4GReEajdPvfZaUGE2mgKSDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739654; c=relaxed/simple;
	bh=1ywW8a3SB/Fis7HVQ2bD96rFKTz4O+TNpBllCwnp1EI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V77LgkH4wVVt/hEKw4QqMov2REif6T1o5gYTyuS9Ix920MFXjDFg3gxvouQ9909z0otdDsjOAJGfz2cpo78MfL/ato8QKzV3A82HGNBbis6jXs236qtg42Dv4sfwKXBLnJFpZRwjK95PADk2BqofwufOjIefvcVF+kV3Ve7l+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vbrh2TX6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fcuDT7uF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 10:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740739650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/ptxWFUNih/wrwsi2l1i1o64kt3nmKnGlTSYRTiCjk=;
	b=Vbrh2TX6OER1PNEwOd9XowRwfZzCfz1pTMrwH8AETgCOkL3QrzYIg6DXgxOl+oVoWPxZS1
	iDhc3rvNn0wuOey4LZzp+QEuM/DBqSrH66jo3zvEaYNsOfx2NvWwMJZntyH1a5HClcOuJU
	A39ifewWSRqDmoKKqUXZVL1rkB7FKSlAZN97wo5jlsU4dUzEPdfm/e0ec6hAhBv2nSHUT6
	kMMiq8ByMt9aCgGUEMYa9Ax8ycbzKrFR2XwSV3sBvjHvNn4XTbq7IwxZZK/Yl/u4g0DU31
	K7C5AlVYeVibD0yNXI6YhETlPMUoMM3JeGsv1AV0VUk8qjgIeYEaglVsgB8PaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740739650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/ptxWFUNih/wrwsi2l1i1o64kt3nmKnGlTSYRTiCjk=;
	b=fcuDT7uFrSm4Y/DwKHKfDCK4EAstwdVELS6tYYmPMpjHNOcsdOHjlkzHoj8cgm8m3VK/EJ
	Za5J7IB74Btda/Dw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] vmlinux.lds: Ensure that const vars with
 relocations are mapped R/O
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250221135704.431269-5-ardb+git@google.com>
References: <20250221135704.431269-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073965032.10177.1515990082741091983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     68f3ea7ee199ef77551e090dfef5a49046ea8443
Gitweb:        https://git.kernel.org/tip/68f3ea7ee199ef77551e090dfef5a49046ea8443
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 21 Feb 2025 14:57:06 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 25 Feb 2025 09:46:15 -08:00

vmlinux.lds: Ensure that const vars with relocations are mapped R/O

In the kernel, there are architectures (x86, arm64) that perform
boot-time relocation (for KASLR) without relying on PIE codegen. In this
case, all const global objects are emitted into .rodata, including const
objects with fields that will be fixed up by the boot-time relocation
code.  This implies that .rodata (and .text in some cases) need to be
writable at boot, but they will usually be mapped read-only as soon as
the boot completes.

When using PIE codegen, the compiler will emit const global objects into
.data.rel.ro rather than .rodata if the object contains fields that need
such fixups at boot-time. This permits the linker to annotate such
regions as requiring read-write access only at load time, but not at
execution time (in user space), while keeping .rodata truly const (in
user space, this is important for reducing the CoW footprint of dynamic
executables).

This distinction does not matter for the kernel, but it does imply that
const data will end up in writable memory if the .data.rel.ro sections
are not treated in a special way, as they will end up in the writable
.data segment by default.

So emit .data.rel.ro into the .rodata segment.

Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250221135704.431269-5-ardb+git@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5450401..337d333 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\

