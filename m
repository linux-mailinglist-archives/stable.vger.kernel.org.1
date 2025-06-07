Return-Path: <stable+bounces-151839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2EBAD0E0C
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA675188D2D1
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A4B1AF4C1;
	Sat,  7 Jun 2025 15:23:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF891A3167
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309785; cv=none; b=isGgxxoy/sRdwmKIcgfzh7UalTCr6S8Cn/STuUPmOW3LIZ3+txXydylpbtRmj9FshJKzQXEd5eRCwI7GNIxOSAWMvdni6DQEBQInhKhaTmfPBZp8RkcBtCx3IX98cQSH8opC+3q7DWl9piRNW2f0/p9k9jZJ/oymifQ17oWt8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309785; c=relaxed/simple;
	bh=T1bzXIP5fV53jYyxoSgzX/RXEBSqLXqI5FO50iuzN30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psrBQ6htZAWBsGLYySW6uCPvdvilHeXBDIMJsrB4zbieX59NzHp5DHXdGTndFv/Tn4tYjqDmrYDwJ5y743t0H4pTQYJ+688gb1RQXEWFT1446tFA6c5C+m8X6Xh3yeoj/A3uZqQNi38KiMIiVEv2i0gDCom4Ser9DLbCxtuaEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24c4gXGzYQvFF
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A7A771A0EC4
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S5;
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
Subject: [PATCH 5.10 03/14] arm64: insn: add encoders for atomic operations
Date: Sat,  7 Jun 2025 15:25:10 +0000
Message-Id: <20250607152521.2828291-4-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S5
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFyfXrW3AF48tw1rAF1xuFg_yoW8JF4Uto
	WvqF1UWr4DGrWrWFWfCw17tFy0v34xGwsYyrW5tF4kWa1ktFnxZF1fu3yUAa47JF47Jaya
	gw1kJay8WayxJFykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYL7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ByIUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit fa1114d9eba5087ba5e81aab4c56f546995e6cd3 ]

It is a preparation patch for eBPF atomic supports under arm64. eBPF
needs support atomic[64]_fetch_add, atomic[64]_[fetch_]{and,or,xor} and
atomic[64]_{xchg|cmpxchg}. The ordering semantics of eBPF atomics are
the same with the implementations in linux kernel.

Add three helpers to support LDCLR/LDEOR/LDSET/SWP, CAS and DMB
instructions. STADD/STCLR/STEOR/STSET are simply encoded as aliases for
LDADD/LDCLR/LDEOR/LDSET with XZR as the destination register, so no extra
helper is added. atomic_fetch_add() and other atomic ops needs support for
STLXR instruction, so extend enum aarch64_insn_ldst_type to do that.

LDADD/LDEOR/LDSET/SWP and CAS instructions are only available when LSE
atomics is enabled, so just return AARCH64_BREAK_FAULT directly in
these newly-added helpers if CONFIG_ARM64_LSE_ATOMICS is disabled.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20220217072232.1186625-3-houtao1@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/insn.h |  80 +++++++++++++--
 arch/arm64/kernel/insn.c      | 185 +++++++++++++++++++++++++++++++---
 arch/arm64/net/bpf_jit.h      |  11 +-
 3 files changed, 253 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index c9e4862fb24e..33b3351028f0 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -218,7 +218,9 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_LOAD_EX,
+	AARCH64_INSN_LDST_LOAD_ACQ_EX,
 	AARCH64_INSN_LDST_STORE_EX,
+	AARCH64_INSN_LDST_STORE_REL_EX,
 };
 
 enum aarch64_insn_adsb_type {
@@ -293,6 +295,36 @@ enum aarch64_insn_adr_type {
 	AARCH64_INSN_ADR_TYPE_ADR,
 };
 
+enum aarch64_insn_mem_atomic_op {
+	AARCH64_INSN_MEM_ATOMIC_ADD,
+	AARCH64_INSN_MEM_ATOMIC_CLR,
+	AARCH64_INSN_MEM_ATOMIC_EOR,
+	AARCH64_INSN_MEM_ATOMIC_SET,
+	AARCH64_INSN_MEM_ATOMIC_SWP,
+};
+
+enum aarch64_insn_mem_order_type {
+	AARCH64_INSN_MEM_ORDER_NONE,
+	AARCH64_INSN_MEM_ORDER_ACQ,
+	AARCH64_INSN_MEM_ORDER_REL,
+	AARCH64_INSN_MEM_ORDER_ACQREL,
+};
+
+enum aarch64_insn_mb_type {
+	AARCH64_INSN_MB_SY,
+	AARCH64_INSN_MB_ST,
+	AARCH64_INSN_MB_LD,
+	AARCH64_INSN_MB_ISH,
+	AARCH64_INSN_MB_ISHST,
+	AARCH64_INSN_MB_ISHLD,
+	AARCH64_INSN_MB_NSH,
+	AARCH64_INSN_MB_NSHST,
+	AARCH64_INSN_MB_NSHLD,
+	AARCH64_INSN_MB_OSH,
+	AARCH64_INSN_MB_OSHST,
+	AARCH64_INSN_MB_OSHLD,
+};
+
 #define	__AARCH64_INSN_FUNCS(abbr, mask, val)				\
 static __always_inline bool aarch64_insn_is_##abbr(u32 code)		\
 {									\
@@ -310,6 +342,11 @@ __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
+__AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
+__AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
+__AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
+__AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
+__AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
@@ -452,13 +489,6 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register state,
 				   enum aarch64_insn_size_type size,
 				   enum aarch64_insn_ldst_type type);
-u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
-			   enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size);
-u32 aarch64_insn_gen_stadd(enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size);
 u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
 				 enum aarch64_insn_register src,
 				 int imm, enum aarch64_insn_variant variant,
