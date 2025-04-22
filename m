Return-Path: <stable+bounces-134978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48EA95BE4
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FA63AAB15
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428826B96C;
	Tue, 22 Apr 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAIXyfHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD126B95A;
	Tue, 22 Apr 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288325; cv=none; b=Q0Tg+uOUgUkj9RGrB75bZ15aUis5NPu+A0t+5bm8m+pDUQVHpPwB+WMppgQC3i5e6OMmdFRU4W1SW4JubXLIRDWe8IKBgNkN5s1JuFDvgKxiCkBXqWx0kLVIQQyueFZ7tWepW+1ELF8DLix1dtcuUuhGvgvFoAgQ1Y8o0O+qlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288325; c=relaxed/simple;
	bh=zUWHg3M5/7e6/OE5DILVPOKMNGSQopFKWdCPK6kJ/KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwwO04SlHdOtMvotpa+P5X724S5HNEUlHoGDOiqrCwrDvO5siFS9JHsWUe0DpoEv25fuBNpYDWJsPKQdFNiYbYKiRAOUpoIRBzyLxhvRsCYOVdHjSMklsDD6jxeNcsWH5zwCf21s7GRukmHOmv7HqSFByiFw4p6QynpFWsjY3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAIXyfHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0040C4CEE4;
	Tue, 22 Apr 2025 02:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288325;
	bh=zUWHg3M5/7e6/OE5DILVPOKMNGSQopFKWdCPK6kJ/KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAIXyfHENv7TwoC16YbjkPMa3byko9nGINIVU9CaqcU1zH3+X97N+rs5CKny1E4W1
	 lb/0fPmqobTgwgM2CI3gm7jxtTC+fQuOcffxYaVV+PltMRT2yordUVfCuU2rYWacd/
	 xljs5c4wA+JODjatoWUlnkMibVY0tN3S8dGxxF//YuXSaYHQqdvE74X59puKJ/s3B0
	 VoloaKn+BppzPLL2J0tftgD6QrXp5ybe9L/1AbISjInqJ/q99S0Kw15wK9QjJivFgO
	 d3uy3rKNSXo9Muoz08iMiRGmElfnxZprfiR/OzNfVp7/YyE7B3DFYAYzcsxKqjXp2q
	 ob11qhKfvGrww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/12] riscv: Avoid fortify warning in syscall_get_arguments()
Date: Mon, 21 Apr 2025 22:18:25 -0400
Message-Id: <20250422021826.1941778-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021826.1941778-1-sashal@kernel.org>
References: <20250422021826.1941778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 1413708f990cb7d025affd706ba9c23e2bfc1a27 ]

When building with CONFIG_FORTIFY_SOURCE=y and W=1, there is a warning
because of the memcpy() in syscall_get_arguments():

  In file included from include/linux/string.h:392,
                   from include/linux/bitmap.h:13,
                   from include/linux/cpumask.h:12,
                   from arch/riscv/include/asm/processor.h:55,
                   from include/linux/sched.h:13,
                   from kernel/ptrace.c:13:
  In function 'fortify_memcpy_chk',
      inlined from 'syscall_get_arguments.isra' at arch/riscv/include/asm/syscall.h:66:2:
  include/linux/fortify-string.h:580:25: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
    580 |                         __read_overflow2_field(q_size_field, size);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

The fortified memcpy() routine enforces that the source is not overread
and the destination is not overwritten if the size of either field and
the size of the copy are known at compile time. The memcpy() in
syscall_get_arguments() intentionally overreads from a1 to a5 in
'struct pt_regs' but this is bigger than the size of a1.

Normally, this could be solved by wrapping a1 through a5 with
struct_group() but there was already a struct_group() applied to these
members in commit bba547810c66 ("riscv: tracing: Fix
__write_overflow_field in ftrace_partial_regs()").

Just avoid memcpy() altogether and write the copying of args from regs
manually, which clears up the warning at the expense of three extra
lines of code.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Dmitry V. Levin <ldv@strace.io>
Link: https://lore.kernel.org/r/20250409-riscv-avoid-fortify-warning-syscall_get_arguments-v1-1-7853436d4755@kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/syscall.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 384a63b86420b..8426c4510d31e 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -61,8 +61,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 	args[0] = regs->orig_a0;
-	args++;
-	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
+	args[1] = regs->a1;
+	args[2] = regs->a2;
+	args[3] = regs->a3;
+	args[4] = regs->a4;
+	args[5] = regs->a5;
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
-- 
2.39.5


