Return-Path: <stable+bounces-161616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4003B00D0D
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 22:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F406478AF
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3D30207B;
	Thu, 10 Jul 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAZHJaQE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D75302CBE;
	Thu, 10 Jul 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179136; cv=none; b=CMaB9KIxVfbZtvXczeMNnMLfE8KAuX6Q9wteQv3YfT6lpdDslj5cp1ntUymZiN87WIIuSYWhthYzbckP8Ocypl9vuuJuEM6XUzcy+9hQ3y2R2izbkBJByPrZ1pCm6kjnS3PqB/m6NRyHQU+MoMBGBvLRYHg/G+86btX58JGjBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179136; c=relaxed/simple;
	bh=P7zxnegUb85mA+6We1f5qwe9gxYERpxjlx3DtZfguCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tzn784DNiBzSooEy7Mv4alCGmoLeMDrEGIUAE6LYrR102v5T8JNe2i431TT8lsijfPvr5Oi1AofzjDLycrgkNANTbkNsnf6lPVEGPT5lbaxcCM6GL6MKPWhWXoP6LDWh8GsGrLEDE/NXrDStfnYjKESPmoXu70HHkSPpdDQL1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAZHJaQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3119DC4CEE3;
	Thu, 10 Jul 2025 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752179135;
	bh=P7zxnegUb85mA+6We1f5qwe9gxYERpxjlx3DtZfguCA=;
	h=From:Date:Subject:To:Cc:From;
	b=MAZHJaQEl4RJFiWhzI3upsOYplIPkUFIXG+52Z7Vn9eyuEbdwP9bNFfV2xivWTVzr
	 qVJZwBHTtqwWiJo7G+LSHGQLJYDnpzXx6tq0AgokWVmFdm9o25DeuDvREcmijzCUaG
	 C800Ch4D0aC58qxnP60bRmCL+9euDH1tZn7dW8BgqVo6gilYGnHtfGrdSFzzZF+w3T
	 YoCxACJHdqSjeJ4uyWsy38HG8b2yROMCk3Wk/44rOnd+DKeNgXf69VDuDv1Mw41Qm3
	 ydBZbFVHDKmQQdtuod0CVXVRQZgfDBVceHKgIvfxtpGor0S/vS0C6oK8apDSkj/Q07
	 W6KHh5QCtpOYA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 10 Jul 2025 13:25:26 -0700
Subject: [PATCH] riscv: Only allow LTO with CMODEL_MEDANY
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org>
X-B4-Tracking: v=1; b=H4sIALUhcGgC/x3MTQqEMAxA4atI1gZaoYheRVz0J84EtEpSRBHvP
 mXgbb7Ne0BJmBTG5gGhk5X3XGHbBuLX5w8hp2roTOdMbw0KazxRSItwLLiWHWsbJZ9vXGzoU3J
 xCMFDXRxCC1///TS/7w8UBY/6bgAAAA==
X-Change-ID: 20250710-riscv-restrict-lto-to-medany-f1b7dd5c9bba
To: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=nathan@kernel.org;
 h=from:subject:message-id; bh=P7zxnegUb85mA+6We1f5qwe9gxYERpxjlx3DtZfguCA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBkFinvFdQXcOyVYGBbwrDGPu3pHf842lsbawhssml7F1
 uX/70V1lLIwiHExyIopslQ/Vj1uaDjnLOONU5Ng5rAygQxh4OIUgIm8Fmb4H5O99uTxLbNfv1xd
 9LcnXNImkOfzJ2HrGDflFT2v88NduBkZmv9M5f5x74Jot33wwuXb8h55fn3NLnFWMjtOb1bCr3m
 JzAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_CMODEL_MEDLOW and CONFIG_LTO_CLANG, there is a
series of errors due to some files being unconditionally compiled with
'-mcmodel=medany', mismatching with the rest of the kernel built with
'-mcmodel=medlow':

  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 899908), and 'i32 1' from vmlinux.a(net-traces.o at 1014628)

Only allow LTO to be performed when CONFIG_CMODEL_MEDANY is enabled to
ensure there will be no code model mismatch errors. An alternative
solution would be disabling LTO for the files with a different code
model than the main kernel like some specialized areas of the kernel do
but doing that for individual files is not as sustainable than
forbidding the combination altogether.

Cc: stable@vger.kernel.org
Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506290255.KBVM83vZ-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7..4eee737a050f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -68,7 +68,7 @@ config RISCV
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	# LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
-	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
+	select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000 && CMODEL_MEDANY
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU

---
base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026
change-id: 20250710-riscv-restrict-lto-to-medany-f1b7dd5c9bba

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


