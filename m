Return-Path: <stable+bounces-254529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PWxGD/GFmpVrwcAu9opvQ
	(envelope-from <stable+bounces-254529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:23:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED55E2968
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D77304EA2E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54B3EFD36;
	Wed, 27 May 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oSq834UG"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301F3EFFA8;
	Wed, 27 May 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876936; cv=none; b=cbr75pRzxjrCQl40rZL6HlH700hWBYnDCvfGscBb0RnWT9syDm/s2Q4X6dWOsZTPp2t47xhFV+Z8BPaizONGqEgZHqIpFFjvvcxzf7GuTjsg+XceSbu7rAKKiPGSI/6b0KGML8/O6uXxsmki+wMXyYnogIv2B/D5rF6VA8G3gsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876936; c=relaxed/simple;
	bh=11Ch8SRuV30IKc6WYj2PYORtmdlKFlKYIOyzxzCdY/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQoF4c8Ec0ia3ZYts6kmUNaTsRzTc0AOaFVSaFGObw8MRZYMbY0jhndBGzNkWeZEsoCktsD40Ya65JQTEqTUIzzuCJzPX5RdsO+DKOIO+G+DldfuJH1Tek/gYb3r+BOsoTzTI8AGFcsPNRt2ohV0KL+80bzgiQoWIjBPaH/MoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oSq834UG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4003169C;
	Wed, 27 May 2026 03:15:23 -0700 (PDT)
Received: from [10.164.19.7] (unknown [10.164.19.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9F853F7D8;
	Wed, 27 May 2026 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779876928; bh=11Ch8SRuV30IKc6WYj2PYORtmdlKFlKYIOyzxzCdY/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oSq834UGuKiM2+78TjUMC/7CFpOQSaVkGtkwnwVw6wEh77IDpZniTH2Ll34ktWbVi
	 i10lybDeLgZpwDurSiUporQyyJRmE9NGZNsnDtMONWqT6Jn2VBTCk6pwvwlHwCFci1
	 PT0wbisNKGnc6MQ25CZJXU4GE2Nuq6evM+eubKdo=
Message-ID: <4ac24b2c-7fbe-44bd-9efc-c1add7785453@arm.com>
Date: Wed, 27 May 2026 15:45:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: update file PMD counter before
 folio_put()
To: Yin Tirui <yintirui@huawei.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Yang Shi <yang.shi@linux.alibaba.com>, wangkefeng.wang@huawei.com,
 chenjun102@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526101337.1984081-1-yintirui@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260526101337.1984081-1-yintirui@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-254529-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,arm.com:dkim,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ADED55E2968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/26 3:43 pm, Yin Tirui wrote:
> __split_huge_pmd_locked() updates the file/shmem RSS counter after
> dropping the PMD mapping's folio reference. If folio_put() drops the
> last reference, mm_counter_file() can later read freed folio state via
> folio_test_swapbacked().
> 
> Move the counter update before folio_put().
> 
> Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>

>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0135c29a4372..a5f4a48b7b77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3145,7 +3145,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
>  				folio_set_referenced(folio);
>  			folio_remove_rmap_pmd(folio, page, vma);
> +			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
>  			folio_put(folio);
> +			return;
>  		}
>  		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
>  		return;


