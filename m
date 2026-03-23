Return-Path: <stable+bounces-229979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DJHIGB4wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:29:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A82F9F11
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2643E303F425
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AF3C5541;
	Mon, 23 Mar 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lfYT0yiZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFB3C4571
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285639; cv=none; b=AVqGbR2evUQyts9xRWPGmK3H64r7kdwsYaJVBKM3hwYcZWAMfgl3ssGqJBdzsW5Y7aWF0S3JjAGUoTcZzw+tM6NpCKuJwDW4lbvoxG8c2HD+QjyW1jcdOnBQc+c2O/UDSocbLac+ft/uyi7tqdnXw1WQa4mBFn3OJ7LEWJ5myH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285639; c=relaxed/simple;
	bh=NXHdFcMsCZ9zeiG0neWEIh44GOUy5j6PRRxlB62eKCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncBgkbD8XRg1thiTASzN2XZRl04gj1NSGLc4Egorw1h7Bo8TBtdrQPEs/jmdHm9qz46RcvmQ5K0n8Jbb/Jax34/htwFQAD6v/Ap0pmM0EEO8CdUNKTZHefhYOJ+rAd6UGgPMJW2JLSi0Rv2bcSQlMjOivTuA+9n0j7pT/xYner4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lfYT0yiZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9841aecf72so344449766b.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774285635; x=1774890435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wP0O2YEaaZh2jzplFE2HN0DYzURZaOx4Bx6nnpcvKg=;
        b=lfYT0yiZMaGP6lZFuVIdLCHWa88SjQLZncYuBn1iZw48oTxtEXXSGHh5Awg23AEzhE
         Uqua4kO2u4C0JotNes9UvWEaF0wpofYZVY3yMsKxskaRFPK/Cc8yQzO2OHRXKM5nKb2E
         i3SKZG3KKiL2uYe9BF+dbQiPikcPdFrWQaYVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285635; x=1774890435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wP0O2YEaaZh2jzplFE2HN0DYzURZaOx4Bx6nnpcvKg=;
        b=ENLz/6V+Uuu+AtEfCavUbzK8gZbWOT7zN8q7xX0Uk01uY6OwA/DI1fN0rq5UCbXZ31
         HvXTkcwkBzhodl5qcueX4nri7Mq0gMewXv5gB/Ix77TIUpmoyRuKOTebo9Xi+QmuvlYg
         IgWZ+TX8GM2DnAyf1Y9T8tM8GWmA+UzR9v9EJ1nah2M39uVkaIWWrsSyQ/LDEfz8yok0
         uZq7lfImvxa6xAdusA7IIReQ03g2X3ts23BDeq2MBqLdhlgScHqPIMZOV5c3HiUEGAHF
         FxBIurad6CX1xr3X1XcyrooJOQZFhhwspW7BvHs45iS4jHgU2vrcYjqgwird9rX6ehBK
         sR7A==
X-Forwarded-Encrypted: i=1; AJvYcCXo6JUMbn7G+VaJ9on42TLkWH/YEN0iDfYov6ahjHxb7875WSJbZfleqX7DYXv9B38FWzdoxdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfTuLrMQAU2EnhAqJXMNUYjtQPWU3J1W/y5hryIZbJ41rK7sn
	hKLhphtRT0DkP38/D+YDMwKDrIww08SLPZMCGQekMMdjXZKfrdVBN2uDaj6hRlsVJKcG+MkNyhG
	ugBrbFd0I
X-Gm-Gg: ATEYQzy0l8dE7ff/Jz6w+i7ttx4zaD6FMAwkM1H/4C/JhaJsaCPo0NJ22FhiXIUnTmM
	ajPMJSQWnxkTnDkuF5vbgZTiNznZZQweHJNuoA6iTHRaC+GmeGmGASWekciDx49Z76Ioc0FiDY3
	JERByiqZEYg889GN1hgHiEFdEAJlDeL9fisD/vM2+ihzB6ZRAUy7DFaxVMXG45FMVOIdc37Nklc
	yl+zSeLhnQVitzRCSHT3fJGBNfzqFTYrD8Nsqpkf3EFpO9i9Krj9p7O52LW2DSkYgSqWv6dxhk4
	r+hAOrgidPuLH5+dqmJBjIfJ2GqRCRHMsi3xH80i5Ghhp9LACf1JHZgap7vmq6IhVpWzlpf14pZ
	VA8nkh/6NImacgIuzAsAfLftCiURcqdqxj2hAjKjsz05GL1MQrKparGEa1qB/6mXViHr3yCAdkD
	GuVLnUo84pMFOisOiFcTrkC9dVkKAtvMQNpgFzupl0bXxTw29X60NHPvniHWGIuQ==
