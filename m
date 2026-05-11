Return-Path: <stable+bounces-245295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MODwFy0VAmr+ngEAu9opvQ
	(envelope-from <stable+bounces-245295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:43:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE038513A9E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52B130A1287
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D142EEDF;
	Mon, 11 May 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cwTmoJA3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B33D647A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518222; cv=none; b=TIBeuzr5niCfY+pIVK+BLRtFEhBBN/2gB5pDuT3csHypTyiSU5YceMdGJFf6qNkLc2C+fUMEkMK1ZfaTprJ5DY8zxYov6odSMoflVbbm8IJo2yI85hXT+HEv39McQGXWDzUnk1ZSmxpWevFJnoyDXX/HvH+5zXPSpDZEZEzDoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518222; c=relaxed/simple;
	bh=3ddHCI/u6AMzCPiKrNEM/VNWHhoOwc6c1h5VWFgOqig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7oQuTfkaDbEGO7s4Z3xeaKI0nh3hNcIwdvbwXrqPeQVgoIDzwpPYIw+7cZn3SekHODso544u1E1BevsErinVsR0Ix6/my9KTBIspniFh4by8H4rEtdRNo7+M1HFDUs9Y3FT25hRpWgHCnN+CpKkYWer+KdJMmRYIqgeJEN5A9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cwTmoJA3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so814930666b.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778518219; x=1779123019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pyc2irlV4hpTozzdn4QAIYkKHdvExB4pAKBzqwiHQiY=;
        b=cwTmoJA3d/+psOsBsCkW7T/Xbets/AL5b/UABqEcs0e2QXQBiqeGNDs1PdAEEmxJkC
         YpJNGapd2iAB7yfDm/4FB9OaqQZQ//aryHxbejLYZIiBOBKobp/Xi6SSnN+lA0cKJraL
         eF6uZj9bET+/x6tdUhkySUSoZBCuMO6ID+Gzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518219; x=1779123019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyc2irlV4hpTozzdn4QAIYkKHdvExB4pAKBzqwiHQiY=;
        b=jD4J6sHP5bKri8whJU5QsxQ4rzr3Or/c0P7gBodN6Y2+zNU9zy5m0xApHXw0CPnT2H
         7qeBIZMsAEO54rzBDxdLVUdfkUD0p+2/8IqTYvOgWOSMztHgCzLRITmSSvST3sIAh7GJ
         pTeyyFtfkBG+PLXJ4PagtacXBE7D+U9MCrCh8V4KLYW720UHZlx0AvC8s3KapLc+BC8A
         eishwgF1X/atwdvosbjVoT4AefLu/Vwr/EI7w7+CVSiy/RwEd7iML1CHSVrlrav51lgo
         VdPDtZWwhHwlis7UVYAdVRuDIRnuCU8/baJ0N33N9xfr4BMk32ALvS1MwiCiPMAKX56N
         vt0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+HIjpSmbThkbcxsZbb3bGgUGK/I0z4ZtIJ6gitJihv/A5bGXyH9DFvdE3wiXZJr3xd3gnJ18U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ya5aT2ZsfP0tpV5Pt6q9OLrGnhZlOV0yDa5wqVBr8P6wOiZG
	0WcqswO4Eu2A4OBG7gv0m3QL4+jboUkjyFoj0SIfsbPY6C/QZLsVqaEP/p2OtlDvvhsPXwtTAM0
	ZFo8=
X-Gm-Gg: Acq92OFvW2CpkKhSvWU+ab4X2ofM1HaD6Nwj6RlJ+I0+UoxhBBkcHjDhAbAUEJaYt6B
	V18MCBzA3pVDrOdqZjdJjlukcdJw1lOHtLR2htXwqp1l+PnJwqxR5sjoFX7CuLhWtoYIRhd2RJt
	gH9tv6GzrkiYtiQgRKWvI4I0SEkIkD1DZSoLFYzaS4tvDNrGXp17rse9iJOrF6GMB5ozBST2j35
	qB6iBTecQuEZAr3qoQcNKKLJbr04uKcfv/2TySc8fJe6Q3FNCt3iILXomGzmuHr7dgRmSHcdRKj
	hGy6sRng3DUlMVsiMqSW7UCUz9rOwOOrESk0AL54Y6Wg9uVEw2UANtH2G6S4uEoTwK1PcKyeDU7
	wkb3cJ7gcKZL7HPlMH57N60Mc/O8IHVAfNVeKNZGQFcz9U5hEg4FMVDpUhVFmjDIh+sWey7WpSk
	NK+jso08M3ByXt6Re6BgHnxU135SeASmO6jxQjy4a0n7r8u0k/jIqW64Yzn10q
X-Received: by 2002:a17:906:4fc8:b0:bc6:502e:6d68 with SMTP id a640c23a62f3a-bc6502e7514mr1218914366b.40.1778518218536;
        Mon, 11 May 2026 09:50:18 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcf3226d77csm224719166b.26.2026.05.11.09.50.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:50:17 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso568271666b.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:50:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vEUFIOp80kGBo2VB6L/QtlFoIbLvUi4/BeeSHleCjNvaRmAGRHh9p3WkZ8qHX/MXFVcuG+bw=@vger.kernel.org
X-Received: by 2002:a17:907:748:b0:ba8:9137:da5f with SMTP id
 a640c23a62f3a-bc56e6fb36emr1500682166b.32.1778518216661; Mon, 11 May 2026
 09:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
 <20260323-uvc-hwtimestamp-v1-4-aa42e3865204@chromium.org> <10a08462-30ce-4a79-bb5d-001ab7f3d0d8@kernel.org>
In-Reply-To: <10a08462-30ce-4a79-bb5d-001ab7f3d0d8@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 11 May 2026 18:50:03 +0200
X-Gmail-Original-Message-ID: <CANiDSCs9gby6bNBCRmxT15D8c-nksdUmwH8iUDAsiV1tmQTM3Q@mail.gmail.com>
X-Gm-Features: AVHnY4JL0Aa54-Afx6BfrRiZHEfsHTgnEN1oSkHuKXH696j2MXYzf_2uO0CcVZg
Message-ID: <CANiDSCs9gby6bNBCRmxT15D8c-nksdUmwH8iUDAsiV1tmQTM3Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: uvcvideo: Do not add clock samples with small
 sof delta
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yunke Cao <yunkec@google.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AE038513A9E
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245295-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim]
X-Rspamd-Action: no action

