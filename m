Return-Path: <stable+bounces-157215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4ABAE52F0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32DB1B66328
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F341C84A0;
	Mon, 23 Jun 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQQVCsJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5442056;
	Mon, 23 Jun 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715321; cv=none; b=CjxxY+FiVe5EqHL7gionJptNE4u1l3y0LVZgTH7FJVeJrH5C7lLNPA1SyEDkqIalatal718qqbmbco1xi+NL6psTrpi+BLgNqt7fBNNnJX0OSFc7I7JPvJ8Aiayz6vHM/RkiXP4LkrC4XhZFfN2BCedWIlooJpM2/Kg49nFG+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715321; c=relaxed/simple;
	bh=XSma3ZNutnPzw7bNf8WLSCla3CTG2fesbbfFaiR89ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JN0dpb7Hj9/9eYrgPA5HP8X8JyKGqODv7aaqc+qWah1eOrZqbWQyFrRgfwKgxiqXNQ678NzsbroZOWLw4DoPfCXScffwQ8vNislMYlb7R0oi480Aw1QEw9wt8PO94X9EG9XqLq9SGKaQdhyVKYl9253tRX6TBM+vPJ6KV3bFT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQQVCsJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E881C4CEEA;
	Mon, 23 Jun 2025 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715321;
	bh=XSma3ZNutnPzw7bNf8WLSCla3CTG2fesbbfFaiR89ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQQVCsJu/daKssJiSQE0VCZhRsNUOzbWo7B9/1so4kjHgQNxk/KDobdl2eeFsqkqq
	 X/5PuyRydsxE+ZeaiMiGm3/8bllZ3V7oLYVu2z5+fqicz8Nhg0J/nmhZ9HU6IXuODR
	 vPhWyBHbSRoT1+oFqQ0ccUExZgWLN3l3gbTrPJU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	WANG Xuerui <git@xen0n.name>,
	Xi Ruoyao <xry111@xry111.site>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.15 451/592] LoongArch: vDSO: Correctly use asm parameters in syscall wrappers
Date: Mon, 23 Jun 2025 15:06:49 +0200
Message-ID: <20250623130711.155594138@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit e242bbbb6d7ac7556aa1e358294dc7e3c82cc902 upstream.

The syscall wrappers use the "a0" register for two different register
variables, both the first argument and the return value. Here the "ret"
variable is used as both input and output while the argument register is
only used as input. Clang treats the conflicting input parameters as an
undefined behaviour and optimizes away the argument assignment.

The code seems to work by chance for the most part today but that may
change in the future. Specifically clock_gettime_fallback() fails with
clockids from 16 to 23, as implemented by the upcoming auxiliary clocks.

Switch the "ret" register variable to a pure output, similar to the
other architectures' vDSO code. This works in both clang and GCC.

Link: https://lore.kernel.org/lkml/20250602102825-42aa84f0-23f1-4d10-89fc-e8bbaffd291a@linutronix.de/
Link: https://lore.kernel.org/lkml/20250519082042.742926976@linutronix.de/
Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
Fixes: 18efd0b10e0f ("LoongArch: vDSO: Wire up getrandom() vDSO implementation")
Cc: stable@vger.kernel.org
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Reviewed-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/vdso/getrandom.h    |    2 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -20,7 +20,7 @@ static __always_inline ssize_t getrandom
 
 	asm volatile(
 	"      syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (buffer), "r" (len), "r" (flags)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8",
 	  "memory");
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -25,7 +25,7 @@ static __always_inline long gettimeofday
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (tv), "r" (tz)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
@@ -44,7 +44,7 @@ static __always_inline long clock_gettim
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (clkid), "r" (ts)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");
@@ -63,7 +63,7 @@ static __always_inline int clock_getres_
 
 	asm volatile(
 	"       syscall 0\n"
-	: "+r" (ret)
+	: "=r" (ret)
 	: "r" (nr), "r" (clkid), "r" (ts)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
 	  "$t8", "memory");



