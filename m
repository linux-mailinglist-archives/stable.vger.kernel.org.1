Return-Path: <stable+bounces-95613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A632F9DA59E
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 11:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1156CB2914A
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6917194C9D;
	Wed, 27 Nov 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GpVQvYt4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E93193439
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702811; cv=none; b=PUNJaaBTLCayD+TYhWIVQbKW5RBz2j06Wr0n+LIr9yby8DC6bHoBt3HDOoe8ZpwQzH2UHvkWVClHOEuh43hqrQGB9PfscHgGvWwyYwERNdsi9ierVyCWaMoNU7Sk3G5qWMH1RJjXgV7Vjs2p9OpYTSO/1Pa52o/eOC/FeS5v1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702811; c=relaxed/simple;
	bh=8r5vCCz3A7owBJYWh+nbdral5EKpJhok9PThU26k4nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABsfOzh1Vk6pKgyY+8SOC5ila9H2YR2JhOsPaKvLNCZG4fhYTjFF+siOpoeEezzXUGuylvPSgIAYwm7gZ+n9bVtij8EkXRYwRO4rsh0406CJsQlHI/r2UhwrwGcKlsj4CLaBv+lwId35u0lgAjd23IDuqfDlCnFjv+xWdkLI5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GpVQvYt4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea8b039ddcso5209353a91.0
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732702808; x=1733307608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94aDzij1Sd3lW/XcYirCTixFdk5KYMfgdRn5F74gnPs=;
        b=GpVQvYt4kkRELixReHpfaGGgzvzaVrn7hK7wUABsswjnMwljBs/AK7MFp8ttLj0XDh
         ShITFYVvlJ1otxw5LH+c3I/4ZAABH/VLpqH+WNCMNnYwSg2x9+tpIsuVizgK1JNa4wrr
         5DV5qqXuIgYqz/CbDALFOeVm8DMzwy8o2PmpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732702808; x=1733307608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94aDzij1Sd3lW/XcYirCTixFdk5KYMfgdRn5F74gnPs=;
        b=Dhb1oRCyjPVgjZkWhzDhQooO4ssuX0OT71qbG55Qi5CVsJCCAXMOm3c1Zy1qncvvXo
         z0g7vPUShu+6WBnN5HpcKCPBBhRa/GGTT8ZK9xlZLV9Cw1uNo1kBMttsFuye9YZKSy5A
         sMEYTX25O5PENlDn5JGb7UQio+ukJqjWjCxh4b6MfMlJPErr/C3YirZm5Y5u7W3solOd
         KZc3AIg9xF3u+kjm1mOcYm5HaYeCD4i/iU3VQlKSBbtdZ+is8G0sGwWaojWqm3dykRUE
         yxki8aV+4fwXATe2y0TJDnc+vwbnfXLLVY2KuU74LDn/XBrTNdQ2Gy26quS5+YoONwk2
         xthQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsMLKePri7Mqp0A5FKTf2IoIvvNS4Ekf332Dt+DZ9KWw6WEX7WKMuII9sKLKlcY7/uc9mvC/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqpANqgDxqo7Y5eZuUtVRZkGDZdKdJ3e+UcmB6Jf7//eKhaqj
	nAH+dmic4H+BlnfBxg2Mj98k89sDINWf9YRPSsBZLvtM+CxvSbkhmPQbnCRXkyJWmVNyiTnQL/o
	=
X-Gm-Gg: ASbGncsI9wedUZYlkcU8uLLgl2pOgW/ew60PlptPpDITQNP0fMJD4iiLQxAbmSgp8et
	GE9Za/6CUiOASERxOq2XCElzDsUkAYZZEFSai5zbVYDmo2yo0/x5i+4VR8MkO2FTQgzx8op+91k
	sQCFTsml/B+5vOoeX7JoppImmKrF61frKGGUagT9xMbF5Zedi3KBgQe8KvKI05gUSUd4+PuqmMw
	xyFieZieqQjLmV+58xNR/0WZ8llOtBKlNjfG90lkaHXxcoPVxzSXkHflZD6QkURIVN+j6fWyUMc
	r5TRJ9+ssH6IAF+a
