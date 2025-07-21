Return-Path: <stable+bounces-163622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52DB0CA6E
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DA4E781F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E72E1738;
	Mon, 21 Jul 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJebDYSL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F632DCF73;
	Mon, 21 Jul 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122520; cv=none; b=VyLQU7FpzJ+CtepkAPphk3OqbW45RN6rvyrH47T7Mp3ujeRaIQ/H/xfIewUvzLNq/UWFAxi1r3fgK/dwUIpgdqxSkDPmQDsJHGvJaZYTpuTbcEqvLLyEjPuZkAB0NEWxx2739Vt65nTPnWWNMfD8rErQHUp3HKgZEEagp9bnJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122520; c=relaxed/simple;
	bh=I7NH1FeIwcHLYwxJFBgDnEAZ97hIN1JuI9B4dn/AH2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jObeIo3kFpp7soqxQn5NWTqIeSKqB4fvTdwr2QgUyMtrVi7W2PUMvaV/XYxBnBt3cPkSklQKIHmmPwiB6vu6JLnShM1lT3ijo60/6Qx0REAV3MvWdJm81CzlajhF352tnCXweqFoaLyZ3oGvMxSELp/Sc3jgsnbZJ/B2dBY0W2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJebDYSL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so2996287f8f.0;
        Mon, 21 Jul 2025 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753122517; x=1753727317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuY4YQnKN/QwyJv0uRB4uQ52TvVUDyE6G0eusiV92uo=;
        b=HJebDYSL3wOEO0eSyICLjKRnhOfuQp/qmgJarbSQ4BMYbFn94RvmbV1Whd3vm5sXz2
         g639fYgmUKLJwMgY23p1duxTbzUutBAlzBcgpKjxdbW8scJXtyAtCKwtO1dL+TRo10/+
         VXz8HnNDSs0z9HcMjnp54V9mFjvl/L4scyvGGFOhjzjHz3JVsRrf/WXwz5j9S+lawwOF
         Na1+UV/0MO2t3cZH1hOAyvP4/9iD/X7vXNa5+f3ooyIRDuipEWDb9PTO+hGfAWKw7Fi2
         DciE5KppFwVlpb9w9TEJDFDO0sawAqHSbqB50xJnesRNvVkR1RL+DgXXJ+KHTzmnra22
         /zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122517; x=1753727317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuY4YQnKN/QwyJv0uRB4uQ52TvVUDyE6G0eusiV92uo=;
        b=qisSjv9+h+smUmQIFPl6ezCLjau5lshAWNGyvyg1fkswsG+CuNQ06iICUX5ROeiZwe
         WnsTU9AQmjNPS1a44eBxLDmI8D+ukTXle+lkZQOvUl84UvCLOqpvPYiDeR1+3eumJUG2
         YQW2SFMpf1zgCncOnfNyO59gF2GNGeGT0kAupKB0IVfiUgISDrp8uqTwXXict0EecG1h
         1FNlfv7MuDKNE6UK5VEJk3K+RqyaJcTcVHnij9Yh7LgiSCrMH51gZQns0cfRlfeGClP5
         YrE95VT14HcNvqkRUlnEP9PnRD2TUKp4NSAP8FAtmFaYtIeBjTCB+L3ljQxpNd10GCb0
         8yTw==
X-Forwarded-Encrypted: i=1; AJvYcCWZJc4K2L++J+sUoFAr/eDjfy/warOiwA27e5RM/6QJzNyi3ayQ8jplEHgvjE2/D3alcb8RIvjA@vger.kernel.org, AJvYcCXWg63wKwHdqO/l8k5KZK/zMoSnJdic2T3D22UeY4D3JaNsdD8BLpe4CHc+wNFf7t5K1Uu6olQV0VLdbOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rB0SVO9qaBEy9UWcf1QH7jdEGWoc2hq68cjsffX7ylPq9p16
	nNt8WN/OCQPKIJHcgVL/qoN1DzERP0IoVY06DQHbYutJDjLWguEiz5bc
X-Gm-Gg: ASbGncs3KdZs7ew6cWX/B/Fb1Zpwy/41KtP46PWEstODLMJmEjD5117b/7wa6VP9tHF
	2Oe43yeUB0jBhhEQ7xgcvzdPmnTU7w3LEScxv7XOJqIed6zTAw++dzqf99HgZwRX1jDysxjOsBT
	3FQmcRtr4hyufgCXsURo26yd9FKDKeMyiK6EWz9cb5XpsxKFEUP1Ytp2t4sCsCxEa6odscNmsNO
	Weled4J/wFuuGzxcTHkkRARGDbkrCgNhmg6qaPgpKInELarHmLcbaTFnekcCLehuhmcGQf+ughb
	+SPbomWsn4k71L/bPN9tpPNqiDQMYPrRi53C/cYvX8zZVSRJZSna4POL9ZPC+sSd7yQ3peJF2cj
	PRtHOt8lTr+H+ErFIGS5W/8iJ3qoIou4Lp8PDVWwb6jpkttfJp67bUUSyX8jw
