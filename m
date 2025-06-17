Return-Path: <stable+bounces-152877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01FADCFE7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C6188C326
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C762EF661;
	Tue, 17 Jun 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jO2e/Yd+"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080C2EF654
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170390; cv=none; b=TMyndVg7gLvPvF4BT5FJAdPzrzPlCZWKsj45Bp48Ch5MruZJ2yxlHD3IsWAqm99F3KrcOhsiaJTT5gL7anw86IuW4NMf2oEZHXD7qn/+gGa/iOO/VkJdMts02aua3qTuk4Kn9PGVjNeuhv8b0MhhsKCAyiq72tOk0Q4qsakC320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170390; c=relaxed/simple;
	bh=wMbM76puJf3UDfEqOtCoByazKLQLkepWM70O2hu1zPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+Nen1SekPlvKrv6EVwQRZh8tjo4V6ROH/iGI/6RliEab1VmxrSMYgAsU0NccjX6VnESsvhMFasSNrXlpXEK5y8IsBp8qpl/PthnM53npEV4cBQ8IqzqJXmgh3xeVga2fXhySpPWwkxYnrFyuzXO98MFME4Kvi4UXktvxbnwAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jO2e/Yd+; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52f28e83e13so225471e0c.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1750170387; x=1750775187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpOAwhaaQKzA9a+hLMz4Fdbv7o6Lk/Fl/Twzh3KUUnM=;
        b=jO2e/Yd+YTwoy9wqucU68iPPCaVMqxMwUTPSVLZWeiQn8M0v0VAJwjyxlERLC3+Kdy
         pfJdBsGew4sDLv/X4cmfi+A1Vdyt1hlySAq1gIs6R/jzGxh2o9SF/EIxl/Lra7et93Y9
         ziQSA6MmLj22VSrW3+4w6aCdPnx5Ph6SqWVuDox8j5Rp8r8bGfTWs/IZTwG9oGtJVtoW
         ydkzfoj+mFx2ok1d8VpOVSAvY+E1ofSGnUHG2l4rWYGhPD7IZNc4qlKRFR4GtDu1m8xb
         VCgnrOzljBUfjov3SLdENzegOJ6rIUHbSD/ky1tiNnYqqaemhZbwC9/cxUuko88u6AYQ
         VoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750170387; x=1750775187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpOAwhaaQKzA9a+hLMz4Fdbv7o6Lk/Fl/Twzh3KUUnM=;
        b=ZacHt+OeZ4/cUaitA2sncdG7dNvH6LugagZE3b60jIt6KygMbab7FSIevAVx8CWfnp
         Q5kstBlHtsQIvnK/7488KKeRGvYdGp2HSItdELjXwlGAwSYIKB4Rdkv4p2BR01VbTbi/
         tolHfhta4Qla4T/BBWAO9Pmt3xcw9CwHz1ja/580mkOUEWKlh6cVBzOmBGhgmeedGfe7
         q2pQ//bfP2ktBiquFBIay6L173T8LOJBvmiaULDAHnlIDRF5S2o5IL23Cuqq4x5FovDW
         uCXEjT6jxMF1UAC1isJUJujR9i3qdXPf+lt6jWBy3Tqj0UmjdmRBkQ+tIqPIEb2IxgK3
         R3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFDjeIW/aPz3WiRBHYgf2QIpKEqxh861fiIwfwVq9yi26lH36KBO+ie6LmvCGLpbASafulPzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zau5cZOTyJa5mxe9A+aeFkxyWuUc7oD/AG5oES0BeDRYWf+v
	8BMH1Xj+RjIKZP5++HvitmZmqPSSWtSs3UNkIri02ELCthWKXWsHnUVCxhUUoLqEK8wwMb+gRKO
	A33ZXbqiEDJk+0xkZtz0eIWx9r+s/bIzceatwbkePnA==
X-Gm-Gg: ASbGncvaW8jVPvZuZyxI5yn4k95dsia/hH707LL60qqtU0pO1gUjsceRLpbplUWIo99
	CgMrKkTQkGHDZXYABj7qixeS8FO4Sh+NbJ9YFB5aYCYAFPoM8igW+wCCz9/DgLoqV9pELuZoiWd
	ohX0eefOdSvwTLXHQIYWmcmVy1e6g99Lyc1p2ySu2/
X-Google-Smtp-Source: AGHT+IEvy629BwKiuNFR6pwMejlGO2WAZGwWZVOcmHQsFf0NqpfbXWmZwN4PhhADQC4Yr8/b+9IDSb34HzZ3UTA0+E8=
X-Received: by 2002:a05:6122:4881:b0:530:2422:68a8 with SMTP id
 71dfb90a1353d-53172c40e8cmr906039e0c.1.1750170386532; Tue, 17 Jun 2025
 07:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-pispbe-mainline-split-jobs-handling-v6-v8-0-e58ae199c17d@ideasonboard.com>
 <20250617-pispbe-mainline-split-jobs-handling-v6-v8-4-e58ae199c17d@ideasonboard.com>
