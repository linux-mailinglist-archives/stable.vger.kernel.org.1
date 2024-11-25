Return-Path: <stable+bounces-95394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC99D8A2A
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CEDB29B59
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189B1B2182;
	Mon, 25 Nov 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MVmLJCRG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEF14287
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547132; cv=none; b=W6dlm/jkJ51kWU/IrhGKL69J2CCaz4KdyKhYKJePVi7gx+nOlTRR610K8pAeddubs7/XBCgE+w65mYEZifTAGPjopl7n37ZL1AiqlGXoZP79QCbYePcebv/9aFOIVONYam+Ot34Fj8GwsDusgUAdGMoVa6/3QQG6Gp8sOLc3OHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547132; c=relaxed/simple;
	bh=UgV0XxTTu1kmFlokedXo9obHhIV4jPG5NnJV/X0554A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMUSnPvJIUeYOARClz8wAFLu9GMFWdKhPLp7MWSEvtRi6OoBI7IqcDKBMbdNRS8b6C729cvqqdWI/qvK2skLjN8JwVdL9+1p0gq9F2iw/D6QYkm400v9fGVjvbjp84BCqBFYcmtZYbN3omgr/kV41xWXGffprVMbh0YS46HH5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MVmLJCRG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720c286bcd6so4016696b3a.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732547130; x=1733151930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sN5xfsl1tMVlezY7JOX6O7i9TGCGKrcDQ0i7ldPTdlo=;
        b=MVmLJCRGsc10UihUCo4MUsJYoGg5FVSdp4mia0ypkZG/3zKV0OpKDrnWGyhXbpQKka
         BELH72swL3mDuFnt9nZKAyMqhCZaasGXjxPyFRjoJYa7Fh25f1gTuxwD7qMMal9QTpF3
         Z7aQLlrmZVdOlR5k3szlB0nFK/Rl6260mMJbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547130; x=1733151930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sN5xfsl1tMVlezY7JOX6O7i9TGCGKrcDQ0i7ldPTdlo=;
        b=ALiGsgdW3sbB5eKa0a7uie1GvfziNhQSACiY0Znx16SU1DlaedEU4L472JCuRTtLuc
         6WtHpHILgaUejaeDnV/wqABBHyuWxAAAAtnsjYzRlkLc5flppepU1lyYUNKxwsYa87d+
         cRqhJTMCqFIo1xIFrpmcOSFpXG1wa9iDcHsluzZlkgjkxAreWX8he9DOBJGtqUo3oCqU
         VASaoOOIQ3I3gOqXcvKtrqL13aZvl/DMwewgLWh+DHeTVOPoaXaRpKJ6lP1q1yrSLKX5
         11AG/++A86NRI0zjYIhcRYLzmKaTmb+XR4u+cacUGpxa8f5jTNCDx7QQ3rEzFW0JPrAO
         YjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFRirnL4vUcxgAjw+zHzoC3sD7xG27djbwaE9GmpPRG4orVF6ZylpkMEKDhuXuc5jkW2V2G20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZ17yZTjS7IfxEY3sv7L9N1GIfQKntEYmH/jlsI12LgdHI6nC
	zEkkfcDpo0wwUv6S2qz/lSQo5Fmv5SV3MUfhoa5ky7CYa7BULgqnab8T1CoK686KN54qxtDuVNE
	=
X-Gm-Gg: ASbGncsZI10Q4rByhxHsS5np4HxPGrY7kRP6WcpxkckEMbLkw5vVPVJjB1JQEbi033o
	pGtSNOoakaY386iPliSwiJBYzY1m4kFj6jLQrs4GbCSsPsAy34eQALvdJXtYCazX8+PGcOGA5yp
	bfc8w9vcmQxGvoy87rGw9Ny2AcOqIYoONImnb25Ggl5wuLm631yuEIIpYa7NsiqOuHWnw+FC7HN
	g21ql5pKpWa28NHmlMnX+vAcVKmJ/eeTLBqMQu4eHldsJV3nY+D67rUyX+v0hWA3lurhv6nBh85
	F/ni6hPwCZ/Jr2Xr
