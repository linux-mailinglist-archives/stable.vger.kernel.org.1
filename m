Return-Path: <stable+bounces-92821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E017B9C5F06
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29992847B6
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C83B21500C;
	Tue, 12 Nov 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6MRz86y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5220896E
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432665; cv=none; b=CJiYwlAzGqU6KOayujVWIKp33I+5H3evID/n4EhZeJk85gbHcwDEmgRqU7KYBlijIg62g5vikJYOvBtmzxBxzPcsWLi6AZGAEzumsWZTdO28sZOBS7Ia/jZUaNHqP4+6PkkfqwI4YrzP12/3JvUg05xcStAN4ZGBBccavcYugcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432665; c=relaxed/simple;
	bh=uHvRxnCwxSPwoWBt7s6p7RnvISj6q1/A38c/hPBn/Oo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OYx0sKF3gL/ZHPhdey2F6uhATbmUuJ1jlqCkRxbERLgJNirUq2m9Lhn6CjEOdQDKDTl+6aqBzXt9eUjNWyHGNuLj65CvSswbymLrYrR51jTaQ5zDR1CbCfzeogRr8tui/a4ZviVyRW4nfCSyaB9MXcTn9Ioxi42FIXvrNeNh2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y6MRz86y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b147a2ff04so444970885a.3
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432660; x=1732037460; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNnLmwM6k2wna/0wjImN/u+vOWZSQ1LYfyw6a2jXzJ8=;
        b=Y6MRz86yPlcWXEfyD7YCtcJj35Kuevwrg9TnH7I4AIGVDnQZRAjgt1LgADTvnz4feS
         GH7nukySUTB8yRjxrDL6gwxxEtN0ddF+sOg8XwHxDk4qRJi9d7E8hd5hfMY4z9LrEzqt
         hCVQq0U4NPxcm8rK93EvpKZXq22xvtwU5iZmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432660; x=1732037460;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNnLmwM6k2wna/0wjImN/u+vOWZSQ1LYfyw6a2jXzJ8=;
        b=ceFoSw4XhjYmguzG44kemh5KtNS+EpDWhhFoJtw+y6ceoaCBJHAvhLWnATVhY5prD/
         uyXnZzPEI1hWRceZ3NM6mX2a6Z9ehUyZl7F2uWM6bPDShC0lG9J+/D3aVoA53QsPmWPo
         qqfs/4/5FngKwrAC0dL0D9kgwHL9cqg5kXgg6ZnNMtCwIwkze+PkjcNL7jhMHejzTP/J
         K9HQ8lIs0/1BffPrrIsm7URcek0dmX964McNjNuuMnL60q+3rrhwfsnK/psvFORD+NHg
         VEzZCMj8jC/dI6fFGTTgC2QSlqaErEYPs8y0OJdydsOwjv7ibaZy3eDLE9CBcV4O7ZPv
         cv9w==
X-Forwarded-Encrypted: i=1; AJvYcCW11aIxCEsJFGqt+z5a9riSu2YnmIZKFHgt6JCicV0eW1ZJJLIHtZWTGAxz3jBfMJ+fgUEXWw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuBOelYQROAY6fvn0+F+Pd1160PB1zwGfssxvJLb4Ohg2T/UW
	G3bRL7HLznN1p5vPLJoYnL6bbyCgsilnDLVyA5Ga6RBVsbtmQHoasPhES5ZAFA==
X-Google-Smtp-Source: AGHT+IEqc2TDtyerxS7bC/9aGU2bzWGZBxZv6iEwNKljp7OmEq6pHR5Uiz4/K5WvZFBjN8dhnkGfug==
X-Received: by 2002:a05:620a:4495:b0:7b1:5143:8da1 with SMTP id af79cd13be357-7b331f20600mr2305215085a.43.1731432660551;
        Tue, 12 Nov 2024 09:31:00 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:30:59 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a
 evdev
Date: Tue, 12 Nov 2024 17:30:43 +0000
Message-Id: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSQM2cC/13MSw7CIBSF4a2YOxZzL/SBjtyHcUCBtgxaDFiia
 bp3aRPjY3hO8n8zRBucjXDazRBsctH5MQ+x34Hu1dhZ5kzewJEXhALZlDSLU2NsYvLYFkVVK8S
 mhBzcgm3dY8Mu17x7F+8+PDc70fq+GfpmEjFkqpJCkLbG1Pys++AHNw0HHzpYpcQ/NaH8qXmuZ
 WmkwpKUMOKvXpblBSRkygLlAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

Some notebooks have a button to disable the camera (not to be mistaken
with the mechanical cover). This is a standard GPIO linked to the
camera via the ACPI table.

4 years ago we added support for this button in UVC via the Privacy control.
This has three issues:
- If the camera has its own privacy control, it will be masked.
- We need to power-up the camera to read the privacy control gpio.
- Other drivers have not followed this approach and have used evdev.

We tried to fix the power-up issues implementing "granular power
saving" but it has been more complicated than anticipated...

This patchset implements the Privacy GPIO as a evdev.

The first patch of this set is already in Laurent's tree... but I
include it to get some CI coverage.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- CodeStyle (Thanks Sakari)
- Re-implement as input device
- Make the code depend on UVC_INPUT_EVDEV
- Link to v2: https://lore.kernel.org/r/20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org

Changes in v2:
- Rebase on top of https://patchwork.linuxtv.org/project/linux-media/patch/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org/
- Create uvc_gpio_cleanup and uvc_gpio_deinit
- Refactor quirk: do not disable irq
- Change define number for MEDIA_ENT_F_GPIO
- Link to v1: https://lore.kernel.org/r/20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org

---
Ricardo Ribalda (8):
      media: uvcvideo: Fix crash during unbind if gpio unit is in use
      media: uvcvideo: Factor out gpio functions to its own file
      media: uvcvideo: Re-implement privacy GPIO as an input device
      Revert "media: uvcvideo: Allow entity-defined get_info and get_cur"
      media: uvcvideo: Create ancillary link for GPIO subdevice
      media: v4l2-core: Add new MEDIA_ENT_F_GPIO
      media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO entity
      media: uvcvideo: Introduce UVC_QUIRK_PRIVACY_DURING_STREAM

 .../userspace-api/media/mediactl/media-types.rst   |   4 +
 drivers/media/usb/uvc/Kconfig                      |   2 +-
 drivers/media/usb/uvc/Makefile                     |   3 +
 drivers/media/usb/uvc/uvc_ctrl.c                   |  40 +-----
 drivers/media/usb/uvc/uvc_driver.c                 | 112 +---------------
 drivers/media/usb/uvc/uvc_entity.c                 |  21 ++-
 drivers/media/usb/uvc/uvc_gpio.c                   | 144 +++++++++++++++++++++
 drivers/media/usb/uvc/uvc_status.c                 |  13 +-
 drivers/media/usb/uvc/uvc_video.c                  |   4 +
 drivers/media/usb/uvc/uvcvideo.h                   |  31 +++--
 drivers/media/v4l2-core/v4l2-async.c               |   3 +-
 include/uapi/linux/media.h                         |   1 +
 12 files changed, 223 insertions(+), 155 deletions(-)
---
base-commit: 1b3bb4d69f20be5931abc18a6dbc24ff687fa780
change-id: 20241030-uvc-subdev-89f4467a00b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


