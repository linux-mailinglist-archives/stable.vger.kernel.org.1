Return-Path: <stable+bounces-230532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PLUJgaqxWlUAQUAu9opvQ
	(envelope-from <stable+bounces-230532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:49:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6833C1E1
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2E9C30210FD
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FB30FF37;
	Thu, 26 Mar 2026 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1Zz6j/C"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6BA301460
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561794; cv=none; b=C0UIUVEji+aUQHMpRWBTGKFdSxevWFPgTwBKbOHhhjxJAze1F2jZk+B51bCEhASU9JNYrpYUuAax1Q2hCuej6+X95vY/M/f+kYSF9YzaJ0fZxEzy8KNHRl3sKtV0cUEjsEC/2+UzvFqBlc9kZcBoyBHfE/JUmjxgyvP03p0QMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561794; c=relaxed/simple;
	bh=aKLX+hNPaI0XlfoPJagBu5mZrf265cU668okNsNseKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZoe+icQBdQ0zfGSK2MHjhMEWYy9jP13FQdP5Yk5hiLtGYD6Hvg16z2k46ztN1evFBV8JGLvGHfByHFhACphOp2lutwxPrx5RoU9OdC22m16HVbry6+csLrN+LwSETM6TnUNGQyle3pUT0ylOSmmggXeYUEWcPVmsSQcWVhIDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1Zz6j/C; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso2210507a12.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774561787; x=1775166587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAKkSou4roERMDhHrtw7MaZZUWuXxGKKeAc/MZ02tbA=;
        b=W1Zz6j/CyUTAvk0EL97msDUjJj0pJWuaLBkhxIK4prYHXWHrrnpuiiYFDtLsST/GSF
         f1obD1H/sx12nUF4eamtLPRcrXezaJlqMwJs/1VyCEwL9UDbP7pOO74RXg+aGxXGuxnh
         OleVh8iXecnONoMjOSK+iCOevDT7nu2XfU8tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561787; x=1775166587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAKkSou4roERMDhHrtw7MaZZUWuXxGKKeAc/MZ02tbA=;
        b=k/ro5sJtLhlSt5dQOWEoQeZmq5MmscxHLnfu/UZl78g70DODyUb05w7hjo+kITrLnc
         LhsK3ssZKOnpDQlks9OatuKS0us9VLm2jsmJWHi43BH9o3CvDPTOFJ4WwsG6wYjlWYRt
         ZmBFYW+SZZ2WOTC2dc09D7O/8JWY4o4J0g3YsoGO6f1ZkeXvAXQxOjYFcgR8fk6RqnbL
         Gq5DK3651qteFTrP9/YOn2NtIPJ7dTPwNQIB6REaWwziSyEkT3vJbWRdNNUU8EpHeeOW
         KfeydgwyjIMtxEmnCtdm2OlDaU/Vwz5MVFcMyx8sLgDTe6pfFXEGKvaHbSZlV2E2BH7f
         afRw==
X-Forwarded-Encrypted: i=1; AJvYcCUXoIkszXMwvubZhsVMWABPRBms6hkcHR+pZYizd9zArrBNgQA6G0KOqWAhPVmKWBJebkQawpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUnE8vPufPEbpxHnqKB5cPodYFquTmssQG/+p83K9AevGc6G+
	hQ1E/c6loQ4WzatADEyOigTssx+2WaFEGhnmgznsCDauP1opteKHfPz0RfwuHb7p40dh24LWwQ3
	iyZ4+cA==
X-Gm-Gg: ATEYQzzLDyFKCx7xVVAA3SwsJsDbAp8eQLGJQKxAnov0bE9TurD2ZdveSFsqHRYTUFs
	FdXLTjeIeXlP6irvgN5ytjRsqeocxEbl5yRA516VEwcoEw928gaaNvHgHS5UiftpPzaglVl0r36
	P6pnKiaagjmBHqUtNrzSlEv64Zb/9X4PjEmPrDvFXvdK07Ps3xV/J6MLCtFoDyw88X3fhca/Zck
	I3CJm/vrAgKE+BZeBEv5A+qeUFbX0QhiIkvWMGySXrVBwi5VBL1L9HODlL8tpjhrjHNcMg5wLjk
	YOojBEn2CQ1sFKudmmjgVaDWG1uA6kOlCHr6wywes/cKIDJB76SyhwU9ITCujFdyUZneq/+J2hT
	abH3wOPnYbZvAxrQiGrIF6oRpyBDNaIkpAx4aYjNPbn1JJ47MSedLHNmqlphHxyCLxDHofYxnf+
	YifwU4MDP55ftkUox0AAlbTDxKfLTWbijNsIsm1TEa5TyavyWgb6/MwcjD8NgEew==
X-Received: by 2002:a17:907:8b95:b0:b94:21a8:f7d9 with SMTP id a640c23a62f3a-b9b507b5d93mr3801566b.36.1774561787084;
        Thu, 26 Mar 2026 14:49:47 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203ef93bsm169337566b.50.2026.03.26.14.49.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 14:49:45 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439af7d77f0so1166943f8f.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 14:49:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlyONBRxFGV9FXoF5wjF5BQbZC9onniWhcpQmIc6dQ/FWIAqcr5yLr2pU6YPhxgNQqQNXRhIw=@vger.kernel.org
X-Received: by 2002:a05:6000:18a5:b0:439:d755:a895 with SMTP id
 ffacd0b85a97d-43b889f5a83mr15702276f8f.42.1774561785162; Thu, 26 Mar 2026
 14:49:45 -0700 (PDT)
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
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
 <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
 <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com> <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
In-Reply-To: <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 26 Mar 2026 14:49:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com>
X-Gm-Features: AQROBzCCSDGRZbt8Tt1gAypD9l0-fhRzQjRInpIAEQRFJCJSpoBx2KceRxCnDFw
Message-ID: <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-230532-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 03B6833C1E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Mar 24, 2026 at 8:21=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> > I'll do that if that's what everyone wants, but the more I think about
> > it the more worried I am that we'll end up with a hidden / harder to
> > debug problem where some driver gets unhappy when its probe is called
> > before dpm_sysfs_add(), device_pm_add(), device_create_file(),
> > device_create_sys_dev_entry(), BUS_NOTIFY_ADD_DEVICE, ...
>
> It's hard to know for all of them.  However, it seems pretty clear that
> device_pm_add() should come before probing, since a probe routine will
> generally want to affect the device's runtime PM state.

Yup, that seems right to me, too. It's why I was trying to avoid just
moving fixing the fwdevlink assignment. I didn't want to run into more
hard-to-debug issues later.


> > > There should not be any difference between probing caused by the devi=
ce
> > > being added to the bus, vs. caused by a new driver being registered, =
vs.
> > > caused by anything else (such as sysfs).  None of these should be
> > > allowed until all of them can be handled properly.
> >
> > Right. ...and I think that's what my proposed "ready_to_probe" does.
> > It really does seem like quite a safe change. It _just_ prevents the
> > driver load path from initiating a probe too early.
>
> Any such consideration should apply to all the probe paths, not just
> driver loading.  (Also, if it's too early to probe the device, perhaps
> the return code should be -EAGAIN instead of 0.)

In my proposed solution, I was returning 0 from __driver_attach(). The
only place that's called from is driver_attach(), which calls it with
bus_for_each_dev(). I don't think returning -EAGAIN is a good idea
there since it stops bus_for_each_dev(). In general __driver_attach()
always returns 0.

In general, the goal of my new proposed patch is to add the device to
the subsystem's "klist_devices" exactly where we do it today for
maximum compatibility. This means that if any code was relying on
being able to find the device, they can still find it. The _only_
exception is that I don't want to be able to find the device in
driver_attach(). So my proposed solution just hides the device in that
one case.

I believe this should be fine. Specifically, driver_attach() could
have been called (in another thread) immediately before
bus_add_device() and everything would have been fine. driver_attach()
wouldn't have found the device (because it wasn't linked in) but the
probe would still happen.


