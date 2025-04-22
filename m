Return-Path: <stable+bounces-134922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F238A95B38
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5034A3AD5B1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA611A5B9E;
	Tue, 22 Apr 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwJKUg27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64A253B65;
	Tue, 22 Apr 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288194; cv=none; b=EgMG9v+CgJONCkdSDiXg05ycY79hSP0RSX3jdF/l+0kZBXUG4x5TWbnDVNgWfxmMC6TJWQRKp+pD4smgkhaMJYFbGlMXg5joVm2w5zTmqsLd+ItyHzFZpYYw7Sgw0WKni3ZKolCCj4kRaQP939kM5p8MidWFnstoTsGE8fQ+VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288194; c=relaxed/simple;
	bh=q/f9f0tVSdoiT/mcDWBVx7/ZzrlTcfC7wdM9rl9lXuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0sYzPHwDlY/AT2ZZSG5HIQMD+HV9iITLVlQIj8yKim4OescXVknMel96raO4elqC98/6xUjjdn8FrsjyaAqM5f9zDc1UAUkAGdkbia4vnd2Owr1vByl7kdvBwbCsBKxPrmi0zMK2Iys5LzYynjm6cumwONdnqYfrJOzHVs+3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwJKUg27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA42BC4CEE4;
	Tue, 22 Apr 2025 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288194;
	bh=q/f9f0tVSdoiT/mcDWBVx7/ZzrlTcfC7wdM9rl9lXuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwJKUg27bPZEpdp0j1oY1xDL1d8aXWOXXRi7oArVf6hQ5UjtsYYbm0fEicCyeehXx
	 4V0Whgn+Q77QdC1QEDYpF07l3ogb/lM4UZGSC9y0PeT5gfKbF3MXcLKv8zj7kW3OJc
	 KoZpY55DScpVIXtfUKx575oBAaKa/JDn2ZDn31n+MGtLA0R6bip7OQ6J8ooIiY7KgA
	 9t8kWthyi+clnJtiWEzBja7/K9fnGxoX8+diDqAB4c0H3oJ8PphrsiL1CtJqB6Vumv
	 mFHesrRyPWEXCcGvzpcH6MdEO5JON8AHVUQTePYT4YVDl3A0a53x9xjOT2INQJ/U9V
	 KLf2sASQzvkFw==
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
Subject: [PATCH AUTOSEL 6.14 24/30] riscv: Avoid fortify warning in syscall_get_arguments()
Date: Mon, 21 Apr 2025 22:15:44 -0400
Message-Id: <20250422021550.1940809-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
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


