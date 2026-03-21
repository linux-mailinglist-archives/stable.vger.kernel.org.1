Return-Path: <stable+bounces-227733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH3+KXRRvmnsMQMAu9opvQ
	(envelope-from <stable+bounces-227733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:06:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDE2E41CF
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 253B53021B28
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB96349AE0;
	Sat, 21 Mar 2026 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCv74/lk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA672C11D1
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080367; cv=none; b=pFeXr6eHBalCZS0Awuv/gjhHYldUrvdCMh8wNLBHd5M7QGSX2k9AbAQFVjmOhev06PHTmR0HXHq5PgwQq1Azony58L0brt2JbCs4TSz0Q79UQSHCMCc+xZ4TySdJt1IFC5wxaogLvvU4D2vxoKC38aX4osRm6T9/qlawWRhWa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080367; c=relaxed/simple;
	bh=2s68hzYNGh4mCdQSBcdofjVj6JnV9wGLi01EF10aUdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq4XHwm8DCQ2Y5KmGUpJzLDlJa2XyvAQmtje/xNcbZRQKOWTcw8e7yBb4PxVootsRNruN8QPbp5LJTcAeg6IzF+VCQbq4l0QpaJ1EGkdRXMReFgnW/5nmFULj7RNE/mWjFTnHUkUr3bmmpRLLecPPTsVpLW2Z3LgLvNs8XWRgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TCv74/lk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6686fbdbe2eso3256276a12.1
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774080363; x=1774685163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPwatB8nwbheTC/o1xIGXmmqpvBr+XI1waV3gj8TSWU=;
        b=TCv74/lkgTqXvD8M+LixGUCNPpxMizlfdsd0FB1tprO7/5oKlHN52tPWwmQPFsm5HZ
         CP3CNLx+n919BGpfJLsH41Kfk4DTFES95rlNI+q4Cy11qNPH9h1EKXPFUVfcRHS7tvdb
         ZkdlmZ2JRTFx+QoeeFH6Zw8FlamTfxEdPuDJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774080363; x=1774685163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPwatB8nwbheTC/o1xIGXmmqpvBr+XI1waV3gj8TSWU=;
        b=l+DvSPr4O/7GRUuOL+Dx0cF3szCigXlNaDbPVWu7BIazw3RpJZWGQ6N/oWZwwd7X/g
         0ybGZSrtmST+5RphnK34r/qjeFQu7ebq1F+bmqWI+8l7b0Ob+heh8CO55uYD0nHKKDA3
         wotw7CEnz429HzfWE4je13ZdLOus0NLuCwPvEfzEocoWNgvO8o04Tf8ALaWKpclKG4VL
         tfZiVCdFD5a3t4CI3eSGJ0RSF2H/1e4GXpJzjve8sjg7/2ECdSxIDuOU/iVmoTu3LWpZ
         zk4iawh+UHWyhtERpw1mKqdisbTEtzw6jrCU921MzVRwwKv3Jjz3cbEDgFXJOkWmRKpM
         tlTw==
X-Forwarded-Encrypted: i=1; AJvYcCVldCbyqumphNcErkwgY8zPBnGxMUyTAfWrkb8VS06wYpFop1b7QpffXlAd8k0s2QaiHMKhaRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBSbgIP5JPyInabg7CZAEySWpjZLTHxYL0CRQSo5vOs3dreo2
	mn5qsRuQ08npM7GsHTNeSfvAGuq+eOD1/EH9qsLPKLwi+1mwgDcH7Qg5xQiKNtRARC18aYrD6ZT
	79tSTC1Lt
X-Gm-Gg: ATEYQzzqGzAv1k7TSMU7qT/Sn7mldslKohQK7NM8XkOGde6Ey/GntF7UmdFsZaXUQEk
	CSoQhHK+BLmVsn3QbgpSefKPOjyjeXMUmUi4VmboRh1KWWjOFCT0WJp04XR4tpr8CT3kie1AqMw
	2W4jHd64b9UhJXiWP7utcgt5rGmwz3KuLgq0PmU9dq4iW+16y9Hb1ee3hlR3+6KWYVNgMBMPNho
	ntFR91Q/B5i1D2GEBfqUrmjWNigBL1LOz0WYIybAFhMb78gczfHuC1i7gaBmv82qX8g7F79FOhl
	GYWZnFUQbQFOQzTGlxIfp+LtnQxN3y7BIl3DTwWrZvaJGMRsku1XfFiKq9iU3zWh5bFTQS51oDl
	MnebIHVWtEOdasbi36MbILxcCJDiizrVS59Gt/3DCJtuQSvAPJJAnIiue6JofaQ0gaHC1b6VvAa
	7e9TOPFPvAy0KboCxbZShOZBdaDL0+cvtcDl/ohxbhorwGWrY/6CN96QrTWzi15A==
X-Received: by 2002:a17:906:174f:b0:b98:42de:3700 with SMTP id a640c23a62f3a-b9842de3755mr168814066b.17.1774080362476;
        Sat, 21 Mar 2026 01:06:02 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8db2fsm253863866b.23.2026.03.21.01.06.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 01:06:01 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so2414468f8f.0
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 01:06:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsW5iZRkH5GtXPaNsrbMmUrpFkYgw4uM9oqJKA9hC2qavKWrSE0cT9CNYQ4fC2AqkW7F1ArCk=@vger.kernel.org
X-Received: by 2002:a05:6000:2409:b0:439:c078:9a57 with SMTP id
 ffacd0b85a97d-43b6428769cmr10495014f8f.25.1774080360308; Sat, 21 Mar 2026
 01:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh> <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh>
In-Reply-To: <2026032114-unlocked-unmoving-091b@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 21 Mar 2026 01:05:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
X-Gm-Features: AaiRm52s-9URaw6TU84sMrns19yrErBQbts8yoJ0kNLkR9r4G1S7vxdHuEDDBiQ
Message-ID: <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-227733-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17EDE2E41CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sat, Mar 21, 2026 at 12:42=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Mar 21, 2026 at 12:35:32AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Mar 20, 2026 at 10:41=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Mar 20, 2026 at 08:06:58PM -0700, Douglas Anderson wrote:
> > > > The moment we link a "struct device" into the list of devices for t=
he
> > > > bus, it's possible probe can happen. This is because another thread
> > > > can load the driver at any time and that can cause the device to
> > > > probe. This has been seen in practice with a stack crawl that looks
> > > > like this [1]:
> > > >
> > > >   really_probe()
> > > >   __driver_probe_device()
> > > >   driver_probe_device()
> > > >   __driver_attach()
> > > >   bus_for_each_dev()
> > > >   driver_attach()
> > > >   bus_add_driver()
> > > >   driver_register()
> > > >   __platform_driver_register()
> > > >   init_module() [some module]
> > > >   do_one_initcall()
> > > >   do_init_module()
> > > >   load_module()
> > > >   __arm64_sys_finit_module()
> > > >   invoke_syscall()
> > >
> > > Are you sure this isn't just a platform bus issue?  A bus should NOT =
be
> > > allowing a driver to be added at the same time a device is being adde=
d
> > > for that bus, ideally there should be a bus-specific lock somewhere f=
or
> > > this.
> >
> > Sure, if the right fix for this is somewhere in the platform bus code
> > then I'd be happy with a patch there to fix it. ...but from my quick
> > glance (admittedly, it's Friday night and I'm tired), it seems like
> > the problem is just with driver_register() being called at the same
> > time as device_add().
> >
> > Certainly adding some sort of locking could be a solution (happy for
> > someone to tell me where to place them), but we'd have to make sure we
> > aren't regressing performance for the normal case...
> >
> >
> > > When a device is added to the bus, yes, a probe can happen, and is
> > > expected to happen, for that device, so this feels odd.
> > >
> > > that being said, your patch does seem sane, and I don't see anything
> > > obviously wrong with it.  But it feels odd that this is just now show=
ing
> > > up for something that has been this way for a few decades...
> >
> > I suspect it's a latent bug that was triggered by a new Android
> > feature. It's showing up on phones that have
> > "ro.boot.load_modules_parallel" set. I think you can get to the
> > relevant source code at:
> >
> > https://cs.android.com/android/platform/superproject/main/+/main:system=
/core/libmodprobe/libmodprobe.cpp?q=3DLoadModulesParallel
> >
> > I suspect the bug is never triggered with more normal module loading
> > schemes. Indeed, one phone that has nearly the same set of drivers but
> > has parallel module loading turned off has no reports of this
> > problem...
>
> Ah, I think we always assumed that modules can NOT be loaded in
> parallel, isn't there an internal module lock that prevents this from
> happening?
>
> So yes, that might be the root problem here.

It's late Friday night for me (technically Saturday morning), so I'm
not going to dig now. ...but I'm fairly certain that Android isn't
using any downstream kernel patches to accomplish its "parallel module
loading". It's just userspace jamming modules in as fast as it can.
Userspace loading modules quickly shouldn't cause the kernel to behave
badly.

If the right solution is to add more locking to the kernel to slow
userspace down, that is also something I could try. It will likely end
up impacting boot speed, but of course correctness comes first. Let me
know if this is a direction I should dig (or someone is free to post a
patch and I can test it).


> > I'd also note that the only actual symptom we're seeing is with
> > fw_devlink misbehaving (because dev->fwnode->dev wasn't set early
> > enough). fw_devlink is a "new" (ish) feature, is officially optional,
> > and isn't used on all hardware.
>
> That's true too, can we set that earlier?

Yes, I can post a patch that _just_ moves the set of dev->fwnode->dev
earlier, and that will probably fix my symptoms (I'll need to test).
This patch already moves it a bit earlier, but if we don't break the
linking out as a separate step it would need to move even higher up in
the function.

Originally, I was going to just propose that, but then I realized that
some of the other code in device_add() probably also ought to run
before we let the driver probe, and hence I ended up with this patch.

-Doug

