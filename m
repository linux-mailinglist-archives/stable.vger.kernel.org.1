Return-Path: <stable+bounces-151848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97706AD0E20
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C35B188F25F
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FE1E32BE;
	Sat,  7 Jun 2025 15:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52701BD01D
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310390; cv=none; b=uaTneM91SBToeOSoXKcfigexS/t9YrAh4JFJ+da/TXDwPplToRkMNcrTkrQ6NEt8uCsgrEXEfgSWelbjQ6F06QJvWaeViKi+5sdhRMpgOgKmu3ypDKf+ATxItqFAQIWwnc7n3nTrOE1M6R30/nRN4ntSTyyHGx2o89KTXQipITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310390; c=relaxed/simple;
	bh=t6BF9tnrdJoVaiUfVdlGJ8oH2t3L3+lrELu9stb+FBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOK2gkfmDqpmROibmnH6apBJ1BgbZtjqZ+FZA+KYLhVhSM3b5B0visijh6HeuvbVq/beYvx+wYx0hD/jSgP+B1bwk7CwivbVytLoK5dDUWS0qEpMDG1lKySgWtJMqK05lpGJbTPzp8ZkH4DJZuHYOvzPnLp3bM/s7tAlN2KfkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bF2JM49hKzKHMwr
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EB2611A0C27
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:05 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sCwW0Rod05JOg--.5386S3;
	Sat, 07 Jun 2025 23:33:05 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.15 1/9] arm64: move AARCH64_BREAK_FAULT into insn-def.h
Date: Sat,  7 Jun 2025 15:35:27 +0000
Message-Id: <20250607153535.3613861-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607153535.3613861-1-pulehui@huaweicloud.com>
References: <20250607153535.3613861-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBH5sCwW0Rod05JOg--.5386S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkCFy5KF4UCFW8Gr15urg_yoW5GF1fpa
	sxuwn5KrW8Wr95KF1FvwnFyr43tan5Kr17Kr9xZFZ0va1Yya1YgrWvqa15uFW8ZFW2vr40
	gry29r1rWF4DZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUw9a9UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 97e58e395e9c074fd096dad13c54e9f4112cf71d ]

If CONFIG_ARM64_LSE_ATOMICS is off, encoders for LSE-related instructions
can return AARCH64_BREAK_FAULT directly in insn.h. In order to access
AARCH64_BREAK_FAULT in insn.h, we can not include debug-monitors.h in
insn.h, because debug-monitors.h has already depends on insn.h, so just
move AARCH64_BREAK_FAULT into insn-def.h.

It will be used by the following patch to eliminate unnecessary LSE-related
encoders when CONFIG_ARM64_LSE_ATOMICS is off.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20220217072232.1186625-2-houtao1@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/debug-monitors.h | 12 ------------
 arch/arm64/include/asm/insn-def.h       | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 8de1a840ad97..13d437bcbf58 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -34,18 +34,6 @@
  */
 #define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
 
-/*
- * BRK instruction encoding
- * The #imm16 value should be placed at bits[20:5] within BRK ins
- */
-#define AARCH64_BREAK_MON	0xd4200000
-
-/*
- * BRK instruction for provoking a fault on purpose
- * Unlike kgdb, #imm16 value with unallocated handler is used for faulting.
- */
-#define AARCH64_BREAK_FAULT	(AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
-
 #define AARCH64_BREAK_KGDB_DYN_DBG	\
 	(AARCH64_BREAK_MON | (KGDB_DYN_DBG_BRK_IMM << 5))
 
diff --git a/arch/arm64/include/asm/insn-def.h b/arch/arm64/include/asm/insn-def.h
index 2c075f615c6a..1a7d0d483698 100644
--- a/arch/arm64/include/asm/insn-def.h
+++ b/arch/arm64/include/asm/insn-def.h
@@ -3,7 +3,21 @@
 #ifndef __ASM_INSN_DEF_H
 #define __ASM_INSN_DEF_H
 
+#include <asm/brk-imm.h>
+
 /* A64 instructions are always 32 bits. */
 #define	AARCH64_INSN_SIZE		4
 
+/*
+ * BRK instruction encoding
+ * The #imm16 value should be placed at bits[20:5] within BRK ins
+ */
+#define AARCH64_BREAK_MON	0xd4200000
+
+/*
+ * BRK instruction for provoking a fault on purpose
+ * Unlike kgdb, #imm16 value with unallocated handler is used for faulting.
+ */
+#define AARCH64_BREAK_FAULT	(AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
+
 #endif /* __ASM_INSN_DEF_H */
-- 
2.34.1