X-Google-Smtp-Source: AGHT+IFHEOzWpT270Spaub4rqdE0tysNp0+Y6Ux8yPMMc0/ZDCRSDQtjBrNPLALYUbEHt2aRaHvHhQ==
X-Received: by 2002:a05:6000:2210:b0:3b7:5cca:1bb with SMTP id ffacd0b85a97d-3b7634856camr537310f8f.1.1753122516606;
        Mon, 21 Jul 2025 11:28:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c313sm172003665e9.28.2025.07.21.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:28:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 19:28:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, sashal@kernel.org,
 linux-kernel@vger.kernel.org, frederic@kernel.org, david@redhat.com,
 viro@zeniv.linux.org.uk, paulmck@kernel.org, stable@vger.kernel.org, Tejun
 Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Luis R .
 Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2] kernel/fork: Increase minimum number of allowed
 threads
Message-ID: <20250721192830.6f8f57d9@pumpkin>
In-Reply-To: <1f81e064-1b19-475d-b48c-39f56381058c@hauke-m.de>
References: <20250711230829.214773-1-hauke@hauke-m.de>
	<48e6e92d-6b6a-4850-9396-f3afa327ca3a@kernel.org>
	<20250717223432.2a74e870@pumpkin>
	<576d1040-4238-4bf0-aa61-e1261a38d780@hauke-m.de>
	<1f81e064-1b19-475d-b48c-39f56381058c@hauke-m.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jul 2025 17:28:20 +0200
Hauke Mehrtens <hauke@hauke-m.de> wrote:

> Hi,
>=20
> I am not exactly sure how I should limit the number of parallel user=20
> mode helper calls.
> The user mode helper is calling wait_for_initramfs() so it could be that=
=20
> some calls are getting queued at the early bootup. This is probably the=20
> problem I am hitting.
>=20
> I do not want to block the device creation till the user mode helper=20
> finished. This could also result in a deadlock and would probably slow=20
> down bootup.
>=20
> When I limit the number of user mode helper calls to 1 and let the=20
> others wait in a system queue, I might block other unrelated tasks in=20
> the system queue.
>=20
> I would create an own queue and let the async user mode helper wait in=20
> this queue to only execute one at a time. When one of them needs a long=20
> time in user space it would block the others. This workqueue would also=20
> be active all the time. After the bootup it would probably not do much=20
> work any more.
>=20
> I do not like any of these solutions. Do you have better ideas?

Could you put the requests onto a private queue but use a system work queue
function the clear the queue - only starting the function if there isn't
a copy running?

	David

>=20
> Hauke
>=20
> On 7/18/25 00:52, Hauke Mehrtens wrote:
> > On 7/17/25 23:34, David Laight wrote: =20
> >> On Thu, 17 Jul 2025 07:26:59 +0200
> >> Jiri Slaby <jirislaby@kernel.org> wrote:
> >> =20
> >>> Cc wqueue & umode helper folks
> >>>
> >>> On 12. 07. 25, 1:08, Hauke Mehrtens wrote: =20
> >>>> A modern Linux system creates much more than 20 threads at bootup.
> >>>> When I booted up OpenWrt in qemu the system sometimes failed to boot=
 up
> >>>> when it wanted to create the 419th thread. The VM had 128MB RAM and =
the
> >>>> calculation in set_max_threads() calculated that max_threads should =
be
> >>>> set to 419. When the system booted up it tried to notify the user sp=
ace
> >>>> about every device it created because CONFIG_UEVENT_HELPER was set a=
nd
> >>>> used. I counted 1299 calls to call_usermodehelper_setup(), all of
> >>>> them try to create a new thread and call the userspace hotplug=20
> >>>> script in
> >>>> it.
> >>>>
> >>>> This fixes bootup of Linux on systems with low memory.
> >>>>
> >>>> I saw the problem with qemu 10.0.2 using these commands:
> >>>> qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> >>>> ---
> >>>> =C2=A0=C2=A0 kernel/fork.c | 2 +-
> >>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/fork.c b/kernel/fork.c
> >>>> index 7966c9a1c163..388299525f3c 100644
> >>>> --- a/kernel/fork.c
> >>>> +++ b/kernel/fork.c
> >>>> @@ -115,7 +115,7 @@
> >>>> =C2=A0=C2=A0 /*
> >>>> =C2=A0=C2=A0=C2=A0 * Minimum number of threads to boot the kernel
> >>>> =C2=A0=C2=A0=C2=A0 */
> >>>> -#define MIN_THREADS 20
> >>>> +#define MIN_THREADS 600 =20
> >>>
> >>> As David noted, this is not the proper fix. It appears that usermode
> >>> helper should use limited thread pool. I.e. instead of
> >>> system_unbound_wq, alloc_workqueue("", WQ_UNBOUND, max_active) with
> >>> max_active set to max_threads divided by some arbitrary constant (3?=
=20
> >>> 4?)? =20
> >>
> >> Or maybe just 1 ?
> >> I'd guess all the threads either block in the same place or just block
> >> each other?? =20
> >=20
> > I will reduce the number of threads. Maybe to max 5 or maybe just one.
> >=20
> > I think we should still increase the minimum number of threads, but=20
> > something like 60 to 100 should be fine. It is calculated based RAM siz=
e=20
> > 128MB RAM resulted already in 419 max threads.
> >=20
> > Hauke =20
>=20


