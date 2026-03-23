Return-Path: <stable+bounces-230023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK3CMQa+wWlSWAQAu9opvQ
	(envelope-from <stable+bounces-230023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:26:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347852FE3A0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C0D3067775
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46502382F2F;
	Mon, 23 Mar 2026 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWkmtfIZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DF382F05
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304712; cv=none; b=aHvg4JMtInfMQVHKoBIgJGTrtJxJR7xUvCC+WhREEHUMyLI4VZXKqmKuwlejcNIFx2F6BkZ04tVFpkEt6Tufjcu4mL2SBXxOjnPdYu56ocozLKf9ws+gAZW/1t56EarsMqsEpAEwRVoIcahJOu67Rm3j2xo+G63uRk+cZ/gvL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304712; c=relaxed/simple;
	bh=bFLBqMlrMNlVvEDThGQzA+HP25jQiPecsDKqaKht8zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd5W03jkSmrnSv4AoAj3RyVkO0hc1ugHesw8OUAVfpCw0TRZ/yT4aS9zQtEuBorAHDJivuh0NaiHMXbvlsJ1gvSJdkkMbs3BMWFNj7fwiCuso/rvzDS50eot0MiZCnh0vVmoxSQhngytSQA1Mx4+/X+nVImjGQrNoP7enTRVkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nWkmtfIZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso5987693a12.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774304706; x=1774909506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXpAwZ8YruU3sawAVevICPn8RHXhLzDURBOvuvjye5I=;
        b=nWkmtfIZd2ROMJblb6n8oOAL57zge+GA0p3b3tcunaqSmBozDVMVg0lcnVthsMZctG
         iEtMmPvgo0N0rx3ai2Bhu8rR0yMji0X/gpPANnF/spRBkNZQvaZBoCGP7f2a4Ih0vxYm
         Y+/XirVGJoBW6g6+5MjeU/PEuwPEnEZlRpbd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304706; x=1774909506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXpAwZ8YruU3sawAVevICPn8RHXhLzDURBOvuvjye5I=;
        b=XOo5QflrPp0aGLBwaay7SQLJD3/IJndGLx696WYiHl29hp+4zmOOj0KqZC2ohJvPCR
         h6ZAKSUUFOKGf1MOVYIj23exZpsk3PZDFMm+zg/YlwV7pK4l/NR1fTh+c4Ua8zy97kQ+
         mihLGAvpkOnDAHJ6lNAK9gARNdOCmr67RtKVxE2ADukZqjsOys3dX1MZxRcF2SSPg3nw
         MFxtBi/YV2dmhSDL8tOzl0XxmyLUXS6lCJH9MQ3om1B334ur3S/R7RjxE1/XYM29UOEY
         LoVTtd4WpSjJctMzWDBNoy6CA8IzOjugrgKW/og2PaZlAKZ69eBvcPKQktxh7qsGBDqI
         rUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVljIUVpZrZfYumrphrUVaJ48cLZ0xNHNrqHwLRhhyRwiix80rRun8h+UmSs8pNFGyzDF4mdn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBf9yDgeb6DJof+EDa+f52RI5omYMKVruJbAPbebUkc6JST85
	YfvU8XZGJfUlC6ct4NfEcAceNjXNVv0qBy3w1yEro1u6d6a+gcq9Vazu1UnIo0MnZx7nKpNGCul
	vjklybqbe
X-Gm-Gg: ATEYQzxKXh3E1PqjESbuZMZiGx8udeR0bOfsJ/oQ6NjOjOyGDn/XukP8qdqSdxVejDk
	JrYz9OPReVrDSgccyfF3qtao6f8QN5JtGv9CqLHkmmQcXFrpT/rfRrxIZPZvEkHSm1VF/RBfZTc
	1CDtirv7ogOMY2RhnwZNLCtUj28xd5AoPTtzuFjPXWazHSRHdS+c6orW1Rksih3z++wTko/8b5R
	iAbW7/Y39rI0J/WwzKVVmLOwrtZugOKdwerh/kgC8bbcDSUt0q9vEbP2eG7CnIrpcTviQ1rHhoo
	C3iJZiqmqQKZ9Xr71TMYK52ZSXA7xHsXO6o+JAMeifQ/Ki8+UHgh6SqzZx0dE6rzi8wlP9y7rRA
	gd4GeMD4PHhOuzeXJNH5eSGB05V8PTvzkI7VnNS5ZLWJXaAxoy0W7ZXgAkjF0wmFWkofHyug3Zc
	Tf+hwI3Q2ISLCy35IKH9Yz76X6F5MELFDo6D1mmUtrY9EYoor+LwWmy6FBxRku7g==
X-Received: by 2002:a05:6402:3786:b0:667:4dc2:fb54 with SMTP id 4fb4d7f45d1cf-668c9524124mr9500792a12.13.1774304705712;
        Mon, 23 Mar 2026 15:25:05 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668cf7e4528sm4162277a12.11.2026.03.23.15.25.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:25:05 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439af7d77f0so3466254f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:25:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuLR6GlT7UxSR+SKs+xR+oqxeRgxLZwIMHUNnyXkprARGeu5wmtjUfHz+bcxglXp40Q+WyTkU=@vger.kernel.org
X-Received: by 2002:a05:6000:420a:b0:43b:498f:dcec with SMTP id
 ffacd0b85a97d-43b6423287dmr21077499f8f.3.1774304703536; Mon, 23 Mar 2026
 15:25:03 -0700 (PDT)
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
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com> <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
In-Reply-To: <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Mar 2026 15:24:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
X-Gm-Features: AQROBzDRoysFzvcPUTGmT6MRxrhQA35lr81_ptAKZ8zLO5ZaZ49Cvz0mD_9klew
Message-ID: <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230023-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim,harvard.edu:email]
X-Rspamd-Queue-Id: 347852FE3A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Mar 23, 2026 at 10:47=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Mon, Mar 23, 2026 at 10:07:01AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Sat, Mar 21, 2026 at 8:54=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > > > > I'd also note that the only actual symptom we're seeing is with
> > > > > > fw_devlink misbehaving (because dev->fwnode->dev wasn't set ear=
ly
> > > > > > enough). fw_devlink is a "new" (ish) feature, is officially opt=
ional,
> > > > > > and isn't used on all hardware.
> > > > >
> > > > > That's true too, can we set that earlier?
> > > >
> > > > Yes, I can post a patch that _just_ moves the set of dev->fwnode->d=
ev
> > > > earlier, and that will probably fix my symptoms (I'll need to test)=
.
> > > > This patch already moves it a bit earlier, but if we don't break th=
e
> > > > linking out as a separate step it would need to move even higher up=
 in
> > > > the function.
> > > >
> > > > Originally, I was going to just propose that, but then I realized t=
hat
> > > > some of the other code in device_add() probably also ought to run
> > > > before we let the driver probe, and hence I ended up with this patc=
h.
> > >
> > > This sounds like a more generic problem.  A bunch of things happen af=
ter
> > > bus_add_device() that should be completed before probing can start; t=
he
> > > firmware node stuff is just one of them.
>
> You know, I wrote this but I'm not so sure that it's accurate.  We've
> gone many years with no big changes to this code; most likely it doesn't
> need alterations now.

That's fair, but I'm really just worried that the Android parallel
module loading code, which is only ~1 year old (and needs to be opted
in for each device) is stressing things in a way that nobody else is.
In most distros, I think modules are loaded "on-demand". A device gets
added first, and then we figure out which module has the driver that's
needed and load the module. Nice and sequential. Android seems to have
a different approach. As far as I understand it just has a list of
modules to load and slams through loading all of them even as devices
are still being added.

I don't think that what Android is doing is technically "wrong", but
it's certainly odd compared to all other distros.

Unless we say that what Android is doing is wrong (and decide what to
do about it), it seems like we need to make sure it's robust.


> > > Splitting bus_add_device() in two sounds reasonable, although I would
> > > rename the old routine to bus_link_device, since all it does it add s=
ome
> > > groups and symlinks.  The new routine can be called bus_add_device().
> >
> > LOL, so basically you want them named exactly opposite I did? That's
> > OK with me, though maybe:
> >
> > bus_prep_device()
> > bus_add_device()
>
> Nothing wrong with those names.  But instead of making these fairly
> intrusive changes it might be better just to move the firmware stuff to
> a different place in the code (you mentioned this possibility in your
> first email).  It would be a smaller change, that's for sure.

I'll do that if that's what everyone wants, but the more I think about
it the more worried I am that we'll end up with a hidden / harder to
debug problem where some driver gets unhappy when its probe is called
before dpm_sysfs_add(), device_pm_add(), device_create_file(),
device_create_sys_dev_entry(), BUS_NOTIFY_ADD_DEVICE, ...


> > > The real question is whether any of the other stuff that happens befo=
re
> > > bus_probe_device() needs to come after the device is added to the bus=
's
> > > list.  The bus_notify() and kobject_uevent() calls are good examples;=
 I
> > > don't know what their requirements are.  Should they be moved down,
> > > between the new bus_add_device() and bus_probe_device()?
> >
> > Yes, this is my question too. The question is, what's worse:
> >
> > 1. Potentially the device getting probed before the calls to
> > "bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)" and
> > "kobject_uevent(&dev->kobj, KOBJ_ADD)"
> >
> > 2. Calling "bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)" and
> > "kobject_uevent(&dev->kobj, KOBJ_ADD)" without first adding to the
> > subsystem's list of devices.
> >
> > As it is, my patch says #2 is worse and thus allows for #1. ...but I
> > don't actually know the answer. The main reason I chose to allow for
> > #1 is that it makes the behavior less different than it was before my
> > patch, but that doesn't mean it's correct.
> >
> > Reading  through a handful of "BUS_NOTIFY_ADD_DEVICE" calls, my guess
> > is that they expect to be called before probe... That would imply that
> > my patch made the wrong choice...
>
> I don't know about other subsystems, only USB.  As far as I remember,
> USB doesn't really care about the order of probing vs. notifications.
> In general, since probing can be asynchronous with registration, the
> kernel always has to work with probing after bus_notify().  It's
> best to preserve that order unless there's a very good reason not to.
>
> uevents may be different, since they go to userspace.  It could be
> weird for a user program to be told about a new device and then not be
> able to find it on the bus.
>
> > I think another option here might be to just add a new bitfield flag
> > to "struct device", like "ready_to_probe". Right before the call to
> > bus_probe_device(dev), we could do something like:
> >
> > device_lock(dev);
> > dev->ready_to_probe =3D true;
> > device_unlcok(dev);
> >
> > Then in __driver_attach() I can have:
> >
> > device_lock(dev);
> > ready_to_probe =3D dev->ready_to_probe;
> > device_unlock(dev);
> > if (!ready_to_probe)
> >   return 0;
> >
> > If I do that, I don't think I'll even need to re-order anything, and I
> > think it's all safe. Basically, it just the device hidden from the
> > __driver_attach() logic until probe is ready.
> >
> > What do you think?
>
> There should not be any difference between probing caused by the device
> being added to the bus, vs. caused by a new driver being registered, vs.
> caused by anything else (such as sysfs).  None of these should be
> allowed until all of them can be handled properly.

Right. ...and I think that's what my proposed "ready_to_probe" does.
It really does seem like quite a safe change. It _just_ prevents the
driver load path from initiating a probe too early.


> And linking the device into the bus's list of devices should be the
> event that makes probing possible.

Sure, but moving the linking into the bus's list of devices all the
way to the end is definitely a bigger change. If nothing else,
"bus_for_each_dev()" starts to be able to find the device once it's
linked into the list. If any of the ~50 drivers who register for
BUS_NOTIFY_ADD_DEVICE are relying on the device to show up in
"bus_for_each_dev()", it would be bad...

-Doug

