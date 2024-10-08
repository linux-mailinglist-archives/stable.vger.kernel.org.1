Return-Path: <stable+bounces-81587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D39947C1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0741F25A05
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037E1DE88F;
	Tue,  8 Oct 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/VQfWG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B11D799E
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388297; cv=none; b=R3GWIJyDT15JHIQ4R+JMTz6KX/faiJ6d6ULf6sZdn85HWTuLVbW66XBk12yPUlKh0FZPj+JlCi9I9P422Mhej+JZ6zzElquIzDh0b9wvT53KzJNIYHEVhlDPSRb88SAWOuetFu4YDUjZtxqtOzwizfBhTC4HTXIRr43jK+cwj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388297; c=relaxed/simple;
	bh=0uC2Yh6l6/OF1D0/KD2NE2Fv+41xtQvci2BIFcTMHZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osQxU+7ttUaJlGCQPWSuKAmQWs+gJmehNXG5nnUzpT0xIhx29nQOtd8i+2N1WMMkpy6UowihBOa3N1UFPmbgZeNAfXLUdi8VYlTgM0ASkI0eh/2RnnhPTg+dQGJjFIK+Y43egXaFalGVnQ6/h0Qy+BdCUIZxRQ8y0fBBfL+UB5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/VQfWG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77ADC4CEC7;
	Tue,  8 Oct 2024 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728388296;
	bh=0uC2Yh6l6/OF1D0/KD2NE2Fv+41xtQvci2BIFcTMHZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/VQfWG/HsKelNr9U/ERf9c7NMsJ64wLB8XaOGooois/kuw4hrKMYU8LBz+CUvtUN
	 uFriZDCXB6Eheeul05NfNtxwwhjV+tnTmXY0XYj3fYOzc67MEx6SRPaRQ77GZW5gsJ
	 TwICX9EuLfOE17ZeZ6i3JnO56NFY6fY5AbV8aXzk=
Date: Tue, 8 Oct 2024 13:51:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com, ahalaney@redhat.com,
	alsi@bang-olufsen.dk, ardb@kernel.org,
	benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
	chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
	ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
	florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
	hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
	ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
	kirill.shutemov@linux.intel.com, kuba@kernel.org,
	luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
	mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
	rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
	vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
	yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
	yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <2024100848-blubber-clinking-6f45@gregkh>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
 <ZwUVPCre5BR6uPZj@duo.ucw.cz>
 <2024100823-barbed-flatness-631c@gregkh>
 <ZwUaGvyHBePPNQF/@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUaGvyHBePPNQF/@duo.ucw.cz>

On Tue, Oct 08, 2024 at 01:40:10PM +0200, Pavel Machek wrote:
> On Tue 2024-10-08 13:24:31, Greg Kroah-Hartman wrote:
> > On Tue, Oct 08, 2024 at 01:19:24PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Unfortunately for distributions, there may be various customers or
> > > > government agencies which expect or require all CVEs to be addressed
> > > > (regardless of severity), which is why we're backporting these to stable
> > > > and trying to close those gaps.
> > > 
> > > Customers and government will need to understand that with CVEs
> > > assigned the way they are, addressing all of them will be impossible
> > > (or will lead to unstable kernel), unfortunately :-(.
> > 
> > Citation needed please.
> 
> https://opensourcesecurity.io/category/securityblog/

To be specific:
	https://opensourcesecurity.io/2024/06/03/why-are-vulnerabilities-out-of-control-in-2024/

Yes, I refer to that in my talk I linked to, what they are saying here
is great, so work with cve.org to fix it.  We can't ignore the cve.org
rules while being a CNA, sorry, that's not allowed.

But that link talks nothing about an "unstable kernel" which is what I
take objection to.  As I always say, never cherry-pick, just take all
stable releases.  That is proven with much research and publications in
the past years, why people don't believe in it is beyond me...

good luck!

greg k-h

