Return-Path: <stable+bounces-235875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5pKJF69T3GnwPQkAu9opvQ
	(envelope-from <stable+bounces-235875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:23:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2113E6C3F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59B683009B01
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 02:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7F219A8A;
	Mon, 13 Apr 2026 02:23:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E41D61A3;
	Mon, 13 Apr 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776047019; cv=none; b=WPU40XtTSQ+0g+2QBwquC0m0pcR1zeemqyfV2+CtbdrEU2wAi4IIqEhVp9FqTkm2voafAzSX+fGybFVeLnzZ6t5pMzs2UGKI2qdAy3mB5JGe/tPdYQgrhOUfmp//fbZgVNjDEz4Vztbn1/sI3te867uXUpdhIToGKt7N2HXqx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776047019; c=relaxed/simple;
	bh=D80txS/XAztON5DTE6u+5jq0ffvc0iHsP/lFZtuoBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpLPoBCFzP8y2JMvNTPCDF5qCQNbRYyPu8NUqalNaYC0YqxU1aPFYlYeBiB8lueGZN30ZedsIjil8CKuu8QqHoNYweTpIopHFaFqAVLFEu5g+bpx5KBP4H/EB+uSNuSX1CH6oQStLY4wkAsgVaZ8106VgnohtPEcRjZz3M9IzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8AxRcGeU9xpQpskAA--.2681S3;
	Mon, 13 Apr 2026 10:23:26 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJDxxsCZU9xpRNBrAA--.42503S2;
	Mon, 13 Apr 2026 10:23:25 +0800 (CST)
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
Subject: [PATCH for 6.12] LoongArch: Remove unnecessary checks for ORC unwinder
Date: Mon, 13 Apr 2026 10:23:14 +0800
Message-ID: <20260413022314.1238307-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxxsCZU9xpRNBrAA--.42503S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar17JrWDJFW3Gr1DWrWxGrX_yoW8KFWxpF
	Z7Gw1UXrWxKryUW39rXryFqr90yFnxJ3WIgFZrGr9Yk3Z8Zw13Ar1j93WUKa1Dtry8Wa1f
	ZF4rArWqkayjyacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235875-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,loongson.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C2113E6C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tiezhu Yang <yangtiezhu@loongson.cn>

According to the following function definitions, __kernel_text_address()
already checks __module_text_address(), so it should remove the check of
__module_text_address() in bt_address() at least.

int __kernel_text_address(unsigned long addr)
{
	if (kernel_text_address(addr))
		return 1;
	...
	return 0;
}

int kernel_text_address(unsigned long addr)
{
	bool no_rcu;
	int ret = 1;
	...
	if (is_module_text_address(addr))
		goto out;
	...
	return ret;
}

bool is_module_text_address(unsigned long addr)
{
	guard(rcu)();
	return __module_text_address(addr) != NULL;
}

Furthermore, there are two checks of __kernel_text_address(), one is in
bt_address() and the other is after calling bt_address(), it looks like
redundant.

Handle the exception address first and then use __kernel_text_address()
to validate the calculated address for exception or the normal address
in bt_address(), then it can remove the check of __kernel_text_address()
after calling bt_address().

Just remove unnecessary checks, no functional changes intended.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/unwind_orc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 9001b5377c22..5f256d75ab1e 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -351,12 +351,6 @@ static inline unsigned long bt_address(unsigned long ra)
 {
 	extern unsigned long eentry;
 
-	if (__kernel_text_address(ra))
-		return ra;
-
-	if (__module_text_address(ra))
-		return ra;
-
 	if (ra >= eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
 		unsigned long func;
 		unsigned long type = (ra - eentry) / VECSIZE;
@@ -374,10 +368,13 @@ static inline unsigned long bt_address(unsigned long ra)
 			break;
 		}
 
-		return func + offset;
+		ra = func + offset;
 	}
 
-	return ra;
+	if (__kernel_text_address(ra))
+		return ra;
+
+	return 0;
 }
 
 bool unwind_next_frame(struct unwind_state *state)
@@ -500,9 +497,6 @@ bool unwind_next_frame(struct unwind_state *state)
 		goto err;
 	}
 
-	if (!__kernel_text_address(state->pc))
-		goto err;
-
 	preempt_enable();
 	return true;
 
-- 
2.52.0


