Return-Path: <stable+bounces-181810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BBBA5AD7
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472964A62C6
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DC2D29BF;
	Sat, 27 Sep 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFbPhmcE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CB1607AC
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962887; cv=none; b=FWQPJEp4BRXe7LppT0a5srcwfaCzsAn0s1FhXYnZQk8qG0xSH8LrR2EeUJuDQSs8/QWkKC02HqWx29BjdAr3mzwgUsRZkoHzfOz9Snfe3GzmOpkTpvp9F8pNAm51w+V8yFhSn7973L8Y+UrVF2FqXAGCPB7L1xzqK5r+rF5PRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962887; c=relaxed/simple;
	bh=W3jFT2xCuMdLstdxWfEbBiE9g9ULW4SMf/2PYW8sF0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uK91qMXD3e2grb3q0B+brnXIPxeCPYM4e5adE1H7JzMn4J9HD8iWLiQaZc1ostlqdyEHV5GQfx8Qvo92xQUqyZRz2VnQHnhmOaaa+SU+m0VHsB9CU4J1Oua7wH7OXOO5k5x8UJgV39vjCZY4ZOOjHME69atI2o4sEOXYYBpZaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFbPhmcE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so2619488a91.3
        for <stable@vger.kernel.org>; Sat, 27 Sep 2025 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758962885; x=1759567685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GTUQPP8+/5EC2O1mZ2t0mC7oS0NY7urV0HxwSW70UI=;
        b=EFbPhmcErXPM8UQyW275k9D26+VWXbmSxKKVEaVdO+dHiJNibzbB4VrBZuctCTnwk4
         3wGoVXcYXndrozrGZ3NnqsKRUKV5plnNn1uR1vxJFTfde++dWX23+QPp0d3u12I9WHXI
         4FxkGdFkJK5u1d2tHJ7doEveJ0V2b9yVgbl86zrLwR06tqc2JSynRjk3RCFGVJTx/ZOA
         em+ItWhG0QHec+jAmUpPLTuAMNGzTSHfKtjjZWzCYJOnPG86k1I8TKBkeYUYMdQ+G3RU
         hj5x1nEbttLOFgcSxWWvJXKIqXeUpCjCOf74pPNrLJ9VdXZEpcuByEf0w0fxy+gjGxGC
         In2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758962885; x=1759567685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GTUQPP8+/5EC2O1mZ2t0mC7oS0NY7urV0HxwSW70UI=;
        b=CCu32UTsSGtRD8mu0Vxg1KZWdGV69igDwMBeapXjNWuXb0n1BuMkQXY4i4TxXVws+h
         Qm2trX0L/8mcxsRyP5HUlnEO55fcJ21iCflB6PS3KxCOv6FMfqof0QjBgNgfk2X4Ng88
         J6Th9wt7f6t0gShcuSqWgArBl4UFZowJnxyME3YLIXbTfgAZkFO0wAKF3GT87rLmz/l6
         uk+gcftQFfsfh+EVPSqgNLt4Y+qJW48tgvCHks1J9eIpzddoaUc8kvAstH2dOM1FBqFW
         21aKqA/23tqSsTmOtxuPfkNpLUVzl63NPFuhG78ElV6LaWp4WIxVGg5JTxdlFICFwLqy
         0HEA==
X-Forwarded-Encrypted: i=1; AJvYcCXltet/bfB1vLEd10u8GlVBFGaySLHyTr9yNe6BHCmMWrRnC3oZV1lFSUJtpo8/JlTBH2cvd6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmkdJYyW+U/X6qFjrDMWCPfw/wNc/LpK7AQRDfik3wtJO2mGQ
	3StQlKeS5qQ+XZj/zntOjFHmINO2NUur0lt1avuNEJDCGMRKVbklRju7SYfqgDdxts8QBzmJ0BW
	Sjc87DgIUda4VNvR0hHbT5X2a6oVWi6o=
X-Gm-Gg: ASbGncupWWbpJCdTJiIYtUwbz2alcJJk8v8oePE1c2awb0zdDftzrIvoU0qf0Xs2fWg
	ITK9HS3UklYERR2otPOnnReVzpthNsOxSv339Cvf32RbjqAZDmzVI10xSOLsw4xj0EmDS0fRRtP
	T8JnEt4uFv3e0i2XpcPCrB4Fkisl/k3mjK0L7WcFaPzJrhVAisV8cctZZUN+ShqdWxiZiPf7btl
	t3GibByOc4O7ydlRbO0
X-Google-Smtp-Source: AGHT+IE8/Ky1EmR+0LJIy4YhT01cjWKhOibqsHQ53cBmr/JkwwCwaBr7tP12GcnmDWyv0cmrxLHDEEw+q8nuhwMAZu0=
X-Received: by 2002:a17:90b:4d04:b0:32e:a60d:93e2 with SMTP id
 98e67ed59e1d1-3342a260e49mr10570366a91.11.1758962885154; Sat, 27 Sep 2025
 01:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927044106.849247-1-aha310510@gmail.com> <87bjmwb9y6.wl-tiwai@suse.de>
In-Reply-To: <87bjmwb9y6.wl-tiwai@suse.de>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 27 Sep 2025 17:48:02 +0900
X-Gm-Features: AS18NWAH5mQvcVsDREbrMd7yAaCa4-5UOBVCoSMH3cnV9nAbMNh2Maxiike7hRQ
Message-ID: <CAO9qdTHSu6QmUVMo0pZj_=foz9CDtwKEYwjBx5vjj8gHzzVFNQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
To: Takashi Iwai <tiwai@suse.de>
Cc: clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 27 Sep 2025 06:41:06 +0200,
> Jeongjun Park wrote:
> >
> > The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
> > removal") patched a UAF issue caused by the error timer.
> >
> > However, because the error timer kill added in this patch occurs after the
> > endpoint delete, a race condition to UAF still occurs, albeit rarely.
> >
> > Therefore, to prevent this, the error timer must be killed before freeing
> > the heap memory.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>
> I suppose it's a fix for the recent syzbot reports?
>   https://lore.kernel.org/68d17f44.050a0220.13cd81.05b7.GAE@google.com
>   https://lore.kernel.org/68d38327.a70a0220.1b52b.02be.GAE@google.com
>

Oh, I didn't know it was already reported on syzbot.

> I had the very same fix in mind, as posted in
>   https://lore.kernel.org/87plbhn16a.wl-tiwai@suse.de
> so I'll happily apply if that's the case (and it was verified to
> work).  I'm just back from vacation and trying to catch up things.
>

Although it's difficult to disclose right now, I have already completed
writing a PoC that triggers a UAF due to the error timer in a slightly
different way than the backtrace reported to syzbot, and I have confirmed
that no bugs occur when testing this patch through this PoC.

>
> thanks,
>
> Takashi
>
> > ---
> >  sound/usb/midi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > index acb3bf92857c..8d15f1caa92b 100644
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -1522,6 +1522,8 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> >  {
> >       int i;
> >
> > +     timer_shutdown_sync(&umidi->error_timer);
> > +
> >       for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
> >               struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
> >               if (ep->out)
> > @@ -1530,7 +1532,6 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> >                       snd_usbmidi_in_endpoint_delete(ep->in);
> >       }
> >       mutex_destroy(&umidi->mutex);
> > -     timer_shutdown_sync(&umidi->error_timer);
> >       kfree(umidi);
> >  }
> >
> > --

Regards,
Jeongjun Park

