Return-Path: <stable+bounces-128595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E4A7E89E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C153BBF35
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F6255254;
	Mon,  7 Apr 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWLu1ztK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A725524F;
	Mon,  7 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047240; cv=none; b=dBHwwfybS3vDDXA8nLXEBUthoRuyAHC7TU7CSp0fzU/ALnD+cSnPOPii3XdkGQxS+aZbFmMh5v7OSIaQ7NJNAFH2Y/pqeh7BF7G7CyUtxeWgZwtjGE3itCOb/t7R10LdgZeBvFsb3zRiGT1SObI5RoBg7YwZwpHfKRVBV7KwYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047240; c=relaxed/simple;
	bh=5zlDeiuL9DgF/BlOHl+qwQ7JDuCW686ISBIaHc651Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWOfePjL6yHm6qyHMfME+CNJl68lx8gpPjIUAf/D9aoh/k7DVNkhW3tkKebkbDbC5wYELpKBy06b8BHCvk39NuCaSPjJnXCL94ua/QJqXS+EvGipaEZqYzmWHsLiqCZsESOlIc73rbXHLm1mO+ogdHRg0HImPtuobixtdNYsMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWLu1ztK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2FEC4CEE9;
	Mon,  7 Apr 2025 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047239;
	bh=5zlDeiuL9DgF/BlOHl+qwQ7JDuCW686ISBIaHc651Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWLu1ztKxj+u68He4wtSFTYHUbqcfekr+20JiLGGg0ExuUEQUF+l3kOndmoXkkCUs
	 iizQ/TafNhaN1T950Oja51szTRDgt0oe7BcBZ0kldpIdmimu5wyh3k8774HZWJu8iO
	 c6EcckZVd28qeumMyWTYrRf6tnb17HdJy/wh463Zf7I4eKO7uVjkEiEqBUfUjtv9pO
	 meqeIPfl18yAKKOPyf/LlqQrLgUyt5fdEfBKjrK0G9ChVzcsgDFzuh79qjFfOhuIWM
	 GXE98g9W2k48+Wc9IVj7jqBQC8mPrQC3VLZ/T1Hwm5nXk/khpJfRlaD4KocyTL/lWv
	 DVIzpEC/s5yIA==
Date: Mon, 7 Apr 2025 19:33:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Roberto Ricci <io@r-ricci.it>
Subject: Re: [PATCH v3] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
Message-ID: <Z_QMghKBVFz_EDap@gmail.com>
References: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
 <Z_LGqgUhDrTmzj5r@gmail.com>
 <Z_LJv9gATY6nk4Yu@gmail.com>
 <78346ff0-d5ee-48f0-ac4d-762a5ec18eb7@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78346ff0-d5ee-48f0-ac4d-762a5ec18eb7@qtmlabs.xyz>


* Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz> wrote:

> On 4/7/25 01:36, Ingo Molnar wrote:
> 
> > * Ingo Molnar<mingo@kernel.org> wrote:
> > 
> > > * Myrrh Periwinkle<myrrhperiwinkle@qtmlabs.xyz> wrote:
> > > 
> > > > The current implementation of e820__register_nosave_regions suffers from
> > > > multiple serious issues:
> > > >   - The end of last region is tracked by PFN, causing it to find holes
> > > >     that aren't there if two consecutive subpage regions are present
> > > >   - The nosave PFN ranges derived from holes are rounded out (instead of
> > > >     rounded in) which makes it inconsistent with how explicitly reserved
> > > >     regions are handled
> > > > 
> > > > Fix this by:
> > > >   - Treating reserved regions as if they were holes, to ensure consistent
> > > >     handling (rounding out nosave PFN ranges is more correct as the
> > > >     kernel does not use partial pages)
> > > >   - Tracking the end of the last RAM region by address instead of pages
> > > >     to detect holes more precisely
> > > > 
> > > > Cc:stable@vger.kernel.org
> > > > Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
> > > So why is this SHA1 indicated as the root cause? AFAICS that commit
> > > does nothing but cleanups, so it cannot cause such regressions.
> > BTW.:
> > 
> >   A) "It was the first random commit that seemed related, sry"
> >   B) "It's a 15 years old bug, but I wanted to indicate a fresh, 8-year old bug to get this into -stable. Busted!"
> 
> You got me :) How did you know that this is a 15 years old bug?

Call it a 'regression radar' that every kernel maintainer develops 
after their first 20 years or so - each bug has a distinct feeling
to them, and this one felt genuinely *ancient*.

> [...] (although I didn't think the age of the bug a patch fixes would 
> affect its chances of getting to -stable)

Yeah, it doesn't really affect its -stable elibility much once we move 
outside the ~6-12 months window that upstream recognizes as a 
semi-recent regression - it was mostly my lame attempt at deadpan 
humor, trying to play off 15 year old bugs against 8 year old bugs as 
if 8 years old bugs were fresh. Yeah, I know, it's not funny even to me 
anymore, I'm weird that way. ;-)

> This specific revision was picked since it's the latest one that this 
> patch can be straightforwardly applied to (there is a (trivial) merge 
> conflict with -stable, though).

Yeah. So in the x86/urgent commit I've tagged the other commit you 
pinpointed in your followup mail:

    Fixes: e8eff5ac294e ("[PATCH] Make swsusp avoid memory holes and reserved memory regions on x86_64")

Just to give backporters *some* chance at fixing this ancient bug
in older kernels, if they really want to.

Thanks,

	Ingo

