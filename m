Return-Path: <stable+bounces-78596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50F98CD0F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 08:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CB21C210D0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB1823AC;
	Wed,  2 Oct 2024 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FwwOO2s2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hww04qCM"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6884DE0;
	Wed,  2 Oct 2024 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850103; cv=none; b=MuCL5L0u+OzsxMpAO2wr83+XvtXptmlp29c6VR8vkpSWjp99KcyeCC9AVgpvzr9P5yNN83zsiBdrMclcCdWDpyxE4zX/FGh5nE1fZpJq7igOtGklaVXnGquYxou9IPyIZ40I8UeipJXDdfMsvz1p374SM88GtkXhKbT2U9+NF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850103; c=relaxed/simple;
	bh=OYwR2UIVRlLxCSWG4Kgykf30j3e4seyiM/kys2W8oKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/lKeeEQdQk3+R8d81D5BEfVDm8AP9YuQUTfJRt6HmaS5x2dbis22ccii0K4gUFMCa5ZKivNOrIGrZrP3MyHx3LSX3KtZ6hPj6WNsgM+sLREpUE0hfQcr3oWvYtJjq7jA5GJHv39h3FTduYopOT0jAP2/pz4vVkZ8gAWC6Rf9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=FwwOO2s2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hww04qCM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 436511140185;
	Wed,  2 Oct 2024 02:21:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 02:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727850100; x=1727936500; bh=DmCF/hSCPm
	Nd0pBrpYB0ObHUKxIqKWrk/EUSMN9QKYk=; b=FwwOO2s2ZCHvHqfYsHuS0RS33A
	tcssyGojSJe4b2Q3SLRim/RWxGAv4yl34VUUz5DFcLNpuuUXpRy3GiFPNV0MxkhU
	gJnW+3TwcBH6+cCT2AteLbYQIy5ResAtMh02pyjDINiBfthywGudd9g6f57uiphd
	nU+PDjY/kePGMRJEfAiDTRMbohP7LJHaD2qkGVTpUsG/QwVg47XAuetez4yF1HLy
	xZpuAPYgwgs0JT9GyQg4J7ksstp7bNu4QPpSi6kCGj9wDUk03Q84oDYXQkhunEwh
	PcYtfWxE2C4MW5w+LFUcz+fJTPN+PdIOWoVFqIuY1kjpYRokK7FZFZdzfuCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727850100; x=1727936500; bh=DmCF/hSCPmNd0pBrpYB0ObHUKxIq
	KWrk/EUSMN9QKYk=; b=hww04qCMweBi5cd3SxW5xIHC5E0rsQoMjpxQFPyMBF20
	R/reUo34eYwm10xYsQB5/eiM2Ei1wf/2YgG/CGZ4f3Xc0ld37Th4tWT7mzhqGZ5i
	1HGx4U2LV1EK0qfmpgCLnpssAmT+nDaA6xsX7buDb5A0K0IYbrznwDQM+oc/ok1t
	Jn3CgMxHapy7G6tAKaovnG3LTfNbwk8BP1DmhCs46aJvejhCrszwsiGfvS+8uBxy
	ORVobUYW9PUtg/7LFAg1BP+hSuU2jJVGyhcqcHy8SPRbATa3w4SQt4PsTA954wrZ
	speGP+5sjlcKvvbfUrPpDHCoM3zItpuSvNcgGyDTAg==
X-ME-Sender: <xms:c-b8ZtOp-FwV_OucAf34iq9_7_gxl1nV53Sg63OHSRk5Owrpdj9sHg>
    <xme:c-b8Zv_87c4xVP8I3mkGT8Qo2gY4FklGuRqqWDRBzfh4xU2q5wHGVy5-F0JT3Pegg
    oNOit1ew8J8dw>
X-ME-Received: <xmr:c-b8ZsQqFkFVTvjEiV0QexKFNzKCbBO5JApgaR6mv1161vG7IrIeOIs7jhqavrIDNLUTOuzj4M1q0D_46Tjhzp777J870MwM2-rSnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueef
    hffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpth
    htohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghshh
    grlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:c-b8Zpu5b0pPRJV_X8ayzDTytk8V2G1yqf6hwOO-kSpcInzoG678Yw>
    <xmx:c-b8ZlcNe9NLNKf0UohYPOG77VI6MoHuKKIoCa0q4h6Agxa9axqNEw>
    <xmx:c-b8Zl10e9jWls0Ej7277fy2S18lOfsszjcCnB7CEmnGCCm_GFkXvQ>
    <xmx:c-b8Zh-rdXX_k8T2xmvRc7S0RHIJvXuLy8vyC54EBeEt5oZsCw_O9g>
    <xmx:dOb8Zj2x7o5oLfE6wL46xpgeIIVdFPWlFdsUFEQE-PcVghpAKJc2jKL_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 02:21:39 -0400 (EDT)
Date: Wed, 2 Oct 2024 08:21:36 +0200
From: Greg KH <greg@kroah.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <2024100227-zesty-procreate-1d48@gregkh>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvzIeenvKYaG_B1y@zx2c4.com>

On Wed, Oct 02, 2024 at 06:13:45AM +0200, Jason A. Donenfeld wrote:
> On Tue, Oct 01, 2024 at 09:29:45AM -0600, Shuah Khan wrote:
> > On 10/1/24 09:03, Jason A. Donenfeld wrote:
> > > On Tue, Oct 01, 2024 at 08:56:43AM -0600, Shuah Khan wrote:
> > >> On 10/1/24 08:45, Jason A. Donenfeld wrote:
> > >>> On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
> > >>>> On 9/30/24 21:56, Jason A. Donenfeld wrote:
> > >>>>> This is not stable material and I didn't mark it as such. Do not backport.
> > >>>>
> > >>>> The way selftest work is they just skip if a feature isn't supported.
> > >>>> As such this test should run gracefully on stable releases.
> > >>>>
> > >>>> I would say backport unless and skip if the feature isn't supported.
> > >>>
> > >>> Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.
> > >>
> > >> Not sure what you mean by Nonsense. ENOSYS can be used to skip??
> > > 
> > > The branch that this patch adds will never be reached in 6.11 because
> > > the kernel does not have the corresponding code.
> > 
> > What should/would happen if this test is run on a kernel that doesn't
> > support the feature?
> 
> The build system doesn't compile it for kernels without the feature.
> 

That's not how the kselftests should be working.  They can run on any
kernel image (build is separate from running on many test systems), and
so they should just fail with whatever the "feature not present" error
is if the feature isn't present in the system-that-is-being-tested.

thanks,

greg k-h

