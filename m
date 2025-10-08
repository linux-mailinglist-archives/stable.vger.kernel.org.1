Return-Path: <stable+bounces-183589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B415CBC3B8C
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4A8A4E15D3
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 07:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465C2F0C73;
	Wed,  8 Oct 2025 07:50:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AE1E5B7B;
	Wed,  8 Oct 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909858; cv=none; b=EPsrQwCg3qB3SJp6U7ZlvEJBsLFz+ako84hfRbWYMzu5ASQyiTd0aKtDGEE02tnJdF3CLDy6eqvIerxMcHXTwSgLJofoCYHe5hCmjNCvXISFFnb6dIZ0721PCuoPKF36T+aHMMn5O4+3hx5oOo3JvhbWXP3P/mh/BiS6Xjm4J+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909858; c=relaxed/simple;
	bh=px9Lr1+HC+LthT8zAWS5s3VKv1z0Z0pYU6ur6uCZNCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmhWEfg0kxVIiZg9pgvZ52dXC7kXA1DysyHf/OVpAMAfuNG+CVQNvP+Ga53UfjDBEeBkyvwgsJ8K3Q2IJhcBKcABeldSZA9ejP6/i2ODnY9HBUBfsO0fz4WWhXZKgFLyfB3KTxlC1Jxpd6e8TutqdjZZCWJenAnG09HifAp9GXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowAA3kaPLF+ZoUI4EDQ--.32936S4;
	Wed, 08 Oct 2025 15:50:36 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 08 Oct 2025 15:50:17 +0800
Subject: [PATCH 6.6.y 2/2] riscv: mm: Do not restrict mmap address based on
 hint
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-riscv-mmap-addr-space-6-6-v1-2-9f47574a520f@iscas.ac.cn>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
In-Reply-To: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
To: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Guo Ren <guoren@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, 
 Yangyu Chen <cyy@cyyself.name>, Han Gao <rabenda.cn@gmail.com>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, 
 Palmer Dabbelt <palmer@rivosinc.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAA3kaPLF+ZoUI4EDQ--.32936S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DWF1furyUZr4kZFyDAwb_yoW8uFykpF
	Zakanakr1vkry7trZrAr47uF18tan8KFy2grW0grnYkr1YvFW7Xr4Ik3WkZF1UZFW09a1F
	vF1fCasYva4UJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit 2116988d5372aec51f8c4fb85bf8e305ecda47a0 ]

The hint address should not forcefully restrict the addresses returned
by mmap as this causes mmap to report ENOMEM when there is memory still
available.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: b5b4287accd7 ("riscv: mm: Use hint address in mmap if available")
Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Closes: https://lore.kernel.org/linux-kernel/ZbxTNjQPFKBatMq+@ghost/T/#mccb1890466bf5a488c9ce7441e57e42271895765
Link: https://lore.kernel.org/r/20240826-riscv_mmap-v1-3-cd8962afe47f@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[ Adjust removed lines ]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 arch/riscv/include/asm/processor.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 938aef30dfb42ee477b7c59b5d2afc3871d8004d..4747277983ad1a2a9666c03a4e69758f56d22dbc 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -15,30 +15,12 @@
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
-	unsigned long mmap_end;					\
-	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 ||					\
-	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
-		mmap_end = STACK_TOP_MAX;			\
-	else							\
-		mmap_end = (_addr + len);			\
-	mmap_end;						\
+	STACK_TOP_MAX;						\
 })
 
 #define arch_get_mmap_base(addr, base)				\
 ({								\
-	unsigned long mmap_base;				\
-	typeof(addr) _addr = (addr);				\
-	typeof(base) _base = (base);				\
-	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 ||					\
-	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
-		mmap_base = (_base);				\
-	else							\
-		mmap_base = (_addr + len) - rnd_gap;		\
-	mmap_base;						\
+	base;							\
 })
 
 #ifdef CONFIG_64BIT

-- 
2.50.1


