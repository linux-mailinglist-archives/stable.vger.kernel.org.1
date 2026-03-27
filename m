Return-Path: <stable+bounces-230715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CaSJETcxmkoPQUAu9opvQ
	(envelope-from <stable+bounces-230715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:36:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA38A34A3D5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D984C30D87E1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164D381AF3;
	Fri, 27 Mar 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WYctW9NY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF592382283
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639870; cv=none; b=uW51BNdCOHcyMLph0+BPcio79v6agC7R1im6oeNCzxkiG8o0FRZM6IxrngJxJcFnvj5CpEZ0YE6HImQA4rEdiGq9Qx6URB3qt54s61g1yKOIcQA14nfqQmiHio9u0eXqRsCAjsVK/smfW2689HReLIqm8jTGIAVlmqTWBfRN6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639870; c=relaxed/simple;
	bh=UdbT8M+h+T/8FIRyzyUEwSC00Y3Lxmg3ItzAi+c/6HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqJu+lvG1epV2z6BC7aBifm0f2KQu0dmMXPgiE/CCzJGnXM9/P8lJxTuzRz0R6nzBsdXKmSAOfgvgZZFjk7VvbXBlqR5nS+uOOKjlVmF3HzyOJ5QGDHPV6v/OSyhnv0Ff9ZvEFbmBu8lFgq+JT4DnGyOiQ2mlLpOl5QyUMeULAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WYctW9NY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97905516faso331762766b.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774639863; x=1775244663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99gWaYSzjnyq01Amp2SCb6AR3PTrEPRcQ1jAAPcG8L8=;
        b=WYctW9NYS4pqViGtJeVcxu7Z7/GjP7Tlf2nsQKOHOMcY48ICwsKcH1UVnO5aFP2uAc
         k0oPmx/Ogk9AcfLSeWyeofxI9foitN906iQ4EgSBAqs9a07bMbMXWmy9kiRfiJBLeoKJ
         uufSfDgwitU9tAh1xSU+LvKtNAZB6PImL2bow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639863; x=1775244663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99gWaYSzjnyq01Amp2SCb6AR3PTrEPRcQ1jAAPcG8L8=;
        b=ec3KsK5RZx/Jc+wHAmrmuRS72TI0iKK0uRzNYwIo8HNwSID7EooN5Pvp69YETnt6CQ
         hv4DnZ63dW4W2mdt4IO5s8BP7ltsnizAF7+TXlsrEhHuZeek1reFm3sToc2HwvzmH+pD
         wKStF8IKQx5Vd+lJOtNlP4KZIF8QDvP13bOrFtAf1+FNtce++PKt6acb+iLF/rLZztz7
         HDGK86NGidCZmthO5pzupd4W9eW492D16taBCls0+4gr5XjB+5VrKsHNCL8UgH8DlqPQ
         Yex8GASk+LIzLqZbW2z9y62BYF9GHdADAI0SkZFna365husbximqZX4XloQJ1rRwsZLt
         ROzw==
X-Forwarded-Encrypted: i=1; AJvYcCULMIkp25S7+6EIyeUp53971xiH6xxW2pziuw1Gu5qZg5Au8zsvi9RxjIGZeySNT/J77fRma9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJavzCXuc6Wl6aYewo8xZG1jMiD2HzWAMe8bEQqW4UwZRW0Uu
	+WsjarJMaebUJKP8l35Mi3mW8vkOaxtbYr9q6S4Vwgz/vXEpERsMrXodJ3VJ+qBiqVS8gNMR5Uv
	+9/KUPA==
X-Gm-Gg: ATEYQzyRiaNsTkt2FdCdjR9yKebErN6ytCi6rB8aETR+N0Ud2VW3UxGPGt/5TlS0gjl
	Vv0DnSNShTOggBhwrbdYGCBAejzVQmxuUl132cTAzOnphsUvLMofmjToHSfbH0EBFEkjiJkkXrR
	g+xuZceulQJgKDEvY8ytZatvx/7EBxeN2nKLaVhJ7Qk6JKClPrCLPBYz9oIOQ2uI2vXFxOWVZki
	fIp8sEPqS7ru1YapqE2TC5kT1GXapslPKzjg2bFd0iyPaHXR+HbUX5H6eoQbZAe8dvbMSLNMijt
	IWrxSmLIcGxkNN2GdOpY0E9dK14s3u0mN0sOxj4NVC3jj8Wu5S90gFYhJEY7KyyP85PnBLNBWdO
	jJLyYX8fiHHAVradmAQbpFlRLZUtAxKYQlbQNT6nnWwKlu7IHfcmaBuZUXw4vGaqhFG2vM/JpnR
	nfLmoTjM/74wQjRaOGIv95OEpgwZJp1ewPhEwN9aJ+Q6EV5Mo7DhKLcOgwYiooDBJBpu00a4QL
X-Received: by 2002:a17:906:4795:b0:b97:2a5:8a48 with SMTP id a640c23a62f3a-b9b507b0eb8mr260539866b.37.1774639862670;
        Fri, 27 Mar 2026 12:31:02 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b75ba9742sm1098a12.16.2026.03.27.12.31.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 12:31:02 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b9144790dso1391016f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:31:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGF6U3ELPzhs8VxCnPJAiIVqIEG1/JAJqjDZA/Zj8zKDa4tjs/AhWiyjK7dcGqjK7D+TRF1gA=@vger.kernel.org
X-Received: by 2002:adf:f5d0:0:b0:43c:f1da:488b with SMTP id
 ffacd0b85a97d-43cf1da494emr250211f8f.30.1774639859273; Fri, 27 Mar 2026
 12:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026032152-getting-carmaker-29d5@gregkh> <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh> <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
 <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
 <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
 <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
 <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com> <852cd509-4ce1-4b22-ab1f-b9b9bbf6a52e@rowland.harvard.edu>
In-Reply-To: <852cd509-4ce1-4b22-ab1f-b9b9bbf6a52e@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 27 Mar 2026 12:30:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UroO1vQYJDkrp86D475F8b-RStUXYejWwTQ0NqP1a_ew@mail.gmail.com>
X-Gm-Features: AQROBzB1FKb3rh0thX0FLzEGHt2HXFbkx3ukymP0tbJUZxNnXoTJGwjGT2c25ZE
Message-ID: <CAD=FV=UroO1vQYJDkrp86D475F8b-RStUXYejWwTQ0NqP1a_ew@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230715-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harvard.edu:email]
X-Rspamd-Queue-Id: EA38A34A3D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, Mar 27, 2026 at 11:46=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, Mar 26, 2026 at 02:49:33PM -0700, Doug Anderson wrote:
> > > > Right. ...and I think that's what my proposed "ready_to_probe" does=
.
> > > > It really does seem like quite a safe change. It _just_ prevents th=
e
> > > > driver load path from initiating a probe too early.
> > >
> > > Any such consideration should apply to all the probe paths, not just
> > > driver loading.  (Also, if it's too early to probe the device, perhap=
s
> > > the return code should be -EAGAIN instead of 0.)
> >
> > In my proposed solution, I was returning 0 from __driver_attach(). The
> > only place that's called from is driver_attach(), which calls it with
> > bus_for_each_dev(). I don't think returning -EAGAIN is a good idea
> > there since it stops bus_for_each_dev(). In general __driver_attach()
> > always returns 0.
> >
> > In general, the goal of my new proposed patch is to add the device to
> > the subsystem's "klist_devices" exactly where we do it today for
> > maximum compatibility. This means that if any code was relying on
> > being able to find the device, they can still find it. The _only_
> > exception is that I don't want to be able to find the device in
> > driver_attach(). So my proposed solution just hides the device in that
> > one case.
>
> But why just in that one case?  That's what I don't understand.  If it's
> not okay to bind at this time on the driver-load path, why is it okay to
> bind on other pathways (such as bus.c:bind_store())?

Ah, I see!

Yeah, OK. I spent more time, and I think I've a patch that will
address things. I still like adding the "ready_to_probe" flag and
setting it in device_add() right before bus_probe_device(). ...but
I've changed where I'm testing this flag. Now I've got the test in
__driver_probe_device(), where I simply do:

  /*
   * In device_add(), the "struct device" gets linked into the subsystem's
   * list of devices and broadcast to userspace (via uevent) before we're
   * quite ready to probe. Those open pathways to driver probe before
   * we've finished enough of device_add() to reliably support probe.
   * Detect this and tell other pathways to try again later. device_add()
   * itself will also try to probe immediately after setting
   * "ready_to_probe".
   */
  if (!dev->ready_to_probe)
    return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready_to_probe");

I think that is more inline with your intuition that we should return
some sort of "try again" code when we end up with this situation. This
should also block _all_ probe paths safely by adding to the deferral
list (just in case) or returning -EAGAIN (in the case of
device_driver_attach()).

Does that sound like what you're looking for?

-Doug

