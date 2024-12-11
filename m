Return-Path: <stable+bounces-100737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFB9ED56B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318AA280F66
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AFC249533;
	Wed, 11 Dec 2024 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeIbXk8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2624952C;
	Wed, 11 Dec 2024 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943157; cv=none; b=dO7KyFrpK/A8yES0nH82oEYZtLe2I7NmHhcHlk69CDKmCBmNAMeSlsRr9HriPcbe+CC7epsmch3X5P7HzypX4durjTg8/MDY6BySV0Jh7GX2szMHQChfPUWOSNq0C3svYs3LPHr3OaKZehJIfZIP/R5NahBR38DAVN8HDHZfAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943157; c=relaxed/simple;
	bh=rqg2w4iPOtxasrBB3O2j/E9Z70zWx/+29wiMZyqRQTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA6I1hfYqWV7rnTfi66X7DurutZ72dJma+c8MjyS8K3iQrs922UF/bOzdZY6UYeQ2uEiloWexRJXPJsSMcERG8/vuswYY9Afl3iOAY2AiLrBstCEEGEOyzH7fj/2rwvnH8QmXawBpelom7+u0coC0L+53O/zJctrcD5frhjRYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeIbXk8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF81C4CED2;
	Wed, 11 Dec 2024 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943157;
	bh=rqg2w4iPOtxasrBB3O2j/E9Z70zWx/+29wiMZyqRQTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeIbXk8W6VSvDHJ7BGmK2/rvFEAgB+tuVlR3XI0oXxyaXdCgoaliVbnyw8hanfjq9
	 WpH2hvEMXj9e2nk2cKjIKCap6qltBEpBRW6IjVDT/A7BSEx9mQMPXDNyJSCG8vXaaH
	 e97XsfnoQ5bVBGXg/SIyepDx7U4k7A0C0Z81eeZugQaB4gK1K08c5IHzww6iJUUebb
	 DuFbG4M2IOTVMcAaRKhtz1zPRT8AgM6WL+EBRCyRvopK75pDWjpgq4+qUT8M36/ugb
	 +hWt282rBV5onrhnnR+kBe3SCpmZRiceBbl2Cs+ekyvqCdkrFSzx3hIJlxcdjU7CrL
	 23oilv7Rogxmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	maobibo@loongson.cn,
	tglx@linutronix.de,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 11/23] LoongArch/irq: Use seq_put_decimal_ull_width() for decimal values
Date: Wed, 11 Dec 2024 13:51:48 -0500
Message-ID: <20241211185214.3841978-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: David Wang <00107082@163.com>

[ Upstream commit ad2a05a6d287aef7e069c06e329f1355756415c2 ]

Performance improvement for reading /proc/interrupts on LoongArch.

On a system with n CPUs and m interrupts, there will be n*m decimal
values yielded via seq_printf(.."%10u "..) which is less efficient than
seq_put_decimal_ull_width(), stress reading /proc/interrupts indicates
~30% performance improvement with this patch (and its friends).

Signed-off-by: David Wang <00107082@163.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 9dbe7907a9612..a3e154978ac9d 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -83,7 +83,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < NR_IPI; i++) {
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi_irqs[i]);
+			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, cpu).ipi_irqs[i], 10);
 		seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]);
 	}
 }
-- 
2.43.0


