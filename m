Return-Path: <stable+bounces-95428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA49D8CF4
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CDB16A4A5
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776EE1BF7FC;
	Mon, 25 Nov 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhzovlRw"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149317E00F
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564153; cv=none; b=C3qW87P5fLCpfGcXd5zRe1QZQoUr141vxrxfMFbuTK0F2GFSgX5NfAXxJqkArf5vIen3p9Gxx3qAsCI8LZRKq20A+XVfYj7rfEC/1vMbVaV+hIxu6o8qvFjppDZy0IAmbqZPxdVqjHsQShuyaclVvgZjgMMbheT8o7WNkDB0dhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564153; c=relaxed/simple;
	bh=b5FPROm5q+hhn5O8ELo7nAQdUkxygSxSN11xMKyLRL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U2GN7LjFyip9Q07gFRfxI+VZ/ZdHFI3Mu8uxqaXJvDwUVHlNKfNacHv2aEDEp/xLwEyIFb04Vq3CP4jQL2qxqqhuXi3tCEDXRvtWkLo0a2JG+gAU2Hg/u7XJNYueTf0VeybYodISEbN1+eYiscr89f0mHW6iG6Ggn2MkaqboqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hhzovlRw; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4af02dca8fbso600188137.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732564150; x=1733168950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3YMYMBOC1y/OpFUAEcUDMmPh9VN+m16GZQ7wshOyQQ=;
        b=hhzovlRwvhQSnH95FRtZNZtcu3T16hzvF+M/N5UVePR6kbP2Nu7TFJqoOaXX25f6xf
         JAkAl+RIiCEcurBtfqFV1dr/FS653NVDQMF/Sgaovoc6ROpuipxCp/fxkzzwPYrhZpN7
         IMCnS25WWhI0H4c907c+fF0bL+6cFbWQpmqFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564150; x=1733168950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3YMYMBOC1y/OpFUAEcUDMmPh9VN+m16GZQ7wshOyQQ=;
        b=h4rJ/zde2TM9SsOAXaFDgHaPwan3PTKWN8e4igk6Gdatv/rtKP/GrPpKlBfG1QrgDH
         IHfu3bbzVuGdP11aKE+cMhhgJ3gXuz+ZHtY/8ifN0/bizLuEd+0rFHWTg1tLqDqluO50
         /yMKzIBWrgwxZjTAswu7BrzZhlIYkHOvM9IY2zirOWPLr/73wrUXa8CUKPrsAJW2dTCq
         9bXzjufRYAbL+tfEHnHn2mpKKIBWawn1pHyKVdfkGEY5iFJytEgtXbROXhusb/ATcZ+6
         PjwuY7pv+ZqIlnrUgES0ka+sUk2AhxcJlEt4TDs3iuO6/O1v5e8+Elk1F5AwVqngNkno
         9Gog==
X-Forwarded-Encrypted: i=1; AJvYcCVPqQOSJcoC+qsyre7Nt84+xts1DRc52vPE6vKLJHwteFhoSnJvMRS+AddqqQhLx/INQa7iPSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywXg3v3DF08W32bg6Pi5qnzGc8FBB4l2sIpuNXUUwpuhBg9JIL
	L4rO7PQiISfEtBjHijygncGnXHRZEHOXBKEVAUxDWNQhCCCz5FvgVmzFps00sVTI6L6VFLdgJN0
	=
X-Gm-Gg: ASbGncsLMSYjsoEnbLmKoIeRA8UxRa1SUrrlMTHqwq0HDiF1TweLOsGKsGTtid15e5c
	l7aa2vvpB4MKLYTdMwJPvyuCJ90gmVpAr5rwYiumXae9U2NOQZ4QlkPy0R7M42BYNEDxmi6bZIE
	ChIZWWgJq09qIXb2c/BmigIudg7Yc0IQ3yXg1AmWgGsZIWmRkmo3CdERMHNxg3qKUNZlcuPFnAV
	wqvKnnn3LVkuULp4TTLufGsciDh4Wg2yzkC4XFLpfdrFtRNynCpTtJMkRWg9E8uePB94ICkl01k
	8Nf6msXcXVaFmUmETiIHwSzw
X-Google-Smtp-Source: AGHT+IF3i1DjM+8L9Am+OLgfA3D5+6d98KCXkJXVzSCq96ElUU+smooe1wy5gMqeM1C6j6UluK1rdw==
X-Received: by 2002:a05:6102:3ec7:b0:4a3:c9b6:b311 with SMTP id ada2fe7eead31-4addcedab68mr14866884137.26.1732564150629;
        Mon, 25 Nov 2024 11:49:10 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358d2f9asm75324137.23.2024.11.25.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:49:09 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/7] media: uvcvideo: Implement the Privacy GPIO as a
 evdev
Date: Mon, 25 Nov 2024 19:49:05 +0000
Message-Id: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHURGcC/23M0Q6CIBiG4VtxHEf7f0CljrqP1gECKgdqg2Q15
 72Hbi1tHX7f9rwTCdY7G8g5m4i30QU39GmIQ0Z0q/rGUmfSJgyYQOBAx6hpGCtjI5WnWoiiVAB
 VThK4e1u75xq73tJuXXgM/rW2Iy7vJ4PbTEQKVBWSc9TWmJJddOuHzo3dcfANWUqRfTWC3GmWt
 MyNVJCj4ob/0Xyjke00TxqsyktuBCqUP3qe5zetVcoBIwEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
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
Changes in v4:
- Remove gpio entity, it is not needed.
- Use unit->gpio.irq in free_irq to make smatch happy.
- Link to v3: https://lore.kernel.org/r/20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org

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
Ricardo Ribalda (7):
      media: uvcvideo: Fix crash during unbind if gpio unit is in use
      media: uvcvideo: Factor out gpio functions to its own file
      media: uvcvideo: Re-implement privacy GPIO as an input device
      Revert "media: uvcvideo: Allow entity-defined get_info and get_cur"
      media: uvcvideo: Introduce UVC_QUIRK_PRIVACY_DURING_STREAM
      media: uvcvideo: Make gpio_unit entity-less
      media: uvcvideo: Remove UVC_EXT_GPIO entity

 drivers/media/usb/uvc/Kconfig      |   2 +-
 drivers/media/usb/uvc/Makefile     |   3 +
 drivers/media/usb/uvc/uvc_ctrl.c   |  40 ++---------
 drivers/media/usb/uvc/uvc_driver.c | 123 ++--------------------------------
 drivers/media/usb/uvc/uvc_entity.c |   7 +-
 drivers/media/usb/uvc/uvc_gpio.c   | 134 +++++++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvc_status.c |  13 +++-
 drivers/media/usb/uvc/uvc_video.c  |   4 ++
 drivers/media/usb/uvc/uvcvideo.h   |  43 +++++++-----
 9 files changed, 195 insertions(+), 174 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241030-uvc-subdev-89f4467a00b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


