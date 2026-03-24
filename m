Return-Path: <stable+bounces-230045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKKUBY/4wWkmYgQAu9opvQ
	(envelope-from <stable+bounces-230045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 03:35:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BC301397
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C69D3053E26
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB234386C25;
	Tue, 24 Mar 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Dt6obDm8"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9538642A;
	Tue, 24 Mar 2026 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319448; cv=none; b=Qn5NhJCfWqwqLnjH/q2eeNZmnHokXITlL5vMR1pcjnRc/3e05m+YpP/dDuzBn+Hvq4lI40gZr/tuKvAkI0oo8KTvxsxWNC2r1jWi9e+7+8TNzK4Qn0M/jhmMvmDFuYZJYL48VAwkggwpvkrmkxY8aquRztQm0Eiw6JsrrVFsvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319448; c=relaxed/simple;
	bh=RrUmRi7A4StAuAEUyYjf0VD4Rp0D3K1/CLDNzQDnIWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eZGuhgQY3cuveasdFsxXtE6ATOPGSQ3PF/1E6vufC9cz7yMWv5n3Kq932YJMBYb2xn1UNCvqLUfyJQ9dtSOw5DeipE4JRbsnBbiiQob46R1FcQmvnL5Qm/x8QTE9ORI+1mN2JqDs2PU53TLmlW6mXff14txnJpvQvFDpS/v5bwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Dt6obDm8; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GUvSjKAHpf5/ZLV5403ywCefJdhPTSpPVXdwv2MuyJE=;
	b=Dt6obDm8VOXeUcHNGhgpUbOKrKJaeP4qLY3YmVVrDTXqMCO7LdcPBS2elLOL5OGRvlJFC7FJ+
	f8coNORJRzwKI+8xMARAHVQQn/7xVWeXGpuJjGFWif3YkPJRhRstLll9mj2lpdTzlSjKfnjrjW2
	FO+e8o3wwJvSG2rNP12ADxU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4ffv4k2KfKzLltg;
	Tue, 24 Mar 2026 10:24:38 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B3D44055B;
	Tue, 24 Mar 2026 10:30:42 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 10:30:41 +0800
Message-ID: <a7fa6fd9-79b2-4e46-8ee4-fde9d5853100@huawei.com>
Date: Tue, 24 Mar 2026 10:30:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
To: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "David Hildenbrand
 (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>, Yang Shi
	<yang@os.amperecomputing.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <20260323130317.1737522-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230045-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tujinjiang@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 884BC301397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/3/23 21:03, Ryan Roberts 写道:
> It has been possible for a long time to mark ptes in the linear map as
> invalid. This is done for secretmem, kfence, realm dma memory un/share,
> and others, by simply clearing the PTE_VALID bit. But until commit
> a166563e7ec37 ("arm64: mm: support large block mapping when
> rodata=full") large leaf mappings were never made invalid in this way.
>
> It turns out various parts of the code base are not equipped to handle
> invalid large leaf mappings (in the way they are currently encoded) and
> I've observed a kernel panic while booting a realm guest on a
> BBML2_NOABORT system as a result:
>
> [   15.432706] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
> [   15.476896] Unable to handle kernel paging request at virtual address ffff000019600000
> [   15.513762] Mem abort info:
> [   15.527245]   ESR = 0x0000000096000046
> [   15.548553]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   15.572146]   SET = 0, FnV = 0
> [   15.592141]   EA = 0, S1PTW = 0
> [   15.612694]   FSC = 0x06: level 2 translation fault
> [   15.640644] Data abort info:
> [   15.661983]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
> [   15.694875]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [   15.723740]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   15.755776] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081f3f000
> [   15.800410] [ffff000019600000] pgd=0000000000000000, p4d=180000009ffff403, pud=180000009fffe403, pmd=00e8000199600704
> [   15.855046] Internal error: Oops: 0000000096000046 [#1]  SMP
> [   15.886394] Modules linked in:
> [   15.900029] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc4-dirty #4 PREEMPT
> [   15.935258] Hardware name: linux,dummy-virt (DT)
> [   15.955612] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   15.986009] pc : __pi_memcpy_generic+0x128/0x22c
> [   16.006163] lr : swiotlb_bounce+0xf4/0x158
> [   16.024145] sp : ffff80008000b8f0
> [   16.038896] x29: ffff80008000b8f0 x28: 0000000000000000 x27: 0000000000000000
> [   16.069953] x26: ffffb3976d261ba8 x25: 0000000000000000 x24: ffff000019600000
> [   16.100876] x23: 0000000000000001 x22: ffff0000043430d0 x21: 0000000000007ff0
> [   16.131946] x20: 0000000084570010 x19: 0000000000000000 x18: ffff00001ffe3fcc
> [   16.163073] x17: 0000000000000000 x16: 00000000003fffff x15: 646e612065766974
> [   16.194131] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   16.225059] x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000018
> [   16.256113] x8 : 0000000000000018 x7 : 0000000000000000 x6 : 0000000000000000
> [   16.287203] x5 : ffff000019607ff0 x4 : ffff000004578000 x3 : ffff000019600000
> [   16.318145] x2 : 0000000000007ff0 x1 : ffff000004570010 x0 : ffff000019600000
> [   16.349071] Call trace:
> [   16.360143]  __pi_memcpy_generic+0x128/0x22c (P)
> [   16.380310]  swiotlb_tbl_map_single+0x154/0x2b4
> [   16.400282]  swiotlb_map+0x5c/0x228
> [   16.415984]  dma_map_phys+0x244/0x2b8
> [   16.432199]  dma_map_page_attrs+0x44/0x58
> [   16.449782]  virtqueue_map_page_attrs+0x38/0x44
> [   16.469596]  virtqueue_map_single_attrs+0xc0/0x130
> [   16.490509]  virtnet_rq_alloc.isra.0+0xa4/0x1fc
> [   16.510355]  try_fill_recv+0x2a4/0x584
> [   16.526989]  virtnet_open+0xd4/0x238
> [   16.542775]  __dev_open+0x110/0x24c
> [   16.558280]  __dev_change_flags+0x194/0x20c
> [   16.576879]  netif_change_flags+0x24/0x6c
> [   16.594489]  dev_change_flags+0x48/0x7c
> [   16.611462]  ip_auto_config+0x258/0x1114
> [   16.628727]  do_one_initcall+0x80/0x1c8
> [   16.645590]  kernel_init_freeable+0x208/0x2f0
> [   16.664917]  kernel_init+0x24/0x1e0
> [   16.680295]  ret_from_fork+0x10/0x20
> [   16.696369] Code: 927cec03 cb0e0021 8b0e0042 a9411c26 (a900340c)
> [   16.723106] ---[ end trace 0000000000000000 ]---
> [   16.752866] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   16.792556] Kernel Offset: 0x3396ea200000 from 0xffff800080000000
> [   16.818966] PHYS_OFFSET: 0xfff1000080000000
> [   16.837237] CPU features: 0x0000000,00060005,13e38581,957e772f
> [   16.862904] Memory Limit: none
> [   16.876526] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>
> This panic occurs because the swiotlb memory was previously shared to
> the host (__set_memory_enc_dec()), which involves transitioning the
> (large) leaf mappings to invalid, sharing to the host, then marking the
> mappings valid again. But pageattr_p[mu]d_entry() would only update the
> entry if it is a section mapping, since otherwise it concluded it must
> be a table entry so shouldn't be modified. But p[mu]d_sect() only
> returns true if the entry is valid. So the result was that the large

