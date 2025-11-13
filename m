Return-Path: <stable+bounces-194755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1BC5A5B2
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CD454F2419
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5D326939;
	Thu, 13 Nov 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CuJgCX7N"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0F325712
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073363; cv=none; b=Pl+yMjr/pnFAGqbpMnqhjOrxixsM0ejEETKXgIPsOGVZrNRZZtKPGDysQ0YNpKsBd5tWt/g4S3CNEuvLhV++bRawsKFxmzI154kQA79ehZG8qE9qrdvQ8BG2oqlGK+eWHG2CzDPBecDWjR0dRKZn/U2F03TP+yWEoqgpipa/yjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073363; c=relaxed/simple;
	bh=2yVpJY+aeisJHvGDwoFPYLuYT8Ebc0gRs6IMYNT04l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzqZUAAtqH140zxbwsB80JprT5TTT7gohivQ58CK1eXkqK/Tp7mSnICJnT6QOJemszUA/Rf81Sypo5i6AR35qshOOG8VD4owwTOoACElEkoQAik3/L1Mq76hZwNcbsyGx2AEeq+RY8XaD5+Z6eVE5pTA6uUfzvc5YaJqcvMHGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CuJgCX7N; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59457f79859so1383256e87.2
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 14:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763073359; x=1763678159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h30VSnQHi4bPYHqpJ1DDcugPgpyo8jt9+e8fEtu4vhU=;
        b=CuJgCX7N0zxqpf0ZefF3fpWqwulzhzpxi1D6D1qOfV1+XxQY9mNLgcdr0zlcunHsN/
         XHdayrSRCMHjHILGi0gXNOn5+1JRbru/3bdNY/GjCvZWFlJbrpGxfgVg7Wmx4M573jCZ
         d2EQZjKZUiUh+btuEQSiQWw9eQVqVShrFQTYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763073359; x=1763678159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h30VSnQHi4bPYHqpJ1DDcugPgpyo8jt9+e8fEtu4vhU=;
        b=NBMbX9UuV/+qoo9VDj6RFidju7NO6QlLsmVk8/locd5zoUayP+kQV+f3aq3VrxiOaN
         pRM0mAp6+oXbW0mAyL/09GcpiYl00BEs5svMUphLkmBELkriTUtSfBKWp1AZivQls7qZ
         G4P4n3wNKxDL3qae63/noFXUYvdm/z0HFbZnrTocBVNhmO536uLkZNjjJL96CBKaodA0
         +xNsZPrlDoVSrXymt+jYZc675bjwNLa3Y5XHPnGPwOMyqRDjlnemQcusCf87Rf9815ew
         5t9NjCDZXdIDrpz622cvUw2rtMVN9rgFLlRs5gV2XM3goa5ZA0myhYYqvwQd0G3eCF/b
         1Vlg==
X-Forwarded-Encrypted: i=1; AJvYcCVC7Zlu9NR9tDixrEcDEDkOsohmzz9wJ5/h9E4lAfRPaan5cT2QB58AoLdJp57u4pUTlcyaIjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDYU7jCzB+Cm+9Sa2vPFXv48cdONjXb2hC+MZNxPm1T1W4YvZ
	7vJSdKECShePm0hSUjaq+4NkLK2tS+AKIxOmHADiINMHO5kLzFVl8ChSZD5lPcLAjORvq6g5kqZ
	juGnvug==
