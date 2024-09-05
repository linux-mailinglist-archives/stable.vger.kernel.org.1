Return-Path: <stable+bounces-73164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBF96D375
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA721F2ACB4
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C28194C6F;
	Thu,  5 Sep 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQYVmaE/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455B194AD9;
	Thu,  5 Sep 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528982; cv=none; b=WY9ZxjTJgjv2VuOKGkN3r2JVV0U95i62lPVmaQdCJgZQH+KYwzPPEX9VxsdxAqUxE1kiqqpi2ptxX01TB8ep3SEieddfo0vMcrUhKvOTe/Vo71WYRbPTAwozriS0Ep/HJCMf+tm9Rtldw67zCZ/WhY0dL3O6h0qrNM0RnsJev+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528982; c=relaxed/simple;
	bh=1P5szQ0lyJISmfHOtw4B6lt1baYfPKswS5UJtRPvARw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6/Rb1QwauxPUrL4Vgt7Qtiv/KgKk0w2ZeCzPPIneU5lkFF2ROy34B++fXw3uXeDvMQQpwbROBvasaKrLduQAJJU+fh3TRj/zQ500XIir+eBpSpjocxXD6x6uZtli+AeKTzk+ZFt5VC3vctmDNIIClLjHQnCvtB32iOpPkSJ4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQYVmaE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFC4C4CEC3;
	Thu,  5 Sep 2024 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725528981;
	bh=1P5szQ0lyJISmfHOtw4B6lt1baYfPKswS5UJtRPvARw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQYVmaE/ziTh2Dp6wjdhXeatf9rD05Jvc4Kp3+4WQBJholrtOucoSno58oPDUYnUt
	 1BMjjjqeZTeY/hHmh9RT8ww3LGjuVMzxsdI0c+6vzzfgewSTsYT1Z2YMY54jH0Qa3u
	 5i/w7EOfUbyaQggPiIQXLv/RWlSmNwc8ccyXQuVw=
Date: Thu, 5 Sep 2024 11:36:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: validate event numbers
Message-ID: <2024090541-bride-marbled-f248@gregkh>
References: <2024083026-attire-hassle-e670@gregkh>
 <20240904111338.4095848-2-matttbe@kernel.org>
 <2024090420-passivism-garage-f753@gregkh>
 <fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org>
 <2024090556-skewed-factoid-250c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090556-skewed-factoid-250c@gregkh>

On Thu, Sep 05, 2024 at 11:33:46AM +0200, Greg KH wrote:
> On Wed, Sep 04, 2024 at 05:20:59PM +0200, Matthieu Baerts wrote:
> > Hi Greg,
> > 
> > On 04/09/2024 16:38, Greg KH wrote:
> > > On Wed, Sep 04, 2024 at 01:13:39PM +0200, Matthieu Baerts (NGI0) wrote:
> > >> commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.
> > >>
> > > 
> > > This did not apply either.
> > > 
> > > I think I've gone through all of the 6.1 patches now.  If I've missed
> > > anything, please let me know.
> > It looks like there are some conflicts with the patches Sasha recently
> > added:
> > 
> > queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
> > queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
> > queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
> > 
> > >From commit 0d8d8d5bcef1 ("Fixes for 6.1") from the stable-queue tree:
> > 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0d8d8d5bcef1
> > 
> > I have also added these patches -- we can see patches with almost the
> > same name -- but I adapted them to the v6.1 kernel: it was possible to
> > apply them without conflicts, but they were causing issues because they
> > were calling functions that are not available in v6.1, or taking
> > different parameters.
> > 
> > Do you mind removing the ones from Sasha please? I hope that will not
> > cause any issues. After that, the two patches you had errors with should
> > apply without conflicts:
> 
> Ok, I've now dropped them, that actually fixes an error I was seeing
> where we had duplicated patches in the tree.
> 
> >  - selftests: mptcp: join: validate event numbers
> >  - selftests: mptcp: join: check re-re-adding ID 0 signal
> 
> I'll go add these now, thanks!

I just tried, and they still fail to apply.  How about we wait for this
next 6.1.y release to happen and then you rebase and see what I messed
up and send me the remaining ones as this is getting confusing on my
end...

thanks,

greg k-h

