Return-Path: <stable+bounces-245322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLOqBB1MAmpaqQEAu9opvQ
	(envelope-from <stable+bounces-245322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:37:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB351659E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A01E33007503
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45B4D90D2;
	Mon, 11 May 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lxPVL1Cz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B984D90BD
	for <stable@vger.kernel.org>; Mon, 11 May 2026 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535450; cv=none; b=eeZZQRl+nepEwCuduAD4jpUtYcW28jTXrSkdv0XOmEu706W5cWIXrKuhHB/iO2s8RLT47XvkdM5kGT6m5irH+jV/mGTffZqOZdNmnIF/k74fp6/dmGW2kJKYhoUAYPKbzC6JnHnvJWQDn4QGcaNtp2zKHSyks5tEA/s2BxyaHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535450; c=relaxed/simple;
	bh=A3MJypCEqW61QXNqmA+FMxYPBjIm/S7t+aAdvmTTzZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niIHd+dWSevqzfSLXMwapy/qY46uJMQFRsXveBnBw0h3nGFkySHT4WB9LazAFSJAKbf/eH5Mxx1jM20bewHVpn+YYkyd5WJsH+OySK9/jrGr3PWr62nMT5sql1dWUH6kjlkxNWKoDsONAz8w8ywnn06Lc/cYutQp+I/89fnGjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lxPVL1Cz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bce57c132b2so263772066b.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778535446; x=1779140246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLoelSKoan22JmqYjfWJMk8ZdX9uFP9e2dwS6RmeLfQ=;
        b=lxPVL1CzEAmmsmZZV+CzLNQfn3pE79l+DBGPxriqAr4K8p2O5MJPIRj/5ouZ2uOOJf
         p34I3ZrZVzGAbuMPqhzRE63RHgrQbB7s2IrL9IDOJdn5KMUsVkjxN9BDKUea9rgGynko
         lX61AYlZ5S7SxkBxN7sRJ7qnwL01U4mnVJyn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535446; x=1779140246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLoelSKoan22JmqYjfWJMk8ZdX9uFP9e2dwS6RmeLfQ=;
        b=rS+wK4XRJJEjpsxl8sTPX0E8SqpEeWRCog15aZBhWzhvwaZTRXcEI1olGnBBlKI6Il
         LMTgL2qpjnxOuOkp4mkPexLrXWc7YyxkH20JO9XO16+SrLfqhPBS/tbYHGIZjXGAHWnl
         yCe26cuUlNj6EBnx5J2gkOZLbCjaJ3dv+9hXzpcl3WFYO1z1e6Tnf4juWNa5arMmvjJf
         7wr2HAYJeFjuhuZAFpjatq7/bU9B8sXb0COdygr5b/0dX7kWTRZVOEwqFkPoyDrR4hbN
         Q3wrDT/sTjiA8o20bQRvngE1VHgVIYVK/sZm8kt1qUXxX7XrjqGT9u6QcHojySN2Xcqp
         OmZg==
X-Forwarded-Encrypted: i=1; AFNElJ+NysuMmS/oPDNbv0ppgBht3YTmJKBviU5Ppk+sOkh7YuEDM6b3FB4ABbMb81gaYAWN+yBobhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6c1Cyk06kcQl9TaFpr3RKFSizCxEi4KFSH/NoYBSWhllwqxT
	qr5Lb5ESBTo21fkFfJfVD4mjfZQ86eSWm73m4JxWW/SNm4BarlOQfzCyixxqTyhdrBibLYWluHk
	vMGs=
X-Gm-Gg: Acq92OFaVCvl9mL9AKVzYDcGq9asi44RJD39LGW3GzX6z9QfnmImPE9snD56q8isbSF
	0izV7CeHeij7YLj1r3Ki2cQT0E/QwtqkfsyC3fDWsEd9359Wpla7WiZmemJ+yw1UtlUdvVfOphk
	JibBS0UTZ3DuplugudPuGyXg/1qA48H0ys32YzsqMickGpNpTobvGxhXN3d3XdOkNFqEqe8Qg2A
	ga1MP04jBpH9fTCR/vX6F7F/IztxH4Up62E+lA+Z2g5brVz5YUkRWCnVURaBYf2kpxEWO+hmmiq
	z0hbLrXK5NYGdVnmp3G1K9Btcah36cC/0GhFDTcDcBJEZpP6WQOihOyxLkX7HJUHavVeVZ1n2qr
	lgz+pDqf+DKIff4fhpYxutv2jKnpj/LLK2l//jrcdhRHJXafdmSnFpSg1YC9vEhEqaM0bH8/7E1
	rIrUqD77DvDYCRlZ+RFSbvFKdBNC4SiWDjXEs0Sd/y5mzJlCpU2+Px85NogCv0
X-Received: by 2002:a17:907:5ca:b0:bc1:1808:7fe1 with SMTP id a640c23a62f3a-bd23be009ebmr78902166b.21.1778535446301;
        Mon, 11 May 2026 14:37:26 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bce33b0071csm305926666b.51.2026.05.11.14.37.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 14:37:24 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso10440328a12.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 14:37:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8HXndjkeLr6TWiqKWIjsTCydTjeKaGIheEcCfbK8Q/D0ejJ/qq/SthMBPvq4prlkHPAeUkudQ=@vger.kernel.org
X-Received: by 2002:a17:906:6a1c:b0:bd0:6293:bd0d with SMTP id
 a640c23a62f3a-bd23ae147d3mr75481766b.7.1778535443392; Mon, 11 May 2026
 14:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
 <20260323-uvc-hwtimestamp-v1-4-aa42e3865204@chromium.org> <10a08462-30ce-4a79-bb5d-001ab7f3d0d8@kernel.org>
 <CANiDSCs9gby6bNBCRmxT15D8c-nksdUmwH8iUDAsiV1tmQTM3Q@mail.gmail.com> <2edd1e71-d345-4c91-92f0-15d39299f0b9@kernel.org>
In-Reply-To: <2edd1e71-d345-4c91-92f0-15d39299f0b9@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 11 May 2026 23:36:57 +0200
X-Gmail-Original-Message-ID: <CANiDSCsoRP9vzKHPN3arKX1OZ-dyyTxgsfMC9Xxp8kE6+UStAQ@mail.gmail.com>
X-Gm-Features: AVHnY4KLsR7QkcvaLV23mSwAoBpguXDr49sx5Ko_0bX2dba0T-pPbP8RgjI8tuo
Message-ID: <CANiDSCsoRP9vzKHPN3arKX1OZ-dyyTxgsfMC9Xxp8kE6+UStAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: uvcvideo: Do not add clock samples with small
 sof delta
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yunke Cao <yunkec@google.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A7AB351659E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245322-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Hans

(Hi Laurent :P)



On Mon, 11 May 2026 at 20:33, Hans de Goede <hansg@kernel.org> wrote:
>
> Hi,
>
> On 11-May-26 18:50, Ricardo Ribalda wrote:
> > Hi Hans
> >
> > On Mon, 11 May 2026 at 18:07, Hans de Goede <hansg@kernel.org> wrote:
> >>
> >> Hi,
> >>
> >> On 23-Mar-26 14:10, Ricardo Ribalda wrote:
> >>> Some UVC 1.1 cameras running in fast isochronous mode tend to spam the
> >>> USB host with a lot of empty packets. These packets contain clock
> >>> information and are added to the clock buffer but do not add any
> >>> accuracy to the calculation. In fact, it is quite the opposite, in our
> >>> calculations, only the first and the last timestamp is used, and we only
> >>> have 32 slots.
> >>>
> >>> Ignore the samples that will produce less than MIN_HW_TIMESTAMP_DIFF
> >>> data.
> >>>
> >>> Fixes: 141270bd95d4 ("media: uvcvideo: Refactor clock circular buffer")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>> ---
> >>>  drivers/media/usb/uvc/uvc_video.c | 18 ++++++++++++++++--
> >>>  1 file changed, 16 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> >>> index dcbc0941ffe6..e1a4e84d6841 100644
> >>> --- a/drivers/media/usb/uvc/uvc_video.c
> >>> +++ b/drivers/media/usb/uvc/uvc_video.c
> >>> @@ -544,6 +544,19 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> >>>       spin_unlock_irqrestore(&clock->lock, flags);
> >>>  }
> >>>
> >>> +static inline u16 sof_diff(u16 a, u16 b)
> >>> +{
> >>> +     u32 aux;
> >>> +
> >>> +     a &= 2047;
> >>> +     b &= 2047;
> >>> +     if (a >= b)
> >>> +             return a - b;
> >>> +
> >>> +     aux = a + 2048;
> >>> +     return (u16)(aux - b);
> >>> +}
> >>> +
> >>>  static void
> >>>  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >>>                      const u8 *data, int len)
> >>> @@ -664,12 +677,13 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >>>       sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
> >>>
> >>>       /*
> >>> -      * To limit the amount of data, drop SCRs with an SOF identical to the
> >>> +      * To limit the amount of data, drop SCRs with an SOF similar to the
> >>>        * previous one. This filtering is also needed to support UVC 1.5, where
> >>>        * all the data packets of the same frame contains the same SOF. In that
> >>>        * case only the first one will match the host_sof.
> >>>        */
> >>> -     if (sample.dev_sof == stream->clock.last_sof)
> >>> +     if (sof_diff(sample.dev_sof, stream->clock.last_sof) <=
> >>> +         (MIN_HW_TIMESTAMP_DIFF / stream->clock.size))
> >>>               return;
> >>
> >> If I understand things correctly then uvc_video_clock_update() uses
> >> first->host_time + some correction time. But you might end up not
> >> storing a sample for the very first isochronous USB packet of a frame
> >> because of this new check.  Which means that the first->host_time used
> >> as a starting point for the timestamp just has become inaccurate ?
> >
> > In UVC 1.5 All the ISOC packets have the same dev_sof and dev_stc.
> > So this check will avoid adding a whole frame into the timestamp
> > circular buffer when running at more than 320 Hz (1/(0.1/32))
> >
> > In UVC 1.1 all ISOC packets have the same dev_stc but different dev_sof.
> > This check will avoid adding some of those packets into the circular
> > buffer, but the accuracy will not be lost. We will use the data from
> > the neighbour packets (even from previous frames) to recover the sof.
> >
> > The biggest winner for this patch is UVC 1.1, which will have much
> > more accurate timestamps, because the distance between the first and
> > last will be bigger (as in uvc1.5)
>
> I'm still trying to wrap my head about the whole concept of the hw
> timestamps TBH.
>
> Upon reading it a couple of times I now see that when exactly we
> take samples is not important because the actual frame time in
> STC units is stored in buf->pts and that is supposed to be our
> starting point. And the rest is just used to calculate
> a factor + offset.
>
> At least that is what the big comment says but I'm confused by
> the code which is supposed to implement:
>
>  * SOF = (SOF2 - SOF1) / (STC2 - STC1) * PTS
>  *     + (SOF1 * STC2 - SOF2 * STC1) / (STC2 - STC1)
>  *
>  * or
>  *
>  * SOF = ((SOF2 - SOF1) * PTS + SOF1 * STC2 - SOF2 * STC1) / (STC2 - STC1)   (1)
>
> I think that the code tries to implement the second formula:
>
> We've (with some checks removed):
>
>         /* First step, PTS to SOF conversion. */
>         delta_stc = buf->pts - (1UL << 31);
>         x1 = first->dev_stc - delta_stc;
>         x2 = last->dev_stc - delta_stc;
>
>         y1 = (first->dev_sof + 2048) << 16;
>         y2 = (last->dev_sof + 2048) << 16;
>         if (y2 < y1)
>                 y2 += 2048 << 16;
>
>         y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
>           - (u64)y2 * (u64)x1;
>         y = div_u64(y, x2 - x1);
>
>         sof = y;
>
> Simplifying this by removing all the range-shifting
> and using sof1/sof2 instead of y1/y2 like in the comment
> we end up with:
>
>         x1 = first->dev_stc - buf->pts;
>         x2 = last->dev_stc - buf->pts;
>
>         sof1 = first->dev_sof;
>         sof2 = last->dev_sof
>
>         sof = ((sof2 - sof1) + sof1 * x2 - sof2 * x1) / (x2 - x1)
>
> Now substitute stc1/stc2 for first->dev_stc / last->dev_stc
> and just pts for buf->pts and expand x1 + x2 we get:
>
>         sof = ((sof2 - sof1) + sof1 * (stc2 - pts) - sof2 * (stc1 - pts)) /
>               ((stc2 - pts) - (stc1 - pts))