@@ -519,6 +549,42 @@ u32 aarch64_insn_gen_prefetch(enum aarch64_insn_register base,
 			      enum aarch64_insn_prfm_type type,
 			      enum aarch64_insn_prfm_target target,
 			      enum aarch64_insn_prfm_policy policy);
+#ifdef CONFIG_ARM64_LSE_ATOMICS
+u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
+				  enum aarch64_insn_register address,
+				  enum aarch64_insn_register value,
+				  enum aarch64_insn_size_type size,
+				  enum aarch64_insn_mem_atomic_op op,
+				  enum aarch64_insn_mem_order_type order);
+u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
+			 enum aarch64_insn_register address,
+			 enum aarch64_insn_register value,
+			 enum aarch64_insn_size_type size,
+			 enum aarch64_insn_mem_order_type order);
+#else
+static inline
+u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
+				  enum aarch64_insn_register address,
+				  enum aarch64_insn_register value,
+				  enum aarch64_insn_size_type size,
+				  enum aarch64_insn_mem_atomic_op op,
+				  enum aarch64_insn_mem_order_type order)
+{
+	return AARCH64_BREAK_FAULT;
+}
+
+static inline
+u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
+			 enum aarch64_insn_register address,
+			 enum aarch64_insn_register value,
+			 enum aarch64_insn_size_type size,
+			 enum aarch64_insn_mem_order_type order)
+{
+	return AARCH64_BREAK_FAULT;
+}
+#endif
+u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
+
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7d4fdf974542..7efa567ef0f6 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -721,10 +721,16 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 
 	switch (type) {
 	case AARCH64_INSN_LDST_LOAD_EX:
+	case AARCH64_INSN_LDST_LOAD_ACQ_EX:
 		insn = aarch64_insn_get_load_ex_value();
+		if (type == AARCH64_INSN_LDST_LOAD_ACQ_EX)
+			insn |= BIT(15);
 		break;
 	case AARCH64_INSN_LDST_STORE_EX:
+	case AARCH64_INSN_LDST_STORE_REL_EX:
 		insn = aarch64_insn_get_store_ex_value();
+		if (type == AARCH64_INSN_LDST_STORE_REL_EX)
+			insn |= BIT(15);
 		break;
 	default:
 		pr_err("%s: unknown load/store exclusive encoding %d\n", __func__, type);
@@ -746,12 +752,65 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 					    state);
 }
 
-u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
-			   enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size)
+#ifdef CONFIG_ARM64_LSE_ATOMICS
+static u32 aarch64_insn_encode_ldst_order(enum aarch64_insn_mem_order_type type,
+					  u32 insn)
 {
-	u32 insn = aarch64_insn_get_ldadd_value();
+	u32 order;
+
+	switch (type) {
+	case AARCH64_INSN_MEM_ORDER_NONE:
+		order = 0;
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQ:
+		order = 2;
+		break;
+	case AARCH64_INSN_MEM_ORDER_REL:
+		order = 1;
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQREL:
+		order = 3;
+		break;
+	default:
+		pr_err("%s: unknown mem order %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn &= ~GENMASK(23, 22);
+	insn |= order << 22;
+
+	return insn;
+}
+
+u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
+				  enum aarch64_insn_register address,
+				  enum aarch64_insn_register value,
+				  enum aarch64_insn_size_type size,
+				  enum aarch64_insn_mem_atomic_op op,
+				  enum aarch64_insn_mem_order_type order)
+{
+	u32 insn;
+
+	switch (op) {
+	case AARCH64_INSN_MEM_ATOMIC_ADD:
+		insn = aarch64_insn_get_ldadd_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_CLR:
+		insn = aarch64_insn_get_ldclr_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_EOR:
+		insn = aarch64_insn_get_ldeor_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_SET:
+		insn = aarch64_insn_get_ldset_value();
+		break;
+	case AARCH64_INSN_MEM_ATOMIC_SWP:
+		insn = aarch64_insn_get_swp_value();
+		break;
+	default:
+		pr_err("%s: unimplemented mem atomic op %d\n", __func__, op);
+		return AARCH64_BREAK_FAULT;
+	}
 
 	switch (size) {
 	case AARCH64_INSN_SIZE_32:
@@ -764,6 +823,8 @@ u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
 
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
+	insn = aarch64_insn_encode_ldst_order(order, insn);
+
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
 					    result);
 
@@ -774,17 +835,68 @@ u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
 					    value);
 }
 
