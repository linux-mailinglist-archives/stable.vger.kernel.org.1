Return-Path: <stable+bounces-241680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJJ7HxPG8GloYQEAu9opvQ
	(envelope-from <stable+bounces-241680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:37:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 345994871D6
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE56B3047A2D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB438A70E;
	Tue, 28 Apr 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbCXFLyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A937F8AF
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386762; cv=none; b=BsyjU2vSupDVt7s4S+dtbOtJCaDIUxlMfSb8YG+ffqbeVu0CnHx2+yrjqGU1p0BIi7cJHPCGHwIJRTOtC9VYYyIKnJzbHa5uUFfxtPoB8YtRG9YO6uqC32fHfNqXPRxCEiT+c2ACOKdYnzniyi7B+uFldeTSFidGwCsryYwW8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386762; c=relaxed/simple;
	bh=twidEE97n68ehrZnnp4SUdHpdcpplnCErrpCI9l7Rzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq/Buql0Me26R6eL3ua15G3lsv0Is/w7+UwWcAcOA/xeugdxccT5bsHlHix6Y8LKoblnICYDzHA0WbnF0iayPvRBypUJS1QDV/IgGhpBINP1PpgdLUdhv6Fe4L1ZF7RfNqg+wex496W2UbILdvvUEyE5Eqi9QmphCP1tsV0mQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbCXFLyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B73CC2BCAF;
	Tue, 28 Apr 2026 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777386761;
	bh=twidEE97n68ehrZnnp4SUdHpdcpplnCErrpCI9l7Rzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbCXFLyLSgWcBN+Wsu9AIfIOdiuyXPlzbO0PbsRaP57w4rZjA7BUP145x4e3DIKEe
	 WflxkqeTak7O0KFuOg96imyRp8RPualuNsSwUDOhvkIvp9ry7F3xkQuTxIzhhbyhR6
	 +EENg+zZDzyaffeymWb7q/t8TUcXiMYb7CbpaXiz9LrRWdJ8i/1pqJxmPBho8+LgKo
	 UrYrehDyUHbsN88SsTs8Q7LJNSgs0W4/js5lOVccigHTslqcxQElP9/EKkY2V4uPWX
	 92cy55yqtLNnqOuCRhDK3x+hOT1WwxGZgMcG8G2olbWTK1IAwqurlR9bgZl5eF1jR7
	 /fF9mfMqs3QmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] arm64: mm: Fix rodata=full block mapping support for realm guests
Date: Tue, 28 Apr 2026 10:32:38 -0400
Message-ID: <20260428143238.2960283-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428143238.2960283-1-sashal@kernel.org>
References: <2026042741-lagged-ricotta-aa8b@gregkh>
 <20260428143238.2960283-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 345994871D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241680-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,huawei.com:email]

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit f12b435de2f2bb09ce406467020181ada528844c ]

Commit a166563e7ec37 ("arm64: mm: support large block mapping when
rodata=full") enabled the linear map to be mapped by block/cont while
still allowing granular permission changes on BBML2_NOABORT systems by
lazily splitting the live mappings. This mechanism was intended to be
usable by realm guests since they need to dynamically share dma buffers
with the host by "decrypting" them - which for Arm CCA, means marking
them as shared in the page tables.

However, it turns out that the mechanism was failing for realm guests
because realms need to share their dma buffers (via
__set_memory_enc_dec()) much earlier during boot than
split_kernel_leaf_mapping() was able to handle. The report linked below
showed that GIC's ITS was one such user. But during the investigation I
found other callsites that could not meet the
split_kernel_leaf_mapping() constraints.

The problem is that we block map the linear map based on the boot CPU
supporting BBML2_NOABORT, then check that all the other CPUs support it
too when finalizing the caps. If they don't, then we stop_machine() and
split to ptes. For safety, split_kernel_leaf_mapping() previously
wouldn't permit splitting until after the caps were finalized. That
ensured that if any secondary cpus were running that didn't support
BBML2_NOABORT, we wouldn't risk breaking them.

I've fix this problem by reducing the black-out window where we refuse
to split; there are now 2 windows. The first is from T0 until the page
allocator is inititialized. Splitting allocates memory for the page
allocator so it must be in use. The second covers the period between
starting to online the secondary cpus until the system caps are
finalized (this is a very small window).

All of the problematic callers are calling __set_memory_enc_dec() before
the secondary cpus come online, so this solves the problem. However, one
of these callers, swiotlb_update_mem_attributes(), was trying to split
before the page allocator was initialized. So I have moved this call
from arch_mm_preinit() to mem_init(), which solves the ordering issue.

I've added warnings and return an error if any attempt is made to split
in the black-out windows.

Note there are other issues which prevent booting all the way to user
space, which will be fixed in subsequent patches.

Reported-by: Jinjiang Tu <tujinjiang@huawei.com>
Closes: https://lore.kernel.org/all/0b2a4ae5-fc51-4d77-b177-b2e9db74f11d@huawei.com/
Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ adjusted context to use `__ASSEMBLY__` instead of `__ASSEMBLER__` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/mmu.h |  2 ++
 arch/arm64/mm/init.c         |  9 +++++++-
 arch/arm64/mm/mmu.c          | 45 +++++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 78a4dbf75e602..c5d187769c6c9 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -112,5 +112,7 @@ void kpti_install_ng_mappings(void);
 static inline void kpti_install_ng_mappings(void) {}
 #endif
 
+extern bool page_alloc_available;
+
 #endif	/* !__ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 524d34a0e9219..341ae4f15845e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -357,7 +357,6 @@ void __init arch_mm_preinit(void)
 	}
 
 	swiotlb_init(swiotlb, flags);