In-Reply-To: <20250617-pispbe-mainline-split-jobs-handling-v6-v8-4-e58ae199c17d@ideasonboard.com>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Tue, 17 Jun 2025 15:25:52 +0100
X-Gm-Features: Ac12FXxY2MjozgnKj7SQp4qGI8gl5dx5KqJMAcZDD_ubJWJD9OKIvfSseMEz2Tk
Message-ID: <CAEmqJPoxHSgXBp+EH+MWQVHVwYL2N5CnOwC-7W+AFWt1k7Zv+Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] media: pisp_be: Fix pm_runtime underrun in probe
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Nick Hollinghurst <nick.hollinghurst@raspberrypi.com>, 
	David Plowman <david.plowman@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo,

Thank you for this fix.

On Tue, 17 Jun 2025 at 14:54, Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> During the probe() routine, the PiSP BE driver needs to power up the
> interface in order to identify and initialize the hardware.
>
> The driver resumes the interface by calling the
> pispbe_runtime_resume() function directly, without going
> through the pm_runtime helpers, but later suspends it by calling
> pm_runtime_put_autosuspend().
>
> This causes a PM usage count imbalance at probe time, notified by the
> runtime_pm framework with the below message in the system log:
>
>  pispbe 1000880000.pisp_be: Runtime PM usage count underflow!
>
> Fix this by resuming the interface using the pm runtime helpers instead
> of calling the resume function directly and use the pm_runtime framework
> in the probe() error path. While at it, remove manual suspend of the
> interface in the remove() function. The driver cannot be unloaded if in
> use, so simply disable runtime pm.
>
> To simplify the implementation, make the driver depend on PM as the
> RPI5 platform where the ISP is integrated in uses the PM framework by
> default.
>
> Fixes: 12187bd5d4f8 ("media: raspberrypi: Add support for PiSP BE")
> Cc: stable@vger.kernel.org
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Tested-by: Naushir Patuck <naush@raspberrypi.com>
Reviewed-by: Naushir Patuck <naush@raspberrypi.com>


> ---
>  drivers/media/platform/raspberrypi/pisp_be/Kconfig   | 1 +
>  drivers/media/platform/raspberrypi/pisp_be/pisp_be.c | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/raspberrypi/pisp_be/Kconfig b/drivers/media/platform/raspberrypi/pisp_be/Kconfig
> index 46765a2e4c4d1573757ff842f208834216e582cb..a9e51fd94aadc6add70f883bfcea0c9fa91f0c4b 100644
> --- a/drivers/media/platform/raspberrypi/pisp_be/Kconfig
> +++ b/drivers/media/platform/raspberrypi/pisp_be/Kconfig
> @@ -3,6 +3,7 @@ config VIDEO_RASPBERRYPI_PISP_BE
>         depends on V4L_PLATFORM_DRIVERS
>         depends on VIDEO_DEV
>         depends on ARCH_BCM2835 || COMPILE_TEST
> +       depends on PM
>         select VIDEO_V4L2_SUBDEV_API
>         select MEDIA_CONTROLLER
>         select VIDEOBUF2_DMA_CONTIG
> diff --git a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
> index ccc6cb99868b842ac0d295f9ec28470303e60788..be794a12362020f42b3cf5bd291b4a1625543b5f 100644
> --- a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
> +++ b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
> @@ -1725,7 +1725,7 @@ static int pispbe_probe(struct platform_device *pdev)
>         pm_runtime_use_autosuspend(pispbe->dev);
>         pm_runtime_enable(pispbe->dev);
>
> -       ret = pispbe_runtime_resume(pispbe->dev);
> +       ret = pm_runtime_resume_and_get(pispbe->dev);
>         if (ret)
>                 goto pm_runtime_disable_err;
>
> @@ -1747,7 +1747,7 @@ static int pispbe_probe(struct platform_device *pdev)
>  disable_devs_err:
>         pispbe_destroy_devices(pispbe);
>  pm_runtime_suspend_err:
> -       pispbe_runtime_suspend(pispbe->dev);
> +       pm_runtime_put(pispbe->dev);
>  pm_runtime_disable_err:
>         pm_runtime_dont_use_autosuspend(pispbe->dev);
>         pm_runtime_disable(pispbe->dev);
> @@ -1761,7 +1761,6 @@ static void pispbe_remove(struct platform_device *pdev)
>
>         pispbe_destroy_devices(pispbe);
>
> -       pispbe_runtime_suspend(pispbe->dev);
>         pm_runtime_dont_use_autosuspend(pispbe->dev);
>         pm_runtime_disable(pispbe->dev);
>  }
>
> --
> 2.49.0
>

