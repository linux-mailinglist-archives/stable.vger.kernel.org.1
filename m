Return-Path: <stable+bounces-100887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7499EE49C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5747C281E71
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF2211486;
	Thu, 12 Dec 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="blluRLC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yn37y/Y9"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBB1F2381;
	Thu, 12 Dec 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001162; cv=none; b=F2f1REchdqL9rYAfos1VihmUc28muBrnRRtOwS7aZTsy0HPtTz91gGndv9rUVbSlCZFIbxCs2dVOg9Ivmd415s8hjW6gtUTDQKuHNevCxjrpVY1B7W3BVnJU8rfaHHBZp8Q9I3BlTJDXf/WdMYXhM3rK9t2UjsK6gwu62ItQK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001162; c=relaxed/simple;
	bh=mcK3h30a/lkzuSzxpZ0ZEEi1c/oiaM1UL0dOcf0URL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGU3BjQesRpJDTtXyKBGeshie8lqsTVmoNO/4dsdAR5tUZpvQUvKB7DNgKD2mdYfDfAYEvQvq9EIh+QfhdB9OeEGLh46OrbZrzGwlqPef6N1c3vLT/3Z4k6VJXEgfVQgHHQUbslTLRT1POKwfIdjXEb32ZWYMISK00z6jERWCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=blluRLC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yn37y/Y9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A25AB13814C6;
	Thu, 12 Dec 2024 05:59:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Dec 2024 05:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734001158;
	 x=1734087558; bh=gwhw9bU6KiITG3sp4wNEARpZ/37deJWGpNHhXpt1EbA=; b=
	blluRLC3Mklx3n83L5hDagBQF/Zj3wfin+MLaIN9G1V1xYDvwR8jVztoy/fwGYVa
	Zx96aeEA/yly8EBC8W7d2si/arnpzVZjcfvJYwwtV8OeBpbXGSxjfDo7CkPuQuEM
	CKNSrGaTqJIv2dLifERjQWWfCx5O7PlHrVSxmRYXTtIbX7VjR6REZPR+dZGGlm+J
	bNRXmKWnTl39SKPaCilvVjLLq3c+DZ4f0mZLRubznWwVYiE+cSLeusVLBom4Eocw
	jBBVyxyDlAmTyvu3WZ4ZLqhEEWTddKPCNn6kjcjc23wq0gTVNgPu6RVGTiJpf0XE
	L7Exk+LCcCpqfUftXkXFCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734001158; x=
	1734087558; bh=gwhw9bU6KiITG3sp4wNEARpZ/37deJWGpNHhXpt1EbA=; b=y
	n37y/Y9DGLzYn2qk7NHj2j64JHGqvK5nY38GLrh7YWO5bVKQtU/SUDBeJauYayGU
	W9FH7IEksubwrCuiUyLmWcK9MwUPOIEokUlQS9rcbsHI3EmVEdlq5NgA0cVAqIub
	vhzgfUyF1oOBEp6CAdNYxYErMtCZ1x1doJNywyLYj3M3KMogSQwwA1C7ftXB2K/8
	DZMYXUS3WZ1d9R/Uiq9dKVRygJqqvLYKxg4WPWXpNgC8/awTp2CeKOYOjZVKoL63
	z3kswL0wPXf4m/wrsRhU3F2qACpmopGsCk4MFlAc3+HWS/UQKuWQnAQG3vK/jckj
	KpxeXrafesFSh2VRZpEIQ==
X-ME-Sender: <xms:BsJaZy6UTWMVR3Mau-UxTm3jsRQbXiRZPYXGhJcrQ9PqpfO7cXNVQw>
    <xme:BsJaZ76Hh8Eu-uqSO9gj0MQEWSBLbe-nIuqqYfZzkKfhgf3ULxG1xAsiFxZ9OyT9W
    6KlOsLnYWcXTg>
X-ME-Received: <xmr:BsJaZxfYMQkaEwSygBBBAo0Cp9WiC8_YxAUTDU-MfsbTyMSX9VZIBM0vyJjcr6gQ01UcGU9CZz3_WGPx0vqR2L5g86mzb1PNYyxpPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepleekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeu
    ieekudefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvg
    hnjhgrmhhinhdrthhishhsohhirhgvshesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvqdgtohhmmhhithhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggv
    nhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:BsJaZ_IXdR5CljKvLL6BT6Ap0fGnBVSUppGMvFJDyO4X4JaeEjEC7A>
    <xmx:BsJaZ2JiulYYXKVEsfi1dWrGrjLcYv5pWCYws_yngen_a-eWJKrATQ>
    <xmx:BsJaZwyM_pAHi_L_YGHdlCu_bToZoZvYpoiOfj4Sb_FhQKYLBH0VgQ>
    <xmx:BsJaZ6L64WNkV3mXzZJzsILFnV3jalxdZIck9wvUv8UDb1JWjol1Zw>
    <xmx:BsJaZzBR5l4lKXYQfS9thRzM9ROJKcgot-CKjd7TmGA8O0XJ_91TpKGW>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 05:59:17 -0500 (EST)
Date: Thu, 12 Dec 2024 11:59:16 +0100
From: Greg KH <greg@kroah.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	bentiss@kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: Re: Patch "HID: bpf: Fix NKRO on Mistel MD770" has been added to the
 6.6-stable tree
Message-ID: <2024121205-wifi-step-8925@gregkh>
References: <20241210210012.3586101-1-sashal@kernel.org>
 <CAO-hwJL7HgrE0wTkG6U47N9k8LRiCR2AqZ4a0CmeX0Lip7uofA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJL7HgrE0wTkG6U47N9k8LRiCR2AqZ4a0CmeX0Lip7uofA@mail.gmail.com>

On Wed, Dec 11, 2024 at 09:27:42AM +0100, Benjamin Tissoires wrote:
> On Tue, Dec 10, 2024 at 10:00 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     HID: bpf: Fix NKRO on Mistel MD770
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      hid-bpf-fix-nkro-on-mistel-md770.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> 
> Please drop this patch (and in all previous releases).
> 
> Again, it makes no sense to backport any files in
> drivers/hid/bpf/progs on kernels before 6.11, and even then, it makes
> very little value as they are also tracked in a different userspace
> project (udev-hid-bpf).

Thanks for the info, now dropped from all queues.

greg k-h

