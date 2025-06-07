Return-Path: <stable+bounces-151838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DBAD0E0D
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A5E7A4FCE
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3721D5CEA;
	Sat,  7 Jun 2025 15:23:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE31AF4C1
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309785; cv=none; b=S37BJzOrKKCzjQue7SDmbGy6VfjpBOz3dFEm8dyE/CKPD3ge2DNBsQPxJJ3vfx1uV7RhsOub/P8m6qXeAA7Gt9p3wKJ8S40qNgpYcuEv6dzLD44rwJOPCfkzV/zRosjUWU5pJflrIO+f4zO4MXQkyCen9J2BtYzZO9jPXjqAcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309785; c=relaxed/simple;
	bh=aFxOcx6aBN6iIUKYiSsYs4rkdGwqEeP2GYgrVBU9iF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojGrroiDoZmXqzzn2YxeFv+Szspc0Sq4MlOo+Np3YXKP/ePzDMiIBnpJCbY+3NPc5ZElM76rLtprmv8O7fQOlkKgkewvvrKpXXIemaF1a9Jjc3FHwzJhZmrjidkssQWb079i0Oa5oWLF01ZukjImXjxdxaqcRMIsWPVgv2nZfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24c5DKqzYQvPF
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BBC511A0EC0
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S6;
	Sat, 07 Jun 2025 23:22:55 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 04/14] arm64: insn: Add support for encoding DSB
Date: Sat,  7 Jun 2025 15:25:11 +0000
Message-Id: <20250607152521.2828291-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607152521.2828291-1-pulehui@huaweicloud.com>
References: <20250607152521.2828291-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGry3tr1kKFyDCr4UJry3XFb_yoW5uF1rpF
	s8Zr1rG3W8uryfKF1Svrn8Zrs0gw4kWFZxKr9Fgw1vvw47Z34rtF40gr1jgFyUCrWq9ay8
	KF4jvr4fu3WUXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: James Morse <james.morse@arm.com>

[ Upstream commit 63de8abd97ddb9b758bd8f915ecbd18e1f1a87a0 ]

To generate code in the eBPF epilogue that uses the DSB instruction,
insn.c needs a heler to encode the type and domain.

Re-use the crm encoding logic from the DMB instruction.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/insn.h |  1 +
 arch/arm64/kernel/insn.c      | 60 +++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 33b3351028f0..01eb21da089a 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -584,6 +584,7 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
 }
 #endif
 u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
+u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type);
 
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7efa567ef0f6..2d84453f5200 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2014-2016 Zi Shen Lim <zlim.lnx@gmail.com>
  */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
@@ -1810,43 +1811,41 @@ u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
 }
 
-u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
+static u32 __get_barrier_crm_val(enum aarch64_insn_mb_type type)
 {
-	u32 opt;
-	u32 insn;
-
 	switch (type) {
 	case AARCH64_INSN_MB_SY:
-		opt = 0xf;
-		break;
+		return 0xf;
 	case AARCH64_INSN_MB_ST:
-		opt = 0xe;
-		break;
+		return 0xe;
 	case AARCH64_INSN_MB_LD:
-		opt = 0xd;
-		break;
+		return 0xd;
 	case AARCH64_INSN_MB_ISH:
-		opt = 0xb;
-		break;
+		return 0xb;
 	case AARCH64_INSN_MB_ISHST:
-		opt = 0xa;
-		break;
+		return 0xa;
 	case AARCH64_INSN_MB_ISHLD:
-		opt = 0x9;
-		break;
+		return 0x9;
 	case AARCH64_INSN_MB_NSH:
-		opt = 0x7;
-		break;
+		return 0x7;
 	case AARCH64_INSN_MB_NSHST:
-		opt = 0x6;
-		break;
+		return 0x6;
 	case AARCH64_INSN_MB_NSHLD:
-		opt = 0x5;
-		break;
+		return 0x5;
 	default:
-		pr_err("%s: unknown dmb type %d\n", __func__, type);
+		pr_err("%s: unknown barrier type %d\n", __func__, type);
 		return AARCH64_BREAK_FAULT;
 	}
+}
+
+u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
+{
+	u32 opt;
+	u32 insn;
+
+	opt = __get_barrier_crm_val(type);
+	if (opt == AARCH64_BREAK_FAULT)
+		return AARCH64_BREAK_FAULT;
 
 	insn = aarch64_insn_get_dmb_value();
 	insn &= ~GENMASK(11, 8);
@@ -1854,3 +1853,18 @@ u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
 
 	return insn;
 }
+
+u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type)
+{
+	u32 opt, insn;
+
+	opt = __get_barrier_crm_val(type);
+	if (opt == AARCH64_BREAK_FAULT)
+		return AARCH64_BREAK_FAULT;
+
+	insn = aarch64_insn_get_dsb_base_value();
+	insn &= ~GENMASK(11, 8);
+	insn |= (opt << 8);
+
+	return insn;
+}
-- 
2.34.1


