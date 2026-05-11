Return-Path: <stable+bounces-245268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIesOEMGAmpZnQEAu9opvQ
	(envelope-from <stable+bounces-245268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:39:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8196512610
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 813443067EA4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3B423A8A;
	Mon, 11 May 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIQI7/MN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C81423A66
	for <stable@vger.kernel.org>; Mon, 11 May 2026 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515131; cv=none; b=UAiWmF+ujWMrForHkTQ0ymqWRJ07o6SoHtROUi3aWo4hJ+bNoXaEptNy1fcTw6vfQko5DrLInd3TBbjp6On58RJx1MkUhDv6lkyApI9YMLD8JLh2rpAqmru7Vj/9qlWmn/ZmR5bHKlvBr1q4eOiksnadcD8MP37jKyZ2WeYcaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515131; c=relaxed/simple;
	bh=tPjz8MvZYUwd2HrVmfdhiEjC4piGNjBbAcum3J0fxsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFVyPUhnOwIc9bJIFmBaPTtoWqOxfJNVEurnKqrfMRoAbWnuP2U6GGNFyCxBt83tmMcMOB5KeRgkLUx6HIWDOFcq22wGZRGmQA7oaHPOxgRgl5eml9j9FjEfQ8Lam9uas6lKDLU7754dogP/MAvBgO/tz2wkLaRRQDTAnuys9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EIQI7/MN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso8720079a12.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778515127; x=1779119927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gGm3/h7WrYTDgc2Zza1Wt6uQJTTMxObDFpBEiSspy7s=;
        b=EIQI7/MNjYVlgDMkxv3IK0jvffemZgHbRKs2qqfFAhqMYpc33etLJ0KOyuLLfDVtqd
         D2w0O8rDrW3rL7U7RgqAEMaNlkAfsMrJw5x9gvKwp1Cj2DvDuczKdZxOMfiedlQaoMi9
         RZgbw6vFLd6QJAoMlhgmaoD1MkWqLH1xhK9o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515127; x=1779119927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGm3/h7WrYTDgc2Zza1Wt6uQJTTMxObDFpBEiSspy7s=;
        b=hkN2Ybtl/uaoVavRtGIYJ8cAKrf4xPZnl9b8exygQspJmfyKMVEDkTVLK/jhgKdCn/
         cQh+VR1WH49dKRpdLGp7CWibKgnLYo/gPOy7qy1zHfJRcuE2+/828zIYAED5iIqkmnrD
         Zi629BoGhMwTk4PXvbmZWmAgZZvzOYRtwXVwNWQPalxpgVqJ5Vnooxqg8b0aEvb6NqtO
         3EOx0P6WVk+q5rIzGpitdzV1pvzeeT8SEqR5EHaaP/BIJw9wpdjcl+ItAsrY/gy8sbgF
         eT5rtwej1qnkcGE0oTBvH77P+FTSizoC8osvZYsNxcnt35rFTJcJeX2eX0UzfudephCc
         pdbA==
X-Forwarded-Encrypted: i=1; AFNElJ+h1ajMasUyPqTh08O0K6ITTuQWzJzwtuIg2qtatlLqwaIwNSkErcYsRV3OJDwGlg0VOZcAHaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHZLbnUoeIYgFuujDaHu5YJFSl7XUFXDVJT2KqaFUMIM4CIbS
	2vaeixO4bRjwJdTii4RmKUNtA69AsQ40SNtWznkEUX89GtNSWK+K3J7dKC9NCOYq6cGh0jbbMTc
	zs/w=
X-Gm-Gg: Acq92OGPy4pe05CUy36umsWQYHb3XXsxjRc48y2ZC3y1E9AaYpB+vvDgSFOfOSuozIN
	Mbx4yrmkmzFMb+mXd1oMEcuEGpuJQaoIKp2i08Ye0wM/+BxHfQjLLNhvW5iTkkA3dFq+h58ivQ3
	fZ7bCI1vzzVejTO8G4gpziox8wEpLFONq4may9QfqHEzPcRFGK58oYjkemnuh0c2neZnOXPnGld
	Ue4Q1a51nPTVQy5MPhkPWtM0weYZNmpFsy6lAttsnFh7otuhfXutEI/GdNt53k1ckDJkHKcM/YW
	+fqK2nPzxbTPrcIZ7nXng2J5xrr896Zf6i398Q7PXBXCNDnRUv52GIZxh/GuRNws35S6yTuoruT
	SwZb3wLLikrX5XsRLuEQIQFdQ78Qdyi+Xlhj6v1T1bLHkL35CyHaiiFhqv2CZaDl/7IHvxYzrc5
	BBzbYHseAHf/vP/xYsWEdZChm3prifUILjcsFK0joOYW2KFS7iLwCkBMcFa1rUvDdi0Vk1QL0=
X-Received: by 2002:a05:6402:5389:b0:67d:afe0:da63 with SMTP id 4fb4d7f45d1cf-67f713c6b11mr4789715a12.16.1778515127107;
        Mon, 11 May 2026 08:58:47 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3bb2asm3798398a12.6.2026.05.11.08.58.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 08:58:46 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so7955488a12.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 08:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/IsDjrddHmyncgTYyWkc2LzMFPBQnbrnewg/fHXzXoS1bK5DVHKZ+dBCdz9631pOM6pJ/FKh8=@vger.kernel.org
X-Received: by 2002:a17:906:c14d:b0:bd0:6dbe:22b3 with SMTP id
 a640c23a62f3a-bd06dbe3240mr238397466b.18.1778515124475; Mon, 11 May 2026
 08:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
 <20260323-uvc-hwtimestamp-v1-3-aa42e3865204@chromium.org> <20260511155125.GD3043805@killaraus.ideasonboard.com>
In-Reply-To: <20260511155125.GD3043805@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 11 May 2026 17:58:30 +0200
X-Gmail-Original-Message-ID: <CANiDSCs5jeEN7OL1PDc0XXtCP5Op2jpnWJyw7WR4Vn_Z7ECYOQ@mail.gmail.com>
X-Gm-Features: AVHnY4LotYKZD0QXvksPifwDyP78oM1-PCByG8vfrZnviLIV2oBHBptW9nPbzG8
Message-ID: <CANiDSCs5jeEN7OL1PDc0XXtCP5Op2jpnWJyw7WR4Vn_Z7ECYOQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: uvcvideo: Relax the constrains for
 interpolating the hw clock
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E8196512610
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245268-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:email,chromium.org:dkim,ideasonboard.com:email]
X-Rspamd-Action: no action

