Return-Path: <stable+bounces-222366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LMfIoOko2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:29:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1A1CD995
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CE5357DFB4
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0179C305047;
	Sun,  1 Mar 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGg9CiZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867B303CA0;
	Sun,  1 Mar 2026 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330700; cv=none; b=nbq5om2BGW2PDwrIUUbrF8buRm+EW9na5xDHr7DOD45vtDvdRBADhB237Edj6KtJwIwqB+iLPfadeKIbTydraH8/xTIiWniQUestpZ7CTW2BOwosPNLPtKaKP6hQbl+9Vz7U597xdszYGwf/yM9MwvAouKVJB7js+Tzn8QwzKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330700; c=relaxed/simple;
	bh=ErYRIwyllTz/uwQ1UcASlYhuxP8D85VWxNe97VEB03w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGNFUsa2aAQq/0dvmAl5Wf8mHQ+XRwSBhH4NdmqLMLSRKrKiIbr/srnShcTV6tNNwKaAJlktemfJZ4PVyQaeROC68X5YJ5shMiOJhfhfXqoEiq1O3daMMKxzT7v3nSLjcIhM2YLgihgT4jzgSyUIWnQBdKCDE+ZRQfa0Cs7Bsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGg9CiZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0ABC19421;
	Sun,  1 Mar 2026 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330700;
	bh=ErYRIwyllTz/uwQ1UcASlYhuxP8D85VWxNe97VEB03w=;
	h=From:To:Cc:Subject:Date:From;
	b=iGg9CiZovlLH1c2McOExqjzlpu4jgSBqknGEitXAZsMd73dgZhdv63+ls3opKdtky
	 0uaZA185kWL8pyvneW4XwMbkDlpE8172rppCfkl0oyE2bXuEHRDGeC8fakvJNcKSZ1
	 XVS6Xgx2aDFyx5Cc7Kk482dcduMWlS7YgaJkUq/TvN+85ViTrtNRbUsEu0XVBH60eE
	 YsDKtVrpioOO9EyKsjXtB6qB/M8dkYTJbuQb0LHWjnBeDXqbBN7kwYwpOz2ym8vAvm
	 K3ivlHlfSphwpK8JMxeg698ckEig9ASFmkGnuXDcQVU78DeE1m1nCC4leK+nu0Khqd
	 tLYs9vgm0C5Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	kasan-dev@googlegroups.com,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Rework KASAN initialization for PTW-enabled systems" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:04:58 -0500
Message-ID: <20260301020458.1733544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222366-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32E1A1CD995
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:17 +0800
Subject: [PATCH] LoongArch: Rework KASAN initialization for PTW-enabled
 systems

kasan_init_generic() indicates that kasan is fully initialized, so it
should be put at end of kasan_init().

Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
on PTW-enabled systems, here are the call chains:

    kernel_entry()
      start_kernel()
        setup_arch()
          kasan_init()
            kasan_init_generic()

The reason is PTW-enabled systems have speculative accesses which means
memory accesses to the shadow memory after kasan_init() may be executed
by hardware before. However, accessing shadow memory is safe only after
kasan fully initialized because kasan_init() uses a temporary PGD table
until we have populated all levels of shadow page tables and writen the
PGD register. Moving kasan_init_generic() later can defer the occasion
of kasan_enabled(), so as to avoid speculative accesses on shadow pages.

After moving kasan_init_generic() to the end, kasan_init() can no longer
call kasan_mem_to_shadow() for shadow address conversion because it will
always return kasan_early_shadow_page. On the other hand, we should keep
the current logic of kasan_mem_to_shadow() for both the early and final
stage because there may be instrumentation before kasan_init().

To solve this, we factor out a new mem_to_shadow() function from current
kasan_mem_to_shadow() for the shadow address conversion in kasan_init().

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/kasan_init.c | 78 +++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 170da98ad4f55..0fc02ca064573 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,39 +40,43 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-void *kasan_mem_to_shadow(const void *addr)
+static void *mem_to_shadow(const void *addr)
 {
-	if (!kasan_enabled()) {
+	unsigned long offset = 0;
+	unsigned long maddr = (unsigned long)addr;
+	unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
+
+	if (maddr >= FIXADDR_START)
 		return (void *)(kasan_early_shadow_page);
-	} else {
-		unsigned long maddr = (unsigned long)addr;
-		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
-		unsigned long offset = 0;
-
-		if (maddr >= FIXADDR_START)
-			return (void *)(kasan_early_shadow_page);
-
-		maddr &= XRANGE_SHADOW_MASK;
-		switch (xrange) {
-		case XKPRANGE_CC_SEG:
-			offset = XKPRANGE_CC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_UC_SEG:
-			offset = XKPRANGE_UC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_WC_SEG:
-			offset = XKPRANGE_WC_SHADOW_OFFSET;
-			break;
-		case XKVRANGE_VC_SEG:
-			offset = XKVRANGE_VC_SHADOW_OFFSET;
-			break;
-		default:
-			WARN_ON(1);
-			return NULL;
-		}
 
-		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+	maddr &= XRANGE_SHADOW_MASK;
+	switch (xrange) {
+	case XKPRANGE_CC_SEG:
+		offset = XKPRANGE_CC_SHADOW_OFFSET;
+		break;
+	case XKPRANGE_UC_SEG:
+		offset = XKPRANGE_UC_SHADOW_OFFSET;
+		break;
+	case XKPRANGE_WC_SEG:
+		offset = XKPRANGE_WC_SHADOW_OFFSET;
+		break;
+	case XKVRANGE_VC_SEG:
+		offset = XKVRANGE_VC_SHADOW_OFFSET;
+		break;
+	default:
+		WARN_ON(1);
+		return NULL;
 	}
+
+	return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+}
+
+void *kasan_mem_to_shadow(const void *addr)
+{
+	if (kasan_enabled())
+		return mem_to_shadow(addr);
+	else
+		return (void *)(kasan_early_shadow_page);
 }
 
 const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -293,11 +297,8 @@ void __init kasan_init(void)
 	/* Maps everything to a single page of zeroes */
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE, true);
 
-	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
-					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
-
-	/* Enable KASAN here before kasan_mem_to_shadow(). */
-	kasan_init_generic();
+	kasan_populate_early_shadow(mem_to_shadow((void *)VMALLOC_START),
+					mem_to_shadow((void *)KFENCE_AREA_END));
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
@@ -307,13 +308,13 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
-			(unsigned long)kasan_mem_to_shadow(end), NUMA_NO_NODE);
+		kasan_map_populate((unsigned long)mem_to_shadow(start),
+			(unsigned long)mem_to_shadow(end), NUMA_NO_NODE);
 	}
 
 	/* Populate modules mapping */
-	kasan_map_populate((unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR),
-		(unsigned long)kasan_mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
+	kasan_map_populate((unsigned long)mem_to_shadow((void *)MODULES_VADDR),
+		(unsigned long)mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
 	/*
 	 * KAsan may reuse the contents of kasan_early_shadow_pte directly, so we
 	 * should make sure that it maps the zero page read-only.
@@ -328,4 +329,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
-- 
2.51.0





