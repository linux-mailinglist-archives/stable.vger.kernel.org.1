Return-Path: <stable+bounces-157340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8ADAE538C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7066445402
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEB1AD3FA;
	Mon, 23 Jun 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIgfTA4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE71C84A0;
	Mon, 23 Jun 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715629; cv=none; b=FGQ6J5Aq+0jMsIvyvpst0+xt6hobwAGQJQCvi5JeNuHq06YsynI0jYShhBkhqCTyMv2ZIP7PZ2mcS6HQJBdq+LrNzn0SCyc0gTSPwOGC8B5Bq817bI5YVzWAywGTsJl/0s66AhUGqqiWb27Ym1HZJDA3S6UdSoLffNUsrfwi8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715629; c=relaxed/simple;
	bh=tmxXQcM1JjskrXYEL6IvCO2QAa4TLfFDn+/sW77sMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MORLO/OvifBEr4CpRJXPx7mg9ldSJjvOzYDoYtGkQn2wjvpMrYGRZoMDAB8f9AhaZe7yiZLWPI9Jg8TUPDNw3hUVRv/ox5guRxTa/Ye4LvLyVPPLjXkYEQESM8FM+POenoCLwyOJN3Ltn+HS01qosCxzscH8UlyUqcqhIi/VTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIgfTA4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8037EC4CEEA;
	Mon, 23 Jun 2025 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715628;
	bh=tmxXQcM1JjskrXYEL6IvCO2QAa4TLfFDn+/sW77sMkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIgfTA4RHvG1rrog3T52QdO7CWfqPIxSVB96jA9YOQW6Dsig5lIx9F2x26jO2BgBt
	 LwimQNg5i++Ig2r4OEboeNSul96q5Y8PQ9Mznq0OaTWoloIry1isvxIiNcLGaKYfml
	 EvD9pipXJ6SwzoAf+bWsGbUuCfhcvkFUsQpJVjLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yanteng Si <si.yanteng@linux.dev>,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.6 211/290] LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg
Date: Mon, 23 Jun 2025 15:07:52 +0200
Message-ID: <20250623130633.276735659@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 52c22661c79a7b6af7fad9f77200738fc6c51878 upstream.

When building kernel with LLVM there are occasionally such errors:

In file included from ./include/linux/spinlock.h:59:
In file included from ./include/linux/irqflags.h:17:
arch/loongarch/include/asm/irqflags.h:38:3: error: must not be $r0 or $r1
   38 |                 "csrxchg %[val], %[mask], %[reg]\n\t"
      |                 ^
<inline asm>:1:16: note: instantiated into assembly here
    1 |         csrxchg $a1, $ra, 0
      |                       ^

To prevent the compiler from allocating $r0 or $r1 for the "mask" of the
csrxchg instruction, the 'q' constraint must be used but Clang < 21 does
not support it. So force to use $t0 in the inline asm, in order to avoid
using $r0/$r1 while keeping the backward compatibility.

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/pull/141037
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/irqflags.h |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/loongarch/include/asm/irqflags.h
+++ b/arch/loongarch/include/asm/irqflags.h
@@ -14,40 +14,48 @@
 static inline void arch_local_irq_enable(void)
 {
 	u32 flags = CSR_CRMD_IE;
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 }
 
 static inline void arch_local_irq_disable(void)
 {
 	u32 flags = 0;
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 }
 
 static inline unsigned long arch_local_irq_save(void)
 {
 	u32 flags = 0;
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 	return flags;
 }
 
 static inline void arch_local_irq_restore(unsigned long flags)
 {
+	register u32 mask asm("t0") = CSR_CRMD_IE;
+
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
 		: [val] "+r" (flags)
-		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
 		: "memory");
 }
 



