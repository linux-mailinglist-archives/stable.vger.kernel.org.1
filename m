Return-Path: <stable+bounces-109610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43FA17D0F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 12:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7777A17F6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0791F12E9;
	Tue, 21 Jan 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="g0SRljO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtJw4VlP"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CE1F0E31
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459174; cv=none; b=G8WM7JVux/AGqSSg5LQNyMWInq0B3KIsFkOvoptwjzFB+BGKWmnMc12JQWVSXJ8ZNdtuq8HWqRRysykVwb3VifYPmRUPhlKM2ufpQMlTCkgdWIwcX9CQ7+liBeo+Z1KTAI82RCy+fkKDLiQLpByZM/Hik+v8kOY/c45ibSHTNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459174; c=relaxed/simple;
	bh=whKp/oapmMbiPSTwDKW9Z5OhYtTxLPZ0RvS+Qyokk90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyS4M2Fyrg9Kn0k2HsMR35eLRylDRkvFlTGDvF0DWxvkOLssY+IrOh+xTHk/lpwSYucy8xQxkHfjdRxqp3wpPkpcsZnNYRMDx0KHiEZILlEit3F0XSGf3XgRo/X4lSnAsgRjlnjpXgDKETthmHL5IcAty/zoVJQhSkon/ruD/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=g0SRljO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtJw4VlP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8740B114013A;
	Tue, 21 Jan 2025 06:32:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 06:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737459170; x=1737545570; bh=1AkRqmVJka
	X95Z35aFrmV8Tb+S5Wb41CVHR9aiBL0Cw=; b=g0SRljO+cSvvup0aEKUyMRJYBN
	LpiJwHZ4X7cHtJyHKACe1rI02a1KagE/7fDS09mY5pIad0t/Txe7Oro0/RbeMB2f
	biYjZEwpRjR6pmBhGaT7lw2PZOTP8qkoBjhKw7Uj6vWzM4uwrzrU9dnjrYZMivqH
	3kaeO6UOCAATWqPX/cVvjVD4wAVLpPoNtuSJVq/Q8AZ6rhRLzGNPKKNR3mUexwP2
	bfRfYHcAiMMOOPrOM/V9zBaG+euOJ10CIglKC0B/ICWPOrLWWpi1Be7Uy/f3kDjd
	5WzFyNd15PYGtQiB8fRceZ7ABfl2cZ6cAS9w5VcRMlXC6fbn0cgXDymx8WFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737459170; x=1737545570; bh=1AkRqmVJkaX95Z35aFrmV8Tb+S5Wb41CVHR
	9aiBL0Cw=; b=rtJw4VlPXXcm4VeeixCam1+EWhoXU0WrpQbIe02qTOHPOGX1lQA
	IO0EkamWruqD+bpTpmvK9hFawgha5xbUXprkJpTmELjTdtG+TCo2x9Ux3mDkSJjd
	+VX7ITuP+MUSdow6KUQTwYZ2AdU/alukJJJIgAr7/AYfgzeGJs7LvjBn9Ygbw0uz
	eL48ZETkqbBqovk0eUKoU51jHva55MXHrlf0hs9MVBhAAlScyYClhh+NWCp+gbxa
	Kzx1GV41r7xJfNggu+xhd8KrExwJ1PJd6QpVu6l1jqAHgt3WQP4OY7TRnUQ6TZws
	qVMwfx4pxnqN9brscop6BGI6foF3UdjdFgQ==
X-ME-Sender: <xms:4oWPZ9miXgEyeunk22TCSVm-wJJBq-Xzv2RUNMG8587jAx_uwWgHVg>
    <xme:4oWPZ41onDHsVqdePJYC6a8arOU6ayuMAegTyH79xlfjo2hWPkhVIrjD8gm8mVoLJ
    H9xYpXQXfY1dg>
X-ME-Received: <xmr:4oWPZzqK40RhjLZNTH45QJ317Ib5kcdFlGbi-46t74tz_LpCeRG94VeTCqFOidw9wMCO0t9RRqbdGLxrKl-q8sN9RFU6PSogJKmEkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheek
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepkhhrrghmmhgvseguihhgihhtrghlmhgrnhhufhgrkhhtuhhrrd
    gtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhohhhnrdhjohhhrghnshgvnhestggrnhhonhhitggrlhdrtghomh
X-ME-Proxy: <xmx:4oWPZ9libcFXe9yj3boAUi56VZqVclyOk_453aiq0Mv2kKHB0KirzQ>
    <xmx:4oWPZ73QsSxctDJF_OFpBskRgylmdAqGxMWA4aoPFvE7puxdDJnU9g>
    <xmx:4oWPZ8tKYp49gjUo37a4vCZXx-IpMPUgFdvpTLFDDejX10Jtn0xJ9g>
    <xmx:4oWPZ_XLzS71RkKkaXV9bpuSC-tC0JPDJlWSoILBrovfryjXvczr9A>
    <xmx:4oWPZ1pwDuy4cQSKuLmvrHTOxGCfAJ94hn3BkAS48548aeGA3f7mo7ew>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 06:32:49 -0500 (EST)
Date: Tue, 21 Jan 2025 12:32:48 +0100
From: Greg KH <greg@kroah.com>
To: Paul Kramme <kramme@digitalmanufaktur.com>
Cc: stable@vger.kernel.org, john.johansen@canonical.com
Subject: Re: NULL pointer dereference in apparmor's profile_transition v6.12
Message-ID: <2025012142-resupply-stimulate-c3de@gregkh>
References: <CAHcPAXTDE-X28xU2ngUASXQdgrQdOAffSh1qYbPgS98u3mSKOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHcPAXTDE-X28xU2ngUASXQdgrQdOAffSh1qYbPgS98u3mSKOA@mail.gmail.com>

On Tue, Jan 21, 2025 at 11:55:21AM +0100, Paul Kramme wrote:
> Hello,
> 
> with v6.12 we encountered a kernel BUG (panic on our systems) that is
> caused by a NULL pointer dereference inside the apparmor's
> profile_transition code. I've contacted John Johansen as the
> maintainer for the apparmor system, and he pointed me to 17d0d04f3c99
> as a fix for that issue. That commit has now landed in v6.13, would it
> be possible to backport this to v6.12? Commit is
> 
> 17d0d04f3c99 apparmor: allocate xmatch for nullpdb inside aa_alloc_null

Now queued up, thanks.

greg k-h

