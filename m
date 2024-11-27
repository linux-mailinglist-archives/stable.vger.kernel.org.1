Return-Path: <stable+bounces-95599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914F9DA440
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2912A1657B7
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6A19004A;
	Wed, 27 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhLbLkml"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74862189919
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697920; cv=none; b=YTJVYUmPg9h+oEi6NBOIfNNBHKsqdRonY6BMuS7fvRscl5itUClqVoULpSTATqJu1zpJaWG3+w+8BtQjQ1O7h5oksGlaOxUWbTFtG0j5rxlkPFFZII7zx6SJQEoiAKJHJEhqI/YrQJrQ+Jwa+AKPhyAhH8gZE1cR+11SsY+4gE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697920; c=relaxed/simple;
	bh=JiHij5QSGg+4juP7Bw0Jcbhv8F9uCGy9weyzR2lagVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bb2j4eqfXQRy10KIFdPvjDpAQByyuMCTl62yhIMBBcscOJI3GUB5xhjbF9RzhduN9vvS0vRUmBGk3qWyH97CP4q3I9DX8T3G07LEgnitkKMCp2L51JOuzpVltSUJr5955J1SagX0sId1Gu1FR+TvEt1B/BegzX6HaLGEO5QwBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PhLbLkml; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ea55e95d0fso1155613b6e.2
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732697917; x=1733302717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2a1NquYRm428Xk6taKkRe/kN+BcnV15X20uznJxfdTg=;
        b=PhLbLkmlVrHaBbjsLbntYaQDRDDo0TNlOyykDLCPqcEYVqpmops5IObjRYsHEM50CJ
         t8ERIFPTrTWwrKtdBEN3rJPlmR6Zhv/KEkW7GBPk2x5ILmVW9fNp/0Wg5FJa8XmmL3Br
         KGfioluaeJ2vq77vX75QnX52dmDanR+UXQtYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697917; x=1733302717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a1NquYRm428Xk6taKkRe/kN+BcnV15X20uznJxfdTg=;
        b=o75u5P+LoGmS/eZIC3bH/XAwfRAkYpQ55SIb1xSOre6bXD7T+GxWdmJnNVvZ1YKnx3
         Og2IiQRN82Z6M4Bw/FCcaqEs4dhB7htTFAtayGKYGgHuKP6fkhvxAXr3r1o6WvtM3Bdj
         mdqvJIENvq4VueVH4T3CrXmJPI5mMxZ0RJhbc5JtcG7+fjp0UdApS1iXNQwTygOd7i3m
         mRkjT2NxAPHkVVB6cXOXNqpJO/tywp9O2es3vxoFrn7ljcUufQnc0x49qhjL98euMEQL
         aBpXycFPdll4L7ZlPI6vtvPymO3/7+uT1OOh07Lw+qG9k+5Ts/ga46+9F8mWAVzPPRtR
         dQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzj6yk1HqERduCswIBh07y58nR3pHJ3UcHQkcDNQXf+ftXLKDzzAh4dcAQS7ls6nxAEHDj7uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNux/NCQXEoYfVdzsU4FulTubP8wyKVJF1kr3tVyDESS88jxcV
	ivc/5goYckue2l5njsIjQMMakLAu3OS/Gj/MJaqUMichk3SXwaligvCYXBJN7ZN3LNV5DCX2Si4
	=
X-Gm-Gg: ASbGncv4OajKIhT3hbfdMlxDYhDv/PJRtUDlRspLN0sX2sRLbnV25/5oWxKG0vaE2R7
	Qsa2k6khZbA6pu1UrGeCS8ZN07168GIjgR87tokEg2XLEMMrXxi9AbtjvxGeopSWgu5tB4f4xgA
	y/EW6yiMbnbPErtpqZezzRSK2MNjnJKUKThCr+Rdv4rBrloOFpqIN5X4ZYIIJ41shn9E6yZ2QuT
	lC7KZW0N+Nicy5jeeL4rxDdQJzOeg5t7uBXHNaF8jMo3SUpd5q75t977Rl7zFjpUPqIk/UebUFL
	smp2mP3xs3HX
