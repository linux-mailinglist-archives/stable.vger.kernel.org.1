Return-Path: <stable+bounces-136590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00907A9AF80
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAE7ACAB2
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A1183CA6;
	Thu, 24 Apr 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opa7GH8v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3441993B9;
	Thu, 24 Apr 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502054; cv=none; b=Mxd/BeTJs4vPfnWjZOjw+nS5r6pajKLbswDB8UIB+o/torD//hVve2bLkcIu3nwfaRSoCfshPU+pFCX2eF5uYCTYWbfVWts4rOlWr5JZf4Ucuv4O/xDd8wstUFITvBVI1di6lSzBleeXT3IhTEp8Gtz73ADycqeule+Eq3Gzq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502054; c=relaxed/simple;
	bh=chM8XrpuD/1v0wpXfbr9Lt3+9f0+NNkETTt1fZS2qec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOmFPYGvnyrfWyQL3CX04BG9EFoWQ1a8KWOnSYCTjZ/HqgbSfnf2YKN+2xioa4j4g6fqpRaYS5MLhq15ETETVIIgwOT7xYOigF8UNNiEFjwU+ReqLceb2VtJ4TxwZVdcctCIRANzhelsEbixL/jg6TgMlM7SlIlb26Wco12jNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opa7GH8v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c50beb0d5so1752575ad.3;
        Thu, 24 Apr 2025 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745502052; x=1746106852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGR59W4mDFi4xO+EAgOhdxOaLwy6rWMY5fVRK30YhEk=;
        b=Opa7GH8vZUAp/bInre53cbPYvZhOAOi8u2nSliowiFXisaqElvqwii/j0eR911WVKX
         QWGJJ3pAyZQ4KKimSfqc8szaT95rdcqpubg/kE2yZXq64YBL5St2egddaI17a5vaQVKh
         iy89tMqE9R7Sjr+Rw95AQ4zTxakez+z1R/yTdHz5DieOa/k8tyMdlfN4s5FHwbQdFPRQ
         F8IXNR8LftyYX+JVgDSUwXnRw86TX4U+5f59/zt+TMBUNB1VyLGSClIzCdw2nGeBghOY
         QG41cSVtYsjTpcD4gyojpbGMGg7CHDIRQqc0umuuV0WpiVgQqT1kn1QMDyL/Q4J4pl3A
         E6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502052; x=1746106852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGR59W4mDFi4xO+EAgOhdxOaLwy6rWMY5fVRK30YhEk=;
        b=EeB7AFBRFNy+0Nvs3N3RI6BXksYF1ZQsEIcdk9ybEp7ZD80N/HJwdQeL2mOh/avC9H
         t2N5Vdqnakqv8rDyDgZNrg7MrbvEwgsyIcttndu4b7MOIhVXGzs+g9fSHG1k9wGAlK7h
         9iy7duYur5qIdainB7Lthu83B6sNsDuYqClArM6v/PR/SZ2c7Ox1pwOO1WbjYAj4peb8
         r+c2qW4fAlu/a7U0lJDDfqoMTdFBR4ADdoA8h17DVe7kmB9cYvxI1jJH55RVsidirk0d
         WAcAlSBIy1IupIrBUoCqXg1pFLs7cYrJXSnNZ6JNerc2iglk6PqcISWCKpnouvjjBzdj
         gwFw==
X-Forwarded-Encrypted: i=1; AJvYcCUAMjYPfwQdb17ZMfguxh0Kop/6ZLAOLLFBJe02hwFyGFdlH2RtYFKhzOdGTXzRsvvqOaCVEM/aivm362E=@vger.kernel.org, AJvYcCVL5IE4HQfLoTUqMUt46xh/Qs6TBQURo4/YKM/jH1kkfWKI5699tc8mwewFnuV0WUo5CPfkZl0V@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx2shyjQgeBkZzblJGrxWfUwf4hWA2Y04w38MgJ0GienlkRJLU
	NnlvMAAZRTeZYveFB1SU4zzubnFDdjefhD+ETk8owR7upxxjN3Dpv+1AqGqrvKinCu7+jlDn9kt
	XgXfoX8Jiw6JJrHPI4lqjfpTYv20=
X-Gm-Gg: ASbGnctNyjyolS0TDTWFJz+DyItZctTQvtXh708063YJSUcxuNg/WFbN+5hFU19lULP
	V3lRrJnwUIun1TRg+9iq5s2uuCfywQpsV4ykm6eO+V8QivUns6W7QlNTwKtsd6LOtCOoNs0GGBq
	kX4zaBr0lny2KdMCxmXAeIvZotUBUoU2ev
X-Google-Smtp-Source: AGHT+IFvVwkz/fRggf4RXSdAHEIOl2NoH3IHh/SjTK4riJvjfQYcCpR4CKh/u9HL7mVUlCxaPq6yhDN8QLMRohVGWjQ=
X-Received: by 2002:a17:902:c94d:b0:224:1936:698a with SMTP id
 d9443c01a7336-22db3becec4mr14640995ad.5.1745502051712; Thu, 24 Apr 2025
 06:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418083129.9739-1-arefev@swemel.ru> <PH7PR12MB56852EECD78C11BD15157AF383BB2@PH7PR12MB5685.namprd12.prod.outlook.com>
 <CADnq5_NLEUZget2naQm9bYH1EsrvbhJCGd7yPN+=9Z_kKmUOCw@mail.gmail.com>
 <BL1PR12MB5144467CB7C017E030A4C3E3F7BB2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <9e4700f6-df58-4685-b4fe-6b53fc1c5222@amd.com>
