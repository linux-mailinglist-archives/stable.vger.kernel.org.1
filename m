Return-Path: <stable+bounces-100886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F929EE498
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79065188761D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D021148B;
	Thu, 12 Dec 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vGGVrOBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2n4Kbmk"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD38211486
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001104; cv=none; b=Q+ILSsmWqFvklYq3RPFe7Z7BwtFK6FECX2Ai2mrdvlPeT0l5nufCxFcoBw2NVBz8IUT5kXoD9VBjb0mMu2Yx4QJolWEoeOOtx+7KkQIk5c6Ai3EzZqDmnygZR8V2Wype1wP94+9B0y8wQUzJkKl49ydHCFiAzhqns9fz984eJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001104; c=relaxed/simple;
	bh=Dlt0+X4Bivm8dLX5z74u8Ct1ioAUD2HNRemaCubCh8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf+Exi0zkSoL+qkY/hKRfJhnl+yxtTDEMnbx4FA8ke17UZXLxxoYRF215zQc6OXMe+pY0RU0nSjTpp4LRgOXoGDfHVH9ckXWbMVwOSUzJTjoXEjQgBA2ynmYyfX/PjQOX1zrrcj2RarDvpaCW56XEEUmwtilDxRyHAwMgiN40sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=vGGVrOBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2n4Kbmk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAD8211401A8;
	Thu, 12 Dec 2024 05:58:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 05:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734001099;
	 x=1734087499; bh=dR5J0sMO3X1Lg0sjAWYqTwNNV3tVPWm3zyZvk2LyBZQ=; b=
	vGGVrOBg/JDqbrdapcq1yp3eYhoK4tTBWPjjELEVkQUkjxnSWrY7y0MIJYIoHNci
	jrz+P3e2ArE8t6DLj9hOmjlPzYWAFbR6rhsFaU03RwTcT5a7fXUZE1J/XxzRufqA
	Z7gJaCS8e9gUFwJN4XRQhYEy2uwe9ZkY58VyfEGE7wXImstJz4O3OSF0GgilLKPN
	BV025aPiWMzvUrrh2Kw8x60yqABqki0MlgHP2JRv26p8ikicVSMHF8hM1uXBwM0C
	PB95Gr/6AetmDuxrhTlzf7sMSOfEtZROoCuYmLu2zDNX0m7qfM3JywjbuWORxRBk
	FHD4ct/A2LGFjUAqp1gLZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734001099; x=
	1734087499; bh=dR5J0sMO3X1Lg0sjAWYqTwNNV3tVPWm3zyZvk2LyBZQ=; b=d
	2n4KbmkGVGdvTKpV0mSvOAbHfoenz5p2BbMGVEM4mqHq+yuKK1mTJNTT8KnHYbkh
	Tz5KXlmW9KQFuXti2zUqZCEgcOti/AXGLJ4LqQi/J5CwyVMPUZucCn6WTtS/7tzB
	Vu0TeweX8QmjFGZR2cpiHWYknr/bB1lP2D44WfGy7aGO4W+iWsi2CsfkMtYlM5mw
	fN84AchM5ntZh8tLLEEhjdBl2Q5hHJKjVg7Djuh4bMFZpPPcfwRB/Ilh6I9IfJtB
	/3qOeg4TcUPUZIu/CFEu9dgCELzde099W+hyfg+85dx4ruSWJkkxyaYgqqSDoWnx
	LtGMB7fcInWcGaQqyRKiQ==
X-ME-Sender: <xms:y8FaZ9lR6yYvh5YVLb4rcAzkd3CQtTd6XDszc04pA3YGNUHoFCAR2g>
    <xme:y8FaZ43rvOc_4l75ivfjeek70tb9dEqBAMBxiq8qIChHgyRYqRs4Z0_VUDAoiwRbm
    JJyR8UYCRaj1g>
X-ME-Received: <xmr:y8FaZzpRbcoQPF3v9DpPbummcDezZKDcqWffeimr3sRMj5ez_MYl3zmtDah9w8sFQU_9CehvYx-yzgR6SMDw6isDhV9z4iRPlO_8uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeevveetgfevjeffffevleeuhfejfeegueevfeetudejudefudetjedt
    tdehueffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglh
    hoiigrrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdroh
    hrgh
X-ME-Proxy: <xmx:y8FaZ9kd4dkiU2TG_P2PON_H_RQd_uEAQxcMFUvn4W4Sm49zAIlsUA>
    <xmx:y8FaZ71v-vP-YK5qS6oXfkaX_icdLHDOaDRN36ZogxthVq3a7tyy0g>
    <xmx:y8FaZ8v9J0tgOvRMXgf7sL3LH9zHkcv-YI_gIkH7wb9o3asFR1WS9g>
    <xmx:y8FaZ_UCzWFwbt2CIfJgx_J3iHDmO48esAVimH0t0QOiKKV2QfrsjQ>
    <xmx:y8FaZ1rfJNpyNZjvAojETLam0Xg9QB4wSF3ecw8yknkGXbrGmccdj-Tt>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 05:58:18 -0500 (EST)
Date: Thu, 12 Dec 2024 11:58:16 +0100
From: Greg KH <greg@kroah.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "rtla/utils: Add idle state disabling via libcpupower" has
 been added to the 6.12-stable tree
Message-ID: <2024121207-darkening-surrender-4ae5@gregkh>
References: <20241210204420.3582045-1-sashal@kernel.org>
 <CAP4=nvQ6wqxwVki--BdBHQ+5wuT36LWLYSW84FSEjO8awakmsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvQ6wqxwVki--BdBHQ+5wuT36LWLYSW84FSEjO8awakmsw@mail.gmail.com>

On Thu, Dec 12, 2024 at 11:37:24AM +0100, Tomas Glozar wrote:
> út 10. 12. 2024 v 21:44 odesílatel Sasha Levin <sashal@kernel.org> napsal:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     rtla/utils: Add idle state disabling via libcpupower
> >
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      rtla-utils-add-idle-state-disabling-via-libcpupower.patch
> > and it can be found in the queue-6.12 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This is a part of a patchset implementing a new feature, rtla idle
> state disabling, see [1]. It seems it was included in this stable
> queue and also the one for 6.6 by mistake.
> 
> Also, the patch by itself does not do anything, because it depends on
> preceding commits from the patchset to enable HAVE_LIBCPUPOWER_SUPPORT
> and on following commits to actually implement the functionality in
> the rtla command line interface.
> 
> Perhaps AUTOSEL picked it due to some merge conflicts with other
> patches? I don't know of any though.
> 
> [1] - https://lore.kernel.org/linux-trace-kernel/20241017140914.3200454-1-tglozar@redhat.com

Now dropped from both queues, thanks.

greg k-h

