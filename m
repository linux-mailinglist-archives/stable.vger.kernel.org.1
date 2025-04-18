Return-Path: <stable+bounces-134542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04EFA9350E
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962B33BE1AE
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D1B26E17A;
	Fri, 18 Apr 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OaH6t4Em"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2F26FDAD;
	Fri, 18 Apr 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967013; cv=none; b=pwFyS1yj1UuVI+7ZoewvvaMow/rAXjFvWBLpZyd2WxB7oiYw3OFZPFGoXLs2E/X4aljOvP2WvhatJfnrc/JDSfWF36qdDnMKyd9JngBUDOEb7cXSJI8dcbRwJULrzF0ethtgt4Y1WNNs4Ntn5EzAtJ4J72KIt68ilumG7pVszZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967013; c=relaxed/simple;
	bh=ux85UaKGHmWgF6HhVM8OOvobqVgJwNDXi1I9R0gjp8o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dKLYu3Ngo+bwlWaswMPtY0s82DUuQk4E5UsK1aML/r27rJQ+G8LXdh8y3VFKI2AO0BkKJTLuAVGfx5xSRGwPn8zpvOKqkqiY6tgXk7aOuUystxa2UHYPMhg3Wv1YK2uxaveuKfRIGAtJQjfx77QMHYhMxI0qoxtbTFXC/WaEt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OaH6t4Em; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/TUgmXRIt862ZvkLN+SJfvXp8pRPa3ExVWG6heV/r3c=; b=OaH6t4EmRnkaOCLDxBbVCkP9bZ
	r0Nae3ODBz1Bym6pu799K8rcBPxqn1Y29idZLKhw5eCeZn+pSTjbdmdr6gZ+QVApzEjGcJWA0jEzl
	4AE+wkHEn0WcMeN4Kqjlf+wth7LVvp+b+RwIYtilGDIwhk9qfCaKWt+9b7DiKs1YBDHh+wJFPc9VD
	0TN0yz+TmMdAa02YBXKaVi8t/tZlodlb++fqvdz/q5Isg9pLu8VtoD8SSWEavvWOXF0QhpG3vB2bx
	sZzabt9Q0i9JO5uQQgWBShk3OAl4nz0a88Nks/wpQaV11tJ+VnBe7WqINPam5jkBbMY7xh7G2BA2F
	vrobwNEQ==;
Received: from 39-14-33-89.adsl.fetnet.net ([39.14.33.89] helo=[192.168.220.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u5hd0-001AZP-2j; Fri, 18 Apr 2025 11:03:18 +0200
Message-ID: <983ba47e-ab95-4a43-bca2-97b75c3c90d0@igalia.com>
Date: Fri, 18 Apr 2025 17:03:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
From: Gavin Guo <gavinguo@igalia.com>
To: ziy@nvidia.com
Cc: david@redhat.com, willy@infradead.org, linmiaohe@huawei.com,
 hughd@google.com, revest@google.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20250418085802.2973519-1-gavinguo@igalia.com>
Content-Language: en-US
In-Reply-To: <20250418085802.2973519-1-gavinguo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/25 16:58, Gavin Guo wrote:
> When migrating a THP, concurrent access to the PMD migration entry
> during a deferred split scan can lead to a invalid address access, as
> illustrated below. To prevent this page fault, it is necessary to check
> the PMD migration entry and return early. In this context, there is no
> need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
> equality of the target folio. Since the PMD migration entry is locked,
> it cannot be served as the target.
> 
> Mailing list discussion and explanation from Hugh Dickins:
> "An anon_vma lookup points to a location which may contain the folio of
> interest, but might instead contain another folio: and weeding out those
> other folios is precisely what the "folio != pmd_folio((*pmd)" check
> (and the "risk of replacing the wrong folio" comment a few lines above
> it) is for."
> 
> BUG: unable to handle page fault for address: ffffea60001db008
> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> Call Trace:
> <TASK>
> try_to_migrate_one+0x28c/0x3730
> rmap_walk_anon+0x4f6/0x770
> unmap_folio+0x196/0x1f0
> split_huge_page_to_list_to_order+0x9f6/0x1560
> deferred_split_scan+0xac5/0x12a0
> shrinker_debugfs_scan_write+0x376/0x470
> full_proxy_write+0x15c/0x220
> vfs_write+0x2fc/0xcb0
> ksys_write+0x146/0x250
> do_syscall_64+0x6a/0x120
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The bug is found by syzkaller on an internal kernel, then confirmed on
> upstream.
> 
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
> ---
> V1 -> V2: Add explanation from Hugh and correct the wording from page
> fault to invalid address access.
> 
>   mm/huge_memory.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47682d1ab7..0cb9547dcff2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   			   pmd_t *pmd, bool freeze, struct folio *folio)
>   {
> +	bool pmd_migration = is_pmd_migration_entry(*pmd);
> +
>   	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>   	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>   	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   	 * require a folio to check the PMD against. Otherwise, there
>   	 * is a risk of replacing the wrong folio.
>   	 */
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> -		if (folio && folio != pmd_folio(*pmd))
> -			return;
> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
> +		if (folio) {
> +			/*
> +			 * Do not apply pmd_folio() to a migration entry; and
> +			 * folio lock guarantees that it must be of the wrong
> +			 * folio anyway.
> +			 */
> +			if (pmd_migration)
> +				return;
> +			if (folio != pmd_folio(*pmd))
> +				return;
> +		}
>   		__split_huge_pmd_locked(vma, pmd, address, freeze);
>   	}
>   }
> 
> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9

Hi Zi, I've carefully reviewed the mailing list and observed that the 
indentation is not a strong concern from the reviews. And the cleanup 
suggestion from David will override the modification in this patch. I 
have decided to keep the original version (the unindented one). Let me 
know if you have any feedback with the v2 patch. Thank you!

