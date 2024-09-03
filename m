Return-Path: <stable+bounces-72907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1144296A92B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DAD283F10
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21011205E2E;
	Tue,  3 Sep 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGqAOZWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD451E4903;
	Tue,  3 Sep 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396347; cv=none; b=VhwTdUwBj4D7QhFsmtit2gbgql3N1FnWfPsIH+kjsEjItEP9kZiFos8CStsvbp9aGVmJs/3P90w8Stin3lQMohX7ABjYAVspCTRmrwYnQjpyRgnDZobG6jz6wvsH7h5YzOqrfUtfCTCq+ikcFPsrY4d5qQzJ3+4oSMRgzPIwwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396347; c=relaxed/simple;
	bh=xTPZ7PYuVdWpNG1mNPzohvAPpXevJQ2JRBXnJW4/ff4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfRykz/87S0hnaSR6ORiwm9Llx/DYos4Zeo6xspAJXJpestDo/JzOjFx1NnQ9QmgbWKqf20Wbj5cYIabcS30kaYTS74lIYTFc+wKw0PmEgm0tyy3uT8kYUQny95j4GkH3M19/btzQv20vaGJJCUPZ48MD1hnErhVt9upvX0gJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGqAOZWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295DC4CEC5;
	Tue,  3 Sep 2024 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396347;
	bh=xTPZ7PYuVdWpNG1mNPzohvAPpXevJQ2JRBXnJW4/ff4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGqAOZWOnH3jW9KiitfrodEUM+75rmNSveqIVyHvRltAVLuzNZHlCrIumOkIKVTnM
	 KqYxz2Z3TW/zx6zrqTrREyTpovcUEiyuSLc8KfcTi8Bcj01XZshHwoHibXl+gdc+D8
	 2UgSr20zoypbKbnF5TifeFocUyqncBqwsfEUBHVs0mfwRe+PpDbrA09m0FBadpf7AC
	 TdgJJ9FwVkJ/OejIMQdsUL85TojWz0/fRV6GilwqNFVmwa6eXz9fijbjgYRJT9wr7d
	 7QLfKuOmkLKS0juLJbNwctduranxmAzb4n33BE1YBLVxDtx0mTmqcc/C9/7shsgf8A
	 gZ0RbC860J1qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	maobibo@loongson.cn,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 11/17] LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE
Date: Tue,  3 Sep 2024 15:25:25 -0400
Message-ID: <20240903192600.1108046-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 274ea3563e5ab9f468c15bfb9d2492803a66d9be ]

Currently we call irq_set_noprobe() in a loop for all IRQs, but indeed
it only works for IRQs below NR_IRQS_LEGACY because at init_IRQ() only
legacy interrupts have been allocated.

Instead, we can define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE in asm/hwirq.h
and the core will automatically set the flag for all interrupts.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/hw_irq.h | 2 ++
 arch/loongarch/kernel/irq.c         | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd858..8156ffb674159 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,8 @@
 
 extern atomic_t irq_err_count;
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOPROBE
+
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 0524bf1169b74..4496649c9e68b 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -122,9 +122,6 @@ void __init init_IRQ(void)
 		panic("IPI IRQ request failed\n");
 #endif
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_set_noprobe(i);
-
 	for_each_possible_cpu(i) {
 		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, order);
 
-- 
2.43.0


