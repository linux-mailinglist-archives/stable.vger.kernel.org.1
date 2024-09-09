Return-Path: <stable+bounces-74072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621097206B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86E61F24338
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49AD176AB6;
	Mon,  9 Sep 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK7w6x1U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC66173328;
	Mon,  9 Sep 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902727; cv=none; b=fc6atbMdO1L7jv9qzTVe97uiwJN8W0iknClprUTMC4XPsxuTINlzjVRXOgc/nYOLoBWFTHmpiHKtJeKInKm85dX/PmeD00tk7cdQiYKhPSMfBzQ+ega8bp4970o88mvAqUEOwwFUtBwxiE4hqk1NSd/SEGWYcYdYOG35on8FFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902727; c=relaxed/simple;
	bh=x5b9yMIYdeozokFTxEtCcPcMyDUISRlG4u4tDgBljBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRCv+XNgG/h5IZHuXti8T8kLlRbY2/T6yqfAcVAd+N1Wf0CAaFfVsjM7G155DaJdIy0jnphdZf+ZksaFIOMAfMw2m3fuW5F2KEY11gCUGUIwrGTAhxJ3tYaYPrs54PXGB12CPtgBu9MP659mxPDXrg7mogRA3W2iv0yz6+hzAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK7w6x1U; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-846c3aa0ff2so158087241.3;
        Mon, 09 Sep 2024 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725902725; x=1726507525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6HhkSoNUnMMq3D2hVDty/duRuGXfXAOcY5s6838TPc=;
        b=QK7w6x1URtvvq4vY/uh+T2BiUkWhBVLOqBhPN+KvFs/eAOSx/IdcAWymTzw9luwdao
         UAfdOMc71JC6eTDjmYxPtN2lFWzgMjWcS+yNiwLLdCtR5vTVAbk5ajiEZ1B1SzZY9Tx8
         Rv4CasBoN9NNuclmhaCwlq4b3Jfy+aSmHAOv9zGWJCFgPZ/mQnZ64qGFq/SdqZ21Q1Hz
         ks+TUx8MrxlkACgnHY4Lu3nlUqQoicYBXkBUdZBUtKt+DpEJ2rboMjT6WC9uhPHSd1QZ
         KgIrIOZX63pdg8YuT5Vwf611hpHWyOOu0QTYxJSBmb3RDaSIRu7bWK9e7fnl9X1lrV/i
         ZFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902725; x=1726507525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6HhkSoNUnMMq3D2hVDty/duRuGXfXAOcY5s6838TPc=;
        b=JV12tqtT+zlCcFbb9gj7HhgNjoTulWWAr94SdsBqzv+rHmDFKY4G/xcL8RYcbAyqlU
         Kuwo6EngJA9PUlSBCn+WXLcAlIdSDq8sgr1CJSVW2hqKarPaA1QRqRiEhADSYQ+BqS6n
         +fSKlL0Xw8iJusnHJjYt8c+FEPp5nXmwnEymk7EfezM32Hr+YvCm/bQCvZCzhOINREBV
         je3gfFKewHz61QwPyYylY3PyZBRHAo6DIer5Yb0gzXkfUIJN+X9KQLyxLc+Z+7bOjZrX
         RewVcd8i9sTYdpBitqx4AN2oia1ekutqXjVQNAGSAmdyJDS4ZlURNG5/syTE86TAiRiZ
         oZjw==
X-Forwarded-Encrypted: i=1; AJvYcCVnu6Sy8fchk9BS/kytKyuh0fxuMQCedQPMJlo/rlej5/fV2DsVFsh8rkW7s9sbHlZeNe7mPdBF@vger.kernel.org, AJvYcCXRCKzV9egQn7OgzQ3wtpmB+j3uqbe/v2XvfrGj6aVZE0Obe0Pr5X+CKZ/0VoJqCYLYgZdlpXbAhsgz2Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBAQA1XhRmSjB0Jc2CkMgnD/5pse2cYAPk7uHFQQhqh8xS90V
	QorxEV4Ib/8hanTvduTNaLmoEPeqqz2phBEBZH3ljwRIHaiQeLwTj51mUOZDQ27Y8HvY8EnwhWn
	jCNoqR6HuiwaXlqmAPFtG9TRoYG4=
X-Google-Smtp-Source: AGHT+IE+92W3Wb5qGWWv0/BNzhYfbYBSNd1bpAERi4JgZtkLOBi8feyRz8JARPymwdvLFiYP5/0AF80SNFmwkpF82h8=
X-Received: by 2002:a05:6122:6113:b0:501:2e0a:ed2a with SMTP id
 71dfb90a1353d-501e77976bemr6205128e0c.0.1725902724367; Mon, 09 Sep 2024
 10:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909064000.1198047-1-make24@iscas.ac.cn>
In-Reply-To: <20240909064000.1198047-1-make24@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 13:25:12 -0400
Message-ID: <CADnq5_Ouci1bvRJh+1mDRxgazvL7C-rgg+BjeGyNT-qa=vHtyQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: Add null check before access
 structs in dcn32_enable_phantom_plane
To: Ma Ke <make24@iscas.ac.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, alvin.lee2@amd.com, wenjing.liu@amd.com, 
	roman.li@amd.com, dillon.varone@amd.com, moadhuri@amd.com, 
	aurabindo.pillai@amd.com, akpm@linux-foundation.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:48=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> In dcn32_enable_phantom_plane, we should better check null pointer before
> accessing various structs.
>
> Cc: stable@vger.kernel.org
> Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for D=
isplay Core")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Thanks for the patch.  This is already fixed in:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/fdd5ecbbff751c3b9061d8e=
bb08e5c96119915b4

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 969658313fd6..1d1b40d22f42 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1650,6 +1650,8 @@ static void dcn32_enable_phantom_plane(struct dc *d=
c,
>                         phantom_plane =3D prev_phantom_plane;
>                 else
>                         phantom_plane =3D dc_state_create_phantom_plane(d=
c, context, curr_pipe->plane_state);
> +               if (!phantom_plane)
> +                       return;
>
>                 memcpy(&phantom_plane->address, &curr_pipe->plane_state->=
address, sizeof(phantom_plane->address));
>                 memcpy(&phantom_plane->scaling_quality, &curr_pipe->plane=
_state->scaling_quality,
> --
> 2.25.1
>

