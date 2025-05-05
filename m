Return-Path: <stable+bounces-139644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0FAA8EF1
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E561D188F7CF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855BC1F5822;
	Mon,  5 May 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B11R3BxE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29401F2BB5
	for <stable@vger.kernel.org>; Mon,  5 May 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436033; cv=none; b=Z8pysFU+dlO4D0OZYNUM1RcZfY/Vfmm/Y9tfPMyvN3xA2HHNSxYBlMj930m69okPQT2PMrNVcLEfqujlTdxmEFKp9vrZJlf9VTS5LN7pDC4Eznk6bcEE86Ip+2rUWGV+JfcTcq4q9PzhPchKnlJ9YodzKPhhD+aTJar5gDJN95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436033; c=relaxed/simple;
	bh=DKSAlySHx3h3D9zpUBcxrMd3u1LhzK+bGMkaFdM8fys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqB547iEFmLzxKKfqz/B5oO+w/iva0s4zPq4WmXj2IEdxTluWsnNH2NimkBP5dW8qwRAMR8m2UKNutyVk34tHf2bfRV1zT723GxuKjlZ2tr6riKQpIgJ+njbYDXEvvXm6oFeETw7essz2vfsVxk6XWj6pQLx4aAfGjSk8CiZ90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B11R3BxE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549963b5551so4648477e87.2
        for <stable@vger.kernel.org>; Mon, 05 May 2025 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746436029; x=1747040829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GsrYYGdHiHagWAJNMJ4+WIR65DiPU+EFWzyGSzQD9k=;
        b=B11R3BxE2WX3AAs+NcgXlX+9i16oKvJ1xoZpvvY0OsZ+AlrgJtnKWJY8GBvTFkr135
         LnxVTg2VKN5/J0EmPSu/9ySeADHie0TEyrlFAuQ2+tYBKrMTQ+DWiWqwwtVqAgIe2rg9
         WrT2J8gGp3MAOSSNbu4zIBaHKgNLNMGH0l1T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436029; x=1747040829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GsrYYGdHiHagWAJNMJ4+WIR65DiPU+EFWzyGSzQD9k=;
        b=hUN2UqYo5VI2d7iaFFQOzt4PZfZ4ePCLx+dfG7q4yDYVeJx7cQ4Z+DTaPm8jZ2j7bM
         VYGLbYgqL3xypUaur0bulow/rBwEWQMeUKhC68kfpcjs+3Kd3EUQ/8xX+HKiXZhyfaif
         SLwBTkDML55WH6oXx3A7nmv+AHHoWKqhonGd8Mb8iqbDyJTghksGQA+2olOFr8/6zW8t
         5cR3kV4WmngEwXxCTIOJg6TlKDWzA3Gd+BbxNopD8a6gofxoVjw+7/nJcynWtpUINQZY
         tAj2Fo7fFcreqFmqVlzntIlut4p7l63JVJ1iOIVPb2J0HFuFPteW3v3QC+MSYfXYndio
         Ts3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTfk90HnHTnV2iKsC3IeYvz23mmWuSlc8bWZ/uwTCbbP962ti1vfNwflFT1u3g4gaqcnPrZTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wNN4+JK4OOH69eMfjHNPWoZqrvzpytPR10RP4DqSFuorfLat
	4Z2n6pmm6so3FlZR+ITkDKjGftS5Mse++F2eT3roMHoQ22xwNu44RTDBhGCecdn+zanq10fWZk8
	=
X-Gm-Gg: ASbGnctZhcvunDvUv6yn3iTBJR4GH6csxTJIBah0Gsp41gX8tj1XZEp3niKG2XlSaEL
	1KHIVfbaihriTBTFRC+KNo3SZLA2x7lHAdBFPpXWZj3IHKIu0m61eKvUB5IrcEtdUKngqEN7Yzl
	IkNHapQbF/w7dAlK7TGWqCVA4lR+8nQhBUZ5GXDoL5ycX9+5H+MGmKGBgQG++WVuYo4HWLYoDXV
	a6sRyeKbp0Ytu44UdjLhW/k6QRHEZ547x+gozwd/t5AiPT4f5Inr/7YaAKkXrz7lmi9nneBVZwq
	csJaQpjNRQSxuLcCnw4cctS/zvBfqp8QcivJxJ1WJEZHT33UqQHMTceZUVEwE0/G1XTqnE0+PMm
	kweXO162oRiGpDw==
