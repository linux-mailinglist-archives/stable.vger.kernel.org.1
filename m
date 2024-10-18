Return-Path: <stable+bounces-86730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47349A338D
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 05:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D122B22193
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 03:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A616DC01;
	Fri, 18 Oct 2024 03:59:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4411684A5;
	Fri, 18 Oct 2024 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223989; cv=none; b=mjxotjcXu2WujysICbasfDo9XkZkIorH0Rym2pW6duGchtzlFfLheLmTL7KgqekW9BUdOaGZw5oO4nZjDIb7kd5ipAbnMSA9zumuUhE4Aba+TJx8FSn1ZC6Cb+vuQd1gH7UhFfZOidicqV3vgVGMeO4iA2MLJhlNLivGSY2j0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223989; c=relaxed/simple;
	bh=kQ5HXg7ckmYX9fdJDxid/fSA00OhvaOTWPV/xGVPYWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZfIK5J/7v7eM/yUowG0vVLw/5s/CzakzOMT8p1vGzt+4jX1hOQfphAKM1w+yzuDmdFoxHLmPvrXv0YlHbk86ND7NoqCntnZi7U9vcYnWRAW+55axBeMeBnU0rEAAmg4Yl1NuyNBnxgUVK2sgz5hVGXbrAVhOI5extE3XUyy+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCDCC4CEC3;
	Fri, 18 Oct 2024 03:59:45 +0000 (UTC)
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
	Chao Li <lichao@loongson.cn>
Subject: [PATCH] LoongArch: Get correct cores_per_package for SMT systems
Date: Fri, 18 Oct 2024 11:59:20 +0800
Message-ID: <20241018035920.1059661-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In loongson_sysconf, The "core" of cores_per_node and cores_per_package
stands for a logical core, which means in a SMT system it stands for a
thread indeed. This information is gotten from SMBIOS Type4 Structure,
so in order to get a correct cores_per_package for both SMT and non-SMT
systems in parse_cpu_table() we should use SMBIOS_THREAD_PACKAGE_OFFSET
instead of SMBIOS_CORE_PACKAGE_OFFSET.

Cc: stable@vger.kernel.org
Reported-by: Chao Li <lichao@loongson.cn>
Tested-by: Chao Li <lichao@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 00e307203ddb..cbd3c09a93c1 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -55,6 +55,7 @@
 #define SMBIOS_FREQHIGH_OFFSET		0x17
 #define SMBIOS_FREQLOW_MASK		0xFF
 #define SMBIOS_CORE_PACKAGE_OFFSET	0x23
+#define SMBIOS_THREAD_PACKAGE_OFFSET	0x25
 #define LOONGSON_EFI_ENABLE		(1 << 3)
 
 unsigned long fw_arg0, fw_arg1, fw_arg2;
@@ -125,7 +126,7 @@ static void __init parse_cpu_table(const struct dmi_header *dm)
 	cpu_clock_freq = freq_temp * 1000000;
 
 	loongson_sysconf.cpuname = (void *)dmi_string_parse(dm, dmi_data[16]);
-	loongson_sysconf.cores_per_package = *(dmi_data + SMBIOS_CORE_PACKAGE_OFFSET);
+	loongson_sysconf.cores_per_package = *(dmi_data + SMBIOS_THREAD_PACKAGE_OFFSET);
 
 	pr_info("CpuClock = %llu\n", cpu_clock_freq);
 }
-- 
2.43.5

diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index 6d5846dd075c..7657e016233f 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -26,6 +26,10 @@ struct loongson_board_info {
 
 #define NR_WORDS DIV_ROUND_UP(NR_CPUS, BITS_PER_LONG)
 
+/*
+ * The "core" of cores_per_node and cores_per_package stands for a
+ * logical core, which means in a SMT system it stands for a thread.
+ */
 struct loongson_system_configuration {
 	int nr_cpus;
 	int nr_nodes;

