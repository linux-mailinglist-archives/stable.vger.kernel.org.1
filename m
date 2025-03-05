Return-Path: <stable+bounces-120414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E7A4FC3A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3618D1719A6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94B205AAC;
	Wed,  5 Mar 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FkRI1oSF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51E2E337F
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170650; cv=none; b=lNsH0GxbLHDZpVh73bFlaBEwHkG0I5FY8BA6+Dxn2cavGAPZ7oaqUqvQBTG9z/SflskWe3pO6WdFsYkxWfB9NiLypfGSpV0to4XRKsiybewY4dQ2mGTMYFOWgoSYDlmvTh2sodER/S46BezqbnMTY819cznzatMQ09shvXyDpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170650; c=relaxed/simple;
	bh=iigU5PiIa2iP3AOiAwmNv/qoweSPdviFCF89Neb1CWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRJ3OQDOFZSfEAkJBx4fiGsvrlJs8CRLi/c4smKJNrmEurQp+qZFj6Ar6E4xQO6JqxSqH13ZX5WZvTQPrKSefS0OZi/MNeUjrzIpXHgxssYJWdvzTDT60OkSg4jLPPenCkwcBQ1c9Iagot/KbBwV1ACAvqav2DeRvsoXKQFTaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FkRI1oSF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54964606482so3311359e87.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741170646; x=1741775446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+odpLyF4k23EH3ni3sp30W0DMVgtLmwAOhB7SEnTKhk=;
        b=FkRI1oSFLSPWQZd1gG4JKB9DEqkzBPHz1J3ZSORMkTIpxBIVKzswWClpN123vvMz3O
         FBAdnY+QffdA+mpzzdKrii7XP/actfgVgrscTPNf/1zo/w2ufBZQ27/8Y6ugzbRoupVM
         xOF+Pj/069+dH3Hg7t7UetyvMDnvJMX5hDQmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170646; x=1741775446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+odpLyF4k23EH3ni3sp30W0DMVgtLmwAOhB7SEnTKhk=;
        b=XlOHW3r1LyA3N9xqRXrYSnd2ihTQePupyoafDX1E0PMlq5i7OCPeyW2m3SASE3pS8v
         PTasoSY6dptwNNgbat0H6hYWtgKFXzrc5WtboxCxB9Ql7KHhC5A8E2x/cxhv8KbrnMji
         vZNqrqIeK/VQ/T7nHE8sBvThn7P3ChRcm+lPRogzyTPmkHL2woawhoWaxew7lDX1uTVm
         hchDgMXXIbo1kNSi8fIvcIssR4Ahwub1I0Um0hGE8gYpXu3rPvXO1C7znCUsurVejjO7
         0qHyu20vVeXDT+uIJS7GGzrLmdYtK2uJUAEoki7GWxs2T39oMCgX1cYT+QVcGifctjpF
         Ydpw==
X-Gm-Message-State: AOJu0Yzg7ta+AEAobWz90MfgcTbqHIAyoWFgFdGXF1ExMu1Bl7NGpY0h
	+2+fPUfJigrbuNfoB7Sc3By69QKWkLeK0k8DNr+nKUIuoVR5r9ppQl56EcoOwxW9bfcC/2wqYYQ
	=
X-Gm-Gg: ASbGncvkeUUvSzMgLSxDYKYB5VENJO9GfYRfPwXABlm7rmOfVmYDL1fidOtGVqn708q
	EBMPJcRQjPnLzvS70f72YuAb5pisZAiPoXAQzV/444/Q3y9EJSF0rR6KWJ/QXYDpvNx8isYXb8k
	i12GD0rHN0lacwWJKonB2UBmawG7zq4CP9CcPCpNpJVEnGLDdvpAoXyBGr7cY5w/YBYlaQ7gacj
	UrYtInnHGPF1gVwcqlIF+kCh++3XMuh71Z9uBpycWIbBATUnSoxbFPZdB7AydFwjyphKTzdsubA
	Ni+BtVF1ISYg5HW8rR7UseESCACpRqgrODB/2MTasV5Zh77fVHch+SnzFDVRKlwO7B9WLpIDOBb
	xR86rNBbXNVQ=
X-Google-Smtp-Source: AGHT+IEr12P8+POfwnKa+yF+cN86gpr5UhhQpE+esL55M9AKZwD107BAA2+mYGXOuhTK+jURKf0YZg==
X-Received: by 2002:a05:6512:3f12:b0:549:54f7:e54 with SMTP id 2adb3069b0e04-5497d38ba55mr1013061e87.50.1741170645986;
        Wed, 05 Mar 2025 02:30:45 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54952b0d3acsm1516018e87.103.2025.03.05.02.30.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 02:30:45 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613802a59so74475631fa.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:30:45 -0800 (PST)
X-Received: by 2002:a2e:a99f:0:b0:30b:c6fe:4530 with SMTP id
 38308e7fff4ca-30bd7a0e557mr9452891fa.3.1741170642042; Wed, 05 Mar 2025
 02:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228084003.2730264-1-ribalda@chromium.org> <20250228171826-c77ba78a63afe214@stable.kernel.org>
In-Reply-To: <20250228171826-c77ba78a63afe214@stable.kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 5 Mar 2025 11:30:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCumU+a3KNb7=YqDuu=ZpZzG9o9P8Tek_jfsziDwDRtzSQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq9kCH99tev_K6I0_v4nv-sbD5gCy9HpOkVIaAifanobDMWsZ5v61q74Mg
Message-ID: <CANiDSCumU+a3KNb7=YqDuu=ZpZzG9o9P8Tek_jfsziDwDRtzSQ@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] media: uvcvideo: Remove dangling pointers
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

This patch depends on the already commited:
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
> 5.15.y | Not found
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
> | stable/linux-5.10.y       |  Failed     |  N/A       |
>
> Build Errors:
> Patch failed to apply on stable/linux-5.10.y. Reject:
>
> diff a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.=
c      (rejected hunks)
> @@ -1577,7 +1612,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device=
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