-u32 aarch64_insn_gen_stadd(enum aarch64_insn_register address,
-			   enum aarch64_insn_register value,
-			   enum aarch64_insn_size_type size)
+static u32 aarch64_insn_encode_cas_order(enum aarch64_insn_mem_order_type type,
+					 u32 insn)
 {
-	/*
-	 * STADD is simply encoded as an alias for LDADD with XZR as
-	 * the destination register.
-	 */
-	return aarch64_insn_gen_ldadd(AARCH64_INSN_REG_ZR, address,
-				      value, size);
+	u32 order;
+
+	switch (type) {
+	case AARCH64_INSN_MEM_ORDER_NONE:
+		order = 0;
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQ:
+		order = BIT(22);
+		break;
+	case AARCH64_INSN_MEM_ORDER_REL:
+		order = BIT(15);
+		break;
+	case AARCH64_INSN_MEM_ORDER_ACQREL:
+		order = BIT(15) | BIT(22);
+		break;
+	default:
+		pr_err("%s: unknown mem order %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn &= ~(BIT(15) | BIT(22));
+	insn |= order;
+
+	return insn;
+}
+
+u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
+			 enum aarch64_insn_register address,
+			 enum aarch64_insn_register value,
+			 enum aarch64_insn_size_type size,
+			 enum aarch64_insn_mem_order_type order)
+{
+	u32 insn;
+
+	switch (size) {
+	case AARCH64_INSN_SIZE_32:
+	case AARCH64_INSN_SIZE_64:
+		break;
+	default:
+		pr_err("%s: unimplemented size encoding %d\n", __func__, size);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_get_cas_value();
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_cas_order(order, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    result);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    address);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
+					    value);
 }
+#endif
 
 static u32 aarch64_insn_encode_prfm_imm(enum aarch64_insn_prfm_type type,
 					enum aarch64_insn_prfm_target target,
@@ -1697,3 +1809,48 @@ u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
 }
+
+u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
+{
+	u32 opt;
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_MB_SY:
+		opt = 0xf;
+		break;
+	case AARCH64_INSN_MB_ST:
+		opt = 0xe;
+		break;
+	case AARCH64_INSN_MB_LD:
+		opt = 0xd;
+		break;
+	case AARCH64_INSN_MB_ISH:
+		opt = 0xb;
+		break;
+	case AARCH64_INSN_MB_ISHST:
+		opt = 0xa;
+		break;
+	case AARCH64_INSN_MB_ISHLD:
+		opt = 0x9;
+		break;
+	case AARCH64_INSN_MB_NSH:
+		opt = 0x7;
+		break;
+	case AARCH64_INSN_MB_NSHST:
+		opt = 0x6;
+		break;
+	case AARCH64_INSN_MB_NSHLD:
+		opt = 0x5;
+		break;
+	default:
+		pr_err("%s: unknown dmb type %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_get_dmb_value();
+	insn &= ~GENMASK(11, 8);
+	insn |= (opt << 8);
+
+	return insn;
+}
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index cc0cf0f5c7c3..9d9250c7cc72 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -89,9 +89,16 @@
 #define A64_STXR(sf, Rt, Rn, Rs) \
 	A64_LSX(sf, Rt, Rn, Rs, STORE_EX)
 
-/* LSE atomics */
+/*
+ * LSE atomics
+ *
+ * STADD is simply encoded as an alias for LDADD with XZR as
+ * the destination register.
+ */
 #define A64_STADD(sf, Rn, Rs) \
-	aarch64_insn_gen_stadd(Rn, Rs, A64_SIZE(sf))
+	aarch64_insn_gen_atomic_ld_op(A64_ZR, Rn, Rs, \
+		A64_SIZE(sf), AARCH64_INSN_MEM_ATOMIC_ADD, \
+		AARCH64_INSN_MEM_ORDER_NONE)
 
 /* Add/subtract (immediate) */
 #define A64_ADDSUB_IMM(sf, Rd, Rn, imm12, type) \
-- 
2.34.1


