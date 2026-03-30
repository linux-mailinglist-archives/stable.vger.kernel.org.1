Return-Path: <stable+bounces-231256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALtmEDmiymmx+gUAu9opvQ
	(envelope-from <stable+bounces-231256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 18:18:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BF35E9BA
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE2273028EB8
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A437756D;
	Mon, 30 Mar 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MKZ0QgqS"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FC6373C1E;
	Mon, 30 Mar 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887441; cv=none; b=BSNaTZ49mp2M6jtkmbxyur/SF/Lci1ONaM7IWMekJ6IycOFq8uNuq/Xgo9HdZ0OV3aMJYTImi2ObtQYTGf5MU1T0f3PLS0alrTspgBjt/qa/ON2etCX7dWpWOZLaac36BAPhIVFSN2cN/fm2TqJlXYiQwtxCO2UF9tSzW9+0BiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887441; c=relaxed/simple;
	bh=r3k1Z9klFrD/nffPa33a1oaZbeOO3hVcdWdTsDunBW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLIgX1RBSRUrfEoUmlsdi30yhXzkbafEXhWEyj0LsKZw3MJK2/sjOzpSMJ3OvtHmLD6LMBuGoxHesmVs7Rqxnd/uw85O0IhooFLo2lfiDwH5uymn8USCLH3Ojg2eTdZXt8yM31fBc89sZqhixDNvRmlVes8wg4pg0a+6yurYpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MKZ0QgqS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D5A41F91;
	Mon, 30 Mar 2026 09:17:13 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7227E3F7D8;
	Mon, 30 Mar 2026 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774887438; bh=r3k1Z9klFrD/nffPa33a1oaZbeOO3hVcdWdTsDunBW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKZ0QgqSC/inGWaruxli87p2e6u7URCxf5VZuE5dzt8UI6bNwj38vs2twFzDezEJX
	 N2h65vH3wjrPJipyZpuZWaRkWkGMYTVNsEQZcJK45X5B4+Of5g/KVaBll7Lcpmi8Iy
	 jlvMvgvjrCUo1+lDzv9wXKCx6D3PJsz4iO3VpfbQ=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support for realm guests
Date: Mon, 30 Mar 2026 17:17:02 +0100
Message-ID: <20260330161705.3349825-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330161705.3349825-1-ryan.roberts@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231256-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:email,arm.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: C43BF35E9BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Fixes: a166563e7ec37 ("arm64: mm: support large block mapping when rodata=full")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/mmu.h |  2 ++
 arch/arm64/mm/init.c         |  9 +++++++-
 arch/arm64/mm/mmu.c          | 45 +++++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 137a173df1ff8..472610433aaea 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -112,5 +112,7 @@ void kpti_install_ng_mappings(void);
 static inline void kpti_install_ng_mappings(void) {}
 #endif
 
+extern bool page_alloc_available;
+
 #endif	/* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 96711b8578fd0..b9b248d24fd10 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -350,7 +350,6 @@ void __init arch_mm_preinit(void)
 	}
 
 	swiotlb_init(swiotlb, flags);
-	swiotlb_update_mem_attributes();
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
@@ -377,6 +376,14 @@ void __init arch_mm_preinit(void)
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
index a6a00accf4f93..223947487a223 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -768,30 +768,51 @@ static inline bool force_pte_mapping(void)
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
@@ -891,8 +912,6 @@ static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp
 	return ret;
 }
 
-static bool linear_map_requires_bbml2 __initdata;
-
 u32 idmap_kpti_bbml2_flag;
 
 static void __init init_idmap_kpti_bbml2_flag(void)
-- 
2.43.0


