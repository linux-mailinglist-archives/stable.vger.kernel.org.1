Return-Path: <stable+bounces-150704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E68ACC5C7
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA3A166AEE
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316C22E3E0;
	Tue,  3 Jun 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EjwPsOj0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUYsPeG9"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307C22DFE8;
	Tue,  3 Jun 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951358; cv=none; b=J/iGs2+9UyHvHpneIbAbJMiyn38xe5lzOHLTjaesZMntN5fwzOQvkWNZw215rsdnJUnBOV+asH3YXopQI2DxLGzT1aX7J7WxjFTeQ1gpBqLXjtDBN8Ts54UIQBbgQUSGklUMi4nVTiylRFa1dLEWwWCPpstXCjB/DYAQN8h3OEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951358; c=relaxed/simple;
	bh=wom79q92oCFLcZlN7tEa7jlXzfWsnWnHafZTXK6l0Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tmoGk2eYnWZyOf9ajxdD257BNkKO5KqR7tcV5DHpmFuaDo7JcxgqaK6pNuHhAyroJ7xiqBDt7h8DbY4iF/hj7KO9H/IluctabwMNqY9lf8QtNuaYtnf66z1gwYnBtD97KVKwaF6106r4wRee3JBId8a7/6drU17b3TqvHjYau34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EjwPsOj0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUYsPeG9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748951355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oMdxVtTtFnSvdmEEqBijs6M91boPnIabeZHBVmqzvPk=;
	b=EjwPsOj0dLQE/8aFL3ohPMaRoo0e/s2GZB+PG+3m2tfAa0LMtAm9nqn1rx7IfHR5Z7OWBv
	KVIIGzw5Z27uqRzZBxJXZmtv9E5hwe07m1wuksd5wdsLObVyjh/uu2KJpfI8f4Fds1JYPO
	Moech0JSHXX71BQa1opFTYUj04mZpCnh39o84ooVyMtgoSBwF9jL2vQQdVW/jXQx9SZsWq
	VlxCReNVl+d1ThaJPuyYE3r35k2gl69BT7zrjy470Y21AXvko1o4YwwWimTd/EQFixPNnS
	TrNce6WbFBJDRP0B0cVSwztYjelLwszM/kDe0OMd9q/rkEBfmjBWtBpSJYVKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748951355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oMdxVtTtFnSvdmEEqBijs6M91boPnIabeZHBVmqzvPk=;
	b=dUYsPeG9AFR7ZdVKavNrhR4xPgd4/ZYrgxEEAoShaQm7l8kfScYHN/Pz4hEkoECXOJFfLt
	0bpn1r+RHnbsesAQ==
Date: Tue, 03 Jun 2025 13:48:54 +0200
Subject: [PATCH] LoongArch: vDSO: correctly use asm parameters in syscall
 wrappers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACXhPmgC/x3MMQqAMAxA0atIZgNVqahXEYdYowZKKw2IIt7d4
 viG/x9QTsIKQ/FA4lNUYsioygLcTmFjlCUbalNb05oGfYxho+R2PBeNqLc68h5X21nq+5nJNJD
 jI/Eq1z8ep/f9AAP8HJpoAAAA
X-Change-ID: 20250603-loongarch-vdso-syscall-f585a99bea03
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748951353; l=3225;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wom79q92oCFLcZlN7tEa7jlXzfWsnWnHafZTXK6l0Iw=;
 b=3jgZcQJ3gm6pwD+AzZ1xE/BHuSfeZIiVw/+Nnhy3PUYU1fJnM8+f0WObpafBHQrqu/2ZDkpTc
 4bUHhFr2fhpA/aVAes5K8IZ/IBAp4j39bk92v8lblXzB0kMOLsKwQKp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The syscall wrappers use the "a0" register for two different register
variables, both the first argument and the return value. The "ret"
variable is used as both input and output while the argument register is
only used as input. Clang treats the conflicting input parameters as
undefined behaviour and optimizes away the argument assignment.

The code seems to work by chance for the most part today but that may
change in the future. Specifically clock_gettime_fallback() fails with
clockids from 16 to 23, as implemented by the upcoming auxiliary clocks.

Switch the "ret" register variable to a pure output, similar to the other
architectures' vDSO code. This works in both clang and GCC.

Link: https://lore.kernel.org/lkml/20250602102825-42aa84f0-23f1-4d10-89fc-e8bbaffd291a@linutronix.de/
Link: https://lore.kernel.org/lkml/20250519082042.742926976@linutronix.de/
Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
Fixes: 18efd0b10e0f ("LoongArch: vDSO: Wire up getrandom() vDSO implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/include/asm/vdso/getrandom.h    | 2 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/include/asm/vdso/getrandom.h
index 48c43f55b039b42168698614d0479b7a872d20f3..a81724b69f291ee49dd1f46b12d6893fc18442b8 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -20,7 +20,7 @@ static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, uns
 
 	asm volatile(
 	"      syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (buffer), "r" (len), "r" (flags)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8",
 	  "memory");
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 88cfcf13311630ed5f1a734d23a2bc3f65d79a88..f15503e3336ca1bdc9675ec6e17bbb77abc35ef4 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -25,7 +25,7 @@ static __always_inline long gettimeofday_fallback(
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (tv), "r" (tz)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
@@ -44,7 +44,7 @@ static __always_inline long clock_gettime_fallback(
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (clkid), "r" (ts)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
@@ -63,7 +63,7 @@ static __always_inline int clock_getres_fallback(
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (clkid), "r" (ts)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");

---
base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
change-id: 20250603-loongarch-vdso-syscall-f585a99bea03

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


