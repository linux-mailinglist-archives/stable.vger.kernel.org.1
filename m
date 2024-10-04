Return-Path: <stable+bounces-80886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C4990C56
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3800F1F267BC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695401F5EAA;
	Fri,  4 Oct 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg9CQuBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E201F5EA5;
	Fri,  4 Oct 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066175; cv=none; b=MNxfXlkxe+NkXDpIvOl69PNTD6bh5mFACZ6E3iMaCyQUj+DY85W30rNFaTBU6mu/U+kpDOTzeeJXd2QMh4Y7edAHFP7/t3QNWcN7CY6QcSXxmvp/idQgbonb2w7e+lBtb8aALdMRl3Jcj0sX0bf7LDlzliK4b6GN4cOTma0LDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066175; c=relaxed/simple;
	bh=lQwW8GvhU7cntpyWPbWqgvJ1TFtT/WD4eXCDKKYmQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8yN+zGvAU8IvN/3EocV4+80ZyJkNvCdGSb2BPLxChRAntEiCDRTOsFtTiF+ZyxmoFi4Ego6rmDCrCCR9ujAJ2DYqH8ojVBOx7klNY0uB1StgvDVyqh8HQYrroVdH0jCeX/vmspyegKh2YIVv2L2bEJwCTRtPRVqkZsEUdGBDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg9CQuBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8636C4CECD;
	Fri,  4 Oct 2024 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066175;
	bh=lQwW8GvhU7cntpyWPbWqgvJ1TFtT/WD4eXCDKKYmQDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dg9CQuBm6KAlpC1COYDzDVUB8/bXYKVrxvWdyiYn1pyJet9J9nY8TpDuadABRN682
	 +B/RpLMNUD4YBU6gvDWISfw0zqWdBVSmPXoWHXlnimbzv7XCWDeapGTHCz12L15PFe
	 4+ME6jWwsvx5PZBrZffuTOklen9Ae5btHPHIeIYPJqKPPglxmpcmkGyHE/hcoPZm+p
	 VWJvoYGwPAhTKvtkKWFwKtiBIoGF/7x/bFPaftnydHIBJkHmAxWJqhfiDh+aoNDN4X
	 sSDKmtaGpn6PBSWZJVaA3OiCvFsD6aX/fk/Vo6QJyyY9Tm68gQS1D/RPdKsUPh4WhC
	 w4bu5ZpAFtC2g==
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
Subject: [PATCH AUTOSEL 6.10 30/70] RISC-V: Don't have MAX_PHYSMEM_BITS exceed phys_addr_t
Date: Fri,  4 Oct 2024 14:20:28 -0400
Message-ID: <20241004182200.3670903-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


