Return-Path: <stable+bounces-128726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC651A7EB12
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5E6188834A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3521ADDE;
	Mon,  7 Apr 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mILM1JuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78B210184;
	Mon,  7 Apr 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049803; cv=none; b=CiVAo9ZSG7OzrYt39OuHu6VB2GCWefm+ykkgqV37Vh/pklDP5vWGS0BQxa203TzIQjaRxd5cAZmSpBJb+yLoFt4QHrEFqvIQdgzFi/XVIKNWJMQOc9EYWB0oo4ifaRWY1lVJv1yKiSb+eOf9vxu756bFnOgCqpO8xii9DaJShKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049803; c=relaxed/simple;
	bh=QjTZVZpLSS+0ELNf070SsOOXNr9BdGZ36boybxSz8d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoFV3VfGg1RNSxG+xk/97rE8I4jkJRLcoufeiZn36ubteK1jaZvHhwZUAfWkErSRNW87nejlsFw6211AgLjN4wCtbrAGQsdIUfm9LDR+/ki1XMFvluREDdGhm/j9bscVA+3OwfbJbuYVHxz98qcMXjW28intcOnK2s5Yv49vi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mILM1JuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53D5C4CEF5;
	Mon,  7 Apr 2025 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049802;
	bh=QjTZVZpLSS+0ELNf070SsOOXNr9BdGZ36boybxSz8d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mILM1JuRO3G8+RuzMDn/IuQVP4WtUg8FT6i7WuTFPoDtB3LiqvL8h3LGfVxHTfMC2
	 UXvVy2khev8u2L6C8A1NGpQe5DyGvHgY/NtACFOx+H3tNMwx44BIu3lPDRvSJt4sY/
	 /hsq7iRUv77V4707mGrgcdlMSJMJO2hj4egZ8uyji79k1O7Apra4InMdFl0lOzeRnr
	 mEED0qGMjf2mkrfy4VCu8Y9D2mwtkuK1dH7pq57/3qEwgofiIhjpT5ASGaNOZmL/1S
	 krRhbXV9xngdOxG02qqv4Lo/3+xpaMpZavkCqiAMl4A4E82/M9356r3X8PvdQyg10v
	 qM9ar2IYh9Uxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 2/9] riscv: tracing: Fix __write_overflow_field in ftrace_partial_regs()
Date: Mon,  7 Apr 2025 14:16:28 -0400
Message-Id: <20250407181635.3184105-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181635.3184105-1-sashal@kernel.org>
References: <20250407181635.3184105-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit bba547810c66434475d8800b3411c59ef71eafe9 ]

The size of &regs->a0 is unknown, causing the error:

../include/linux/fortify-string.h:571:25: warning: call to
'__write_overflow_field' declared with attribute warning: detected write
beyond size of field (1st parameter); maybe use struct_group()?
[-Wattribute-warning]

Fix this by wrapping the required registers in pt_regs with
struct_group() and reference the group when doing the offending
memcpy().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/ftrace.h |  2 +-
 arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c4721ce44ca47..ec6db1162021f 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 {
 	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
 
-	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
+	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
 	regs->epc = afregs->epc;
 	regs->ra = afregs->ra;
 	regs->sp = afregs->sp;
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c18..2910231977cb7 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -23,14 +23,16 @@ struct pt_regs {
 	unsigned long t2;
 	unsigned long s0;
 	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
+	struct_group(a_regs,
+		unsigned long a0;
+		unsigned long a1;
+		unsigned long a2;
+		unsigned long a3;
+		unsigned long a4;
+		unsigned long a5;
+		unsigned long a6;
+		unsigned long a7;
+	);
 	unsigned long s2;
 	unsigned long s3;
 	unsigned long s4;
-- 
2.39.5


