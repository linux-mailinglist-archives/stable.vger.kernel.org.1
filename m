Return-Path: <stable+bounces-235908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEYxDQWB3GmYSAkAu9opvQ
	(envelope-from <stable+bounces-235908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFD3E781F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029743014BD1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103A730BB97;
	Mon, 13 Apr 2026 05:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="h1AsM6NQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB22C11E4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058594; cv=none; b=GhHO/1KoGDaTQJrBsRuSDYpXCT2Zg16nuOD6YUoyzo/QTj6uSEKD+HHQYXlam4na5WY5B6kNfmLb6UUyiwNtxoe9ss/AudwB+xe2JvBxsAU953vXowZQcVz+Ma9b8jzAy7iNs8oemGmxR4oquNQbZVJme/Nnk0XD8PnH9PzmmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058594; c=relaxed/simple;
	bh=rFIWaQVIzDr7LJ2pLxgr0TzD6LrP2YpDnjbHqEmKV08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA5c0yhzVVTUeXUk6C323oWo9bAuPCQjOv9WnW11jRKRjH7IVqBiX8CdISfKQz8DXnyguj07XwB6IahIZC5EDqqYmDOyaNcJfk7j2lJpCrgAmoKDXfD6JsrbdacCuqbrGZP6Gm8U/7YPD3htUWuxbKG5O5CeUoHJTsB+BuZExHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=h1AsM6NQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd71fb9f06so246070485a.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 22:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776058592; x=1776663392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/X2QfEAZrHNubsDZK1Rva+fNiB1w8v4TMc0y0Ptc/zQ=;
        b=h1AsM6NQiNmlG6J8HLnQKdP741Abn1BRxDHZlWhZQRBQpgctOF8jORxQXgQnCghtvr
         Zx6gJ83LDQGQ9Abu1o46TBlMnf54gD8xs7/8wg3H8PwEuHNnvmbVt0AaGEmU/KdlrALk
         pLiRgs/kAY7rIt2SOfaIzio2+bTK+JgnGCeY8zg+9I+BYOg0urNUT2I9eSt5NtUVMNfS
         EJ9BWKnNK7g9WlNP0ZY+EW44VwBuFQZ7cYvgttyDPCNNwhFZmkyl2AqIxMk2+GV7AxHM
         /jyP1k7QDJju0ngYZ1f+CTXY4GXAEwlpe4gs7bmUTzq+bkR/N/BIf8RNyw6GuTYhugUu
         aSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776058592; x=1776663392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X2QfEAZrHNubsDZK1Rva+fNiB1w8v4TMc0y0Ptc/zQ=;
        b=ctigIx2Cge/MlvGy0VNIaztpUM1s9kehibazkT2m9gwQwYQ3BshwUU4Q0eQJ14aGjf
         lrfziD1hsyQe0nxJ8icLWgriwu0ONrWg5iyyjclLugl6LVRAtkHjZOjoDa12qcGuFxXL
         dgnDWCWJz3wniK/gBA3sOHknmYfbREwvSzNpLGEqU9/il5J2f2RyMFVj0bswVA/X1nGn
         ugzZ+41/DyvYPeAJ25ENgC86CDnJY2h50SUxAzBe4llkxYJsQV1wWRgXa4Nd+uO/WNNg
         y0od2vtn4N6nFz8IaGGrdbWfXYxccEQ/OpeDcTZ0yUCbdzRU6xI1DdH5ejX2nhTNlA7t
         s+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUnc/b4AM9dhCx+wDG+L1mqVzlKhf7mSLwSlrkQo2WKwiRfsA0zBtnIRiovXgnxGyBh4mtGUDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSV26xQX9n5RkQTPU4C/gUB1ibMYBpoDZ0xMReNkVHVWdISy3H
	XF/MSXrqlPPPgdzTNXEN/p5IxG/Zx7o9d+RI/z14/ZSsXk4Yjaxq1ihDfGRHz8na/kE=
X-Gm-Gg: AeBDiesbSA/cUo/PrbfseT5a+F9Kh7C8MLbAJmxQ3P66Qs6zh5k+6n5+/iu81heYAWE
	12Q7d9w/Wd+DWiIWL99sViu/wekuA3VbEsn0rbaF5trxq14mLkJSf8mhkiKUFps3OQaTpUm2PZU
	Cs7MYDcbUVmof6vvxoumlck3mNl4ISpX4Gh6d2F6la+To3l6csyKsvM17dxeeN/5652tACc7iAR
	kXv5hVXzZA1akjozMri0gkgEiWp4wHmw6eKyGsmUDYl4Hbv5WudQroXfx233PR0JM2VMGZLauzQ
	Pf3OEOtFrjzFg88zpiNRSFW8VSv3JBvBpOzGLAfgL/V2RruKwabigH5EJA99hh+ylt47NFD8WuR
	oX033SnDiY/7KdyN5a07QipcBRryGqTL04Bvzw3D3+p1DUZVzqTC/RqiXjGtC70WyYUSzVYrJ+N
	kJNyxKHMfKBd6DgxR310Q125SPEtBRnDvy3xfKc6v1WpqIzHHGJ/CCFem3a4Apd1TDJ4bTfUxlL
	+2REtnH+FVS
X-Received: by 2002:a05:620a:4013:b0:8d7:4f7c:873b with SMTP id af79cd13be357-8ddcdbe3c79mr1768071585a.14.1776058592318;
        Sun, 12 Apr 2026 22:36:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca9f7e0b0sm25350806d6.11.2026.04.12.22.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 22:36:31 -0700 (PDT)
Date: Mon, 13 Apr 2026 01:36:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rppt@kernel.org, peterx@redhat.com, surenb@google.com,
	aarcange@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: preserve write protection across UFFDIO_MOVE
Message-ID: <adyA3X2k1GdzxOEZ@gourry-fedora-PF4VCD3F>
References: <20260409152822.1073083-1-gourry@gourry.net>
 <20260412111807.42c3edf86d19528d7cb1bb7b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412111807.42c3edf86d19528d7cb1bb7b@linux-foundation.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-235908-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95DFD3E781F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 11:18:07AM -0700, Andrew Morton wrote:
> On Thu,  9 Apr 2026 11:28:22 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > move_present_ptes() unconditionally makes the destination PTE writable,
> > dropping uffd-wp write-protection from the source PTE.
> > 
> > The original intent was to follow mremap() behavior, but mremap()'s
> > move_ptes() preserves the source write state unconditionally.
> > 
> > Modify uffd to preserve the source write state and check the uffd-wp
> > condition of the source before setting writable on the destination.
> 
> Please can we have a description of the userspace-visible impact of the
> bug.
>

Simply:

  UFFDIO_MOVE silently drops write protection from the source PTE when
  moving pages to a destination, leading to missing write-protect faults
  after the page has been moved.

I ran into this while futzing around with some user space management of
VM memory, and expecting a move to continue firing WP faults after.

But Sashiko actually made a useful (though obtuse) observation which
has made me realize _MOVE is actually ambiguous on what to do with
source region UFFD modes.

> > +		if (pte_uffd_wp(orig_src_pte))
> > +			orig_dst_pte = pte_mkuffd_wp(orig_dst_pte);

This line assumes the destination must have intended to be WP, and the
the result is essentially stale uffd wp bits in the opposite case (a
user not intending to carry over WP now carries it over).

tl;dr: this is more of a semantic change than I'd intended, and the
existing tests did not catch it.

The correct solution here is to make a UFFDIO_MOVE_MODE_WP flag to copy
the UFFDIO_COPY_MODE_WP pattern.  Otherwise:

> (presently wondering if this is backward compatible)

Yes, you're right to wonder - this does break backward compatibilty.

Will come back around with UFFDIO_MOVE_MODE_WP.

~Gregory