X-Gm-Gg: ASbGncvtn68CYhWHCnI9PwsFZZCmEC2vOI2S4zRyotH6fFGG0phNJFNje0c7AmyMR/c
	tZ9t1vy4daRXR3jSR0X8XqrcFfOJAb/xJRQ6+sz9s9OUDP8Kpt3wLjRh2irFmnvp+3BAjfx/cq2
	gqDNvDy6TyFKPVQNRGNlimGoPrgjRRUpTiJaK+Wmdh1Muf1dnP6bp1/rPFs5WSckv+iTtB+laUc
	k8NiEb/4CE599Ku/BxBKXmMEWa8/J/jth7l4xGeknxkR6zZ1FoYagpo6uTx4SZsGz4f1xV08h6z
	QvCvP1Fp10LEX7BtOfy7E95+qYW+Qyvp131+B5xTaTUWY2A69Lpprz7JYweFgjftEWXSyhI5LvF
	fCik/aO9ksN5ZhAqPB+EICf3Quix6sPd3jPfTUDC/vmdBtV9cMl+sO2BtKpllzyr3Z034vqPWEm
	czWHCGxBA7hVwtEEK03pkb+VdyjmTRq5/4znrUzA==
X-Google-Smtp-Source: AGHT+IFCfbdTSes3OYtLmmxQjPTZc/I3mJxXtrM3VGNT8XKFXA37+LIwCB9z2cKmh19KcWpdoXKEjg==
X-Received: by 2002:a05:6512:3d05:b0:594:49ed:3ced with SMTP id 2adb3069b0e04-595842273c2mr299288e87.54.1763073358990;
        Thu, 13 Nov 2025 14:35:58 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b7a67sm652288e87.43.2025.11.13.14.35.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 14:35:58 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5942e61f001so1297946e87.1
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 14:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSam+bmRwSP47kQoj9822ao13AMMUxwFEhlv0m+8Wijx8bRKjP98R8/Aeq1DJZ2zUqmo7hKYY=@vger.kernel.org
X-Received: by 2002:a05:6512:1597:b0:591:c8de:467b with SMTP id
 2adb3069b0e04-59584209463mr317437e87.40.1763073356972; Thu, 13 Nov 2025
 14:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-uvc-fix-which-v1-1-a7e6b82672a3@chromium.org> <20251113215909.GG9135@pendragon.ideasonboard.com>
In-Reply-To: <20251113215909.GG9135@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Nov 2025 23:35:44 +0100
X-Gmail-Original-Message-ID: <CANiDSCs5ZcU8_8vZQumtLtPXod2swLuyzwZiV6u8bywx7ZF0bQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmaVztA46OPLtJzSKyIMRHfLXxFFMuCdSt3BgLwwD5VreTLlAY8KC-n1Cg
Message-ID: <CANiDSCs5ZcU8_8vZQumtLtPXod2swLuyzwZiV6u8bywx7ZF0bQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix support for V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Thu, 13 Nov 2025 at 22:59, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tue, Oct 28, 2025 at 05:55:10PM +0000, Ricardo Ribalda wrote:
> > The VIDIOC_G_EXT_CTRLS with which V4L2_CTRL_WHICH_(MIN|MAX)_VAL can only
> > work for controls that have previously announced support for it.
> >
> > This patch fixes the following v4l2-compliance error:
> >
> >   info: checking extended control 'User Controls' (0x00980001)
> >   fail: v4l2-test-controls.cpp(980): ret != EINVAL (got 13)
> >         test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> >
> > Fixes: 39d2c891c96e ("media: uvcvideo: support V4L2_CTRL_WHICH_MIN/MAX_VAL")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 11 +++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  9 ++++++---
> >  drivers/media/usb/uvc/uvcvideo.h |  2 +-
> >  3 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 2905505c240c060e5034ea12d33b59d5702f2e1f..2f7d5cdd18e072a47fb5906da0f847dd449911b4 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1432,7 +1432,7 @@ static bool uvc_ctrl_is_readable(u32 which, struct uvc_control *ctrl,
> >   * auto_exposure=1, exposure_time_absolute=251.
> >   */
> >  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> > -                        const struct v4l2_ext_controls *ctrls,
> > +                        const struct v4l2_ext_controls *ctrls, u32 which,
> >                          unsigned long ioctl)
> >  {
> >       struct uvc_control_mapping *master_map = NULL;
> > @@ -1442,14 +1442,21 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >       s32 val;
> >       int ret;
> >       int i;
> > +     bool is_which_min_max = (ioctl == VIDIOC_G_EXT_CTRLS &&
>
> Is the ioctl check needed, given that this function will be called with
> which set to V4L2_CTRL_WHICH_CUR_VAL if ioctl is not VIDIOC_G_EXT_CTRLS

Right now it is not needed. But I wanted to be on the protective side
here. Let me add a comment and remove the ioctl check.

> ?
>
> > +                              (which == V4L2_CTRL_WHICH_MIN_VAL ||
> > +                               which == V4L2_CTRL_WHICH_MAX_VAL));
>
> Let's move this up to have longer lines first.
>
> >
> >       if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
> > -             return -EACCES;
> > +             return is_which_min_max ? -EINVAL : -EACCES;
> >
> >       ctrl = uvc_find_control(chain, v4l2_id, &mapping);
> >       if (!ctrl)
> >               return -EINVAL;
> >
> > +     if ((!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) ||
> > +          !(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)) && is_which_min_max)
>
> Please put MIN before MAX.
>
> Do we have to bundle min and max, or could we handle them separately ?
> Something like

