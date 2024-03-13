Return-Path: <stable+bounces-28072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBD87B16B
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770B0B2516D
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA90145347;
	Wed, 13 Mar 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cgu9VBYv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CA145333
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352634; cv=none; b=WkVH9R5BkkB3UvElRskK22ruXMk1mYAI6GwMs2oiTSYsvJsRboQ6mbeb5gRrbtDuPPz0Aq3WSBKDkw5FBrVare4ZDCQZD5h17HVeDUOY+9Yvn4dPGaZGxmMaeDBMle0w/zFGCiyIOuJcwYXmai5Ako+rsnFcEcRZ7osoTyHJhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352634; c=relaxed/simple;
	bh=X5Teg34/eXS0zy2mWZ0Lp6OfEpgyOrMI7KhAZFh0xno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJGagEkyLzY4a1fnhJeHSSfCD6HE0iVC5NdCPGXxF4PKtu+Xnui5t8EQYs0qGCvt11wdCW9lHjyUCSD7Ih0WWWHBzLdD1Ca+G9YU+64RlIFhZuEiehLbjAen5a+VNIs63wHwKwf6W9NbNjqd6nKNkit7KIHg8vVZM/jKp+HuvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cgu9VBYv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd161eb03afso22458276.0
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710352632; x=1710957432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01bhDM3sgbMCVy0wA7pMlXqjUXnnMg0Fx0xhubvbwtM=;
        b=Cgu9VBYvHqO8SEFi3GX4KLLET+ntfUPaPikYlf6iQ4EKshrtfVnU0hbc+WiB5n6jom
         SaeBgUQFEJ/ZvSgrSmWOEX2hfVH7lv/3UDTtwk2re0KufaabEMzgYH0Nkks3k3M4AHRn
         TYIJZLr1Mr7WSfyqCfxwruPmdlAytbAkLI/t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352632; x=1710957432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01bhDM3sgbMCVy0wA7pMlXqjUXnnMg0Fx0xhubvbwtM=;
        b=g9W7oxFOMnOQj9MTN+XVcl8i+QdcZLbMQSz75KLlL8Lvikl5CAFpstsw/4uyIN0xny
         9rVKV1TqTuRRqRwnrBFiUtGe/lvqaBKuZt4PU+fhzEbW13MEngSTRVUwD42yKyLFuN4+
         3aaiHxdXrv+fP48LWVtpgMw8yEPBpRLaQu9rnYrux8MucD2hXLlMX0P3/FUwGaOhtEt8
         WbSJ8RmjlxZbSl+5BgcNwrgNnfxzTFfF5cSfbGiHkcuDB1Fe9qFYfxBHlr8T1GZsmohq
         SQ3oLAcRrjpSYy3WwJILtAoQhc879te7SeqCGKwGxyYl0NRlToyjbfl2uUMTtfIacT2W
         zRow==
X-Forwarded-Encrypted: i=1; AJvYcCXNuNuZOq8C+Ttn7hJaWgNbivnVObiwy24EUi91cln4Ze7TAnFnnfwHq6OAadfRbzu8yWTYqbkJ8GKUv3JcyzIA5xFx455Z
X-Gm-Message-State: AOJu0YxkNr0k3lGK2zBZudGp2sAW1FMfBFPqviDO2wIKaQMORmkTj4FT
	WM6e6CTOzOXshIM954ziG7iR7DOh9AsKeXa7YIq/qjutPR6uh8F+ii+rLsWd4FLeTGb2CoqGEtM
	U1XlNDemP3z7eAU+wtsUQNNGeiTCetworjQE3
X-Google-Smtp-Source: AGHT+IEkAZO78oDndyJfmxsMlcdlD0RuRua6PWTKx+M6sfIsCscvGyELnd8QyAHN/7Zx/pEiL7sgBzbEQQX3YUR74R0=
X-Received: by 2002:a5b:a:0:b0:dcd:2d3a:b528 with SMTP id a10-20020a5b000a000000b00dcd2d3ab528mr2867472ybp.9.1710352631869;
 Wed, 13 Mar 2024 10:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312093551.196609-1-jfalempe@redhat.com>
