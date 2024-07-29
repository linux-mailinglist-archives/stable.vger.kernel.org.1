Return-Path: <stable+bounces-62451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12993F25D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710771C219D5
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBF13DBA7;
	Mon, 29 Jul 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mc/1nV4m"
X-Original-To: stable@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88B13A25F;
	Mon, 29 Jul 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248175; cv=none; b=QAEJ4c0PZeJi1GDYk44zEkr7tkEj/DgYK0SiWQg2sJGy6rdNK1WuycwQvp6wic+rl2nNHav9xK2kucssMGHvyPfJVzJyiyPtcDWfni7VpyJ4Ayn9E115oefhvG+9WW8kdi954tJtUW9Rya5WO7lJ4QCoRFYitT27i82VGpVu2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248175; c=relaxed/simple;
	bh=S2kDna0y+5oSBmGdHqrrYsJkaPHhKDJXjStLwhOwkz4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ALk1udYTzyoZKVxRsmwvQGLvgq7ajXEtZueR33q9opum+JnefJUP16k5F5JMmgiG78q5YIy8hsOToi46iqoP52QOxJfuU+pk4auUdnxp66+UU3eD4wCYvpdVKBptmhRgrc2KYUz98FTlchPIpJgjKejxB1W71bD8W+YUZsDcA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mc/1nV4m; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722248170; x=1722507370;
	bh=S2kDna0y+5oSBmGdHqrrYsJkaPHhKDJXjStLwhOwkz4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mc/1nV4m8TMMGJeIUMii9ZkH6oZomOab96hwvnxWu2gNI3S1ZVUnJ0v7Zed2yjXbn
	 As+t2qSXVrAbemPFvrTNio927NzUZiGO68n03CRMo48JkQq0GBnNVFHQrG/9WEMvhR
	 8ITLplTApB0EwO2nJhfcW0JEAxWVLXyFfhVxjTwyeOPq/4aUrQ/y5XDjvfzp7GLTgv
	 i4JPcs1zShaNrnPF1B45jSotEIB+vq3FL+DJanNBp4XYD1KA9SweE50fAWSQ1r19TJ
	 xllms2BUBPXvfcoUZnnIdmH6ReKgnFf4032J509CYFJSqc2NiqqE4UIU48Ow4OWcrS
	 W2Smoi8ufMUvA==
Date: Mon, 29 Jul 2024 10:16:04 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
From: "edmund.raile" <edmund.raile@proton.me>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, tiwai@suse.com, clemens@ladisch.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ALSA: firewire-lib: restore process context workqueue to prevent deadlock
Message-ID: <ora25phw5xyiog2z5xmlkrwvgffpwjq27algi6hqjs7s76b2qg@wbgokl2mblbq>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: a09e72281001a8ca1419aa95857d79dea51fda67
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Thank you for your sending the revised patches, it looks better than the
> previous one. However, I have an additional request.
Allright, patch v3 it is.

> [1] https://git-scm.com/docs/git-revert
Should have known git has something like that, how handy!

> $ git revert -s b5b519965c4c
Yes, 5b5 can be removed via revert, but what is the difference in
effect? Just time saving?
> $ git revert -s 7ba5ca32fe6e
This one I'd like to ask you about:
The original inline comment in amdtp-stream.c
amdtp_domain_stream_pcm_pointer()
```
// This function is called in software IRQ context of
// period_work or process context.
//
// When the software IRQ context was scheduled by software IRQ
// context of IT contexts, queued packets were already handled.
// Therefore, no need to flush the queue in buffer furthermore.
//
// When the process context reach here, some packets will be
// already queued in the buffer. These packets should be handled
// immediately to keep better granularity of PCM pointer.
//
// Later, the process context will sometimes schedules software
// IRQ context of the period_work. Then, no need to flush the
// queue by the same reason as described in the above
```
(let's call the above v1) was replaced with
```
// In software IRQ context, the call causes dead-lock to disable the taskle=
t
// synchronously.
```
on occasion of 7ba5ca32fe6e (let's call this v2).

I sought to replace it with
```
// use wq to prevent deadlock between process context spin_lock
// of snd_pcm_stream_lock_irq() in snd_pcm_status64() and
// softIRQ context spin_lock of snd_pcm_stream_lock_irqsave()
// in snd_pcm_period_elapsed()
```
to prevent this issue from occurring again (let's call this v3).

Should I include v1, v3 or a combination of v1 and v3 in my next patch?

> Just for safe, it is preferable to execute 'scripts/checkpatch.pl' in
> kernel tree to check the patchset generated by send-email subcommand[3].
Absolutely should have done so, sorry.

Thank you for your patience and guidance,
Edmund Raile.


