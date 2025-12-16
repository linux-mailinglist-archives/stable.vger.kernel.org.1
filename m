Return-Path: <stable+bounces-202711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FBCC43D8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E70330A3DFC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157533066B;
	Tue, 16 Dec 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1tYd7FB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040923D7D4
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897749; cv=none; b=QJX1QIrQD3NAQgyf3vAIMd4RithZA9/oPrwthO/VlRCTiSJ/HXXwd7vYhFZX+fNxXKHHBo6zsMbi4LIcoI0d81bMCG/p6/g5q936oG9s2CtMuGhaXzg9n+5FgMfhqIRmCYHm78Fpf63JGMdJrB0EPRhY55Zk7yET74jwidgKj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897749; c=relaxed/simple;
	bh=kaCnNQu10IecAEcgUBVksPSpUHP7s0XUXmn3lqVr7io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEPzeAdwF8jn1E83kkAiJixi/U8nDP0nTSSwhbbDXhy9nwx+6xFZBowBcuFgKw+k6C7+Qs+VhibN/Tt6avEbiG3yGdYc7f9PV9GLHQSVbBK6sVEFvwKRzLB80FJgSl/JDJbtQJE8CFqyRlzMgt2JC6lpmKU7NxVLkOlgTPSj6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1tYd7FB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bceaaed0514so223624a12.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765897747; x=1766502547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBQ+KEKtZFBQW9f8fhCsIZyeGJB9EoLToMD3vA7Aj08=;
        b=G1tYd7FBMOxFBm8q3w6s2/W9w/FfoNLcmR83WHfWqCL5vSCYA1UZys3i0ukf6mpEye
         1CERDPKZs9BT2FTBWCFaxcI1ScTKAZrQbuktxRFBnPaq7XYVXio2bCvyMhAG5T6yowjF
         Tq3Avwstk8ILOjBNI+wCF4jzjShYFEcdS5LgcSzONzMPEemvOMGH9yIwsgKzocMUExO3
         iUa9Hhdfavbv9rYFqOfavaBS+/LmbLinTJHv5NecpznNaTQI4Wd6tEEtXCZdPGddvHuf
         NL4puLchv2BjW4ky35IIOH7i1QlCtQsDUhvCkZWNKfh61BqLAHXaMOP0ygmalgG+U7nN
         JN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897747; x=1766502547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TBQ+KEKtZFBQW9f8fhCsIZyeGJB9EoLToMD3vA7Aj08=;
        b=r1k+JU9KTn/AEpOLGrZS0dud+hLusBjy3vWtLtRwjsILUp2I2tVZ3OFIlNn0VGiC1K
         3U7C2SvGPtrR3lNEI6mNz24k4l6wKz2JxX939DlbOoOV2S+e2HqPosNragfls0ZkyI3e
         gyXLltqOLi1U9Bh+l1AGp0QtHjsLNQsNTzVFal9acIDv2HL/Gs29ZU/aAHUklEbJW9nM
         UmAWCxsOK5wnTW78Ty2WisyTgX8nyplnKfxy9cxQP5boKUVjFAILA+WBG/La7mycXP0O
         qb39+an7GZOg7jHTY+PxrJrLVCTd+5Wmyi+Z2I2sN7++1JG2bHbH91btvYvzRI3XHdy5
         WokA==
X-Forwarded-Encrypted: i=1; AJvYcCUdBRaXYa4DMjOc+3vNRohWq9er4lzq9MI2qGWZkzVSB226jSdARwgu2UE/jsvVk2mz/Le8wv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdx8OmwID1MbOBgeptMGjhB7Im1+oyqiIOo6Y4Afku7izUziVI
	3qGp2mE864aBP6EqlTv+HlloeDVqCyMyp/keQLE+Lbjc7vbtcBPXWKWp8b4AR9xJAZ2lFSMjzoo
	G2nBCAr7ALWaBUry5w6+457gINg6QH9I=
X-Gm-Gg: AY/fxX5HghHWRFjttKVw2IbY647xa/5E/9OMu+N/GGBAvpAVpgYrJKOTGssA4klRm8L
	2rTEMcQtvBezSJF7hc7feaNnXABVvcXltp7V8YUMPzoTt4/4+2Zjxz2+6OloqVb2CUK7WZcy7Ye
	7sYVWgCVZcxbX/1e6Z49nKyOpTQWYzFXqjR+5od2dkHfvUHSWA2w/ptslz+948lakM42GvBk1sl
	ZPwEXkIPoyc14ffuOHMqMAT43uxj3cgy93m7fPtjcL9irCJmNUA5+Opn2Y9eQWXv+mYBkh77d/9
	yv3sjN4=
X-Google-Smtp-Source: AGHT+IE06XFlmMgvXerznAhzoCBIgwCI6cVyUE2Vj6xD/o7J8s5VveIDQEUmJl1xe3ToLTKUn/phA5QKg6FpsbGtWOw=
X-Received: by 2002:a05:7022:fa2:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11f34874285mr6126769c88.0.1765897746571; Tue, 16 Dec 2025
 07:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213-dml-bump-frame-warn-clang-sanitizers-v1-1-0e91608db9eb@kernel.org>
In-Reply-To: <20251213-dml-bump-frame-warn-clang-sanitizers-v1-1-0e91608db9eb@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:08:55 -0500
X-Gm-Features: AQt7F2qcbLgX7_41oZokd-Bui00GaFx0PuQiAfWWLBHHuXsoZHZJuKEIq9MvOX0
Message-ID: <CADnq5_OHj3Vz1uVKer8AKH+h3jthM=FE+hCJ=M=xFox65sxcHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Apply e4479aecf658 to dml
To: Nathan Chancellor <nathan@kernel.org>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sat, Dec 13, 2025 at 1:16=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> After an innocuous optimization change in clang-22, allmodconfig (which
> enables CONFIG_KASAN and CONFIG_WERROR) breaks with:
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c:1724:6: error: stack frame size (3144) exceeds limit (3072) in 'dml32_Mod=
eSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    1724 | void dml32_ModeSupportAndSystemConfigurationFull(struct display=
_mode_lib *mode_lib)
>         |      ^
>
> With clang-21, this function was already pretty close to the existing
> limit of 3072 bytes.
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c:1724:6: error: stack frame size (2904) exceeds limit (2048) in 'dml32_Mod=
eSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    1724 | void dml32_ModeSupportAndSystemConfigurationFull(struct display=
_mode_lib *mode_lib)
>         |      ^
>
> A similar situation occurred in dml2, which was resolved by
> commit e4479aecf658 ("drm/amd/display: Increase sanitizer frame larger
> than limit when compile testing with clang") by increasing the limit for
> clang when compile testing with certain sanitizer enabled, so that
> allmodconfig (an easy testing target) continues to work.
>
> Apply that same change to the dml folder to clear up the warning for
> allmodconfig, unbreaking the build.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2135
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/dr=
m/amd/display/dc/dml/Makefile
> index b357683b4255..268b5fbdb48b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -30,7 +30,11 @@ dml_rcflags :=3D $(CC_FLAGS_NO_FPU)
>
>  ifneq ($(CONFIG_FRAME_WARN),0)
>      ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> -        frame_warn_limit :=3D 3072
> +        ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
> +            frame_warn_limit :=3D 4096
> +        else
> +            frame_warn_limit :=3D 3072
> +        endif
>      else
>          frame_warn_limit :=3D 2048
>      endif
>
> ---
> base-commit: f24e96d69f5b9eb0f3b9c49e53c385c50729edfd
> change-id: 20251213-dml-bump-frame-warn-clang-sanitizers-0a34fc916aec
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

