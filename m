Return-Path: <stable+bounces-95605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC709DA4BB
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CEBB223B7
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15A8192B70;
	Wed, 27 Nov 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nM9DLUhS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540B192597
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699564; cv=none; b=IsgoIvd7+H98z+PQJkAaxng39dfDZA0WX6s71RFEcS33dSb1H1Mm88MlDGts5JcFB/+s/BXcFh5+UPsYbYgIW1F0tHNNlMVWP8rEathstAOCQTWD8DY0SPMoOgnnFNTlMs4o3uMwXbNLIskzy6rvq+zVozo8lPcT8qXAs3xg2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699564; c=relaxed/simple;
	bh=Pr2w9P5YgFGcloq41dky7oHk7tvapxV8DUhchBmh8oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGnpf92Pl9VK8j0iK4IsLFUKRrLbRLty8PF/CjhagZtqyhnuI9R0nLFIuHXp6NbYCqUE1CcaSIUrTnGqgCrkwOS3KYYHGyrV5VSG4FFSLjaGjlYC1rxV1fDo6Sako4Syj6TLdeHR2yAXPDXPUgNnHmDSEs9DPZBmiLYyY1lTF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nM9DLUhS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7251ace8bc0so442321b3a.0
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732699562; x=1733304362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ef33Q45NDhtM2JikV+GQsfJKYqlaYSgoxUTe9Gy8DDA=;
        b=nM9DLUhS/WMKZGhCuOLjUOgE9z7K68xdnSKRy40y31t7kwTdvpfKe8Wq4xo1hK0sei
         iKR74XhR9HwxLib3UR/YiUCkeO5st58Oaz7inls9OrulRLqtxcVo2gAF8Ur67zOR/nl5
         IyXNfhhKzPjPs5uNQpaZ1/CLNs/+AcWijobGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732699562; x=1733304362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef33Q45NDhtM2JikV+GQsfJKYqlaYSgoxUTe9Gy8DDA=;
        b=mmdl+4XCDi62yiIPSQUzX/6FFRBhYNmd8k+f/yb2o4m2xNaJ7mwKXtUzAofbx0/Rq1
         Fgg7jMm7NOLC+ju27FdFFhoTLaJnPK4vA1jfVjsbK+IUoHa1T351z/Ps4efvENN4C9A9
         fmaHtU2VGNF1jimLr8sN17EM3NxQqN6gqVaVqcO2axxqH3r0WZyz+BBMD/lyRDzUFalv
         HCM+LFrzl5dc5v9iQevEpVJXjR/4QuHlqOnHN844xnCucjrgNz9wMhuvMLvaTYwiuMff
         bFjXkrCalIFbovQXNpYexRMSivSj9Z2M6KQXwoVOAAhFgOksCY/smc/88RH72MeZt2lr
         gNRA==
X-Forwarded-Encrypted: i=1; AJvYcCVvfyVT9cJc/Pkoa4kVEiAr6WsvM01Sy7OstE5dR4ezb3XXbTSURzP/qDH50tNMbMbE0rGThT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2MM0R/OYOk6SBvoIhWK/HnNd4JwMVZ8n1a/sIkj5bMN4AjX/
	oq4GOCO/gzGZzFjF9gGWPI0HoT+o7VA8x02BCgdJLRanvc1Wc8GccfYZTHK2Cvmc/SYlxun17uI
	=
X-Gm-Gg: ASbGncu0cEf8xRG94GeKUDloAg9rPePYrn/vzK8oggxUpYZPuDj0K0r40E3n0ky2yjB
	0RlgpNXY6rjmIxnkbA/GBR7QTvB/hKiPQmBygb/KafURV3zglrFiq7rPKdRdFM2Dj/eQ6B394j4
	YyoTiObajimcw5SABL0Jf43ph+23LrJ98DrX1cSq/FPLo64h5Met8lAQZVFMRMhO7vvBlPecFOn
	BELvOh23l92+QEP75XSXmxRMwtC+NQTHK7bv3JHN8PfyamS4n5yQ+U4hY0ZrHZbHTSRnp1qy+xm
	1uebW3ZG+8wjlqyE
X-Google-Smtp-Source: AGHT+IEHtLosPKQOGYRli0vP+KgNfKGrahRVRb2C+iawfr/V0+6HIl7/Xj59rlOBk1QtKcIyOfcIdA==
X-Received: by 2002:a17:902:d4c5:b0:212:3f36:d983 with SMTP id d9443c01a7336-21500fc6e87mr35760765ad.27.1732699562361;
        Wed, 27 Nov 2024 01:26:02 -0800 (PST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com. [209.85.210.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8f749sm98146295ad.21.2024.11.27.01.26.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 01:26:01 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7250906bc63so479422b3a.1
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 01:26:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvjqN6XN+N/gN1u7iqUoF6feJzE2/nFGFoso2LC8UmSb9F8bKBRW9NOH9N00ebbqz04WBsc2w=@vger.kernel.org
X-Received: by 2002:a05:6a00:3014:b0:725:37a4:8827 with SMTP id
 d2e1a72fcca58-72537a489f6mr1060353b3a.3.1732699560596; Wed, 27 Nov 2024
 01:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
 <20241127-uvc-fix-async-v1-1-eb8722531b8c@chromium.org> <20241127091153.GA31095@pendragon.ideasonboard.com>
In-Reply-To: <20241127091153.GA31095@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 10:25:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCs36Ndyjz52aYA0SHef8JVQc=FvtDNk8xQwR=30m652Gg@mail.gmail.com>
Message-ID: <CANiDSCs36Ndyjz52aYA0SHef8JVQc=FvtDNk8xQwR=30m652Gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: Do not set an async control owned by
 other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:12, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 07:46:10AM +0000, Ricardo Ribalda wrote:
> > If a file handle is waiting for a response from an async control, avoid
> > that other file handle operate with it.
> >
> > Without this patch, the first file handle will never get the event
> > associated to that operation.
>
> Please explain why that is an issue (both for the commit message and for
> me, as I'm not sure what you're fixing here).

What about something like this:

Without this patch, the first file handle will never get the event
associated with that operation, which can lead to endless loops in
applications. Eg:
If an application A wants to change the zoom and to know when the
operation has completed:
it will open the video node, subscribe to the zoom event, change the
control and wait for zoom to finish.
If before the zoom operation finishes, another application B changes
the zoom, the first app A will loop forever.

>
> What may be an issue is that ctrl->handle seem to be accessed from
> different contexts without proper locking :-S

Isn't it always protected by ctrl_mutex?

>
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 4fe26e82e3d1..5d3a28edf7f0 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >               return -EACCES;
> >
> > +     /* Other file handle is waiting a response from this async control. */
> > +     if (ctrl->handle && ctrl->handle != handle)
> > +             return -EBUSY;
> > +
> >       /* Clamp out of range values. */
> >       switch (mapping->v4l2_type) {
> >       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

