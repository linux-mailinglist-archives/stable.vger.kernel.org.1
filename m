Return-Path: <stable+bounces-233384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBu6AVrG02mqlgcAu9opvQ
	(envelope-from <stable+bounces-233384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:42:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B33A44C9
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32C323020861
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A113845B4;
	Mon,  6 Apr 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RLz4ISqH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF43859F8
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486491; cv=none; b=oaqJ7hd3LcUyvyC66YYKPIZVwT2ekGwwuAbAMectRpgcT1Lx50jOeCihEor6mdIGi9SzNtt6i4RzYXvZOyUz1+1kMc8/v6KLsmeiXe7ITvtDxAtM7IVUk3ux5I76vL6+nYXNXk40wpwkuDjk0T1F4Hujo5aXUqi6C8/RU5esoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486491; c=relaxed/simple;
	bh=7oNzeFfYFgQWoRDQJKiCyaff80r1S13ZgndAkYlmils=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ep05Zu1914eY7GcFVDCDMLRMJTSumUF7Qs1K4r0cY3jra4uMAavYuJGF4DRDKo6tO7RGLc1DHjlru/HrErCBZEl7/dv59N1bqEDprEH1krHP0ev8iQmJo4kK7H1JnjoLL5Pk1PJqmX6OA5frvgShYIsELTktCcyCydOpP9dcnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RLz4ISqH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f9568e074so660237966b.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775486483; x=1776091283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgzwoDGM2saCO6xG8KTBFI42La8jnMppIEczXuZm8oI=;
        b=RLz4ISqHlQNq0E6iELgaEg+r2gmODPrtpvAR9jmvjVN4liJOs0wCX8iXjAGnEpCbez
         wp/4OrH+NyilOY3YM0Ec3Kau5nc6nypEfaWZuVBIVkIlmOQur97W5ZDR7Az5pfIkNLJr
         OhFT7aavdbiep81F3E847Z4rzV5UnpQyPhGVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486483; x=1776091283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgzwoDGM2saCO6xG8KTBFI42La8jnMppIEczXuZm8oI=;
        b=cUeDAZ4/lg9cQqQy43/VgG4ZmNUfglTgEC7dh2JO6k8OhdBiOR57lZRWGLKebGsmXo
         fbmGp0A+27tQ0bChuLvcWltVkAiNd4BqEt5cIzO8V6+l7/T9hMWbhbX7Y/QodhSlHajK
         liq0nB6aeeO8WYVrHfmmVaLZ7ceUXyKpsR3lSRRr4LjATXi9sY/omylIZIKXhLIzDBgk
         ecxyFyx057l54nVrMPnjeI77ZgQvQB6yhWnzA4lnjwCQ7nno+IOmrMzey+DUemVEavCG
         +bLKcAJGg9rV2ILEVMVDvherl3+GjZ9/mWAJ3UQYIa2/58XnwIuaBuS3mScKlx/nG4EL
         Kh4w==
X-Forwarded-Encrypted: i=1; AJvYcCVDw6hjf2Ow4HYV3kAJhIswAd50hq48J/H09/dCBAji/qoKgtaJIhyZ2GuHZ12MxfgGLETcpQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3d5CPv7R3kQSTcYGYn3BrVyExwmvxtaNodkLKKACsBW6ulICW
	EWMTBkH6+VYa7f4BfjOC5E3jeR4FndhEemwpu2yk99ZRADR78hWrLgRyg7sKMliYJA/fOuhewfb
	J0cM+v9bW
X-Gm-Gg: AeBDieu4rDP5X1L9U1YV9dtmFye2StfpH6CzLOdnO3tdjM2ecAA5rZhV9ucWh34zEQ3
	OT6SyY5F6faLJb6jxRRpqkz0vz1zpkdpTN/ObXW0hODml11u+0L6l+ELNplbn7HZU5gSV3D8M4f
	62hM5WpdfO43JZeeKfS5P+d/GenzPmPK3CKZ5lZTgz2SRX67YYG2/AWHXxrEKZE8ZImls6wz/FZ
	9zoC5BTHT9cipz/9tdhZx5hdsjte5rxwzl7/Q0qSM53+VZw4aBVpXybhYaOKREVLIHCeqI26uZv
	oS/QBMQo+VxdAfO5LZF73X6cSjpqemQI262CCA3Innuk27sFXhclYl7zx6ZoQaBLwVyjAf7AtfZ
	ZvKPMmIB8sTdQ3esL31QKFCTA9eK+52yEFAR2Jcq+G8WRRWfZO2Y8TM7hsVYB/f2NJ++A5y8QQB
	Az4n8P349lzYtA6wiQRJQ+f/s+PV0Q8tgiq5Wk015BaEJDiWkPNuBIgYyVALhQkw==
X-Received: by 2002:a17:907:198d:b0:b9c:d04:e05f with SMTP id a640c23a62f3a-b9c67978f92mr677921666b.32.1775486483211;
        Mon, 06 Apr 2026 07:41:23 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff128bsm473032166b.53.2026.04.06.07.41.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 07:41:22 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfb723793so2495423f8f.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 07:41:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdIy2CqsQKd40Fgrwk5XVtzVRglKB5D61eb3sR5rvi3nKGjVe/hxaZ7RDAjTWqQG6GjMAzTEM=@vger.kernel.org
X-Received: by 2002:adf:f10e:0:b0:43d:2ffc:4794 with SMTP id
 ffacd0b85a97d-43d2ffc47fdmr11005477f8f.0.1775486480662; Mon, 06 Apr 2026
 07:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid> <873418d2fz.wl-maz@kernel.org>
In-Reply-To: <873418d2fz.wl-maz@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Apr 2026 07:41:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
X-Gm-Features: AQROBzD_yK60R7hoa5tSGTXqMdhnXFgJKJJYeHosMoKRuVf_v6EpbCc2RzT9xS4
Message-ID: <CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233384-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 6E4B33A44C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sun, Apr 5, 2026 at 11:32=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
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
> I think this lacks some ordering properties that we should be allowed
> to rely on. In this case, the 'ready_to_probe' flag being set should
> that all of the data structures are observable by another CPU.
>
> Unfortunately, this doesn't seem to be the case, see below.

I agree. I think Danilo was proposing fixing this by just doing:

device_lock(dev);
dev_set_ready_to_probe(dev);
device_unlock(dev);

While that's a bit of an overkill, it also works I think. Do folks
have a preference for what they'd like to see in v5?


> > @@ -675,8 +691,34 @@ struct device {
> >  #ifdef CONFIG_IOMMU_DMA
> >       bool                    dma_iommu:1;
> >  #endif
> > +
> > +     DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
> >  };
> >
> > +#define __create_dev_flag_accessors(accessor_name, flag_name) \
> > +static inline bool dev_##accessor_name(const struct device *dev) \
> > +{ \
> > +     return test_bit(flag_name, dev->flags); \
> > +} \
> > +static inline void dev_set_##accessor_name(struct device *dev) \
> > +{ \
> > +     set_bit(flag_name, dev->flags); \
>
> Atomic operations that are not RMW or that do not return a value are
> unordered (see Documentation/atomic_bitops.txt). This implies that
> observing the flag being set from another CPU does not guarantee that
> the previous stores in program order are observed.
>
> For that guarantee to hold, you'd need to have an
> smp_mb__before_atomic() just before set_bit(), giving it release
> semantics. This is equally valid for the test, clear and assign
> variants.
>
> I doubt this issue is visible on a busy system (which would be the
> case at boot time), but I thought I'd mention it anyway.

Are you suggesting I add smp memory barriers directly in all the
accessors? ...or just that clients of these functions should use
memory barriers as appropriate?

In other words, would I do:

smp_mb__before_atomic();
dev_set_ready_to_probe(dev);

...or add the barrier into all of the accessor?

My thought was to not add the barrier into the accessors since at
least one of the accessors talks about being run from a hot path
(dma_reset_need_sync()). ...but I just want to make sure.

-Doug

