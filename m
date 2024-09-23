Return-Path: <stable+bounces-76361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4897A161
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F30B1C215D2
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69D15689A;
	Mon, 16 Sep 2024 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIBk1hBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB0314AD19;
	Mon, 16 Sep 2024 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488373; cv=none; b=Ck7Ay/SgvCZpR1Aew917rtJDOc4znc13z2VqOguWKasHZQmXxSLlHOCXQm79cYv+wsnLPt7bZCN2iYBt461YVNtstgKXi47UnxBYQORs/bM+qTi0r+reN+LUdapy4zlwM18SmROi+RvABO5vm9voAU43j/Iw2s5opIfLPbAL0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488373; c=relaxed/simple;
	bh=tcU+PKAaeQrSh2Rdnr/zfOpK2j5/PQjB6lGgTeWxi7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBMAAqMzrIn2ahzSibhTg4YHEJLn/9Cok+a0tQMUjEa5Vyqp1D+fkLUlD67TFCsIEiARf8MXEDIJEldHtJAf3d0k7WRFX6W4A/oY5nBeUkwYiWWBeE2xRD+UDHnNYzeKLicRikfXfQ8+6+rhgDHBjcVx98aXV4nzN2Ckst769oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIBk1hBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C764BC4CEC4;
	Mon, 16 Sep 2024 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488373;
	bh=tcU+PKAaeQrSh2Rdnr/zfOpK2j5/PQjB6lGgTeWxi7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIBk1hBItuWQy3iLS1+Do4cEsuRg+YGsZ5FH8uEM1INTQbbuJFGiCrK/bIjLpMEDN
	 DnmOAHL3jcUMSwqf13QOHxdHa6CbuxH6fOPJezhBYzipKGj0pscTK4z59L6Btf2Tix
	 nC5mD+kDeLjaX7r+nWu9xQHKY9OPLX50U9+Z3hcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 090/121] riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF
Date: Mon, 16 Sep 2024 13:44:24 +0200
Message-ID: <20240916114232.120682646@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
References: <20240916114228.914815055@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit 7c1e5b9690b0e14acead4ff98d8a6c40f2dff54b ]

The icache will be flushed in switch_to() if force_icache_flush is true,
or in flush_icache_deferred() if icache_stale_mask is set. Between
setting force_icache_flush to false and calculating the new
icache_stale_mask, preemption needs to be disabled. There are two
reasons for this:

1. If CPU migration happens between force_icache_flush = false, and the
   icache_stale_mask is set, an icache flush will not be emitted.
2. smp_processor_id() is used in set_icache_stale_mask() to mark the
   current CPU as not needing another flush since a flush will have
   happened either by userspace or by the kernel when performing the
   migration. smp_processor_id() is currently called twice with preemption
   enabled which causes a race condition. It allows
   icache_stale_mask to be populated with inconsistent CPU ids.

Resolve these two issues by setting the icache_stale_mask before setting
force_icache_flush to false, and using get_cpu()/put_cpu() to obtain the
smp_processor_id().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6b9391b581fd ("riscv: Include riscv_set_icache_flush_ctx prctl")
Link: https://lore.kernel.org/r/20240903-fix_fencei_optimization-v2-1-8025f20171fc@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/cacheflush.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index a03c994eed3b..b81672729887 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -158,6 +158,7 @@ void __init riscv_init_cbo_blocksizes(void)
 #ifdef CONFIG_SMP
 static void set_icache_stale_mask(void)
 {
+	int cpu = get_cpu();
 	cpumask_t *mask;
 	bool stale_cpu;
 
@@ -168,10 +169,11 @@ static void set_icache_stale_mask(void)
 	 * concurrently on different harts.
 	 */
 	mask = &current->mm->context.icache_stale_mask;
-	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
+	stale_cpu = cpumask_test_cpu(cpu, mask);
 
 	cpumask_setall(mask);
-	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
+	cpumask_assign_cpu(cpu, mask, stale_cpu);
+	put_cpu();
 }
 #endif
 
@@ -239,14 +241,12 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 	case PR_RISCV_CTX_SW_FENCEI_OFF:
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
-			current->mm->context.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->mm->context.force_icache_flush = false;
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
-			current->thread.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->thread.force_icache_flush = false;
 			break;
 		default:
 			return -EINVAL;
-- 
2.43.0




