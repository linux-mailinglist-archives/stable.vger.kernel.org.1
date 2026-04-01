Return-Path: <stable+bounces-232861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AhVCo6KzWnFegYAu9opvQ
	(envelope-from <stable+bounces-232861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:13:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656B380876
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB8A304740B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288463B8BDF;
	Wed,  1 Apr 2026 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3vsytiw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD883B8BD4
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077820; cv=none; b=HQlifZHBAnC8C7DqOcAQrXi/hXEGl1R/r7sKknId+zcmMVWAKklJJGWQYg8rjhVPL3qduS5rNrnj+ZPZfTcQJOiE1rCsmD7e32qzHEDrSIMbw4wR9nhhWUChQEn+qs3QIDwzA5267au4I0VYSGG4xR70GRONOdzWf9Xuz4lf/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077820; c=relaxed/simple;
	bh=zyFttTXNuZJK/32CT2m4h7GpWqj2ROee7GaYCXKbwTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j53C1z+msKRmJSX6631pCAkd93WSbIkZUr7de5wuaFYbQx6V2jvfZFwp5HcSIerwXTguq/3Jr16Nsxy1HGbT8tCXXGArGB00NrBJwWBSkAQLA7b+4rlalzm6DZqzYHEUDO3p+WkcD+t7DZxoNk5qY1YbPGtGzTezJwE8HHtlYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m3vsytiw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so296756a12.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775077814; x=1775682614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHX3adFhp3VQ3EddlCuHOOnOuSJT+t+CMh0HAuvok2w=;
        b=m3vsytiw3cJdNTuUEmMRWFJ+7hFj9aOVgDhDTbWHOJ7z9P6dKMCB+4ZaOaXKYHPetK
         n8d+YYhowHN68LKnrzvkQJGkLmOUCLGSWrbTIHfy4YX1obhUaq59tPrA6ALrqXPV2F63
         lj8/ZTeGEr5ydNIR7ouFnHAwJuQ/wLkzOFFIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077814; x=1775682614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHX3adFhp3VQ3EddlCuHOOnOuSJT+t+CMh0HAuvok2w=;
        b=jQgpmFL+e2K3VOcj+bBjMHIbqyUNidHwTKI1pEB9+GtVcDLrc5yPqSIKfohwdoFhLk
         RMzWlvULR64EEKRS3SG6YI2dZLFbd/lzzztRxuYXcpkyjKRRnppgpc9bdIiAxTWyugi9
         JRvooQCymY+XkP45wzVHTbJlXENZsXJxquJ9ZMYfbXn/+I2pxD5aExlUTwtam91cchgM
         oJIZ0sUuuHpU/2U1DWUndJENMsFDDnVraDBFp5IU0f9cPq0LLoqmWvqXPaTVcliRU3EP
         uMFWE1vnGLN+pVKANN0GaHoxdj7GE9xvRVSFG7l/rT7WaIYwPJiorOufAXSiLJv98pnl
         wLcA==
X-Forwarded-Encrypted: i=1; AJvYcCXs1fuVIm2GnjwH/636iHM2X2VHgGa4Hl7amwp2z7R4Gra7iOJg6Wl7oMefeMX3CA8sppQ/vKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMetMLmnk5eq2yWX4rlnSxoFaCOtJBWYj/3cqNj6DM5sN4S+Xq
	Cr9JGNDLYNCv6dON/I1+CDsnxE9Z7ksDjUW9Wx+OK1zHVpfIkvVHPAE88nwavo3W1SSFFMm+GWC
	4r6AcPA==
X-Gm-Gg: ATEYQzyUuZ9o4PL+Q+gJD06+22NoCU1i67KFQoYtZQzGBdQYaFIzik0ZsFX5GCoo8b+
	awn2BEivVVNgXjA41I/m4OrB5yf/owDq6j6gEdTJtQKO4ou3yCOTePLHzcf/Vqc4Q66lKZhQDpR
	exGaU2BhJ26C7ayGwvtOMXUXK33/6HM9YKwxAC0u4N/w3Wc2+KR6c1Kaqxl5Fy0i77fy5KxNLlw
	tTnpIFIJD7iStYTBNnLs+VEkMV71hzb3mLBIP8kjj7RlEnQYs+WSCx9SoFjxknXx1N7CuJ0viXI
	bR81BTzNl7xEuwdghIm5DTt6780qjCMzKw+MLhopOL5nuInXrH7wZEPRr5JIcVC9QZiNb9W4nLG
	lheI3C2Qx/FbKkL/JSRlOb3/LKP2IXb/whRBqaF5DnNQm5TG8405u+H0zZwotnJFwo4DOPNye0w
	uJ/0UYVU2chyqJyQcll9xevJxjhZz903KX9cxEn7dT4ArEhC29AF6sOcBIu2Qpnw==
X-Received: by 2002:a05:6402:a204:10b0:66d:d11c:fa0e with SMTP id 4fb4d7f45d1cf-66dd11cfb51mr1761527a12.12.1775077814044;
        Wed, 01 Apr 2026 14:10:14 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a7899sm179233a12.17.2026.04.01.14.10.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 14:10:13 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so1527225e9.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 14:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLsGMD0xj38PwuM/4MpppKhY3t3y9PYa4Hq8M9h9ITotOTpjg1Dr7vnrM6qeZ7SSVOWKtM1PA=@vger.kernel.org
X-Received: by 2002:a05:600c:1d0e:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488835bc1acmr82347435e9.12.1775077811306; Wed, 01 Apr 2026
 14:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <DHH1PD0ASG8H.1K3KG9L658DYN@kernel.org> <CAD=FV=XJ2qOZ7ftDg70AhD0GRX6TfQb6OVyNaUfFg42+hmwxGQ@mail.gmail.com>
 <DHI4H61YSZGE.BBM3H9B3H8F7@kernel.org>
In-Reply-To: <DHI4H61YSZGE.BBM3H9B3H8F7@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 Apr 2026 14:09:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X38yR7=KOPfayQCchY7xr=bpPz562bHMJTawXBL_2rsA@mail.gmail.com>
X-Gm-Features: AQROBzBupfLpPHVGbgE5Pj1a7iA_ATwmIVBVN-KRft9BiV43nt4TGPxsenumMp4
Message-ID: <CAD=FV=X38yR7=KOPfayQCchY7xr=bpPz562bHMJTawXBL_2rsA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Don't let a device probe until it's ready
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Kay Sievers <kay.sievers@vrfy.org>, 
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-232861-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 7656B380876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Wed, Apr 1, 2026 at 2:06=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Tue Mar 31, 2026 at 5:26 PM CEST, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Mar 31, 2026 at 7:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> >>
> >> > @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct d=
evice_driver *drv, struct device
> >> >       if (dev->driver)
> >> >               return -EBUSY;
> >> >
> >> > +     /*
> >> > +      * In device_add(), the "struct device" gets linked into the s=
ubsystem's
> >> > +      * list of devices and broadcast to userspace (via uevent) bef=
ore we're
> >> > +      * quite ready to probe. Those open pathways to driver probe b=
efore
> >> > +      * we've finished enough of device_add() to reliably support p=
robe.
> >> > +      * Detect this and tell other pathways to try again later. dev=
ice_add()
> >> > +      * itself will also try to probe immediately after setting
> >> > +      * "ready_to_probe".
> >> > +      */
> >> > +     if (!dev->ready_to_probe)
> >> > +             return dev_err_probe(dev, -EPROBE_DEFER, "Device not r=
eady_to_probe");
> >>
> >> Are we sure this dev->ready_to_probe dance does not introduce a new su=
btle bug
> >> considering that ready_to_probe is within a bitfield of struct device?
> >>
> >> I.e. are we sure there are no potential concurrent modifications of ot=
her fields
> >> in this bitfield that are not protected with the device lock?
> >>
> >> For instance, in __driver_attach() we set dev->can_match if
> >> driver_match_device() returns -EPROBE_DEFER without the device lock he=
ld.
> >
> > Bleh. Thank you for catching this. I naively assumed the device lock
> > protected the bitfield, but I didn't verify that.
> >
> >
> >> This is exactly the case you want to protect against, i.e. device_add(=
) racing
> >> with __driver_attach().
> >>
> >> So, there is a chance that the dev->ready_to_probe change gets interle=
aved with
> >> a dev->can_match change.
> >>
> >> I think all this goes away if we stop using bitfields for synchronizat=
ion; we
> >> should convert some of those to flags that we can modify with set_bit(=
) and
> >> friends instead.
> >
> > That sounds reasonable to me. Do you want me to send a v3 where I
> > create a new "unsigned long flags" in struct device and introduce this
> > as the first flag? If there are additional bitfields you want me to
> > convert, I can send them as additional patches in the series as long
> > as it's not too big of a change...
>
> I think the one with the biggest potential to cause real issues is can_ma=
tch, as
> it is modified without the device lock held from __driver_attach(), which=
 can be
> called at any time concurrently.
>
> (I think there are others as well, but they are more on the theoretical s=
ide of
> things. For instance, dma_skip_sync is modified by dma_set_mask(), which
> strictly speaking does not require the device lock to be held. In practic=
e,
> that's probably never an issue since dma_set_mask() is typically called f=
rom bus
> callbacks usually, but it's not strictly a requirement.)
>
> More in general, from a robustness point of view, everything that is set =
once at
> device creation time is fine to be a bitfield; bits that are used for
> synchronization or are modified concurrently, I'd rather use bitops.

OK, thanks! I've almost finished with patches to fully move all of
them to bitops. This means we simply don't need to think about them.
Also: even if they're not truly needed as bitops, it's nice (and saves
space) not to have some of some flags using bitfields and some bitops
unless there's a good reason.

I'll make sure that "can_match" is second in the list of patches. If
you hate the idea of converting the other ones we can just apply the
earlier patches in the series and drop the rest. ;-)

-Doug

