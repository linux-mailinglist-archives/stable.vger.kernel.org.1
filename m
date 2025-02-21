Return-Path: <stable+bounces-118592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F05A3F6A3
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EDF3BEAA2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6420E335;
	Fri, 21 Feb 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IObDNwlc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619520B7F2
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146237; cv=none; b=cbdYQ2j9zW9jztuhyGbBzV/kLMBQPkavUoucm+6Zev8lWLIxiNEuvC/88FEecqssgxohyXMNp8MmO1TB88t9UIzKY82/ZIju3hB3WOPj+jQWys9TAfPWKyWxbqBlNI5es+y32j6TKXTB0NjgU6vd+CpjDUbVKjbkU/VEFbJXduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146237; c=relaxed/simple;
	bh=volPFa9RYy4gVcRgv7Kf3SiRUiDUxttAzs4dh4Ct8Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7TAnQ0caUfHyaOwG03ulvqje58cVFTond9dHtK47794kXOIRmHRNIIRSP0KpHnELEdHJuXXjCOFDGQXx2+ld5QgbfwS7c4JM4+hCn3hv2M7ZnH8EiSHc/316Af9Dd/fy8CfSmPkHIBr49H+jFYIi2tmQPd8GtEe2ZJq+GOtQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IObDNwlc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so23148975e9.0
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 05:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740146234; x=1740751034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QgqpJEuycUIEe4Og2qawQLjpg/faFxO4eXm0mFbcOA=;
        b=IObDNwlcrRwXS//K+defeDYPobCM6RWgSCfbh81CsfNrPKJz14I/KyLcx5qYpffOEX
         /JzW6Ud4us/FxKknkitYizgvEUANFNGDb75LVhZ7nGUyoODZ802RHAuFk9oZ8N7NTQc3
         hQJtYg2nnxLVB2QbgNa++S1Rt7nTjP8OURxYwSnB3eWB6lYa2zvGtKw0yWkNjyAOsrH1
         W3zEsPjYsoD8YZ2kb+6xCUoG1JzdwgbLihnKrkPKHL/QzOZ6rxD7DYcBKrCbges9WY58
         GF4CjdeI/tzXqy0WAtU7Q1AcOuGHpJkVS3/99bX8VsqZ4Pd5DL+d2Kn3NBQ0aYDchx/E
         Mf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146234; x=1740751034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QgqpJEuycUIEe4Og2qawQLjpg/faFxO4eXm0mFbcOA=;
        b=KeV0dK5w8t1+at5AAUeq+l/9Wa42jgGaaHjJuxzvq75dKtWReqqtfmUNmqaZcYZTzt
         EGEOYGx2NmDqp/+Bqe6+2SyAUYIAY/1eb583IWkUFAk9MiA73YpGJPT2tBvOH6XelFvn
         04sSB1+31GACBEuRHBPJNoM4j3vF8epTJ9nBvsldzAh3nmOLToxakt9r///WD9Fmwvqy
         /8S2WnSW9WGWs4yPFYdImUSVP43xDIRFvVShSCKvezpdSTVdPgVLVOxmYq6jyvA9ojCS
         pU1KPkwjzygmMlblw8sV+3PpPmhllOaiPLHkH2PzGmTBmrVTnwUH9cNiPHVWLP7Cs1m9
         6wbg==
X-Forwarded-Encrypted: i=1; AJvYcCXbK5kMvvgkoDyDnt7xHveNOeLeQHhkqmgrG2f0I1SBs7naTnFYbB3h7fYmQCxZBLyA1cV3EXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgDXo0DOmUUGIScf2A8lv/RLyNzBYV9WOZR5INTHgiO5/oTGj
	KtKPIneImapz0vojzIJltuE/HKlqvrdVkXzsbuHdxj05xfedyKKjdavzZdnieBwO9ryoog==
X-Google-Smtp-Source: AGHT+IGx6LVhgSFcm42dg7VjXDgeanxRd6Hh/hW3ioF0J+rcD6X8uxvpf66q7lnwBitra9fBYMtRkJ1O
X-Received: from wmbfl27.prod.google.com ([2002:a05:600c:b9b:b0:434:f1d0:7dc9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1383:b0:439:9a5a:d3a5
 with SMTP id 5b1f17b1804b1-439aeae186dmr20877285e9.1.1740146234049; Fri, 21
 Feb 2025 05:57:14 -0800 (PST)
Date: Fri, 21 Feb 2025 14:57:06 +0100
In-Reply-To: <20250221135704.431269-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221135704.431269-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=ardb@kernel.org;
 h=from:subject; bh=qMOouDoNVEK00y+HH+qNoH/b3RqloGuhSktNBenc3kE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1Hm5Efe0ljepWmvlq70RRXld+/Zu53tny8Q0ONea/FX
 Ikomz8dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJV1xgZWl/eP+v3+PupjU4H
 rLqeqC5s8mkTuideZRltsfrLtBoBPUaGM+phP2tYz7z1a63lEs068mz7/p3Vl2QeGOj/ZZC02rm YGwA=
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221135704.431269-5-ardb+git@google.com>
Subject: [PATCH v3 1/2] vmlinux.lds: Ensure that const vars with relocations
 are mapped R/O
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

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

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 02a4adb4a999..0d5b186abee8 100644
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
-- 
2.48.1.601.g30ceb7b040-goog