Maybe I missed something, pmd_sect() only checks PMD_TYPE_SECT, doesn't check PTE_VALID?
Why it only returns true if the entry is valid?

#define pmd_sect(pmd)        ((pmd_val(pmd) & PMD_TYPE_MASK) == \
                  PMD_TYPE_SECT)


> leaf entry was made invalid in the first pass then ignored in the second
> pass. It remains invalid until the above code tries to access it and
> blows up.
>
> The simple fix would be to update pageattr_pmd_entry() to use
> !pmd_table() instead of pmd_sect(). That would solve this problem.
>
> But the ptdump code also suffers from a similar issue. It checks
> pmd_leaf() and doesn't call into the arch-specific note_page() machinery
> if it returns false. As a result of this, ptdump wasn't even able to
> show the invalid large leaf mappings; it looked like they were valid
> which made this super fun to debug. the ptdump code is core-mm and
> pmd_table() is arm64-specific so we can't use the same trick to solve
> that.
>
> But we already support the concept of "present-invalid" for user space
> entries. And even better, pmd_leaf() will return true for a leaf mapping
> that is marked present-invalid. So let's just use that encoding for
> present-invalid kernel mappings too. Then we can use pmd_leaf() where we
> previously used pmd_sect() and everything is magically fixed.
>
> Additionally, from inspection kernel_page_present() was broken in a
> similar way, so I'm also updating that to use pmd_leaf().
>
> I haven't spotted any other issues of this shape but plan to do a follow
> up patch to remove pmd_sect() and pud_sect() in favour of the more
> sophisticated pmd_leaf()/pud_leaf() which are core-mm APIs and will
> simplify arm64 code a bit.
>
> Fixes: a166563e7ec37 ("arm64: mm: support large block mapping when rodata=full")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/mm/pageattr.c | 50 ++++++++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 358d1dc9a576f..87dfe4c82fa92 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
>   {
>   	struct page_change_data *masks = walk->private;
>   
> +	/*
> +	 * Some users clear and set bits which alias eachother (e.g. PTE_NG and
> +	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
> +	 * first then set.
> +	 */
>   	val &= ~(pgprot_val(masks->clear_mask));
>   	val |= (pgprot_val(masks->set_mask));
>   
> @@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
>   {
>   	pud_t val = pudp_get(pud);
>   
> -	if (pud_sect(val)) {
> +	if (pud_leaf(val)) {
>   		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
>   			return -EINVAL;
>   		val = __pud(set_pageattr_masks(pud_val(val), walk));
> @@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
>   {
>   	pmd_t val = pmdp_get(pmd);
>   
> -	if (pmd_sect(val)) {
> +	if (pmd_leaf(val)) {
>   		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
>   			return -EINVAL;
>   		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
> @@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>   	ret = update_range_prot(start, size, set_mask, clear_mask);
>   
>   	/*
> -	 * If the memory is being made valid without changing any other bits
> -	 * then a TLBI isn't required as a non-valid entry cannot be cached in
> -	 * the TLB.
> +	 * If the memory is being switched from present-invalid to valid without
> +	 * changing any other bits then a TLBI isn't required as a non-valid
> +	 * entry cannot be cached in the TLB.
>   	 */
> -	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
> +	if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||
> +	    pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
>   		flush_tlb_kernel_range(start, start + size);
>   	return ret;
>   }
> @@ -237,18 +243,18 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>   {
>   	if (enable)
>   		return __change_memory_common(addr, PAGE_SIZE * numpages,
> -					__pgprot(PTE_VALID),
> -					__pgprot(0));
> +					__pgprot(PTE_MAYBE_NG | PTE_VALID),
> +					__pgprot(PTE_PRESENT_INVALID));
>   	else
>   		return __change_memory_common(addr, PAGE_SIZE * numpages,
> -					__pgprot(0),
> -					__pgprot(PTE_VALID));
> +					__pgprot(PTE_PRESENT_INVALID),
> +					__pgprot(PTE_MAYBE_NG | PTE_VALID));
>   }
>   
>   int set_direct_map_invalid_noflush(struct page *page)
>   {
> -	pgprot_t clear_mask = __pgprot(PTE_VALID);
> -	pgprot_t set_mask = __pgprot(0);
> +	pgprot_t clear_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID);
> +	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
>   
>   	if (!can_set_direct_map())
>   		return 0;
> @@ -259,8 +265,8 @@ int set_direct_map_invalid_noflush(struct page *page)
>   
>   int set_direct_map_default_noflush(struct page *page)
>   {
> -	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
> -	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
> +	pgprot_t set_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID | PTE_WRITE);
> +	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
>   
>   	if (!can_set_direct_map())
>   		return 0;
> @@ -296,8 +302,8 @@ static int __set_memory_enc_dec(unsigned long addr,
>   	 * entries or Synchronous External Aborts caused by RIPAS_EMPTY
>   	 */
>   	ret = __change_memory_common(addr, PAGE_SIZE * numpages,
> -				     __pgprot(set_prot),
> -				     __pgprot(clear_prot | PTE_VALID));
> +				     __pgprot(set_prot | PTE_PRESENT_INVALID),
> +				     __pgprot(clear_prot | PTE_MAYBE_NG | PTE_VALID));
>   
>   	if (ret)
>   		return ret;
> @@ -311,8 +317,8 @@ static int __set_memory_enc_dec(unsigned long addr,
>   		return ret;
>   
>   	return __change_memory_common(addr, PAGE_SIZE * numpages,
> -				      __pgprot(PTE_VALID),
> -				      __pgprot(0));
> +				      __pgprot(PTE_MAYBE_NG | PTE_VALID),
> +				      __pgprot(PTE_PRESENT_INVALID));
>   }
>   
>   static int realm_set_memory_encrypted(unsigned long addr, int numpages)
> @@ -404,15 +410,15 @@ bool kernel_page_present(struct page *page)
>   	pud = READ_ONCE(*pudp);
>   	if (pud_none(pud))
>   		return false;
> -	if (pud_sect(pud))
> -		return true;
> +	if (pud_leaf(pud))
> +		return pud_valid(pud);
>   
>   	pmdp = pmd_offset(pudp, addr);
>   	pmd = READ_ONCE(*pmdp);
>   	if (pmd_none(pmd))
>   		return false;
> -	if (pmd_sect(pmd))
> -		return true;
> +	if (pmd_leaf(pmd))
> +		return pmd_valid(pmd);
>   
>   	ptep = pte_offset_kernel(pmdp, addr);
>   	return pte_valid(__ptep_get(ptep));

