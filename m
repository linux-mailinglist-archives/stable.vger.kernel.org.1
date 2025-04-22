Return-Path: <stable+bounces-134948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B16A95B89
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43525188262D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670325F780;
	Tue, 22 Apr 2025 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEGIViSF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404725E47D;
	Tue, 22 Apr 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288258; cv=none; b=pN3Ru/ck2uiuSggQ7PvmY0SK07fxquseXi4vvqnXet9/D64kHblS8rguaXOkBGgqkq6JszeA4mphsMDTywk8FmwmDp+rYBprX0/kLhAba5Ft/NRhNrSzsKudC0bPYRLkx7iBPQ3OUmdQD60hojfnpe57RuY8SWS9vIynfd0Eu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288258; c=relaxed/simple;
	bh=q/f9f0tVSdoiT/mcDWBVx7/ZzrlTcfC7wdM9rl9lXuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUROXDM0eoqBN4GHgIlhHq9xOp4l00N/j548+MG4OEjTuSPlvlRGbLQ32Ah5xkSyVcMmUSUi1zLwFmV8hUDNqup6Ju7PiojFyJ7wt/NIj2geHin7Mf4qddAyGfTR5JV/7pfpQn2XMy/Nlqe9MPwzPLa2/ejnh+AnaIgNkcz604c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEGIViSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595FDC4CEE4;
	Tue, 22 Apr 2025 02:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288257;
	bh=q/f9f0tVSdoiT/mcDWBVx7/ZzrlTcfC7wdM9rl9lXuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEGIViSFlV6KeLoyNBBxl4Cc+WAGclVHKi9Wdr/2dynITgMvGgtHCWmpow8sq9gGs
	 932rBk2Z4k3RImZhXxxZYLI9RkW/WPy2vEHnPHc4Ylod3rL/rAUaY7dTOc5Mjt5S9y
	 YJ+PVNrhUBkicaPEGZQWtv8dCSbsZ9f+U8YjAq6kO4rnDt591mxnqalJc65OJFVg0d
	 4TAWvYDZUHvXpxT6ZRGWrS23wtIOPTrbAalPdZgBpNvnJKnSMzfrV0BZHQoHNPZLy3
	 RJsgxy5nZSDl2wc+yshosbCPAA0jJMSSr/U7ChUY1ivPjnOMoyVwJlKPcRoZmzQxej
	 TZxyntWZOMn9g==
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
Subject: [PATCH AUTOSEL 6.12 20/23] riscv: Avoid fortify warning in syscall_get_arguments()
Date: Mon, 21 Apr 2025 22:17:00 -0400
Message-Id: <20250422021703.1941244-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
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
index 121fff429dce6..eceabf59ae482 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -62,8 +62,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
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


