Return-Path: <stable+bounces-62417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ABA93EFDC
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8791F22C06
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1613B783;
	Mon, 29 Jul 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b="DU9eH44o"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816B613B293;
	Mon, 29 Jul 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241578; cv=none; b=FU9fpdLHBTsbzyy16RiDBdj7S1AmxwhIqpWaGMD+DEKN4nSZUkJi3Gl2QQCY2UUrWY8F/FNHESFV7nIoBsRJKvjyH1I2HB2/ehCQJA0OsQZtUk1RgTjpgCEPeple+lZTJBzvY+P9i7XO2u2yDQbqLGwF+VcqsHJM8f+qcXjJi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241578; c=relaxed/simple;
	bh=K7fnqw37rhxeqjvTfmqBdiz93kBqO/8jFv9TVqAzuSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9GK09BQ99swN24e+IfDVRF7xrB2K4Cdnjsh6BdjutJiqU/oCt3a9cGs9CvZ6K7sj1lA4ZfjFqrmEDCwRflIpMm03FEx4SpanaBzPo8V1U8WeMXmKdrIlk/wUJ585qeD2wUWpDj8E0bb0FI/RZw1UC1I7Bze3ePB5SlJpYjTUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io; spf=pass smtp.mailfrom=sylv.io; dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b=DU9eH44o; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sylv.io
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WXWf55JDkz9tJ5;
	Mon, 29 Jul 2024 10:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
	t=1722241565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K7fnqw37rhxeqjvTfmqBdiz93kBqO/8jFv9TVqAzuSI=;
	b=DU9eH44oPtmAdluEEyoP/E2jdGbDnTyb0fWZoUp2ydRTSvXP48q5Kogbg8Kvc+6aKF9J7G
	BAKm+xjIcnB+yj4naC11+QetJRSB/1hNVsHBa8Heew8gwYwnVTlr10gJfqL6UwoZNMwJsM
	2OQDcb5y1GGva32HzKEeph3CmwkrNFAJPdFlI6o9V/xFX8Q/0ViZvfCEsoItnWTIhGn9R/
	CFGk1Wb7gX9iQuPABQhoZKTxIUMal9D6X+u96jPpk/FLradT1yK1rFD/30IvR+6dbPJCfi
	i+cvTvKBYVWrGprU4wKelXEHSXWJxDWKP8ggMZ+YnauHcjvIin7N/oNapgM63A==
Message-ID: <baae33f5602d8bcd38b48cd6ea4617c8e17d8650.camel@sylv.io>
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
From: Marcello Sylvester Bauer <sylv@sylv.io>
To: andrey.konovalov@linux.dev, Alan Stern <stern@rowland.harvard.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>,  Aleksandr Nogikh <nogikh@google.com>, Marco Elver
 <elver@google.com>, Alexander Potapenko <glider@google.com>,
 kasan-dev@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, 
 syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Date: Mon, 29 Jul 2024 10:25:56 +0200
