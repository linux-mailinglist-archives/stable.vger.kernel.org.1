Return-Path: <stable+bounces-81005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D1990DBD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC38286D7F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D011D95AD;
	Fri,  4 Oct 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptjxfsPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749801D95A6;
	Fri,  4 Oct 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066477; cv=none; b=na5aTAY1hRvNPvN33k0sDgmhm5jZQXlSXcSeE6iOu3hkY6ZQBYgauBblGY29qCbId/hsGcqac7T2sxn2rSyS3yXsHjiqzthO0L302GJsewkiba+hpnmufh1HzMp6+lfOkokcaII2Yk+OSKiK5YGUeifOnfmMZT5CXc+cD5WmYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066477; c=relaxed/simple;
	bh=lQwW8GvhU7cntpyWPbWqgvJ1TFtT/WD4eXCDKKYmQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSAZpiPmi3uvpOyJxPRSDf1F+1V7W9jHXm6ZJJNODH/+TNN6jgcqLwdQgt/f1kVCJkZVU6uRB8Sj1m+OBBhcv6TxtEWdLLm+6dk7MeLHX1hn2Ibg7fYpdsi7CSFY7YZTc5BlzVmXwCiCxCJIEDJRH4lAs4Zloel6PUZ6hXGXo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptjxfsPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD4C4CECC;
	Fri,  4 Oct 2024 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066477;
	bh=lQwW8GvhU7cntpyWPbWqgvJ1TFtT/WD4eXCDKKYmQDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptjxfsPpJSg5gdYuejUtwHSh8A1bGddY9nY9BIDu/R94pYny8MAoBOmUkBBCQaBEx
	 Wbg1zfG1xqG6RyanxvfOnWkoOrXS7TonWpE5X0mEf5feB5p4DSP3szxM0zZ1k9DfVu
	 ezPSr6TCqv4NAWD9AAKuXGo3rr4LjTRDzvht+au2B7vMBzS3Rnl/ng4ZaovACqDfko
	 JP3UX3Uq5TrxiE17lOS3Hib2gBIDtlpRdZuPvPIJ2+CZyY491oHHdLida59bylJINT
	 kbB4nvLuiTViJhIRji/ykoG6DAfwDWIq4IC10y2w7AECfQeOlP0PHEFLqno4VJYLPK
	 bFeRiULTqPXKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 21/42] RISC-V: Don't have MAX_PHYSMEM_BITS exceed phys_addr_t
Date: Fri,  4 Oct 2024 14:26:32 -0400
Message-ID: <20241004182718.3673735-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Palmer Dabbelt <palmer@rivosinc.com>

[ Upstream commit ad380f6a0a5e82e794b45bb2eaec24ed51a56846 ]

I recently ended up with a warning on some compilers along the lines of

      CC      kernel/resource.o
    In file included from include/linux/ioport.h:16,
                     from kernel/resource.c:15:
    kernel/resource.c: In function 'gfr_start':
    include/linux/minmax.h:49:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '17179869183' to '4294967295' [-Werror=overflow]
       49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
          |                                     ^
    include/linux/minmax.h:52:9: note: in expansion of macro '__cmp_once_unique'
       52 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
          |         ^~~~~~~~~~~~~~~~~
    include/linux/minmax.h:161:27: note: in expansion of macro '__cmp_once'
      161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
          |                           ^~~~~~~~~~
    kernel/resource.c:1829:23: note: in expansion of macro 'min_t'
     1829 |                 end = min_t(resource_size_t, base->end,
          |                       ^~~~~
    kernel/resource.c: In function 'gfr_continue':
    include/linux/minmax.h:49:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '17179869183' to '4294967295' [-Werror=overflow]
       49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
          |                                     ^
    include/linux/minmax.h:52:9: note: in expansion of macro '__cmp_once_unique'
       52 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
          |         ^~~~~~~~~~~~~~~~~
    include/linux/minmax.h:161:27: note: in expansion of macro '__cmp_once'
      161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
          |                           ^~~~~~~~~~
    kernel/resource.c:1847:24: note: in expansion of macro 'min_t'
     1847 |                addr <= min_t(resource_size_t, base->end,
          |                        ^~~~~
    cc1: all warnings being treated as errors

which looks like a real problem: our phys_addr_t is only 32 bits now, so
having 34-bit masks is just going to result in overflows.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240731162159.9235-2-palmer@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/sparsemem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
index 63acaecc33747..2f901a410586d 100644
--- a/arch/riscv/include/asm/sparsemem.h
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -7,7 +7,7 @@
 #ifdef CONFIG_64BIT
 #define MAX_PHYSMEM_BITS	56
 #else
-#define MAX_PHYSMEM_BITS	34
+#define MAX_PHYSMEM_BITS	32
 #endif /* CONFIG_64BIT */
 #define SECTION_SIZE_BITS	27
 #endif /* CONFIG_SPARSEMEM */
-- 
2.43.0


