Return-Path: <stable+bounces-85057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC50299D465
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190F61C20B5D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD31B4F08;
	Mon, 14 Oct 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aC9Gr4Eu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC01AE003
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922350; cv=none; b=c/udhNxeyx11FxQw5++DGnTIvh81S2x6mYwSWJ7e9PQ/Ui+wYTsTV8XOWNYK8c5Jr6Y4TZO8vebZGCLb2iTSNTwXgJDNTwBBCGqOm3JHkGa45JoJu3u51LVSeT5fqqwEqNCyBnYNy1epLwZ1p8kMF/3S1h/wzhT8rm2w3xLU0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922350; c=relaxed/simple;
	bh=OAUV6ISm7p7vDSvm5tc9L4GqRgcVOrGjRLuc34K4bOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQbd7sX9lNgcQjcslz8DkCXCq+l1nySjNHhkC8mzneGHJzCfHsSZ/l6u82TbgZsVuQDqMVP+qZb+D8+JmY6lHEth5CMhLHTRcwyRx88dDN8FTL9GuSwjRHGuRPZxAIz/bQidzfJDmeqWbM4+JzR7LNww/6Hp1YUJ3judba5ujfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aC9Gr4Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E627C4CEC3;
	Mon, 14 Oct 2024 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728922349;
	bh=OAUV6ISm7p7vDSvm5tc9L4GqRgcVOrGjRLuc34K4bOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC9Gr4EunwdCeL3UHW4vptrip3g6211sG+aA4xVW/4nRd5v6mBZpXpTVif9GhqZBo
	 tDLRpGJHRmRgtoC4A57It9ZXG44Dxmb4Nz5e6hJyRmDc6R9/mAIfg4MQMec0zDtQkf
	 Z5Q+u97Umcp7UPXVsqnBkbFIS7szoR/PA7Ojot0A=
Date: Mon, 14 Oct 2024 17:56:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pedro.falcato@gmail.com>, stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: backport mseal and mseal_test to 6.10
Message-ID: <2024101437-taco-confusion-379f@gregkh>
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh>
 <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>

On Mon, Oct 14, 2024 at 08:27:29AM -0700, Jeff Xu wrote:
> On Sun, Oct 13, 2024 at 10:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > > Hi Greg,
> > >
> > > How are you?
> > >
> > > What is the process to backport Pedro's recent mseal fixes to 6.10 ?
> >
> > Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how all of this works :)
> >
> > > Specifically those 5 commits:
> > >
> > > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> > >     selftests/mm: add mseal test for no-discard madvise
> > >
> > > 4d1b3416659be70a2251b494e85e25978de06519
> > >     mm: move can_modify_vma to mm/vma.h
> > >
> > >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> > >   mm/mprotect: replace can_modify_mm with can_modify_vma
> > >
> > > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> > >       mseal: replace can_modify_mm_madv with a vma variant
> > >
> > > f28bdd1b17ec187eaa34845814afaaff99832762
> > >    selftests/mm: add more mseal traversal tests
> > >
> > > There will be merge conflicts, I  can backport them to 5.10 and test
> > > to help the backporting process.
> >
> > 5.10 or 6.10?
> >
> 6.10.
> 
> > And why 6.10?  If you look at the front page of kernel.org you will see
> > that 6.10 is now end-of-life, so why does that kernel matter to you
> > anymore?
> >
> OK, I didn't know that. Less work is nice :-)

So, now that you don't care about 6.10.y, what about 6.11.y?  Are any of
these actually bugfixes that people need?

thanks,

greg k-h