> I'm not at all sure whether the constraints we've got will need to force
> some events to happen after adding the device to the bus list and before
> allowing probing to start.
>
> > > And linking the device into the bus's list of devices should be the
> > > event that makes probing possible.
> >
> > Sure, but moving the linking into the bus's list of devices all the
> > way to the end is definitely a bigger change. If nothing else,
> > "bus_for_each_dev()" starts to be able to find the device once it's
> > linked into the list. If any of the ~50 drivers who register for
> > BUS_NOTIFY_ADD_DEVICE are relying on the device to show up in
> > "bus_for_each_dev()", it would be bad...
>
> I don't know the answer to this.  That is, I don't know if there are any
> notification handlers depending on the device showing up in the bus's
> list.  The safest thing to do is issue the notification after adding the
> device to the list -- which may mean after probing has potentially
> started.  Is there any reason why that would be a problem?  I'm not
> aware of any.

I'm not completely sure I follow what you're suggesting here...


> The order constraints should be commented explicitly in device_add(),
> not just implicitly implied by the code.  Otherwise people won't know
> what changes are allowed and what changes are forbidden.

Yup! I added comments about ordering constraints in this RFC patch,
and will continue to do so as it evolves.

I still believe adding a flag that just hides the device from
driver_attach() is a safe and correct approach. In general I don't
want to fragment the discussoin, but I think it might be useful to
send a v2 that shows what that looks like. Any objections?

-Doug

