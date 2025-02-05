Return-Path: <stable+bounces-113846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3CA29477
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020BF188DF33
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0CE194094;
	Wed,  5 Feb 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rNB8CRFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEA192D97;
	Wed,  5 Feb 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768363; cv=none; b=tBswq/5e7fsvre5cIFi5rmPdqLwQrDLjPLZ+BAKIvnFpHFLnLdwoARg5f6onibC8LGH56KBmqIXUUwKhOBwrGyDz1r/wQcJYHgB/95YtacO43ldTf86nk1/Apdril4qgxoVebiYuunpoUqe5OSsaDVk5alHshqbM8upyninDNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768363; c=relaxed/simple;
	bh=52z+rjEejEeUJlw30pQ3e5pBPKcxB2xhnP8dPT/Jwo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWPsCv515rtg7ZAtVXZ6fXhWcO3UlxsdtaMcrj0Ns49TY0q4DZ8cRZ+nP0J9mWNOkMEY2dbn66AwBL0gvbSKHi1cQ8Lsn0rZZCEkRElynBtw8cS0lhrsJETQtZSvTpPm5WLzIsFzUKZgnmTe5cQ3zW4oCp0MRyS2zjLu5H4oPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rNB8CRFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB9BC4CED1;
	Wed,  5 Feb 2025 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768363;
	bh=52z+rjEejEeUJlw30pQ3e5pBPKcxB2xhnP8dPT/Jwo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNB8CRFfSKX6VoAKlOJgAp/KM2gc34OwOzwKZpp0w1FQ+L+m243pMjGQNzlRhqePO
	 ljmZ3FQLrIDF/MBpxOWmcv0LUcYVt+eQxbrMkFyIge004eDE8ZvX6VHbwsLRpA8jgS
	 A2v5o25heicOieWVNUARfQqVLXfAwWKaBq7M3Clo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WANG Xuerui <git@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 589/590] LoongArch: Change 8 to 14 for LOONGARCH_MAX_{BRP,WRP}
Date: Wed,  5 Feb 2025 14:45:44 +0100
Message-ID: <20250205134517.796830393@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit f502ea618bf16d615d7dc6138c8988d3118fe750 upstream.

The maximum number of load/store watchpoints and fetch instruction
watchpoints is 14 each according to LoongArch Reference Manual, so
change 8 to 14 for the related code.

Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#control-and-status-registers-related-to-watchpoints
Cc: stable@vger.kernel.org
Fixes: edffa33c7bb5 ("LoongArch: Add hardware breakpoints/watchpoints support")
Reviewed-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/hw_breakpoint.h |    4 -
 arch/loongarch/include/asm/loongarch.h     |   60 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/hw_breakpoint.c      |   16 ++++++-
 3 files changed, 76 insertions(+), 4 deletions(-)

