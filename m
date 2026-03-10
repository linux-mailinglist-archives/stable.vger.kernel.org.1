Return-Path: <stable+bounces-224528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJRANtpUsGkJiQIAu9opvQ
	(envelope-from <stable+bounces-224528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:28:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C025593D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9107131B59DC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D73CF02A;
	Tue, 10 Mar 2026 17:24:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852A2DB7B9;
	Tue, 10 Mar 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163488; cv=none; b=GP5SGAn6VoAQ11VI5CfQJpU7QYR2ZL76hWDxQWsHgk7fWJ4qWmma3TsYsmkaPpWLjiUAU1m7uBQrol4WVEv5Kbdy9wHxD3S/FKOi2lIQi5B5A2VLz20gHqWEkq/G1EGTVSLhm5S30xnIt49lB83GJXO0H5A24kRc+CdvYFCi42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163488; c=relaxed/simple;
	bh=/ZLHb41tF9gOmEmiEjRMLrS/NfJM9CSRUwSa3rGkEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvw/MSgrYy0whAE7uTkRzLYpX7DmSwmwgMGcsqNp9KL+obghhvDbn7QaKEMcaZRe0rb/hUGjpe2Wd1kl7WdnsY4HR2Obfs9GpHFTvaMSRLq/44qDOY+oN3h9FgKwoRFaHJBNwk8pIEUJS8PLQd6rNIcHTixWL4JwV1kpg14robg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ECBE14BF;
	Tue, 10 Mar 2026 10:24:40 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5D383F694;
	Tue, 10 Mar 2026 10:24:45 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:24:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Reda CHERKAOUI <redacherkaoui67@gmail.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: harden ASID allocator against empty bitmap
 after rollover
Message-ID: <abBT2gV84-9uaHkJ@arm.com>
References: <20260219113715.8001-1-redacherkaoui67@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219113715.8001-1-redacherkaoui67@gmail.com>
X-Rspamd-Queue-Id: 3F2C025593D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224528-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.965];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid]
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:37:14AM +0000, Reda CHERKAOUI wrote:
> new_context() assumes that after incrementing asid_generation and calling
> flush_context(), find_next_zero_bit() will always find a free ASID.
> 
> If that invariant is ever violated, __set_bit(NUM_USER_ASIDS, asid_map)
> would write past the end of the bitmap. Add a defensive check so the
> kernel fails loudly instead of silently corrupting memory.
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Reda CHERKAOUI <redacherkaoui67@gmail.com>
> ---
>  arch/arm64/mm/context.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index b2ac06246327..74c1ece7db78 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -160,6 +160,7 @@ static u64 new_context(struct mm_struct *mm)
>  	static u32 cur_idx = 1;
>  	u64 asid = atomic64_read(&mm->context.id);
>  	u64 generation = atomic64_read(&asid_generation);
> +	unsigned long idx;
>  
>  	if (asid != 0) {
>  		u64 newasid = asid2ctxid(ctxid2asid(asid), generation);
> @@ -194,9 +195,11 @@ static u64 new_context(struct mm_struct *mm)
>  	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
>  	 * pairs.
>  	 */
> -	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
> -	if (asid != NUM_USER_ASIDS)
> +	idx = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
> +	if (idx != NUM_USER_ASIDS) {
> +		asid = idx;
>  		goto set_asid;
> +	}
>  
>  	/* We're out of ASIDs, so increment the global generation count */
>  	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
> @@ -204,7 +207,10 @@ static u64 new_context(struct mm_struct *mm)
>  	flush_context();
>  
>  	/* We have more ASIDs than CPUs, so this will always succeed */
> -	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
> +	idx = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
> +	if (unlikely(idx == NUM_USER_ASIDS))
> +		panic("ASID allocator: no free ASIDs after rollover\n");
> +	asid = idx;

How do you even hit this? Is it if you have less ASIDs than the number
of CPUs? The kernel complains about this in asids_update_limit.

Anyway, given how you are not following up on maintainer's comments, I
assume these patches are automatically generated.

-- 
Catalin

