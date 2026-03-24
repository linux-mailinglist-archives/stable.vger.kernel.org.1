Return-Path: <stable+bounces-230115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC25HUhxwmmncwQAu9opvQ
	(envelope-from <stable+bounces-230115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:11:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072AE3070FE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE7BF305B5A7
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E873E5EC3;
	Tue, 24 Mar 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPBZn2wN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C43E4C75;
	Tue, 24 Mar 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350279; cv=none; b=ZAPp6BMFphiLAtRdHzvnSV85zp/24Wa0gWpszS6c6+Gukskc+gP0FWvJGrahqG1vwFeDw3YaA0/P9F/eAWqyg+FIBp/CoxJXFV+FR94srpRJeDhN1Myd8aVZdERlm4TrkVn+CypPH9/ZZeyD/5ruKLFOP0pTkZDpwv8IJGNfioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350279; c=relaxed/simple;
	bh=rnFMpHblF7tfmmg1p1erGQtnBbDTkaS+4wz6+R+ceA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isDi6e6sFpL9Mo3j4WmU2E5YcjfvCkqpbM+oObXXrpPpU1T5hY/WbDQqr03x9RqKgV8cveRcrm88ebrU3r4GEp/UrwX0d7OOhGc2ewyqYlTFutck5WjgVAhAq3nJk/B1DAUFvXzmz42obpv0SVPeqqY9c3DvllQkdJfwRYxUqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPBZn2wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C89CC19424;
	Tue, 24 Mar 2026 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774350279;
	bh=rnFMpHblF7tfmmg1p1erGQtnBbDTkaS+4wz6+R+ceA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPBZn2wNQxbsfUGL75fvK0emhXc6+bHOf3S1hJvckqTJ0mtoYjlhrxTD6EOw6c2Mx
	 pmSCa8EJxcgbx7VKVqRjV2ri9wlisAufPvUU9llrEHYs5f1sW3AMVgjdca/jy7gQax
	 qUMrj4xiAxfk3rvYyIPB2aEXPQHAuPmzxWBk6TbYW2aQ4Mj+9Q0icOHZdve92gaXy8
	 5jBCHC3VHK9ND6+Q98XLE/Pm0VL5esEah9VD2Z3J5M5/dk3Hi0kq6sR3VFyMTuHg3d
	 XqBJ9UbqvdfnLN3hndBxHQb9PEm+9An5KCbv5Ky6ma1umDauyws7Au6jt5hQAVxy2c
	 7oWgDtpr6D8dw==
Date: Tue, 24 Mar 2026 11:04:33 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	linux-mm@kvack.org, Alex Williamson <alex@shazbot.org>, 
	Max Boone <mboone@akamai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
Message-ID: <b3b78722-c265-484b-acde-3aa4bee0aac7@lucifer.local>
References: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230115-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 072AE3070FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:20:18PM +0100, David Hildenbrand (Arm) wrote:
> follow_pfnmap_start() suffers from two problems:
>
> (1) We are not re-fetching the pmd/pud after taking the PTL
>
> Therefore, we are not properly stabilizing what the lock lock actually
> protects. If there is concurrent zapping, we would indicate to the
> caller that we found an entry, however, that entry might already have
> been invalidated, or contain a different PFN after taking the lock.
>
> Properly use pmdp_get() / pudp_get() after taking the lock.
>
> (2) pmd_leaf() / pud_leaf() are not well defined on non-present entries
>
> pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.
>
> There is no real guarantee that pmd_leaf()/pud_leaf() returns something
> reasonable on non-present entries. Most architectures indeed either
> perform a present check or make it work by smart use of flags.

It seems huge page split is the main user via pmd_invalidate() ->
pmd_mkinvalid().

And I guess this is the kind of thing you mean by smart use of flags, for
x86-64:

static inline int pmd_present(pmd_t pmd)
{
	/*
	 * Checking for _PAGE_PSE is needed too because
	 * split_huge_page will temporarily clear the present bit (but
	 * the _PAGE_PSE flag will remain set at all times while the
	 * _PAGE_PRESENT bit is clear).
	 */
	return pmd_flags(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PSE);
}

So you might have missing _PAGE_PRESENT but still pmd_present() returns
true, as does pmd_leaf().

Seems the same for RISC-V.

And other arches play other games with the same result :)

So we probably shouldn't actually hit any problem with this from any other
sauce, but still good to do it.

>
> However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
> and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd(). Whereby
> pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not
> do that.

But pmd_present() checks for _PAGE_HUGE in pmd_present(), and if set checks
whether one of _PAGE_PRESENT, _PAGE_PROTNONE, _PAGE_PRESENT_INVALID is set,
and pmd_mkinvalid() sets _PAGE_PRESENT_INVALID (clearing _PAGE_PRESENT,
_VALID, _DIRTY, _PROTNONE) so it'd return true.

pmd_leaf() simply checks to see if _PAGE_HUGE is set which should be
retained on split so should all still have worked?

But anyway this is still worthwhile I think.

>
> Let's check pmd_present()/pud_present() before assuming "the is a
> present PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page
> table handling code that traverses user page tables does.
>
> Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP,
> (1) is likely more relevant than (2). It is questionable how often (1)
> would actually trigger, but let's CC stable to be sure.
>
> This was found by code inspection.
>
> Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This looks correct to me, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
> Gave it a quick test in a VM with MM selftests etc, but I am not sure if
> I actually trigger the follow_pfnmap machinery.
> ---
>  mm/memory.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 219b9bf6cae0..2921d35c50ae 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6868,11 +6868,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
>
>  	pudp = pud_offset(p4dp, address);
>  	pud = pudp_get(pudp);
> -	if (pud_none(pud))
> +	if (!pud_present(pud))
>  		goto out;
>  	if (pud_leaf(pud)) {
>  		lock = pud_lock(mm, pudp);
> -		if (!unlikely(pud_leaf(pud))) {
> +		pud = pudp_get(pudp);
> +
> +		if (unlikely(!pud_present(pud))) {
> +			spin_unlock(lock);
> +			goto out;
> +		} else if (unlikely(!pud_leaf(pud))) {

Tiny nit, but no need for else here. Sometimes compilers complain about
this but not sure if it such pedantry is enabled in default kernel compiler
flags :)

Obv. same for below.

>  			spin_unlock(lock);
>  			goto retry;
>  		}
> @@ -6884,9 +6889,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
>
>  	pmdp = pmd_offset(pudp, address);
>  	pmd = pmdp_get_lockless(pmdp);
> +	if (!pmd_present(pmd))
> +		goto out;
>  	if (pmd_leaf(pmd)) {
>  		lock = pmd_lock(mm, pmdp);
> -		if (!unlikely(pmd_leaf(pmd))) {
> +		pmd = pmdp_get(pmdp);
> +
> +		if (unlikely(!pmd_present(pmd))) {
> +			spin_unlock(lock);
> +			goto out;
> +		} else if (unlikely(!pmd_leaf(pmd))) {
>  			spin_unlock(lock);
>  			goto retry;
>  		}
>
> ---
> base-commit: 3f4f1faa33544d0bd724e32980b6f211c3a9bc7b
> change-id: 20260323-follow_pfnmap_fix-bab73335468a
>
> Best regards,
> --
> David Hildenbrand (Arm) <david@kernel.org>
>

Cheers, Lorenzo

