Return-Path: <stable+bounces-85060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950CB99D48F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E12AB26199
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA601AE01F;
	Mon, 14 Oct 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lWtQaKE7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F71AB6E6
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922984; cv=none; b=jz9q+IgS0mbQA/+POSKQu2YWq/xkez9MVQGMsnI+9W0tnc2oxI86wbWUFFG5GzcLpApqY3A/q3vvE1puWP8FttC+gO7U3Ld+mzOf3wqf1B59zHKrbpa+rSaA4VAd6GvQMT/ijRIeKzbms7IL94JtqBwNVtqX9LXmvjMn+jzKym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922984; c=relaxed/simple;
	bh=Y6gbczwYnvz1SwloZvay0pz8pPosbY1Vh6Cn6hun2nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qix9xwOxotg2BweZgEe8m8Be7FuYOjIDcVCi8HaR13R6HEJ5pBxwFl5+sIM8ZGjVoelE5I0PMSVtuOHIZNDx0yvXNss92uLEbNzlSnLBCaaVN+ulMy8FoQhp7coOyI2gdzWTkfRCkvT4Wcbn9F507oI1kphh0xTdin7qcB8K5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lWtQaKE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D47C4CEC3;
	Mon, 14 Oct 2024 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728922983;
	bh=Y6gbczwYnvz1SwloZvay0pz8pPosbY1Vh6Cn6hun2nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWtQaKE7Wn0eJNvea50z4wjTCAfWSn7ELW2ZoFiN12XNIe19ViGmXQ1MrM3f1uFsn
	 sE72fLJYEV9Uc8iK2Bc6rSVvWzeZCgOBPEhH4eWBG42eHcDxc61SBlf2QD531gbtXU
	 kjuMNXUxwD09hgpH6KS6y9qo2z4YD50VPB6hMguY=
Date: Mon, 14 Oct 2024 18:23:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pedro.falcato@gmail.com>, stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: backport mseal and mseal_test to 6.10
Message-ID: <2024101409-catcall-sequence-3ecf@gregkh>
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh>
 <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
 <2024101437-taco-confusion-379f@gregkh>
 <CABi2SkVA3qynBG1Ra_v2pg_k-pAzfjGc4VSDMN2L9tv9BreAiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVA3qynBG1Ra_v2pg_k-pAzfjGc4VSDMN2L9tv9BreAiw@mail.gmail.com>

On Mon, Oct 14, 2024 at 09:19:55AM -0700, Jeff Xu wrote:
> On Mon, Oct 14, 2024 at 9:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 08:27:29AM -0700, Jeff Xu wrote:
> > > On Sun, Oct 13, 2024 at 10:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > > > > Hi Greg,
> > > > >
> > > > > How are you?
> > > > >
> > > > > What is the process to backport Pedro's recent mseal fixes to 6.10 ?
> > > >
> > > > Please read:
> > > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > for how all of this works :)
> > > >
> > > > > Specifically those 5 commits:
> > > > >
> > > > > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> > > > >     selftests/mm: add mseal test for no-discard madvise
> > > > >
> > > > > 4d1b3416659be70a2251b494e85e25978de06519
> > > > >     mm: move can_modify_vma to mm/vma.h
> > > > >
> > > > >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> > > > >   mm/mprotect: replace can_modify_mm with can_modify_vma
> > > > >
> > > > > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> > > > >       mseal: replace can_modify_mm_madv with a vma variant
> > > > >
> > > > > f28bdd1b17ec187eaa34845814afaaff99832762
> > > > >    selftests/mm: add more mseal traversal tests
> > > > >
> > > > > There will be merge conflicts, I  can backport them to 5.10 and test
> > > > > to help the backporting process.
> > > >
> > > > 5.10 or 6.10?
> > > >
> > > 6.10.
> > >
> > > > And why 6.10?  If you look at the front page of kernel.org you will see
> > > > that 6.10 is now end-of-life, so why does that kernel matter to you
> > > > anymore?
> > > >
> > > OK, I didn't know that. Less work is nice :-)
> >
> > So, now that you don't care about 6.10.y, what about 6.11.y?  Are any of
> > these actually bugfixes that people need?
> >
> Oh, yes. It would be great to backport those 5 mentioned to 6.11.y.

Why, are they bugfixes?

> I don't know what will be the lifetime of 6.11.y, but keeping mseal's
> semantics consistent across releases is important.

Stable kernels last until the next release happens, like has been
happening for 15+ years now, nothing new here :)

If you wish to have patches backported to stable kernels, please read
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h

