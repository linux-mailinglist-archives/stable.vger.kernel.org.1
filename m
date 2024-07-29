Return-Path: <stable+bounces-62560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C293F6BD
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820C928266F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560CE1487E1;
	Mon, 29 Jul 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XMV3eulV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZEGU5YX"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD308C06;
	Mon, 29 Jul 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260004; cv=none; b=Uiq+6wszG/zGi7+MKRt6ps9uuXH1Qu4eJcI8g7UFYL023m8DumWxbrkHVTb2lKjKtYfg2pYteATsaVEUAXCAatyTn6uwm1XspRVTMhohwvVoaQhzwii8941TVRi1Er+2F1sPs5kIhU0tyuFac9VFcyAG3yNyB5CdFbwNmEP7bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260004; c=relaxed/simple;
	bh=wKJN1owZ+Xw9GBWfIxQQnbL/vvcRCbzNJTXcvYPQVjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/aKXSg4b8J7wSsKcUBEAq6eLMoXPSuWLkiUxdqpYoopPcVTAr7ufBknkDHAt+175GHknIwv0FwQSzy3w7ZWlHv6w2dwyLCSQAvqr65Hcd7JxXvyB02GeJuzrVG0DfaJOmFqXl1A28aC8u4/S5OURrW0r5q/NtLal6AiPvmuk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XMV3eulV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZEGU5YX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 51962114011C;
	Mon, 29 Jul 2024 09:33:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 09:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722260000; x=
	1722346400; bh=1+7cREE5qD3aSshiacIOspAADyLJzFXs1PLzuYNurzM=; b=X
	MV3eulVSGUhfCfUKTrIf2KFxN4rOoC+v+QEFpdrtkfXf67nepSQrlUgjf7R51fRY
	qRBT8ywxoLUesu0eDWhaAyrHW8yLAGOIWKk0v4QOsLTyS4jAY63REqoBtyT0iJsy
	XnL007ygTcLPsAopg+rapuaQgtZImm2tx6udSNoFXVung+tnOj63hycpOs8HtWxO
	Yr1kczAj1InG8j9mMjAwp+9DXZsWAmn7FoEMsxcBErtbMg9WDRa2kjHYadl1HkhX
	coNDO2N0iDGz2oOIrH7vzfR5dW5D1K8M2QjHkYlFFYrZrw9rTsb+CGJv00X99LFh
	z1uWNjXsAygshkiY+ctZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722260000; x=1722346400; bh=1+7cREE5qD3aSshiacIOspAADyLJ
	zFXs1PLzuYNurzM=; b=SZEGU5YXP44yG7ap+3e/dJsHH3qMhcgKipRlBIQpfEhw
	u8h39dwkqZ0czFETqf3jF0Naxkes1qwC2NqcLQpf860GPOg1H8RglS78wK29AVd2
	Kyv8ZCb8NybikoCtjJKR2sUwKO13b3iEhYjaNlRq8UdpED81OmAkhAvsmWpJ4dxc
	UxhZCAllvU5OAfrJ8EFdnKsGwZ5kmVR8JIk0ilx5zOo/qfM4gt07ujLHXfbGDOeh
	I7tH6oGxXgfud2ahO0kx+S7nbqI90GOexbCePZ//NQdcNc4Gw2gEQem9ovnA8Fxx
	Z1V+5mOteLQfI/eSZTaIrzojcUg7+lM4MCEGQ5TLyw==
X-ME-Sender: <xms:IJqnZl5EnwHg-9RTJidoI2Iy2q1pgOtI6ieHJqrV238ihKPy11cEFA>
    <xme:IJqnZi6s2ppTb4G6poX0JpxlxHYaQIy5S2p5Ut5BPwzp2WXt7WDJ9mYPThacv01hR
    QLpKML3LEpjqsepjyY>
