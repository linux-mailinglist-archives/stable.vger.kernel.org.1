Return-Path: <stable+bounces-47867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D48D8291
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A861C2365C
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384F612C47D;
	Mon,  3 Jun 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KuP2ZdVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgDGsJv0"
X-Original-To: stable@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CE83CAE
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418509; cv=none; b=kNjxorVItapyCqxGhzFEHm1ZaR6+E7wYI0yG3mOaVToScQ8YWLzjTe/Xu7OD8yZS74uUFC8NC6ideJJZjDT1KRgU4L2lddDYYFuxNjFfdUl3jmAarq3cLW2WHHmz+l8aF/KEivtrFEkfn+lpCILpbhso4Cro74FRsTUYmt5YL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418509; c=relaxed/simple;
	bh=ck7ERi3jkNm3v33fNhOhfY9RK0n8D/wiGyeE2yeK7PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaGEXMSH7+LN7OB4rMSmTSRNrlsr/kt8H5VprjyOlf7cP/MyWduuw+vJC1+wRGkH3DhIcHBMNrEpsFznXkLOFMOqtiYvXbvuzrFq/m5nRuda6uQg5uq5S6NZYI6Kgu4c+KktLSeN7Xwok1NhVZluDLgly7j7xzXonqojGcC1Yr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KuP2ZdVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgDGsJv0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id B637F13800A3;
	Mon,  3 Jun 2024 08:41:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 Jun 2024 08:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717418505; x=1717504905; bh=NqrjlYP3fk
	fndhe9g7J1kmuwkwnFlflLXdi6k+Nyivc=; b=KuP2ZdVdIZ/ksf8viDUOp6Qjuq
	WAIbUUfSIvcj/w8ONROoHp89pZZn3/+hO4qdw50EGzIZEIJWfO0yTbxTDdl7VpJ2
	BV2XW0BO0Tbg2eymTQw5b90jcvljjkGnAn18sGOdYmPJC/te9OTrR9eUqvmxwCzG
	wdwpUaJuDFAdD3V296nGt+beYEmZnIEPzirgt5s3310v1Rxd2l6NoRSR2xlcCw8s
	bNohYbJtC7U+XAeKEgagQUzXRbd5qQmt1QdU0klyZTrEVupFSZuFNA+X6bJkeseO
	oLdstYZa6Wk8X6RP8bwViOtQaxpcMKzutxRaMDim3ke1T0IZlLNmk05kIqXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717418505; x=1717504905; bh=NqrjlYP3fkfndhe9g7J1kmuwkwnF
	lflLXdi6k+Nyivc=; b=VgDGsJv01RTFpy6CalRhUtRYVMb6ed7U4YsdXHySZo8u
	LeAgEiO1ZEWIWXYAO2FYx9ldRJJxrXz+0yxtN4wI71nejiCB5O/SYSNi2M76/Eod
	/O9qm7bUcy1ro0OWCeNkXG0eWGSyCPrt5FeBCbLi+QxGz/l5ik3kTa9X8BR32kLt
	21vUDpBGDq9ZdBiFo3Y3onX0DHjqyvxpfviGWyaoci9aqHbR55Mqzpi7Uolp7ZkI
	qubq6wp4zNWEAU7ICxUGoMZwWT/grHsSYjtJ7fqCcLT8DWRy7rLr5ZiXJAHs2ZSb
	2qAsLiJhjTPXyPqLIwqM5Q7qA2XfTZtOjv8gxOutmg==
X-ME-Sender: <xms:CbpdZo9hGTmEWsSb_R861N_6XNnXTEy3JQK2rJ87Pb5Xto_ttlJcUg>
    <xme:CbpdZgsgP1cWi-c0fzcyMMW82eatjEhxJKDAgNI3UePs-5bzMwVStT0gzqEsaI0sq
    MVWEsstsTU2lA>
X-ME-Received: <xmr:CbpdZuDeLugfAr7szWluLA-R0RPtSq5Uokpl7If4cHPGAjEkBlM0J8XsOUJxI_Fkr_JxZ7PcF1DnE7APJygwJ9y6DUeG1QBW7ED1jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:CbpdZoeRlfOzSKKrb-6rZ9y7HKFaY2FRNGsu2P2oM9zOR_A3LjH4mg>
    <xmx:CbpdZtMEJo7kZZHhNLaSAPgMyz9QQ1KORwGHgk944oz7dtrGh5hZmA>
    <xmx:CbpdZik88JuxN8oNHVAzq4dpkEW9sN9JtW3loVpHGJLM57m7NI0CSw>
    <xmx:CbpdZvsEwLFqWUWsgvdto-A4mJJMdvvlUCChO_wCflw6-VjyRAixWA>
    <xmx:CbpdZioYER_JjNmCLemwTxBE3rUk_iNBtAeyju5kId4MC-0dLhuufayG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 08:41:44 -0400 (EDT)
Date: Mon, 3 Jun 2024 14:41:54 +0200
From: Greg KH <greg@kroah.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org
Subject: Re: Patch "ALSA: timer: Set lower bound of start tick time" has been
 added to the 6.8-stable tree
Message-ID: <2024060318-harvest-skirmish-23c4@gregkh>
References: <20240530190237.17492-1-sashal@kernel.org>
 <87zfs714im.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfs714im.wl-tiwai@suse.de>

On Thu, May 30, 2024 at 09:30:41PM +0200, Takashi Iwai wrote:
> On Thu, 30 May 2024 21:02:36 +0200,
> Sasha Levin wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     ALSA: timer: Set lower bound of start tick time
> > 
> > to the 6.8-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      alsa-timer-set-lower-bound-of-start-tick-time.patch
> > and it can be found in the queue-6.8 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this one for 6.8 and older (you posted for 6.6 too).
> As already explained in another mail, this commit needs a prerequisite
> use of guard().
> 
> An alternative patch has been already submitted.  Take it instead:
>   https://lore.kernel.org/all/20240527062431.18709-1-tiwai@suse.de/

I've dropped this again and will take this patch when I catch up on the
my stable queue patches either tomorrow or Wednesday, thanks!

And sorry about the duplicate commit.

greg k-h

