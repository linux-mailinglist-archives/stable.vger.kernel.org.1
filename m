Return-Path: <stable+bounces-119910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A95A49368
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54A81892A51
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16802248898;
	Fri, 28 Feb 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICH4jcFw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991B2459C5
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731118; cv=none; b=hhU+PffJlGeAdD7+UTXrx5hQxc3yJH9wq9aqZtdga+NDK1huRvzehPefP8X0EOb5SFqtbisc3hJECDQW12Ls0W1yQUS82LkX9PJg+MfIR0aG/wH6b5kbI+8sE6G/zQvr+Yi8PMKsNDf2pz+q5ns0S+raVjZkXfwcak0v5u6u+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731118; c=relaxed/simple;
	bh=3WcUqiPz2AZpJ4/WQDGHqNJ0ensJOWfFNsbEN2tkLG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qh0lMeBex2TMNqf7YNSYs+Q2ibpPPPnRJTrmsqFwM4br+N7nAhPj9w36oSMEvYs3cd5Bs4tlQDnLdAk/QI+TpEtGLuxNm9H9dppxG+MUx3H6KO+sHuvpalXlxO0c1+JphDtB6FIqOY0lfSB9hO74Gkx/YXG+rbIDUFPZl9apVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICH4jcFw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2f240156so21896661fa.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740731113; x=1741335913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itw1YAgzwsVuF020OckqCIXwBXxewDqXyhKgFBPrRAs=;
        b=ICH4jcFwpB2Gt9Bv1C9AX/kjb3ZAW2fn1a5yEqFTMZI4HsQeaa89Lf9uhyaOEgJS8R
         PQ1OYJMqGV6Dcm0rdLBT17DGkWy4cOzvmTac3n2na0CUxzlCqiRxfZMhRb9n1XhZWSWN
         Sg3Mkfbnb1WXFhBA3g0c4PkAH29nvX6fpJ7m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731113; x=1741335913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itw1YAgzwsVuF020OckqCIXwBXxewDqXyhKgFBPrRAs=;
        b=m8/Z03Qhrr//mRKIcWD+ltif6SaPqnZrjj1oqL9QXSIXHR8vd9Ia+wcXAWZbXoyQ79
         6KzuDTQGCeqDG8gSj06Cg7ATfRntycIWEFWt6VdP9X0vTP7Az4FOcV3r1Ct+b85cKszS
         rKIrbZeWacEgyBiVO+OsKfwZk6D965ijh7FFOPz+ATA8KoySUnp/QlwuUc7wB0lMLAdG
         GqZAtXY2kDK+XLarNMe9svzCcFcaPJD3Uoe4yH9bmiXNfBXIdN5G/BWAeNE/M5a5Zl36
         PyabvMgSjiNZO+iX1JzIUcTXP6R4+KBpNbuHZjNFcSUoUTThpYs1WZnyVuXr8Vq2qmIs
         rNOA==
X-Forwarded-Encrypted: i=1; AJvYcCUXTuSXhXIc8v+JXxpsV2p07A9BKCnrB5q/76T1ip4N6SC9MUXiPCXXrHvqxGTKhnsUgAR6odU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1sla8CbrCMEB+JFRP9uRPIjIuM9TrelgQguX9PeeXFNyqIYmk
	cOggo6gMdI29MN//0lzFYt/GknuzkR6j3kXrM9HDE6RkoITajyvfsZrUBJDF8x0jO+V5snMgM8W
	1YQ==
X-Gm-Gg: ASbGncvsiT6p5jcCGoFNZU1f3plDUpD2xN3Vz1iX4vDloNl8vbUaMKlfeC5Nn4D70uS
	12DckX3GPLYpQBGW60OZtmDt42wpsMguRxHNrUkwNgbPj+meE2yeu0m98ewWhbF+gkvP8xypAk9
	xHNvGyQYf9+niYXV8KwjLhiDg7Tj87KsnaDdZ1lxJlVMElpfxY9rsxdHaKaQqXl4O3LZk4ThP29
	HCQb2aPcqLWDufm7Q5GPYl5QEBbs8pNRFlwq//Gx0C41AFQx9yaLfHLnKy1EbVl92PCiv5XRFY1
	IS77d6m7sSQPbZRYp+VrZ4lzPhmOw+mNfDIyQNmtB5OcTfy0LycBzNwO7GskIIGK
