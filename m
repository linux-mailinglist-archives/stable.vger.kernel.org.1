Return-Path: <stable+bounces-95555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3A9D9D29
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D016415E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1CF1DDA0E;
	Tue, 26 Nov 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZqBIgWX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434631DC1BD
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644789; cv=none; b=BuODtn3KtDF9H2V0V00xv+t1GFntodMwFpTz6P/lTzEFRVoAhQXJ8t7ZEAt/OGk5m6x/QjFUNceDRUBiKi1l9Kf4Vs85ahL6VigUT6hSD4kus4g32aimBuThOk2ZfPMl97quWKoWIDHFCVE1pqzvR5OsI9rZsc0ZDAru3Ktfk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644789; c=relaxed/simple;
	bh=N5DXqLLENJurn1n1t0P92WWNwx35eWFGM+6sfF7P2Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHT5Avwp1YsBFBtPeaBRlI9N8fuh0pyyZBfK6WqZ+MlSdMaP3an/V0KGY82ph7k6zN8N1FkOmhPXJ6RtLNHvnxjfxaQ/VXz0IWooJ+VTx4sgOSWtTIKzRU+tPd/Ysb5ISI+TfYEeBOF+qRc85t7HYfDuksd2nL9TX7rZ3++TzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZqBIgWX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-212348d391cso57308935ad.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732644787; x=1733249587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DRDHH9mII91Onr/ViRKZaUWx6zHyVw0QRYxvAkTS5oQ=;
        b=LZqBIgWXXELEi5P1qyZGXH8IxW7yB1LRjBbqvguAOnFsjrBRHIxoDyTrQNsKQVcgu8
         pfB/si+MBFJxOxnVlZmubTR006Pue8ORxqxWVSLTg6ysdr5L2HKndPTjhaFm/7vSsvCj
         EX8SHUvrFlnMDJK5bKt4dXN9/5hbe0mMI8jfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644787; x=1733249587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRDHH9mII91Onr/ViRKZaUWx6zHyVw0QRYxvAkTS5oQ=;
        b=s5mQb4Z7DafP1/Vn74stZQGH9dBHkNPjVhpygHckyIpLJf0jrXzuxPxzd3FB/l5LSe
         BB2QCKOSTzkn2QOqa+5WJ8fdHS7lDWlqjwGoGqrAmCPykmlf63gWiJbhEhD7jo7CAwL1
         zydjuYH4/7ASz1zP4U57aC1A/Ou0Hm3nB3c+dCWNalFZpKbjRH4PMwOqGJGs6r9nT/8T
         bh6/4OrkM8XKCjK9U4BxVUw3oTzn9GTbADWCdKcl/jaUl49SP2TupkPX7COxkvH6yYrv
         lVFJijKfdm41HBAR5lEm/lKfcaM4yADkX6WwxXezuYcWKjbJxQMTZ1x2MrrKlZd5ikSd
         Qm3A==
X-Forwarded-Encrypted: i=1; AJvYcCX87YXi5rsf9SRnVFqeFjH/7b7zU4Dh73P2+gdne+3dQtuAbAz4N0FUwsdeQeFSjEMKB6cgFEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPBGLBaWDr0Z7Hy5HDUUvdwFwHLX/Mc7A042uu5lCXkf5nz1v
	8Ume7S/diMIdORZcEzbzj9Cz+Pie8YUMMDGSJY7v3lKF2PM7d6/dHYt3eIBmEpOGF6QL7TeCFYg
	=
X-Gm-Gg: ASbGncsbFzTA8VDzdebI4JA3sO3TtbtJkIpWu+x89OeUCiGEsaVqpYMnrVWe6ID+TJ1
	oCfPrRTJ0w87grCLt/xmjOM4L6Woor6t4RyVw+JwV9Zqm9IBRdc4Nnj23FY1lmqTqON4NDSfm5O
	T9GnCtuik425DKWgMNhFNVsl0Aj6GEsB1IiYh6F6Y38MOHKH7Zn6gvbWgYHxqmtuwrbLsohCxVb
	gDQxeU6q8nH9N0UeSkHKNXnwoxEFyNacJ52xZQ6J/nF+r1NtcNPe2IYT/NTQw+2ib1vticjqAz+
	divl5Y9EA8Wyudjq
X-Google-Smtp-Source: AGHT+IGjjaKKxQVU91cfWOo+ke6cUGrpPTjPFJCTILHUrXHeX2UU8rIhCRTuik8U+NNECMXGD4Fh5Q==
X-Received: by 2002:a17:902:f651:b0:212:3bf9:951 with SMTP id d9443c01a7336-2150108753dmr2137025ad.6.1732644787342;
        Tue, 26 Nov 2024 10:13:07 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc21a25sm87560045ad.254.2024.11.26.10.13.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:13:06 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so3885078a12.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 10:13:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfyK0TMcKvzYjkmcF/HUh6nsxYk1yomHZavW1HyB/kr2KfLL3Vtf/Vo6uRyT+bNbuflr5wCFY=@vger.kernel.org
X-Received: by 2002:a05:6a21:39a:b0:1e0:dbfd:d254 with SMTP id
 adf61e73a8af0-1e0e0b8cbf0mr485269637.41.1732644785584; Tue, 26 Nov 2024
 10:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
 <20241120-uvc-readless-v4-1-4672dbef3d46@chromium.org> <20241126180616.GL5461@pendragon.ideasonboard.com>
In-Reply-To: <20241126180616.GL5461@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 19:12:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCuZkeV7jTVbNhnty8bMszUkb6g9czJfwDvRUFMhNdFp2Q@mail.gmail.com>
Message-ID: <CANiDSCuZkeV7jTVbNhnty8bMszUkb6g9czJfwDvRUFMhNdFp2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 19:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 20, 2024 at 03:26:19PM +0000, Ricardo Ribalda wrote:
> > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > requested from a control if it can fit in less bytes.
> > Eg: Returning 0xab instead of 0x00ab.
> > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> >
> > Extend the returned value from the camera and return it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index cd9c29532fb0..482c4ceceaac 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -79,6 +79,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >       if (likely(ret == size))
> >               return 0;
> >
> > +     /*
> > +      * In UVC the data is usually represented in little-endian.
>
> I had a comment about this in the previous version, did you ignore it on
> purpose because you disagreed, or was it an oversight ?

I rephrased the comment. I added "usually" to make it clear that it
might not be the case for all the data types. Like composed or xu.
I also r/package/packet/

Did I miss another comment?

>
> > +      * Some devices return shorter USB control packets that expected if the
> > +      * returned value can fit in less bytes. Zero all the bytes that the
> > +      * device have not written.
>
> s/have/has/
>
> And if you meant to start a new paragraph here, a blank line is missing.
> Otherwise, no need to break the line before 80 columns.

The patch is already in the uvc tree. How do you want to handle this?

>
> > +      * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need to
> > +      * be excluded because its size is always 1.
> > +      */
> > +     if (ret > 0 && query != UVC_GET_INFO) {
> > +             memset(data + ret, 0, size - ret);
> > +             dev_warn_once(&dev->udev->dev,
> > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > +                           uvc_query_name(query), cs, unit, ret, size);
> > +             return 0;
> > +     }
> > +
> >       if (ret != -EPIPE) {
> >               dev_err(&dev->udev->dev,
> >                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

