Return-Path: <stable+bounces-100385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA79EACBC
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A503F1889E09
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8AB2343B3;
	Tue, 10 Dec 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4dh7uS4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AC2343A0
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823764; cv=none; b=RhVme4Xs/8XacHyprQOgoqcicI3FDvUXq+YS2hd9qsoQIqvNU8BpyMeNzI7dpC6Sxeg6cT52f7uEfiSukXXvIKxjeQU2HR434rk4PY+LME/UtiM8Ap3TTqkvLg9m7f+mwb9t/uekEcagHHl8wEk1e21s8uUr6BilWiVR98j1v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823764; c=relaxed/simple;
	bh=W4n9/zH+C/vvYGNZa9XYCEv4xPGGQ5hRlN9Wv2h4Srg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rpFId1kdj+bJn9HlZzHhacJm+6YYeCX3gVDeAtdfe3cIk3P+L8As1h9KR2hn823ncVvLVziACxqdcubEI5wvzDXEZZK9oAN54pOk0q1GhdDbfaCe3r9cdpB875iK90dAczh4OFagn/LtOvmSFURJ33HYYmc7yXjkMd1eWkzghAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e4dh7uS4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d896be3992so27168276d6.1
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 01:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823761; x=1734428561; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPMHAf/hxZCUfpZdyOFGEvnrV8VlCcY6UDqHBjaMUmE=;
        b=e4dh7uS4NWpG2Jt/PABrxPy0qKkGEP58OW/PYAi+wrpQlZ8ifSKI26Yi2UpZxYMbzp
         j6itFkQ+bCdkRzmL1m6z45IOhx/ZNq7oiERDPY/cjtk+YskaAC+V3J68juu23s3Yt/j5
         lkGegDbFY7L6MqNDh9jgXCZDcH7HMQ8a3BksM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823761; x=1734428561;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPMHAf/hxZCUfpZdyOFGEvnrV8VlCcY6UDqHBjaMUmE=;
        b=o/isv00B+ijykcpZUl4v8V2Mje20McGbt+UnADDjvSU66qcBg2oMcNO9iGgu3Pty3J
         uMT/jKgU5q+GSNkjuKjGfQpSRPqEkU6CnSLvaw0Rn9DECjxcjIfgDbTpcbaXgOgmIIHM
         AFxT+7EvvLRN2PblfB3Q8L0lJ7ELRWEDE/K0QeR6CB8s7fnBDuCudSiTCA7ets00y01D
         d0QfzjsU9tSDgaFGf5HsGD6ipABcPVt3tRer9acgwkx/MU7kbhCGYdyCyKZGtCZM7Ilm
         Xq35YwV+CgZDvs1iC1bAM02UHERT7LaMMPaDEe5rez0zL8WcOteUbVPZlMn8LTcPPPZo
         k+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZZICnDdPHLtMUkLtV4ZuhdArB2fIiSvrYqHAS1gHWt58SrTTqy9qIcCuhUlHRnEBq4IjkE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzctQWiZw5fSlL6As2PMugrfhcrqLmx7/Ir+J6OFhvvh8jZthF
	ePA2YpA2Zv1cR4TPeh6LKNzl3ruACAwcMnB3lyWIgLgmMB31whUGX6pijwDVJlxzxERHrqZhP1M
	=
X-Gm-Gg: ASbGncvvszC+1iO+yLphWTMUWD4aNAbJRhfBajGpyrPr83Z6cyPmL3oaVwI0678ICo/
	9F65Mc/Njrl+wpbLV23FUV//Odw2ImYXSR2qUUVgmeRXRpWhdFiHQHzhJCXKx9rJDOHeAirKmcx
	skAWBX9t5uGN/29rZUdVlBCfQWkFgKqck4U05+1NA0A86EbDeKWLwuDbsFWCUxx/qSMwViNQDGm
	orOnfUFzpjMvMPo+GYLs4eptu5c7IxbB5rLUS99FjMrJ7pBkO2svN4/qnwlVjVyG4QOBEEPTePj
	LmX6KyoVz80NEcSoCUYbZb8x7I0i
X-Google-Smtp-Source: AGHT+IE9ymMf+noLkzf+qA5yR3o7IoBnW5uGgs2prn2pjidiCE98XTIoDpUPwhIWGAOjLqWqLeFVTw==
X-Received: by 2002:a05:6214:d8d:b0:6cd:ec00:205e with SMTP id 6a1803df08f44-6d91e161552mr70084316d6.0.1733823761093;
        Tue, 10 Dec 2024 01:42:41 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:39 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v16 00/18] media: uvcvideo: Implement UVC v1.5 ROI
