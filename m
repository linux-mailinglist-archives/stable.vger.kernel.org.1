Return-Path: <stable+bounces-151840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80641AD0E0E
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84593AF4E6
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE01D86C6;
	Sat,  7 Jun 2025 15:23:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244F27701
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309785; cv=none; b=nLigCCbteE5j5TnKEBNGH10CHLPfcbaV+vH9RbJNklf1qBENJ/MWnJdxZY1elBXx8n+CCM/ey9xlJM2x4Ar1xPS+vJuBgINzVI+d77hQS575evT7t2ucsipfdk050XtWbx/iwCVHxysVA46lFJy8/sW77qedOt+2ExinTxTuS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309785; c=relaxed/simple;
	bh=acNGWaURZ9Mm9L6hQ3Q4h/MWj1ZCYW4Y9lCNJIdAhmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wloejd3PA4ZPGwUgtdNj0Id86MeohJvqvUCAZ4GUl190owqdPlq1l27iHvEDf0/bhZrg852TNsPU58vnvWTCGkq/KKBVWNJj16a3nXchME4hdYtmPGMME5ZNLUkQFvdgsnrC3jLK/zizyV73Dl6/CBVvssdSXxsoSP5KaTze2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24c3wpYzYQvBy
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 907971A1A31
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S3;
	Sat, 07 Jun 2025 23:22:54 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 01/14] arm64: insn: Add barrier encodings
Date: Sat,  7 Jun 2025 15:25:08 +0000
Message-Id: <20250607152521.2828291-2-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4rKF15ZF1rJF13trWfuFg_yoW8Kw4kp3
	ZYvr1fGr18WrZ5GFn2yryYqr43WFs5Kr43W347Ww1I9w4DJ345tF1vgr12vF4vkr12gF48
	JF42vr4F9rWUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7qjgUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Julien Thierry <jthierry@redhat.com>

[ Upstream commit d4b217330d7e0320084ff04c8491964f1f68980a ]

Create necessary functions to encode/decode aarch64 barrier
instructions.

DSB needs special case handling as it has multiple encodings.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Link: https://lore.kernel.org/r/20210303170536.1838032-7-jthierry@redhat.com
[will: Don't reject DSB #4]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/insn.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index d45b42295254..e16e43a1702b 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -370,6 +370,14 @@ __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
 __AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
 __AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
 __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
+__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
+__AARCH64_INSN_FUNCS(dsb_base,	0xFFFFF0FF, 0xD503309F)
+__AARCH64_INSN_FUNCS(dsb_nxs,	0xFFFFF3FF, 0xD503323F)
+__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)
+__AARCH64_INSN_FUNCS(sb,	0xFFFFFFFF, 0xD50330FF)
+__AARCH64_INSN_FUNCS(clrex,	0xFFFFF0FF, 0xD503305F)
+__AARCH64_INSN_FUNCS(ssbb,	0xFFFFFFFF, 0xD503309F)
+__AARCH64_INSN_FUNCS(pssbb,	0xFFFFFFFF, 0xD503349F)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -381,6 +389,19 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
 	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
 }
 
+static inline bool aarch64_insn_is_dsb(u32 insn)
+{
+	return aarch64_insn_is_dsb_base(insn) || aarch64_insn_is_dsb_nxs(insn);
+}
+
+static inline bool aarch64_insn_is_barrier(u32 insn)
+{
+	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
+	       aarch64_insn_is_isb(insn) || aarch64_insn_is_sb(insn) ||
+	       aarch64_insn_is_clrex(insn) || aarch64_insn_is_ssbb(insn) ||
+	       aarch64_insn_is_pssbb(insn);
+}
+
 int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
-- 
2.34.1