X-Google-Smtp-Source: AGHT+IHcw+TyjAROj5KjNdbQ5q9QzDIJk8zOFwqCHrU3ce7a+lQ8rATrE4f5XVrQOtpBtXarUjFJdA==
X-Received: by 2002:a05:6808:2010:b0:3ea:50a8:4587 with SMTP id 5614622812f47-3ea6dbd39d5mr2029736b6e.10.1732697917455;
        Wed, 27 Nov 2024 00:58:37 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e91500f91bsm3550498b6e.52.2024.11.27.00.58.34
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 00:58:35 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d4e043dd9so1515362a34.1
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 00:58:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGdphuOtJNkPljnko0LFMrufc/TH1Ui7Qtl2qxvp5ACaXVdubgV1dYlDp4emgm8MaUIU0UXQI=@vger.kernel.org
X-Received: by 2002:a05:6808:3087:b0:3ea:4e7c:a91a with SMTP id
 5614622812f47-3ea6dd4a1fbmr2389825b6e.34.1732697913702; Wed, 27 Nov 2024
 00:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
 <20241120-uvc-readless-v4-1-4672dbef3d46@chromium.org> <20241126180616.GL5461@pendragon.ideasonboard.com>
 <CANiDSCuZkeV7jTVbNhnty8bMszUkb6g9czJfwDvRUFMhNdFp2Q@mail.gmail.com> <20241127083444.GV5461@pendragon.ideasonboard.com>
In-Reply-To: <20241127083444.GV5461@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 09:58:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCvvCtkiHHPCj0trox-oeWeh_rks3Cqm+kS9Hvtp9QC6Yg@mail.gmail.com>
Message-ID: <CANiDSCvvCtkiHHPCj0trox-oeWeh_rks3Cqm+kS9Hvtp9QC6Yg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 09:34, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Nov 26, 2024 at 07:12:53PM +0100, Ricardo Ribalda wrote:
> > On Tue, 26 Nov 2024 at 19:06, Laurent Pinchart wrote:
> > > On Wed, Nov 20, 2024 at 03:26:19PM +0000, Ricardo Ribalda wrote:
> > > > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > > > requested from a control if it can fit in less bytes.
> > > > Eg: Returning 0xab instead of 0x00ab.
> > > > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> > > >
> > > > Extend the returned value from the camera and return it.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index cd9c29532fb0..482c4ceceaac 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -79,6 +79,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > >       if (likely(ret == size))
> > > >               return 0;
> > > >
> > > > +     /*
> > > > +      * In UVC the data is usually represented in little-endian.
> > >
> > > I had a comment about this in the previous version, did you ignore it on
> > > purpose because you disagreed, or was it an oversight ?
> >
> > I rephrased the comment. I added "usually" to make it clear that it
> > might not be the case for all the data types. Like composed or xu.
>
> Ah, that's what you meant by "usually". I read it as "usually in
> little-endian, but could be big-endian too", which confused me.
>
> Data types that are not integers will not work nicely with the
> workaround below. How do you envision that being handled ? Do you
> consider that the device will return too few bytes only for integer data
> types, or that affected devices don't have controls that use compound
> data types ? I don't see what else we could do so I'd be fine with such
> a heuristic for this workaround, but it needs to be clearly explained.

Non integer datatypes might work if the last part of the data is
expected to be zero.
I do not think that we can find a heuristic that can work for all the cases.

For years we have ignored partial reads and it has never been an
issue. I vote for not adding any heuristics, the logging should help
identify future issues (if there is any).

>
> > I also r/package/packet/
> >
> > Did I miss another comment?
> >
> > > > +      * Some devices return shorter USB control packets that expected if the
> > > > +      * returned value can fit in less bytes. Zero all the bytes that the
> > > > +      * device have not written.
> > >
> > > s/have/has/
> > >
> > > And if you meant to start a new paragraph here, a blank line is missing.
> > > Otherwise, no need to break the line before 80 columns.
> >
> > The patch is already in the uvc tree. How do you want to handle this?
>
> The branch shared between Hans and me can be rebased, it's a staging
> area.

I will send a new version, fixing the typo. and the missing new line.
I will also remove the sentence
`* In UVC the data is usually represented in little-endian.`
It is confusing.


>
> > > > +      * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need to
> > > > +      * be excluded because its size is always 1.
> > > > +      */
> > > > +     if (ret > 0 && query != UVC_GET_INFO) {
> > > > +             memset(data + ret, 0, size - ret);
> > > > +             dev_warn_once(&dev->udev->dev,
> > > > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > > > +                           uvc_query_name(query), cs, unit, ret, size);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > >       if (ret != -EPIPE) {
> > > >               dev_err(&dev->udev->dev,
> > > >                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