In-Reply-To: <9e4700f6-df58-4685-b4fe-6b53fc1c5222@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Apr 2025 09:40:39 -0400
X-Gm-Features: ATxdqUH-6vkzj31ZXtYYUvGAtxeQT0Et5GikCO2xh4TnwiIKM3nEqTfSrYXtSjE
Message-ID: <CADnq5_O-tqQ4y7sNx0nMD_0aTFO0H7_vVg=umaPXUbBLFmwnJg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: check a user-provided number of BOs in list
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Denis Arefev <arefev@swemel.ru>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Chunming Zhou <david1.zhou@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 10:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/22/25 18:26, Deucher, Alexander wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Alex Deucher <alexdeucher@gmail.com>
> >> Sent: Tuesday, April 22, 2025 9:46 AM
> >> To: Koenig, Christian <Christian.Koenig@amd.com>
> >> Cc: Denis Arefev <arefev@swemel.ru>; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; David Airlie <airlied@gmail.com>; Simona =
Vetter
> >> <simona@ffwll.ch>; Andrey Grodzovsky <andrey.grodzovsky@amd.com>;
> >> Chunming Zhou <david1.zhou@amd.com>; amd-gfx@lists.freedesktop.org; dr=
i-
> >> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; lvc-
> >> project@linuxtesting.org; stable@vger.kernel.org
> >> Subject: Re: [PATCH v2] drm/amdgpu: check a user-provided number of BO=
s in list
> >>
> >> Applied.  Thanks!
> >
> > This change beaks the following IGT tests:
> >
> > igt@amdgpu/amd_vcn@vcn-decoder-create-decode-destroy@vcn-decoder-create
> > igt@amdgpu/amd_vcn@vcn-decoder-create-decode-destroy@vcn-decoder-decode
> > igt@amdgpu/amd_vcn@vcn-decoder-create-decode-destroy@vcn-decoder-destro=
y
> > igt@amdgpu/amd_jpeg_dec@amdgpu_cs_jpeg_decode
> > igt@amdgpu/amd_cs_nop@cs-nops-with-nop-compute0@cs-nop-with-nop-compute=
0
> > igt@amdgpu/amd_cs_nop@cs-nops-with-sync-compute0@cs-nop-with-sync-compu=
te0
> > igt@amdgpu/amd_cs_nop@cs-nops-with-fork-compute0@cs-nop-with-fork-compu=
te0
> > igt@amdgpu/amd_cs_nop@cs-nops-with-sync-fork-compute0@cs-nop-with-sync-=
fork-compute0
> > igt@amdgpu/amd_basic@userptr-with-ip-dma@userptr
> > igt@amdgpu/amd_basic@cs-compute-with-ip-compute@cs-compute
> > igt@amdgpu/amd_basic@cs-sdma-with-ip-dma@cs-sdma
> > igt@amdgpu/amd_basic@eviction-test-with-ip-dma@eviction_test
> > igt@amdgpu/amd_cp_dma_misc@gtt_to_vram-amdgpu_hw_ip_compute0
> > igt@amdgpu/amd_cp_dma_misc@vram_to_gtt-amdgpu_hw_ip_compute0
> > igt@amdgpu/amd_cp_dma_misc@vram_to_vram-amdgpu_hw_ip_compute0
>
>
> Could it be that we used BO list with zero entries for those?

Yes.  Dropping the 0 check fixed them.  E.g.,

+       if (in->bo_number > USHRT_MAX)
+               return -EINVAL;

Alex

>
> Christian.
>
> >
> > Alex
> >
> >>
> >> On Tue, Apr 22, 2025 at 5:13=E2=80=AFAM Koenig, Christian <Christian.K=
oenig@amd.com>
> >> wrote:
> >>>
> >>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>
> >>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>
> >>> ________________________________________
> >>> Von: Denis Arefev <arefev@swemel.ru>
> >>> Gesendet: Freitag, 18. April 2025 10:31
> >>> An: Deucher, Alexander
> >>> Cc: Koenig, Christian; David Airlie; Simona Vetter; Andrey Grodzovsky=
;
> >>> Chunming Zhou; amd-gfx@lists.freedesktop.org;
> >>> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org;
> >>> lvc-project@linuxtesting.org; stable@vger.kernel.org
> >>> Betreff: [PATCH v2] drm/amdgpu: check a user-provided number of BOs i=
n
> >>> list
> >>>
> >>> The user can set any value to the variable =E2=80=98bo_number=E2=80=
=99, via the ioctl
> >>> command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
> >>> expression =E2=80=98in->bo_number * in->bo_info_size=E2=80=99, which =
is prone to
> >>> overflow. Add a valid value check.
> >>>
> >>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>>
> >>> Fixes: 964d0fbf6301 ("drm/amdgpu: Allow to create BO lists in CS ioct=
l
> >>> v3")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> >>> ---
> >>> V1 -> V2:
> >>> Set a reasonable limit 'USHRT_MAX' for 'bo_number' it as Christian
> >>> K=C3=B6nig <christian.koenig@amd.com> suggested
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> >>> index 702f6610d024..85f7ee1e085d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> >>> @@ -189,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct
> >> drm_amdgpu_bo_list_in *in,
> >>>         struct drm_amdgpu_bo_list_entry *info;
> >>>         int r;
> >>>
> >>> +       if (!in->bo_number || in->bo_number > USHRT_MAX)
> >>> +               return -EINVAL;
> >>> +
> >>>         info =3D kvmalloc_array(in->bo_number, info_size, GFP_KERNEL)=
;
> >>>         if (!info)
> >>>                 return -ENOMEM;
> >>> --
> >>> 2.43.0
> >>>
>

