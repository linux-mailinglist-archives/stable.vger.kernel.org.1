Return-Path: <stable+bounces-231446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBJfGXLqy2myMQYAu9opvQ
	(envelope-from <stable+bounces-231446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:38:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C757E36BDCC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B8EF3170888
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830C40B6EB;
	Tue, 31 Mar 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QX7xzuDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F609407575
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970788; cv=none; b=i015kBBoEmgAdEs8XtxmOlpUCg5KsoXX4iik3s4IARBW+ZTOnAGvEZMupEc8FmejRbf+wxyie4wdHqOUE9wW54iu5/VVhW1ezD1niKrBschGcJRLamamaYd/d8ofQkmlMz56HlR653++7uZemjJXkckAPbiz+WSjFKVVA8uTmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970788; c=relaxed/simple;
	bh=p1FuVBtkzvgZxkA/85sVWcISljQ1QqCRc/77Myie85M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZH+7OmEe0fJCS3iCX4VYEOMl4bHG5Diw2Ij9wK0fmGJqIdTWd22UkG933AgjuSzoQYxBg7veyt5dNP6nnXaX8zEHSbMhxO335IyHVyY23sZGWxG+JzYXbgQIk11EeEF2dwtu0BjZ2CAh//bNlKFLQWk5Mk0WaEzsVKgmL3eCnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QX7xzuDy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358dd7f79so33417266b.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774970782; x=1775575582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv9FvyVYU4HlL8YK9g3Zs+LbipJa/4PqgGL/7ICcHJI=;
        b=QX7xzuDyNz72BDnATBOyEq2XlT2igy2KlPDafjE2mBWnuNFGe2mJiJX3v1zrnYPfnW
         NxEyHuxaBuQ+rMroTnlufkPJNmwLE/84kHVjo1tp0/5KO774Gtc6HpgcTgB22mJietmI
         d7rLPEhatBl+rUZ3IDqL0RPd7usBuethf7DkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970782; x=1775575582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qv9FvyVYU4HlL8YK9g3Zs+LbipJa/4PqgGL/7ICcHJI=;
        b=UD11EntGegzNpjzG4Ctu1qsoLCW9MsswjQB7Jevs9w0hAUmxCgGFk6tt6Wk51OHWZ9
         IruWZtSh3y6Rec2+7jyumGyZIfl5HN87qk9TZZAHc85BjSIWIa3jO8ulImn/fuUH1Ohv
         XYBuOGWooAZDBwgd1RDcQ7Q7TzfZ4vrPI8JFUboAQRxDttRanyWTTyhbGIaszMJ1+UT5
         grYElrEauFGBMbTjQy6y+UAG6RK5I8kwfWn4k0yIK60Ngli/A9tZbcAis3SHl7VsVGHJ
         yPCl8USHqJCmJnFE7CK5CrRUjzTJJbcHuvv3uuyQV+3fTY7IyT9jIIKppBajOZcjUu3L
         JE5A==
X-Forwarded-Encrypted: i=1; AJvYcCVxW3djTkQQAGmyRNrO5ql2o9RzW1tAlwOsshidQ0hcnn/o5auoA6XpN8aFS9XBjrgaWN7Ml4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpN0EpbMbOjYpxz1NDiXHwFFBR4Blz41z2X7/syjvCrAzJs3uv
	dS5vG9m5ioHUkOU31J/ReyCmtN5ZXVIvwVvuhKtyEASZT2rm344hpVcPSlKGUtrYTGV5qRw/FKS
	J9K3V2w==
X-Gm-Gg: ATEYQzwRITOIbW0Z76y58a/OMc6vnMII5ZOw1VW+W8Ith9LDF0jmc3NL45HpnSd9Ors
	Ye0a3b6we0mnR/NqnlbpMyRHgd0KwXz7EY8tE/orCutWja9wKjVmFaTEJ2fqbQLNd3Pn2GKT8dP
	zqtoPBqpUfLRTzS5uXvqeS0I4fmXlTVPiO15833dMX3SkLpicr9+mPpDwpCdvXodk7ywYCiMFOB
	YMg1KrmLyHTiW/AeRTCCyG+WX+t9AY7VUjEG+EpdXEKiMeEa8NYEE+Z7yzJoR1ZIXCgOxD/zt8E
	Qf146KY3phALtuQE3ZVBcb1OMOvBD5JFZwQlge9i0C2R248McuzQEIVKdJr0Ey/7FsH2zgUhFO1
	leFd8FGozviHey/k1Bm5Ser3pKd6u6Xix637r8SgB+QH721b2q0uqo7QZ5+afcylnuag2KokDGj
	dWVeHgrrm3xdowooTNAfx92/T0egr+Kun0H58O0YGouJbYMqkD+moeW/rlHRzIjg==
X-Received: by 2002:a17:907:c786:b0:b98:baf:638e with SMTP id a640c23a62f3a-b9c138bff1cmr4426466b.13.1774970781728;
        Tue, 31 Mar 2026 08:26:21 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae50e6dsm424976466b.15.2026.03.31.08.26.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 08:26:21 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d02a71526so1154964f8f.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 08:26:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL/+YZHpsd7xyH0YA9NekQv/JOJskH+WYlcRDzC+l32pgl3Cs9EXbX2EJ70hylW3FiPK66d1s=@vger.kernel.org
X-Received: by 2002:a05:6000:24c1:b0:43b:3cdc:941f with SMTP id
 ffacd0b85a97d-43d150869ddmr130954f8f.17.1774970778986; Tue, 31 Mar 2026
 08:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <DHH1PD0ASG8H.1K3KG9L658DYN@kernel.org>
In-Reply-To: <DHH1PD0ASG8H.1K3KG9L658DYN@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 31 Mar 2026 08:26:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJ2qOZ7ftDg70AhD0GRX6TfQb6OVyNaUfFg42+hmwxGQ@mail.gmail.com>
X-Gm-Features: AQROBzAO84ippC-b2XO-7R5l6fnyfqHcAQ7sFFgv72ZLW18LGW8l3elfjno7St0
Message-ID: <CAD=FV=XJ2qOZ7ftDg70AhD0GRX6TfQb6OVyNaUfFg42+hmwxGQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231446-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C757E36BDCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Mar 31, 2026 at 7:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> > @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct devi=
ce_driver *drv, struct device
> >       if (dev->driver)
> >               return -EBUSY;
> >
> > +     /*
> > +      * In device_add(), the "struct device" gets linked into the subs=
ystem's
> > +      * list of devices and broadcast to userspace (via uevent) before=
 we're
> > +      * quite ready to probe. Those open pathways to driver probe befo=
re
> > +      * we've finished enough of device_add() to reliably support prob=
e.
> > +      * Detect this and tell other pathways to try again later. device=
_add()
> > +      * itself will also try to probe immediately after setting
> > +      * "ready_to_probe".
> > +      */
> > +     if (!dev->ready_to_probe)
> > +             return dev_err_probe(dev, -EPROBE_DEFER, "Device not read=
y_to_probe");
>
> Are we sure this dev->ready_to_probe dance does not introduce a new subtl=
e bug
> considering that ready_to_probe is within a bitfield of struct device?
>
> I.e. are we sure there are no potential concurrent modifications of other=
 fields
> in this bitfield that are not protected with the device lock?
>
> For instance, in __driver_attach() we set dev->can_match if
> driver_match_device() returns -EPROBE_DEFER without the device lock held.

Bleh. Thank you for catching this. I naively assumed the device lock
protected the bitfield, but I didn't verify that.


> This is exactly the case you want to protect against, i.e. device_add() r=
acing
> with __driver_attach().
>
> So, there is a chance that the dev->ready_to_probe change gets interleave=
d with
> a dev->can_match change.
>
> I think all this goes away if we stop using bitfields for synchronization=
; we
> should convert some of those to flags that we can modify with set_bit() a=
nd
> friends instead.

That sounds reasonable to me. Do you want me to send a v3 where I
create a new "unsigned long flags" in struct device and introduce this
as the first flag? If there are additional bitfields you want me to
convert, I can send them as additional patches in the series as long
as it's not too big of a change...

-Doug

