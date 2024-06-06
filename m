Return-Path: <stable+bounces-48303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5D8FE761
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631AD286A0D
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E949196C7C;
	Thu,  6 Jun 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RvqnyFUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oiPZD/uM"
X-Original-To: stable@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A5196428;
	Thu,  6 Jun 2024 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679692; cv=none; b=Eikaw1vEwZ18P0GHfVdCfIg49QLC5lQSyIy4j9TQw3TGQmB/GIttHiDcIh2w4hshalHWbzA+vvhO+njJAwnPuyxCMADvAtnkg6dGd0rzQe3PPhZL/Kp1jl0VYCE5edRCIFRMQQC5VWD7KNMjAnTHeJOFbcGx1y48mBvIjEyNPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679692; c=relaxed/simple;
	bh=oIwMipS3AlHfDLwiNOm61S8BN3VduPkvCci3fpCbguU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APb0wWa1AlYo3b3sblDa2siJjN4khecUGukBdap0S+0HBzFYobYQShBeUZCWCKSAN3hqhZ6ya0+/PNBb57o/IfDHw/jdrDVbYCUcVj61ShKu29HBe8QNYbMM6T7LpDuphl/DMMBN8eel/mSc3byivj8ZHP9+Kj3oTbWTWvPQ1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RvqnyFUn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oiPZD/uM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3361C1140193;
	Thu,  6 Jun 2024 09:14:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 09:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717679690; x=1717766090; bh=K1cq3Bh18d
	LkDVd7acFYf51Eko7K5AdqDkTZgJAPX8g=; b=RvqnyFUn5xPKJGGxeqVYU0M0tk
	rJkQ1DINJryjKDUzbGLLrll6bt9t/P0XHltlO+FxXatTGT7TnQ8E5qS2svGKBnW/
	SUdEWYUT/xrLMcFD66GzqtbbS2sSvYAqpGJHLLrdA6YzSU44KDQJli70l0+vEzTF
	Qn+Kt+XZmCe5FhBfz+fvmOsjo1LAeo5FT0aMm2+plv6VoK9lpk0FyD9cYy0GLk6r
	Svq8WXThzCAhTyyy6RiClNc/KEb5Gtbpcd0yW4wA5O7IpA/0gUBQHUSRelRmLlvX
	rWuf7YqpV3Vwa5r139e9/cXxilgF+zseYEQGEeKqyiXB1vkXST8TtC+s2hSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717679690; x=1717766090; bh=K1cq3Bh18dLkDVd7acFYf51Eko7K
	5AdqDkTZgJAPX8g=; b=oiPZD/uMGaGy8XURPlAT2Jilo5YPbcMiZ6MBygXUJERd
	MhuQk7FOPKRPg1/fRKMGP2gYnYz0B+P7V1vsH2WFQaFVDZu40R9dKitzT1D0ZSa4
	evkrdBMAK8Il/FyyZrjMC+9UQxXEOfRr3vfB6UfHVdzHCFHbmysO0ps2twAAtjDq
	MgGg1HVY/0pC/VAQxmHuK3+M1TCLkntSPvQI5opcwW4wwg6I6SLkR+O9sWSSGMZx
	+FhZbOyhLOu5BCXbTWGQurOUOz7Ni4XBNr82h3Vq8rBj+NMD8VNBhBEvhWGWFfQL
	eviCFRvNZzs6PDpEbKEDNUzq8CYgVvRm2DzdTmYd+g==
X-ME-Sender: <xms:SbZhZjLrvP2GJfWYP7BHPB-KcY4KfvFTXPlzax_P2K-nEumSz7HM1g>
    <xme:SbZhZnIszTpWV0cJPELmoYpA6R2g5idLnjSxUMUNHaziRpqgiuumlwokZWsL8e3K4
    B9WSKVH_3iEkA>
X-ME-Received: <xmr:SbZhZruwwivZKxStvlheB2ioumro28jxr_t3ZueFEge9FKIYVoKmpgQqKCJdFzAIGVhUeTwZqo2pKOmRIRu8dsDFFJSr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:SbZhZsat9OfKDvcDRic4sFzqx1Q30pyvtxoiV2TX0tdLS0gNMriGpw>
    <xmx:SbZhZqalGbo1OKIwrT9h78UAQxO1_D2p33c0Wmgr79ACX-VtA92HOw>
    <xmx:SbZhZgBIrXEpNBbbON_KAaYRJxHJEMGP_FRKVGXqpOfruOvjlQ4taA>
    <xmx:SbZhZoY5FeiKd2clnBpGfFvu-PYbigYdGHYKB3JXzBMnhb5qt-bUjw>
    <xmx:SrZhZnTtbFOIwRXyDM-CpFPT44QIyaSTApuGitu6MnVvOjfAnHEV0P5f>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 09:14:49 -0400 (EDT)
Date: Thu, 6 Jun 2024 15:14:48 +0200
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: Patch "arm64: fpsimd: Bring cond_yield asm macro in line with
 new rules" has been added to the 6.6-stable tree
Message-ID: <2024060619-drank-unheard-bd84@gregkh>
References: <20240605231152.3112791-1-sashal@kernel.org>
 <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>

On Thu, Jun 06, 2024 at 02:42:09PM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Jun 2024 at 01:11, Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     arm64: fpsimd: Bring cond_yield asm macro in line with new rules
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      arm64-fpsimd-bring-cond_yield-asm-macro-in-line-with.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> 
> NAK
> 
> None of these changes belong in v6.6 - please drop all of them.
> 

Ah, I see why, it was to get e92bee9f861b ("arm64/fpsimd: Avoid
erroneous elide of user state reload") to apply properly.  I'll drop
that as well, can you provide a backported version instead?

thanks,

greg k-h

