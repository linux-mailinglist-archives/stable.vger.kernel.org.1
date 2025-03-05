Return-Path: <stable+bounces-120417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54AA4FC44
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AF57A3F78
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A8207E15;
	Wed,  5 Mar 2025 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KH6qrsOl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC8207676
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170686; cv=none; b=of0kfkhsCYBJmqlK6JNmS5E5q9n5CHhMp39752kHAA8AMak1Myy5iT6rMldO7i02e8z39uIz7Kk55PhucEpsRTHgiPb+6PU1pmlySq42+uHbAq8lkyUW9FOsZgi/rsyOHvbSFNnudNAfboASgXzwkqiSzykipSTCu4zY3zVkE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170686; c=relaxed/simple;
	bh=kui0Fc7O0MCAKlyJw0TzUjAFwmQ8s6dHRZx9/RC8468=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7gcvm3J3E1i4DNYcuZkcaEgfNKVh2eUs0PPUbHfcDDoFQdbuVc27r3yhFN40zp0UVhbmW4+K5NT1he+qUIN3RjrcOhAW4tCH19Z//PRT9GDJ0zTKcY53TmTTxTkIsOUjgKoSg7mVZ++7dPp+c37o+35y8MT2idcjMQCfrT7C8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KH6qrsOl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54954fa61c8so5457395e87.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741170683; x=1741775483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LatVyNYREN/RuaddOmG24V2MJfbeWZJ1cUw84w+ZAfk=;
        b=KH6qrsOlJH26VqWP986IBYAo2Q0Z1KnUncf+RjrqDyl0YIG0TPGsQGThcvFeccWA3y
         xAJPcm620RFUk0MiPFiWXu9PZ3/KI+sdWj71M+uwV3i3RRUIOlFaI4U1hhwsdpYgQgVV
         UXBO6Kfcv1+y1J7sv+Cb8hYTyMZiivZEM2GiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170683; x=1741775483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LatVyNYREN/RuaddOmG24V2MJfbeWZJ1cUw84w+ZAfk=;
        b=JGqCh3VrRz7Zt/5uAUeRSvCLZnKYmp1JMxQ/6Cv+WLFlKp/+ItdHcgOtTiUySx+Zjv
         +fVUve/sfQtAf2+mylDXA1K4eJtcs9/54jkXLE6bUwfPwZ7rA0y/UFpyP1Lusu9UggGw
         sUuP3uW00l7HfestpsE/z74v4WHstFgwbBvePZDk6ockEhJjS/uH5inLn3QScMDdhuEX
         Y5KtkUUOyfCatvQ/9Zqo00SgkRgzM1UIj7SZrV37x6qL5Pl4YRCETKJLYFn1jjdo2sHf
         sZR+Pi0bN3Wc907kBQ5TPs64Ds3ZsW6ONJ4tlyWKPtEXIT6sG1o9LbJC5RY8gOwk4O47
         hP6Q==
X-Gm-Message-State: AOJu0YzLJmq8/I0p0aRzJFzAYenqNB8PzUpOZn9qGDNTcwaTFG6f3zOB
	IbFiige2HUIMfTKZ76fADKsOvU2QGAIlgsmqHtk2hPjsCNrj29clFEpb4SIesfQg97d/TdKwCiI
	=
X-Gm-Gg: ASbGncsBVYI9s4oIulJr8ErgYKpQ2GY2hz6SBzf4rOFA48YXjbSZD8RsvVR2SPLqfKz
	lFgxAjt0zIPI6BbBdJhgYYMRGJLpl78LvBYLtrWjkQyRA2K9zoP2cec5osRH8rS0AXY3UXBSxZz
	DrfN3ryVCkhDkq0UIsJsGVWHSCOlZmCN9hYXsSpocUXjG4EVRgWhlaA6Rfw8yWxU7PFOKyTQcfV
	+QKUEdCJsx6ZgG/IDzw2DuFbYhePGzpqV3diQfi1xsQxKGHJ9sv0F1oSBBAyWR7mTFCT+ySz/Es
	PQ+PFlFMZ6oJN8ZOVEhGBgtGd4q3GfCA1Ih7PhoVlNHVVgF/ddL4ihCDetyo9tYGy/Eh4k8ztTM
	AWWfUUno=
X-Google-Smtp-Source: AGHT+IHXZL+PVxKqK8+sBqBJde+eIkaKxw5NO70MIqhggxyhEQ9jOKSS7AtuQGDZCtnQhKrAer+Aiw==
X-Received: by 2002:a05:6512:2254:b0:549:39d8:51ef with SMTP id 2adb3069b0e04-5497d32f6fdmr888833e87.6.1741170682738;
        Wed, 05 Mar 2025 02:31:22 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443be67esm1872531e87.202.2025.03.05.02.31.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:31:22 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54954fa61c8so5457377e87.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:31:22 -0800 (PST)
X-Received: by 2002:a05:6512:3d19:b0:549:4bf7:6464 with SMTP id
 2adb3069b0e04-5497d376b95mr849963e87.38.1741170681666; Wed, 05 Mar 2025
 02:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228084659.2752002-1-ribalda@chromium.org> <20250228193340-6016db82aed38507@stable.kernel.org>
In-Reply-To: <20250228193340-6016db82aed38507@stable.kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 5 Mar 2025 11:31:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCv-yKFbe6R1+XFBur+T9d__2M5jgXxx_7C7sdod_-29OQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrcV4oQrDl__bL4FRCP7Cy4LExd7PxOfu1an-ztVB0GLZhhWGUG-Y1Sj0Q
Message-ID: <CANiDSCv-yKFbe6R1+XFBur+T9d__2M5jgXxx_7C7sdod_-29OQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] media: uvcvideo: Remove dangling pointers
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

This patch depends on the already committed:
 "media: uvcvideo: Only save async fh if success"

Please apply on top of it.

Thanks!

On Sat, 1 Mar 2025 at 05:21, Sasha Levin <sashal@kernel.org> wrote:
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9D=8C Build failures detected
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing pr=
oper reference to it
>
> Found matching upstream commit: 221cd51efe4565501a3dbf04cc011b537dcce7fb
>
> Status in newer kernel trees:
> 6.13.y | Present (different SHA1: 9edc7d25f7e4)
> 6.12.y | Present (different SHA1: 438bda062b2c)
> 6.6.y | Present (different SHA1: 4dbaa738c583)
>
> Note: The patch differs from the upstream commit:
> ---
> Failed to apply patch cleanly.
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.1.y        |  Failed     |  N/A       |
>
> Build Errors:
> Patch failed to apply on stable/linux-6.1.y. Reject:
>
> diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.=
c      (rejected hunks)
> @@ -1754,7 +1789,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device=
 *dev,
>
>                 if (!rollback && handle &&
>                     ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> -                       ctrl->handle =3D handle;
> +                       uvc_ctrl_set_handle(handle, ctrl, handle);
>         }
>
>         return 0;



--=20
Ricardo Ribalda