-	swiotlb_update_mem_attributes();
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
@@ -384,6 +383,14 @@ void __init arch_mm_preinit(void)
 	}
 }
 
+bool page_alloc_available __ro_after_init;
+
+void __init mem_init(void)
+{
+	page_alloc_available = true;
+	swiotlb_update_mem_attributes();
+}
+
 void free_initmem(void)
 {
 	void *lm_init_begin = lm_alias(__init_begin);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index bffb01ee04147..f869887d4166d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -774,30 +774,51 @@ static inline bool force_pte_mapping(void)
 }
 
 static DEFINE_MUTEX(pgtable_split_lock);
+static bool linear_map_requires_bbml2;
 
 int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 {
 	int ret;
 
-	/*
-	 * !BBML2_NOABORT systems should not be trying to change permissions on
-	 * anything that is not pte-mapped in the first place. Just return early
-	 * and let the permission change code raise a warning if not already
-	 * pte-mapped.
-	 */
-	if (!system_supports_bbml2_noabort())
-		return 0;
-
 	/*
 	 * If the region is within a pte-mapped area, there is no need to try to
 	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
 	 * change permissions from atomic context so for those cases (which are
 	 * always pte-mapped), we must not go any further because taking the
-	 * mutex below may sleep.
+	 * mutex below may sleep. Do not call force_pte_mapping() here because
+	 * it could return a confusing result if called from a secondary cpu
+	 * prior to finalizing caps. Instead, linear_map_requires_bbml2 gives us
+	 * what we need.
 	 */
-	if (force_pte_mapping() || is_kfence_address((void *)start))
+	if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))
 		return 0;
 
+	if (!system_supports_bbml2_noabort()) {
+		/*
+		 * !BBML2_NOABORT systems should not be trying to change
+		 * permissions on anything that is not pte-mapped in the first
+		 * place. Just return early and let the permission change code
+		 * raise a warning if not already pte-mapped.
+		 */
+		if (system_capabilities_finalized())
+			return 0;
+
+		/*
+		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
+		 * page allocator. Can't split until it's available.
+		 */
+		if (WARN_ON(!page_alloc_available))
+			return -EBUSY;
+
+		/*
+		 * Boot-time: Started secondary cpus but don't know if they
+		 * support BBML2_NOABORT yet. Can't allow splitting in this
+		 * window in case they don't.
+		 */
+		if (WARN_ON(num_online_cpus() > 1))
+			return -EBUSY;
+	}
+
 	/*
 	 * Ensure start and end are at least page-aligned since this is the
 	 * finest granularity we can split to.
@@ -897,8 +918,6 @@ static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp
 	return ret;
 }
 
-static bool linear_map_requires_bbml2 __initdata;
-
 u32 idmap_kpti_bbml2_flag;
 
 static void __init init_idmap_kpti_bbml2_flag(void)
-- 
2.53.0


