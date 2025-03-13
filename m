Return-Path: <stable+bounces-124330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90DA5FA21
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5413E19C518F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F72686AD;
	Thu, 13 Mar 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alVjjR3M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C08267F4F;
	Thu, 13 Mar 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880308; cv=none; b=ezrhdX/5VKLL5o93TgduznALc8ilyfoOptiowYGKHlJn19izhCOUklnLpCE3oiG25IZCJIFa7jiZClapbHGk2rRP0kRCKecMWTYQhu/PgtJRMsJrBrv/Y5bfp++H+g9wdaNFI44eVV4KKou/OqfQaWnuDU7aAnePKTUt6PPw0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880308; c=relaxed/simple;
	bh=wMkjK3eM/J+DCnwY/w1FF80+Pw0go5FynljZX0c9TcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCPYCgHei/Q/9rLTNPlKWUZSP+ouQzyizE23k/t6RGmI1qGeQtNsQp4I89luqaAFxgV+1BpYSNeSSv2lbM88LfalW5sbQMmykr/efsqG6WK18z+UJFh+O9KX+jMx0jfZ3eq4Jh+MzIEHeB9UX1gVk3Ec4/cc0JX8KS66FNMITXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alVjjR3M; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff7cf59a8fso288616a91.3;
        Thu, 13 Mar 2025 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741880305; x=1742485105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/IG2UNH9lhkw2/E8UkhZN3j0Io+vt9kP0caOhOAn4M=;
        b=alVjjR3M+qE1AcxwNaxlJz5MHGRDT7rMqFCr0JEhECKcerjBtKr4Js7Ci8piw+sr5I
         CuYgVX8TMAOPT1SFKLsM7ux87Gag1RwT5yyHEGm5xQdesM2MuqLjQgE7HEht9tJh+i2d
         +TtJh4D5GtX+Srb289yN4mfijeQijbxcCP5ZaU0P4v4My/V8DDeZmvXH2DhVLbBUE5ld
         jAnWT6UvhXxtyKc9pqcFVoBl03Q+7+oU8kVJGamIcOZcd2UuWUhHDeCoChnEGG3GJNNE
         9CRf1uODCW4dFSqeEWmJJavdCOK2jZqZbkdz4KTIzqnU9e1mo/mU5ksQDFSsLYmSc/3N
         L5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880305; x=1742485105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/IG2UNH9lhkw2/E8UkhZN3j0Io+vt9kP0caOhOAn4M=;
        b=qIabviYTioEvKVYt4IhpN5XeoEAP/1g2Yv2u2U2UAPLjENtS1Ev9H5AS/ZkADxzCRo
         f4y0Zi81XGi2V3qzwsaR47BBqvlUsZr0ov0Gaa2qIhwXDyolm6qepyJtI6v4yoWLdwl8
         PwOnLF83UK9v7Ou+cBM+BeOQsiZIJLqFZAb4wy4DplQMtpRSdVzPKJ3F0YkCuw0Xv7Ie
         8EhMZ+ezWtT4iN6Nj7Mex4bhmI5YkkiUBL+s+9ALRlMTBc8iQD9C7AjPb+MFBVjJuTeb
         knhNCR1eoXUYmZDbc/lCQ6OtNpuGJkKV+idVkcO3+crUVSIJYDTs4u0eJ1Cp1JBdJQuN
         4Uvg==
X-Forwarded-Encrypted: i=1; AJvYcCWFpUqyGM2x10dQV3da02K9XcyKSwMoEu/AoaZQDZ3W69hUxahobiKNU/NfBP4iEGNFzU/1xa7V@vger.kernel.org, AJvYcCWmucXJunJuMgzqYrmavFNUBVxdGIZJWKzY48CTGemY5TXJtXPN+/nefMbIVsDKp4o8MwzVkGCt664hBJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4zDcGpf++0/kHjYE3RgOlD4C2d5+HPt5qOnyWgCEbdrNQYji
	dQkdLHhNzNGQqOQzQvHz9e9pIh3tNwGed1p3QNDvldVrgzU/jtt0BTKub4DDAUl6Fliw3BunnfK
	Sn6dH+bfGctBdz018w20y5QASPH8=
X-Gm-Gg: ASbGncvZ1y8ENsgFDvEO65/g039z5unZYyniA+0/zyFbkRcH/nH5BKOR6/9vWo8sm7y
	u5Buln0udTMDpa+VO/Bxll5BgIT0ctNvhy/iccdd2WGiwKQCyWc1yfYrZy2vbyk87NFnc5JJVdF
	K4ddM6XfhWcN+9dFeV5IGS9qOwng==
X-Google-Smtp-Source: AGHT+IF6424p+zrs81oK/FMpNgLrtT9UJ2LVWKyFJVkfm6+/bB/C+cR8PsMtaS4M3CsCMWprNAn/8jFeuEpAYxVJzTI=
X-Received: by 2002:a17:90b:3812:b0:2ff:4a6d:b359 with SMTP id
 98e67ed59e1d1-300ff91fb2fmr5520980a91.7.1741880305351; Thu, 13 Mar 2025
 08:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312063106.772-1-vulab@iscas.ac.cn>
In-Reply-To: <20250312063106.772-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Mar 2025 11:38:13 -0400
X-Gm-Features: AQ5f1JpzKR_TjlBfb7plqnz-2EyQBV5yCEiQgCqhVC2krXJgZq2oSKe1L_igh0M
Message-ID: <CADnq5_O8s5=bOmQDU=FRLxz75LuNq5BzON_i=-KBM9o8JeSDLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12: correct cleanup of 'me' field with gfx_v12_0_me_fini()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, Hawking.Zhang@amd.com, Likun.Gao@amd.com, 
	sunil.khatri@amd.com, kenneth.feng@amd.com, Jack.Xiao@amd.com, 
	marek.olsak@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Mar 12, 2025 at 6:09=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> In gfx_v12_0_cp_gfx_load_me_microcode_rs64(), gfx_v12_0_pfp_fini() is
> incorrectly used to free 'me' field of 'gfx', since gfx_v12_0_pfp_fini()
> can only release 'pfp' field of 'gfx'. The release function of 'me' field
> should be gfx_v12_0_me_fini().
>
> Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index da327ab48a57..02bc2eddf0c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -2413,7 +2413,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(=
struct amdgpu_device *adev)
>                                       (void **)&adev->gfx.me.me_fw_data_p=
tr);
>         if (r) {
>                 dev_err(adev->dev, "(%d) failed to create me data bo\n", =
r);
> -               gfx_v12_0_pfp_fini(adev);
> +               gfx_v12_0_me_fini(adev);
>                 return r;
>         }
>
> --
> 2.42.0.windows.2
>

