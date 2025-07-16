Return-Path: <stable+bounces-163181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFBEB07B3F
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC04582EF3
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B621CA1D;
	Wed, 16 Jul 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAe0f0M5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A63BBC9;
	Wed, 16 Jul 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683608; cv=none; b=SW0BnmPT313VXGBxtv7oQ0wc86OtfNX5IRx6r5mAwQrNGdEgEXMmvgLc6mfDRJY1ne/MrtyQo2nXCRw56s/edY3DfcyGz7VUrcvgyeCggCa5KYDQNZ5BodLjHCeuFmioUmkK704dqskMtSlz8N+WeprHioKx27D9Z/vfjK/PEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683608; c=relaxed/simple;
	bh=t2VYmA+g3pP4PYiBq6s06JykaFHIJUfcRmzrTy7uh8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zp68qCkX0hnBHujjtVRIql9VPMjTUsQQNQy2y2LAm5imWzD4lrr2/Ls0uKmL5abyHhB4SOR6O/XCodVmDjusSpq1jdJgLQwtL3nL5GgVizSV6raFEPVILob8D62vdyP8knMIXcXLqtEUVRuvQB7OJ0t4+3ky0/XRiOsBXfd4Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAe0f0M5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31308f52248so22580a91.2;
        Wed, 16 Jul 2025 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752683607; x=1753288407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6kvfz6qI7DeZGGpdbs/tIzaH7qf+aL2nFfg6lLF3So=;
        b=gAe0f0M5TlvjKrrFTY5kzB/F5ftWcgkZbz70bQjeRbrEkLkLeePwNdT5/Mngmtwp+G
         J7ZitRfvZa0bMVos41oTGvC4nacHTDoCltIJsSn3SNtGzZ4jrrv0Lg8Jkz0eiKUz92vc
         t2Pv+2akIwPQx1q+ZhLosa5ZEvOcr1LQXMRGdMaoxB0EpdG5RNXJ5jzjfOFBh5wbA8fd
         66pTia4YJK+3bngkJwx9eVaHvOw3PQs9C+8TZ+GVvq3XQC9l4N6KutLSwPlWP3wNce26
         2dtTY+Yo4l5Aa4fULUl2pVbS4Osaa5NYnmX5dYeGG1IReHaMabec6DiaZeOylWCSom1r
         z38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752683607; x=1753288407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6kvfz6qI7DeZGGpdbs/tIzaH7qf+aL2nFfg6lLF3So=;
        b=IxuguXlX02kqT0TXJRmCQ8mKxV5LZjSN1xD0To4WqKPVC25fT7X7SSlZmNFZRm83Dx
         5tERnewUy/qzLLkoG5bY6UbdDCnUgsU4nUn++qHT7VB2UB2Cl4Ldr2nUqTC690CfTATT
         sk2W4vv1f6SKaYVCazWa6cQMFzZI1Ucn/+TFF+lUemG/yFYm59Jvjxk1PzudeoH1bPwm
         oCw6u+hwlAomYTF9MEZ3mWvhQrmP6oV19uUuTAfb1sQbOAxYWF8d9kgBQOrtWgnQi5nb
         SlamRGNFqpRit/Tz/JKtpSKYreNoQ79tigxksy0VlSHntZ+o1u8DZAme0yT5QbyQgxRs
         fXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkl8hQHWClm/ikSec2H1AiUL6hRR2LnvYrwnEitPbAXm/dVhV8vpFRMpyJYnN2qKxdRQMB32j/@vger.kernel.org, AJvYcCWCparWRHHYQ/1fAoNVOT/FdbnWcPLlFXfaBT+H3gDMjz7iJI9S5qQyCyL4mstSMTvAqqwQq9npzy6LqOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAouVHsR5aNfhEIDsDl0iobtV2rqiSDqsWwpyCd4oEF8/J04s3
	08xCFDS01pMDNnQGOy0mtpQzmV85xB7uoYrRw1qTrEhSbhQfPGsRrFj+8v6yb5Y4TFZahbjFY/n
	S6+D9MN9N1bXd3s9FIPPOSsHHceQXdRg=
X-Gm-Gg: ASbGncufP70CqZdAljxkB2wctw+SwKMzRDSsXkvxxTRFRSQvax2tNYVSn8Lo7IxabHN
	dJ3JfTu4moSvIi1L6ySi182pQjRmeda9rBn3WOXOv45xs3wmz+LRs8F7w3m+IvLYMS06xX8lFmW
	FsPvGcu1E6NYz2bXxiTjR1mr9kLD8DPTuLJyJBqq/QEVTDc+7EEl9C5S/pLeL0+h4sRZa0ZL9DJ
	rYGFuESS5mx/4pjsDs=
X-Google-Smtp-Source: AGHT+IGH02kK3nf0wBnxEd6jFb8Tsf0f+O7BQ8LAJmQ7cLUtzxcWAGs+OU1waCN/Gja7YYGXXxQ/tdPDawx20M8+Yx8=
X-Received: by 2002:a17:90b:5610:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-31c9e6048aamr2513820a91.0.1752683606488; Wed, 16 Jul 2025
 09:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com>
In-Reply-To: <20250716161753.231145-1-bgeffon@google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Jul 2025 12:33:15 -0400
X-Gm-Features: Ac12FXynnQtGo7k60pqb-2x03E1O-iBR7bwfy-E4dA6mxcK93JHx0XXz9lriT9c
Message-ID: <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Brian Geffon <bgeffon@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@google.com> =
wrote:
>
> Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)=
")
> allowed for newer ASICs to mix GTT and VRAM, this change also noted that
> some older boards, such as Stoney and Carrizo do not support this.
> It appears that at least one additional ASIC does not support this which
> is Raven.
>
> We observed this issue when migrating a device from a 5.4 to 6.6 kernel
> and have confirmed that Raven also needs to be excluded from mixing GTT
> and VRAM.

Can you elaborate a bit on what the problem is?  For carrizo and
stoney this is a hardware limitation (all display buffers need to be
in GTT or VRAM, but not both).  Raven and newer don't have this
limitation and we tested raven pretty extensively at the time.

Alex

>
> Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)=
")
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.1+
> Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 73403744331a..5d7f13e25b7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdg=
pu_device *adev,
>                                             uint32_t domain)
>  {
>         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GT=
T)) &&
> -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D CHIP_STONEY))) {
> +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D CHIP_STONEY) ||
> +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
>                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