X-ME-Received: <xmr:IJqnZsf7lPsy5Am4IcqF9EckkL5PplkzJUgVo_tB727x4fOs1Hd6J5RNHYDELzuV5Ou00srgy4gpbivGZx80bm22KMyTdSAQBEKZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:IJqnZuJp--rOkoprGSVLVZCxsQFpanPph1pBFES0fdMJK4hmDbKi_A>
    <xmx:IJqnZpLlyMJMHf2fCkSuUD9acirkIre1UpGxgpOyhtxlZLv8R_jrhg>
    <xmx:IJqnZnyHSS3-RyoQiZJrwxuhAVYw-r_g8MJZSZkW3c-aOSEvpRyf1A>
    <xmx:IJqnZlKp9TgFIbM57PJN4N0BUFLmIfolD7yHOY2PbQ-W1QJobwBx2A>
    <xmx:IJqnZuqdHz4UnR6g3Ut7hz_h9bfgvgJTrfTkaSZLxHKc6DPd9A38P9HH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:33:16 -0400 (EDT)
Date: Mon, 29 Jul 2024 22:33:12 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "edmund.raile" <edmund.raile@proton.me>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, tiwai@suse.com,
	clemens@ladisch.de, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ALSA: firewire-lib: restore process context
 workqueue to prevent deadlock
Message-ID: <20240729133312.GA122247@workstation.local>
Mail-Followup-To: "edmund.raile" <edmund.raile@proton.me>,
	linux-sound@vger.kernel.org, stable@vger.kernel.org, tiwai@suse.com,
	clemens@ladisch.de, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
References: <ora25phw5xyiog2z5xmlkrwvgffpwjq27algi6hqjs7s76b2qg@wbgokl2mblbq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ora25phw5xyiog2z5xmlkrwvgffpwjq27algi6hqjs7s76b2qg@wbgokl2mblbq>

On Mon, Jul 29, 2024 at 10:16:04AM +0000, edmund.raile wrote:
> > $ git revert -s b5b519965c4c
> Yes, 5b5 can be removed via revert, but what is the difference in
> effect? Just time saving?

The title of commit generated by git-revert could be helpful when reading
history of changes later. The code change is itself important, while the
history of changes often assists developers to work between several
trees.

> > $ git revert -s 7ba5ca32fe6e
> This one I'd like to ask you about:
> The original inline comment in amdtp-stream.c
> amdtp_domain_stream_pcm_pointer()
> ```
> // This function is called in software IRQ context of
> // period_work or process context.
> //
> // When the software IRQ context was scheduled by software IRQ
> // context of IT contexts, queued packets were already handled.
> // Therefore, no need to flush the queue in buffer furthermore.
> //
> // When the process context reach here, some packets will be
> // already queued in the buffer. These packets should be handled
> // immediately to keep better granularity of PCM pointer.
> //
> // Later, the process context will sometimes schedules software
> // IRQ context of the period_work. Then, no need to flush the
> // queue by the same reason as described in the above
> ```
> (let's call the above v1) was replaced with
> ```
> // In software IRQ context, the call causes dead-lock to disable the tasklet
> // synchronously.
> ```
> on occasion of 7ba5ca32fe6e (let's call this v2).
> 
> I sought to replace it with
> ```
> // use wq to prevent deadlock between process context spin_lock
> // of snd_pcm_stream_lock_irq() in snd_pcm_status64() and
> // softIRQ context spin_lock of snd_pcm_stream_lock_irqsave()
> // in snd_pcm_period_elapsed()
> ```
> to prevent this issue from occurring again (let's call this v3).
> 
> Should I include v1, v3 or a combination of v1 and v3 in my next patch?

I think we pay enough attention to regenerate the deadlock, thus v3 is a
good choice. But the cause of deadlock in the above description is a bit
wrong. It is typical AB/BA deadlock, like:

Thread 0:
1. Acquire stream lock by calling 'snd_pcm_stream_lock_irq()' or so
2. Wait until running tasklet finishes by calling 'tasklet_disable_in_atomic()'
   (actually at tasklet_unlock_spin_wait())

Thread 1:
1. Launch tasklet
2. Wait until the stream lock released

The softIRQ context does not related to any type of lock in sound
subsystem essentially.


Thanks

Takashi Sakamoto