Hi Hans

On Mon, 11 May 2026 at 18:07, Hans de Goede <hansg@kernel.org> wrote:
>
> Hi,
>
> On 23-Mar-26 14:10, Ricardo Ribalda wrote:
> > Some UVC 1.1 cameras running in fast isochronous mode tend to spam the
> > USB host with a lot of empty packets. These packets contain clock
> > information and are added to the clock buffer but do not add any
> > accuracy to the calculation. In fact, it is quite the opposite, in our
> > calculations, only the first and the last timestamp is used, and we only
> > have 32 slots.
> >
> > Ignore the samples that will produce less than MIN_HW_TIMESTAMP_DIFF
> > data.
> >
> > Fixes: 141270bd95d4 ("media: uvcvideo: Refactor clock circular buffer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index dcbc0941ffe6..e1a4e84d6841 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -544,6 +544,19 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> >       spin_unlock_irqrestore(&clock->lock, flags);
> >  }
> >
> > +static inline u16 sof_diff(u16 a, u16 b)
> > +{
> > +     u32 aux;
> > +
> > +     a &= 2047;
> > +     b &= 2047;
> > +     if (a >= b)
> > +             return a - b;
> > +
> > +     aux = a + 2048;
> > +     return (u16)(aux - b);
> > +}
> > +
> >  static void
> >  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >                      const u8 *data, int len)
> > @@ -664,12 +677,13 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >       sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
> >
> >       /*
> > -      * To limit the amount of data, drop SCRs with an SOF identical to the
> > +      * To limit the amount of data, drop SCRs with an SOF similar to the
> >        * previous one. This filtering is also needed to support UVC 1.5, where
> >        * all the data packets of the same frame contains the same SOF. In that
> >        * case only the first one will match the host_sof.
> >        */
> > -     if (sample.dev_sof == stream->clock.last_sof)
> > +     if (sof_diff(sample.dev_sof, stream->clock.last_sof) <=
> > +         (MIN_HW_TIMESTAMP_DIFF / stream->clock.size))
> >               return;
>
> If I understand things correctly then uvc_video_clock_update() uses
> first->host_time + some correction time. But you might end up not
> storing a sample for the very first isochronous USB packet of a frame
> because of this new check.  Which means that the first->host_time used
> as a starting point for the timestamp just has become inaccurate ?

In UVC 1.5 All the ISOC packets have the same dev_sof and dev_stc.
So this check will avoid adding a whole frame into the timestamp
circular buffer when running at more than 320 Hz (1/(0.1/32))

In UVC 1.1 all ISOC packets have the same dev_stc but different dev_sof.
This check will avoid adding some of those packets into the circular
buffer, but the accuracy will not be lost. We will use the data from
the neighbour packets (even from previous frames) to recover the sof.

The biggest winner for this patch is UVC 1.1, which will have much
more accurate timestamps, because the distance between the first and
last will be bigger (as in uvc1.5)
>
> Regards,
>
> Hans
>
>


-- 
Ricardo Ribalda