I think this is where your explanation goes slightly off:

x2 is actually stc2 - pts + (1UL << 31), and x1 is stc1 - pts + (1UL << 31).

Before you scream at me, look at the end of the mail! :P


>
> We can simplify the divisor here by getting rid of the pts bit
> since the 2 "- pts" parts negate each other:
>
>         sof = ((sof2 - sof1) + sof1 * (stc2 - pts) - sof2 * (stc1 - pts)) /
>               (stc2 - stc1)
>
> Now lets get rid of the () from expanding x1 / x2:
>
>         sof = ((sof2 - sof1) + sof1 * stc2 - sof1 * pts - sof2 * stc1 + sof2 * pts)) /
>               (stc2 - stc1)
>
> Shuffle bringing " * pts" parts to the front:
>
>         sof = (sof2 * pts - sof1 * pts + (sof2 - sof1) + sof1 * stc2 - sof2 * stc1)) /
>               (stc2 - stc1)
>
> Simplify:
>
>         sof = ((sof2 - sof1) * pts + (sof2 - sof1) + sof1 * stc2 - sof2 * stc1) /
>               (stc2 - stc1)
>
> Looks a lot like the comment except there is a + (sof2 - sof1) too much
> in there ?
>
> And some of the range shifting also feels wrong. As long as we're only
> subtracting the range shifting is fine. But as soon as we start multiplying
> variables in different shifted ranges the end result actually changes.
>
> Especially weird here is that we range-shift by (1UL << 31) for calculating
> delta_stc and then *multiply* (y2 - y1) by (1ULL << 31) I guess this is
> to compensate for the (1ULL << 31) component of x1/x2 but the first->dev_stc
> and pts parts of x1 where never multiplied by (1ULL << 31) so these
> are still in their original *scale*. Either we should multiply all
> parts to go to some other fixed scale and the sof value are both range-shifted
> by 2048 as well as multiplied by 65536, which also seems wrong to me as
> soon as we do sof1 * stc2 or sof2 * stc1
>
> All in all this all feels like there are some issues lurking here and it
> does not seem to match the comment at the top.
>
> Regards,
>
> Hans
>
>
>

