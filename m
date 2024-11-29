Return-Path: <stable+bounces-95849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5A9DED36
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 23:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87B8B21DD3
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02319D898;
	Fri, 29 Nov 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXSf81a3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24D142623
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918752; cv=none; b=GdR4MR/SafRBaqEVemwXAprHyEvMyWK30NJclBtIpvxr4HquWfx/Q3KjLt9DI2uDOQNgEbDoY9AFxsq9QM0JXUtZsLljVG3qesPqfpmOzD1Eux815YtngQssvp32t9ydXPY1eJv2c+lilC/qIViQ75KOK9v9cEPzHQpwGUGljXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918752; c=relaxed/simple;
	bh=vEKjGTkYVhfnz5owgv3+b9nsmE+0qOZCKZ0+m2kHulE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/sie7alrkxaH0Nfoeh3dzeXCOH10Yx2PRUTUMKos55ud1+IiLTP11WQe++iuLJVG/jRnVjYo8yugc+rg9DdyiJMYtku9rpgqQBL5GG8okD857c+Jg37bM2h1D7tw6c+UBA77Pr74cFrNNNiy5RJhFZlrgHXWjpkXHU/0Df5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jXSf81a3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc2b84bc60so1397967a12.1
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732918749; x=1733523549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/UwWvzboXwaTQVa3UMHS8RQfD6Akh8wwGfMsFYt7QM=;
        b=jXSf81a3bjaE3/xU4a5ZA4yJuMDyj7BqdRWpKIw2TB9lEBJG1doc7K6/sh70tfLERh
         v8PkDXrDa3GnSMfQtQ37yHPIbnYPNieJvgPXYxjiILhgzj+cMR4FQ0JhD9IvXYdQl3yb
         o7OF8N60mAa/JbXC2sxajAkPP9ldDpDA4pmpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732918749; x=1733523549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/UwWvzboXwaTQVa3UMHS8RQfD6Akh8wwGfMsFYt7QM=;
        b=kmbTd5cTE4eI22ZD+5BzEhryAb8MMMl3FfM/RbOE3oS5Q3fMiBRYZEdrUEYm06Ea3q
         iGzoTZDYNswkTvykDAM8J2Ym/uujCg1YeXzX+yw+EL1lExhwFGoXAJxm04LrNYRHYRe2
         /FHL8noIuUSf5heb8tChIfEr4c51LaplI4aoAsSIomolKXod8P+pCu6N2mJLTnnPcIrT
         4kNkalVuyj1Sxl/ivuMIZpr0dOY56H8n4inmr3IgBNFFtR/wzFY2IYCJdUHXTk4woPxu
         PyiOIipBUjwJOpU3HTfMTZGT5x8KDCJtDakIqW+QnvJcNGEan86WlgEqBoPl+5FXuWcF
         B6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXGpFGkHu1SFuSbMCx3qjDUSka8qrNI2NphIjaT+NGBfe+Z3gYoh2IHgGTlCG5/++6LRT+XLCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVT1pmJOMh8JZ9vrN53LVNeDBrO8NO7rKF0V11mCTRpkWlMTnm
	+PQAadWobRFL1tXEn8PMAirw/lgILBBnABqpgk9x1uRP4PxLRwxFf9rOv4O4zvTWOP909rT3EbI
	=
X-Gm-Gg: ASbGncsoxQYAAdBXoL5CPWTzdhJxDIsgxSJKnDRmXOKGL565F7rO2f/hXHxLZQjbnEe
	yOrq/N6ki5LujlKj/sX+l/goN28vWR6XamzTVnAIdEE+3zR9166plkD+otoJGWC0jlvpDzjIlZy
	5TZMFzNaXSKrE14jyC+PSmADmsjeiavmPbkN7wsmNTMEazTb7awM/13HJj59ATtdCjh5DDj09JK
	GrlbnuGn4z7c/x/uc/TrBlD3hNDELUR2YChPOPfcu/jsBbxD90l52P9u3qebmfN0g62ZqoQK8oM
	10q/PoPoJzS79MLU
