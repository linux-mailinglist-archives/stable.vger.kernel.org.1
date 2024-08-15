Return-Path: <stable+bounces-68122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D59530BC
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2890F287C14
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBF1714D9;
	Thu, 15 Aug 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpZ3pjun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D144376;
	Thu, 15 Aug 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729563; cv=none; b=gZnRpRpExIbwdEQcpVIEa84YSLUxscRtCiGUrhld7GKLKTLi+KaQVXbedVfPTG0RHqI0yTsowpta2fSaDE6SoruSUOZHFYSpncFLwx53+Wz+jhXX+LGmdYXfCya3tvIPbDB6UmatXfVunFJEY0VNMXdbgJSyGZUvdHW2zaFGnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729563; c=relaxed/simple;
	bh=zHMZZQbRpFeOyktIXZvA4ZGNBpkfFLtCQUpa3pizDc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlHpoG6hiBEsnhI1VH2tEN+eOuBKPnRL0R2TBfgUswAadq6//a4x+lH+7gpnTEvC1D0MN7PiwPHVa7lqKVZnxMXiiIaZraC+TyN/0KpX1fmGQXarNMcLsnKydJvkYiPog0pIpbNc1/DyQ2cCS8x0ZAuLsjLOj4PSPUFtlMEuDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpZ3pjun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF99C4AF0C;
	Thu, 15 Aug 2024 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729563;
	bh=zHMZZQbRpFeOyktIXZvA4ZGNBpkfFLtCQUpa3pizDc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpZ3pjunqnwF5K0u50ua3onUoiILjudw2ejlNkVwcoYSLM3s+u2E+1GP+6Asxv2Lt
	 AqDB58F4p9VdSvOZ/RMGc9PcVWCfbwOuWebeaX8kOAjY8fvjmZBzOgE8fIzTauC2fk
	 RyMWGmUYrsF9qpUbDbY/fIIS/Jds7u5oEyiep+YM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 138/484] powerpc/xmon: Fix disassembly CPU feature checks
Date: Thu, 15 Aug 2024 15:19:56 +0200
Message-ID: <20240815131946.738243751@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 14196e47c5ffe32af7ed5a51c9e421c5ea5bccce ]

In the xmon disassembly code there are several CPU feature checks to
determine what dialects should be passed to the disassembler. The
dialect controls which instructions the disassembler will recognise.

Unfortunately the checks are incorrect, because instead of passing a
single CPU feature they are passing a mask of feature bits.

For example the code:

  if (cpu_has_feature(CPU_FTRS_POWER5))
      dialect |= PPC_OPCODE_POWER5;

Is trying to check if the system is running on a Power5 CPU. But
CPU_FTRS_POWER5 is a mask of *all* the feature bits that are enabled on
a Power5.

In practice the test will always return true for any 64-bit CPU, because
at least one bit in the mask will be present in the CPU_FTRS_ALWAYS
mask.

Similarly for all the other checks against CPU_FTRS_xx masks.

Rather than trying to match the disassembly behaviour exactly to the
current CPU, just differentiate between 32-bit and 64-bit, and Altivec,
VSX and HTM.

That will cause some instructions to be shown in disassembly even
on a CPU that doesn't support them, but that's OK, objdump -d output
has the same behaviour, and if anything it's less confusing than some
instructions not being disassembled.

Fixes: 897f112bb42e ("[POWERPC] Import updated version of ppc disassembly code for xmon")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240509121248.270878-2-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/ppc-dis.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 75fa98221d485..af105e1bc3fca 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -122,32 +122,21 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
   bool insn_is_short;
   ppc_cpu_t dialect;
 
-  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON
-            | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
+  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON;
 
-  if (cpu_has_feature(CPU_FTRS_POWER5))
-    dialect |= PPC_OPCODE_POWER5;
+  if (IS_ENABLED(CONFIG_PPC64))
+    dialect |= PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_CELL |
+	PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 |
+	PPC_OPCODE_POWER9;
 
-  if (cpu_has_feature(CPU_FTRS_CELL))
-    dialect |= (PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC);
+  if (cpu_has_feature(CPU_FTR_TM))
+    dialect |= PPC_OPCODE_HTM;
 
-  if (cpu_has_feature(CPU_FTRS_POWER6))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC);
+  if (cpu_has_feature(CPU_FTR_ALTIVEC))
+    dialect |= PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2;
 
-  if (cpu_has_feature(CPU_FTRS_POWER7))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-                | PPC_OPCODE_ALTIVEC | PPC_OPCODE_VSX);
-
-  if (cpu_has_feature(CPU_FTRS_POWER8))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-		| PPC_OPCODE_POWER8 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_VSX);
-
-  if (cpu_has_feature(CPU_FTRS_POWER9))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
+  if (cpu_has_feature(CPU_FTR_VSX))
+    dialect |= PPC_OPCODE_VSX | PPC_OPCODE_VSX3;
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
-- 
2.43.0