Lets go back to the beggining:

SOF = ((SOF2 - SOF1) * PTS + SOF1 * STC2 - SOF2 * STC1) / (STC2 - STC1)

This is the formula for a straight line when you know two points. The
names are super ugly, lets use something we are more used to:

y = ((y2 - y1) * x + y1 * x2 - y2 * x1) / (x2 - x1) ;

Ok. how would this look if we want x to be exactly at (1 << 31) to
prevent unsigned underflow? ?

we just have to move things around:

delta = x - (1<<31);

new_x1 = x1 - delta = x1 - x + (1<<31)
new_x2 = x2 - delta = x2 - x + (1<<31)

We plug this in the formula and:

y = ((y2-y1) * (1 <<31) + y1 * new_x2 - y2*new_x1) /(new_x2-new_x1);
Which is exactly what we have.


Now lets look at the scaling:

         delta_stc = buf->pts - (1UL << 31);
         x1 = first->dev_stc - delta_stc;
         x2 = last->dev_stc - delta_stc;

X1 and X2 are NOT scaled

         y1 = (first->dev_sof + 2048) << 16;
         y2 = (last->dev_sof + 2048) << 16;
         if (y2 < y1)
                 y2 += 2048 << 16;

Y1 and Y2 is scaled 16 (ignore the +2048, the variable is mod(2048))

         y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
           - (u64)y2 * (u64)x1;
         y = div_u64(y, x2 - x1);

y = (SCALE16 - SCALE16)*K + SCALE16*SCALE1 - SCALE16*SCALE1; => Result
is SCALE16
y = div64(SCALE16, SCALE1) => Result is SCALE16

So it looks good to me. It is a painful code, but I think it is correct.

(Painful, but I would probably fail to do it better :P)

Regards



-- 
Ricardo Ribalda

