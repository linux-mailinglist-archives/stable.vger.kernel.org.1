Return-Path: <stable+bounces-234877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNNbIbOi1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C73C186E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 630633038F0D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4573AEF5F;
	Wed,  8 Apr 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tZdnTgnT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EF3624B9;
	Wed,  8 Apr 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673994; cv=none; b=HMXbiNt2z71Z2voNMesVyCSALM6Yl9Hzh38fIKhkoh8yi+n6PmqAPWUvA5k3vjv74hk7oMi7C4jDvRHji6yw4mglFTjqyTbWYIgIfyjQUaBbQQegIbyHajmp/aagcUGiX4c2/chxuoFruB9/7pkfH1iDW2Tf8RttLOi8kQA64Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673994; c=relaxed/simple;
	bh=mhJNsNwV42U+0Pp/j4ERyyyaLqHrbHv1MlADu+FWkpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY4lrRuy5Qrn1CV+5ueeL3F/sHPpU/f0EQLU5HdKEICTFzeCQbXUdYzFobnrrxb1dTkZ0tENdAOH8/PZhp0YWrkxx/W2yU5GJpORe15jxpx9Zna4y+OMOW2QUwSRmQTDRJLpcuBzIfScM1NEa+MDu8PFt+ELq/Pn68GmZKqtSiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tZdnTgnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74ACC2BC87;
	Wed,  8 Apr 2026 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673994;
	bh=mhJNsNwV42U+0Pp/j4ERyyyaLqHrbHv1MlADu+FWkpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZdnTgnTQsJIFg+RL1+dfhBHe02UoJjNSQER8tlXKpPJo4f2LSrRZ25xRF67MojIx
	 PIo2cZFGdihGQ4QCqr0ynW5QABqBqFblaJj/HtOQMmpVtGWsOwRLsBNX/NzI1vnGkF
	 qSj3rM9KolzqNQmE6QNIsrHdXiKkWr95odiDFyic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 168/242] Revert "LoongArch: Handle percpu handler address for ORC unwinder"
Date: Wed,  8 Apr 2026 20:03:28 +0200
Message-ID: <20260408175933.376731129@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234877-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 485C73C186E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 8eeb34ae9d4c743b1fd2cf58f9c51def37091cf5.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/setup.h |  3 ---
 arch/loongarch/kernel/unwind_orc.c | 16 +---------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index f81375e5e89c0..3c2fb16b11b64 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -7,7 +7,6 @@
 #define _LOONGARCH_SETUP_H
 
 #include <linux/types.h>
-#include <linux/threads.h>
 #include <asm/sections.h>
 #include <uapi/asm/setup.h>
 
@@ -15,8 +14,6 @@
 
 extern unsigned long eentry;
 extern unsigned long tlbrentry;
-extern unsigned long pcpu_handlers[NR_CPUS];
-extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 extern char init_command_line[COMMAND_LINE_SIZE];
 extern void tlb_init(int cpu);
 extern void cpu_cache_init(void);
diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index e8b95f1bc5786..4924d1ecc4579 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -357,21 +357,7 @@ static bool is_entry_func(unsigned long addr)
 
 static inline unsigned long bt_address(unsigned long ra)
 {
-#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
-	int cpu;
-	int vec_sz = sizeof(exception_handlers);
-
-	for_each_possible_cpu(cpu) {
-		if (!pcpu_handlers[cpu])
-			continue;
-
-		if (ra >= pcpu_handlers[cpu] &&
-		    ra < pcpu_handlers[cpu] + vec_sz) {
-			ra = ra + eentry - pcpu_handlers[cpu];
-			break;
-		}
-	}
-#endif
+	extern unsigned long eentry;
 
 	if (ra >= eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
 		unsigned long func;
-- 
2.53.0




