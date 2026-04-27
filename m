Return-Path: <stable+bounces-241405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOqjFYiS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72832476A0D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2210C3008D0E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50FE3CF69A;
	Mon, 27 Apr 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPVF9w9J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF43A168C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308197; cv=none; b=dnhvxmaqWTT7atVQYgd0hWPMG9vmbNaR19zN/reNBkkGpm4NihkcUCEZttypCosu9ekfbzdinWyHjvCOHUwZYr534+GwLfGh/h11rXVV1IBJZSa1AO3eTQTOeWoFRAK0BWzAHU6vWSXcsh5QAo++5CfaDRFvqSurPd3JqplDqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308197; c=relaxed/simple;
	bh=+Q4rZ/1lbki5FCCVvhBq+K/f4Ko78eZ4f9cITy9X9Ds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ofxSEa+XJbfS9weFpdzkcMPJ9oypQLLSXr9VFgyptY+74EULMWifZGs44dTj33WrscQZsHUWVOG3CO+zCBP9OiNgGVdIjiN6Cll5jSxLF7oyoS44BKO7PYnNzZ0A2J3pfBK2BSSQTaZFIOoMBTRV0FcPGiTHPDVfUM5mkbUCOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPVF9w9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B82C19425;
	Mon, 27 Apr 2026 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777308197;
	bh=+Q4rZ/1lbki5FCCVvhBq+K/f4Ko78eZ4f9cITy9X9Ds=;
	h=Subject:To:Cc:From:Date:From;
	b=FPVF9w9J63f0Ugf3IOLdXP8JadIm0Wuq22m1f6guScGYKTXlXxWXgnb45tJuajy3x
	 sl9OuEUkgg8B+mlaPBnwU4lF0ufrPC7uOI6PWJyA2oGV6acskL/Ml/mlhbTigTzqF5
	 P/wCm3GQ1Mci6m+WkSXnIHP8JJSe30lSpDCEFq80=
Subject: FAILED: patch "[PATCH] arm64: mm: Fix rodata=full block mapping support for realm" failed to apply to 6.18-stable tree
To: ryan.roberts@arm.com,catalin.marinas@arm.com,kevin.brodsky@arm.com,suzuki.poulose@arm.com,tujinjiang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:42:41 -0600
Message-ID: <2026042741-lagged-ricotta-aa8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72832476A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241405-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f12b435de2f2bb09ce406467020181ada528844c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042741-lagged-ricotta-aa8b@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f12b435de2f2bb09ce406467020181ada528844c Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Mon, 30 Mar 2026 17:17:02 +0100
Subject: [PATCH] arm64: mm: Fix rodata=full block mapping support for realm
 guests

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

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 137a173df1ff..472610433aae 100644
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
index 96711b8578fd..b9b248d24fd1 100644
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
index a6a00accf4f9..223947487a22 100644
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


