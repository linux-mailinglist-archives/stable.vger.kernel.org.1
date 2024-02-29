Return-Path: <stable+bounces-25592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11B86CFF7
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF355B255EC
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335B78266;
	Thu, 29 Feb 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RwWqCEwa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337034AECA
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225875; cv=none; b=t0uZzsg+DrtWg6lfzBHe7XLU5rsLRigZqGp+D3GLycnsIRC4gV+3wWH05iGSblazB9YjiQzbbM3jSXcdtIMt+EP97hssp3tTJRgPg9EHGjndgaqlKdxYUpWTgzsSZWp7I+6N7IyU2KPdphEd8EMPRsxlCpLUpzxnykAXlZBhhBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225875; c=relaxed/simple;
	bh=/iw69Wo9b7FEqCXecpxEQgFw9ugs5Mjc606tFUFxMt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnvmqiQQTpzb/mqQyL4+sIKiPm4RvIS8abYv5S4C1sV75uJQhtEA0aJLNfm+tUg+FuaXLY+4X/wlPn3GOkWU3ZulllovUg5VIcBKgIh+RIoWvGBYnk4cxHQ6oMrR/pAf96sXHk75+Ngt8HhfOihaJgRS7ID23CpyeKH7ra+ezyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RwWqCEwa; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e4953d801bso575886a34.2
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709225873; x=1709830673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wIQGu3rSrz7XnTQlEMgB0HP/EAY1ehgeyK1F+l2GXOk=;
        b=RwWqCEwa7i3XY5L79QT61EhFpmWOExPkAvv1qBNe1ppoEB+VO+eFEeqasTTHyo4dM5
         iaCasV6IySwvysO66r0W2FfIh9v734+ZYgARzqs9OMPCSXgY9noOjBvcE58xK1/Ls2ha
         +bBh0j7Tp0n1jQctmYLZJRt747HS9ae/Pyi6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225873; x=1709830673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIQGu3rSrz7XnTQlEMgB0HP/EAY1ehgeyK1F+l2GXOk=;
        b=RF17Iq4Xs8e9Sa6xojBJwGpNNl9RzQKNE3zRjLRrTHlXA3M/Of+Q5irfKxEaFmu+ZU
         cbHo4hXVVRMAFT+ksyJdZDZwuWyVgITIyfmQSsomyDZY20l6zNBC1Q0kaSrsD4VG2AbH
         R8lNiFuR5J9gBjDiD0+EkSO4eNayVAO9jDoR9SCyOD70HEC446vOhbtbx76pw2IjJLE8
         PTJQacVtPEjIkundZOyWrqMPsnCE7MxPwoknvg7M7ad+iqYX9gvpnFp5Siht7C+l0pqr
         yxa/dl8tWyhqg9JW5DBGjgZUxdph7bJW3x2cjNXnU9OKHn3a82o3e/QN4l14HGqeRjtH
         7NzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqgfZR71tbBNewK7dWdhYQACv4C/oxrRGBOqMg3WNo6Ho3hVTbCUZd4z+Abe2TEgv7/tmax+eVMz6nyfHW75vuXM1x6J1d
X-Gm-Message-State: AOJu0Yyy1xT4t68THaM8iG9TyqE/WCvEemFmSWL5XIdKFfXVGmBY6Mfe
	a9dP/BRZ4BM0XMyRemHHnAdG7jBZL0ajpZP4CkzyMZRQYKI8ZMoRIcjczG0zPCOEUXkZS00N5qw
	=
X-Google-Smtp-Source: AGHT+IEDMLahJV9oiMrFMhXO52srRhtE4QMnqm9fId0mIZJSYHCivli3QRSDAPRVpy0BxfQ5p5cIog==
X-Received: by 2002:a05:6870:1493:b0:21e:b778:dc5c with SMTP id k19-20020a056870149300b0021eb778dc5cmr2695758oab.44.1709225872809;
        Thu, 29 Feb 2024 08:57:52 -0800 (PST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id gl7-20020a0568703c8700b0021fb37e33e5sm513682oab.19.2024.02.29.08.57.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:57:52 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a027fda5aeso515434eaf.1
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 08:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxB/ydU1HyXW93DbZHX2+YDlH7qA9pGWp9JyMW9mzM/WivXI9t1okUvYVrWa8QyEt6Qbrs13U+UjPmDO30MptVTbUCW5Kx
X-Received: by 2002:a05:6358:441e:b0:17b:5c4b:90a with SMTP id
 z30-20020a056358441e00b0017b5c4b090amr3320345rwc.5.1709225871313; Thu, 29 Feb
 2024 08:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com> <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
 <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>
 <20240213104725.GC5012@pendragon.ideasonboard.com> <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
In-Reply-To: <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 29 Feb 2024 17:57:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>
Message-ID: <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Oliver Neukum <oneukum@suse.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oliver, friendly ping

On Mon, 19 Feb 2024 at 16:13, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Oliver
>
> Would you prefer a version like this?
>
> https://lore.kernel.org/all/20231222-rallybar-v2-1-5849d62a9514@chromium.org/
>
> If so I can re-submit a version with the 3 vid/pids.  Alan, would you
> be happy with that?
>
> Regards!
>
> On Tue, 13 Feb 2024 at 11:47, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 02:04:31PM -0500, Alan Stern wrote:
> > > On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> > > > On 04.02.24 11:52, Laurent Pinchart wrote:
> > > > > Hi Ricardo,
> > > > >
> > > > > Thank you for the patch.
> > > >
> > > > Hi,
> > > >
> > > > sorry for commenting on this late, but this patch has
> > > > a fundamental issue. In fact this issue is the reason the
> > > > handling for quirks is in usbcore at all.
> > > >
> > > > If you leave the setting/clearing of this flag to a driver you
> > > > are introducing a race condition. The driver may or may not be
> > > > present at the time a device is enumerated. And you have
> > > > no idea how long the autosuspend delay is on a system
> > > > and what its default policy is regarding suspending
> > > > devices.
> > > > That means that a device can have been suspended and
> > > > resumed before it is probed. On a device that needs
> > > > RESET_RESUME, we are in trouble.
> > >
> > > Not necessarily.  If the driver knows that one of these devices may
> > > already have been suspend and resumed, it can issue its own preemptive
> > > reset at probe time.
> > >
> > > > The inverse issue will arise if a device does not react
> > > > well to RESET_RESUME. You cannot rule out that a device
> > > > that must not be reset will be reset.
> > >
> > > That's a separate issue, with its own list of potential problems.
> > >
> > > > I am sorry, but it seems to me that the exceptions need
> > > > to go into usbcore.
> > >
> > > If we do then we may want to come up with a better scheme for seeing
> > > which devices need to have a quirk flag set.  A static listing probably
> > > won't be good enough; the decision may have to be made dynamically.
> >
> > I don't mind either way personally. Oliver, could you try to find a good
> > solution with Ricardo ? I'll merge the outcome.
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