X-Google-Smtp-Source: AGHT+IFZEEqpggYEhdiHtqaMACmUe4JXSWtCz8YF5WYVU0tx/20bZkUxbOBWdutuVJl0cglzdQMrwA==
X-Received: by 2002:a17:90b:3c45:b0:2ea:9309:759f with SMTP id 98e67ed59e1d1-2ee08e5caa0mr3077715a91.1.1732702808501;
        Wed, 27 Nov 2024 02:20:08 -0800 (PST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03e7sm1122014a91.42.2024.11.27.02.20.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 02:20:07 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724e113c821so4495200b3a.3
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 02:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyBlguLTzBmKcplJ2gWPGAA+O26H09KEX/3FtqAYgczK5LYar/8SFAKV8lHsw5LBuXbsvLBQ8=@vger.kernel.org
X-Received: by 2002:a05:6a00:1396:b0:724:62b3:58da with SMTP id
 d2e1a72fcca58-72530043fe3mr3288577b3a.6.1732702807121; Wed, 27 Nov 2024
 02:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
 <20241127-uvc-fix-async-v1-1-eb8722531b8c@chromium.org> <20241127091153.GA31095@pendragon.ideasonboard.com>
 <CANiDSCs36Ndyjz52aYA0SHef8JVQc=FvtDNk8xQwR=30m652Gg@mail.gmail.com> <20241127094212.GF31095@pendragon.ideasonboard.com>
In-Reply-To: <20241127094212.GF31095@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 11:19:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCuukO7kQw=VHyHS3ir3y4mCERbnRoUTTTSoRHZkMpLBdg@mail.gmail.com>
Message-ID: <CANiDSCuukO7kQw=VHyHS3ir3y4mCERbnRoUTTTSoRHZkMpLBdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: Do not set an async control owned by
 other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:42, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 27, 2024 at 10:25:48AM +0100, Ricardo Ribalda wrote:
> > On Wed, 27 Nov 2024 at 10:12, Laurent Pinchart wrote:
> > > On Wed, Nov 27, 2024 at 07:46:10AM +0000, Ricardo Ribalda wrote:
> > > > If a file handle is waiting for a response from an async control, avoid
> > > > that other file handle operate with it.
> > > >
> > > > Without this patch, the first file handle will never get the event
> > > > associated to that operation.
> > >
> > > Please explain why that is an issue (both for the commit message and for
> > > me, as I'm not sure what you're fixing here).
> >
> > What about something like this:
> >
> > Without this patch, the first file handle will never get the event
> > associated with that operation, which can lead to endless loops in
> > applications. Eg:
> > If an application A wants to change the zoom and to know when the
> > operation has completed:
> > it will open the video node, subscribe to the zoom event, change the
> > control and wait for zoom to finish.
> > If before the zoom operation finishes, another application B changes
> > the zoom, the first app A will loop forever.
>
> So it's related to the userspace-visible behaviour, there are no issues
> with this inside the kernel ?

It is also required by the granular PM patchset.


>
> Applications should in any case implement timeouts, as UVC devices are
> fairly unreliable. What bothers me with this patch is that if the device
> doesn't generate the event, ctrl->handle will never be reset to NULL,
> and the control will never be settable again. I think the current
> behaviour is a lesser evil.

The same app can set the control as many times as it wants, and if
that app closes the next patch will clean out the handle.
Maybe I should invert the patches?


>
> > > What may be an issue is that ctrl->handle seem to be accessed from
> > > different contexts without proper locking :-S
> >
> > Isn't it always protected by ctrl_mutex?
>
> Not that I can tell. At least uvc_ctrl_status_event_async() isn't called
> with that lock held. uvc_ctrl_set() seems OK (a lockedep assert at the
> beginning of the function wouldn't hurt).

ctrl->handle = NULL in uvc_ctrl_status_event_async() is completely redundant.

The only place we set the value of the handle is in uvc_ctrl_set, and
that can only happen for controls with mappings.
I am sending another patch to remove that set to make it clear.

>
> As uvc_ctrl_status_event_async() is the URB completion handler, a
> spinlock would be nicer than a mutex to protect ctrl->handle.
>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 4fe26e82e3d1..5d3a28edf7f0 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> > > >               return -EACCES;
> > > >
> > > > +     /* Other file handle is waiting a response from this async control. */
> > > > +     if (ctrl->handle && ctrl->handle != handle)
> > > > +             return -EBUSY;
> > > > +
> > > >       /* Clamp out of range values. */
> > > >       switch (mapping->v4l2_type) {
> > > >       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

