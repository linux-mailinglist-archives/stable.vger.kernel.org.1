Return-Path: <stable+bounces-235878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHcJOtNW3GmYPgkAu9opvQ
	(envelope-from <stable+bounces-235878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:37:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9393E6CB2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AEE2300A632
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0F228CB0;
	Mon, 13 Apr 2026 02:37:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B817223323;
	Mon, 13 Apr 2026 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776047823; cv=none; b=G+99S8NDMloOymAONKMZDri6sM2+eIO8+dH8MBUiOJv1kwwi12uk8R8lZvKdgcclMrbg8jWeACVlorp8T7dBzXp2/ZTzYfCygaBi83cMRuI4TCmnyOZaeqnKDAUAXe8pmO0ORNBoFCFlx6TB0BCGZOedF0DZz5WLSUqpUus+J+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776047823; c=relaxed/simple;
	bh=PsL5db0nM1bEblz0+wTpxO7dvW4KkqmM588z1vTLkaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+oKA2IWFilEtVNK52PQh5yvFR2OY+v+Q6FWcAsIQyiuBCZxoP9jK4zQQry9xjTcEzwsJloyHqEA8vap+thHchgeNL5uR07briJKyQnoDMVtiEO4MKLokZxcc31pDqaQcWuDNU9y8LVNpFCHZFJPth3KOfwzUpsV0Ac5kdccCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8CxMvHKVtxpApwkAA--.2750S3;
	Mon, 13 Apr 2026 10:36:58 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJBx58DGVtxpGNJrAA--.42849S2;
	Mon, 13 Apr 2026 10:36:58 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 for 6.12] LoongArch: Handle percpu handler address for ORC unwinder
Date: Mon, 13 Apr 2026 10:36:47 +0800
Message-ID: <20260413023647.1368051-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx58DGVtxpGNJrAA--.42849S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF17AFW8Zr18Kw43WF1xWFX_yoW5WryxpF
	9Fkr4DKrW8Wryvva4qyFyj9r98Awn3Gw12qFWag34ruF12qa4fCrs2vrnFgFyDJ3y8XF1r
	Xas5G34Y9F45AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,loongson.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C9393E6CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 055c7e75190e0be43037bd663a3f6aced194416e ]

After commit 4cd641a79e69 ("LoongArch: Remove unnecessary checks for ORC
unwinder"), the system can not boot normally under some configs (such as
enable KASAN), there are many error messages "cannot find unwind pc".

The kernel boots normally with the defconfig, so no problem found out at
the first time. Here is one way to reproduce:

  cd linux
  make mrproper defconfig -j"$(nproc)"
  scripts/config -e KASAN
  make olddefconfig all -j"$(nproc)"
  sudo make modules_install
  sudo make install
  sudo reboot

The address that can not unwind is not a valid kernel address which is
between "pcpu_handlers[cpu]" and "pcpu_handlers[cpu] + vec_sz" due to
the code of eentry was copied to the new area of pcpu_handlers[cpu] in
setup_tlb_handler(), handle this special case to get the valid address
to unwind normally.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Add upstream commit ID.

 arch/loongarch/include/asm/setup.h |  3 +++
 arch/loongarch/kernel/unwind_orc.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 3c2fb16b11b6..f81375e5e89c 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -7,6 +7,7 @@
 #define _LOONGARCH_SETUP_H
 
 #include <linux/types.h>
+#include <linux/threads.h>
 #include <asm/sections.h>
 #include <uapi/asm/setup.h>
 
@@ -14,6 +15,8 @@
 
 extern unsigned long eentry;
 extern unsigned long tlbrentry;
+extern unsigned long pcpu_handlers[NR_CPUS];
+extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 extern char init_command_line[COMMAND_LINE_SIZE];
 extern void tlb_init(int cpu);
 extern void cpu_cache_init(void);
diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 5f256d75ab1e..7a9bc4754474 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -351,6 +351,22 @@ static inline unsigned long bt_address(unsigned long ra)
 {
 	extern unsigned long eentry;
 
+#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
+	int cpu;
+	int vec_sz = sizeof(exception_handlers);
+
+	for_each_possible_cpu(cpu) {
+		if (!pcpu_handlers[cpu])
+			continue;
+
+		if (ra >= pcpu_handlers[cpu] &&
+		    ra < pcpu_handlers[cpu] + vec_sz) {
+			ra = ra + eentry - pcpu_handlers[cpu];
+			break;
+		}
+	}
+#endif
+
 	if (ra >= eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
 		unsigned long func;
 		unsigned long type = (ra - eentry) / VECSIZE;
-- 
2.52.0


