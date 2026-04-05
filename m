Return-Path: <stable+bounces-233340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CsEKLTk0mlNcAcAu9opvQ
	(envelope-from <stable+bounces-233340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 00:39:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CE3A0022
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF27A3006962
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44222DC350;
	Sun,  5 Apr 2026 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NoTQCyjE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6A146D5A
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775428785; cv=none; b=Zq1IVNG6sxOdmtpCYvzBfy2xZk2Z20cmTFSITFRRDiWcX+F0TVZVPPC9nJMkg1HZBmvvvjiWYa2AARigL86b7vfS5U+2eSFR310OlhWk9090fUVY2vbgmW3oOreHBX9IjyfzpstA1Hsv+/B8wcGCoSc7tzUjYFMn07QJi+eFmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775428785; c=relaxed/simple;
	bh=T0JVAUYSB4U6s/hgIINi+Y+L1JiMeDIr2XIwSjoMKcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdthQKHiT9SZQjpnQOGZzREuKJVZ+N+H1HRQyERHyTPT0RpItHCyhUVXvOBDPAjYZ8wXRV0f5boubLwuuEYmszYMtD4l97FSzjuRj428dMyiRDjXF1IC/ePiD/T5N4RiQwEk1py3tdWuKsxriROm0Vl3ntey36K3NtknX2DR8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NoTQCyjE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so6407842a12.2
        for <stable@vger.kernel.org>; Sun, 05 Apr 2026 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775428780; x=1776033580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s8eJ05TLahhUNspYgkZ7HDkIZCDUFKgkov6A8JZIeI=;
        b=NoTQCyjEYcHoGuKx2xoI6LxoFNMHHXRhJO2fQHnRg4yFr1BhzuRsAfvaW9UcH3evGy
         48rRtrMj6M90XgJuJleTTw5lc1fDHIo68a7wx+Ak9N3U9iRJHG1pZ778b0geMUDVzepR
         7jHOY+BI47G/iqqyBa2ro6OK/7wacGAHCU9m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775428780; x=1776033580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8s8eJ05TLahhUNspYgkZ7HDkIZCDUFKgkov6A8JZIeI=;
        b=fknKzw8yiEQoO5yn6RRY2tQjiM6bMuasHM1LGKFZ8hWuWSEqQiwq0H9l/RMU2fIcjO
         8QK4cTKguStU9+KPesYNXpBTQ4SZ9INx5AofU3DDRCBB/MRCDyw3YDVmWj/sBYtIYLht
         Ub4Nh9XZyPQlevYAkn7bqWVtYqhK7pdZ26gTBH8MJn8mCxUcVvdu/qm3q9JPnNUgrBN7
         2tAOI9kIDdQUETe44RkxMNA3yMwsKNTkWAgBGv1T5gqa5Y+eBdeJ1sAbfZnFXKk+VrXg
         zL1cuWnuLl+x4O0PyVCwtMjYl6qWwwhWvpPqf2lpJr3CfLgeuM+q+GU5PcHWTkiKjsUL
         Kecg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8rePvHub7VVIU8wDF/Gju9vUgfYy90DYmWSbIUgtutXxbtO4c5QcuYLK1P+JtQ4ZO9xjYrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvcqb8eoBvq+WBSLJIFICNhvPbqur1O86hg1J5CVuCZkesrJdF
	Dp4B4vkqTBpJrrpwBMw93VbqbUGEFBxbWtj+f+Wnjqvjs3lWLPg8gdFd+gJcsA3zo7ND3zGOU9g
	xQb2Yvg==
X-Gm-Gg: AeBDiesy8NaNWRTuClDeNy9pHoe8HHwya9Ltzc0chDa1tdKPpcdtFqUPs6uAWlfIXrX
	gNGnZVcIZCnpC5G+OZP245cbiqvIlSL3w8VMlhE7Ugu9My6ngYku98cYDezb/NjiVlcEhp9CTos
	Yr4kBgFnT5sbydpe49Bh9nkgC6iofUMknrE7HbvAw3GNoEKVYjlO+zd32yI0Di/oMTo7W1n4n9z
	tnSuo3EyW+kPGivYSQjMZuNAZbOiEVo/CCY+4mkGdMjgEoUR7Zb1VEGawqFHSA9SYwWCzjIQk2a
	CBz9WYeaktUChEEX8Yxyb0c7IaTUqBhtQbIBL0Fb+NfnmA+igtGQI8JkObZpB/SSkDXnKmmT5Z+
	QiarVbhzVjCvh/ZAPDMRJ6B4vQfpKKmZf3lt+kgmjWWOboHtVDJ7jaI0AP6uAh/PgJCxZ6EOoOu
	10gwQS73TnDwIkvEHR4WiOZQVEMp1Fvc0/6WAckXn5qtXJ5YRf4mY0cK+oc2f7qoMfi36Y1XtE
X-Received: by 2002:a05:6402:51d2:b0:66e:6f48:879c with SMTP id 4fb4d7f45d1cf-66e6f4889abmr3371798a12.5.1775428780346;
        Sun, 05 Apr 2026 15:39:40 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e1bfc789csm3062883a12.6.2026.04.05.15.39.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:39:40 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a041eae5so12304695e9.1
        for <stable@vger.kernel.org>; Sun, 05 Apr 2026 15:39:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxT9l3LvlCLA1TOgD2L5G97EnNFTSTcCcvcJQzXNA9rr56C+Rr9zA6GI57YPPa0+4sMwD4RMk=@vger.kernel.org
X-Received: by 2002:a05:600c:6085:b0:488:b239:77ec with SMTP id
 5b1f17b1804b1-488b2397962mr13831405e9.17.1775428778171; Sun, 05 Apr 2026
 15:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid> <DHLITCTY913U.J59JSQOVL0NH@kernel.org>
In-Reply-To: <DHLITCTY913U.J59JSQOVL0NH@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:39:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wgw7kU+Xse6dwjE+U06_A_tWcA93UXu6TTf0Erh+Mt8Q@mail.gmail.com>
X-Gm-Features: AQROBzDf0YIRXtcswLwNrYUqFXTDhkD4ap27KBOAGZqirfMvG0HLFLXaEuaI0tM
Message-ID: <CAD=FV=Wgw7kU+Xse6dwjE+U06_A_tWcA93UXu6TTf0Erh+Mt8Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's ready
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233340-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim]
X-Rspamd-Queue-Id: 064CE3A0022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sun, Apr 5, 2026 at 1:58=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Sat Apr 4, 2026 at 2:04 AM CEST, Douglas Anderson wrote:
> > Instead of adding another flag to the bitfields already in "struct
> > device", instead add a new "flags" field and use that. This allows us
> > to freely change the bit from different thread without holding the
> > device lock and without worrying about corrupting nearby bits.
>
> I was just about to pick up this patch series (Greg mentioned to pick it =
up next
> week, but we agreed offlist that I will pick it now, so it gets a few mor=
e
> cycles in linux-next).
>
> Due to this, taking a second glance at the code, I noticed the below issu=
e.
>
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 09b98f02f559..f07745659de3 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3688,6 +3688,19 @@ int device_add(struct device *dev)
> >               fw_devlink_link_device(dev);
> >       }
> >
> > +     /*
> > +      * The moment the device was linked into the bus's "klist_devices=
" in
> > +      * bus_add_device() then it's possible that probe could have been
> > +      * attempted in a different thread via userspace loading a driver
> > +      * matching the device. "ready_to_prove" being unset would have
> > +      * blocked those attempts. Now that all of the above initializati=
on has
> > +      * happened, unblock probe. If probe happens through another thre=
ad
> > +      * after this point but before bus_probe_device() runs then it's =
fine.
> > +      * bus_probe_device() -> device_initial_probe() -> __device_attac=
h()
> > +      * will notice (under device_lock) that the device is already bou=
nd.
> > +      */
> > +     dev_set_ready_to_probe(dev);
>
> By converting this to a bitop, we now avoid races with other bitfields (s=
uch as
> dev->can_match), but I think we still need to take the device lock for th=
is one
> specifically:
>
>         Task 0 (device_add):            Task 1 (__driver_probe_device):
>
>         dev->fwnode->dev =3D dev;
>                                         device_lock(dev);
>         device_lock(dev);                       if (dev_ready_to_probe())
>         dev_set_ready_to_probe()                        access(fwnode->de=
v);
>         device_unlock(dev);             device_unlock(dev);
>
> Otherwise, nothing prevents the above dev->fwnode->dev =3D dev assignment=
 to be
> re-ordered with dev_set_ready_to_probe() and we are back to the problem t=
he
> commit attempts to solve in the first place.

Ah, that sounds like a reasonable concern, and I agree that taking the
device_lock() here seems like the cleanest solution.


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
> > +     if (!dev_ready_to_probe(dev))
> > +             return dev_err_probe(dev, -EPROBE_DEFER, "Device not read=
y to probe\n");
> > +
> >       dev->can_match =3D true;
>
> Focused on ordering from the above, I also noticed that this ordering of
> dev_ready_to_probe() and dev->can_match =3D true is actually pretty subtl=
e and we
> should add the following comment.
>
>         /*
>          * Set can_match =3D true after calling dev_ready_to_probe(), so
>          * driver_deferred_probe_add() won't actually add the device to t=
he
>          * deferred probe list when dev_ready_to_probe() returns false.
>          *
>          * When dev_ready_to_probe() returns false, it means that device_=
add()
>          * will do another probe() attempt for us.
>          */

Sure. That seems useful for future readers.


> As it would be nice to land this for v7.1-rc1, I can apply both changes o=
n
> apply, i.e. not need to resend AFAIC.

Thanks! I'm happy to resend a new version if need be, but I'm also
happy if you want to make changes when applying.

-Doug

