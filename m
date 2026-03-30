Return-Path: <stable+bounces-231240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM6yEQ2Mymn09gUAu9opvQ
	(envelope-from <stable+bounces-231240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:43:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AED8135D13A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8254230B061C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653A28688C;
	Mon, 30 Mar 2026 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUUulQb5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FA28C035
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881096; cv=none; b=dczkCkczdyE/olTjuPtSVhFccGYvn2yF/FiHJBgBsT9ESBywBqrq6ExrlDawFb9KLBk2/UyWp2r0K/z5MnT9/bcEiC9I2sa1+hW0thI0Jjh0Fkpn9d8HpAs6of9pUI1IqXBUpWLaTGbQ+3jfpEMlq+0C3ZwoT6Od6XN9nlCNUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881096; c=relaxed/simple;
	bh=h3FGVwRTPYOfB0zDSRnMIsrHoO/wxz/4EbZYgSdFw2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnL/fq61WcCKvFrZKslaskhBkrxCVEqDnqjqaJTHxDL+1KVQQZ76L4XruOEuo5vqfA0WMTPp1iKSzF09C9iTyWIKABtkL/B0/iFtW7hMUoWd8PRsh+v6iAeQXh0iyo6blEiQfOPPZ//G4+6Xd76wxw/A/0KpK/lY2cUgWrmReWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUUulQb5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9b1ffbb9f5so549227566b.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774881091; x=1775485891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cqMaBn41Rar9mtlb33z9M/+19lyrnvUNl4CHgOmrTM=;
        b=DUUulQb5eNFqfdwZpaROsOtLJbV916bVbvZxLTY2BVfwIO3ytKLrZ8W4vATIet/ahH
         bh/uPpfkSOKsc0/b6W+WVsNgLMimyViPW1gqzDbi6mGlhi7BS4udSFCpbH+9gFxbyt8S
         pNAGYe90h6MlUEVOEQhJ4d0X470iDQ3l/axnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881091; x=1775485891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cqMaBn41Rar9mtlb33z9M/+19lyrnvUNl4CHgOmrTM=;
        b=aREmSM1O9yzWrF0ngINNZ5Xxs9T3ltn6KqtygZiShUrP/9kbdaLkK1J5YeiVUvg70j
         S8et3vwQqpkCu9hrGaPD6/jQqCGJ30h72YUjZT2VrERFFNzqLemeknUNXT2MXmEds4jP
         m2kDZH4/YJE5cGEtKYQqzKX8cbsZi5WDYiW1JFGwlKCdPBojGo/ExoKVaoLkholTYtNl
         j1gDT9RVByDWBBkpUoePGkpscSlKhAuxONrpey1Du7hW4kFkq8ivdVeEwaPbpNJOytS9
         1glIJ34+9vajaiZkx7v+kghvBmrh2E80R/6LODfLBtf7T8bWaVkuQLG/kC6m6nuAuj7g
         UDQg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ePjTfdnyrCvQfsue/kRrmW+3z3O2C7Z50TlS1DC+lsGxBtDTY8jC84D9CcNbgqm9qDzQL54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHl9TXEOf2jNhDdIIStCeDLCTcBiRi2upmt8PxYs8CMzyAD4xp
	0jFAYjHxdwrRYAbYWrl4wA0EpcOUZ1Jn5PrqWAuKU0HhV1WkrrQZpqKypIvV6a+WLOZN9wh+kai
	LST87xg==
X-Gm-Gg: ATEYQzwqX8jxgPgfEd+5BvQRKuqWodD4vjyVtDZRi8aJMcOLrqbt25vbnKWBCzHUWtP
	Ez6rTmxLeKYhcA0THXWfsuuLCBaoF509522hF4uliFdbbcS9UMw130JnQ6ZqNEsNMtp7xz8Zyl+
	AUvEDWvqvB2XXo8Vyi6BbDOt0xO+esjNA+XqTbP73mBZzpMiLNE7ffd9k+uKr0g9XzzDiWgIG51
	/VJcyDKAK3+yA7IcNtV9E9OmwHayeBTliRbRFU8/wEmTIKePMRb8VcHGFSeB4BAdeX5B+KWnLrh
	C8CTMtg42ANCPmjK7RBfQ5FeKBHejlSxppSg4lAbKtA7HlZ21xh5tJ03I/wndSgpK5VdslNdCky
	UvqWyhvF+I/Ub7TIGs+BI3WwNCaZvFGe+oi2v1Qu5rhIOXUvCPR5kEfYsDfs0ui/uVTHkP9Km8f
	tuQ5xMaVjdAPrVL3iFoKd1GPeQyJXWHh1IZSan5O8sI6mFKR+1Oe32HwjWDx/4tA==
X-Received: by 2002:a17:907:e106:b0:b98:56b0:dc96 with SMTP id a640c23a62f3a-b9b503541e8mr509476866b.21.1774881090376;
        Mon, 30 Mar 2026 07:31:30 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a6736sm306112666b.38.2026.03.30.07.31.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:31:28 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9b1ffbb9f5so549214266b.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:31:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeQ7UMPcQA1VpDAgaMtqCIfPw6tULB9pAxaUyKuliE+b2TSmDBeREuhdemi8Fs57+k3+bhquA=@vger.kernel.org
X-Received: by 2002:a17:907:e158:b0:b98:32c1:2465 with SMTP id
 a640c23a62f3a-b9b5094ea6emr617512066b.48.1774881088102; Mon, 30 Mar 2026
 07:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026032114-unlocked-unmoving-091b@gregkh> <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
 <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
 <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
 <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
 <CAD=FV=WeeBoQAoPgNq+5ocZas+mOn1RuNto3k57ag4ODo2vOLw@mail.gmail.com>
 <852cd509-4ce1-4b22-ab1f-b9b9bbf6a52e@rowland.harvard.edu>
 <CAD=FV=UroO1vQYJDkrp86D475F8b-RStUXYejWwTQ0NqP1a_ew@mail.gmail.com> <5ea67deb-e669-4faa-be47-b1b225f1194a@rowland.harvard.edu>
In-Reply-To: <5ea67deb-e669-4faa-be47-b1b225f1194a@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 30 Mar 2026 07:31:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPRchnWroMXtjdiMoGwz8JvO1aZFPEioOO54LoY3Cw2g@mail.gmail.com>
X-Gm-Features: AQROBzD_XzWh9fcI0DGus-Fi8sX9sgc08LM_4d2MoOacxTHrOysvfL0PhdVqk6E
Message-ID: <CAD=FV=VPRchnWroMXtjdiMoGwz8JvO1aZFPEioOO54LoY3Cw2g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231240-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harvard.edu:email,mail.gmail.com:mid,chromium.org:dkim]
X-Rspamd-Queue-Id: AED8135D13A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, Mar 27, 2026 at 6:35=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Mar 27, 2026 at 12:30:47PM -0700, Doug Anderson wrote:
> > > But why just in that one case?  That's what I don't understand.  If i=
t's
> > > not okay to bind at this time on the driver-load path, why is it okay=
 to
