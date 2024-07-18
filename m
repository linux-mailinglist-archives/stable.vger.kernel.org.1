Return-Path: <stable+bounces-60552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A4934DAE
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 15:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9B91F2410E
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9D4A15;
	Thu, 18 Jul 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="djHauMTi"
X-Original-To: stable@vger.kernel.org
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938E1DDEA;
	Thu, 18 Jul 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307772; cv=none; b=cDLBwI7i1KHiY+PZ1MxsoRy0+vxEHa4Rekni1Z4xghU5JclTH6UicIHddWVz7UTZIilzrRAvx/W7zYhIG4//JYMMhUKjo9MZyNVK6NJmodRZO3zA0dvmUJc/ZKxlPCyi6zNgKdfy3HJcR+r4BIFbl855/jBXnREsGqj9n4gna5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307772; c=relaxed/simple;
	bh=MZcf5HKg2xGnIwe/226e4jhMx8GAo1mzF03h+MQwqgk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfUCGlm5gBGhHm+jR94SomanV2eOm7xt2/WHsDrCogbiPdoWQHpRsc5YkGN930ulC2mgS24DZ1TRkNV2KBJ/8Nbqc5O4z8i5nCeEbwfnq+Dnq3xyB7Ro+r+nveEUm5XI53/iojnFR8sldqywYcJzodfaBSkthcKpUjdRVKqGPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=djHauMTi; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721307761; x=1721566961;
	bh=9Cq1kYOOh4haPvErrEi0ZorhnPKKtbTkm37WeZr/RwI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=djHauMTirdLnUoYqo5ZWLurL59I8tmXbJ+F3r1tgjiEBDOwyfr9opyrqJJyKbg7X2
	 BIRR76BLNnGgEgJRVnNU1U1ZKc8Qp8oNF5XApgoixL8AGyF/UuFX7oKIgiuK7gYuYi
	 sPk9yZsYLosuPEGC0qaGzF1OR4sACzMmcBULzKrc6XVv2nG8zG22dQmEm6segYBn5w
	 tgeZq74VZHeyKiWg444QVm1FckkgVGAqM/0BHAkgyWqvF8WHYiq6R6hNel89pNO3b8
	 6H0avnpfkGpzOhYX3HVazwj90uwjV9eRTkbYBqua8L9V23zaVSEQdeeBHKCUTLwhn+
	 1WbpD2ayW+mag==
Date: Thu, 18 Jul 2024 13:02:26 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
From: "edmund.raile" <edmund.raile@proton.me>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, linux-sound@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org, tiwai@suse.de
Subject: Re: [REGRESSION] ALSA: firewire-lib: snd_pcm_period_elapsed deadlock with Fireface 800
Message-ID: <stydzmsrtsdpoi7umdhxk66zsqdqaj7yyerro63eatecj5p44b@vad2xzpgdkag>
In-Reply-To: <20240717144649.GA317903@workstation.local>
References: <kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hzeo4simnl@jn3eo7pe642q> <20240717144649.GA317903@workstation.local>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 0f8570c0bec60156c33a86ccb863c54edc02e256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 24/07/17 04:46, schrieb Takashi Sakamoto:
> Hi,
>=20
> Thanks for the regression report, and I'm sorry for your inconvenience.
>=20
> As long as reading the call trace, the issue is indeed deadlock between
> the process and softIRQ (tasklet) contexts against the group lock for ALS=
A
> PCM substream and the tasklet for OHCI 1394 IT context.
>=20
> A. In the process context
>     * (lock A) Acquiring spin_lock by snd_pcm_stream_lock_irq() in
>                snd_pcm_status64()
>     * (lock B) Then attempt to enter tasklet
>=20
> B. In the softIRQ context
>     * (lock B) Enter tasklet
>     * (lock A) Attempt to acquire spin_lock by snd_pcm_stream_lock_irqsav=
e() in
>                snd_pcm_period_elapsed()
>=20
> It is the same issue as you reported in test branch for bh workqueue[1].
>=20
> I think the users rarely face the issue when working with either PipeWire
> or PulseAudio, since these processes run with no period wakeup mode of
> runtime for PCM substream (thus with less hardIRQ).
>=20
> Anyway, it is one of solutions to revert both a commit b5b519965c4c ("ALS=
A:
> firewire-lib: obsolete workqueue for period update") and a commit
> 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event in
> process context"). The returned workqueue is responsible for lock A, thus=
:
>=20
> A. In the process context
>     * (lock A) Acquiring spin_lock by snd_pcm_stream_lock_irq() in
>                snd_pcm_status64()
>     * (lock B) Then attempt to enter tasklet
>=20
> B. In the softIRQ context
>     * (lock B) Enter tasklet
>     * schedule workqueue
>=20
> C. another process context (workqueue)
>     * (lock A) Attempt to acquire spin_lock by snd_pcm_stream_lock_irqsav=
e()
>                in snd_pcm_period_elapsed()
>=20
> The deadlock would not occur.
>=20
> [1] https://github.com/allenpais/for-6.9-bh-conversions/issues/1
>=20
>=20
> Regards
>=20
> Takashi Sakamoto

Thank you for taking the issue seriously!
Yes, indeed it was the same issue reported to the test branch for
bh workqueue!

It was "fun" living with this "hilarious" bug for years and not knowing
where it comes from.
Having it solved is almost like christmas to me, I am very glad I was
able to.

Your explaination of what was happening here also helped me understand
the issue better, so thank you.

Of course there will be better solutions in the future but for now,
the kernel freeze is banished, I hope [2].

Trying to implement my "fix" on the latest kernel (I was only testing
with 6.9.9) revealed that 6.10.0 introduced another regression [3],
resulting in heavy digital distortion.
I'd like to ask you to look into it.
Despite the horrible distortion, I'm happy to report that the patch [2]
also works on the latest kernel!

Thank you for your hard work on the firewire sound drivers!

[2] https://lore.kernel.org/linux-sound/20240718115637.12816-1-edmund.raile=
@proton.me/T/#u
[3] https://lore.kernel.org/linux-sound/n4jdkizinqfoztqn2cwv7uqqqnvkyu2xk32=
qebazqznh74b3d3@r23skt4k7mqe/T/#u