I believe we have to bundle min and max. Controls that support
VIDIOC_G_EXT_CTRLS with  V4L2_CTRL_WHICH_(MIN|MAX)_VAL have this flag:
V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX

```
Whether a control supports querying the minimum and maximum values
using V4L2_CTRL_WHICH_MIN_VAL and V4L2_CTRL_WHICH_MAX_VAL is indicated
by the V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX flag.
```




>
>         if ((which == V4L2_CTRL_WHICH_MIN_VAL &&
>              !(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)) ||
>             (which == V4L2_CTRL_WHICH_M1X_VAL &&
>             !(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)))
>                 return -EINVAL;
>
> > +             return -EINVAL;
> > +
> >       if (ioctl == VIDIOC_G_EXT_CTRLS)
> >               return uvc_ctrl_is_readable(ctrls->which, ctrl, mapping);
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 9e4a251eca88085a1b4e0e854370015855be92ee..d5274dc94da3c60f1f4566b307dd445f30c4f45f 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -765,6 +765,7 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *priv,
> >
> >  static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
> >                                struct v4l2_ext_controls *ctrls,
> > +                              u32 which,
>
> This fits on the previous line.
>
> >                                unsigned long ioctl)
> >  {
> >       struct v4l2_ext_control *ctrl = ctrls->controls;
> > @@ -772,7 +773,8 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
> >       int ret = 0;
> >
> >       for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> > -             ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, ioctl);
> > +             ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, which,
> > +                                          ioctl);
> >               if (ret)
> >                       break;
> >       }
> > @@ -806,7 +808,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *priv,
> >               which = V4L2_CTRL_WHICH_CUR_VAL;
> >       }
> >
> > -     ret = uvc_ctrl_check_access(chain, ctrls, VIDIOC_G_EXT_CTRLS);
> > +     ret = uvc_ctrl_check_access(chain, ctrls, which, VIDIOC_G_EXT_CTRLS);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -840,7 +842,8 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> >       if (!ctrls->count)
> >               return 0;
> >
> > -     ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
> > +     ret = uvc_ctrl_check_access(chain, ctrls, V4L2_CTRL_WHICH_CUR_VAL,
> > +                                 ioctl);
> >       if (ret < 0)
> >               return ret;
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index ed7bad31f75ca474c1037d666d5310c78dd764df..d583425893a5f716185153a07aae9bfe20182964 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -786,7 +786,7 @@ int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
> >                struct v4l2_ext_control *xctrl);
> >  int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
> >  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> > -                        const struct v4l2_ext_controls *ctrls,
> > +                        const struct v4l2_ext_controls *ctrls, u32 which,
> >                          unsigned long ioctl);
> >
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >
> > ---
> > base-commit: c218ce4f98eccf5a40de64c559c52d61e9cc78ee
> > change-id: 20251028-uvc-fix-which-c3ba1fb68ed5
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

