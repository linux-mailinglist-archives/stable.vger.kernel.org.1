Return-Path: <stable+bounces-95550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF09D9B6D
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 17:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7150A285C92
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0C1D88D7;
	Tue, 26 Nov 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNZHBOEP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED951D63EF
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638494; cv=none; b=L8P2+f8Q/9fvPKpiRbaWIdIgf0xdbKGJkLA2v1btNkSkIvZVUZK0hS4y8eISzWq8lwlW4tijKSaGhjhwAHxFKyJtmRRSchv6laiahPr26qQiZn7Nt1yfawOQtVlV4cxHbKMhpPJQ9fRyQpIhLvjsPU9qgTovF+7xOuwqH0Idbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638494; c=relaxed/simple;
	bh=/VFh394bqpoPVPaVYrZD7casHaZGYWi9G0Bs0UrwOhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiGkCx8q0tcCJnrmAK6AOttJPi4zBqZI9iKvsLUj80FCu8DGhjhJpKEA7wqWogSHwXz1I4/cv1OuWsDovPhZb1QESY/P2YprTJKPl1K2wr5K5VDYxYWFxik5mEpGr0h9BbFc2x68lAJYiFSws28hz9/3o6vSD4enDc1CkMsyVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hNZHBOEP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21269c8df64so59465775ad.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638492; x=1733243292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VFh394bqpoPVPaVYrZD7casHaZGYWi9G0Bs0UrwOhs=;
        b=hNZHBOEP9pOES91PMQz+vaLcGN+STMP3MgflYC0MLr5XxjUy0agk80ApNXka0kXg4x
         bNx520+tvjiFLMhm7u7WJVKfMYnw2VsXCp3hbVm+sga2r7IKz5clfFNTiLBaEmwwcQR8
         wGCXj2+i1mRNzC9VzS6kgORCLLXune/sFOnvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638492; x=1733243292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VFh394bqpoPVPaVYrZD7casHaZGYWi9G0Bs0UrwOhs=;
        b=Wq6bKgT6uQFW+JmScA1sBoDpha/gV2VzVJSeuWPGy4VhYHWec5iMYyfY5K68Y2GALW
         ghRc72tJPkoCAEoaDYPL9MpNHSC8y3p2a1sq8b9q0g4nwIGS2n/I085rsfLySIZEVLP3
         bow4iD3XMVk6yntbKupKMXNtPdIVhjAT6RclJh827BXnNCH/Odh1EXj9QrAfBlo/LRHG
         5knYeDE9dIhGM/kb9u7ANKKjaWvmfuKMOJJRWUlTqF4kYJF7YaQgM500X7hH5lNBMmw8
         X3fVEUPOq/CxZKeSa0VxEwn6VCQxyUbUP5YjX6dh7X3D+TC5Ps7r2v3RiSOeLojbfM2m
         dR/g==
X-Forwarded-Encrypted: i=1; AJvYcCVptThiYrfHboXZUo7STGMrU8IcrYjGaqqtpict2EdCWjkRwoC1NnGxB6u1ljZRA/GaPjl+s/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKi+DWsSKqF3RqOsDTLGi2Fj3Nxw6U5HwtlVf5xuHSG1ll0cQ6
	j0iXcLZCydoaPwuwNC+s5+WgWrnYfMopLS8ek4fwLVDSWX1BvcsOLq81R5MRcWwmyus33WKYpgo
	=
X-Gm-Gg: ASbGnctsB++/PpDSyJdcs6JmrOAAm/H35vkb84bOoP0JSZ4jJNpmAu+dKK1Fi+55wJO
	uBhM2BxYOEWtsNpRnKiS30gMQ8n8VF409ePktb7V+hzwbjakg6M3bhbbo8+vlHHsLPOwjeZvRJ3
	C+ymCNUAXHBy4Bka5cy4+Dvcgpcw4ssJEWM0vCjDqmNtJiNk1OHZWkTNOPGyzeGavHpL6YKaxWY
	l1RWq0Tfx3btd1Hkq7vGFAgWTJh4IQYPvDXO83iXnKakkrbKrQn4DZ3KSlN0QQ9+Q0eORtV/PHY
	Qf6MtLFbYQmH
