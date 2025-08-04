Return-Path: <stable+bounces-166492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB95B1A561
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 16:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AA518A2A24
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3927120A5F3;
	Mon,  4 Aug 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR5JXakC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B9202C48
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319516; cv=none; b=u7ZtxHDRKzJRQspy4crMFvWklhNPp/sR9tNtTWfX3xQ7nGVKg9L0kP9w1oRNO0Yhb+C8e6HewJRxrvzTuSdG27gqv5dO8E5tti53azuRSh1cfYljOBoS7A74kBcvQCcR4i+28yJjrawuZYhtnnniLIV9gKfcuVrvwaK80i3+VkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319516; c=relaxed/simple;
	bh=leQDo9lWFiFsbFTBBMIWxdXMXVsnj8+H9i157HR6yt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbY5eN3TH029fAiAjzZQR3kLDQ4f5tcleIQPd+6geuj7SLzjEfiUGtzXuclULIFSHxrjtGJZecn5jS65dUgVKpRCLACFK+fzhiYG9/hz29Hq3v8Z189kE9HLxn7/moJxZaw2FSSAhyP96USg5gM4f90GbShNjjLt+TOe77JB4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR5JXakC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31f5ed172daso693831a91.2
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754319514; x=1754924314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7/ASt/irUPb2g601c2QDSCmGB9ne3khsU9MiNt4vQ4=;
        b=RR5JXakCtKeNUxgDs0xGP6xwYwIxjj3C6imvoGBn4oQF9kZsBd2bgU3sdNjnyW8+qV
         WuA50+Q3EJ/teCn2fVxSH+4laZyZl/ClnIgf9PsJo9oCbwf72TU+LnQ8zAmGT3+dphJd
         MnyX2T7pKZugAHSPV2QrTKZqwjRpSy0DofeFVEK0NZSXK7r6DT2ctJEbRLtsZebRyVUd
         OlLSdYsNhQw3mFpwxw+FTelc7ShRerdi4Fdg9Uh6m9hlxrYog+dqJktc2mE2jAg+MDJs
         SxPpqL5HdJa2zX3O3qLasTeeKHF1QFMtVnm4X+fWzDop2UVfoKVGhjeXQ5HiPkWr9hIj
         +qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319514; x=1754924314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7/ASt/irUPb2g601c2QDSCmGB9ne3khsU9MiNt4vQ4=;
        b=hgHb+mg10c3Apvoki7LQyn1q4CIQEgbXzCqivXnprev3fiqTvTK+nsz8dLCHFhEIlG
         q5AlxAezwpC85oxmmsBwPjpLJfG9agqeaBZY5VjHs4zHFAy7hktRuq1yVaMbLrUxEZvN
         9JyW9h5EFhwWdKfWLUmwt7J3HHeFCNxEund4GEjdbGsl7Hb67b792lmBSWw8SOS/V3jP
         bjumERUTxuVG7ZlNDg5Z9lAsQuJj6vD/UJsw+cGOvdlfRLSiCLm/BrvyCQuw5cH8k/Ci
         Ubi7yBaHGq7Shtbd478QKM2d9VCmrq0EZ0R/dV4I38H/thUWMR5pgA9KLicE0DrQnjJ2
         ru8w==
X-Forwarded-Encrypted: i=1; AJvYcCXCqE4UDg4bxP+bQBJg8fI1u8HA9fxDLySQMFJ4/OF5bmjtanel84EdafXwicv5PMs+afj8AUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdVbWJtmd3pskeuQT5rlo0kJP1FSJ+1VvyYlTlCTklVDD0I5L
	sttYOCVOoT/SXEQ64kVLHVSkIY2boRehdqElnCTgCe11a+lZkWVX3QE2RlYEI/llbHI71pB7YUh
	zqEBBDnn0jHpXnX9+boe7+gAkThYZeAc=
X-Gm-Gg: ASbGncvTAHtO/IRefOKQPzkRhC0I+/nJsRxUjAP1tBoVDc3QMRAH2rL6MuwETKgBCdh
	HUnIFJb5H7znbSEGvo74gNoYuBLPDh5+VF3acQvbI2gKGKIy9knxq4ETsHQl3oOVy00czpsdGRm
	H4/uTnGFdECtxXhI4zYy9B9WoOOC5Lyip5y1RZqC7Vpg4UBCz1b/88MFw7vAKjPbNGxZ0a4SToa
	7SAKgMw
X-Google-Smtp-Source: AGHT+IHnKvKiNnjlutaqdoCUWb0lWfV5Y9kAcO0MqZsWa0lJGxMv3NvJtDT1awL/N72gQsh33nqXYiAys09W1DIvQ+U=
X-Received: by 2002:a17:90b:3e8b:b0:31e:a421:4de1 with SMTP id
 98e67ed59e1d1-321162baaf8mr5566304a91.5.1754319513895; Mon, 04 Aug 2025
 07:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731224951.8631-1-xaver.hugl@kde.org>
In-Reply-To: <20250731224951.8631-1-xaver.hugl@kde.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:58:22 -0400
X-Gm-Features: Ac12FXwybowAQCCms396RCTCdCKzGr7u5lfBU9xfKB_GCNmaaQpYGuGENmin-H4
Message-ID: <CADnq5_PQf9qY1+UBzd7C-dbs6mWifCapsywwrfoQrFX1+ypi_Q@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/amdgpu_discovery: increase timeout limit for IFWI init
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:49=E2=80=AFPM Xaver Hugl <xaver.hugl@kde.org> wro=
te:
>
> With a timeout of only 1 second, my rx 5700XT fails to initialize,
> so this increases the timeout to 2s.
>
> Closes https://gitlab.freedesktop.org/drm/amd/-/issues/3697
>
> Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
> Cc: stable@vger.kernel.org

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 6d34eac0539d..ae6908b57d78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -275,7 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
>         int i, ret =3D 0;
>
>         if (!amdgpu_sriov_vf(adev)) {
> -               /* It can take up to a second for IFWI init to complete o=
n some dGPUs,
> +               /* It can take up to two seconds for IFWI init to complet=
e on some dGPUs,
>                  * but generally it should be in the 60-100ms range.  Nor=
mally this starts
>                  * as soon as the device gets power so by the time the OS=
 loads this has long
>                  * completed.  However, when a card is hotplugged via e.g=
., USB4, we need to
> @@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
>                  * continue.
>                  */
>
> -               for (i =3D 0; i < 1000; i++) {
> +               for (i =3D 0; i < 2000; i++) {
>                         msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
>                         if (msg & 0x80000000)
>                                 break;
> --
> 2.50.1
>

