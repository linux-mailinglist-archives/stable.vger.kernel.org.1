Return-Path: <stable+bounces-179719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A943EB5971D
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 15:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE01882824
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC11581EE;
	Tue, 16 Sep 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwFrFYdx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F31A9F86
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028311; cv=none; b=j+/bAd5Py5K9n35vlADFwyULF8DlDHYkpzewBzibufso0tjmOcQyIw8O5xSMZTXc37EeBAENvL8wJ/XzR/o0dc9L2iqy5a9nUKBudS0u7b24Ac2UxEV7uCro6o9PSq82pEMFV9XkZy+To3gbGXL0LuDJ2DZduwbFRI6nXgQKpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028311; c=relaxed/simple;
	bh=vP05yFoeLTRzL//60PLlbZGWz0gmuy48tWvS2dAN1C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+5Rc5Zp+pBWJygnu/4l+58o8UmNDq4vWnZShyZ+JCVD43Cd5Q4+WvHytzzbZ4AvBQF7ZkCHRh4iaLLNj0YA6MtzdNBAs2e1ILis7uPETjEdAzhxVkaglTYMexEBvH1VRATlPd6r+kvg2fnq3eWfzRap6L/J3AkPVNloQ9jK+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwFrFYdx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2618a7299faso6093975ad.2
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758028309; x=1758633109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZQGWLMYS20RM2PHRcKIUdzG/sbIcO56YCQjlhrSFJ0=;
        b=PwFrFYdxFQhHnzPnyXzJUDjBmQ1YtVIbwZkgJ169wMn9tRKnUd6ajkPtqFaoVJwP+J
         5eaWrKwzDf98QMh6RsM4rFcoChOdff8JNiuZvqiJrumoQyByDOyh4qShncsz2vxSLxMI
         /5SQjb0R6lKE8xYIXEHWe5EAr5j7RVQVMWhCwODw3607uaAeENvGR6SzYIlinTCrq0pA
         xxsKflQrdGuy4cYNQIKUyvPqPdTsbp24K/h+kLiw92Nkpfukr+JfHAICRN0KI4aVJq6t
         ESeD1F5gImDxIdae9Oq6FYJ/q6R+Qh9vpgOCv+YqIiIuPc55QremgAfIbsWzt3rS+cqu
         dWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028309; x=1758633109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZQGWLMYS20RM2PHRcKIUdzG/sbIcO56YCQjlhrSFJ0=;
        b=h6Y/kIHUF2ht07sYqi7hjH6hMyM5VFkGHjphq0O8V4XMDlyTGxN0shPp8Qt+dSTtyu
         DH21NTAPMCBXHHyRgyPgkQ2C3ccQMq3VxvvVNYx3hkd5mrzuIcphskuqxyksLMA9cUx2
         oa7TwX6ikrv6i73OtR+O7hVGs7kD1J4ErNoZJRtDk57j4l6VDIuUzWQZ2vntNVBZZql1
         HuZq4nClabNRzKGQOmjQGX2jwf9oPgU5+5x1aCDrpE604k80+puCpuJaMyfJqFuOW9+a
         2nroplNVbhMuGTtTvIl1xVB+cHbyieLpTkyAAT5Sao4VE7IZ8TRVmE2uEuS/iFG3o0Mr
         5UFw==
X-Forwarded-Encrypted: i=1; AJvYcCXj1IfvQdmDsHTsQ3JRg5ck7P+5ekpdyLwCDhGxVuKLnHJSO7w98/RigXhViKJAikzIOImcoj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9tvqOJDhHGcD0RfHs7QKuVlnmwigcZLP1U4mIjKdweYUSL6F
	kMRvpAa06dFSoKW+TDbvMqT92ptLN0pFKESqs0dTo4bmRytfLtFXAIgAmFXr3oHxmyjhSGb3oPR
	IIgEPGU/ldy+mVtno2ctAcITZ5dc9XLA=
X-Gm-Gg: ASbGncvrp8gXKkOUG9Vx300fFGe/0Q34jLU0iFGxr9ucW4Z7WaLXg5YYrhdC1dRAAai
	KW96eTPlW1m5r1o02FkwEdDK28cUkewFSKIK8WGnHrHlFK3jjGaoRPqfJOpEG+Mw/54UI98n2N+
	Ki3XnFm5nxu8HpZLHY4SbRB2ddFwkf83D3VGiHuJmjkNXPR9v3iu65/h80VxvysMtU9INOcciO/
	BXFo80=
X-Google-Smtp-Source: AGHT+IHdBX+BDCzs72mqFiTaPcuHGQueiRO+jKRRLYirXl9AXm5yXijcUbkgPTo7POT8AC9lyHyKpRnsayPUaVFJHnc=
X-Received: by 2002:a17:903:ac5:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-25d27c1df3cmr106987245ad.6.1758028308742; Tue, 16 Sep 2025
 06:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916015902.77242-1-mario.limonciello@amd.com>
In-Reply-To: <20250916015902.77242-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Sep 2025 09:11:35 -0400
X-Gm-Features: AS18NWBHylpMVcq-hRpBq7PC5b0sPBeEzYLb6jrJrCkWt5NgsGld7AXBRsGzCGU
Message-ID: <CADnq5_PqbmO9JpzuG-Ry1Mw53Db62-wHJMLjKqy6Dnd47KMofw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Only restore cached manual clock settings in
 restore if OD enabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsO0bWUgTMOpY3V5ZXI=?= <jerome.4a4c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:39=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If OD is not enabled then restoring cached clock settings doesn't make
> sense and actually leads to errors in resume.
>
> Check if enabled before restoring settings.
>
> Fixes: 796ff8a7e01bd ("drm/amd: Restore cached manual clock settings duri=
ng resume")
> Cc: stable@vger.kernel.org
> Reported-by: J=C3=A9r=C3=B4me L=C3=A9cuyer <jerome.4a4c@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/0ffe2692-7bfa-4821-856e-dd0f18e2c=
32b@amd.com/T/#me6db8ddb192626360c462b7570ed7eba0c6c9733
> Suggested-by: J=C3=A9r=C3=B4me L=C3=A9cuyer <jerome.4a4c@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index bf2b38dd7e25..fb8086859857 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2263,7 +2263,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_bl=
ock)
>                         return ret;
>         }
>
> -       if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
> +       if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL && =
smu->od_enabled) {
>                 ret =3D smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE=
, NULL, 0);
>                 if (ret)
>                         return ret;
> --
> 2.49.0
>

