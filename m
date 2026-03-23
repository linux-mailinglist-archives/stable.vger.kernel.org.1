Return-Path: <stable+bounces-227975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMoTHIs6wWn2RgQAu9opvQ
	(envelope-from <stable+bounces-227975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:05:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FD2F2797
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 018C93018F15
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD73AA4E7;
	Mon, 23 Mar 2026 13:03:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F471B4223;
	Mon, 23 Mar 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271013; cv=none; b=agFADmg6BqZNLN7rL5HgFm9OPLqmFQ3/0+MywNQ08UnIhQyrdjnOXeGbIVZban9kTkGhWmgTlsu3y/X4vw3M64nhQ6EivoOXnX6OLKDsvXGw8XWMspxk8w8xTDuu1HGQ0u9qrb+JZ+W+lEd2bAVf/wgCT+KfRka+sSlhi7STijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271013; c=relaxed/simple;
	bh=i+0PDLQo9WcEt2mlaqbT2dwD07UT1Dej2cEKg/tyZo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFcVUh8CehkJInMitseewDIE9WFaURix7N4ApEYrizYZa8WLevQAKentb0C6pmzLTSe5F86dBNYpG88z0F8C9vlXVEFLgxUgLevlbpv7COa/S1M62Wpz+b3BGKzCg3MSlsroXTB4YWmPkCA2lCHaYHOft6mrSYK1Z5Psm8Ma1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3710B1516;
	Mon, 23 Mar 2026 06:03:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 770CD3F885;
	Mon, 23 Mar 2026 06:03:29 -0700 (PDT)
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
Subject: [PATCH v1 1/3] arm64: mm: Fix rodata=full block mapping support for realm guests
Date: Mon, 23 Mar 2026 13:03:13 +0000
Message-ID: <20260323130317.1737522-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323130317.1737522-1-ryan.roberts@arm.com>
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227975-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: 2C6FD2F2797
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
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/init.c |  9 ++++++++-
 arch/arm64/mm/mmu.c  | 35 +++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 9 deletions(-)

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
index a6a00accf4f93..5b6a8d53e64b7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -773,14 +773,33 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
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
+	if (!system_supports_bbml2_noabort()) {
+		/*
+		 * !BBML2_NOABORT systems should not be trying to change
+		 * permissions on anything that is not pte-mapped in the first
+		 * place. Just return early and let the permission change code
+		 * raise a warning if not already pte-mapped.
+		 */
+		if (system_capabilities_finalized() ||
+		    !cpu_supports_bbml2_noabort())
+			return 0;
+
+		/*
+		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
+		 * page allocator. Can't split until it's available.
+		 */
+		extern bool page_alloc_available;
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
 
 	/*
 	 * If the region is within a pte-mapped area, there is no need to try to
-- 
2.43.0


