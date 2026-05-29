Return-Path: <stable+bounces-256641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH6UFCSdGWq7xwgAu9opvQ
	(envelope-from <stable+bounces-256641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:05:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1ED603400
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D00830DAD32
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225D3E121E;
	Fri, 29 May 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neeNnvpP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A593DEAC1;
	Fri, 29 May 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063224; cv=none; b=pLaB9h6UKwKL3r2h+l4Rye9jQlR0zn1CNhlr5Y/9Z4rp468oLGcSjwsx4EWfpV6IsDnnY2/2ql3cz3tnFtl3NbP6CfdmfNBKXyUfpY/PYFxoFaTcN9om4YvPW7RDjif4740xspMxYDfn8yE9WiKcSyIUuHp2mxZ32k+/w9qBSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063224; c=relaxed/simple;
	bh=W2pTYBq+b+oXiGU1QZzMVV+zQTudHkur2VT97ExkcZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdMAs4NS+7IOPaRfLMtkF+jLeH0F3JTuEVmqkXZ2unvdpHttZdUhzASK6YFR5LcTvSzYxwDmYerbYDZ+FRKIxO9ba91T34hQzUh2Cb2aI98FLSoDEbknb62cfNsYrlQNREaJI47vC56Z0otdeiK8AbXt80B7WG4heIip+VHYCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neeNnvpP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFDA1F00893;
	Fri, 29 May 2026 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780063223;
	bh=o53KZSM1xwnMx9qRi9blrTJDTT9nvtmbWfg0I22/pKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=neeNnvpPJ5li6VA0xHi+YFqdkMv2Z2MOaS7H1Wgd4ceLe4M5SB91cfCT5ZZ8dDZlV
	 PKe6T3haHkhV+DXKVCfhRjx0RiQJjkgdRnG2MNfFrDkdri/AJFgSEU+FM0qR59oiAo
	 +CDHcC1rjjFIkvr716svKIRiGkFhqD7ts2Iup6pf4yA54hvqRcmfah0snxc0hJQ7FB
	 sSBT8f1Q8LOXvAoS+ftsJRLjaNhK9Y5nkxKrIK0E+/eiIg4/187gfg0UqH/50Q6JS7
	 MvkeYaQdtGqiC//rj1Hce2Aj/IOHTDZmenaNoPt6hQMEr3yF8fev/ZeUZyMbJ8F7+X
	 w6Tv3aWA/tCLA==
Date: Fri, 29 May 2026 15:00:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Message-ID: <ahmQvfNk7S4F0LBj@lucifer>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-5-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526130509.2748441-5-kirill@shutemov.name>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256641-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA1ED603400
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 02:04:52PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> vma_flags_t is one unsigned long on 32-bit -- NUM_VMA_FLAG_BITS ==
> BITS_PER_LONG by design, so VM_xxx-declared bits sit in the first
> word and hit the single-long fast path. But the bit enum declares
> some bits unconditionally above BITS_PER_LONG (VMA_UFFD_MINOR_BIT
> == 41 today, with VM_UFFD_MINOR == VM_NONE on 32-bit so no VMA
> actually carries the bit).

Yeah ugh.

>
> Passing such a bit to mk_vma_flags() goes through __set_bit(41,
> &one_long) and writes one word past the end. The compiler folds
> the OOB store with wraparound (1UL << (41 % 32) == bit 9) into
> the first word. Bit 9 is already in __VMA_UFFD_FLAGS so the mask
> happens to come out right today, but any high-numbered bit whose

That is... helpful :) but not great that this is the situation, an
oversight, clearly! How I hate 32-bit kernels :)

> mod-BITS_PER_LONG position is otherwise unused would silently OR
> an extra bit into the mask.
>
> Add VMA_NO_BIT and have DECLARE_VMA_BIT() resolve any bitnum out
> of range to it. vma_flags_set_flag() drops negative bit values.
> The ternary collapses at compile time, the runtime check folds
> away when the bit is in range, and the common path is unchanged.

Hmm are you sure it does?

A key design goal was that mk_vma_flags() generates compile-time constants
the same as if the bitmap were constructed independently.

This surely must generate code? Or at least runs a significant risk of it?

Setting a precedent here would probably lead to VMA_NO_BIT being used more
and therefore generating code in more places I think.

And I'm not sure I really want to bend over backwards here to work around
issues with 32-bit kernels when in the long run the intent is that we move
to making these values 64-bit anyway.

Perhaps it's even wise possibly to just make these values 64-bit already,
ahead of time?

