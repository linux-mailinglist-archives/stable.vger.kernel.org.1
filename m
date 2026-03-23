Return-Path: <stable+bounces-227976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDybAs88wWk+RwQAu9opvQ
	(envelope-from <stable+bounces-227976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:14:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D22F2A09
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9829A30D42B2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED111E1A3D;
	Mon, 23 Mar 2026 13:03:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B53AA4F4;
	Mon, 23 Mar 2026 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271015; cv=none; b=EVqJFmgKt9dB1wRZghi1jtM8MylenLRFcRGR5jU47qNA+m6YHc+4NjL6OIQF8cG6tU4z0NmepmfgE6u8c2fQ1B0vcaXrmahTXjEO9Urs0Ry0RKX6VskhFde4/zyyYnQPE3vrrpBDLADG3drpX7BdJ0im3YRD4Yvz/vqV6a3UQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271015; c=relaxed/simple;
	bh=zM8TDhiXz4UqejfHBMlISVluQljShazmrodv7kYCVOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKySfkJXvJx83PDr1jTTxkERdnC3iQGe9fmzfIREDaPsLAdakiZcHdBWCo+Gy0MrlyF2/5+5HFlrRUKMvqza7RaV9hG1g+Prh86i12U3bmXAizLOsTvn77+1uqIcC4o1hrrB5eG8tVUk/fsoh1ljTNL0EK7ZIu/49XMVY9/uR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2091688;
	Mon, 23 Mar 2026 06:03:27 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA9A3F885;
	Mon, 23 Mar 2026 06:03:31 -0700 (PDT)
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
Subject: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings correctly
Date: Mon, 23 Mar 2026 13:03:14 +0000
Message-ID: <20260323130317.1737522-3-ryan.roberts@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227976-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: 893D22F2A09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It has been possible for a long time to mark ptes in the linear map as
invalid. This is done for secretmem, kfence, realm dma memory un/share,
and others, by simply clearing the PTE_VALID bit. But until commit
a166563e7ec37 ("arm64: mm: support large block mapping when
rodata=full") large leaf mappings were never made invalid in this way.

It turns out various parts of the code base are not equipped to handle
invalid large leaf mappings (in the way they are currently encoded) and
I've observed a kernel panic while booting a realm guest on a
BBML2_NOABORT system as a result:

[   15.432706] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
[   15.476896] Unable to handle kernel paging request at virtual address ffff000019600000
[   15.513762] Mem abort info:
[   15.527245]   ESR = 0x0000000096000046
[   15.548553]   EC = 0x25: DABT (current EL), IL = 32 bits
[   15.572146]   SET = 0, FnV = 0
[   15.592141]   EA = 0, S1PTW = 0
[   15.612694]   FSC = 0x06: level 2 translation fault
[   15.640644] Data abort info:
[   15.661983]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
[   15.694875]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[   15.723740]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   15.755776] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081f3f000
[   15.800410] [ffff000019600000] pgd=0000000000000000, p4d=180000009ffff403, pud=180000009fffe403, pmd=00e8000199600704
[   15.855046] Internal error: Oops: 0000000096000046 [#1]  SMP
[   15.886394] Modules linked in:
[   15.900029] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc4-dirty #4 PREEMPT
[   15.935258] Hardware name: linux,dummy-virt (DT)
[   15.955612] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   15.986009] pc : __pi_memcpy_generic+0x128/0x22c
[   16.006163] lr : swiotlb_bounce+0xf4/0x158
[   16.024145] sp : ffff80008000b8f0
[   16.038896] x29: ffff80008000b8f0 x28: 0000000000000000 x27: 0000000000000000
[   16.069953] x26: ffffb3976d261ba8 x25: 0000000000000000 x24: ffff000019600000
[   16.100876] x23: 0000000000000001 x22: ffff0000043430d0 x21: 0000000000007ff0
[   16.131946] x20: 0000000084570010 x19: 0000000000000000 x18: ffff00001ffe3fcc
[   16.163073] x17: 0000000000000000 x16: 00000000003fffff x15: 646e612065766974
[   16.194131] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   16.225059] x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000018
[   16.256113] x8 : 0000000000000018 x7 : 0000000000000000 x6 : 0000000000000000
[   16.287203] x5 : ffff000019607ff0 x4 : ffff000004578000 x3 : ffff000019600000
[   16.318145] x2 : 0000000000007ff0 x1 : ffff000004570010 x0 : ffff000019600000
[   16.349071] Call trace:
[   16.360143]  __pi_memcpy_generic+0x128/0x22c (P)
[   16.380310]  swiotlb_tbl_map_single+0x154/0x2b4
[   16.400282]  swiotlb_map+0x5c/0x228
[   16.415984]  dma_map_phys+0x244/0x2b8
[   16.432199]  dma_map_page_attrs+0x44/0x58
[   16.449782]  virtqueue_map_page_attrs+0x38/0x44
[   16.469596]  virtqueue_map_single_attrs+0xc0/0x130
[   16.490509]  virtnet_rq_alloc.isra.0+0xa4/0x1fc
[   16.510355]  try_fill_recv+0x2a4/0x584
[   16.526989]  virtnet_open+0xd4/0x238
[   16.542775]  __dev_open+0x110/0x24c
[   16.558280]  __dev_change_flags+0x194/0x20c
[   16.576879]  netif_change_flags+0x24/0x6c
[   16.594489]  dev_change_flags+0x48/0x7c
[   16.611462]  ip_auto_config+0x258/0x1114
[   16.628727]  do_one_initcall+0x80/0x1c8
[   16.645590]  kernel_init_freeable+0x208/0x2f0
[   16.664917]  kernel_init+0x24/0x1e0
[   16.680295]  ret_from_fork+0x10/0x20
[   16.696369] Code: 927cec03 cb0e0021 8b0e0042 a9411c26 (a900340c)
[   16.723106] ---[ end trace 0000000000000000 ]---
[   16.752866] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   16.792556] Kernel Offset: 0x3396ea200000 from 0xffff800080000000
[   16.818966] PHYS_OFFSET: 0xfff1000080000000
[   16.837237] CPU features: 0x0000000,00060005,13e38581,957e772f
[   16.862904] Memory Limit: none
[   16.876526] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