In-Reply-To: <20240312093551.196609-1-jfalempe@redhat.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 13 Mar 2024 13:57:01 -0400
Message-ID: <CABQX2QN729DjtdOzAS9jeEP_xHXT4zNaOcP59pa-KyXnME=xaw@mail.gmail.com>
Subject: Re: [PATCH] vmwgfx: Create debugfs ttm_resource_manager entry only if needed
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	tzimmermann@suse.de, airlied@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, daniel@ffwll.ch, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:36=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> The driver creates /sys/kernel/debug/dri/0/mob_ttm even when the
> corresponding ttm_resource_manager is not allocated.
> This leads to a crash when trying to read from this file.
>
> Add a check to create mob_ttm, system_mob_ttm, and gmr_ttm debug file
> only when the corresponding ttm_resource_manager is allocated.
>
> crash> bt
> PID: 3133409  TASK: ffff8fe4834a5000  CPU: 3    COMMAND: "grep"
>  #0 [ffffb954506b3b20] machine_kexec at ffffffffb2a6bec3
>  #1 [ffffb954506b3b78] __crash_kexec at ffffffffb2bb598a
>  #2 [ffffb954506b3c38] crash_kexec at ffffffffb2bb68c1
>  #3 [ffffb954506b3c50] oops_end at ffffffffb2a2a9b1
>  #4 [ffffb954506b3c70] no_context at ffffffffb2a7e913
>  #5 [ffffb954506b3cc8] __bad_area_nosemaphore at ffffffffb2a7ec8c
>  #6 [ffffb954506b3d10] do_page_fault at ffffffffb2a7f887
>  #7 [ffffb954506b3d40] page_fault at ffffffffb360116e
>     [exception RIP: ttm_resource_manager_debug+0x11]
>     RIP: ffffffffc04afd11  RSP: ffffb954506b3df0  RFLAGS: 00010246
>     RAX: ffff8fe41a6d1200  RBX: 0000000000000000  RCX: 0000000000000940
>     RDX: 0000000000000000  RSI: ffffffffc04b4338  RDI: 0000000000000000
>     RBP: ffffb954506b3e08   R8: ffff8fee3ffad000   R9: 0000000000000000
>     R10: ffff8fe41a76a000  R11: 0000000000000001  R12: 00000000ffffffff
>     R13: 0000000000000001  R14: ffff8fe5bb6f3900  R15: ffff8fe41a6d1200
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffb954506b3e00] ttm_resource_manager_show at ffffffffc04afde7 [ttm=
]
>  #9 [ffffb954506b3e30] seq_read at ffffffffb2d8f9f3
>     RIP: 00007f4c4eda8985  RSP: 00007ffdbba9e9f8  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 000000000037e000  RCX: 00007f4c4eda8985
>     RDX: 000000000037e000  RSI: 00007f4c41573000  RDI: 0000000000000003
>     RBP: 000000000037e000   R8: 0000000000000000   R9: 000000000037fe30
>     R10: 0000000000000000  R11: 0000000000000246  R12: 00007f4c41573000
>     R13: 0000000000000003  R14: 00007f4c41572010  R15: 0000000000000003
>     ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> Fixes: af4a25bbe5e7 ("drm/vmwgfx: Add debugfs entries for various ttm res=
ource managers")
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index d3e308fdfd5b..c7d90f96d16a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1444,12 +1444,15 @@ static void vmw_debugfs_resource_managers_init(st=
ruct vmw_private *vmw)
>                                             root, "system_ttm");
>         ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, =
TTM_PL_VRAM),
>                                             root, "vram_ttm");
> -       ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, =
VMW_PL_GMR),
> -                                           root, "gmr_ttm");
> -       ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, =
VMW_PL_MOB),
> -                                           root, "mob_ttm");
> -       ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, =
VMW_PL_SYSTEM),
> -                                           root, "system_mob_ttm");
> +       if (vmw->has_gmr)
> +               ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw=
->bdev, VMW_PL_GMR),
> +                                                   root, "gmr_ttm");
> +       if (vmw->has_mob) {
> +               ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw=
->bdev, VMW_PL_MOB),
> +                                                   root, "mob_ttm");
> +               ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw=
->bdev, VMW_PL_SYSTEM),
> +                                                   root, "system_mob_ttm=
");
> +       }
>  }
>
>  static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long v=
al,
>
> base-commit: b33651a5c98dbd5a919219d8c129d0674ef74299
> --
> 2.44.0
>

Thanks! That looks great. I can push it through drm-misc-fixes.

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

