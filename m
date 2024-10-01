Return-Path: <stable+bounces-78477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D873398BBDC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782442845D0
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701331C1ACA;
	Tue,  1 Oct 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBydUgDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74B18C011
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784797; cv=none; b=qX8zh75Z2pwoDYcgvc4BNoZMsoRmk3jm5EO3afYcTZUMZ4SMoGZ/vJTyDlpDCp5E/x5uYqlAexnzoyRtBXq217gL+aE+6ByRhEXt/D3CVJ8h9R3MYQSkqIFz2IDJ2heHeLLeeYGoqnE11Xtwgy3RAVyrRVL1UoYGXRl9tHhCNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784797; c=relaxed/simple;
	bh=H9f7d/0P57ymXGoqsIFvgMwkEGwZ5TILMtLC7fcIv6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI3qVy2kXcZZvsJ0C90Vqm0UxpwGr7cPBv88pMLo0O/oF6Fu792X5vSA3gErRJdJ/7OpM6XeppVRsOQiZuqgBuVjQp3vo+zcTC1BkMyI7Crkg/hb4Lnw6jjCQ1+CrURhOjIrY3gOF3YKsgKTyOZ9RQtP9qv0l7IHlGhSTVT9uCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBydUgDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9621BC4CEC6;
	Tue,  1 Oct 2024 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727784797;
	bh=H9f7d/0P57ymXGoqsIFvgMwkEGwZ5TILMtLC7fcIv6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBydUgDBC/KQ0EKfIH+laNwkles0ahY9PgSL31PH3szIo0xiu2AxpaelWsAGJ77HM
	 ki2lD4UszlGnarQpX+Aq3EHNAtfEx2j8vJkrmaV5sACdY1jVj3Y1e6yn84dFE8FIef
	 eAjrfPdyta61Jo1G0RR/AYqzmE03uDzaXGCsWptU=
Date: Tue, 1 Oct 2024 14:13:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: patches sent up to 6.13-rc1 that shouldn't be backported
Message-ID: <2024100120-unlucky-sample-091b@gregkh>
References: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>
 <2024100107-womb-share-931a@gregkh>
 <ZvvjyyO00fL_JL4q@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvjyyO00fL_JL4q@zx2c4.com>

On Tue, Oct 01, 2024 at 01:58:03PM +0200, Jason A. Donenfeld wrote:
> On Tue, Oct 01, 2024 at 08:52:28AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 01, 2024 at 06:02:45AM +0200, Jason A. Donenfeld wrote:
> > > Hi Sasha,
> > > 
> > > I've been getting emails from your bots...
> > > 
> > > I sent two pulls to Linus for 6.13-rc1:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e1a5d43c5deec563b94f3330b690dde9d1de53
> > > 
> > > In these, I'm not sure there's actually much valid stable material. I
> > > didn't mark anything as Cc: stable@vger.kernel.org, I don't think.
> > > 
> > > As such, can you make sure none of those get backported?
> > > 
> > > Alternatively, if you do have reason to want to pick some of these,
> > > can you be clear with what and why, and actually carefully decide
> > > which ones and which dependencies are required as such in a
> > > non-automated way?
> > 
> > They say so directly in the commit, i.e.:
> > 	Stable-dep-of: 6eda706a535c ("selftests: vDSO: fix the way vDSO functions are called for powerpc")
> 
> Wha? Sasha added that. It's not in the original commit.

Yes, that's to document why this is being added to the stable tree.

> Is that tag anywhere in Linus' tree?

Again, no, this is added to help document why it is being added.

> > in each one.  So this seem to be needed to fix up the powerpc stuff.
> > 
> > I'll drop them all if you feel these should not be applied.
> 
> Yes, thanks.

Ok, I'll try to rework the other dependant patches to see if we can get
that fix in somehow without this change.  But why not take this, what is
it hurting?

thanks,

greg k-h

