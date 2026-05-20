Return-Path: <stable+bounces-250868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AJdJ9/0DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:52:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBF594CC0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BE30327E800
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFC3EFD14;
	Wed, 20 May 2026 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jli6b7BW"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396727E045
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296516; cv=none; b=kBQyVvhOi2FA/H3trEQvfoAueCRnnkre9SUZijM58Xqf0m6NbjC5Hbs9cRmVJbkGytou4pePbfT3yd8N0mDfGZYvBfhWNDDTZmVuIr1COHABhN+zfuAdQ0XZv1p89Zk/SqfC5/wMHZ6CYip3nwd2TShHEoSLJtzr7sBg8dZER7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296516; c=relaxed/simple;
	bh=IMYx3KN4W/rs0qjLPQmuF1Ictk6EYTiYu8gSliArrmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3jb6H3vT28wfv+5PVBVzJ84XM6eNaIzGLahYTKTQbvKFRZrKgsi9ZgkYWJ4wjFew53Pt7JDd8z5DanY2LAoMZ0eKZjbs8jCsBvI2YxVWLctu5jaqGh6LmxjQjazsCAGN9ZOrQacbZlMWOTkVpJoCwgwpGUVUtC1sUq9ZYWrO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jli6b7BW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E316F292B;
	Wed, 20 May 2026 10:01:47 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C09813F7B4;
	Wed, 20 May 2026 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779296513; bh=IMYx3KN4W/rs0qjLPQmuF1Ictk6EYTiYu8gSliArrmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jli6b7BWHur+VPleSm/8RX2ujhUXeJy19OLXI4eHH57j8n0DPtnpBFhipWfk0EIxR
	 GWrXDVfP1UJEbslOpTmBWRR8NsL+GyM13rCvOisDXNNkEOHldNgyXvIgLYhUuRyUC+
	 BOqp+SNorynQiiSxTO8koI5rY8S/P+8v7XBESObg=
Date: Wed, 20 May 2026 18:01:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: will@kernel.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.12 1/1] arm64: io: correct user memory type in
 ioremap_prot()
Message-ID: <ag3o-RbDTQWWazwF@arm.com>
References: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
 <20260520091337.3799553-2-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520091337.3799553-2-xiangyu.chen@windriver.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250868-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,arm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: C2EBF594CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:13:37PM +0800, Xiangyu Chen wrote:
> generic_access_phys() passes a 'pgprot_t' value determined from the
> user mapping of the target 'pfn' being accessed by the kernel.
> On arm64, this 'pgprot_t' contains all non-address bits from the pte,
> including user permission controls (PTE_USER).
> 
> When a process attempts to read the target memory via cross-process
> subsystems (such as reading /proc/<pid>/mem or via ptrace), the kernel
> re-maps this memory using ioremap_prot(). Since the PTE_USER bit is
> incorrectly preserved in the temporary kernel-space mapping, it triggers
> a level 3 permission fault on systems with PAN (Privileged Access Never)
> enabled, resulting in an immediate kernel panic.
> 
> Upstream already fixed this issue in
> commit: 8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()")
> 
> Directly porting the upstream patch's macro changes inside <asm/io.h>
> creates circular build dependencies due to the architecture-specific
> GENERIC_IOREMAP refactoring introduced in the stable kernel lifecycle.
> 
> To bypass header dependency traps safely, this backport confines the fix
> entirely inside the implementation layer of arch/arm64/mm/ioremap.c:
> 1. It uses pgprot_val() to safely unpack page properties into a pteval_t mask.
> 2. It introduces a targeted safety check (if (prot_val & PTE_USER)) to
>    selectively strip away volatile user permission parameters.
> 3. It maps the memory through pure kernel attributes, leaving standard
>    peripheral device drivers completely unaffected.
> 
> Tested-by: QEMU ARM64 (Cortex-A55, CONFIG_ARM64_PAN=y, /proc/<pid>/mem read)
> Fixes: 893dea9ccd08 ("arm64: Add HAVE_IOREMAP_PROT support")
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>

Instead of re-implementing this, could we cherry-pick the prior commit
renaming ioremap_prot() to __ioremap_prot() throughout arm64? It's not a
straightforward cherry-pick since we changed the prot arg from unsigned
long to pgprot_t (across multiple architectures), but with some minor
tweaks we can get the patch below. After this, 8f098037139b should apply
(hopefully unmodified). Please give it a try:

--------------------8<------------------------------------
From a38c5529973892914c1c967d43a2abcdcd9c6287 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Mon, 23 Feb 2026 22:10:10 +0000
Subject: [PATCH 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()

commit f6bf47ab32e0863df50f5501d207dcdddb7fc507 upstream.

Rename our ioremap_prot() implementation to __ioremap_prot() and convert
all arch-internal callers over to the new function.

On this 6.12 branch, ioremap_prot() remains as an exported wrapper around
__ioremap_prot(), since the generic ioremap_prot() prototype still takes an
unsigned long protection value. The wrapper keeps the existing behaviour and
will be subsequently extended to handle user permissions in 'prot'.

Cc: Zeng Heng <zengheng4@huawei.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/io.h |  7 ++++---
 arch/arm64/kernel/acpi.c    |  2 +-
 arch/arm64/mm/ioremap.c     | 12 +++++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 1ada23a6ec19..e6ad41131d80 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -274,15 +274,16 @@ __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 typedef int (*ioremap_prot_hook_t)(phys_addr_t phys_addr, size_t size,
 				   pgprot_t *prot);
 int arm64_ioremap_prot_hook_register(const ioremap_prot_hook_t hook);
+void __iomem *__ioremap_prot(phys_addr_t phys, size_t size, pgprot_t prot);
 
 #define ioremap_prot ioremap_prot
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
 #define ioremap_wc(addr, size)	\
-	ioremap_prot((addr), (size), PROT_NORMAL_NC)
+	__ioremap_prot((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_np(addr, size)	\
-	ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
+	__ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
 
 /*
  * io{read,write}{16,32,64}be() macros
@@ -303,7 +304,7 @@ static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
 	if (pfn_is_map_memory(__phys_to_pfn(addr)))
 		return (void __iomem *)__phys_to_virt(addr);
 
-	return ioremap_prot(addr, size, PROT_NORMAL);
+	return __ioremap_prot(addr, size, __pgprot(PROT_NORMAL));
 }
 
 /*
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e6f66491fbe9..a99476819e6b 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -379,7 +379,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 				prot = __acpi_get_writethrough_mem_attribute();
 		}
 	}
-	return ioremap_prot(phys, size, pgprot_val(prot));
+	return __ioremap_prot(phys, size, prot);
 }
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 6cc0b7e7eb03..ca008a4732ae 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -14,11 +14,10 @@ int arm64_ioremap_prot_hook_register(ioremap_prot_hook_t hook)
 	return 0;
 }
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem *__ioremap_prot(phys_addr_t phys_addr, size_t size,
+			     pgprot_t pgprot)
 {
 	unsigned long last_addr = phys_addr + size - 1;
-	pgprot_t pgprot = __pgprot(prot);
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
@@ -39,6 +38,13 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 
 	return generic_ioremap_prot(phys_addr, size, pgprot);
 }
+EXPORT_SYMBOL(__ioremap_prot);
+
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   unsigned long prot)
+{
+	return __ioremap_prot(phys_addr, size, __pgprot(prot));
+}
 EXPORT_SYMBOL(ioremap_prot);
 
 /*