--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -38,8 +38,8 @@ struct arch_hw_breakpoint {
  * Limits.
  * Changing these will require modifications to the register accessors.
  */
-#define LOONGARCH_MAX_BRP		8
-#define LOONGARCH_MAX_WRP		8
+#define LOONGARCH_MAX_BRP		14
+#define LOONGARCH_MAX_WRP		14
 
 /* Virtual debug register bases. */
 #define CSR_CFG_ADDR	0
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -959,6 +959,36 @@
 #define LOONGARCH_CSR_DB7CTRL		0x34a	/* data breakpoint 7 control */
 #define LOONGARCH_CSR_DB7ASID		0x34b	/* data breakpoint 7 asid */
 
+#define LOONGARCH_CSR_DB8ADDR		0x350	/* data breakpoint 8 address */
+#define LOONGARCH_CSR_DB8MASK		0x351	/* data breakpoint 8 mask */
+#define LOONGARCH_CSR_DB8CTRL		0x352	/* data breakpoint 8 control */
+#define LOONGARCH_CSR_DB8ASID		0x353	/* data breakpoint 8 asid */
+
+#define LOONGARCH_CSR_DB9ADDR		0x358	/* data breakpoint 9 address */
+#define LOONGARCH_CSR_DB9MASK		0x359	/* data breakpoint 9 mask */
+#define LOONGARCH_CSR_DB9CTRL		0x35a	/* data breakpoint 9 control */
+#define LOONGARCH_CSR_DB9ASID		0x35b	/* data breakpoint 9 asid */
+
+#define LOONGARCH_CSR_DB10ADDR		0x360	/* data breakpoint 10 address */
+#define LOONGARCH_CSR_DB10MASK		0x361	/* data breakpoint 10 mask */
+#define LOONGARCH_CSR_DB10CTRL		0x362	/* data breakpoint 10 control */
+#define LOONGARCH_CSR_DB10ASID		0x363	/* data breakpoint 10 asid */
+
+#define LOONGARCH_CSR_DB11ADDR		0x368	/* data breakpoint 11 address */
+#define LOONGARCH_CSR_DB11MASK		0x369	/* data breakpoint 11 mask */
+#define LOONGARCH_CSR_DB11CTRL		0x36a	/* data breakpoint 11 control */
+#define LOONGARCH_CSR_DB11ASID		0x36b	/* data breakpoint 11 asid */
+
+#define LOONGARCH_CSR_DB12ADDR		0x370	/* data breakpoint 12 address */
+#define LOONGARCH_CSR_DB12MASK		0x371	/* data breakpoint 12 mask */
+#define LOONGARCH_CSR_DB12CTRL		0x372	/* data breakpoint 12 control */
+#define LOONGARCH_CSR_DB12ASID		0x373	/* data breakpoint 12 asid */
+
+#define LOONGARCH_CSR_DB13ADDR		0x378	/* data breakpoint 13 address */
+#define LOONGARCH_CSR_DB13MASK		0x379	/* data breakpoint 13 mask */
+#define LOONGARCH_CSR_DB13CTRL		0x37a	/* data breakpoint 13 control */
+#define LOONGARCH_CSR_DB13ASID		0x37b	/* data breakpoint 13 asid */
+
 #define LOONGARCH_CSR_FWPC		0x380	/* instruction breakpoint config */
 #define LOONGARCH_CSR_FWPS		0x381	/* instruction breakpoint status */
 
@@ -1002,6 +1032,36 @@
 #define LOONGARCH_CSR_IB7CTRL		0x3ca	/* inst breakpoint 7 control */
 #define LOONGARCH_CSR_IB7ASID		0x3cb	/* inst breakpoint 7 asid */
 
+#define LOONGARCH_CSR_IB8ADDR		0x3d0	/* inst breakpoint 8 address */
+#define LOONGARCH_CSR_IB8MASK		0x3d1	/* inst breakpoint 8 mask */
+#define LOONGARCH_CSR_IB8CTRL		0x3d2	/* inst breakpoint 8 control */
+#define LOONGARCH_CSR_IB8ASID		0x3d3	/* inst breakpoint 8 asid */
+
+#define LOONGARCH_CSR_IB9ADDR		0x3d8	/* inst breakpoint 9 address */
+#define LOONGARCH_CSR_IB9MASK		0x3d9	/* inst breakpoint 9 mask */
+#define LOONGARCH_CSR_IB9CTRL		0x3da	/* inst breakpoint 9 control */
+#define LOONGARCH_CSR_IB9ASID		0x3db	/* inst breakpoint 9 asid */
+
+#define LOONGARCH_CSR_IB10ADDR		0x3e0	/* inst breakpoint 10 address */
+#define LOONGARCH_CSR_IB10MASK		0x3e1	/* inst breakpoint 10 mask */
+#define LOONGARCH_CSR_IB10CTRL		0x3e2	/* inst breakpoint 10 control */
+#define LOONGARCH_CSR_IB10ASID		0x3e3	/* inst breakpoint 10 asid */
+
+#define LOONGARCH_CSR_IB11ADDR		0x3e8	/* inst breakpoint 11 address */
+#define LOONGARCH_CSR_IB11MASK		0x3e9	/* inst breakpoint 11 mask */
+#define LOONGARCH_CSR_IB11CTRL		0x3ea	/* inst breakpoint 11 control */
+#define LOONGARCH_CSR_IB11ASID		0x3eb	/* inst breakpoint 11 asid */
+
+#define LOONGARCH_CSR_IB12ADDR		0x3f0	/* inst breakpoint 12 address */
+#define LOONGARCH_CSR_IB12MASK		0x3f1	/* inst breakpoint 12 mask */
+#define LOONGARCH_CSR_IB12CTRL		0x3f2	/* inst breakpoint 12 control */
+#define LOONGARCH_CSR_IB12ASID		0x3f3	/* inst breakpoint 12 asid */
+
+#define LOONGARCH_CSR_IB13ADDR		0x3f8	/* inst breakpoint 13 address */
+#define LOONGARCH_CSR_IB13MASK		0x3f9	/* inst breakpoint 13 mask */
+#define LOONGARCH_CSR_IB13CTRL		0x3fa	/* inst breakpoint 13 control */
+#define LOONGARCH_CSR_IB13ASID		0x3fb	/* inst breakpoint 13 asid */
+
 #define LOONGARCH_CSR_DEBUG		0x500	/* debug config */
 #define LOONGARCH_CSR_DERA		0x501	/* debug era */
 #define LOONGARCH_CSR_DESAVE		0x502	/* debug save */
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -51,7 +51,13 @@ int hw_breakpoint_slots(int type)
 	READ_WB_REG_CASE(OFF, 4, REG, T, VAL);		\
 	READ_WB_REG_CASE(OFF, 5, REG, T, VAL);		\
 	READ_WB_REG_CASE(OFF, 6, REG, T, VAL);		\
-	READ_WB_REG_CASE(OFF, 7, REG, T, VAL);
+	READ_WB_REG_CASE(OFF, 7, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 8, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 9, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 10, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 11, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 12, REG, T, VAL);		\
+	READ_WB_REG_CASE(OFF, 13, REG, T, VAL);
 
 #define GEN_WRITE_WB_REG_CASES(OFF, REG, T, VAL)	\
 	WRITE_WB_REG_CASE(OFF, 0, REG, T, VAL);		\
@@ -61,7 +67,13 @@ int hw_breakpoint_slots(int type)
 	WRITE_WB_REG_CASE(OFF, 4, REG, T, VAL);		\
 	WRITE_WB_REG_CASE(OFF, 5, REG, T, VAL);		\
 	WRITE_WB_REG_CASE(OFF, 6, REG, T, VAL);		\
-	WRITE_WB_REG_CASE(OFF, 7, REG, T, VAL);
+	WRITE_WB_REG_CASE(OFF, 7, REG, T, VAL);		\
+	WRITE_WB_REG_CASE(OFF, 8, REG, T, VAL);		\
+	WRITE_WB_REG_CASE(OFF, 9, REG, T, VAL);		\
+	WRITE_WB_REG_CASE(OFF, 10, REG, T, VAL);	\
+	WRITE_WB_REG_CASE(OFF, 11, REG, T, VAL);	\
+	WRITE_WB_REG_CASE(OFF, 12, REG, T, VAL);	\
+	WRITE_WB_REG_CASE(OFF, 13, REG, T, VAL);
 
 static u64 read_wb_reg(int reg, int n, int t)
 {



