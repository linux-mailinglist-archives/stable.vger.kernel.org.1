Return-Path: <stable+bounces-120416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6BA4FC4E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EBB18968E0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E5205E31;
	Wed,  5 Mar 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LN3x6SdM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A56207666
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170679; cv=none; b=re/zfvfK7NHzw2PfkjlsrDwaqllVPhsgDwMNFFNugvW5XlqoVByafCZStZN7WRNVz8IfRC7OhBVZOp+N67I27ABl6Xahn1sRjhs/tFBO32fHc+7X7S/kQ6nNXHVLLeNJD30/4j2xLUqrTfFkBdsB1GaYdeoqrKwc/7Czb4+6bfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170679; c=relaxed/simple;
	bh=cI/FwYOea9v9acFNYem85Rlg0xNzSGh+sC58cnGIc0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCnG+od6XrZw3WCAL0Wxds6nO40+nYKaiajKPeJlmdBAnrQTpzTfM8kDvdB7+8sgE9JalW25wGeM9Ep/sMPLwSpUgtScJIipkT0xDvKacZGaHqXSVD1pb/qiqY/WrFAyXi1Iml7b+A4G87lUCQzuvTh62CckulTHR//0c7zrwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LN3x6SdM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5496078888eso3606424e87.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741170675; x=1741775475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw15WMgQQdn5WtfRUhZCkCwttQ1/j0/WKtgzTjjCFbE=;
        b=LN3x6SdMnwcDxrph94fjxAc5jIPp7swivtOyLbTBYzK8jcic59I0wYCEEnxYYl+/BV
         wZnk7PEo5ntDMIAk8zU4yn56lWfdo5fYX4Y51OwwRDd4h85lM7Qqk32SXAzaGiO3f+qX
         lETP4pT+dAQuCW7QnWOSOOuY7V/NqZTJMdciY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170675; x=1741775475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw15WMgQQdn5WtfRUhZCkCwttQ1/j0/WKtgzTjjCFbE=;
        b=i+vYqcbrnW1OPc0KXOhnRfF4XTOMdYZyt26yWsAQ2kqKkeEidevAx0zdbU5yejtyh4
         VtBB3LTIZSiMl0SQESipMJyoyzxME+CPxXVdB4f+uenS3tdDwDZfXA0Itc9R06KMyUgK
         JNbJv7viNCu8i+W/sLCQ+54mrollWT2kuY1J2dBwRjDStzSQMGySyjbwRT/0Gq6HgW5F
         V27X8VeuvPKpQ+D1vp4NrcC0Kq0vTY+o071A+DIZETY4Iq9mgE9wn976ULSFUhxd9etl
         3r24RaQoOC+AJvIocfkQgx2zHZzw+iMPeCAadKSiZWKW5hpnej7/T1hZbmLjnfjRRZVh
         3Iwg==
X-Gm-Message-State: AOJu0YzTmcxN29tTJZnkr0yWHPVsTqmuuh7yyg8QL/jHOlzQd8/Ns+fR
	GHij7Z9rrtFHYPf4ufIsMjDXJlMFJnkhjQ/JPfLjEsq4rsDcpaKlvifDGliiaELBHSrx1atf9m8
	=
X-Gm-Gg: ASbGncu9yx/49hsjxhvYfntol+/klpxYBf9aTgZr25RZGYXvfqBh7jnq1QTvjqk/2P8
	u5/YatIXNyzxpHja0EATUV4tHwdkW7GVkBT7O5gSyaBv/T7sm7LBHd/CknujxduONbcXHH69jy8
	Nc71dAV27jTji/lyaiJW01mvPlRUzdAB4KqN9PAcgRh4FCTu03omKR+JTCt3hTgzx/6se9onHF7
	WUik/DGqzyoUxj/yPP0NELKaByOCgbYcYKBqEX+D5j6NeAn5UtuK8ZQV6WGbLvqCkM/EomwX0+R
	2hfA7qAdujUFpTMR1YVDyqjJGN7aYXwsvJhrHn+l5nXOuH4LLeqoFl8tWugNKHWgzj3Jd0t3O/Y
	l8+nkVPk=
X-Google-Smtp-Source: AGHT+IEId9KMZbQi0ZUkYErZCAIbGNKImoIdvv9nnvUxmeEv4v3WaxFJrqOMn2Sy/S8wkPMP1hk+KA==
X-Received: by 2002:a05:6512:3b22:b0:545:27af:f2d1 with SMTP id 2adb3069b0e04-5497d38c101mr1052462e87.44.1741170674935;
        Wed, 05 Mar 2025 02:31:14 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54950e2d386sm1516909e87.17.2025.03.05.02.31.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:31:14 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so7351183e87.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:31:14 -0800 (PST)
X-Received: by 2002:a2e:a54a:0:b0:30b:bba5:ac19 with SMTP id
 38308e7fff4ca-30bd7a19c6fmr8815281fa.1.1741170673708; Wed, 05 Mar 2025
 02:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228084424.2738674-1-ribalda@chromium.org> <20250228173400-7a1e9333cd4df318@stable.kernel.org>
In-Reply-To: <20250228173400-7a1e9333cd4df318@stable.kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 5 Mar 2025 11:30:58 +0100
X-Gmail-Original-Message-ID: <CANiDSCsY7fdUcgaCUfqXFpz+pMxJp20YhEDhejCLOB+JRRKdnA@mail.gmail.com>
X-Gm-Features: AQ5f1JrxcfVRFxmlvhJXwny_-94yGv846-oE_f3QB5RRl9XcTQI2c34rHEq8o24
Message-ID: <CANiDSCsY7fdUcgaCUfqXFpz+pMxJp20YhEDhejCLOB+JRRKdnA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] media: uvcvideo: Remove dangling pointers
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
> =E2=84=B9=EF=B8=8F Patch is missing in 6.13.y (ignore if backport was sen=
t)
> =E2=9A=A0=EF=B8=8F Commit missing in all newer stable branches
>
> Found matching upstream commit: 221cd51efe4565501a3dbf04cc011b537dcce7fb
>
> Status in newer kernel trees:
> 6.13.y | Present (different SHA1: 9edc7d25f7e4)
> 6.12.y | Present (different SHA1: 438bda062b2c)
> 6.6.y | Present (different SHA1: 4dbaa738c583)
> 6.1.y | Present (different SHA1: ccc601afaf47)
> 5.4.y | Not found
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
> | stable/linux-5.15.y       |  Failed     |  N/A       |
>
> Build Errors:
> Patch failed to apply on stable/linux-5.15.y. Reject:
>
> diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.=
c      (rejected hunks)
> @@ -1696,7 +1731,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device=
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

