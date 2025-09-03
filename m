Return-Path: <stable+bounces-177566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD353B41464
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 07:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A03B78E4
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F112D543B;
	Wed,  3 Sep 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JLdgKnf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C072D47E0
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877681; cv=none; b=Szj+vPSF7/gdJxnlqaAbptZJh/+ugft6amOLUk9Oh2dj++4S/gHwaGFQ2o4aEAfvpzOLJiOWg/oKDYDngDEAGNnIR4Iwy28C3CghFpDFmunLZr2Tk7sjGDjctXjYK9NE4V1MvOIvgXcyn4Z99hYlx7VDei5Ail9zA9ANtOHKOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877681; c=relaxed/simple;
	bh=Dn99J/wNZcQ8cjepOF0bFowzIyB5iiQnDIx6F1w1350=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPG6rRBK/aI6q0sYBY7fJgOR+XsSx04azsqW7M6NJ8g6PD7pCpyqia/K1YLVdO5ULF6BrWsUWvo9QmRanGo5ArYozK5LwSeQF5xusxa9J2yotIP0tiHIf6vu9rM9uF11/HAnLyhty92MChzEiZ9nSvVVXj7eTDWjd/5po7rFkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JLdgKnf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38633C4CEF0;
	Wed,  3 Sep 2025 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756877680;
	bh=Dn99J/wNZcQ8cjepOF0bFowzIyB5iiQnDIx6F1w1350=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLdgKnf5mpupjTIzrlpoUb9vBvABQUmYezdlPzitP7YFyCk6mKabo0tptyM9Z8Cp/
	 8zTiAEwLD2fC3QO2iLBH2KDtxKucr8yG14D+61M8YdSzf20lmBjTppCTWTZk+ejkoQ
	 exY7fWqTAQckpsxBk5+JhJhIjyKhjYu2AFSECO3o=
Date: Wed, 3 Sep 2025 07:34:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: xen-devel@lists.xenproject.org, stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>, kernel test robot <lkp@intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthoine Bourgeois <anthoine.bourgeois@vates.tech>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v5.10.y] xen: replace xen_remap() with memremap()
Message-ID: <2025090335-operating-antarctic-39f7@gregkh>
References: <4cc9c1f583fb4bfca02ff7050b9b01cb9abb7e7f.1756803599.git.teddy.astie@vates.tech>
 <2025090203-clothes-bullish-a21f@gregkh>
 <d4d5ce1f-8bcf-46c3-a1a5-f509375e80e9@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4d5ce1f-8bcf-46c3-a1a5-f509375e80e9@vates.tech>

On Tue, Sep 02, 2025 at 04:24:33PM +0000, Teddy Astie wrote:
> Le 02/09/2025 à 13:18, Greg Kroah-Hartman a écrit :
> > On Tue, Sep 02, 2025 at 09:28:32AM +0000, Teddy Astie wrote:
> >> From: Juergen Gross <jgross@suse.com>
> >>
> >> From: Juergen Gross <jgross@suse.com>
> >>
> >> [ upstream commit 41925b105e345ebc84cedb64f59d20cb14a62613 ]
> >>
> >> xen_remap() is used to establish mappings for frames not under direct
> >> control of the kernel: for Xenstore and console ring pages, and for
> >> grant pages of non-PV guests.
> >>
> >> Today xen_remap() is defined to use ioremap() on x86 (doing uncached
> >> mappings), and ioremap_cache() on Arm (doing cached mappings).
> >>
> >> Uncached mappings for those use cases are bad for performance, so they
> >> should be avoided if possible. As all use cases of xen_remap() don't
> >> require uncached mappings (the mapped area is always physical RAM),
> >> a mapping using the standard WB cache mode is fine.
> >>
> >> As sparse is flagging some of the xen_remap() use cases to be not
> >> appropriate for iomem(), as the result is not annotated with the
> >> __iomem modifier, eliminate xen_remap() completely and replace all
> >> use cases with memremap() specifying the MEMREMAP_WB caching mode.
> >>
> >> xen_unmap() can be replaced with memunmap().
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
> >> Link: https://lore.kernel.org/r/20220530082634.6339-1-jgross@suse.com
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> Signed-off-by: Teddy Astie <teddy.astie@vates.tech> [backport to 5.10.y]
> >> ---
> >
> > Why is this needed for 5.10.y at all?  What bug does it fix?  And why
> > are you still using Xen on a 5.10.y kernel?  What prevents you from
> > moving to a newer one?
> >
> 
> This patch is only useful for virtual machines (DomU) that runs this
> Linux version (a notable Linux distribution with this kernel branch is
> Debian 11); it's not useful for Dom0 kernels.
> 
> On AMD platforms (and future Intel ones with TME); this patch along with
> [1] makes the caching attribute for access as WB instead of falling back
> to UC due to ioremap (within xen_remap) being used improving the
> performance as explained in the commit.

So this is only a performance improvement?  One that people have not
noticed in over 3 years?  That does not feel like a real bugfix that
stable kernels should have to me.

Again, what is preventing you from just running 5.15.y in your system
instead?  Debian 11 is quite old as well, why not use Debian 13 or 12?
You only have one more year left of 5.10.y kernels so you need to
consider moving off of that as soon as possible.

thanks,

greg k-h