X-Google-Smtp-Source: AGHT+IGB/mq2tPFfAZOCIycRKTitbTdCVf/YMUFBcnVyDSwaYwWBqzGpjWu4Vb6CEVzxEVUi1QjjVw==
X-Received: by 2002:a05:6a20:a10a:b0:1e0:d0ac:133b with SMTP id adf61e73a8af0-1e0e0b53581mr17388783637.33.1732918749588;
        Fri, 29 Nov 2024 14:19:09 -0800 (PST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2e6af1sm3127639a12.21.2024.11.29.14.19.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 14:19:07 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724f1004c79so1559289b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 14:19:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq48BCkKcMQ8v7qyEPOVTMTyX43wCs3qI0H8WJLmMVxlYm8lvke+glbVbnakIbBX35MTPH3Zs=@vger.kernel.org
X-Received: by 2002:a17:90b:3e86:b0:2ea:9ce1:d143 with SMTP id
 98e67ed59e1d1-2ee08eb0640mr16580627a91.11.1732918746928; Fri, 29 Nov 2024
 14:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128222232.GF25731@pendragon.ideasonboard.com>
 <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
 <20241128223343.GH25731@pendragon.ideasonboard.com> <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl> <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
 <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com> <20241129220339.GD2652@pendragon.ideasonboard.com>
In-Reply-To: <20241129220339.GD2652@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 23:18:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCsXi-WQLpbeXMat5FoM8AnYoJ0nVeCkTDMvEus8pXCC3w@mail.gmail.com>
Message-ID: <CANiDSCsXi-WQLpbeXMat5FoM8AnYoJ0nVeCkTDMvEus8pXCC3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 23:03, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Nov 29, 2024 at 07:47:31PM +0100, Ricardo Ribalda wrote:
> > Before we all go on a well deserved weekend, let me recap what we
> > know. If I did not get something correctly, let me know.
> >
> > 1) Well behaved devices do not allow to set or get an incomplete async
> > control. They will stall instead (ref: Figure 2-21 in UVC 1.5 )
> > 2) Both Laurent and Ricardo consider that there is a big chance that
> > some camera modules do not implement this properly. (ref: years of
> > crying over broken module firmware :) )
> >
> > 3) ctrl->handle is designed to point to the fh that originated the
> > control. So the logic can decide if the originator needs to be
> > notified or not. (ref: uvc_ctrl_send_event() )
> > 4) Right now we replace the originator in ctrl->handle for unfinished
> > async controls.  (ref:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n2050)
> >
> > My interpretation is that:
> > A) We need to change 4). We shall not change the originator of
> > unfinished ctrl->handle.
> > B) Well behaved cameras do not need the patch "Do not set an async
> > control owned by another fh"
> > C) For badly behaved cameras, it is fine if we slightly break the
> > v4l2-compliance in corner cases, if we do not break any internal data
> > structure.
>
> The fact that some devices may not implement the documented behaviour
> correctly may not be a problem. Well-behaved devices will stall, which
> means we shouldn't query the device while as async update is in
> progress. Badly-behaved devices, whatever they do when queried, should
> not cause any issue if we don't query them.

I thought we could detect the stall and return safely. Isn't that the case?
Why we have not seen issues with this?


>
> We should not send GET_CUR and SET_CUR requests to the device while an
> async update is in progress, and use cached values instead. When we
> receive the async update event, we should clear the cache. This will be
> the same for both well-behaved and badly-behaved devices, so we can
> expose the same behaviour towards userspace.

seting ctrl->loaded = 0 when we get an event sounds like a good idea
and something we can implement right away.
If I have to resend the set I will add it to the end.

>
> We possibly also need some kind of timeout mechanism to cope with the
> async update event not being delivered by the device.

This is the part that worries me the most:
- timeouts make the code fragile
- What is a good value for timeout? 1 second, 30, 300? I do not think
that we can find a value.


>
> Regarding the userspace behaviour during an auto-update, we have
> multiple options:
>
> For control get,
>
> - We can return -EBUSY
> - We can return the old value from the cache
> - We can return the new value fromt he cache
>
> Returning -EBUSY would be simpler to implement.
Not only easy, I think it is the most correct,

>
> I don't think the behaviour should depend on whether the control is read
> on the file handle that initiated the async operation or on a different
> file handle.
>
> For control set, I don't think we can do much else than returning
> -EBUSY, regardless of which file handle the control is set on.

ACK.

>
> > I will send a new version with my interpretation.
> >
> > Thanks for a great discussion
>
> --
> Regards,
>
> Laurent Pinchart

Looking with some perspective... I believe that we should look into
the "userspace behaviour for auto controls" in a different patchset.
It is slightly unrelated to this discussion.


-- 
Ricardo Ribalda