X-Received: by 2002:a17:907:d58e:b0:b97:aba7:1969 with SMTP id a640c23a62f3a-b982f3cbc95mr885542266b.45.1774285635274;
        Mon, 23 Mar 2026 10:07:15 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983e4e9b65sm417703366b.31.2026.03.23.10.07.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:07:13 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so28871045e9.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:07:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBlz4zdAz+p03gj215pEQ2slK4orjZa+I03wd6LCi3ydBCWc+XkCqkGnXaU3KVoWn0eCL+SJ0=@vger.kernel.org
X-Received: by 2002:a05:600c:a4a:b0:485:5c6e:8a38 with SMTP id
 5b1f17b1804b1-486fee0fbabmr171857425e9.17.1774285632783; Mon, 23 Mar 2026
 10:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh> <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh> <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
In-Reply-To: <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Mar 2026 10:07:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
X-Gm-Features: AQROBzD1wQwwLkQqFLAaWiaEUc38lElDQKStGZ6mOr6tab1Sq5qFqqIwOw8EX6M
Message-ID: <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229979-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:dkim,harvard.edu:email]
X-Rspamd-Queue-Id: 1E9A82F9F11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sat, Mar 21, 2026 at 8:54=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> > > > I'd also note that the only actual symptom we're seeing is with
> > > > fw_devlink misbehaving (because dev->fwnode->dev wasn't set early
> > > > enough). fw_devlink is a "new" (ish) feature, is officially optiona=
l,
> > > > and isn't used on all hardware.
> > >
> > > That's true too, can we set that earlier?
> >
> > Yes, I can post a patch that _just_ moves the set of dev->fwnode->dev
> > earlier, and that will probably fix my symptoms (I'll need to test).
> > This patch already moves it a bit earlier, but if we don't break the
> > linking out as a separate step it would need to move even higher up in
> > the function.
> >
> > Originally, I was going to just propose that, but then I realized that
> > some of the other code in device_add() probably also ought to run
> > before we let the driver probe, and hence I ended up with this patch.
>
> This sounds like a more generic problem.  A bunch of things happen after
> bus_add_device() that should be completed before probing can start; the
> firmware node stuff is just one of them.
>
> Splitting bus_add_device() in two sounds reasonable, although I would
> rename the old routine to bus_link_device, since all it does it add some
> groups and symlinks.  The new routine can be called bus_add_device().

LOL, so basically you want them named exactly opposite I did? That's
OK with me, though maybe:

bus_prep_device()
bus_add_device()


> The real question is whether any of the other stuff that happens before
> bus_probe_device() needs to come after the device is added to the bus's
> list.  The bus_notify() and kobject_uevent() calls are good examples; I
> don't know what their requirements are.  Should they be moved down,
> between the new bus_add_device() and bus_probe_device()?

Yes, this is my question too. The question is, what's worse:

1. Potentially the device getting probed before the calls to
"bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)" and
"kobject_uevent(&dev->kobj, KOBJ_ADD)"

2. Calling "bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)" and
"kobject_uevent(&dev->kobj, KOBJ_ADD)" without first adding to the
subsystem's list of devices.

As it is, my patch says #2 is worse and thus allows for #1. ...but I
don't actually know the answer. The main reason I chose to allow for
#1 is that it makes the behavior less different than it was before my
patch, but that doesn't mean it's correct.

Reading  through a handful of "BUS_NOTIFY_ADD_DEVICE" calls, my guess
is that they expect to be called before probe... That would imply that
my patch made the wrong choice...


I think another option here might be to just add a new bitfield flag
to "struct device", like "ready_to_probe". Right before the call to
bus_probe_device(dev), we could do something like:

device_lock(dev);
dev->ready_to_probe =3D true;
device_unlcok(dev);

Then in __driver_attach() I can have:

device_lock(dev);
ready_to_probe =3D dev->ready_to_probe;
device_unlock(dev);
if (!ready_to_probe)
  return 0;

If I do that, I don't think I'll even need to re-order anything, and I
think it's all safe. Basically, it just the device hidden from the
__driver_attach() logic until probe is ready.

What do you think?

-Doug

