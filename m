Return-Path: <stable+bounces-12242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B88324FC
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 08:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5971F23ADD
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA158F5B;
	Fri, 19 Jan 2024 07:19:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC06FB0
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648757; cv=none; b=lqGWtIkJDjnWfcVOXSUcpB1HP1Rmr45ws9pIVilQcxrtRQnveqxPTFSExdO26XsHrSYl2Cqtkzn8XB3HZc+5OFX7V+UKIGb4pCkpEOliYAFIg0+YDLkjBQgy8osCBU+QxGOWMMqja0Uq4c9BT6CKcbXmWXmfMY5MrdY+xGbDv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648757; c=relaxed/simple;
	bh=aTwua2ZjP6eM7ptBaufdfAqj8CDH2OcpybQlk6NDGzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hyotn83Qpztrvhsr0fhUhSIb5XGISmO57Ws/O3djEIkfe4C895W3h1+eJwLhKEumX7zdlRH9ok5QKE32Y6Qof6UOdOP5ZXPUz1Xn8xON0nB+zhYX8rgmkOhyfU34w8iSWKVfXKK5V2pHTtq3vkDKR2qknlTJ3YAa6PGXoLu9nEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.128.250])
	by gateway (Coremail) with SMTP id _____8DxWPBvIqpl3f0BAA--.9582S3;
	Fri, 19 Jan 2024 15:19:11 +0800 (CST)
Received: from crazy.crazy.loongson.org (unknown [10.180.128.250])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c5tIqplSmcKAA--.52075S6;
	Fri, 19 Jan 2024 15:19:11 +0800 (CST)
From: liweihao <liweihao@loongson.cn>
To: kernel@openeuler.org
Cc: liweihao@loongson.cn,
	WANG Rui <wangrui@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH OLK-5.10 2/3] LoongArch: Fix return value underflow in exception path
Date: Fri, 19 Jan 2024 15:19:08 +0800
Message-Id: <20240119071909.339939-3-liweihao@loongson.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119071909.339939-1-liweihao@loongson.cn>
References: <20240119071909.339939-1-liweihao@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c5tIqplSmcKAA--.52075S6
X-CM-SenderInfo: 5olzvxhkdrqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr45CFyfWF4fKr17GF4kuFX_yoW8tF4rpr
	y7Arn7KF48WFyfZas0vF9Yqr48XF47WwnruF4xAryrWa4DZrn5uryrGa9xXFsxX395Xr10
	qrWrKF4rCF48JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EeHDUU
	UUU==

From: WANG Rui <wangrui@loongson.cn>

LoongArch inclusion
bugzilla: https://gitee.com/openeuler/kernel/issues/I76XQZ

This patch fixes an underflow issue in the return value within the
exception path, specifically at .Llt8 when the remaining length is less
than 8 bytes.

Cc: stable@vger.kernel.org
Fixes: 8941e93ca590 ("LoongArch: Optimize memory ops (memset/memcpy/memmove)")
Reported-by: Weihao Li <liweihao@loongson.cn>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/lib/clear_user.S | 3 ++-
 arch/loongarch/lib/copy_user.S  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
index fd1d62b244f2..9dcf71719387 100644
--- a/arch/loongarch/lib/clear_user.S
+++ b/arch/loongarch/lib/clear_user.S
@@ -108,6 +108,7 @@ SYM_FUNC_START(__clear_user_fast)
 	addi.d	a3, a2, -8
 	bgeu	a0, a3, .Llt8
 15:	st.d	zero, a0, 0
+	addi.d	a0, a0, 8
 
 .Llt8:
 16:	st.d	zero, a2, -8
@@ -188,7 +189,7 @@ SYM_FUNC_START(__clear_user_fast)
 	_asm_extable 13b, .L_fixup_handle_0
 	_asm_extable 14b, .L_fixup_handle_1
 	_asm_extable 15b, .L_fixup_handle_0
-	_asm_extable 16b, .L_fixup_handle_1
+	_asm_extable 16b, .L_fixup_handle_0
 	_asm_extable 17b, .L_fixup_handle_s0
 	_asm_extable 18b, .L_fixup_handle_s0
 	_asm_extable 19b, .L_fixup_handle_s0
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
index b21f6d5d38f5..fecd08cad702 100644
--- a/arch/loongarch/lib/copy_user.S
+++ b/arch/loongarch/lib/copy_user.S
@@ -136,6 +136,7 @@ SYM_FUNC_START(__copy_user_fast)
 	bgeu	a1, a4, .Llt8
 30:	ld.d	t0, a1, 0
 31:	st.d	t0, a0, 0
+	addi.d	a0, a0, 8
 
 .Llt8:
 32:	ld.d	t0, a3, -8
@@ -246,7 +247,7 @@ SYM_FUNC_START(__copy_user_fast)
 	_asm_extable 30b, .L_fixup_handle_0
 	_asm_extable 31b, .L_fixup_handle_0
 	_asm_extable 32b, .L_fixup_handle_0
-	_asm_extable 33b, .L_fixup_handle_1
+	_asm_extable 33b, .L_fixup_handle_0
 	_asm_extable 34b, .L_fixup_handle_s0
 	_asm_extable 35b, .L_fixup_handle_s0
 	_asm_extable 36b, .L_fixup_handle_s0
-- 
2.39.2


