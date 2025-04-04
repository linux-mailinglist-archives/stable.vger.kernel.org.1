Return-Path: <stable+bounces-128279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED189A7B7D7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54B23B61A9
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7D188A3A;
	Fri,  4 Apr 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lua6EUnN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C242AB4
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748661; cv=none; b=ViVxW/0ikZSvusKVRRIFnlKXJ8owhJP5Xo1863xvCk04LE/4H0mhXogAf/dQKq8VGUyDT0TvVWifg06F6W+EpSEIIIDdkAXQ6nqZrhvyzb954x7oV0ccQllzvNBEHqebyL4xMHpe50bgtuR/nq0a1lZ8BQQQGKFluhN3gqMWNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748661; c=relaxed/simple;
	bh=dRcNcXMhQCLQSc8KolpqK0jy3kQMHaeA6z8Dx0eFyNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DmB0G228OwFxN/QbpJHp959ml1pzw1YKytwPBnFuU5XmBEYsK3xtPlHc3wPELQqQVM5nA1uSM0FfNaUUaLileb3E1+gY/trGWNByYsb8kz1WSRhOKJqpQnKEtbES4jY+RlqSXx6ZsRz2Puer25yS98lRuxZX2q631q4PuPKBNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lua6EUnN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54addb5a139so1863478e87.0
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743748657; x=1744353457; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2/0MoQri2+kgKRxHCnO5QrE0iduVLuICWxx2heDZSo=;
        b=lua6EUnNIp42CF4fHgE1cVjU7MIZye6Jqk9SgwfvRSHd4/DpUUABYRo+j9phh788v0
         crENzkRXA0AeCUyjbE9SBRLtki94/2taQXJG3UNceu8wuz6DC3hOgvR1vHMJLGtBgCLM
         y/TR28oQLUb9OP4W9/op2++IotqXEhIMrGCy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743748657; x=1744353457;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2/0MoQri2+kgKRxHCnO5QrE0iduVLuICWxx2heDZSo=;
        b=PdeRufp0PBfagl/A1R+pFQRq84YK7m3Yo8Z+kVj2VQJT3/asUsP9jQmLSbkvqjeO0l
         kw6DN7QMEuBaJf5lnukwnztxcS/AlYtkTt3VsQO1cwFWai5+gbhBIjca+2q0Yg9EgrBH
         y5apLa+5lMc0i8J/Lfrxi6glr2Pd8h+uWc10j3OrtW3G2xTfww88J6kjiZqrVGjHAJfE
         2MhqMF3IPI7Qzp88R2XwTMQ6OmK267O0CpV9p8I3KlIyLzUJkEqHTqUOgUfygrC3BVxC
         XukM9a1lybTy5CBHn6WZdo95HEa2at3ALeiIlw6pJF3PuvPWMvOdrM0f2qApz9z+Qbhe
         51QA==
X-Forwarded-Encrypted: i=1; AJvYcCXwKF9VwQq4fi97a6DhWUXjUhjFiQnnOkrD4NC3XS5TlJg+850lakrQ4FQkaXGjzKLWZGoLNT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCZvCh7EVAh646ZtBPl1WqhawMWBxoGOBiORElZ97PFbxOiEs
	YGaqNhV7zg+gmTqXzXwPnbM6nDL2fx2zrpgouetDkh1pN/3ZiZRWKHYz66H5aw==
X-Gm-Gg: ASbGncvMKRCubKuSnhjxaDU/XDLmCtdTJLvAoMQ0/rRuIBLleSu6ugVBXjpqN1b4eDS
	cZ7bgmC33SNLl99OefGQY/jbVq5Do9CKzDCzScAs3EDaLWoWT5erQp8HdX7esgkBwIAsXZdyWDS
	qbuTweunnLGcxB5OmVrLxHfodV0aswor0IYrZbb/oX+X3AIizbUGzfzYVEafbMhj6XTg74Wv8ER
	dHh4n1NXtI91Q7Rx5ZZ6kHKsC37yUHELPLjqqOkxuBp9PewbbDdYHbmxjhOf/pN/Tlx7GvNGLVJ
	bqTiyBb7bS4RdU++tNeUlXXx6133TLZNn7e4acSHUCvm/mwqMq2nbA6z/x+wDy+T7GzW8nJyENQ
	oQexa6M85NEq3AiGj1FfetXMLAB45l7pAObY=
X-Google-Smtp-Source: AGHT+IEOmx3SeghSSudCtmkKz07r0+wsw6tchEuaUxXFBzVyqDR4IR4qqRks8m0vtjYZGMsLKvWevQ==
X-Received: by 2002:a05:6512:15a6:b0:542:28b4:23ad with SMTP id 2adb3069b0e04-54c22776e3amr581480e87.16.1743748657175;
        Thu, 03 Apr 2025 23:37:37 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672444sm338275e87.251.2025.04.03.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 23:37:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/4] media: uvcvideo: Introduce
 V4L2_META_FMT_UVC_MSXU_1_5 + other meta fixes
Date: Fri, 04 Apr 2025 06:37:33 +0000
Message-Id: <20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1+72cC/23MQQ7CIBCF4as0sxaDlCnalfcwXRA6llm0GGiJp
 uHuYtcu/5eXb4dEkSlB3+wQKXPisNTAUwPO22UiwWNtUFKh1LIVW3ZiptUKQuyMaceLsgT1/or
 05PdBPYbantMa4ueQs/6tf5CshRRXY6zttMGbwbvzMcy8zecQJxhKKV+xnqynowAAAA==
X-Change-ID: 20250403-uvc-meta-e556773d12ae
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

This series introduces a new metadata format for UVC cameras and adds a
couple of improvements to the UVC metadata handling.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Fix codestyle and kerneldoc warnings reported by media-ci
- Link to v4: https://lore.kernel.org/r/20250403-uvc-meta-v4-0-877aa6475975@chromium.org

Changes in v4:
- Rename format to V4L2_META_FMT_UVC_MSXU_1_5 (Thanks Mauro)
- Flag the new format with a quirk.
- Autodetect MSXU devices.
- Link to v3: https://lore.kernel.org/linux-media/20250313-uvc-metadata-v3-0-c467af869c60@chromium.org/

Changes in v3:
- Fix doc syntax errors.
- Link to v2: https://lore.kernel.org/r/20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org

Changes in v2:
- Add metadata invalid fix
- Move doc note to a separate patch
- Introuce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
- Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: Documentation: Add note about UVCH length field
      media: uvcvideo: Introduce V4L2_META_FMT_UVC_MSXU_1_5
      media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META

 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../media/v4l/metafmt-uvc-msxu-1-5.rst             | 23 +++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |  4 +-
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 97 ++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_video.c                  | 12 +--
 drivers/media/usb/uvc/uvcvideo.h                   |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/linux/usb/uvc.h                            |  3 +
 include/uapi/linux/videodev2.h                     |  1 +
 10 files changed, 131 insertions(+), 13 deletions(-)
---
base-commit: 4e82c87058f45e79eeaa4d5bcc3b38dd3dce7209
change-id: 20250403-uvc-meta-e556773d12ae

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