In-Reply-To: <20240729022316.92219-1-andrey.konovalov@linux.dev>
References: <20240729022316.92219-1-andrey.konovalov@linux.dev>
Autocrypt: addr=sylv@sylv.io; prefer-encrypt=mutual;
 keydata=mDMEX4a2/RYJKwYBBAHaRw8BAQdAgPh7hXqL35bMLhbhZbzNFhQslzLjFA/nooSPkjfwp
 1y0J01hcmNlbGxvIFN5bHZlc3RlciBCYXVlciA8c3lsdkBzeWx2LmlvPoiRBBMWCgA5AhsBBAsJCA
 cEFQoJCAUWAgMBAAIeAQIXgBYhBAzRGzXUX6FMlUr5GUv0FpMH/RIkBQJfhrn3AhkBAAoJEEv0FpM
 H/RIk+XAA/2uYBupPaP7oiwvwRjhAnO5wAZzQh8guHu3CDiLTUnXNAQDjeHY1ES/IXN6W+gVfGPFa
 rtzmGeRUQk1lSQL7SfhwCbQvTWFyY2VsbG8gU3lsdmVzdGVyIEJhdWVyIDxtZUBtYXJjZWxsb2Jhd
 WVyLmNvbT6IjgQTFgoANhYhBAzRGzXUX6FMlUr5GUv0FpMH/RIkBQJfhrlYAhsBBAsJCAcEFQoJCA
 UWAgMBAAIeAQIXgAAKCRBL9BaTB/0SJOHbAQCp2E6WRbY3U7nxxfEt8lOq3pCi0VeUAWu93CnWZX0
 X9wEArZ6h9wCGHhlGBTaB/U7BRHlgftCcEuxeCuMZEa8rqwC0MU1hcmNlbGxvIFN5bHZlc3RlciBC
 YXVlciA8aW5mb0BtYXJjZWxsb2JhdWVyLmNvbT6IjgQTFgoANhYhBAzRGzXUX6FMlUr5GUv0FpMH/
 RIkBQJfhrmFAhsBBAsJCAcEFQoJCAUWAgMBAAIeAQIXgAAKCRBL9BaTB/0SJLF/AQDwn+Oiv2Zf2o
 ZxGttQl/oQNR3YJZuGt8k+JTSWS98xxwEAiBULaSCQ4JaVq5VdOXwb0tPsfQuYbBQjbAK9WI3QmwM=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LWyd7UgxwvTeqjduYLti"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4WXWf55JDkz9tJ5


--=-LWyd7UgxwvTeqjduYLti
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Mon, 2024-07-29 at 04:23 +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
>=20
> Commit a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer
> transfer
> scheduler") switched dummy_hcd to use hrtimer and made the timer's
> callback be executed in the hardirq context.
>=20
> With that change, __usb_hcd_giveback_urb now gets executed in the
> hardirq
> context, which causes problems for KCOV and KMSAN.
>=20
> One problem is that KCOV now is unable to collect coverage from
> the USB code that gets executed from the dummy_hcd's timer callback,
> as KCOV cannot collect coverage in the hardirq context.
>=20
> Another problem is that the dummy_hcd hrtimer might get triggered in
> the
> middle of a softirq with KCOV remote coverage collection enabled, and
> that
> causes a WARNING in KCOV, as reported by syzbot. (I sent a separate
> patch
> to shut down this WARNING, but that doesn't fix the other two
> issues.)
>=20
> Finally, KMSAN appears to ignore tracking memory copying operations
> that happen in the hardirq context, which causes false positive
> kernel-infoleaks, as reported by syzbot.
>=20
> Change the hrtimer in dummy_hcd to execute the callback in the
> softirq
> context.
>=20
> Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2388cdaeb6b10f0c13ac
> Reported-by: syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D17ca2339e34a1d863aad
> Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer
> transfer scheduler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>=20
> ---
>=20
> Marcello, would this change be acceptable for your use case?

Thanks for investigating and finding the cause of this problem. I have
already submitted an identical patch to change the hrtimer to softirq:
https://lkml.org/lkml/2024/6/26/969

However, your commit messages contain more useful information about the
problem at hand. So I'm happy to drop my patch in favor of yours.

Btw, the same problem has also been reported by the intel kernel test
robot. So we should add additional tags to mark this patch as the fix.


Reported-by: kernel test robot <oliver.sang@intel.com>
Closes:
https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com
Acked-by: Marcello Sylvester Bauer <sylv@sylv.io>

Thanks,
Marcello

