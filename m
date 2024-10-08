Return-Path: <stable+bounces-81578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E89946C1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9721F212D8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B61D2F58;
	Tue,  8 Oct 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tzjKW/u9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB81D07A3
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386654; cv=none; b=VhIPStCdAoojvIN08bMrFf2huT8bl+LXJZHboL2+veQHNyg+OSpe2GB2bGpFHkG5BRlpQYTTMvktePPoxOqQV1SFhmEu5H4yZzeGFr3gGu+k/WdA9CqtJ7S/aaaJH9p0gAv2dRyNKK7pMpOLOnrQPkiiZzCGqaYfG4VJwmduh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386654; c=relaxed/simple;
	bh=SkfAZZO0gte+KODGsqLykLFr1kKnxfM9DThuvU4RGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYZWRIGOtOQXHkUtnVg5SQYu8SIwW//FHSC1L6U0G2xvb/hgWX+RiMnp+2vxk+gFEDjTBQfdfmoMiCWTIQJ2EbRjxQJk7OcEPYKSnqwx0MW2jX5z+ZRH59l+k7zczifI7M2Hwtu5sgHm7ugQ1yu+4mx/oDEs/6EKcW/ngFSocRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tzjKW/u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0D3C4CEC7;
	Tue,  8 Oct 2024 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728386653;
	bh=SkfAZZO0gte+KODGsqLykLFr1kKnxfM9DThuvU4RGH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzjKW/u9Y2nDCDcKFJHo/F7Ov2KpBdII8uk3mR5yVjVRb1WOVFRk2FIbuVafc5106
	 mV4WJTEubT77WYJKNUpO1Qo0YStsLHQ2K/XkulzH6l2MCkr374ie+Ui7UFQNjL11cZ
	 K+G1vbUViKDFPuNfCS6h0fX0IrWZzSY/ZyQ5eu/w=
Date: Tue, 8 Oct 2024 13:24:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vegard Nossum <vegard.nossum@oracle.com>,
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
Message-ID: <2024100820-endnote-seldom-127c@gregkh>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <ZwUUjKD7peMgODGB@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUUjKD7peMgODGB@duo.ucw.cz>

On Tue, Oct 08, 2024 at 01:16:28PM +0200, Pavel Machek wrote:
> On Wed 2024-10-02 09:26:46, Jens Axboe wrote:
> > On 10/2/24 9:05 AM, Vegard Nossum wrote:
> > > Christophe JAILLET (1):
> > >   null_blk: Remove usage of the deprecated ida_simple_xx() API
> > > 
> > > Yu Kuai (1):
> > >   null_blk: fix null-ptr-dereference while configuring 'power' and
> > >     'submit_queues'
> > 
> > I don't see how either of these are CVEs? Obviously not a problem to
> > backport either of them to stable, but I wonder what the reasoning for
> > that is. IOW, feels like those CVEs are bogus, which I guess is hardly
> > surprising :-)
> 
> "CVE" has become meaningless for kernel. Greg simply assigns CVE to
> anything that remotely resembles a bug.

Stop spreading nonsense.  We are following the cve.org rules with
regards to assigning vulnerabilities to their definition.

And yes, many bugs at this level (turns out about 25% of all stable
commits) match that definition, which is fine.  If you have a problem
with this, please take it up with cve.org and their rules, but don't go
making stuff up please.

greg k-h

