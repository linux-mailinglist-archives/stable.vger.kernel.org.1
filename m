Return-Path: <stable+bounces-46550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401B08D0864
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A29B2DC7C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC3016728F;
	Mon, 27 May 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0/X+WWI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786A167299;
	Mon, 27 May 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825507; cv=none; b=uxnZdhYa70OMDFosD4NlLExpH3rGgDCJLCKSIxkHQI6H8g6/LbEGnT7yoyz1P+2KiEuFaoJ/eDSdLFicxXbPUCtSG+dCRkTrYwqpHVJHjUG8RFo52FZSXRo1QevhG2UrWUBUbnETcfWLdgF3CQ2tp/qtG5MvfX45br79/gx61V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825507; c=relaxed/simple;
	bh=eYPbWO+J/KyuX3TfC231czK2CmnPahyBLfsU/aZGuxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0d5y5pagL6mNAOpBR9CQ3gdmEIZcJlWRTxbPDc3mxROSeK1iywjDOkUSXMM66FTRy1qu3bUO06x/yVdwvf62KmGbzUHq74ljJjD+IlGPMkgfS9AVfvCR33Xo0s/itZ81d/K5AdY78BNlY4H50yoeosRQvHIAzdRFdxzvyCyouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0/X+WWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46E6C32781;
	Mon, 27 May 2024 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825507;
	bh=eYPbWO+J/KyuX3TfC231czK2CmnPahyBLfsU/aZGuxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0/X+WWIrCXVnngvQbOAa4muBvjPtGrpJRyED0rU86SdwoUd7O3huEuDzmgz4gv03
	 aWiTI8ClKKBRsON21QnZv8pnRTk2Bf6K+ABZ/guhigAveIW8T5/d/cUcALG9Deba/I
	 oseulT7r8ergiVIE/w1QZk4Gs3bPv4TSSc/l582pcG4PwHs0iLok4V3ZVDiogvf8tQ
	 uk647R0JY43Q9KriU4bLp9Ktzkz6DC+qab3i/j8CbJU8DWSYKzD0qrp4uE/EWzNKRP
	 e9SQ7SqGrDKuKUhz9ZGicOf72c81AVSAuaRPgawKkEBvfWtQ8qKKuPUvO8FSUdo2HF
	 K83ltMgESSwLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	vaibhav@linux.ibm.com,
	amachhiw@linux.vnet.ibm.com,
	sshegde@linux.ibm.com,
	jniethe5@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 5/6] powerpc/pseries: Enforce hcall result buffer validity and size
Date: Mon, 27 May 2024 11:57:55 -0400
Message-ID: <20240527155808.3866107-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155808.3866107-1-sashal@kernel.org>
References: <20240527155808.3866107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit ff2e185cf73df480ec69675936c4ee75a445c3e4 ]

plpar_hcall(), plpar_hcall9(), and related functions expect callers to
provide valid result buffers of certain minimum size. Currently this
is communicated only through comments in the code and the compiler has
no idea.

For example, if I write a bug like this:

  long retbuf[PLPAR_HCALL_BUFSIZE]; // should be PLPAR_HCALL9_BUFSIZE
  plpar_hcall9(H_ALLOCATE_VAS_WINDOW, retbuf, ...);

This compiles with no diagnostics emitted, but likely results in stack
corruption at runtime when plpar_hcall9() stores results past the end
of the array. (To be clear this is a contrived example and I have not
found a real instance yet.)

To make this class of error less likely, we can use explicitly-sized
array parameters instead of pointers in the declarations for the hcall
APIs. When compiled with -Warray-bounds[1], the code above now
provokes a diagnostic like this:

error: array argument is too small;
is of size 32, callee requires at least 72 [-Werror,-Warray-bounds]
   60 |                 plpar_hcall9(H_ALLOCATE_VAS_WINDOW, retbuf,
      |                 ^                                   ~~~~~~

[1] Enabled for LLVM builds but not GCC for now. See commit
    0da6e5fd6c37 ("gcc: disable '-Warray-bounds' for gcc-13 too") and
    related changes.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240408-pseries-hvcall-retbuf-v1-1-ebc73d7253cf@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/hvcall.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 9bcf345cb208b..0e9d8a5eeb2dc 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -472,7 +472,7 @@ long plpar_hcall_norets_notrace(unsigned long opcode, ...);
  * Used for all but the craziest of phyp interfaces (see plpar_hcall9)
  */
 #define PLPAR_HCALL_BUFSIZE 4
-long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall_raw: - Make a hypervisor call without calculating hcall stats
@@ -486,7 +486,7 @@ long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
  * plpar_hcall, but plpar_hcall_raw works in real mode and does not
  * calculate hypervisor call statistics.
  */
-long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
@@ -497,8 +497,8 @@ long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
  * PLPAR_HCALL9_BUFSIZE to size the return argument buffer.
  */
 #define PLPAR_HCALL9_BUFSIZE 9
-long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
-long plpar_hcall9_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall9(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL9_BUFSIZE], ...);
+long plpar_hcall9_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL9_BUFSIZE], ...);
 
 struct hvcall_mpp_data {
 	unsigned long entitled_mem;
-- 
2.43.0


