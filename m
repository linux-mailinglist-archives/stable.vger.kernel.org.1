Return-Path: <stable+bounces-207971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70508D0D944
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CA8830248B3
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B532284B25;
	Sat, 10 Jan 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="q9YiOe6h"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53925DB1A
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768064070; cv=none; b=Y9Zh5OwxPA8VXuqP37FqKfxZt/cju8wtIe8g3r1kpoOk2/dRRReh7/zd7MNlyuyvuezf+urFoSGQSfZyfup+yLVV3OFIwEhuWvgG1IOXvyQ05FLO6NFTOvmL/BrYw/GebrslI5BTB9iPZRBc8fO29qyhAxuBXcUE4wIFEjsv5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768064070; c=relaxed/simple;
	bh=euKp8D5SGRuBRwnBID71nrQ+qke7wreDwmWtH1i3GY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGYN7Yr8e0lohwHK48VEgdV4AYB6AAAwUgxMCYv0FIeMGzrLDb8Sd1HuLog5t4WKEAB038hrD/w9qktkzoxOB2HEN6A1/R/wTWI4ifayE4FmcoF50C0yMzPYMU5+xowUijS5+luWVbp5AuSObLDMLrxGDaaPyfsxJf30wfBUIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=q9YiOe6h; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79045634f45so57902047b3.1
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1768064067; x=1768668867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgFtFK+acLpuQAz2BzGRmGrNRWb9jmojhInoAcIgzv8=;
        b=q9YiOe6hkRFSvjZK3OPS32yG6YC71C8/obEz+/43sc8hU4lHy6sRUC4JHnZNxuO9o1
         iSmOK4jUpYGuiCFmKWUYjsF3hFfCGK+iLVNWzPBh5pcp4bXg9UcAAJ7MsrGCBiGIlfIl
         1naaM43SwEEMeRJMiPhDwOYoe91d3BdAKMvfXnEyOgIiu6ugcVj49YAr2/uO1EV6uNPf
         ejBq49lgo79OcVEGLWmIBE3tS3MItj3r64wapLW7oIR6EPlQPs5d0ptR0WjqGFqTP099
         kVShppMxErzW8eAEta9kdUvxkhTSMEqyaubhzadwWv/MBg/4evOK8UDgVXJhBRIg9kxb
         NO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768064067; x=1768668867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zgFtFK+acLpuQAz2BzGRmGrNRWb9jmojhInoAcIgzv8=;
        b=CDfW3n4wciIwPOdguy/mjjgj4VoSLZIgryDbHv0HG0frnoiDAMYLz/a+ViKTEQm80w
         2rYTPDM/I46uEzV5FCFQgLh6JjcqAKW1O16O3O5ArYPQsuAnjlHUtFOvV5gZK32zHbah
         syVYziw0UTMl1bDCLvZ5pD6iuMA2bYL3WsMFd2eRL1yxG9wLyaD8+VZeNZg7Jz1iWlZq
         qbklIYrP7tVLB0Uxx5CiG8Bj7YgXYb5KVTN0hqhaQ/IDpbd1aikHnXoP8gKe9XyAfLeM
         +zb+5/rV58K7a/XZRqBcMZVGb1Sc9XkfLVZkPXjdCyw+RGS4RVVrml9Gzeb6P/gab2C6
         NThQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+fKG/x433PtY+nwXhtVYio7zZDN0R7WeC/t0Ylrl1Dxektt3CdKouUmOYHbqzF2/R2LaTqYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBTBf4mUeSa5soMncUZiTuW0XPHjEyUAoc+fuKDL881NvF42q
	T3VR5RmXgueD+svbEqlNgWpx3xNw65sYk2JWRrTNT/0pk5sAL+p9NbsoUi9FPxblFzUD2c8UJed
	foxPHB4E=
X-Gm-Gg: AY/fxX6pJugG4vwIS8Td/aw50oAq6yiF0+OIEC6X6/aYXijfwlf7G3VvotAILSuQ/21
	2zCYPQ8yzVgEar2rdmgNmpOttN4WHqdjTrg/1Iesr5D2idzUS1l241S9kGAPyGmjQ0lM5UwBdL0
	7Yjlmww0KYYt0G1uI1PXVLJjSaDqO9FuFXm0ZeIlp58phygrdJBss2K7W/eFPO318Gpp6vW4Y9Q
	ysDEnRspEQrUvVwvEteTXE40n3wyh7to5VIMV4JCSXfWp3gnykDES4cPe3/fsrNTG47u9CGE8v9
	/8L1n2exTg9KA0T7WamBa33jQe/Ou5t82Q9w8zKHBkHiNXIRXrNgH/p7/7/D/aD7R/MeFj0Ny6m
	bTAKfyE7upFhls28QS5F/sZ0FVYY9LO+7B/pKQQorZbCwEUi3MGNr1Me55ut+osPEhCSg89vCbG
	6obMXIzbtmKYsgDgpxVOSIioEuuKnnl66aIN/fcTJjJVdQ0eijhA==