> If we wanted to keep the hardirq hrtimer, we would need teach KCOV to
> collect coverage in the hardirq context (or disable it, which would
> be
> unfortunate) and also fix whatever is wrong with KMSAN, but all that
> requires some work.
> ---
> =C2=A0drivers/usb/gadget/udc/dummy_hcd.c | 14 ++++++++------
> =C2=A01 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c
> b/drivers/usb/gadget/udc/dummy_hcd.c
> index f37b0d8386c1a..ff7bee78bcc49 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -1304,7 +1304,8 @@ static int dummy_urb_enqueue(
> =C2=A0
> =C2=A0 /* kick the scheduler, it'll do the rest */
> =C2=A0 if (!hrtimer_active(&dum_hcd->timer))
> - hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
> HRTIMER_MODE_REL);
> + hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
> + HRTIMER_MODE_REL_SOFT);
> =C2=A0
> =C2=A0 done:
> =C2=A0 spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
> @@ -1325,7 +1326,7 @@ static int dummy_urb_dequeue(struct usb_hcd
> *hcd, struct urb *urb, int status)
> =C2=A0 rc =3D usb_hcd_check_unlink_urb(hcd, urb, status);
> =C2=A0 if (!rc && dum_hcd->rh_state !=3D DUMMY_RH_RUNNING &&
> =C2=A0 !list_empty(&dum_hcd->urbp_list))
> - hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
> + hrtimer_start(&dum_hcd->timer, ns_to_ktime(0),
> HRTIMER_MODE_REL_SOFT);
> =C2=A0
> =C2=A0 spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
> =C2=A0 return rc;
> @@ -1995,7 +1996,8 @@ static enum hrtimer_restart dummy_timer(struct
> hrtimer *t)
> =C2=A0 dum_hcd->udev =3D NULL;
> =C2=A0 } else if (dum_hcd->rh_state =3D=3D DUMMY_RH_RUNNING) {
> =C2=A0 /* want a 1 msec delay here */
> - hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
> HRTIMER_MODE_REL);
> + hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
> + HRTIMER_MODE_REL_SOFT);
> =C2=A0 }
> =C2=A0
> =C2=A0 spin_unlock_irqrestore(&dum->lock, flags);
> @@ -2389,7 +2391,7 @@ static int dummy_bus_resume(struct usb_hcd
> *hcd)
> =C2=A0 dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
> =C2=A0 set_link_state(dum_hcd);
> =C2=A0 if (!list_empty(&dum_hcd->urbp_list))
> - hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
> + hrtimer_start(&dum_hcd->timer, ns_to_ktime(0),
> HRTIMER_MODE_REL_SOFT);
> =C2=A0 hcd->state =3D HC_STATE_RUNNING;
> =C2=A0 }
> =C2=A0 spin_unlock_irq(&dum_hcd->dum->lock);
> @@ -2467,7 +2469,7 @@ static DEVICE_ATTR_RO(urbs);
> =C2=A0
> =C2=A0static int dummy_start_ss(struct dummy_hcd *dum_hcd)
> =C2=A0{
> - hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> + hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL_SOFT);
> =C2=A0 dum_hcd->timer.function =3D dummy_timer;
> =C2=A0 dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
> =C2=A0 dum_hcd->stream_en_ep =3D 0;
> @@ -2497,7 +2499,7 @@ static int dummy_start(struct usb_hcd *hcd)
> =C2=A0 return dummy_start_ss(dum_hcd);
> =C2=A0
> =C2=A0 spin_lock_init(&dum_hcd->dum->lock);
> - hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> + hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL_SOFT);
> =C2=A0 dum_hcd->timer.function =3D dummy_timer;
> =C2=A0 dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
> =C2=A0


--=-LWyd7UgxwvTeqjduYLti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQR81eCeIFvseLvKEUNWslSZtA36GQUCZqdSFA0cc3lsdkBzeWx2
LmlvAAoJEFayVJm0DfoZT9wA/0cbEIRrGeccZCTVN5CQK6Nx31rSKXTIDsobIdO0
9cG/AQDGFJq2QwpbDTAe4HN2gmybrc3qqnu5zQ/qym81WTu1BA==
=hqtW
-----END PGP SIGNATURE-----

--=-LWyd7UgxwvTeqjduYLti--

