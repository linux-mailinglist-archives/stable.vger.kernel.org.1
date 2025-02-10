Return-Path: <stable+bounces-114651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81955A2F0E9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04AF188BE98
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA5204873;
	Mon, 10 Feb 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKVbmOEI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3E204861
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199954; cv=none; b=fWhLzpboHSRJTpijbiZi/hocUS918w9w84Y2dcTK7K+xJ7VmFgXm96bIigAzO6yKgey9bdnfPSDO0wqSbHfOxCaCtipfze8ePLulw7Mmlgb1PFHV//iF7Rv9RnNwvlm0zxWc6UGXNh8+8l0BOE0405s/GpFgdya4h86qzUC40Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199954; c=relaxed/simple;
	bh=P/ctmUMjn+LOgAtQLjjXfPgljir4CfZIfvWihq/RQb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jujLx6JzJJdv4cWcQDxhYGgeH9CptZzZp3WHxNfW1D4OVQEmsdS247S4PiJoQ82ODjy+rPKgDu9/g5TZOHPEkHVcufyoZng2VSBnfIaKgBHxEqmlzU1M8XKcUQK6Jt82eSxSmCvhqO1JadsKJIJHgTf0zjQTHkPpVHtu4w7aOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKVbmOEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CEFC4CED1;
	Mon, 10 Feb 2025 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199952;
	bh=P/ctmUMjn+LOgAtQLjjXfPgljir4CfZIfvWihq/RQb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKVbmOEI+9xMj+B/ZBdUanCUsJXeJ+tf3xSjizF7XHiidiI0oCjKLm1rvsiVJfmks
	 Y+6YTMM7M0nndvs4nmZXPvP4HUWANgBQkZNsObDuJRCfbenFYz8Q//TKwEnMDzZK/u
	 2H3xt80ZZq//MaB+IQAEY1QziAYcQHDKFz4Ee9Y/D4zUll2Uoy9RRiom8xNjJxRu7D
	 eU5jyozckEhcyirSm81+Hqxlofaj1+qKdZUIc5iELmVgvi+hTb31STOnmu2m4cH4Ng
	 C9n2T00pSwv+yycAYqQIrwLjASQbVHKThshzOtyZt7uYt/dyskcF/CQdS2pgiXFjB/
	 z+lg2fAIgYl1A==
Date: Mon, 10 Feb 2025 15:05:47 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 1/8] KVM: arm64: Unconditionally save+flush host
 FPSIMD/SVE/SME state
Message-ID: <20250210150546.GB7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-2-mark.rutland@arm.com>
 <20250207122748.GA4839@willie-the-truck>
 <Z6YI6IvG_N4txgz7@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6YI6IvG_N4txgz7@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 07, 2025 at 01:21:44PM +0000, Mark Rutland wrote:
> On Fri, Feb 07, 2025 at 12:27:51PM +0000, Will Deacon wrote:
> > On Thu, Feb 06, 2025 at 02:10:55PM +0000, Mark Rutland wrote:
> > > There are several problems with the way hyp code lazily saves the host's
> > > FPSIMD/SVE state, including:
> > > 
> > > * Host SVE being discarded unexpectedly due to inconsistent
> > >   configuration of TIF_SVE and CPACR_ELx.ZEN. This has been seen to
> > >   result in QEMU crashes where SVE is used by memmove(), as reported by
> > >   Eric Auger:
> > > 
> > >   https://issues.redhat.com/browse/RHEL-68997
> > > 
> > > * Host SVE state is discarded *after* modification by ptrace, which was an
> > >   unintentional ptrace ABI change introduced with lazy discarding of SVE state.
> > > 
> > > * The host FPMR value can be discarded when running a non-protected VM,
> > >   where FPMR support is not exposed to a VM, and that VM uses
> > >   FPSIMD/SVE. In these cases the hyp code does not save the host's FPMR
> > >   before unbinding the host's FPSIMD/SVE/SME state, leaving a stale
> > >   value in memory.
> > 
> > How hard would it be to write tests for these three scenarios? If we
> > had something to exercise the relevant paths then...
> >
> > > ... and so this eager save+flush probably needs to be backported to ALL
> > > stable trees.
> > 
> > ... this backporting might be a little easier to be sure about?
> 
> For the first case I have a quick and dirty test, which I've pushed to
> my arm64/kvm/fpsimd-tests branch in my kernel.org repo:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
> 
> For the last case it should be possible to do something similar, but I
> hadn't had the time to dig in to the KVM selftests infrastructure and
> figure out how to confiugre the guest appropriately.
> 
> For the ptrace case, the same symptoms can be provoked outside of KVM
> (and I'm currently working to fix that). From my PoV the important thing
> is that this fix happens to remove KVM from the set of cases the other
> fixes need to care about.
> 
> FWIW I was assuming that I'd be handling the upstream backports, and I'd
> be testing with the test above and some additional assertions hacked
> into the kernel for testing.

The backporting for Android will probably diverge slightly from upstream,
so if I'm able to run your tests as well then it would really handy.
Thanks for sharing the stuff you currently have.

The patch looks fine:

Acked-by: Will Deacon <will@kernel.org>

Will