X-Google-Smtp-Source: AGHT+IGEYkcqcSAnvNWM5yQnC0SfeCPcDTfvNrq6PCTbSFWnAAn+JdXvjizKT9bWBcHO+peW9bUYaA==
X-Received: by 2002:a05:690c:670a:b0:792:7463:c980 with SMTP id 00721157ae682-7927463d5d4mr18854397b3.43.1768064067348;
        Sat, 10 Jan 2026 08:54:27 -0800 (PST)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com. [74.125.224.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa55328fsm53080547b3.6.2026.01.10.08.54.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 08:54:26 -0800 (PST)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6467bed0d2fso5145925d50.0
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 08:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXngJ+TI753Gb4zram6pVJyGIXluEtpFQrbYfCdA6enBi9Foe0U4J/KOfRI6chWWv6qHP3wfHc=@vger.kernel.org
X-Received: by 2002:a53:bdcc:0:b0:63f:b1d4:f9e3 with SMTP id
 956f58d0204a3-64716b3a7d4mr8056846d50.9.1768064066164; Sat, 10 Jan 2026
 08:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
In-Reply-To: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sat, 10 Jan 2026 17:54:15 +0100
X-Gmail-Original-Message-ID: <CAAObsKBmJDbDfegLP-yrO+ys5m1zyoDUe9KMQ8tHeRXxQGAdow@mail.gmail.com>
X-Gm-Features: AQt7F2rSDY8AwFu9wKOfOPB3fQ0feqjbIImAsj0T1FY9RvNW3OrnzYnknqJKAuw
Message-ID: <CAAObsKBmJDbDfegLP-yrO+ys5m1zyoDUe9KMQ8tHeRXxQGAdow@mail.gmail.com>
Subject: Re: [PATCH 0/2] accel/rocket: fix unwinding in error paths of two functions
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Quentin Schulz <quentin.schulz@cherry.de>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 5:36=E2=80=AFPM Quentin Schulz <foss+kernel@0leil.n=
et> wrote:
>
> As reported[1], in the current state of master (that is, *without*
> that[2] patch, yet unmerged), it is possible to trigger
> Oops/out-of-bounds errors/unbalanced runtime PM by simply compiling
> DRM_ACCEL_ROCKET built-in (=3Dy) instead of as a module (=3Dm).
>
> This fixes points 1 and 2 reported here[1] by fixing the unwinding in
> two functions to properly undo everything done in the same function
> prior to the error.
>
> Note that this doesn't mean the Rocket device is usable if one core is
> missing. In fact, it seems it doesn't as I'm hit with many
> rocket fdac0000.npu: NPU job timed out
> followed by one
> rocket fdad0000.npu: NPU job timed out
> (and that, five times) whenever core0 (fdab0000.npu) fails to probe and
> I'm running the example from
> https://docs.mesa3d.org/teflon.html#do-some-inference-with-mobilenetv1
> so something else probably needs some additional love.
>
> [1] https://lore.kernel.org/linux-rockchip/0b20d760-ad4f-41c0-b733-39db10=
d6cc41@cherry.de/
> [2] https://lore.kernel.org/linux-rockchip/20251205064739.20270-1-rmxpzlb=
@gmail.com/
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Thank you, pushed it to drm-misc-next.

Best regards,

Tomeu Vizoso

> ---
> Quentin Schulz (2):
>       accel/rocket: fix unwinding in error path in rocket_core_init
>       accel/rocket: fix unwinding in error path in rocket_probe
>
>  drivers/accel/rocket/rocket_core.c |  7 +++++--
>  drivers/accel/rocket/rocket_drv.c  | 15 ++++++++++++++-
>  2 files changed, 19 insertions(+), 3 deletions(-)
> ---
> base-commit: a619746d25c8adafe294777cc98c47a09759b3ed
> change-id: 20251212-rocket-error-path-f9784c46a503
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>

