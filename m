Return-Path: <stable+bounces-121266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE727A54F91
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD04188AC59
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E401FDE37;
	Thu,  6 Mar 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xu7wHIDE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202312F5A5
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276266; cv=none; b=byPyFTX4WIWdBhu6aQVFbUPLj6yfECjnlgLYUZF4h+hmuHV+NZ9sds6GorW1s7YQfYdRmo8JxaenRQGMGMgN9ukpGUtQD2XhyCC++t7C9otdn5E7kiQfd91yHxkbtxF8D07RvvmKVft5YFtQyiGeL9Mhq4BWk8GkXq1lVmyXCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276266; c=relaxed/simple;
	bh=6/eshPQTJ88U2E8tAaABEc0mBxrlK9eSvRujOfacHCU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=coaRvAv/e4dq/eteqrG1s9la19ZpkgukoiSfmfbkMM8dTRyjiv6HSY+5+8S7OSntk3AZ1U+b2CdS3o4Dz8r7gKudEddS/Mlgq2HvWuZGg+FfBidSJwUAUDsM3ohhMXG9syJeF2apqQvbcp8eNLnWd/f9CjGF9XaGm9ClJwzHDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xu7wHIDE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c24ae82de4so91046185a.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741276264; x=1741881064; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMbnC32xMkkNtpNE5OTsWUJHP+Zfh4wWIQQTgHHZzVc=;
        b=Xu7wHIDENqS09TMlJ8kpd7PYRqY5kXbNVLeAHyjW9VFS/MtDqwAEoqAYI9EqLswSw5
         lcc2fmnhSGXscSlFFJerbgn/51ajt+dpi21jTFfFxksQUNT05DtairqWkYOSaSF6QyTN
         HHk597kq26E1w52L7HyBK1mCAHwnYp/DJLtDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276264; x=1741881064;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMbnC32xMkkNtpNE5OTsWUJHP+Zfh4wWIQQTgHHZzVc=;
        b=h/UNuHS8fstmBMqa/7njAIEbn+mUyrRvSY+1SekpUWmHsWeVW/4grSi6GcifRTOwue
         smfrQJqJiMFwlxswzds1Z0XtbwflbdjjSHU/hBIkSBPbqZzyr9r94HKHK6DKeJ/8l29S
         T/CveR14WK161NxM3Gch+FVxswQlLCfQNNRrg+YahPdkGXIXt0vDq0GCSPshzlR8vpyB
         AuIP8/QNrEqdlFwnAFFpWOwBirmD6HwDWbiUL9HQURVRd9zv/p1VEHZDrcw++UMXO+Xz
         Lx5Mhss9+CBIUsPW78D/4kktECjG+EQu8qwM5JdALIN1YrNa3C0ZpuPVzI1+HPttZHeC
         MHxg==
X-Forwarded-Encrypted: i=1; AJvYcCVEsVNor26+r9FdBH6KDwCh79wicWqqTnR8MKXXMfS6MdAzXXd9mQTMwptYhQemHMoOgW8LMPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpE0EAOyk9TxduiL65afqgWFMaVEw7blzeQ2jvUMuxXPY9HRF
	FjhKcv88/ylH5UzUsuBIWPzVFFyHvlOBnrfwE03RY/7Xhj6r8oC3VlnXF8Qceg==
X-Gm-Gg: ASbGnctcRmE2QN3YtU1J+ERLZwhVuxDgnv4OGCiLrENJW20EsNaNv4b1m4iCyLF8aKL
	ZoTaJzyEDQ2i0TG1mzMI7gLiTh2SrZGp810NFOCrYW6GS0QZhI7gscatfLvbVPw4l3h8pWQ4rEc
	YjfKMdVc/WOCdV4Sy4u/PhEhyoAd60yq+DNc59+YMUOXVaFsQGi+VyNBzR5uXZxAcduOTkBiQOn
	Oc21yWHSnRRU0Y6ET556jw4j3FJJZiKWNR7EGMYdvy0BSzhSYrxR4bvn+dHGwIVR3lpmwErsGcz
	rL4J1RDMe2fRh3bPgOEbOTaxCz1KEF0LxBCTTyT6ZYk3teQmyrXm+2J7AU3NFnvRIauQwT4Ty94
	D0h6/FUCCFUHFl0D0FX+7gA==
X-Google-Smtp-Source: AGHT+IH24KmuxGN+n2gl5zVRmv9+jF9yqy4bvzwQUqbaRmvUqLbrFB/O+ZtC7Gu9XeQA0kdFZZGpLg==
X-Received: by 2002:a05:620a:6190:b0:7c3:d2f7:ca5e with SMTP id af79cd13be357-7c3d8bd27e5mr1112875785a.12.1741276264174;
        Thu, 06 Mar 2025 07:51:04 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm106257585a.6.2025.03.06.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:51:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/3] media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM
 + other meta fixes
Date: Thu, 06 Mar 2025 15:51:00 +0000
Message-Id: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTEyWcC/3XMQQ7CIBCF4as0sxbTTgpGV97DdIEwLbOgGKBE0
 3B3sXuX/0vet0OiyJTg1u0QqXDisLbAUwfG6XUhwbY1YI+yR1RiK0Z4ytrqrAXShcZRXpWyBO3
 yijTz++AeU2vHKYf4OfQy/NY/UBnEIJSxaiZJBs3zblwMnjd/DnGBqdb6BaBrwdKrAAAA
X-Change-ID: 20250226-uvc-metadata-2e7e445966de
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

This series introduces a new metadata format for UVC cameras and adds a
couple of improvements to the UVC metadata handling.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Add metadata invalid fix
- Move doc note to a separate patch
- Introuce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
- Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org

---
Ricardo Ribalda (3):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: Documentation: Add note about UVCH length field
      media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM

 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../userspace-api/media/v4l/metafmt-uvc-custom.rst | 30 ++++++++++++++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |  4 ++-
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 40 ++++++++++++++++++----
 drivers/media/usb/uvc/uvc_video.c                  | 12 +++----
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 8 files changed, 77 insertions(+), 13 deletions(-)
---
base-commit: 36cef585e2a31e4ddf33a004b0584a7a572246de
change-id: 20250226-uvc-metadata-2e7e445966de

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