> > > bind on other pathways (such as bus.c:bind_store())?
> >
> > Ah, I see!
> >
> > Yeah, OK. I spent more time, and I think I've a patch that will
> > address things. I still like adding the "ready_to_probe" flag and
> > setting it in device_add() right before bus_probe_device(). ...but
> > I've changed where I'm testing this flag. Now I've got the test in
> > __driver_probe_device(), where I simply do:
> >
> >   /*
> >    * In device_add(), the "struct device" gets linked into the subsyste=
m's
> >    * list of devices and broadcast to userspace (via uevent) before we'=
re
> >    * quite ready to probe. Those open pathways to driver probe before
> >    * we've finished enough of device_add() to reliably support probe.
> >    * Detect this and tell other pathways to try again later. device_add=
()
> >    * itself will also try to probe immediately after setting
> >    * "ready_to_probe".
> >    */
> >   if (!dev->ready_to_probe)
> >     return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready_to_probe=
");
> >
> > I think that is more inline with your intuition that we should return
> > some sort of "try again" code when we end up with this situation. This
> > should also block _all_ probe paths safely by adding to the deferral
> > list (just in case) or returning -EAGAIN (in the case of
> > device_driver_attach()).
> >
> > Does that sound like what you're looking for?
>
> Yes, that's exactly what I was asking about.  Let's see the complete
> patch!

Yay! Thank you for your patience / reviews / help. As always, it's
much appreciated!

I ran tests over the weekend and things look really good, so I've
posted v2 here:

https://lore.kernel.org/r/20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabce=
ad688d0d8c17@changeid

-Doug

