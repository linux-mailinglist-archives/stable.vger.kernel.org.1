Return-Path: <stable+bounces-85119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06FA99E41B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486DCB23489
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC71E9080;
	Tue, 15 Oct 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9MB2srn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854381E5022
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988353; cv=none; b=Elke7Ze5lWJu3a+SB0SdN5L3bW0chmJChPDJcqyqn5fzqfX/K3q9+Zaz33Uucl1+wwcFwcMage34WKRXBwXF7kfVwK5Jq5VZhnamyaxpakxmBD/3p0FC1V+ib1NqL81bKfWxyFak1qMbmjXiiUPL7asBQ7dM0AZsPyrGzK54N6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988353; c=relaxed/simple;
	bh=aOyfIZ8MUf/tgLKWg8Q6zrbmauH5gdtWkBfRbi2eqGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecUltVzPbMiUQ3eHZ2k8UB+Ef8AJ+Ai2TGk+MzLFkPSE3ZhtuTOEoVaWYOqCGczoTlp1B4tX3gK+G+kPraaBGVguP7jkOnr8Vbcf8TJZWipHK/zRuT44MfB7gR0UTud00uVYuD9Is+kOtN2YbykUdQToPlnuqavwbBsOUb3WyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9MB2srn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAF5C4CEC7;
	Tue, 15 Oct 2024 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728988353;
	bh=aOyfIZ8MUf/tgLKWg8Q6zrbmauH5gdtWkBfRbi2eqGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9MB2srn5nNpFczeFjqjJdUIREbaQk/K+74VQ2FpqLl8odWjTVyEGhKPE0pDNISMR
	 BLLzMKnzRfpjMZgoTP1SxQbOuz85VwRm+2H8lbclDBVTktUVfv1xhgmze88MVFbqTn
	 o8/8q3ynrxME7crm6vfQ39EBdqvU11RFdeqKLkv8=
Date: Tue, 15 Oct 2024 12:32:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pedro.falcato@gmail.com>, stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: backport mseal and mseal_test to 6.10
Message-ID: <2024101534-shingle-rigor-5283@gregkh>
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh>
 <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
 <2024101437-taco-confusion-379f@gregkh>
 <CABi2SkVA3qynBG1Ra_v2pg_k-pAzfjGc4VSDMN2L9tv9BreAiw@mail.gmail.com>
 <2024101409-catcall-sequence-3ecf@gregkh>
 <CABi2SkUvE3uJT0Zt+1WWSgSAneVo+Y_-UYR7DqhGk8OBevs1Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUvE3uJT0Zt+1WWSgSAneVo+Y_-UYR7DqhGk8OBevs1Qw@mail.gmail.com>

On Mon, Oct 14, 2024 at 10:25:54AM -0700, Jeff Xu wrote:
> On Mon, Oct 14, 2024 at 9:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 09:19:55AM -0700, Jeff Xu wrote:
> > > On Mon, Oct 14, 2024 at 9:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 08:27:29AM -0700, Jeff Xu wrote:
> > > > > On Sun, Oct 13, 2024 at 10:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > How are you?
> > > > > > >
> > > > > > > What is the process to backport Pedro's recent mseal fixes to 6.10 ?
> > > > > >
> > > > > > Please read:
> > > > > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > > > for how all of this works :)
> > > > > >
> > > > > > > Specifically those 5 commits:
> > > > > > >
> > > > > > > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> > > > > > >     selftests/mm: add mseal test for no-discard madvise
> > > > > > >
> > > > > > > 4d1b3416659be70a2251b494e85e25978de06519
> > > > > > >     mm: move can_modify_vma to mm/vma.h
> > > > > > >
> > > > > > >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> > > > > > >   mm/mprotect: replace can_modify_mm with can_modify_vma
> > > > > > >
> > > > > > > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> > > > > > >       mseal: replace can_modify_mm_madv with a vma variant
> > > > > > >
> > > > > > > f28bdd1b17ec187eaa34845814afaaff99832762
> > > > > > >    selftests/mm: add more mseal traversal tests
> > > > > > >
> > > > > > > There will be merge conflicts, I  can backport them to 5.10 and test
> > > > > > > to help the backporting process.
> > > > > >
> > > > > > 5.10 or 6.10?
> > > > > >
> > > > > 6.10.
> > > > >
> > > > > > And why 6.10?  If you look at the front page of kernel.org you will see
> > > > > > that 6.10 is now end-of-life, so why does that kernel matter to you
> > > > > > anymore?
> > > > > >
> > > > > OK, I didn't know that. Less work is nice :-)
> > > >
> > > > So, now that you don't care about 6.10.y, what about 6.11.y?  Are any of
> > > > these actually bugfixes that people need?
> > > >
> > > Oh, yes. It would be great to backport those 5 mentioned to 6.11.y.
> >
> > Why, are they bugfixes?
> >
> Yes. For performance, there are 5% impact with mprotect/madvise.

That's not a bugfix, but we do sometimes take performance improvements
if it's really needed and the maintainer is willing to do the backport
for us.

> > > I don't know what will be the lifetime of 6.11.y, but keeping mseal's
> > > semantics consistent across releases is important.
> >
> > Stable kernels last until the next release happens, like has been
> > happening for 15+ years now, nothing new here :)
> >
> Does it mean that with 6.12, 6.11.y will be EOL soon ?

Yes.

> say in the next few months?

Yes.

> (Sorry that I didn't know much about linux release cycle. )

It's well documented, please see the Documentation/process/2.Process.rst
file for details.  If you have questions after that, please let us know.

thanks,

greg k-h

