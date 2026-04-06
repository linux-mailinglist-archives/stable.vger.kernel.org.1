Return-Path: <stable+bounces-233398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAl0FFzj02nIngcAu9opvQ
	(envelope-from <stable+bounces-233398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:46:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5D3A5693
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B9B3003EB4
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E25B21A;
	Mon,  6 Apr 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LOuueNrr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7425776
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493977; cv=none; b=JuEs3sh7uXM9fMcVnq5qiux2XhuAJUy48XDL6G1HFez/InhjbW5Ye1cJwjC2OXCyvMTHdOw2J7fVxZjRWIAJG8asEgnQC4RYMXgN+sMUZuW6bXbRcqgR5bMpLG/r/sVBFXyKpyRWf0EHle72/sNvircmbsa67n3RYH0B1sBzSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493977; c=relaxed/simple;
	bh=QxqGVqm1i/34YnjblUCjGI4Uj90RXCY/8Zyu2fvQrk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjKmeCrArh7hJtV3vhwReiMUWf4wuMNn4iKFlwE2FxlzN04zYokhdF+wV9Ou+SeBbU5p/5eV9buWN2Po7OYIUTM+Ia5CCByM53BuLNfcR17p1mAjyZw79IPuA+JBrPfdRnEwF/d0pdh51iUYgvEkmeFGdmLS11IobqWpwyw80RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LOuueNrr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso7500422a12.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775493969; x=1776098769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f9j7kIZ2Uiuc4j2TejWoSS2WCoQZYaehN86Hk6IOxE=;
        b=LOuueNrrinhpK4LCClnIzK0P22m/DyTLIIfvc38S2MnNGoyg32E91KQEq2VEr6rlIW
         YyKSpHdlN6QoX5UfykzqY0LSLvtluVYz2w0DdP98pcyM8MguC/HM8aA3us7vcKkTReI0
         yrnZlFeX0IuQSLtSqOazNM+EN1LHGhRjEpWyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775493969; x=1776098769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8f9j7kIZ2Uiuc4j2TejWoSS2WCoQZYaehN86Hk6IOxE=;
        b=QMY65zbXWTnWZviHcy5kth2z7I9owXnEe44fVrplbLtaEZ2OdOOAssbt5Zj3inXyCx
         5/pfr30dPRZqguvyFoLVjM8ecMAejjgknQ4hf2mr9pIof0JrdLHgymBXVlqCCi3UcLJa
         j2eco0r9MDsDJDpzhCOtdyc6L87BPJrj4vUxH8TBBa1Z0I5DFGfzjXycckZvpzWVpAwB
         bD2Wq7PA3q74oQZIhgcCuw8lQJVjdHQlFsVibN8nQw0kPut+jYqB4JaGmfzXkIS+is48
         RqG2xn3Z2Zj+bRYjMXCXVsHxJWc6hpWmXC1+gvKyUydEeQzdXKzxqCjh1iQ05KO8fM2/
         Ro9w==
X-Forwarded-Encrypted: i=1; AJvYcCUDZAEgCUWJgm4u1OJMhxcxBOJPrGHDeq7si2CkkFk22f1lc68pcEBNjcEvVlZHbqXsiTog9Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyE+n3eJ7qx1O6pYEXiSHjJzDFE4dDpYj08JsZncyNQqchjtLx
	/bEiF++HLm/Kl/9CcUbpzTN79zOyvOVAKKsEjZJGpuK5arQvSmvKOtDlVaiKgqBZkekb1flltAH
	L5pvK9vSY
X-Gm-Gg: AeBDiethzBDZVYa/Zva5Jo21s49BlLoSc85QtqWZgObfcUD2WoZ9p6SBr496EjKAtO/
	qlzmTmJxVteN4sPcHstiL8QAU6xIK+7lHXhbnEZimrOTT+ej3SG9b8JoaIkV1GWG6uuCqlVI16z
	iM2E9wQLFMiBb3kF5UOFXIKf4FbZDKs5+RsrdVXotzfnxlLllF30krqHFVJPs5phvgKX0SrQs6m
	IrloyRxXvlvrBlqXvQ2PAF8smaEBQknbvUCLIo6Z9Tte10deTveEK00hv5fL7FF7BOdWynh2ozT
	CopKI//fv1LY5SlrsHnPEVad9oRV6jcx4sG7ICQXzbEWzvQRldoxU7n+sEt25G/WO3s8nSLgs0v
	RuypA05yYaNZvDROBPsPV3XjTOilKYu44ZpuuL8GfFmlX5fiHDlRt621IBzHyM+C0UdNrm98ZtF
	iAwsDBJBV5gq6UH1AOm1lKJ8apFoGKsjIZ8i2sP8xMAbzxtxOjrBhjbBhH5T2oZA==
X-Received: by 2002:a05:6402:1f8b:b0:66e:aadc:2021 with SMTP id 4fb4d7f45d1cf-66eaadc212emr2652982a12.17.1775493968852;
        Mon, 06 Apr 2026 09:46:08 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3795885a12.13.2026.04.06.09.46.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:46:08 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2176794f8f.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 09:46:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVulz5k3P/dMAHeXH2B2PncTfZ3wMn4s71oAiadgwUzkr3Dj7g/QLh9VOnM85DwLz0hRL5dx38=@vger.kernel.org
X-Received: by 2002:a5d:5d0f:0:b0:43d:184:8a9b with SMTP id
 ffacd0b85a97d-43d2929d8fcmr19296227f8f.16.1775493965616; Mon, 06 Apr 2026
 09:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <873418d2fz.wl-maz@kernel.org> <CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
 <871pgscaj0.wl-maz@kernel.org>
In-Reply-To: <871pgscaj0.wl-maz@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Apr 2026 09:45:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4RidHw2_DUJxtk6gu3jwoQ52gJ_wbW80f6oO-4Z-uZQ@mail.gmail.com>
X-Gm-Features: AQROBzC--h3fG6U2sMXoOepON7HkR62IdBT7YOau8_qAOR5fD2anVtbUJRhii8c
Message-ID: <CAD=FV=U4RidHw2_DUJxtk6gu3jwoQ52gJ_wbW80f6oO-4Z-uZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's ready
To: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Saravana Kannan <saravanak@kernel.org>, Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, 
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-233398-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BEE5D3A5693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Apr 6, 2026 at 9:35=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 06 Apr 2026 15:41:08 +0100,
> Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Sun, Apr 5, 2026 at 11:32=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > > +      * blocked those attempts. Now that all of the above initiali=
zation has
> > > > +      * happened, unblock probe. If probe happens through another =
thread
> > > > +      * after this point but before bus_probe_device() runs then i=
t's fine.
> > > > +      * bus_probe_device() -> device_initial_probe() -> __device_a=
ttach()
> > > > +      * will notice (under device_lock) that the device is already=
 bound.
> > > > +      */
> > > > +     dev_set_ready_to_probe(dev);
> > >
> > > I think this lacks some ordering properties that we should be allowed
> > > to rely on. In this case, the 'ready_to_probe' flag being set should
> > > that all of the data structures are observable by another CPU.
> > >
> > > Unfortunately, this doesn't seem to be the case, see below.
> >
> > I agree. I think Danilo was proposing fixing this by just doing:
> >
> > device_lock(dev);
> > dev_set_ready_to_probe(dev);
> > device_unlock(dev);
> >
> > While that's a bit of an overkill, it also works I think. Do folks
> > have a preference for what they'd like to see in v5?
>
> It would work, but I find the construct rather obscure, and it implies
> that there is a similar lock taken on the read path. Looking at the
> code for a couple of minutes doesn't lead to an immediate clue that
> such lock is indeed taken on all read paths.

Yeah, it's definitely taken on all read paths. It is only accessed in
__driver_probe_device(). __driver_probe_device() is called in two
places.

1. From device_driver_attach(), it's called with
"__device_driver_lock()" held, which includes the device lock.

2. From driver_probe_device().

...then we look at driver_probe_device(). That's called from three places.

1. From __driver_attach_async_helper, it's called with
"__device_driver_lock()" held, which includes the device lock.

2. From __driver_attach(), it's called with "__device_driver_lock()"
held, which includes the device lock.

3. From __device_attach_driver()

...then we look at __device_attach_driver(). That's called from two places:

1. From __device_attach_async_helper(), which holds the device lock.

2. From __device_attach(), which holds the device lock.

...assuming I didn't mess up, that covers them all.


> > Are you suggesting I add smp memory barriers directly in all the
> > accessors? ...or just that clients of these functions should use
> > memory barriers as appropriate?
> >
> > In other words, would I do:
> >
> > smp_mb__before_atomic();
> > dev_set_ready_to_probe(dev);
> >
> > ...or add the barrier into all of the accessor?
> >
> > My thought was to not add the barrier into the accessors since at
> > least one of the accessors talks about being run from a hot path
> > (dma_reset_need_sync()). ...but I just want to make sure.
>
> I don't think this needs to be inflicted on all flags, specially the
> ones you are simply moving into the bitmap and that didn't have any
> particular ordering requirements. 'ready_to_probe' is a bit different,
> as it is new and tries to offer ordering semantics.

OK, cool. Just wanted to make sure I was understanding!


> So an open-coded barrier on both sides would do the trick, unless you
> go for the lock and can convince yourself that it is indeed always
> acquired on all the read paths.

I'm pretty convinced it's acquired on all read paths. :-)

-Doug

