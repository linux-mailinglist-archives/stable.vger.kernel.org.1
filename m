Return-Path: <stable+bounces-254531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNSaOKzEFmrOqgcAu9opvQ
	(envelope-from <stable+bounces-254531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:17:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8D5E27C4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDCF330034BF
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF33EFD1C;
	Wed, 27 May 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fmxXQqKU"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A483ED3C8;
	Wed, 27 May 2026 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877030; cv=none; b=UNGVJxqOkQsUWakPHGXPnlzc7VT8Nr6NMzfr3ANoTQikteCK0BS2kk4/3i7datjbyHGMyY7EHGFK2JXQQvGpqOv6Ee3mJCiZ2uyR/5XnD+G6R4lA1VowPsD1KK9mHNWp83rpdix4Pg0i+0iCJVVkmUhbVAOn1S6S2IC/LP1Fd9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877030; c=relaxed/simple;
	bh=dxunWLVNoBTNDPHHustbHNmVfyF9OQc1rk7qCoIqqx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzm5Xn4nt4TtmNL5fIMQd4tDXZmBHVQdl/rT2xP2sGwYREPmAw2nH61ac9Xm1Y3c9spYDwUJRzSocavOw2TS4Fc/JFcWtKZmKE/3ngsizxeDgUDgZIqX38amDAYwmkHBsFlSbqM0LcZ5Rk9UM3kc39bNVCbfpdJPbdpLmhALEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fmxXQqKU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D05ED169C;
	Wed, 27 May 2026 03:17:00 -0700 (PDT)
Received: from [10.164.19.7] (unknown [10.164.19.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95A03F7D8;
	Wed, 27 May 2026 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779877025; bh=dxunWLVNoBTNDPHHustbHNmVfyF9OQc1rk7qCoIqqx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fmxXQqKUIE7YXewLZD7f6o3CN6kx8C77ayMefofVQvhrdkf1NCB6SbhjaoezhKQGS
	 izyuG3SrVtn/se2hI6rcmbO6WJ/pAuc5SiYa0yYFxfhtGZBEdUOAUsyHtwavejCSt/
	 gMty1AQ7C57596xePSczg9VbFzWDLqFL1s0GZ8Ek=
Message-ID: <48cbab1e-5547-4dd4-8820-6c918b3db537@arm.com>
Date: Wed, 27 May 2026 15:46:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: update file PUD counter before
 folio_put()
To: Yin Tirui <yintirui@huawei.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Dan Williams <djbw@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, wangkefeng.wang@huawei.com,
 chenjun102@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526101355.1984244-1-yintirui@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260526101355.1984244-1-yintirui@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-254531-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: F0C8D5E27C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/26 3:43 pm, Yin Tirui wrote:
> __split_huge_pud_locked() updates the file/shmem RSS counter after
> dropping the PUD mapping's folio reference. If folio_put() drops the
> last reference, mm_counter_file() can later read freed folio state via
> folio_test_swapbacked().
> 
> Move the counter update before folio_put().
> 
> Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>

>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a5f4a48b7b77..9832ee910d5e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3027,9 +3027,9 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>  	if (!folio_test_referenced(folio) && pud_young(old_pud))
>  		folio_set_referenced(folio);
>  	folio_remove_rmap_pud(folio, page, vma);
> -	folio_put(folio);
>  	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
>  		-HPAGE_PUD_NR);
> +	folio_put(folio);
>  }
>  
>  void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,