Date: Tue, 10 Dec 2024 09:42:36 +0000
Message-Id: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA0NWGcC/z2MQQ6CMBBFr0JmbQ3FMjGuvIdhAWVKZwE1U2g0p
 He3kujyvf/zdogkTBFu1Q5CiSOHpYDGUwXW98tEiscioKkbo7W+qC1ZJYEV4jCidb0mNFDeTyH
 HryP16Ap7jmuQ91FOuv3qX8T8I2VQtUJjHQ0tDuiud+slzLzN5yATdDnnDx9v8bKkAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Yunke Cao <yunkec@google.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
X-Mailer: b4 0.13.0

This patchset implements UVC v1.5 region of interest using V4L2
control API.

ROI control is consisted two uvc specific controls.
1. A rectangle control with a newly added type V4L2_CTRL_TYPE_RECT.
2. An auto control with type bitmask.

V4L2_CTRL_WHICH_MIN/MAX_VAL is added to support the rectangle control.

The corresponding v4l-utils series can be found at
https://patchwork.linuxtv.org/project/linux-media/list/?series=11069 .

Tested with v4l2-compliance, v4l2-ctl, calling ioctls on usb cameras and
VIVID with a newly added V4L2_CTRL_TYPE_RECT control.

This set includes also the patch:
media: uvcvideo: Fix event flags in uvc_ctrl_send_events
It is not technically part of this change, but we conflict with it.

I am continuing the work that Yunke did.

Changes in v16:
- add documentation
- discard re-style
- refactor -ENOMEM
- remove "Use the camera to clamp compound controls"
- move uvc_rect
- data_out = 0
- s/max/min in uvc_set_rect()
- Return -EINVAL in uvc_ioctl_xu_ctrl_map instead of -ENOTTY.
- Use switch inside uvc_set_le_value.
- Link to v15: https://lore.kernel.org/r/20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org

Changes in v15:
- Modify mapping set/get to support any size
- Remove v4l2_size field. It is not needed, we can use the v4l2_type to
  infer it.
- Improve documentation.
- Lots of refactoring, now adding compound and roi are very small
  patches.
- Remove rectangle clamping, not supported by some firmware.
- Remove init, we can add it later.
- Move uvc_cid to USER_BASE

- Link to v14: https://lore.kernel.org/linux-media/20231201071907.3080126-1-yunkec@google.com/

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Hans Verkuil (1):
      media: v4l2-ctrls: add support for V4L2_CTRL_WHICH_MIN/MAX_VAL

Ricardo Ribalda (11):
      media: uvcvideo: Fix event flags in uvc_ctrl_send_events
      media: uvcvideo: Handle uvc menu translation inside uvc_get_le_value
      media: uvcvideo: Handle uvc menu translation inside uvc_set_le_value
      media: uvcvideo: refactor uvc_ioctl_g_ext_ctrls
      media: uvcvideo: uvc_ioctl_(g|s)_ext_ctrls: handle NoP case
      media: uvcvideo: Support any size for mapping get/set
      media: uvcvideo: Factor out clamping from uvc_ctrl_set
      media: uvcvideo: Factor out query_boundaries from query_ctrl
      media: uvcvideo: let v4l2_query_v4l2_ctrl() work with v4l2_query_ext_ctrl
      media: uvcvideo: Introduce uvc_mapping_v4l2_size
      media: uvcvideo: Add sanity check to uvc_ioctl_xu_ctrl_map

Yunke Cao (6):
      media: v4l2_ctrl: Add V4L2_CTRL_TYPE_RECT
      media: vivid: Add a rectangle control
      media: uvcvideo: add support for compound controls
      media: uvcvideo: support V4L2_CTRL_WHICH_MIN/MAX_VAL
      media: uvcvideo: implement UVC v1.5 ROI
      media: uvcvideo: document UVC v1.5 ROI

 .../userspace-api/media/drivers/uvcvideo.rst       |  64 ++
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |  26 +-
 .../userspace-api/media/v4l/vidioc-queryctrl.rst   |  14 +
 .../userspace-api/media/videodev2.h.rst.exceptions |   4 +
 drivers/media/i2c/imx214.c                         |   4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |   9 +-
 drivers/media/test-drivers/vivid/vivid-ctrls.c     |  34 +
 drivers/media/usb/uvc/uvc_ctrl.c                   | 799 ++++++++++++++++-----
 drivers/media/usb/uvc/uvc_v4l2.c                   |  77 +-
 drivers/media/usb/uvc/uvcvideo.h                   |  25 +-
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |  54 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          | 167 ++++-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   4 +-
 include/media/v4l2-ctrls.h                         |  38 +-
 include/uapi/linux/usb/video.h                     |   1 +
 include/uapi/linux/uvcvideo.h                      |  13 +
 include/uapi/linux/v4l2-controls.h                 |   7 +
 include/uapi/linux/videodev2.h                     |   5 +
 18 files changed, 1058 insertions(+), 287 deletions(-)
---
base-commit: 5516200c466f92954551406ea641376963c43a92
change-id: 20241113-uvc-roi-66bd6cfa1e64

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


