Return-Path: <stable+bounces-92199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D69C4ECF
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 07:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA2A1F24643
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 06:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F809209F2A;
	Tue, 12 Nov 2024 06:36:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E618BBA2;
	Tue, 12 Nov 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393390; cv=none; b=krmDVIN7Pqkt1F7/EBd7EH2FoDYXDEf0KghYN3u9k172/ukd3YkeBl67EPSuLFgCigmXV5jVScJJDI18bE8LD2uI5lNU5vFWj50Mtzi1M3wEOhFHnf2xX++vVZp83g/pWzH2wB1SfVwYoBs7BMBy+aebbj57V6rVga+N1zwMvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393390; c=relaxed/simple;
	bh=URwHfk3izC1gRpf2pZy7HuVAGmvFfuhYumBCgJA9vII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9CvRaGYICqg7P7qHGAwOwNjQBUw9/J8o46I4OFBhne2msxPyqq6x6dASuPm2Zn8ygRqOwNqe84vbq2U98Z6Hway67CUMQ+NE61BP2vMhAmkd/d1Bci6HCsKPQOweA9pZFcyK0l2Pt6M9btV5pP15RO4gA/E0IzQUru1B3MDOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521D6C4CECD;
	Tue, 12 Nov 2024 06:36:27 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH] LoongArch: Fix early_numa_add_cpu() usage for FDT systems
Date: Tue, 12 Nov 2024 14:36:10 +0800
Message-ID: <20241112063610.1135103-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

early_numa_add_cpu() applies on physical CPU id rather than logical CPU
id, so use cpuid instead of cpu.

Cc: stable@vger.kernel.org
Fixes: 3de9c42d02a79a5 ("LoongArch: Add all CPUs enabled by fdt to NUMA node 0")
Reported-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index c0b498467ffa..5d59e9ce2772 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -302,7 +302,7 @@ static void __init fdt_smp_setup(void)
 		__cpu_number_map[cpuid] = cpu;
 		__cpu_logical_map[cpu] = cpuid;
 
-		early_numa_add_cpu(cpu, 0);
+		early_numa_add_cpu(cpuid, 0);
 		set_cpuid_to_node(cpuid, 0);
 	}
 
-- 
2.43.5


