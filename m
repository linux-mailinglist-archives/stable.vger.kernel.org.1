Return-Path: <stable+bounces-237623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHBhJnYz3Wl9agkAu9opvQ
	(envelope-from <stable+bounces-237623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:18:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E661B3F1E82
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9EC8302F9BF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02953B7748;
	Mon, 13 Apr 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuYnefdo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41033FE09
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104001; cv=pass; b=ij0loHY4/3nrUnk1xoqnES9PuGVuFQ2moexcjDs8vYqjs6QeX7NXhsXuAtDU+TkErcE8lad6AnFSYpkllrPbklocAKoI/LxsYzbPQcpKaCDCSV3enlp1lIhQMPT57rYs79tD/7PI+yJXg6HqXex4wQWDyQS244u7wn1E4LU3vkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104001; c=relaxed/simple;
	bh=myinR1iyiMOl8lx2G5JLLn4qdu27DmzMWmDWrcaOWbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8ocUJbQCipmu72H1oLwZlQMk/ctKWG6tJzQbG40TzpElcV86GZb/PIPutKuCpFekkVmRu7NBqVZCTjtduvWVxa4Bup6E73vtYCv10/FZLWKyTEzWW+S3bKqaEwIZ/3srEvaf118bu3myaIdMj0RlLsDjnnICKJy+IWop8odssE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuYnefdo; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1277863a912so389562c88.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776104000; cv=none;
        d=google.com; s=arc-20240605;
        b=TfbSpKYVTJ0fuS+dRJ7aKD4Y23BEnNn2FrQdlnP8aAy4I+fGWKZMOMzKFsSdP7YVuW
         v/JOhBeZdhAAKoM4h5u5FroZ2+Bp46NR27fW0H7NTEEGxK/yBu1iF/KY6lshZxFrAdlY
         476BBN2ygL4FrEccfmQGS9ndqcC7PPu2Vo1ZibOx3w6eOi/exe7KklFlcnWmNjFsJmLC
         HRoB22yEjUe1NJF0Fx85l6RzYLlZYJFeP+0hP4RYPWFHzuwuse0ZM6jLodEIw8GYaxfF
         P2V5dDbuX2Vt90v9BYOJ64A5PhoZK/fHX1eo4MxrKnOAEnovhdNTa+/f32NB4XMSpwSJ
         /VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vVVKoC6M8szpkspBmPFev5bUvMCnmAWZCFxFeRDtvro=;
        fh=08505bHhoQdg9zrw8Mr/hfE2hbXDU8rD7CKTgy1+8S4=;
        b=Qmjcq6eyR+9qcT1Z+dOEPQrGwnqnHm24G+2b9vNcmkX/xsIFuq4s8zKGR25WVdlhFt
         FYlPSghfyit31GRGFs6vdaXsEOCrbLwgFInULa53wvdZMllGUM+73aDTvowZphz/RehK
         Jnnrpfib8FledRDbWqh3Sj5oiAnKOKd8kYKoU+2upsQHICYon5jhauhA8ytInzBFAXXO
         pb/Jk4sTAfq7Iil7MX/O5kGi8LMLCjHsClaRsKvp7QSt8FtgcXx+cDId4Gpi0y/UZ99I
         XF5c6Fyzvb+4laCcxN0pkVlmHFY7HArITXgn9xMnyHuuSbc0t5WIoBtxFTk9riAgcNvG
         gY8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104000; x=1776708800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVVKoC6M8szpkspBmPFev5bUvMCnmAWZCFxFeRDtvro=;
        b=PuYnefdo4aKmMuKSK/NKJ5HXk5abzsRB4qQxlonN8P2LtqjRssIG1jcRmME3xcDpR4
         FMtAZRZfH9jUtxqW+osF/ARRE7osxYFtdTX8m/q+6vPRC6OE+1peWlGDlyeuSW/vR7u+
         ylx9Rznw4+r5X96f4ZTef4uJ1Z1coSmmw3Hf4nZJbgruTVSw/0c2EUIlMXbw4+auRPhv
         S2NruTVcFLjVsGJUbJba31o2jB6D6hxVEelaXx/zylU4hknPiQFlPberLbn9gVAkyVro
         g5+BuyXd42S5sWcnlh+SAmiVsxLKweYE8AMykPEzCHa9+xc1OHrVaypOMAj3NfLYLE2g
         K5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104000; x=1776708800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVVKoC6M8szpkspBmPFev5bUvMCnmAWZCFxFeRDtvro=;
        b=PEbThCOZSjtZsjIRTLUuhrrQcHsH1Z3hhTqtG7EEOicVFG/ubQSdpFbWNYQvXeFo6V
         LBGjh9A2M5toNqguU1YkRFKvR/TJjtAz09PqW+8KjUWtIf8ad9z21ZU6NTOiz08H9MA/
         llGnSzoCQpYHLAP7lhAMfLOwVAUziYsNH336ah/eLHOIy+COtogiEummNT1+g47Jw3d1
         QQ29lxfhCFyOSq2LrjHr+NrLaRlrFNJ7VfxorpHxu0IY6vpj65f055Vci2wYPYYroXiT
         ovIwCEbYUIgZGo5j+KKVidlO3dfOCSW31XkvORyK4wpd2Rd2LVNf3ydBQZRUXC5OuRs+
         27Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+hVVSi9k273BDPJAFCSQfauosPQmoSr16KcJmLzNncoLzXqgOoH7PhKVs4vp1fuFuzqA6RKB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05UcFXUUiPDY/LO+kk8ZkPA9URhNGFga7/9lq1XdAFnrzhSRd
	YO3EeEaT7A2jobQFR6qtUG9qvd00egY3e+/DlzS8arx6YSemUN17ux06T3iaGKxLJrWXX8AfXa9
	HfpAKJ3VOEbrxM4A4aqyNTeyobnntT+I=
X-Gm-Gg: AeBDiesCyIlEZyG75oyFRBiQx1gLUlYFGkbDZUG7NJk5L2D1JqtbtRl9eAX4bZfhftk
	nC6VCREoXhUrFGrnb2Jan1qXtrRQMZLC9QAOhguvcq+obZGhZHKyp2mwPvllnXMocL6UQRc4xZp
	0XbGfMx/024K/zshsdyHIS7SPZILzSzXOZJ47IYUr7ibNQPVmRMGR7SIA1Us079zm4oDcJzwbjy
	lhF9bxoZgf2RTKnO+AD52rAl9J92KGKYb32JIvxM0BgFTay0KGVuWCumIYhpl9CRMbG59OIsMTP
	XfY+eZpPHoWhh6CGfsmFnxP6VMcOvWtaGGdV5QhOZ39e4OhAd1OdKKprV1GCzi+O96XclA==
X-Received: by 2002:a05:7022:672b:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12c34dbed15mr3119305c88.0.1776103999545; Mon, 13 Apr 2026
 11:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406225008.2787532-1-werner@verivus.com> <20260406225008.2787532-2-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-2-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 14:13:06 -0400
X-Gm-Features: AQROBzAVudQT9b1KEMIQwaqVTOGdwq-wFQfJObhPf6ovAb3esDyy6cLWlE6yctQ
Message-ID: <CADnq5_PUEMT4n3ZpBuZH0A5QRZdwLjXAGCAnc6nM6CW5td8LmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix integer overflow in amdgpu_gem_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,suse.de,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,verivus.com:email,verivus.ai:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E661B3F1E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 3:41=E2=80=AFAM Werner Kasselman <werner@verivus.ai>=
 wrote:
>
> amdgpu_gem_align_pitch() uses signed int for the pitch calculation.

Can you convert amdgpu_gem_align_pitch() to use unsigned ints?  The
width passed to it is always unsigned.  That would simplify things.

Alex

> When alignment rounding pushes the width to a boundary value (e.g.,
> 2^30 for cpp=3D4), the multiplication 'aligned * cpp' overflows signed
> 32-bit int, producing 0 or a negative value.
>
> The overflow guard in drm_mode_create_dumb() validates width * cpp
> BEFORE the driver callback, but amdgpu_mode_dumb_create() bypasses the
> generic drm_mode_size_dumb() helper and performs its own alignment
> rounding, which can push the pitch past the pre-validated range.
>
> A zero pitch propagates to a zero-size GEM object allocation via
> amdgpu_gem_object_create(). The 0-byte BO passes
> amdgpu_bo_validate_size() (since 0 < man->size) and is returned to
> userspace with a valid handle. This object can then be mmap'd or
> referenced in GPU command submissions, potentially causing out-of-bounds
> access to adjacent slab memory.
>
> DRM_IOCTL_MODE_CREATE_DUMB requires no DRM authentication, so any local
> user with access to /dev/dri/renderD* can trigger this with e.g.
> width=3D1073741760, bpp=3D32, height=3D1.
>
> Add an overflow check in amdgpu_gem_align_pitch() to detect when
> 'aligned * cpp' would exceed INT_MAX, returning 0 in that case. Add
> corresponding checks in amdgpu_mode_dumb_create() to reject pitch=3D0
> and size=3D0 with -EINVAL.
>
> The proper long-term fix is to convert amdgpu to use
> drm_mode_size_dumb() which centralizes pitch/size calculation with
> proper overflow guards, as is being done for other drivers in Thomas
> Zimmermann's dumb-buffer series.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setti=
ng up AMD own's.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index a6107109a2b8..b4341abba20c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1246,6 +1246,15 @@ static int amdgpu_gem_align_pitch(struct amdgpu_de=
vice *adev,
>
>         aligned +=3D pitch_mask;
>         aligned &=3D ~pitch_mask;
> +
> +       /* Sanity check to avoid integer overflow in aligned * cpp.
> +        * The caller (drm_mode_create_dumb) validates width * cpp fits
> +        * in u32 before alignment, but rounding up can push aligned
> +        * past INT_MAX / cpp, causing signed overflow to 0 or negative.
> +        */
> +       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +               return 0;
> +
>         return aligned * cpp;
>  }
>
> @@ -1273,8 +1282,12 @@ int amdgpu_mode_dumb_create(struct drm_file *file_=
priv,
>
>         args->pitch =3D amdgpu_gem_align_pitch(adev, args->width,
>                                              DIV_ROUND_UP(args->bpp, 8), =
0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>         domain =3D amdgpu_bo_get_preferred_domain(adev,
>                                 amdgpu_display_supported_domains(adev, fl=
ags));
>         r =3D amdgpu_gem_object_create(adev, args->size, 0, domain, flags=
,
> --
> 2.43.0
>