(I did look at this in terms of wanting something like a VMA_NO_BIT so we
could get VM_NONE-like behaviour but nothing I tried failed to generate
code.)

A simple solution that doesn't require change to the core is to just uglify
userfaultfd_k.h a bit with:

#ifdef HAVE_ARCH_USERFAULTFD_MINOR
#define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
				      VMA_UFFD_MINOR_BIT)
#else
#define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT)
#endif

But of course that becomes much more horrible with your changes...

Another alternative, which I used for VMA_DROPPABLE is to add something
like this in mm.h:

#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
#define VM_UFFD_MINOR	INIT_VM_FLAG(UFFD_MINOR)
+define VMA_UFFD_MINOR	mk_vma_flags(VMA_UFFD_MINOR_BIT)
#else
#define VM_UFFD_MINOR	VM_NONE
+define VMA_UFFD_MINOR	EMPTY_VMA_FLAGS
#endif

Then we can do:

#define __VMA_UFFD_FLAGS append_vma_flags(VMA_MINOR, VMA_UFFD_MISSING_BIT, \
					  VMA_UFFD_WP_BIT)

With you changes in 08/18 on top it'd get hairier, but we could make our
life easier by implementing something like:

static __always_inline vma_flags_t __mk_vma_flags_from_masks(size_t count,
	const vma_flags_t *masks)
{
	vma_flags_t flags = EMPTY_VMA_FLAGS;
	int i;

	for (i = 0; i < count; i++)
		mask = vma_flags_set_mask(&flags, masks[i]);

	return flags;
}

#define mk_vma_flags_from_masks(...) __mk_vma_flags_from_masks(, \
		COUNT_ARGS(__VA_ARGS__), (const vma_flags_t []){__VA_ARGS__})

(untested code - you would need to ensure it generated equivalent
constants as VM_xxx would now :)

Then you could get VMA_UFFD_RWP with:

#ifdef CONFIG_USERFAULTFD_RWP
#define VMA_UFFD_RWP	mk_vma_flags(VMA_UFFD_RWP_BIT)
#else
#define VMA_UFFD_RWP	EMPTY_VMA_FLAGS
#endif

And then:


/* Always available if CONFIG_USERFAULTFD set. */
#define __VMA_UFFD_DEFAULT_FLAGS \
		mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT)

#define __VMA_UFFD_FLAGS mk_vma_flags_from_masks(__VMA_UFFD_DEFAULT_FLAGS \
		VMA_MINOR, VMA_RWP)

Which is kind ok-ish right? I mean it's all a bit fugly obviously.

>
> Bits declared in the enum are now safe to pass to mk_vma_flags()
> regardless of arch.

I mean another issue here is we're then codifying behaviour that's legacy
ahead of time. I really want to avoid that.

>
> Fixes: 9ea35a25d51b ("mm: introduce VMA flags bitmap type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>  include/linux/mm.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0f2612a70fb1..71b11945e4fc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -286,8 +286,17 @@ extern unsigned int kobjsize(const void *objp);
>   */
>  typedef int __bitwise vma_flag_t;
>
> -#define DECLARE_VMA_BIT(name, bitnum) \
> -	VMA_ ## name ## _BIT = ((__force vma_flag_t)bitnum)
> +/*
> + * VMA_NO_BIT means "no bit"; mk_vma_flags() skips it. DECLARE_VMA_BIT()
> + * below uses it for any bit number that doesn't fit in the bitmap, so
> + * callers don't need to track which bits are valid on the current build.
> + */
> +#define VMA_NO_BIT	((__force vma_flag_t)-1)
> +
> +#define DECLARE_VMA_BIT(name, bitnum)					\
> +	VMA_ ## name ## _BIT = (((bitnum) < NUM_VMA_FLAG_BITS) ?	\
> +				((__force vma_flag_t)(bitnum)) :	\
> +				VMA_NO_BIT)
>  #define DECLARE_VMA_BIT_ALIAS(name, aliased) \
>  	VMA_ ## name ## _BIT = (VMA_ ## aliased ## _BIT)
>  enum {
> @@ -1081,6 +1090,8 @@ static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
>  {
>  	unsigned long *bitmap = flags->__vma_flags;
>
> +	if ((__force int)bit < 0)
> +		return;
>  	__set_bit((__force int)bit, bitmap);
>  }
>
> --
> 2.54.0
>

Either way, I think we should break out any fix like this from the series.

Andrew is I think also not a fan of fixes patches in the middle of series
anyway :P

Cheers, Lorenzo