This panic occurs because the swiotlb memory was previously shared to
the host (__set_memory_enc_dec()), which involves transitioning the
(large) leaf mappings to invalid, sharing to the host, then marking the
mappings valid again. But pageattr_p[mu]d_entry() would only update the
entry if it is a section mapping, since otherwise it concluded it must
be a table entry so shouldn't be modified. But p[mu]d_sect() only
returns true if the entry is valid. So the result was that the large
leaf entry was made invalid in the first pass then ignored in the second
pass. It remains invalid until the above code tries to access it and
blows up.

The simple fix would be to update pageattr_pmd_entry() to use
!pmd_table() instead of pmd_sect(). That would solve this problem.

But the ptdump code also suffers from a similar issue. It checks
pmd_leaf() and doesn't call into the arch-specific note_page() machinery
if it returns false. As a result of this, ptdump wasn't even able to
show the invalid large leaf mappings; it looked like they were valid
which made this super fun to debug. the ptdump code is core-mm and
pmd_table() is arm64-specific so we can't use the same trick to solve
that.

But we already support the concept of "present-invalid" for user space
entries. And even better, pmd_leaf() will return true for a leaf mapping
that is marked present-invalid. So let's just use that encoding for
present-invalid kernel mappings too. Then we can use pmd_leaf() where we
previously used pmd_sect() and everything is magically fixed.

Additionally, from inspection kernel_page_present() was broken in a
similar way, so I'm also updating that to use pmd_leaf().

I haven't spotted any other issues of this shape but plan to do a follow
up patch to remove pmd_sect() and pud_sect() in favour of the more
sophisticated pmd_leaf()/pud_leaf() which are core-mm APIs and will
simplify arm64 code a bit.

