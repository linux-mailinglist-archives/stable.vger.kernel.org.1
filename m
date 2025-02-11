Return-Path: <stable+bounces-114751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E194DA30021
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1E3A3808
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4171C1E04B5;
	Tue, 11 Feb 2025 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfObNTjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19833EA76;
	Tue, 11 Feb 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237407; cv=none; b=kap2lVyOptb4FsXRpGjdJpWYr6eHfnO9he/Tx2hNzYsgEPAcu25uBr6yWYAAQaKPFtmi6Zhy24bV9jW8kV6Rwn1pzURCRAPB5W9WUArgAWT6cD0fjymyhxQGZg+iU0i9TqstHNY+z+i5TaIv7R5Bt8InvhrHW+8B/yqqFYVcLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237407; c=relaxed/simple;
	bh=O0uRPqFkoL/37XU7UWWZV0ARYrC8R2rnUfUL+3Jfoig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgFxKgD1laARS55ZF0lkhk7bcVSX+TsGX0+w2rJUPaiVxHVK23nxUlwA1ombs2jDrOvNfA7ZiLaCV7m6CrSWIJ8AfZjjiWxYBUSCzJLD6zTtJ7J+M7pgFagJAqPy8NEcypPN/8/Vfg4XQkJ2NIpDNbeMdtZI0zhXQOer569aGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfObNTjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A653C4AF09;
	Tue, 11 Feb 2025 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237406;
	bh=O0uRPqFkoL/37XU7UWWZV0ARYrC8R2rnUfUL+3Jfoig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfObNTjq5brsNiDHvtd5SxkxhFCwqrY200exrZ1lN/eulkwG63sJMAlWP/LjITiFq
	 MHOIroSOBLNmxey3MB57vZr635kTVVca5IuwLB6FM671PuMkhmLWM+GjxwYglZD0n+
	 i9nLL6mEymTdUZKwxYgFjFevNDXv1Zelz6DrJFs5PRJ/90xZmxO4gNg733EECEobFF
	 4oMmfA6TMmwCzX1hWGlfxRtfxo4yjKZxyeykSCh9w7KyM1c0hy/y81AeKh5BityGDw
	 ySdlf76h4l0RiyK+BLcUb5KaokWsvDL3GotwQLUEFBzkK5P75zAhaC8AaeifhOK077
	 0pkLJChfSgQHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Lu <luxu.kernel@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 07/21] irqchip/riscv: Ensure ordering of memory writes and IPI writes
Date: Mon, 10 Feb 2025 20:29:40 -0500
Message-Id: <20250211012954.4096433-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

From: Xu Lu <luxu.kernel@bytedance.com>

[ Upstream commit 825c78e6a60c309a59d18d5ac5968aa79cef0bd6 ]

RISC-V distinguishes between memory accesses and device I/O and uses FENCE
instruction to order them as viewed by other RISC-V harts and external
devices or coprocessors. The FENCE instruction can order any combination of
device input(I), device output(O), memory reads(R) and memory
writes(W). For example, 'fence w, o' is used to ensure all memory writes
from instructions preceding the FENCE instruction appear earlier in the
global memory order than device output writes from instructions after the
FENCE instruction.

RISC-V issues IPIs by writing to the IMSIC/ACLINT MMIO registers, which is
regarded as device output operation. However, the existing implementation
of the IMSIC/ACLINT drivers issue the IPI via writel_relaxed(), which does
not guarantee the order of device output operation and preceding memory
writes. As a consequence the hart receiving the IPI might not observe the
IPI related data.

Fix this by replacing writel_relaxed() with writel() when issuing IPIs,
which uses 'fence w, o' to ensure all previous writes made by the current
hart are visible to other harts before they receive the IPI.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250127093846.98625-1-luxu.kernel@bytedance.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-riscv-imsic-early.c      | 2 +-
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index c5c2e6929a2f5..275df50057057 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -27,7 +27,7 @@ static void imsic_ipi_send(unsigned int cpu)
 {
 	struct imsic_local_config *local = per_cpu_ptr(imsic->global.local, cpu);
 
-	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
+	writel(IMSIC_IPI_ID, local->msi_va);
 }
 
 static void imsic_ipi_starting_cpu(void)
diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
index b0e366ade4271..8ff6e7a1363bd 100644
--- a/drivers/irqchip/irq-thead-c900-aclint-sswi.c
+++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
@@ -31,7 +31,7 @@ static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
 
 static void thead_aclint_sswi_ipi_send(unsigned int cpu)
 {
-	writel_relaxed(0x1, per_cpu(sswi_cpu_regs, cpu));
+	writel(0x1, per_cpu(sswi_cpu_regs, cpu));
 }
 
 static void thead_aclint_sswi_ipi_clear(void)
-- 
2.39.5


