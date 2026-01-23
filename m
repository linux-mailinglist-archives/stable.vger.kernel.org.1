Return-Path: <stable+bounces-211325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP/xC5ffcmntqwAAu9opvQ
	(envelope-from <stable+bounces-211325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 03:40:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F06FBC6
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 03:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C4E63002339
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5B37AA90;
	Fri, 23 Jan 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcYHUTHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0637F11D
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136016; cv=none; b=csAXrjyydrj3yIXQLXdvtwEqxKe4CsvPS1nMKUCJ8VcA/Q/uJubQ19myR/Uat+Nb/TodZbyInPQ0plIWzlgwL7EAReyeaxF9vfWZ6sGAO0ssrFp/eCZi1IRvWPcN4KudQ2bxq9SJiFm1P/r+SNfZFTljoBpynsX5XoYcF3bp+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136016; c=relaxed/simple;
	bh=ru2KxRcGrwM/ekHxvYB8KOwDZo6H32afmPxJlFGr5NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb8QHRrVYLIB8cA0uAkX8E0WZQI+mLW2pzFoDpA2Rc87jS77w23MFfODl+WKrBW1LrRG7Wv/LzGXFtyb6zeJMPiEy8GBdnYsdLavwOohCPwkyV0unFRZY04BqRwQcAUu0CofZ+R0opiKtPQ/MThpWTFKheRYPbJWgteh1OXYUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gcYHUTHI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658072a4e56so3608861a12.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769136002; x=1769740802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB8oqoUiSm9TvZ2JaN9V8DQZRGrXXFN3j/zWdKJSX60=;
        b=gcYHUTHIF5ARQsnrePaPcatRpW5hGVFvvn+6Qh5GdyzYgmZoYLeVGQMDzgS4Gdhhxe
         OlvQ5vv+eynDrIiink2H36b9wJdYvISFWENz8V7W/0DUP0lx0sYw4JDcErjqx7ejiFz5
         l5ZeAY1qytopGcGYwM9SpR0yjYAeFIxJHM/1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769136002; x=1769740802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LB8oqoUiSm9TvZ2JaN9V8DQZRGrXXFN3j/zWdKJSX60=;
        b=He+bTmWP2EOmg98mp4bnzdkA2jXt8iLhLqFhPjVHBIN7CPD7g8TuEjp8UTrweUgOmN
         f2p7F4UbACQpyXgoehb0/4PhSrwACJCfr0mR3/2oKm0Oad6CT4YGJiEpQkkS6rqoRgIZ
         l9GLrxy/PlJpiS8w+cHgUsS+FHi2UCRZQGe3vTpvJ2fxQElIPKu3vek8qMne/4YSxHym
         xbEzjoUKLIJcEaqs2nf08HWyqsaLB75Dqqc4yfYkD6T71jEnwgKulZFX53X68xFPxpEB
         1Y9kw/ja/0VIOzMWlxi0mj9XyFUlDtfN6UHhOOzX13ot93WQjX/Zy7jxbuK7lZzh7xu1
         f7qg==
X-Forwarded-Encrypted: i=1; AJvYcCXlyL0DPiAMOixEhjuYBedUhH6k7K5XvQxTZ2OF7QEtM2KtThyaQhNkqxhnSmegoPYHcDOl/1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOvrfyOhKRyePEx2/HyERZauRQrYgQI6CZuC3vVdMyTw66tk7
	Ce1AY0CdjR22iKwyj7Bwg/lilCrd87shj9Upvtbv4VjRlP9AEeYMYwrSCFmhrLf9O6bsH9Vk1Fa
	YMzIvzg==
X-Gm-Gg: AZuq6aIb1Wy/4qyJxWCSUz5vtR90XIJ6doTAHnjBAA9tySBt3cp2qz72ZokZsz3/WS3
	lFAtEGou2lHhFfv0H3LatBVtB/Gmr+8pKdVenoeVxP00XVVNuTMnLNIN5hZW9sq/VnrGPpseIOO
	ncw+CEkB0k2LzdqokpKL9uZnO2fYuQQru0GBL28qi4AM8u+VexAmn9uEv/PV3dLx01KNuRbUNO/
	ZVsDcqg5XAtHBwEZJPhKXQXcQ2YnoGvnBY6/GyhngZHakHimYRnGEiB0uTS8gguvhq3MHqiOGfV
	filJebBWAP/Oc6IErvHpvnkQwJ2qr62oKkQfpL9zjMlhtSosV8Og3VNA7U5Zw2HoXW9o2QPe0AR
	7LZGQWURa6fOY7wWnwM9WicFtklBOJliE26XtrHSh2/sJouWcgm7X5rIMdA6nSVEcL51NMt22pS
	yIF/NrAli+A4k3vD/TgUpwAE9cwxl+NmTFKaydtZjOYadjVW9G0A==
X-Received: by 2002:a17:906:6a01:b0:b73:7b97:5bfb with SMTP id a640c23a62f3a-b885ae6176fmr82535666b.33.1769136002141;
        Thu, 22 Jan 2026 18:40:02 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886048e808sm24460966b.9.2026.01.22.18.40.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:40:01 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so13595655e9.2
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:40:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXV9FujaCD7X9txfnWFFFI9wMpR43+4Wlk6yX28Em7nAfkXKipLBIhrIZQ1uUzI2p29BNOmri4=@vger.kernel.org
X-Received: by 2002:a05:600c:4fcb:b0:47e:e2b0:15b8 with SMTP id
 5b1f17b1804b1-4804c944f2dmr21986175e9.4.1769135999562; Thu, 22 Jan 2026
 18:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122042717.657231-1-realwujing@gmail.com> <20260122052442.667394-1-realwujing@gmail.com>
 <20260122135951.68ca60cf6ca3d90314306552@linux-foundation.org>
In-Reply-To: <20260122135951.68ca60cf6ca3d90314306552@linux-foundation.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 22 Jan 2026 18:39:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UGpqN3XsHWM9coRdez2mL8mz0_hsUMQttTqaD7oEvSEQ@mail.gmail.com>
X-Gm-Features: AZwV_QhyoLrjtmZawFT0pmqegq-FFydcOwVqumYedEAz2oBvSo9n9FgnD1VlPpY
Message-ID: <CAD=FV=UGpqN3XsHWM9coRdez2mL8mz0_hsUMQttTqaD7oEvSEQ@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog/hardlockup: Fix UAF in perf event cleanup due
 to migration race
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qiliang Yuan <realwujing@gmail.com>, lihuafei1@huawei.com, mingo@kernel.org, 
	linux-kernel@vger.kernel.org, sunshx@chinatelecom.cn, thorsten.blum@linux.dev, 
	wangjinchao600@gmail.com, yangyicong@hisilicon.com, yuanql9@chinatelecom.cn, 
	zhangjn11@chinatelecom.cn, stable@vger.kernel.org, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211325-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,kernel.org,vger.kernel.org,chinatelecom.cn,linux.dev,hisilicon.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C48F06FBC6
X-Rspamd-Action: no action

Hi,

On Thu, Jan 22, 2026 at 1:59=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 22 Jan 2026 00:24:42 -0500 Qiliang Yuan <realwujing@gmail.com> wr=
ote:
>
> > During the early initialization of the hardlockup detector, the
> > hardlockup_detector_perf_init() function probes for PMU hardware availa=
bility.
> > It originally used hardlockup_detector_event_create(), which interacts =
with
> > the per-cpu 'watchdog_ev' variable.
>
> Thanks.
>
> For a -stable backport it's desirable to have a Fixes: target.  But it
> appears this is very old code?
>
> Also, I'm not sure who best to ask to help review this change.  I'll
> add a few cc's here.

I'm nowhere near an expert on the perf system or the perf-specific
bits of the hardlockup detector, but I took a quick look...

I guess my first question is: why didn't the
"WARN_ON(!is_percpu_thread());" in hardlockup_detector_event_create()
hit in this case?

I guess my second question is: your new code doesn't seem to use
"fallback_wd_hw_attr" if there is an error. Is that important?

My last thought is: why not just move the "this_cpu_write(watchdog_ev,
evt)" out of hardlockup_detector_event_create() and into
watchdog_hardlockup_enable()? You can just return evt from
hardlockup_detector_event_create(), right? Then you can keep using
hardlockup_detector_event_create() and share the code...

Full disclosure: I don't know this code and I looked at it quickly. If
something I said sounds stupid, please call me out on it.


-Doug