Fixes: a166563e7ec37 ("arm64: mm: support large block mapping when rodata=full")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/pageattr.c | 50 ++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 358d1dc9a576f..87dfe4c82fa92 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
 {
 	struct page_change_data *masks = walk->private;
 
+	/*
+	 * Some users clear and set bits which alias eachother (e.g. PTE_NG and
+	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
+	 * first then set.
+	 */
 	val &= ~(pgprot_val(masks->clear_mask));
 	val |= (pgprot_val(masks->set_mask));
 
@@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
 {
 	pud_t val = pudp_get(pud);
 
-	if (pud_sect(val)) {
+	if (pud_leaf(val)) {
 		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
 			return -EINVAL;
 		val = __pud(set_pageattr_masks(pud_val(val), walk));
@@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	pmd_t val = pmdp_get(pmd);
 
-	if (pmd_sect(val)) {
+	if (pmd_leaf(val)) {
 		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
 			return -EINVAL;
 		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
@@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
 	ret = update_range_prot(start, size, set_mask, clear_mask);
 
 	/*
-	 * If the memory is being made valid without changing any other bits
-	 * then a TLBI isn't required as a non-valid entry cannot be cached in
-	 * the TLB.
+	 * If the memory is being switched from present-invalid to valid without
+	 * changing any other bits then a TLBI isn't required as a non-valid
+	 * entry cannot be cached in the TLB.
 	 */
-	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
+	if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||
+	    pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
 		flush_tlb_kernel_range(start, start + size);
 	return ret;
 }
@@ -237,18 +243,18 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 {
 	if (enable)
 		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(PTE_VALID),
-					__pgprot(0));
+					__pgprot(PTE_MAYBE_NG | PTE_VALID),
+					__pgprot(PTE_PRESENT_INVALID));
 	else
 		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(0),
-					__pgprot(PTE_VALID));
+					__pgprot(PTE_PRESENT_INVALID),
+					__pgprot(PTE_MAYBE_NG | PTE_VALID));
 }
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	pgprot_t clear_mask = __pgprot(PTE_VALID);
-	pgprot_t set_mask = __pgprot(0);
+	pgprot_t clear_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID);
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
 
 	if (!can_set_direct_map())
 		return 0;
@@ -259,8 +265,8 @@ int set_direct_map_invalid_noflush(struct page *page)
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
-	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
+	pgprot_t set_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
 
 	if (!can_set_direct_map())
 		return 0;
@@ -296,8 +302,8 @@ static int __set_memory_enc_dec(unsigned long addr,
 	 * entries or Synchronous External Aborts caused by RIPAS_EMPTY
 	 */
 	ret = __change_memory_common(addr, PAGE_SIZE * numpages,
-				     __pgprot(set_prot),
-				     __pgprot(clear_prot | PTE_VALID));
+				     __pgprot(set_prot | PTE_PRESENT_INVALID),
+				     __pgprot(clear_prot | PTE_MAYBE_NG | PTE_VALID));
 
 	if (ret)
 		return ret;
@@ -311,8 +317,8 @@ static int __set_memory_enc_dec(unsigned long addr,
 		return ret;
 
 	return __change_memory_common(addr, PAGE_SIZE * numpages,
-				      __pgprot(PTE_VALID),
-				      __pgprot(0));
+				      __pgprot(PTE_MAYBE_NG | PTE_VALID),
+				      __pgprot(PTE_PRESENT_INVALID));
 }
 
 static int realm_set_memory_encrypted(unsigned long addr, int numpages)
@@ -404,15 +410,15 @@ bool kernel_page_present(struct page *page)
 	pud = READ_ONCE(*pudp);
 	if (pud_none(pud))
 		return false;
-	if (pud_sect(pud))
-		return true;
+	if (pud_leaf(pud))
+		return pud_valid(pud);
 
 	pmdp = pmd_offset(pudp, addr);
 	pmd = READ_ONCE(*pmdp);
 	if (pmd_none(pmd))
 		return false;
-	if (pmd_sect(pmd))
-		return true;
+	if (pmd_leaf(pmd))
+		return pmd_valid(pmd);
 
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_valid(__ptep_get(ptep));
-- 
2.43.0


