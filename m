Return-Path: <stable+bounces-80588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAED98E157
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD371F22C46
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E931D174C;
	Wed,  2 Oct 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AO3ZaMFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A81D1314;
	Wed,  2 Oct 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888422; cv=none; b=Z9KUfKp2q0RtydvFXb+VVForhnxZuSMSoI7YE83ztf/J77z9jevRqDPoWSeNVbEMhdddRYoAxRzNw+iX/xJN4q7JRxexQEv+RnrGylWf+Wl9ewN599hk1OiTLgQTU+Tw5NTW2FMuhl4lakaDKFhCWZDftx6aEZc6WiRLS+901CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888422; c=relaxed/simple;
	bh=JZz8gzddKUszdtYw5MN3ktLmT45RZx+JHWcCROzRJDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN1AE7jc+cIQZyptseibmZfi/WyH+gIBK2v71X1+bocRrQY+1tvnAXm6e0cpyQE4iAHLDHF8tqzLEHpQLteoy18T3nl3Jd4Mosdxj5C16I7ncDElUUjtJuKT9B+lK0yuyuPYX5k4NpG04Mdv9tPNXk8uQA9mHVxR15+ffwS+JMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=AO3ZaMFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F714C4CECD;
	Wed,  2 Oct 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AO3ZaMFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727888419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3vi3F61bmre7831EOYYbn7XMr2/b9RWvATa9gIfC3k=;
	b=AO3ZaMFTjadjvh3hC2og6qgTtDNFU664rf/H5T2A4n0g3MVTO7vDX23T8trPDoeXJRk2UN
	0WCPrpZ2K15M+MHWFIcetZooLxiXdDTofBhswr9/qAOForgMXKlDXRwdYgdcXp1s+qgLOI
	Pci1Mkdg7wcS0vCjpbQomz4OE4OFtNI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id acf4af39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 17:00:18 +0000 (UTC)
Date: Wed, 2 Oct 2024 19:00:16 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Greg KH <greg@kroah.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <Zv18ICE_3-ASLGp_@zx2c4.com>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com>
 <2024100227-zesty-procreate-1d48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024100227-zesty-procreate-1d48@gregkh>

On Wed, Oct 02, 2024 at 08:21:36AM +0200, Greg KH wrote:
> On Wed, Oct 02, 2024 at 06:13:45AM +0200, Jason A. Donenfeld wrote:
> > On Tue, Oct 01, 2024 at 09:29:45AM -0600, Shuah Khan wrote:
> > > On 10/1/24 09:03, Jason A. Donenfeld wrote:
> > > > On Tue, Oct 01, 2024 at 08:56:43AM -0600, Shuah Khan wrote:
> > > >> On 10/1/24 08:45, Jason A. Donenfeld wrote:
> > > >>> On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
> > > >>>> On 9/30/24 21:56, Jason A. Donenfeld wrote:
> > > >>>>> This is not stable material and I didn't mark it as such. Do not backport.
> > > >>>>
> > > >>>> The way selftest work is they just skip if a feature isn't supported.
> > > >>>> As such this test should run gracefully on stable releases.
> > > >>>>
> > > >>>> I would say backport unless and skip if the feature isn't supported.
> > > >>>
> > > >>> Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.
> > > >>
> > > >> Not sure what you mean by Nonsense. ENOSYS can be used to skip??
> > > > 
> > > > The branch that this patch adds will never be reached in 6.11 because
> > > > the kernel does not have the corresponding code.
> > > 
> > > What should/would happen if this test is run on a kernel that doesn't
> > > support the feature?
> > 
> > The build system doesn't compile it for kernels without the feature.
> > 
> 
> That's not how the kselftests should be working.

If you'd like to get involved in the development of these, by all means
send patches. As you can see, for 6.12, these were intensely improved in
all manner of ways:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/tools/testing/selftests/vDSO

Just look at that flurry of activity. Things are getting better! And
things were in pretty bad shape before. If you think there's an
interesting subset of that for backporting, by all means go for it, but
do it thoughtfully and don't pick patches willy-nilly.

> They can run on any
> kernel image (build is separate from running on many test systems), and
> so they should just fail with whatever the "feature not present" error
> is if the feature isn't present in the system-that-is-being-tested.

So, it's actually not that clear what the best thing is. Firstly, for
vdso_test_chacha.c, it can't even compile without the symlink and a
resolving tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S symlink, which
is on a per-arch basis. You might say that in this case, it's best to
condition the Makefile on `ifneq ($(wildcard tools/arch/$(SRCARCH)/vdso/
vgetrandom-chacha.S),)` instead of on $(ARCH), but there's this ugly
wrinkle where some of the code that's being compiled is 64-bit only, and
x86_64 and x86 share a $(SRCARCH) path. (That Makefile makes use of
$(CONFIG_X86_32), which is pretty gross and might not work; I'm not yet
sure how to fix that.) Christophe experimented with having the compiler
decide, and then there being a runtime result, but it added a lot of
complexity that didn't seem necessary. There's more experimentation to
be done here.

Meanwhile, part of vdso_test_getrandom.c's purpose is to test whether
__kernel_getrandom() or __vdso_getrandom() is actually being properly
exported from the vDSO. This is also interesting on powerpc, where it's
implemented on both 32-bit and 64-bit, so there's the compat case to
worry about. That in turn means that this test has in it:

	vgrnd.fn = (__typeof__(vgrnd.fn))vdso_sym(version, name);
	if (!vgrnd.fn) {
		printf("%s is missing!\n", name);
		exit(KSFT_FAIL);
	}

And not exit(KSFT_SKIP), since that would hide the failure to export the
symbol. Now, you could say that since development on the fundamental
part is mostly concluded, we could move to a KSFT_SKIP, in order to
simplify the build choice and such. I'm not sure where I stand on that.
At the very least, there's still RISC-V coming down the pipeline for
this feature, so it probably would change after that comes out.

Anyway, that is all to say that this stuff has been thoroughly
considered, not haphazardly glued together or something. Maybe that
consideration has reached wrong conclusions -- that's an entirely
possible of an outcome -- but it wouldn't be for lack of caring. If
you'd like to contribute to it, I'd certainly welcome a hand. But please
don't do the arm-chair coding thing.

Meanwhile, this ENOSYS thing has nothing to do with what either of you
assumed it does. This is to handle obscure/exotic arm64 hardware, which
might not exist in the Linux world, that doesn't have NEON support. But
since arm64 support for this function didn't even come to Linux 6.11,
there's no point in discussing it as a backport.

Jason

