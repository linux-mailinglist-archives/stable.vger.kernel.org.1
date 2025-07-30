Return-Path: <stable+bounces-165189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45048B158A2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F825474FB
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 05:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2B1E5711;
	Wed, 30 Jul 2025 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dpgq5wq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB51F237E;
	Wed, 30 Jul 2025 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854914; cv=none; b=dd0hFxSXz7Qc28hKVjjzzVFD+PHG4bi8YmQKAnxTYEqhNtaNclCicLejydaeTfXvRmUAx2IfCZMX+AUUSDBjtEowzdCa2MgfGl3PwM3AN7kuPpKMuwlFgqNsfyRB7OTWO0o4Z3wB7jtbYnU13fOtvlLWpYHglwkasnCddN4mZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854914; c=relaxed/simple;
	bh=l39yP17AT16G16kKr5giWs+Iiz4UMAfGGUKUFJzi+7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6No/g0GGoBFcvDluv75oBCgdScLGYpgWw+hytGE+/zawsgm44Cs3R4pRw1sAsmcCKBAbhYCOHPIS8q+PELn+qFgOE2SFtdKbdfActzCUzjjOIItOaRLdcuGgFuLg0e4heSaDrXw4ZGZ5+Hx932f1c/XB3dP3UCl1hE4me0hkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dpgq5wq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE0C4CEE7;
	Wed, 30 Jul 2025 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753854913;
	bh=l39yP17AT16G16kKr5giWs+Iiz4UMAfGGUKUFJzi+7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpgq5wq8CMjGI6JKHzip4qRQ9RMniFu58rWBzhr9LHhdRePWbzqE7FuyUAPLBYe7R
	 gx3tA2qf/KDipJzLmHSvi2eRjYkhVURklLqBtHsdiU5g0PjXwnJ2YrxNE/An/ygdvi
	 5E1MJe9TaAsfWqfIoZE4CBJpbKrY1gDnH5RP62oc=
Date: Wed, 30 Jul 2025 07:55:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de,
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
Message-ID: <2025073024-musky-smashing-812e@gregkh>
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <2025073013-stimulus-snowdrift-d28c@gregkh>
 <CAO9wTFihpoVsf-SZYn6yUhCSuN9cBXFGWeGegDsS1QHk4wS7-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9wTFihpoVsf-SZYn6yUhCSuN9cBXFGWeGegDsS1QHk4wS7-Q@mail.gmail.com>

On Wed, Jul 30, 2025 at 11:05:31AM +0530, Suchit Karunakaran wrote:
> On Wed, 30 Jul 2025 at 10:22, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 30, 2025 at 09:56:17AM +0530, Suchit Karunakaran wrote:
> > > The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> > > wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> > > INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> > > X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
> > > The error was introduced while replacing the x86_model check with a VFM
> > > one. The original check was as follows:
> > >         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
> > >                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
> > >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >
> > What do you mean by "original check"?  Before the change that caused
> > this, or what it should be?
> >
> 
> Original check in this context refers to the change before the erroneous code.
> 
> > > Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> > > Cedarmill (model 6) which is the last model released in Family 15.
> > >
> > > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> > >
> > > Cc: <stable@vger.kernel.org> # v6.15
> > >
> > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > Nit, no blank lines beween all of those last lines.  Hint, look at all
> > of the patches on the mailing lists AND in the tree already, you have
> > hundreds of thousands of examples here of how to format things :)
> >
> 
> Sorry about it. Should I send a new version of the patch removing the
> blank lines?

That's up to the maintainer(s) of this subsystem, if they want to
manually edit the change or not.  As it's the middle of the merge
window, no one will probably be doing anything for another 2 weeks on it
anyway, so just relax and see what happens :)

thanks,

greg k-h

