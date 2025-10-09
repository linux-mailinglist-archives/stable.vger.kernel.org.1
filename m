Return-Path: <stable+bounces-183683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C5BC8C56
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34223B959C
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA872DFA3A;
	Thu,  9 Oct 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4FcU3jW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FC2DCC04
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009037; cv=none; b=rdD27NeW+1/GLwvNHkKLEmb+kCEMg65NBjEpixEaKiAbbUl/BlX7aFB/8oa0lrkIeCXk8hZnux/fYY7WgKfpS3NWAFDOD3Q6cgEHNX3h0lEV51K/9TPvZeqU/jrovNc9ZCaT+nqVRY64id69zSGRS1gDaXcw5ldgpVgTIWewlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009037; c=relaxed/simple;
	bh=M8nKHUSLyfmF/jDqaCh29GHjGeEn2rLwihqAqoSAQ1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elE3+sOAgSvSKUORj5KvdcRT6pFOBHwZvAzzMC0wMtTZQArFL1G+mHkxfyvi220OOXfw9PqoK3ltFTw5HU5tzxm7Qjm1XS2CSWcNMrwX9mZsgj1C7JoRJ2jTt//REsJMH/uT+P7tfVvJe7+79Uw56l77miJebGqJ+ndyph90oic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4FcU3jW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso823686a91.0
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760009034; x=1760613834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kliHzWy45qfkN0IzOPN+PcDRadWv7e7Kck/MfP/2C44=;
        b=W4FcU3jWi9hIPMO7TKrTCUPJTEcQWtrhQpJIpnCxru7nx5N5zEtCvZbPMbITqSUp/9
         RP4lz9yiwTXTefqmNh2Cxp3uQsjadOC3i65gcm1Q2z0wr2g1DVhPEjYdW69RGqjeE0fP
         mSnge8Q9HfW5bWH29YLP21am7ylFlvXbsYnjPavjCvL6/U2wVVk+Zw8zMW0C5D5ww5GN
         fNzyQkgBQhDKNOeKpn/sLK7c2vh1yL5TttBHQ4/ZlEUT8767MbJA4frUxnKDn/0u+6Jp
         TgtgeEyyVxIkbo73BWa6fo+Y1OhCp36lhfwQFtlUgqiu/njcsw7PxCum9eL0rj+3Hl9U
         T4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009034; x=1760613834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kliHzWy45qfkN0IzOPN+PcDRadWv7e7Kck/MfP/2C44=;
        b=DzIXl1rQy+ROXZdJZIVNP2y6xnJ3OwhDGHTicLrUhhIOTmP496b1NYZS3NFqfb3X+O
         QIA9LOsoAs4pbRKQee+pKbQraQJ+vk4rL25ajCmKzAVwKYWyUMft8RUax2SK+c4ziPXf
         lkZLyqRjOijIbEqfor7PLk30/izx9lMU0szUYcZCuVfO9VuS8pSd9X3byMWqGC2pXsti
         d4VBUC8cd9Snsg+/LDfR1v0anmud5oqKO1v/bfrKvfKFrKu53X53cJKvugwJ2Lg3lnfi
         Qpryvoz/WPjgNINbfWlprDvddwyCAPYerkgtYAK8ZpLUoZy/4WAvRUm5tkD+OE9QJlGi
         nV0w==
X-Gm-Message-State: AOJu0YxwgMQUYP/KNz8LtCj38RNgEYalfUlSD2nmCyq6iw1WT+SOrj+u
	pBfQpqXyOguzOqJmmGnlkPH31kMtGb90SKqTvBTob5dgnA/T2/B5gdM0W0byt0sSKiC2SGzEDy6
	LX63wzzwPMBmQ/g35Fv7u9KQCMkDN6+4=
X-Gm-Gg: ASbGncsqKyeuKNHnVi5hOnZYrVUY7bijd0iEWAFxekE5/LERPTVfqF667GwXTEP+Etz
	DrNecKAlmxfyYdF/R7GTF7UzXDUEHVKqgvdoQlCxG9aZ74tk0AhzqFO8UrOmS2Bb2aIxEow+a+T
	Q2vpsEWAEQkUIHGO+oWhw1toWfZty8TWuJufsLVORxxJ9w4PYl4btLWbsk6vi03ZIzaxtKxf4c/
	FUBcPBJlgLwbFQK64RZ8O/q42lCo0Om0g==
X-Google-Smtp-Source: AGHT+IE+oExOF2jNddJCJDxFn2LMWZIP7mnrCCfmT9mXjdVFldXv6CzpC9tsZJGeyRewgDpRTI6zkh6MEHvslRRbXv0=
X-Received: by 2002:a17:90b:48:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-33b51399953mr8978140a91.36.1760009034367; Thu, 09 Oct 2025
 04:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007155808.438441-1-aha310510@gmail.com> <2025100824-frolic-spout-d400@gregkh>
In-Reply-To: <2025100824-frolic-spout-d400@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 9 Oct 2025 20:23:42 +0900
X-Gm-Features: AS18NWDC7BJjcFMFyKRFdwMNKT5poJ9maKr6eXsqA75V1U9kn8oIuPnGoXIKjFI
Message-ID: <CAO9qdTEo46hCZ0UXKjjBQ4W2sLT2+5zw9DugQF98sqpHLyNzPg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio:
 Kill timer properly at removal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com, 
	Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 08, 2025 at 12:58:08AM +0900, Jeongjun Park wrote:
> > From: Takashi Iwai <tiwai@suse.de>
> >
> > [ Upstream commit 0718a78f6a9f04b88d0dc9616cc216b31c5f3cf1 ]
> >
> > The USB-audio MIDI code initializes the timer, but in a rare case, the
> > driver might be freed without the disconnect call.  This leaves the
> > timer in an active state while the assigned object is released via
> > snd_usbmidi_free(), which ends up with a kernel warning when the debug
> > configuration is enabled, as spotted by fuzzer.
> >
> > For avoiding the problem, put timer_shutdown_sync() at
> > snd_usbmidi_free(), so that the timer can be killed properly.
> > While we're at it, replace the existing timer_delete_sync() at the
> > disconnect callback with timer_shutdown_sync(), too.
> >
> > Reported-by: syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/681c70d7.050a0220.a19a9.00c6.GAE@google.com
> > Cc: <stable@vger.kernel.org>
> > Link: https://patch.msgid.link/20250519212031.14436-1-tiwai@suse.de
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > [ del_timer vs timer_delete differences ]
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  sound/usb/midi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > index a792ada18863..c3de2b137435 100644
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -1530,6 +1530,7 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> >                       snd_usbmidi_in_endpoint_delete(ep->in);
> >       }
> >       mutex_destroy(&umidi->mutex);
> > +     timer_shutdown_sync(&umidi->error_timer);
>
> This function is not in older kernel versions, you did not test this
> build :(
>
> I've applied this to 6.6.y and newer, but for 6.1.y and older, please
> use the proper function.

Sorry, I didn't realize that the timer_shutdown_sync() implementation
commit wasn't backported to versions prior to 6.2.

But why wasn't this feature backported to previous versions? I understand
that most drivers write separate patches for pre-6.2 versions that don't
implement timer_shutdown_sync() to address this type of bug.

Is there some other, unavoidable reason I'm unaware of?

>
> thanks,
>
> greg k-h

Regards,
Jeongjun Park

