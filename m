Return-Path: <stable+bounces-18993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FCD84B83A
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 15:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DB428CA5C
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6013249F;
	Tue,  6 Feb 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxu5V1ru"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66C12FF97
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230694; cv=none; b=kldt1dBVt3/xmQT2jFKtpEFUaovl0bnAUOoY9opKAGQXuH3uusjUxbMR+YToLVRVJId50gLocMEiUO+70+OMV0vAUm+qyox5WlCpb4L4/IBTF4NYbZnonInxqcj4Ub/+UwvnoKVKfNS+r37CCStcIHYvNQq8kclREon85RXyBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230694; c=relaxed/simple;
	bh=kLzvA/GRNTVv1kRX2H3c4v6G8uj/+CXni/hGUK053Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ+OJKSfu+qUk+JcR3nzk7vgsGIj1at0RjeMpoQUxK06ufVLW26DzJWM67hnqLd7i0hE/Q42jrZhKmQKaZt9Ct6L7ac7UM63kLOfmchxguh14ed+8igyG+mj+f1dYFSDhsnBtrl3NjiKhbX9RlUwl2P1E67r6pV0jA+xr9bNXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxu5V1ru; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a94c0fb55so2940674eaf.0
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707230692; x=1707835492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+20KhE5CzGghzyw+yh5TsIxVW9/ObxNGsBkKGzjlNGA=;
        b=Kxu5V1ruTMs11UWDvFzZoMSdd6y6RRINUrmJEKIE+XwzRPVh8nVdaj76pUDOpfyxg5
         HLlugSXKBQVG17lq5l6NGZTuH6tTOSaZ3qPsI7ERSDoIPeBf+ra5uIw4cWxyad9Mp+sB
         Kbd60hPli02sWtzwepzyZRzVYif0imrOrdYADhG2m6cGnIZ2nIdG6xZQGVgsrPPJUa7/
         nmNgC8b1BBWvoI3nWjowywW0BBs7N1kn+nf86GNily7INo69Gl19vE5rT2j0iYf1F2Xc
         lfMwn1dWnzpn7IL2yyaIxJN5+KDprrER4B1EIs9bJH26gMas1SkRVmclu9nELTiqmO/n
         lcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230692; x=1707835492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+20KhE5CzGghzyw+yh5TsIxVW9/ObxNGsBkKGzjlNGA=;
        b=GKDdgDdwJVPeNcoXjrMNep3vj2AU4PdF1m7pXqfbccratpqkgKjrNBZ5oGBXTh/QZ2
         tssfuIr283tV6W5VF3e0AVUr2TyM1QpuQYF5U3soiwBeJ9OFvDlBLEehokrgV6YmzRc8
         fDCEGqxJ7Ev0STcv4wcCuh0AUCqLp1MNKLFzf9u37rlqfJxqRN29QFWoYYagU38CUs7C
         qkJbzlw8y81F0asZr+BtEwM+EXGj6sujhUlSguqUzxc40vstWDQWjrYqaUPLKppJ3n+S
         c7EQUI6tDSnlO1VfySTJ+smkM0mhsru6Tw+6bxTDnyayb+ne3XhVxNyZS6FOXZlb9i/n
         TRkg==
X-Gm-Message-State: AOJu0Yzvd7MQCyA53MGsWyxCUTCld5A0814SNuLrf8ln17S1H989/oCU
	6ZS1evtIC6OaAFCPHmxa/iyoxLnNVkZNe+ZtHkSYRfNAPW8MRlbob9q5wSt1MrNzO2G19PQ+M2z
	dAkbbr7M/ReoUs9xWlFhIZtBLViiuwFC+
X-Google-Smtp-Source: AGHT+IF0WZWM6Ib5EqucHZaEu5uV8FtMlbuTK8HqLl2KoroGz2pfdLgomL1X+7K8CnT8yIn7ZCEgAcp+W+dbQdJdLrU=
X-Received: by 2002:a05:6870:638c:b0:219:3d70:97b9 with SMTP id
 t12-20020a056870638c00b002193d7097b9mr3072489oap.37.1707230692108; Tue, 06
 Feb 2024 06:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-amdgpu-raise-flt-for-dml-vba-files-v1-1-9bc8c8b98fb4@kernel.org>
In-Reply-To: <20240205-amdgpu-raise-flt-for-dml-vba-files-v1-1-9bc8c8b98fb4@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Feb 2024 09:44:40 -0500
Message-ID: <CADnq5_OZq2s2wcLcMccMuk2Vrk2dzYu9uQdfM3hbzciB_AWbMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Increase frame-larger-than for all
 display_mode_vba files
To: Nathan Chancellor <nathan@kernel.org>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	morbo@google.com, justinstitt@google.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Feb 5, 2024 at 5:08=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> After a recent change in LLVM, allmodconfig (which has CONFIG_KCSAN=3Dy
> and CONFIG_WERROR=3Dy enabled) has a few new instances of
> -Wframe-larger-than for the mode support and system configuration
> functions:
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v=
2.c:3393:6: error: stack frame size (2144) exceeds limit (2048) in 'dml20v2=
_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    3393 | void dml20v2_ModeSupportAndSystemConfigurationFull(struct displ=
ay_mode_lib *mode_lib)
>         |      ^
>   1 error generated.
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.=
c:3520:6: error: stack frame size (2192) exceeds limit (2048) in 'dml21_Mod=
eSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    3520 | void dml21_ModeSupportAndSystemConfigurationFull(struct display=
_mode_lib *mode_lib)
>         |      ^
>   1 error generated.
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.=
c:3286:6: error: stack frame size (2128) exceeds limit (2048) in 'dml20_Mod=
eSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    3286 | void dml20_ModeSupportAndSystemConfigurationFull(struct display=
_mode_lib *mode_lib)
>         |      ^
>   1 error generated.
>
> Without the sanitizers enabled, there are no warnings.
>
> This was the catalyst for commit 6740ec97bcdb ("drm/amd/display:
> Increase frame warning limit with KASAN or KCSAN in dml2") and that same
> change was made to dml in commit 5b750b22530f ("drm/amd/display:
> Increase frame warning limit with KASAN or KCSAN in dml") but the
> frame_warn_flag variable was not applied to all files. Do so now to
> clear up the warnings and make all these files consistent.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issue/1990
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/dr=
m/amd/display/dc/dml/Makefile
> index 6042a5a6a44f..59ade76ffb18 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -72,11 +72,11 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $=
(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o :=3D $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o :=3D $(dml_ccflags)
> -CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=3D $(dml_ccfla=
gs)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=3D $(dml_ccfla=
gs) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o :=3D $(dml_cc=
flags)
> -CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o :=3D $(dml_ccf=
lags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o :=3D $(dml_ccf=
lags) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o :=3D $(dml_=
ccflags)
> -CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o :=3D $(dml_ccfla=
gs)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o :=3D $(dml_ccfla=
gs) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o :=3D $(dml_cc=
flags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o :=3D $(dml_ccfla=
gs) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o :=3D $(dml_cc=
flags)
>
> ---
> base-commit: 6813cdca4ab94a238f8eb0cef3d3f3fcbdfb0ee0
> change-id: 20240205-amdgpu-raise-flt-for-dml-vba-files-ee5b5a9c5e43
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