X-Google-Smtp-Source: AGHT+IF46zlhgXPnIiTM2aXkisA9VQkqxUEZaSvQYxafHO6BJhyHnA7b34OjHhWF/jeMh1rrPxypOw==
X-Received: by 2002:a17:902:e84f:b0:20b:5645:d860 with SMTP id d9443c01a7336-2129f781465mr258694705ad.36.1732638492212;
        Tue, 26 Nov 2024 08:28:12 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1580bsm87013585ad.175.2024.11.26.08.28.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 08:28:11 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e59746062fso4921993a91.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 08:28:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCGk/KY+gA+dCUeZjFzPKh+dxxdJOyLf7MBWs+QRyso2OW1k8q4wfUXgxOS/GKZ52xj0Hb/3A=@vger.kernel.org
X-Received: by 2002:a17:90b:1a8c:b0:2ea:65a1:9861 with SMTP id
 98e67ed59e1d1-2eb0e8856ebmr21070959a91.37.1732638490136; Tue, 26 Nov 2024
 08:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
 <bd68178f-1de9-491f-8209-f67065d29283@redhat.com> <CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com>
 <20241114230630.GE31681@pendragon.ideasonboard.com> <CANiDSCt_bQ=E1fkpH1SAft1UXiHc2WYZgKDa8sr5fggrd7aiJg@mail.gmail.com>
 <d0dd293e-550b-4377-8a73-90bcfe8c2386@redhat.com> <CANiDSCvS1qEfS9oY=R05YhdRQJZmAjDCxVXxfVO4-=v4W1jTDg@mail.gmail.com>
 <5a199058-edab-4f9d-9e09-52305824f3bf@redhat.com> <20241125131428.GD32280@pendragon.ideasonboard.com>
 <233eaf78-49f1-43c1-b320-c75cfc04103f@redhat.com> <20241125213521.GV19381@pendragon.ideasonboard.com>
In-Reply-To: <20241125213521.GV19381@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 17:27:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCvfnNKG8KUQEeBsr3JhWjUE+nBr4BTaR-sfaQQV9ZqSwQ@mail.gmail.com>
Message-ID: <CANiDSCvfnNKG8KUQEeBsr3JhWjUE+nBr4BTaR-sfaQQV9ZqSwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a evdev
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 at 22:35, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Nov 25, 2024 at 03:41:19PM +0100, Hans de Goede wrote:
> > Hi,
> >
> > On 25-Nov-24 2:14 PM, Laurent Pinchart wrote:
> > > On Mon, Nov 25, 2024 at 01:01:14PM +0100, Hans de Goede wrote:
> > >> On 18-Nov-24 5:47 PM, Ricardo Ribalda wrote:
> > >>> On Mon, 18 Nov 2024 at 16:43, Hans de Goede wrote:
> > >>>> On 15-Nov-24 9:20 AM, Ricardo Ribalda wrote:
> > >>>>> On Fri, 15 Nov 2024 at 00:06, Laurent Pinchart wrote:
> >
> > <snip>
> >
> > >>>>>> Is there any ACPI- or WMI-provided information that could assist=
 with
