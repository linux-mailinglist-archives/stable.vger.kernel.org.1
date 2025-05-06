Return-Path: <stable+bounces-141832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF16AAC8FE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176457B211A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E0283158;
	Tue,  6 May 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANSI84vE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EC198A08;
	Tue,  6 May 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543672; cv=none; b=s/vsclcmLqKckiAp1eILwVT6E7DYk5alVJVDiWtLfbcNX9jXslR44pfMrRmIFVtbeQe96DMbR0bYjlLoIsgytfYXYnpE4ZIlqnO6erUa9pUmItr7HrEYUObtRVbTA/tJb8alO/DX9+knkOrHzuXmisMN5hcgW0J9ORrWajMU6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543672; c=relaxed/simple;
	bh=cIhzrche21SSHcHQtDiGUHmnbrguz1Vy9Llj2ZQxSec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7664ffmvTcZ/mjIjW74Mig9r9pTXrwSU0svXRmlD4O1rsAhoBfeXGPVegi8YYjVUuRgsJbq4OO4r47pJbQBWqxh4T8K6/OLf6E5q33d47CsexNMg8rhfu6+uQj0kryE6vVXiaDnn7zRuPTSQsbq+5W4eCk/OCIzu+VIqU0rRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANSI84vE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b078bb16607so485992a12.2;
        Tue, 06 May 2025 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543670; x=1747148470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mOdQp0wsCHU79iCTDRAUvjMOiTe90lfOsmNG4A4mz4=;
        b=ANSI84vEDfU+fiBnSFgLAee2TUaHp16/kYRVZ6Oti4Xv1DBVukRXT+ZYPWNQsEf4pv
         cxHkxWn3ZFirwZszCwW2YP0jIQ+HfmT5WfTtHnFDtYK2eErCgxqF+94nq+b6Yzam9T3N
         wHSKKc3h//8EuaPb2x4YPBdseR3gAf1U9v0ONasDcHgvkXDWJgrHFvzEUoaV4qVbZLlZ
         6Bo2IcqgUD9ZgCD5tgKIR+TkzztMB6Ge8jf3gccgRatXBJqU5bDflUOivw+JcyJvKAZs
         8q4DCxGTaR/N9lcvpxQj4o1kbzIlmbwnKmAgkFqWXypU0DrV5h6x5LQi4V7/e9OjnlRM
         qTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543670; x=1747148470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mOdQp0wsCHU79iCTDRAUvjMOiTe90lfOsmNG4A4mz4=;
        b=IRczvaaYfWkoVJodDiJm+h9ZUwEcx7QsyBZEVnlVjBcBCJo1PYoFkpjco7OFzTLFy8
         Bfao2KvY4VV85rh8k1cGQrMAgou+dYmvy835wnZuauc2YskaTNPMOT7Lqb9IABPrA97P
         bHPUVAqtWcMABKdug70wg/jQHEZV1GB/vE0J8vPQme+lJLw+3j8hvOSi/9K9p+OGc/gL
         rYetcAmtUbcJ1tmce2RX4UsFYXCoZkXzeeWLxCUo3Rjx86kC33DKq7VjtzKZKosZ7CqI
         oosVtn3NAndSt8YsNfado4wybXHnXI9fqzuDW73nYLDX3xJcR2aPciPne2kDuwj45wqX
         FBZg==
X-Forwarded-Encrypted: i=1; AJvYcCUHVi9cVDO6vrBL4sFnL6XdW6zCmbOn7mRG5+T1vzZmaEqjOKpyj4RSeFd4N64FOAuOGp9FkH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3a/GXLIxWMvTLimiaREDEQ2R+NHZUP76m11xNnPK/Bhxz9fb
	lghtXqmmbp1ZhCmG3evV/eFNQnRxpAmZxCRXVIlbAXOW8Ho9kcKUv53vkRD+s1rDVQBHcqbwyJu
	ssGHSkTdSliqK5Q5mVAoDj9zr7tA=
X-Gm-Gg: ASbGncuUkn85Rkrcc+bVI+ed6UJklT0K9LQd4EvHZMLhH6GRYvCdMGP9n2u9lElzyQk
	YR4LNPGhm4cqvj5BV/PdLdOmVjQKifP377IRccHK7aKPJelT9O/1M93H6NlnD/DV+KmM3evvPob
	gz3Nq67+UkpFAEQE38GJOZag==
X-Google-Smtp-Source: AGHT+IFVzRQ9UHQ5cn2Pxm1YIqwU9Dn3xpyopqomdm4pOWuYp9SjbtmmdN+nT7CoJWYPnkxPUGfHaPfCYdcX8LUAgv0=
X-Received: by 2002:a17:90b:3006:b0:30a:80bc:ad5 with SMTP id
 98e67ed59e1d1-30a80bc0ba4mr1160943a91.3.1746543670240; Tue, 06 May 2025
 08:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505231320.2695319-1-sashal@kernel.org> <20250505231320.2695319-90-sashal@kernel.org>