X-Google-Smtp-Source: AGHT+IFX6/tKhzKFS3sRA3Ly9s3njjy0iryw8l7ALbj85duKXYPLZS0LS0MCcWfbpfyOflmFZThiNQ==
X-Received: by 2002:a05:6512:1053:b0:54b:1055:f4c0 with SMTP id 2adb3069b0e04-54eb24282f8mr2172450e87.4.1746436028596;
        Mon, 05 May 2025 02:07:08 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b165esm1671761e87.21.2025.05.05.02.07.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 02:07:07 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso5816550e87.3
        for <stable@vger.kernel.org>; Mon, 05 May 2025 02:07:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCZqccnBi5LallSGFmrvdipenZ9uTrdTPZgAcoPtRzkP0wCpO7g1VR8yO3nxAcpG3jTN85uj8=@vger.kernel.org
X-Received: by 2002:a05:6512:3c87:b0:545:2300:9256 with SMTP id
 2adb3069b0e04-54eb2428303mr1840599e87.12.1746436027276; Mon, 05 May 2025
 02:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org>
In-Reply-To: <20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 5 May 2025 11:06:54 +0200
X-Gmail-Original-Message-ID: <CANiDSCtNTMb7kDqrRbpMjDiL+vJh97Tm=2s44J46QS8uH+m0bA@mail.gmail.com>
X-Gm-Features: ATxdqUGQfyylk6QXkXx8f0-VFS2_hwlKvplMAloc_0UYeLmco1yG4YZuTcaOv88
Message-ID: <CANiDSCtNTMb7kDqrRbpMjDiL+vJh97Tm=2s44J46QS8uH+m0bA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] media: uvcvideo: Introduce V4L2_META_FMT_UVC_MSXU_1_5
 + other meta fixes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mauro, Hi Laurent, Hi Hans

Do you have any comments about this version?

Thanks!

On Fri, 4 Apr 2025 at 08:37, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> This series introduces a new metadata format for UVC cameras and adds a
> couple of improvements to the UVC metadata handling.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v5:
> - Fix codestyle and kerneldoc warnings reported by media-ci
> - Link to v4: https://lore.kernel.org/r/20250403-uvc-meta-v4-0-877aa6475975@chromium.org
>
> Changes in v4:
> - Rename format to V4L2_META_FMT_UVC_MSXU_1_5 (Thanks Mauro)
> - Flag the new format with a quirk.
> - Autodetect MSXU devices.
> - Link to v3: https://lore.kernel.org/linux-media/20250313-uvc-metadata-v3-0-c467af869c60@chromium.org/
>
> Changes in v3:
> - Fix doc syntax errors.
> - Link to v2: https://lore.kernel.org/r/20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org
>
> Changes in v2:
> - Add metadata invalid fix
> - Move doc note to a separate patch
> - Introuce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
> - Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org
>
> ---
> Ricardo Ribalda (4):
>       media: uvcvideo: Do not mark valid metadata as invalid
>       media: Documentation: Add note about UVCH length field
>       media: uvcvideo: Introduce V4L2_META_FMT_UVC_MSXU_1_5
>       media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META
>
>  .../userspace-api/media/v4l/meta-formats.rst       |  1 +
>  .../media/v4l/metafmt-uvc-msxu-1-5.rst             | 23 +++++
>  .../userspace-api/media/v4l/metafmt-uvc.rst        |  4 +-
>  MAINTAINERS                                        |  1 +
>  drivers/media/usb/uvc/uvc_metadata.c               | 97 ++++++++++++++++++++--
>  drivers/media/usb/uvc/uvc_video.c                  | 12 +--
>  drivers/media/usb/uvc/uvcvideo.h                   |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
>  include/linux/usb/uvc.h                            |  3 +
>  include/uapi/linux/videodev2.h                     |  1 +
>  10 files changed, 131 insertions(+), 13 deletions(-)
> ---
> base-commit: 4e82c87058f45e79eeaa4d5bcc3b38dd3dce7209
> change-id: 20250403-uvc-meta-e556773d12ae
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>


-- 
Ricardo Ribalda