> > >>>>>> associating a privacy GPIO with a camera ?
> > >>
> > >> I just realized I did not answer this question from Laurent
> > >> in my previous reply.
> > >>
> > >> No unfortunately there is no ACPI- or WMI-provided information that
> > >> could assist with associating ACPI/WMI camera privacy controls with
> > >> a specific camera. Note that these are typically not exposed as a GP=
IO,
> > >> but rather as some vendor firmware interface.
> > >>
> > >> Thinking more about this I'm starting to believe more and more
> > >> that the privacy-control stuff should be handled by libcamera
> > >> and then specifically by the pipeline-handler, with some helper
> > >> code to share functionality where possible.
> > >>
> > >> E.g. on IPU6 equipped Windows laptops there may be some ACPI/WMI
> > >> driver which provides a /dev/input/event# SW_CAMERA_LENS_COVER node.
> > >
> > > Using an event device means that the user would need permissions to
> > > access it. Would distributions be able to tell the device apart from
> > > other event devices such as mouse/keyboard, where a logged user may n=
ot
> > > have permission to access all event devices in a multi-seat system ?
> >
> > input events modaliases contain a lot of info, including what sort
> > of events they report, e.g. :
> >
> > [hans@shalem uvc]$ cat /sys/class/input/input36/modalias
> > input:b0003v046Dp405Ee0111-e0,1,2,3,4,11,14,k71,72,73,74,75,77,78,79,7A=
,7B,7C,7D,7E,7F,80,81,82,83,84,85,86,87,88,89,8A,8B,8C,8E,8F,90,96,98,9B,9C=
,9E,9F,A1,A3,A4,A5,A6,A7,A8,A9,AB,AC,AD,AE,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA=
,BB,BC,BD,BE,BF,C0,C1,C2,CC,CE,CF,D0,D1,D2,D4,D8,D9,DB,DF,E0,E1,E4,E5,E6,E7=
,E8,E9,EA,EB,F0,F1,F4,100,110,111,112,113,114,115,116,117,118,119,11A,11B,1=
1C,11D,11E,11F,161,162,166,16A,16E,172,174,176,177,178,179,17A,17B,17C,17D,=
17F,180,182,183,185,188,189,18C,18D,18E,18F,190,191,192,193,195,197,198,199=
,19A,19C,1A0,1A1,1A2,1A3,1A4,1A5,1A6,1A7,1A8,1A9,1AA,1AB,1AC,1AD,1AE,1AF,1B=
0,1B1,1B7,1BA,240,241,242,243,244,245,246,247,248,249,24A,24B,24C,24D,250,2=
51,260,261,262,263,264,265,r0,1,6,8,B,C,a20,m4,l0,1,2,3,4,sfw
> >
> > So I believe that we can create a udev rule which matches on input
> > devices with SW_CAMERA_LENS_COVER functionality and set a uaccess
> > tag on those just like it is done for /dev/video# nodes.
> >
> > Or we can just use a specific input-device-name (sub) string
> > and match on that.
> >
> > This may require using a separate input_device with just
> > the SW_CAMERA_LENS_COVER functionality in some of the laptop
> > ACPI / WMI drivers, but that is an acceptable compromise IMHO.
>
> As long as it's doable I'm OK with it.
>
> > (we don't want to report privacy sensitive input events on
> > these nodes to avoid keylogging).
> >
> > > Would compositors be able to ignore the device to let libcamera handl=
e
> > > it ?
> >
> > input devices can be opened multiple times and we want the compositor
> > to also open it to show camera on/off OSD icons / messages.
>
> I'm not sure we want that though, as the event should be associated with
> a particular camera in messages. It would be better if it still went
> through libcamera and pipewire.

For OSD we do not necessarily need to know what camera the GPIO is
associated with.

We just want to give instant feedback about a button on their device.
Eg in ChromeOS we just say: "camera off" not "user facing camera off"


>
> > If opened multiple times all listeners will get the events.
> >
> > >>>>>> We could include the evdev in the MC graph. That will of course =
only be
> > >>>>>> possible if the kernel knows about that association in the first=
 place.
> > >>>>>> At least the 1st category of devices would benefit from this.
> > >>>>
> > >>>> Yes I was thinking about adding a link to the MC graph for this to=
o.
> > >>>>
> > >>>> Ricardo I notice that in this v3 series you still create a v4l2-su=
bdev
> > >>>> for the GPIO handling and then add an ancillary link for the GPIO =
subdev
> > >>>> to the mc-graph. But I'm not sure how that is helpful. Userspace w=
ould
> > >>>> still need to do parent matching, but then match the evdev parent =
to
> > >>>> the subdev after getting the subdev from the mc. In that case it m=
ight
> > >>>> as well look at the physical (USB-interface) parent of the MC/vide=
o
> > >>>> node and do parent matching on that avoiding the need to go throug=
h
> > >>>> the MC at all.
> > >>>>
> > >>>> I think using the MC could still be useful by adding a new type of
> > >>>> ancillary link to the MC API which provides a file-path as info to
> > >>>> userspace rather then a mc-link and then just directly provide
> > >>>> the /dev/input/event# path through this new API?
> > >
> > > I don't think we need that. MC can model any type of entity and repor=
t
> > > the device major:minor. That plus ancillary links should give us most=
 of
> > > what we need, the only required addition should be a new MC entity
> > > function.
> >
> > Ah interesting yes that should work nicely.
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda

