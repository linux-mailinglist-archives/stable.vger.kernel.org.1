Return-Path: <stable+bounces-259639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIfaEGjJHWrHeQkAu9opvQ
	(envelope-from <stable+bounces-259639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:03:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E73623ABF
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C871130E2826
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BFB3E121A;
	Mon,  1 Jun 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaFRfgqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC03B7A8;
	Mon,  1 Jun 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336544; cv=none; b=nuQfj/yRemu7hzzGFtKnPoWHXS+UIuCoj0WO1BKHY4Sq++C/FdOI2pKqbg4sTUarCSDM6oCbDqQQisfVpqiiAyiZvyFgzwqkiKBu//5Tyf2SwdZWRNmVita3AtSKYrc/GqBJqSlTqnEkKVvHMqnXY44E7YaUiQliaKkgg02fZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336544; c=relaxed/simple;
	bh=Azf2BNQkMPPZYPuxAJ87DMjqNMXvgzAC71O0eQOEGQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv7Y3yd+rrO2p5Ayofpjc0WGLTF8ncAh8o5VnU1iY8diuu4Cd/E5FpWcR3qrkxRm7HDDc+ODixww1XmpY7Ca1l7u1OGyQzY3aD9s3o0GjLZO3RotAR7OfzEPzQmorJPMCC4yJTL967VlB+4dWITKHsDiQOoVXN2ShaWyoUFdNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaFRfgqW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4540E1F00893;
	Mon,  1 Jun 2026 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780336543;
	bh=U1uP6wM6n2zIqzJIdRb8GLaszOovltVtTL4/EbH3E+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BaFRfgqWdvMM76xeNkgTCsFwms92DF0Ho22NItt3VT9LuxmUq+JH3+7ySdKiXfb4k
	 34lEr+SKqJiYztRg1oX1HRJ9oS0rbrC9t5G8Y8J9uNcsFicggQdyiNvT4yMpybk+yt
	 oW2un0/6/Ebv+TYEpTfHhkX1yeidCQR+kcRz2ytwz/OsW5PjJGpL89Hta60QGmr9Se
	 krjWY+l2WFrPoovPeCymJrpdWpFhQHHN6UTD7N2IKJtipBY6nIozTOwR4K5HVyeSO6
	 0fk2FlgLQqTv/20O9APW80fOKTyVKImh0D27jjkXtc8fzL30+Pi/Q6fEQFOP3YYyQH
	 jGnaTIz0PqPQQ==
Date: Mon, 1 Jun 2026 18:55:37 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
Message-ID: <ah3EQvQ_Ja6AJqzF@lucifer>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-2-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172331.356655-2-kas@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259639-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B2E73623ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 06:23:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> make_uffd_wp_huge_pte() arms the UFFD_WP bit on a present HugeTLB PTE by
> calling huge_ptep_modify_prot_commit() with a ptent snapshot that was
> fetched without the corresponding huge_ptep_modify_prot_start().

The
> start helper is what atomically clears the entry so the kernel-owned
> snapshot stays consistent until the commit; without it, the hardware
> may set Dirty or Accessed in the live PTE between the original read
> and the commit, and huge_ptep_modify_prot_commit() (whose generic
> implementation just calls set_huge_pte_at()) then writes the stale
> snapshot back over the live hardware bits, losing the update.

Very pedantic nit - this is a mammoth paragraph :P maybe add a linebreak
where I did above?

>
> The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
> ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
> pattern for the present-PTE branch. The migration case stays as-is --
> migration entries are non-present, so there's no hardware update to
> race against.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")

I wonder if better as a separate patch? Not sure what Andrew thinks about
it, I do recall him complaining about separate-hotfixes-as-part-of-a-series :>)

> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1e3a15bf46f4..e21a38ac745b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2610,12 +2610,16 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>  	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
>  		return;
>
> -	if (softleaf_is_migration(entry))
> +	if (softleaf_is_migration(entry)) {
>  		set_huge_pte_at(vma->vm_mm, addr, ptep,
>  				pte_swp_mkuffd_wp(ptent), psize);
> -	else
> -		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
> -					     huge_pte_mkuffd_wp(ptent));
> +	} else {
> +		pte_t old_pte, new_pte;
> +
> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
> +		new_pte = huge_pte_mkuffd_wp(old_pte);
> +		huge_ptep_modify_prot_commit(vma, addr, ptep, old_pte, new_pte);
> +	}
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>
> --
> 2.54.0
>

Cheers, Lorenzo