X-Google-Smtp-Source: AGHT+IHx08TnLNE/ifv5JFv2NFahUJ9lHkf6eTovGtvzUf0mxr3a1wK6XTKIBoHPuNnWgWvXi1t2+w==
X-Received: by 2002:a05:6a00:813:b0:71e:74bf:6b1a with SMTP id d2e1a72fcca58-724df663242mr16362211b3a.16.1732547129655;
        Mon, 25 Nov 2024 07:05:29 -0800 (PST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de53c38bsm6486402b3a.95.2024.11.25.07.05.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:05:28 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724d8422f37so3209941b3a.2
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 07:05:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVB3pYbhsX3Yq95a9AE9bYDWzqVueIRVI4q6kR2EMgfksewwU6oICxRPvkPReWkYkbhqFku044=@vger.kernel.org
X-Received: by 2002:a05:6a00:6c8e:b0:725:1951:79fd with SMTP id
 d2e1a72fcca58-72519517cb5mr1434907b3a.26.1732547127285; Mon, 25 Nov 2024
 07:05:27 -0800 (PST)
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
 <5a199058-edab-4f9d-9e09-52305824f3bf@redhat.com>
In-Reply-To: <5a199058-edab-4f9d-9e09-52305824f3bf@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 16:05:15 +0100
X-Gmail-Original-Message-ID: <CANiDSCsxkhZ0Dsxv9ZhkOk5JnZmSrFxq+tUoskxfHJDmSnXM5w@mail.gmail.com>
Message-ID: <CANiDSCsxkhZ0Dsxv9ZhkOk5JnZmSrFxq+tUoskxfHJDmSnXM5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a evdev
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 13:01, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> On 18-Nov-24 5:47 PM, Ricardo Ribalda wrote:
> > Hi Hans
> >
> > On Mon, 18 Nov 2024 at 16:43, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> On 15-Nov-24 9:20 AM, Ricardo Ribalda wrote:
> >>> On Fri, 15 Nov 2024 at 00:06, Laurent Pinchart
> >>> <laurent.pinchart@ideasonboard.com> wrote:
>
> <snip>
>
> >>>> How do you handle cameras that suffer from
> >>>> UVC_QUIRK_PRIVACY_DURING_STREAM ?
> >>>
> >>> For those b) does not work.
> >>
> >> I already suspected as much, but it is good to have this
> >> confirmed.
> >>
> >> I'm afraid that from a userspace API pov cameras with a GPIO
> >> which only works when powered-on need to be treated the same as
> >> cameras which only have UVC_CT_PRIVACY_CONTROL IOW in this case
> >> keep exporting V4L2_CID_PRIVACY instead of switching to evdev
> >> with SW_CAMERA_LENS_COVER.
> >>
> >> Unfortunately this will make the GPIO handling code in the UVC
> >> driver somewhat more involved since now we have both uAPI-s for
> >> GPIOs depending on UVC_QUIRK_PRIVACY_DURING_STREAM.
> >>
> >> But I think that this makes sense, this way we end up offering
> >> 2 uAPIs depending on the hw capabilities:
> >>
> >> 1. evdev with SW_CAMERA_LENS_COVER which always reports a reliable
> >> state + events on the state changing without needing to power-up
> >> the camera.
> >>
> >> 2. V4L2_CID_PRIVACY for the case where the camera needs to be
> >> powered-on (/dev/video opened) and where the ctrl possibly needs
> >> to be polled.
> >>
> >> Assuming we can all agree on this split based on hw capabilities
> >> I think that we must document this somewhere in the media subsystem
> >> documentation. We can then also write down there that
> >> SW_CAMERA_LENS_COVER only applies to internal cameras.
> >
> > I do not think that it is worth it to keep UVC_CT_PRIVACY_CONTROL for
> > the two devices that have connected the GPIO's pull up to the wrong
> > power rail.
> > Now that the GPIO can be used from userspace, I expect that those
> > errors will be found early in the design process and never reach
> > production stage.
> >
> >
> > If we use UVC_CT_PRIVACY_CONTROL for thes two devices:
> > - userspace will have to implement two different APIs
> > - the driver will have to duplicate the code.
> > - all that code will be very difficult to test: there are only 2
> > devices affected and it requires manual intervention to properly test
> > it.
> >
> > I think that UVC_QUIRK_PRIVACY_DURING_STREAM is a good compromise and
> > the main user handles it properly.
>
> Ok, as you wish. Lets go with using SW_CAMERA_LENS_COVER for the 2 models with
> UVC_QUIRK_PRIVACY_DURING_STREAM too.
>
> <snip>
>
> >>>> Is there any ACPI- or WMI-provided information that could assist with
> >>>> associating a privacy GPIO with a camera ?
>
> I just realized I did not answer this question from Laurent
> in my previous reply.
>
> No unfortunately there is no ACPI- or WMI-provided information that
> could assist with associating ACPI/WMI camera privacy controls with
> a specific camera. Note that these are typically not exposed as a GPIO,
> but rather as some vendor firmware interface.
>
> Thinking more about this I'm starting to believe more and more
> that the privacy-control stuff should be handled by libcamera
> and then specifically by the pipeline-handler, with some helper
> code to share functionality where possible.
>
> E.g. on IPU6 equipped Windows laptops there may be some ACPI/WMI
> driver which provides a /dev/input/event# SW_CAMERA_LENS_COVER node.
>
> So I would expect the IPU6 pipeline-handler to search for such a
> /dev/input/event# node and then expose that to users of the camera
> through a to-be-defined API (I'm thinking a read-only control).
>
> The code to find the event node can be shared, because this would
> e.g. likely also apply to some IPU3 designs as well as upcoming
> IPU7 designs.
>
> <snip>
>
> >>>> We could include the evdev in the MC graph. That will of course only be
> >>>> possible if the kernel knows about that association in the first place.
> >>>> At least the 1st category of devices would benefit from this.
> >>
> >> Yes I was thinking about adding a link to the MC graph for this too.
> >>
> >> Ricardo I notice that in this v3 series you still create a v4l2-subdev
> >> for the GPIO handling and then add an ancillary link for the GPIO subdev
> >> to the mc-graph. But I'm not sure how that is helpful. Userspace would
> >> still need to do parent matching, but then match the evdev parent to
> >> the subdev after getting the subdev from the mc. In that case it might
> >> as well look at the physical (USB-interface) parent of the MC/video
> >> node and do parent matching on that avoiding the need to go through
> >> the MC at all.
> >>
> >> I think using the MC could still be useful by adding a new type of
> >> ancillary link to the MC API which provides a file-path as info to
> >> userspace rather then a mc-link and then just directly provide
> >> the /dev/input/event# path through this new API?
> >>
> >> I guess that extending the MC API like this might be a bit of
> >> a discussion. But it would already make sense to have this for
> >> the existing input device for the snapshot button.
> >
> > The driver creates a v4l2-subdevice for every entity, and the gpio
> > today is modeled as an entity.
>
> Ok I see that explains why the subdevice is there, thank you.
>
> > The patchset just adds an ancillary link as Sakari suggested.
> > I am not against removing the gpio entity all together if it is not needed.
>
> Right unlike other entities which are really part of the UVC
> specification, the GPIO is not a "real" UVC entity.
>
> So I wonder if, after switching to SW_CAMERA_LENS_COVER, having
> this as a v4l2-subdevice buys us anything ? If not I think removing
> it might be a good idea.
>
> As for the ancillary link, that was useful to have when the API
> was a v4l2-ctrl on the subdevice. Just like I doubt if having
> the subdevice at all gives us any added value, I also doubt if
> having the ancillary link gives us any added value.
>
> > Now that we are brainstorming here... what about adding a control that
> > contains the name of the input device (eventX)? Is that a horrible
> > idea?
>
> I don't know, my initial reaction is that does not feel right to me.
>
> >>>>>> We can specify
> >>>>>> that SW_CAMERA_LENS_COVER only applies to device internal
> >>>>>> cameras, but then it is up to userspace to determine which
> >>>>>> cameras that are.
> >>>>>
> >>>>> I am working on wiring up this to userspace right now.. I will report
> >>>>> back if it cannot do it.
> >>
> >> Ricardo, great, thank you!
>
> Ricardo, any status update on this ?

I still have not wired it to ChromeOS. But I do not expect to have any
issues. it is relative simple to go from vdev to evdev and the other
way around

 # ls -la /sys/class/video4linux/video0/device/input/input*/
drwxr-xr-x. 3 root  root     0 Nov 25 06:56 event11

 # ls -la /sys/class/input/event11/device/device/video4linux/
drwxr-xr-x. 3 root root 0 Nov 25 06:56 video0
drwxr-xr-x. 3 root root 0 Nov 25 06:56 video1


>
> <snip>
>
> >>>> Assuming the kernel could report the association between an evdev and
> >>>> camera, we would need to report which evdev SW_CAMERA_LENS_COVER
> >>>> originates from all the way from the evdev to the consumer of the event.
> >>>> How well is that supported in standard Linux system architectures ? If
> >>>> I'm not mistaken libinput will report the originating device, but how
> >>>> far up the stack is it propagated ? And which component would we expect
> >>>> to consume those events, should the camera evdev be managed by e.g.
> >>>> libcamera ?
> >>
> >> Good questions. Looking back at our 2 primary use-cases:
> >>
> >> a) Having an app which is using (trying to use) the camera show
> >> a notification to the user that the camera is turned-off by
> >> a privacy switch .
> >>
> >> b) Showing on on-screen-display (OSD) with a camera /
> >> crossed-out-camera icon when the switch is toggled, similar to how
> >> muting speakers/mic show an OSD . Laptop vendor Windows add-on
> >> software does this and I know that some users have been asking
> >> for this.
> >>
> >> I think we have everything to do b) in current compositors
> >> like gnome-shell. Using an evdev with SW_CAMERA_LENS_COVER
> >> would even be a lot easier for b) then the current
> >> V4L2_CID_PRIVACY API.
> >>
> >> a) though is a lot harder. We could open up access to
> >> the relevant /dev/input/event# node using a udev uaccess
> >> tag so that users who can access /dev/video# nodes also
> >> get raw access to that /dev/input/event# node and then
> >> libcamera could indeed provide this information that way.
> >> I think that is probably the best option.
> >>
> >> At least for the cases where the camera on/off switch
> >> does not simply make the camera completely disappear.
> >>
> >> That case is harder. atm that case is not handled at all
> >> though. So even just getting b) to work for that case
> >> would be nice / an improvement.
> >>
> >> Eventually if we give libcamera access to event#
> >> nodes which advertise SW_CAMERA_LENS_COVER (and no other
> >> privacy sensitive information) then libcamera could even
> >> separately offer some API for apps to just get that value
> >> if there is no camera to associate it with.
> >>
> >> Actually thinking more about it libcamera probably might
> >> be the right place for some sort of "no cameras found
> >> have you tried hitting your camera privacy-switch" API.
> >> That is some API to query if such a message should be
> >> shown to the user. But that is very much future work.
> >
> > Are standard apps expected to use libcamera directly or they should
> > use pipewire?
> > Maybe a) Should be pipewire's task?
>
> Standard apps are supposed to use pipewire, but IMHO this is
> really too low-level for pipewire to handle itself.
>
> Also see my remarks above about how I think this needs to
> be part of the pipeline handler. Since e.g. associating
> a /dev/input/event# SW_CAMERA_LENS_COVER node with a specific
> UVC camera is going to be UVC specific solution.
>
> For other pipeline-handlers combined with vendor fw-interfaces
> offering SW_CAMERA_LENS_COVER support I do not think that there
> is going to be a way to actually associate the 2. So we will
> likely simply have the pipeline handler for e.g. IPU6 simply
> associate any SW_CAMERA_LENS_COVER with the normal (non IR)
> user facing camera.
>
> Since we need this different ways to map a /dev/input/event#
> SW_CAMERA_LENS_COVER node to a specific camera this really
> needs to be done in libcamera IMHO.
>
> And I think this also solves the question about needing
> a kernel  API to associate the /dev/input/event# with
> a specific /dev/video#. At least for now I think we don't
> need an API and instead we can simply walk sysfs to find
> the common USB-interface parent to associate the 2.
>
> See how xawtv associates the alsa and /dev/video# parts
> of tv-grabber cards for an example.
>
> Regards,
>
> Hans
>
>
>


-- 
Ricardo Ribalda

