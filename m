Return-Path: <stable+bounces-238492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DA5IDM34mm13QAAu9opvQ
	(envelope-from <stable+bounces-238492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85441BB6E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4DBB3002F48
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B232397E91;
	Fri, 17 Apr 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOuhzwtF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A43A3831
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432898; cv=pass; b=QyCziDVq0W09cZMOS5713G/OA7gkBcKYQYE13zvYremUCDWNfKELz4wsJXQ8oCS6kYpyZzda2Kgw5a2xjcDKx4MNQfWKH8syIprVTUaJefFTwK0jhnaT8Wkik2KZGe6AMsz48SGg5kK+bkaxXclh+K+togpDvy2AYC6eCjJJAa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432898; c=relaxed/simple;
	bh=zQj37/mnwkJ7+JyT9lS3hzx4mcaWtPYGerXZlwj7zLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFDdVS6eAY/zNwtx+VEEq7SnSopv946ra0+iN1ZNAeKbI/L3194pdCZ6ihBM73AAiw+gZU9U4OH1fDOZ+UDr8Og44d1jFeZj3pSZ6hbEP7DT3TOB60OavS5mlodTAwQ2bgDGqW6Gf3CNIoW/fmNwrpv3Fg20XtOCCKqbT9s59io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOuhzwtF; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c726f0a21so26363c88.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776432894; cv=none;
        d=google.com; s=arc-20240605;
        b=cGnHe1++VKRB8ppdlP1ib2D2QSeo6/9n6WOgUGFzLGPAq23ZhrQcRHrV6WY5LtuRzT
         5c4F0s4mcxVody1KH7tHiiR05BfiC+yrBcvfmbw7yO8rDlRWCKVQvE/Ab/FmXyhwxsxk
         2DaQummR3BfNAHV9+P2EVAuIAOSQT9EHEM8AJ7Q99iRiHiXIPMU4P1LgzHnL/eYadpJZ
         FkxdeN5Gz7H1z7e4e+oOq1MzBtYNxjkIzRIO/R99+1RoPBE+kqpMK1ENRhZbqeebMJd3
         Io+pf3/lAry5j/DE/TwD71kCVgSUxwG9cd0Oj0+asruTSI9FacJgMmMzUZos45Du+MDe
         ndLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
        fh=g1ruoOJcTZQLbQCDGAJK1qJKCHEmIZ8NPBQGWzo6QRI=;
        b=gyhS/vi73RqThUFevMGnIvB3+OMzLYa99QlKneK6p+xH5SSx2MuLK5xDyKkqkebGnD
         //e0Ap6EGOKJrDJjPr91qdIOd/55J3qDGR+o+QCuGWUxb5UuMq4nj6rtWYPXQG3HI+0F
         KPuTekXxPnJrMBGOG+y8xPjFq5hX/vJ40mxSv+a+Mcy+JrvgyHvfPHlfqUnodzo5On4T
         mtGfIZRMZYaEPsDw7wsykyJsfosQijceDENeclNCoeuZ+7dOLcD0Rl0/IyviysbZa0GZ
         WIW1FLd1tVmRhbdDkP5no+6g6e4wqCXTR+hQr30G3KRXenjoKdXP89ZaGVhoAX7dCMav
         /wTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432894; x=1777037694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
        b=UOuhzwtFceBkukfzOqVHBtg8VELfoRMMCdK1Ia6Kw66oFr61yluEl5qw8WXjBoitE0
         sXrQdffCwH8DfrvlfzJVSnIjv0lxprBSja4BG6aoSYCl71wDAbLgX6o8yxw9cSzyOx7g
         EkGcIneWF5Z+sCqCkoPu7eQpNulzmX+TuOVw+yOruGiJZgw3JhtO4up17pU+ujpQc4NK
         sxYo4DK6sJR94HRDiWl+/oZfGJ5Yptt+eonqjRLtSh+Izmdba9crXNKw635yA3gc6Npq
         XEJLSfXz/XaUYrM3aYaJUNSmFnzYMzYoHPh+VMjrL7hu27/onDG+gSkZT1kRRpNGJbUG
         NyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432894; x=1777037694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5SQjdAFcyv8NdqIsfRQOzzA0lu5rNy+ZmGTAor1otU=;
        b=W2qCbwLiUCR9nUEYv9eHSpxz0+j7WFzSXa9HDNZ1M4lJ2LI9C/JfOH5cXU/T2XtxhB
         uy0PT++K6+jWDgGCL2wBXsPFeDEf0JGxj4x3CBuqlszUXXhSDA+y9Dj0iqj3pZLND4la
         oFYIN1Pp8Shf66gg0e38a8u2QObxV6TKH5F2q24kxb6MRO+kNQMFGqfMvtNYxgKd+YNy
         Zk7RHMfbDNfI65f5vSvY9STDvcXORHK0llQtDa4uWb5xXlyfHsZCZpNQZCb9vK0EJVHQ
         ke1VAxG5tXIrV0MaGorEccRi98AZUgQOClNEv4nLdeXGtqH+TjlsKO2jAOx6IZDtKnC2
         YTlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Hs+ihjwRk/JOwGbbAQCnF/a9xn/ziMTqwWi2Y/DdA1tEDrK7omjee5/d0Zg53eoRZqlQ1PTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJlBsFboAfqvwinLMNbtZ/HIWNbb9t7+OM6jmhFI9cvtDxhnr
	47ErmKQ0cQQxCK6WK3HmrficsG7bNS6rn0kIwzSeXeyA9LzDpIoQ8YxGh7ZYBh15zvclct8ZJVW
	iHQEF4dM27BnSXowZuKQ4Klxu0SEzDsk=
X-Gm-Gg: AeBDieuk0++w5RH/VPBuvzM506rnuPJBeHppcXDag/bwq/raUbKG2XSIL0A9U9K4uLz
	G2F88OjElplu7YWfcSsJ1wlPtEOrRJmlc+/D502wUTw4MqV2hh16BoMv1TNvWHbKgJtGHuX5RQV
	GdaMRnO36jRHxZEy2lpQT6insFdfTKuS1Ka0WMD+mkFyve+RPZ1OIOMjYAKxhi17D3zWTxTLdAm
	ReBhZXWwlfJHtjSoFp74Y3/jRFcyKBguSEKW+O2JRDEuAQdvB0wgxVtik6UEnJQzVFtcvx05JY5
	y/eDd3M3HIUMMf7aCrMRQbkInuSY/QMoUhQHjWja2r4G+u7zirsDiss4BzCGs4tU2LjhkI7RDxS
	AGaOw
X-Received: by 2002:a05:7022:928:b0:12c:33dd:fa0b with SMTP id
 a92af1059eb24-12c73f69c12mr560921c88.2.1776432894188; Fri, 17 Apr 2026
 06:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
 <20260415221350.1178094-1-werner@verivus.com>
In-Reply-To: <20260415221350.1178094-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 09:34:41 -0400
X-Gm-Features: AQROBzBNKLgUz5j7LnoNFi5Ad4rOoyX0l8ZAuNVWt5YQYXWOh6GE9S_RYf361NE
Message-ID: <CADnq5_M4Rr2ifOoCrvLqiqj9H6tRgKOY3Tn6NqyUB3YziicqZw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/radeon: fix integer overflow in radeon_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238492-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA85441BB6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied.  Thanks!

On Wed, Apr 15, 2026 at 6:14=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> radeon_align_pitch() has the same kind of overflow issue as the old
> amdgpu helper: both the alignment round-up add and the final
> 'aligned * cpp' calculation can overflow signed int.
>
> If that wraps, radeon_mode_dumb_create() can end up returning an
> invalid pitch or creating a zero-sized dumb buffer.
>
> Fix this by using check_add_overflow() for the alignment round-up and
> check_mul_overflow() for the final pitch calculation, returning 0 on
> overflow. Also reject zero pitch and size in
> radeon_mode_dumb_create().
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
> v3:
> - Squash this fix with the earlier zero pitch/size validation change.
> - Use overflow helpers for both the alignment round-up and final
>   pitch calculation.
>
>  drivers/gpu/drm/radeon/radeon_gem.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 20fc87409f2e..8ce180e22d1d 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -28,6 +28,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/iosys-map.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>
>  #include <drm/drm_device.h>
> @@ -812,6 +813,7 @@ int radeon_align_pitch(struct radeon_device *rdev, in=
t width, int cpp, bool tile
>         int aligned =3D width;
>         int align_large =3D (ASIC_IS_AVIVO(rdev)) || tiled;
>         int pitch_mask =3D 0;
> +       int pitch;
>
>         switch (cpp) {
>         case 1:
> @@ -826,9 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, i=
nt width, int cpp, bool tile
>                 break;
>         }
>
> -       aligned +=3D pitch_mask;
> +       if (check_add_overflow(aligned, pitch_mask, &aligned))
> +               return 0;
>         aligned &=3D ~pitch_mask;
> -       return aligned * cpp;
> +       if (check_mul_overflow(aligned, cpp, &pitch))
> +               return 0;
> +       return pitch;
>  }
>
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
> @@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_pr=
iv,
>
>         args->pitch =3D radeon_align_pitch(rdev, args->width,
>                                          DIV_ROUND_UP(args->bpp, 8), 0);
> +       if (!args->pitch)
> +               return -EINVAL;
>         args->size =3D (u64)args->pitch * args->height;
>         args->size =3D ALIGN(args->size, PAGE_SIZE);
> +       if (!args->size)
> +               return -EINVAL;
>
>         r =3D radeon_gem_object_create(rdev, args->size, 0,
>                                      RADEON_GEM_DOMAIN_VRAM, 0,
> --
> 2.43.0