Hi Laurent

On Mon, 11 May 2026 at 17:51, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Mar 23, 2026 at 01:10:30PM +0000, Ricardo Ribalda wrote:
> > In the initial version we set the min value to 250msec. Looks like
> > 100msec can also provide a good value.
>
> I'd like to know where the value comes from and how it has been tested.

I used the Android CTS framework for testing. It checks in multiple
places that the timestamps are stable.

>
> > Now that we are at it, refactor a bit the code to make it cleaner.
>
> Do you mean using a macro ? You can mention that explicitly here.
>
> > Fixes: 6243c83be6ee8 ("media: uvcvideo: Allow hw clock updates with buffers not full")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index c7ebedb3450f..dcbc0941ffe6 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -494,6 +494,13 @@ static int uvc_commit_video(struct uvc_streaming *stream,
> >   * Clocks and timestamps
> >   */
> >
> > +/*
> > + * The accuracy of the hardware timestamping depends on having enough data to
> > + * interpolate between the different clock domains. This value is sof cycles,
> > + * this is, milliseconds.
> > + */
> > +#define MIN_HW_TIMESTAMP_DIFF 100
>
> UVC prefix.
>
> > +
> >  static inline ktime_t uvc_video_get_time(void)
> >  {
> >       if (uvc_clock_param == CLOCK_MONOTONIC)
> > @@ -834,15 +841,12 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
> >               y2 += 2048 << 16;
> >
> >       /*
> > -      * Have at least 1/4 of a second of timestamps before we
> > -      * try to do any calculation. Otherwise we do not have enough
> > -      * precision. This value was determined by running Android CTS
> > -      * on different devices.
> > +      * Check that we have enough data to do the interpolation.
> >        *
> > -      * dev_sof runs at 1KHz, and we have a fixed point precision of
> > -      * 16 bits.
> > +      * y1 and y2 are dev_sof with a fixed point precision of 16 bits.
> >        */
> > -     if (clock->size != clock->count && (y2 - y1) < ((1000 / 4) << 16))
> > +     if (clock->size != clock->count &&
> > +         (y2 - y1) < (MIN_HW_TIMESTAMP_DIFF << 16))
> >               goto done;
> >
> >       y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

