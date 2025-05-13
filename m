Return-Path: <stable+bounces-144163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D282AB5504
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB65D3A937B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18D28E56E;
	Tue, 13 May 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auR5xppo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951228E57B
	for <stable@vger.kernel.org>; Tue, 13 May 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139867; cv=none; b=d6r8MsO+Bufh5FVBuazpi2ODqUfH0oxYRByPLk/Sle1GtngTavIab1yfer7Cz1keEs8Wvb6qsutJdvsxYEBNaYfHBie7KNrHAi85tbJJtp/L6udq/awPm/8FhB3YSrQYaI1+mqKLvv7CKkhpuVHoA11VFfZrHfRIs2avT8sI+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139867; c=relaxed/simple;
	bh=CercuWQuxV7yYRmjzCDzSCtPbUQJXPh+UG0ZNmHQx04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2aj3b7PVYYDF6sYUGhyqgrHLZsSxtHPHd58Guo8INmLHV9BfRC7TziL3sgU0OxpheXj/oXYP04Z0Z3hez5GDoAmTYI1UHmrM5olbBSRL6mBN2Y7F/WriFdpuSYiTzh3UIvMwXX7gLBdTZasY3pv1kcjB1yGdGCzZL82pfr1pyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auR5xppo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b1faa09bae7so775240a12.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747139864; x=1747744664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgXUZnJrqELb6WJv8slnNwPAEoBp1ybmjH13rA8LCYY=;
        b=auR5xppoO0P9JVLlTmaZSdveboVYqrAk01nglqfsZjYQjFme4ebe+lm8bV6kI+rN8p
         1xbGXREH2DNtYIIlAZKdnnhl2+aV0YdHktr0WzBuZf0T4VqioNz2ap/eZ4kY9eSueQLn
         gjwajMzVG9Vx71TVhaV/lMb6cMQBYQf7VpI2ZDAyiS8jXPlJCqitOmWeJTBDC4/FIM1P
         io/IfDXX8wuddK8aED6yPIFLjp4iGVZ9EAVIewJHfZpMG7+bIAFxOnWHORTa319J8o0j
         7roGiMm+8ACG0bcIAlqLwbT5mjN5fvN4399+KqTcKcyjs3YpuI3XaYF8ZdWE4dbCJl/N
         dRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747139864; x=1747744664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgXUZnJrqELb6WJv8slnNwPAEoBp1ybmjH13rA8LCYY=;
        b=RzZY10zmYH4qg9L9ThXuf3eOLyqjNaRgyV8oIhUM2zL3NFuv6antIjLr+JsPhf8zW/
         ejH5LSVOwZMI0NqxKgCYvqBXsKkRsOblvwyPXGSZrJhkmZ7E7FZoTtLiieACaW3PZgXF
         3xkLtJxx3H9mru9v25JYKKJriafdT0NldKDm0XCVRgCbG8dDbblHE8/64W1S7TwrsIOo
         vqn7JtmuqKQg6mk3HdtsbvLvmWMyyMmsoosblfn0lQkYPts19czwjNLDrbHUjFKpwjsl
         f0pemRhD9K6Y0cOg1lSg4KsgZYy72ddLdWrWuNINSyqOQJb2PKPgGp1iWre0O4Xk33S6
         M0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXJjhGpGER4qpwiHic2awNWwbaoVr5RQVf0t6p/AtX+F2biTKlf1ltkr5yX5wRUVZGKySD493o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5VLwJLMnqzazh7vZXqnYupHxF/cOIIc9svR6QEnyx2WNjL5U
	eF4zdNxQVbVeOT3Wpo/1L5ez2UAVnNS20OZ3hE2YEipNBj3wgcvhBHK6dlIMaQei/dxx9up8qxI
	H8jtz5Y5BPyfk8+cmdfxiIvfK2JY=
X-Gm-Gg: ASbGnctHZq7NChW+/8HMlciMVVcpeL4QxPQ4eAHxUFShRUNEYOUQWRfwDZBn9Nn2Pmd
	DzetzJjn/5N2ivgLZQ/gPpPJgeVIEd1Egwo21HkETiCTKquF7wesO7hEcUDQTP3InHVX34jLOCU
	k1+qhxcl+3/bUPC+LGmMAdC15YGp2MngHl
X-Google-Smtp-Source: AGHT+IGXqPrVWRTuQse/tWr97RYjVGYHVy49EKbzFZn8J+XGj6eryspfICEPDRcE8n8HD7EavK4l8XRs+17SEyinqhY=
X-Received: by 2002:a17:903:41c7:b0:224:1936:698a with SMTP id
 d9443c01a7336-22fc8b59833mr95879785ad.5.1747139863710; Tue, 13 May 2025
 05:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513032026.838036-1-Wayne.Lin@amd.com>
In-Reply-To: <20250513032026.838036-1-Wayne.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 08:37:32 -0400
X-Gm-Features: AX0GCFu3j0lM1p8BuPuDkqkhIaFJ4v4zeXAHbwYXKHGN98V6GQH5-a8l3nDRe-8
Message-ID: <CADnq5_MrUPvFVTkMixCuhFqpEuk+cKQpXJPBBBpaVwqrTashMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:28=E2=80=AFPM Wayne Lin <Wayne.Lin@amd.com> wrot=
e:
>
> It's expected that we'll encounter temporary exceptions
> during aux transactions. Adjust logging from drm_info to
> drm_dbg_dp to prevent flooding with unnecessary log messages.
>
> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER c=
ase")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 0d7b72c75802..25e8befbcc47 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *=
aux,
>         if (payload.write && result >=3D 0) {
>                 if (result) {
>                         /*one byte indicating partially written bytes*/
> -                       drm_info(adev_to_drm(adev), "amdgpu: AUX partiall=
y written\n");
> +                       drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partia=
lly written\n");
>                         result =3D payload.data[0];
>                 } else if (!payload.reply[0])
>                         /*I2C_ACK|AUX_ACK*/
> @@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>                         break;
>                 }
>
> -               drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail=
:%d\n", operation_result);
> +               drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fa=
il:%d\n", operation_result);
>         }
>
>         if (payload.reply[0])
> -               drm_info(adev_to_drm(adev), "amdgpu: AUX reply command no=
t ACK: 0x%02x.",
> +               drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command =
not ACK: 0x%02x.",
>                         payload.reply[0]);
>
>         return result;
> --
> 2.43.0
>