In-Reply-To: <20250505231320.2695319-90-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 11:00:58 -0400
X-Gm-Features: ATxdqUGnQpDdB6_AHelJ7NBXUmErUFKTDHQ2k01aYe9xnBMqKDQqW4AzW3PlTMY
Message-ID: <CADnq5_NhYbp2SMivbG2pvB8oZNie5LBxS_ME5nMofX-2syQHrw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 090/153] drm/amd/display: fix dcn4x init failed
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>, 
	Zaeem Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com, sunpeng.li@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	hamzamahfooz@linux.microsoft.com, Daniel.Sa@amd.com, alex.hung@amd.com, 
	rostrows@amd.com, Wayne.Lin@amd.com, Syed.Hassan@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 7:16=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Charlene Liu <Charlene.Liu@amd.com>
>
> [ Upstream commit 23ef388a84c72b0614a6c10f866ffeac7e807719 ]
>
> [why]
> failed due to cmdtable not created.
> switch atombios cmdtable as default.
>
> Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
> Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Support for DCN 4 was added in 6.11 I think so there is no need to
backport DCN 4.x fixes to kernels older than 6.11.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table2.c     | 9 ---------
>  .../gpu/drm/amd/display/dc/bios/command_table_helper2.c  | 3 +--
>  2 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drive=
rs/gpu/drm/amd/display/dc/bios/command_table2.c
> index f1f672a997d7d..d822cc948bdf2 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -103,7 +103,6 @@ static void init_dig_encoder_control(struct bios_pars=
er *bp)
>                 bp->cmd_tbl.dig_encoder_control =3D encoder_control_digx_=
v1_5;
>                 break;
>         default:
> -               dm_output_to_console("Don't have dig_encoder_control for =
v%d\n", version);
>                 bp->cmd_tbl.dig_encoder_control =3D encoder_control_fallb=
ack;
>                 break;
>         }
> @@ -241,7 +240,6 @@ static void init_transmitter_control(struct bios_pars=
er *bp)
>                 bp->cmd_tbl.transmitter_control =3D transmitter_control_v=
1_7;
>                 break;
>         default:
> -               dm_output_to_console("Don't have transmitter_control for =
v%d\n", crev);
>                 bp->cmd_tbl.transmitter_control =3D transmitter_control_f=
allback;
>                 break;
>         }
> @@ -409,8 +407,6 @@ static void init_set_pixel_clock(struct bios_parser *=
bp)
>                 bp->cmd_tbl.set_pixel_clock =3D set_pixel_clock_v7;
>                 break;
>         default:
> -               dm_output_to_console("Don't have set_pixel_clock for v%d\=
n",
> -                        BIOS_CMD_TABLE_PARA_REVISION(setpixelclock));
>                 bp->cmd_tbl.set_pixel_clock =3D set_pixel_clock_fallback;
>                 break;
>         }
> @@ -557,7 +553,6 @@ static void init_set_crtc_timing(struct bios_parser *=
bp)
>                         set_crtc_using_dtd_timing_v3;
>                 break;
>         default:
> -               dm_output_to_console("Don't have set_crtc_timing for v%d\=
n", dtd_version);
>                 bp->cmd_tbl.set_crtc_timing =3D NULL;
>                 break;
>         }
> @@ -674,8 +669,6 @@ static void init_enable_crtc(struct bios_parser *bp)
>                 bp->cmd_tbl.enable_crtc =3D enable_crtc_v1;
>                 break;
>         default:
> -               dm_output_to_console("Don't have enable_crtc for v%d\n",
> -                        BIOS_CMD_TABLE_PARA_REVISION(enablecrtc));
>                 bp->cmd_tbl.enable_crtc =3D NULL;
>                 break;
>         }
> @@ -869,8 +862,6 @@ static void init_set_dce_clock(struct bios_parser *bp=
)
>                 bp->cmd_tbl.set_dce_clock =3D set_dce_clock_v2_1;
>                 break;
>         default:
> -               dm_output_to_console("Don't have set_dce_clock for v%d\n"=
,
> -                        BIOS_CMD_TABLE_PARA_REVISION(setdceclock));
>                 bp->cmd_tbl.set_dce_clock =3D NULL;
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c =
b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index cb3fd44cb1edf..e0231660f69da 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -79,8 +79,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
>                 return true;
>  #endif
>         default:
> -               /* Unsupported DCE */
> -               BREAK_TO_DEBUGGER();
> +               *h =3D dal_cmd_tbl_helper_dce112_get_table2();
>                 return false;
>         }
>  }
> --
> 2.39.5
>

