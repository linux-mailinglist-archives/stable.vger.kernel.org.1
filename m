Return-Path: <stable+bounces-100107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F29E8E13
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 09:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D16528194E
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB3721A92D;
	Mon,  9 Dec 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m1Riq1Ob"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC904218EA4
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734403; cv=none; b=osXf5YPIv0ba+rFpl1l+ZoaHOuly4NtrzFuWSVulpCeX8Jw0NRrLlr8UBmP3IW5hlQJa3LXC2HDIsilrtXLjFLAR0sWIT192ODJyDjxE2A7K5GOtDVRed4arcZBKelqGQa7MbufpkteprTu/wTyC2rbsg8vbO5mcYm8UKTtYAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734403; c=relaxed/simple;
	bh=XrkuNBaA2KFMauWBm/RYoNs/Hm4MI1nuYtz383nCUnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw1CpxsLccUJUqzjc+1fVX8kmH3kw934jnGVyXSwZp93JIRxS2ifR0kqf/9Oa5WtlbscC/ZiDIIov+tBkGkMSPKeXpm0dh5HmI0sAEMuKG/lNZxjxZUHGqOy91O1LvPL1HP3owkQIl7PyNN5KqiGmCPcn7j/LMISrj2XCTw4jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m1Riq1Ob; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eff5ad69a1so13886337b3.3
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 00:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733734400; x=1734339200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPUVctTsNe0r6IsZecNZEOZeVyvwjX2Ivrhtlu3S+Ng=;
        b=m1Riq1Obkeyq66a0uWBWl87D3iF+0UYJyBeGdcUE4i6L7dc3rueA8h/IRa5tVYuOx0
         3cWb4ba5zP3y2ohKTQb2MNpSk+b+SFfp+Dyi8B9/rTFwq0cSkbtZKxyj//lsZeMW0w2I
         SX3DKczqVp/duExuM686q9uXAx4Tfed+JL0Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734400; x=1734339200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPUVctTsNe0r6IsZecNZEOZeVyvwjX2Ivrhtlu3S+Ng=;
        b=X5EGKuV6snTIPW6RZO0hHq7Vm+sfg0wkLJ7Jwr2CWR6E+dpxZ4gYo4M9ut3++dmMUF
         cNYhcHISDtZkSIGvyyoPgufHPuDSyZVdaxHu+GkYbECZsBU80De0vT2EejaoDO57jLPp
         GxDXdtuW279dW3uk0YzZvjo3Lis9Ty05yLm4zoomlWc7OsjbdpzzpHnlw0abTkY//FxL
         uWlWO4D0BgHb0Wn0wg2xVK/iFNNhJg1oYyQ3YKHrcIUC9O82XA5bYvxeyOK6OJLIQ6LI
         kZjn1sfvxkOO3s5PEG23DrOKdcQEuIM4qLraAXEwNPpQLU6qwKe9ocerXXQzyP6+NViu
         LnXA==
X-Forwarded-Encrypted: i=1; AJvYcCXhPU8W7U2QvVx4URAU2863suyskK/F2w3C4PbS0VjBMHrrEadFX2tdzUnqFkyz8uSRsy338RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3VfFG4js9od7iaADue26hzSX6B858abPX5E2WJBDuNr3liP3
	SJBYchmLrp68XQ8Iwve+sDeXDHYCNB8HUMo0u3A8BgGIna18YkHt1CHAYTVK7w8aPrzYb5PWZC4
	GvTK9CRJOjstAuweW+B/Pc3XWmbz5b2M6o+bY
X-Gm-Gg: ASbGnctfZrsNOh1CV6rmjtOxynOlFBhXEqigtB8KFSoW65m780bhDumqYHsxyq0sppx
	92KEwsZkluvyVj+CxTFHqaiRFnokca7M=
X-Google-Smtp-Source: AGHT+IGwuFimavtR5bh3h9P+zvQY5iOG73cLkemO+XKYDlhb2TDqMuz/IxiB1BILzRlt/SAPe4mvu0sMF8C4J4ccZ9k=
X-Received: by 2002:a05:690c:7088:b0:6e5:9cb7:853c with SMTP id
 00721157ae682-6efe3c836b8mr98477407b3.31.1733734399790; Mon, 09 Dec 2024
 00:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
From: Yunke Cao <yunkec@chromium.org>
Date: Mon, 9 Dec 2024 17:53:08 +0900
Message-ID: <CAEDqmY5nuJQkv-J6WgyqXG7J1GR+8Sa3wzXQ7RpDMUrdDgTOKg@mail.gmail.com>
Subject: Re: [PATCH v15 00/19] media: uvcvideo: Implement UVC v1.5 ROI
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yunke Cao <yunkec@google.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Daniel Scally <dan.scally@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

