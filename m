Return-Path: <stable+bounces-208309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D6D1BE5C
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 02:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 476DE3039ADC
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 01:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF924466D;
	Wed, 14 Jan 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WdjNfmC7"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8223E320;
	Wed, 14 Jan 2026 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353562; cv=none; b=kjkCpKTy2GuOGAi+1mkfmlwJlbLrjPI5gwlEwwMVvgXJ1wKtWDvYQRd3jAtKEFQ7I3iF2b0MyanvlZ+Bip+D1rUNDlifZ6IbawHJviYaX8HVYCIyPxHOOHUV6xLW5csto2maH4ZUABy/iFzvO2/BjdTifUBFOA4zS9r3/erBjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353562; c=relaxed/simple;
	bh=a6ZsLShSQVWoAv02UvhXHeaWA6BCLaMaR1drAdYEGbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Jkq/K12jn6aOHhp787cdIyCkETs7MnOVR8PzuCuEmQnNxcrUtcT1sdvd/6ZLjXhVMdEB3/+LlLPqyewo45GKcc3llur3XbJppMCqdYmUQWdnAPQY2JGLGL/zcSOuocjqf0IyC81ARwxdUtOJpt8wvpAOaVZe5BQPf3YJN16erj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WdjNfmC7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=JWETGwEcfHV8y65+VA3wq2t462nUh5xKvgddbS69HlI=;
	b=WdjNfmC7nIK0l8eOWhGDbJjON9+NLFvOnVGRMlQWze7iAFg+F2V34EdrxoH31P
	lipwQMj94vzjgH0WJfPPTuNd+m8N+yZ5dFp4/ejAynccRzgA5AnMxP8V40GKdSuK
	YqzxST/IA3TwJBg/jljEWUlXhxHF03BD1tuWETNXftdhE=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDn71ns7mZpiuzOGg--.18817S2;
	Wed, 14 Jan 2026 09:18:37 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.6] riscv: uprobes: Add missing fence.i after building the XOL buffer
Date: Wed, 14 Jan 2026 09:18:30 +0800
Message-Id: <20260114011830.2045424-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn71ns7mZpiuzOGg--.18817S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWfCrW3KrW5CrWxKryxuFg_yoW8ZF1kpF
	4Fkw4ftr4rXa45G347JrZ5uw1Sv34vqr42v3y3J3yrZwsFqr47uwsagw48Xr1YyrZ09rWY
	v3WqkryDKayDA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM1vV9UUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3Q7qhGlm7u4vfgAA3j

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 7d1d19a11cfbfd8bae1d89cc010b2cc397cd0c48 ]

The XOL (execute out-of-line) buffer is used to single-step the
replaced instruction(s) for uprobes. The RISC-V port was missing a
proper fence.i (i$ flushing) after constructing the XOL buffer, which
can result in incorrect execution of stale/broken instructions.

This was found running the BPF selftests "test_progs:
uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
uprobes tests randomly blew up.

Reviewed-by: Guo Ren <guoren@kernel.org>
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20250419111402.1660267-2-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 arch/riscv/kernel/probes/uprobes.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..cc15f7ca6cc1 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -167,6 +167,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	/* Initialize the slot */
 	void *kaddr = kmap_atomic(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+	unsigned long start = (unsigned long)dst;
 
 	memcpy(dst, src, len);
 
@@ -176,13 +177,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
 	}
 
+	flush_icache_range(start, start + len);
 	kunmap_atomic(kaddr);
-
-	/*
-	 * We probably need flush_icache_user_page() but it needs vma.
-	 * This should work on most of architectures by default. If
-	 * architecture needs to do something different it can define
-	 * its own version of the function.
-	 */
-	flush_dcache_page(page);
 }
-- 
2.34.1


