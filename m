Return-Path: <stable+bounces-49433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694EE8FED3C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EDB1F20FEF
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371819D084;
	Thu,  6 Jun 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="puo6qQp+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C841974EB;
	Thu,  6 Jun 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683463; cv=none; b=r/b03FNlHDRd3MclH3Pa2FoIy9Ql9dQl5W8KrOoaevWO+2nLFO+2/+8Qa8aSNh9XPDYg0qntEyE0fF5S78t6R0TO+uiWIQkLHBJ1Xc7Ge/PnhHR/pJNhp59AhVuZtoLEYtpnUruC0Jbm3PtyVUurrPc7Gj7ekQYmDp+M/AcmIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683463; c=relaxed/simple;
	bh=vP3lJ1fJuyRdU8P9dkCA/9+49RB1wjvZ0/hmKRA0vek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDRqEG2lCqSViOMOIJOEt61h2zR7qH8oN9UI5QIjSlg8fYw00g8oIZst3t0eW0ETiTfY/5XrAeJiVf19qM+J4vdR8JRPekvt0HSpZZ327q+c/+ioA2wyd5NW9RCGhTrhTGQtYDalnkzC7R8afs4ywqM6Yt8NZ8YZrnx2X+8jGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=puo6qQp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7DAC32781;
	Thu,  6 Jun 2024 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683463;
	bh=vP3lJ1fJuyRdU8P9dkCA/9+49RB1wjvZ0/hmKRA0vek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puo6qQp+9mwftTmrH99P+gSxPyBZSJ7pAyVkSm2FUsO9l0UGoc1eKCWBC6R4USO+a
	 dQbhXdPUqnyPGG0cy4cUXsF/rFquXDNkMAPrk+HiirHQhSxiuvv/IdNS6gCWnEOE1l
	 IG6tWxLzBIsUbKGBkUPW2ws4t2qaVe8sT1o50F+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 350/473] LoongArch: Fix callchain parse error with kernel tracepoint events again
Date: Thu,  6 Jun 2024 16:04:39 +0200
Message-ID: <20240606131711.483439370@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit d6af2c76399f98444a5b4de96baf4b362d9f102b ]

With commit d3119bc985fb645 ("LoongArch: Fix callchain parse error with
kernel tracepoint events"), perf can parse kernel callchain, but not
complete and sometimes maybe error. The reason is LoongArch's unwinders
(guess, prologue and orc) don't really need fp (i.e., regs[22]), and
they use sp (i.e., regs[3]) as the frame address rather than the current
stack pointer.

Fix that by removing the assignment of regs[22], and instead assign the
__builtin_frame_address(0) to regs[3].

Without fix:

  Children      Self  Command        Shared Object      Symbol
  ........  ........  .............  .................  ................
  33.91%    33.91%    swapper        [kernel.vmlinux]   [k] __schedule
            |
            |--33.04%--__schedule
            |
             --0.87%--__arch_cpu_idle
                       __schedule

With this fix:

  Children      Self  Command        Shared Object      Symbol
  ........  ........  .............  .................  ................
  31.16%    31.16%    swapper        [kernel.vmlinux]   [k] __schedule
            |
            |--20.63%--smpboot_entry
            |          cpu_startup_entry
            |          schedule_idle
            |          __schedule
            |
             --10.53%--start_kernel
                       cpu_startup_entry
                       schedule_idle
                       __schedule

Fixes: d3119bc985fb645 ("LoongArch: Fix callchain parse error with kernel tracepoint events")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/perf_event.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/perf_event.h b/arch/loongarch/include/asm/perf_event.h
index 52b638059e40b..f948a0676daf8 100644
--- a/arch/loongarch/include/asm/perf_event.h
+++ b/arch/loongarch/include/asm/perf_event.h
@@ -13,8 +13,7 @@
 
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->csr_era = (__ip); \
-	(regs)->regs[3] = current_stack_pointer; \
-	(regs)->regs[22] = (unsigned long) __builtin_frame_address(0); \
+	(regs)->regs[3] = (unsigned long) __builtin_frame_address(0); \
 }
 
 #endif /* __LOONGARCH_PERF_EVENT_H__ */
-- 
2.43.0




