Return-Path: <stable+bounces-72889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F5E96A8FC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9920B2427D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920501E2015;
	Tue,  3 Sep 2024 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fABitcoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3721E2007;
	Tue,  3 Sep 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396258; cv=none; b=plcgTVPZjpT5hm/iVQiFLSwjkod3byq0RIdf7ZxEt4fTYl4hPLTPTXpqn78+RSwGOFXoBIt8OHB2Jt3vDJ4D0/OMpK0YXVdJpjz+F4t3CESbtq+10NCn/mLq606F2evaQ5VcNTAnoYwhe6SvvmPa5zIFwO7UV7T13PPMxrY/eLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396258; c=relaxed/simple;
	bh=ky9ftaUxkSesozZKWnlXMOrWN1O1XEkEhRKllSxMpj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHNTGDHJFXoPDU+Yo5hR5EJ6Ofjb6yLZISzxqjCRJVsN5vkh9AoDQ8tyii4Lu4WjE406dOOdKxyRB3oJF78GLpnKgBPGqDf7wc5dOu3cPCpQsfe5rvI48OhEQuBOgeIKv/5grYYzXFN7lj/ThCnZ2ral391PdjcG92VIYvazQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fABitcoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705FBC4CEC4;
	Tue,  3 Sep 2024 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396257;
	bh=ky9ftaUxkSesozZKWnlXMOrWN1O1XEkEhRKllSxMpj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fABitcoNKh+idsKjzOCff5aWs29fvyjX0Bhz25gtxfeVkyu3oa+dfZh3mP1xlYHLL
	 Aag390qTTPxdCkR0mgQKL9s95D7KVnnHp4Gju/2jfAWxp0kJMBzRLOhu4M3nEBkH9c
	 VAB2dA/eqk/XhphcRF99aPxvmnoqMlyvh8nJzCzHOKXgI3OP8fL3KcKObVME9y9pRo
	 mw0Xagc/Ve7Ca/TC+Eq/C4m/zcRkiDiRH/l6mRVPtwhFCMU/8zOeHUKJhORoUWgzc1
	 GtWGAtbs0GVJZHlioLk1jaeb+SZDoKkWPHCQ0SoxWGw+s4ZZpz8QDvBOGqvN5ybkMY
	 ACIatyJ3EN8Fw==
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
Subject: [PATCH AUTOSEL 6.6 13/20] LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE
Date: Tue,  3 Sep 2024 15:23:45 -0400
Message-ID: <20240903192425.1107562-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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
index 883e5066ae445..df42c063f6c43 100644
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