I've tested the patchset with the fix I commented on in patch 18/19 on
Chrome OS and verified that the region of interest works as expected.

Tested-by: Yunke Cao <yunkec@google.com>

Best,
Yunke

On Fri, Nov 15, 2024 at 4:10=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> This patchset implements UVC v1.5 region of interest using V4L2
> control API.
>
> ROI control is consisted two uvc specific controls.
> 1. A rectangle control with a newly added type V4L2_CTRL_TYPE_RECT.
> 2. An auto control with type bitmask.
>
> V4L2_CTRL_WHICH_MIN/MAX_VAL is added to support the rectangle control.
>
> The corresponding v4l-utils series can be found at
> https://patchwork.linuxtv.org/project/linux-media/list/?series=3D11069 .
>
> Tested with v4l2-compliance, v4l2-ctl, calling ioctls on usb cameras and
> VIVID with a newly added V4L2_CTRL_TYPE_RECT control.
>
> This set includes also the patch:
> media: uvcvideo: Fix event flags in uvc_ctrl_send_events
> It is not technically part of this change, but we conflict with it.
>
> I am continuing the work that Yunke did.
>
> Changes in v15:
> - Modify mapping set/get to support any size
> - Remove v4l2_size field. It is not needed, we can use the v4l2_type to
>   infer it.
> - Improve documentation.
> - Lots of refactoring, now adding compound and roi are very small
>   patches.
> - Remove rectangle clamping, not supported by some firmware.
> - Remove init, we can add it later.
> - Move uvc_cid to USER_BASE
>
> - Link to v14: https://lore.kernel.org/linux-media/20231201071907.3080126=
-1-yunkec@google.com/
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Hans Verkuil (1):
>       media: v4l2-ctrls: add support for V4L2_CTRL_WHICH_MIN/MAX_VAL
>
> Ricardo Ribalda (12):
>       media: uvcvideo: Fix event flags in uvc_ctrl_send_events
>       media: uvcvideo: Handle uvc menu translation inside uvc_get_le_valu=
e
>       media: uvcvideo: Handle uvc menu translation inside uvc_set_le_valu=
e
>       media: uvcvideo: refactor uvc_ioctl_g_ext_ctrls
>       media: uvcvideo: uvc_ioctl_(g|s)_ext_ctrls: handle NoP case
>       media: uvcvideo: Support any size for mapping get/set
>       media: uvcvideo: Factor out clamping from uvc_ctrl_set
>       media: uvcvideo: Factor out query_boundaries from query_ctrl
>       media: uvcvideo: Use the camera to clamp compound controls
>       media: uvcvideo: let v4l2_query_v4l2_ctrl() work with v4l2_query_ex=
t_ctrl
>       media: uvcvideo: Introduce uvc_mapping_v4l2_size
>       media: uvcvideo: Add sanity check to uvc_ioctl_xu_ctrl_map
>
> Yunke Cao (6):
>       media: v4l2_ctrl: Add V4L2_CTRL_TYPE_RECT
>       media: vivid: Add a rectangle control
>       media: uvcvideo: add support for compound controls
>       media: uvcvideo: support V4L2_CTRL_WHICH_MIN/MAX_VAL
>       media: uvcvideo: implement UVC v1.5 ROI
>       media: uvcvideo: document UVC v1.5 ROI
>
>  .../userspace-api/media/drivers/uvcvideo.rst       |  64 ++
>  .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |  26 +-
>  .../userspace-api/media/v4l/vidioc-queryctrl.rst   |  14 +
>  .../userspace-api/media/videodev2.h.rst.exceptions |   4 +
>  drivers/media/i2c/imx214.c                         |   4 +-
>  drivers/media/platform/qcom/venus/venc_ctrls.c     |   9 +-
>  drivers/media/test-drivers/vivid/vivid-ctrls.c     |  34 +
>  drivers/media/usb/uvc/uvc_ctrl.c                   | 805 +++++++++++++++=
+-----
>  drivers/media/usb/uvc/uvc_v4l2.c                   |  77 +-
>  drivers/media/usb/uvc/uvcvideo.h                   |  25 +-
>  drivers/media/v4l2-core/v4l2-ctrls-api.c           |  54 +-
>  drivers/media/v4l2-core/v4l2-ctrls-core.c          | 167 ++++-
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   4 +-
>  include/media/v4l2-ctrls.h                         |  38 +-
>  include/uapi/linux/usb/video.h                     |   1 +
>  include/uapi/linux/uvcvideo.h                      |  13 +
>  include/uapi/linux/v4l2-controls.h                 |   9 +
>  include/uapi/linux/videodev2.h                     |   5 +
>  18 files changed, 1062 insertions(+), 291 deletions(-)
> ---
> base-commit: 5516200c466f92954551406ea641376963c43a92
> change-id: 20241113-uvc-roi-66bd6cfa1e64
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>