X-Google-Smtp-Source: AGHT+IEbePxkqomIpqHT+Iev3FKzDI4TA7cpfRpgkPGjVTcULwG1oXROVSkbsEg9E2K2I4x7YMxkmA==
X-Received: by 2002:a2e:a98e:0:b0:302:29a5:6e21 with SMTP id 38308e7fff4ca-30b931fb825mr7342381fa.3.1740731113130;
        Fri, 28 Feb 2025 00:25:13 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8e40cceesm2800301fa.108.2025.02.28.00.25.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 00:25:12 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5494bc4d796so907041e87.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:25:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7mCcXwG88U1HOBvKJuXOQ75hwlNMcbF2PqexBdvLVMpzYJiKkBdh9YgHE1PmdYByBcLHJtlc=@vger.kernel.org
X-Received: by 2002:a05:6512:3e03:b0:545:2eca:856 with SMTP id
 2adb3069b0e04-5494c129ff6mr957169e87.9.1740731111389; Fri, 28 Feb 2025
 00:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021006-sharpie-patchwork-f168@gregkh>
In-Reply-To: <2025021006-sharpie-patchwork-f168@gregkh>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 28 Feb 2025 09:24:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCsvOxg76YjegVV+nLhfybDw2DH0bt7dSkV91e4nG=OdGg@mail.gmail.com>
X-Gm-Features: AQ5f1Jo_-cxuWsfB19myXG_iZG3JqZqKcVFkX92xFhgWL1OxFdxomFSgba6-7Ig
Message-ID: <CANiDSCsvOxg76YjegVV+nLhfybDw2DH0bt7dSkV91e4nG=OdGg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] media: uvcvideo: Only save async fh if
 success" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com, laurent.pinchart@ideasonboard.com, 
	mchehab+huawei@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch has already  been merged in stable

https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/media/usb/uvc?h=linux-6.6.y&id=08384382e1dbd1e2cbbaddc704d3ce98f46b87e4

On Mon, 10 Feb 2025 at 16:12, <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x d9fecd096f67a4469536e040a8a10bbfb665918b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021006-sharpie-patchwork-f168@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From d9fecd096f67a4469536e040a8a10bbfb665918b Mon Sep 17 00:00:00 2001
> From: Ricardo Ribalda <ribalda@chromium.org>
> Date: Tue, 3 Dec 2024 21:20:08 +0000
> Subject: [PATCH] media: uvcvideo: Only save async fh if success
>
> Now we keep a reference to the active fh for any call to uvc_ctrl_set,
> regardless if it is an actual set or if it is a just a try or if the
> device refused the operation.
>
> We should only keep the file handle if the device actually accepted
> applying the operation.
>
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-1-26c867231118@chromium.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index bab9fdac98e6..e0806641a8d0 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1811,7 +1811,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
>  }
>
>  static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> -       struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
> +                                 struct uvc_fh *handle,
> +                                 struct uvc_entity *entity,
> +                                 int rollback,
> +                                 struct uvc_control **err_ctrl)
>  {
>         struct uvc_control *ctrl;
>         unsigned int i;
> @@ -1859,6 +1862,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>                                 *err_ctrl = ctrl;
>                         return ret;
>                 }
> +
> +               if (!rollback && handle &&
> +                   ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +                       ctrl->handle = handle;
>         }
>
>         return 0;
> @@ -1895,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>
>         /* Find the control. */
>         list_for_each_entry(entity, &chain->entities, chain) {
> -               ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
> -                                            &err_ctrl);
> +               ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
> +                                            rollback, &err_ctrl);
>                 if (ret < 0) {
>                         if (ctrls)
>                                 ctrls->error_idx =
> @@ -2046,9 +2053,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>         mapping->set(mapping, value,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> -               ctrl->handle = handle;
> -
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
>         return 0;
> @@ -2377,7 +2381,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
>                         ctrl->dirty = 1;
>                 }
>
> -               ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
> +               ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
>                 if (ret < 0)
>                         return ret;
>         }
>


-- 
Ricardo Ribalda

