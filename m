Return-Path: <stable+bounces-229976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG84MER4wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:28:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFA2F9EEC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 279F130C46CB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5973C13FE;
	Mon, 23 Mar 2026 16:52:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920293C4564;
	Mon, 23 Mar 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284778; cv=none; b=bXPWb89+XVT2HNvcUjQbkaNJ7jBWefAKMKzW1AcoPyJikicq7lpx/rXK59OXXTL9/MWLutG7FByGUKxUzNB/3HJeuj3zH1jf+qqh/RN5vZs56N6yoXg+AckwPng3oblkdUrCJkktx0mLUE2s2yB5COvdLac8Rc5n6DF9AIreI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284778; c=relaxed/simple;
	bh=57fIqjBtzY+0t0BcOg1MYmpVeehDqEMNYvmgMs2yFMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTg6can3xE11T2CzDTu5AQdRA4VUYtE71QdGj7NRu3mNs3hbdhuJ7bnAPsDt6388kRcYwm8U939/qOpJemZAyLatv9HUiuSj0CEkhm2ZPE+wpgn7+s5p9BCA2fqDQUfGGf7lBj6AMOUyjDBZJmdrRitHQ8mEQsU58Tgb93ETAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 113A31516;
	Mon, 23 Mar 2026 09:52:51 -0700 (PDT)
Received: from [10.57.58.207] (unknown [10.57.58.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EEA33F73B;
	Mon, 23 Mar 2026 09:52:54 -0700 (PDT)
Message-ID: <588b2b4f-9cf6-43e5-b0e5-55820c74cbbb@arm.com>
Date: Mon, 23 Mar 2026 17:52:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260323130317.1737522-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229976-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37AFA2F9EEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 14:03, Ryan Roberts wrote:
> [...]
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 358d1dc9a576f..87dfe4c82fa92 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
>  {
>  	struct page_change_data *masks = walk->private;
>  
> +	/*
> +	 * Some users clear and set bits which alias eachother (e.g. PTE_NG and

Nit: "each other"

> +	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
> +	 * first then set.
> +	 */
>  	val &= ~(pgprot_val(masks->clear_mask));
>  	val |= (pgprot_val(masks->set_mask));
>  
> @@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
>  {
>  	pud_t val = pudp_get(pud);
>  
> -	if (pud_sect(val)) {
> +	if (pud_leaf(val)) {
>  		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
>  			return -EINVAL;
>  		val = __pud(set_pageattr_masks(pud_val(val), walk));
> @@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
>  {
>  	pmd_t val = pmdp_get(pmd);
>  
> -	if (pmd_sect(val)) {
> +	if (pmd_leaf(val)) {
>  		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
>  			return -EINVAL;
>  		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
> @@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>  	ret = update_range_prot(start, size, set_mask, clear_mask);
>  
>  	/*
> -	 * If the memory is being made valid without changing any other bits
> -	 * then a TLBI isn't required as a non-valid entry cannot be cached in
> -	 * the TLB.
> +	 * If the memory is being switched from present-invalid to valid without
> +	 * changing any other bits then a TLBI isn't required as a non-valid
> +	 * entry cannot be cached in the TLB.
>  	 */
> -	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
> +	if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||

It isn't obvious to understand where all those PTE_MAYBE_NG come from if
one hasn't realised that PTE_PRESENT_INVALID overlays PTE_NG.

Since for this purpose we always set/clear both PTE_VALID and
PTE_MAYBE_NG, maybe we could define some macro as PTE_VALID |
PTE_MAYBE_NG, as a counterpart to PTE_PRESENT_INVALID?

- Kevin

> [...]

