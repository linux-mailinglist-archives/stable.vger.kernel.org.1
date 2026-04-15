Return-Path: <stable+bounces-238126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKzjIbiM32l5VAAAu9opvQ
	(envelope-from <stable+bounces-238126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:03:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40E404A36
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 614943030A9E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5C37CD46;
	Wed, 15 Apr 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH+/bKzm"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2433806AC
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257964; cv=pass; b=YkyH3oORL8rihknBlvWTSsjmN2/MqxfTfW5VSZZh4PuBlw2NpLQSLjCgGWqH1aQMuD1RNfjLhVkvCElVypRT2Unu0VwFErjwyhJcSV9GzsUHBjbdSUVXv7JX+ycJjlrZUHm9yBLePHFi4QKg+U7Yw06Ebs7BxhYX2/rGLlTafRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257964; c=relaxed/simple;
	bh=IBXai5084DF0i8LvTA9qZ06l4Lcf/xBqGMCfHBkxp4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdhXuh8bBN9/SemvHWK6bgEM89S5lM0veCgAR/NE25rKNHGgV64MHYM5IuE8sTHfY61BW0/iMq6hIBuUDWR0JKStfxyc8s4Obj1d8R00hy1bkfXn3d0numFt72Pg/fH+uAw3M0FmTupLC6jKAihpJUGFlpm8GvVZoiveeraxNsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH+/bKzm; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-127337e3870so968831c88.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776257958; cv=none;
        d=google.com; s=arc-20240605;
        b=TacKqN4b1WKsp6X7vDbIBxVGSOCtxcKQ6FX/X1oZO98sF3ZwgTAxlQWQSEdj1GWE6O
         aiNFMfkJbMyKUJzTP+vhswIS+JEAXBfAwaipQ+6+t0QZqtpFtaHVvpCRXGq5CpL6dIKa
         GEhr9q/3qVVxNvPfNXklm2gBn2FTjIZhnublfdigeFmiru5LtQ03m02SI92ip1Ojw7bs
         Hul4FGCFqXgrIIGPXXGSUiGtSLbMaRB5uM/1W5p+e+sEzDemNuGg/zJ7qOk9nQOqLK/q
         LCcXXMbJCmwEIG4HacdC/xCQO1ewyrN165siXXFolt/xmXdM0vvSH8IN61jHjKxxlCUp
         l28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
        fh=rYBRuUS/xy4HgArVN0gURf7W6ntS0YXhwGo5nHAIRBs=;
        b=J5CJqMj5hj6wLWlS2YyXlbGVkYOkEUX2Me5Pqt2cYl8HcMOFEXXpBy1W2NVXW+CmAy
         PWJVZ/Fz4JM0WQLhfOgUok423XwGTK0y2dlJc/kPC5UPXRYcWJBcIgdAsTUiU8vnZ9J6
         5Vsaur/YtLgOeVyIMuHkyUrWTpt2V2x1mF7ha/zKprg2YYZoYxLiz68w+b8fZ4N3SWm1
         1veJzbSA8qN5KYxd4fmAUo4ocqd1A51TSc8EOVYb5QM/+11VXROHJhx64P149plv+nUw
         PGJw5FqbLdDHrqgnyWGX7qGnpAlVdnSLfBMvLHsGelB4sZZwEpU5eY68oZXKLlZcbQgH
         VzTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776257958; x=1776862758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
        b=gH+/bKzmzXs3CaSmn4zKbxX12YJUr1FOuC1FbMh0Ub8o+OfKc+0tyYvV++Niqdv7uA
         tJdOAWiIIJZnvLpSRxj1Xp/+W0j6uhCE9PJ0SNWdFrWPlTnt7KAsYWLph/gOHXdjoFed
         SdJeYKSUsqTTU5brEyjHA1VN2stdK7uMTrI7XcCAkLRVr1Fn9ALCZ/plozZiMfjPR/wc
         y9yZv19YHJBM1IruNdAKvsnnEVnfFERLOBwseFj0h35Dp85txYFJxoniDLHRzb63ytGX
         12PUc12M+75JAgbgf3coBGo1An8suxNzFWRjBLJO9nehfYyNJRkNB/0ynlEfl+baG1Z0
         UzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776257958; x=1776862758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
        b=DkjckY8bkpODZs/VaiAIeOm33s4ilinYNNRKIPlo8uGE0gdd/A8wCLUzkYhsrGJ/zd
         nde/cWLogF760p3bGAECIHIk3NDcwtD7kZOFhCyxgim5dxXVuW73bzktmbDZMY2M1kfT
         vA6Y6xqup5oeGz3dxSDgYjLc6CUoL/vBk9fkFeRufO9/pmPa0NLpogf7fABFAjfe9GeV
         a17mJD6780q01ZgRBMAZRLdmzpCJg2M78XbhnolJUv1DWWBZEVTLiidPAudJmWNHKzD5
         AwsolqLccQoQr63OtB4QgQ7EyDuhFfyhcC4sanptNQMLadrJLQ0q2xDTZ/0ewmYJTFsu
         0tXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AqBIUmXKrcpFfPFDG8jags8zl9MI8KWDlHp0KKhvaUzfhk/Oxv/Ifd/1DmHUMK+zAo9bMn/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Obv5NzT37qpGlKpuHgxe5pdSZZv2BEQcPPQZkm0s5ccBG/5Y
	Q7RzOYoc8zJyxKyeqwY4bFerfPTOm7Y9LYcDOQk8sFDikywnuNXkCc+EY08H0kFf1VEf+KkR4SL
	oJjFVVfINSDnAKTcVaBUIeJs84pURHsg=
X-Gm-Gg: AeBDiettg4IzhfM4/Fxh2omdSYZ0xxkjLuZTw2Om0kMeVawzYGMm45W959KuJogirQX
	QJhc1eIlzg32l4t3GrRCwjayGB3glpNJHr7O0TTI6zedXla213/EPBHmfrv3SGslexE4n3/nJqG
	dDfUCw6Ip2tzvxolCRkg8LLcXN6+7efGfI7SWFICiuj6WXYXTWjavTCbaAScW7dWWIi6VyDkQQG
	7TEh3+XcvenMJJAYgnoGxZrjA7KG6tjOl88WA9AokpuZQb16VjG/MXg/rQhNdrphLBeBp7b4Kz/
	KUiBBmEXy4R6+itDUePLOSTnOG68kRKvb6pzGvgvDLOYsLSGOmdMBnChECzdQrBBWI9pbg==
X-Received: by 2002:a05:7022:618c:b0:127:332d:63e with SMTP id
 a92af1059eb24-12c5d4d0c7dmr506525c88.5.1776257958465; Wed, 15 Apr 2026
 05:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
 <20260414211437.154315-1-werner@verivus.com>
In-Reply-To: <20260414211437.154315-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Apr 2026 08:59:06 -0400
X-Gm-Features: AQROBzAeYix9JIhJ4gNGCdBtQrUS7rMQvoooy6xeRQZh2Q7drV282ZxpZgFSuFU
Message-ID: <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: fix integer overflow in radeon_align_pitch()
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
	TAGGED_FROM(0.00)[bounces-238126-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.ai:email,verivus.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF40E404A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Can you squash this with the previous radeon patch?  I only applied
the amdgpu patch at this point.

Alex

On Tue, Apr 14, 2026 at 5:14=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> radeon_align_pitch() has the same kind of overflow issue as the old
> amdgpu helper: the alignment round-up add and the final 'aligned * cpp'
> calculation can overflow signed int.
>
> If that wraps to 0, radeon_mode_dumb_create() can end up with an invalid
> pitch value from DRM_IOCTL_MODE_CREATE_DUMB.
>
> Fix this by using check_add_overflow() for the alignment round-up and
> check_mul_overflow() for the final pitch calculation, returning 0 on
> overflow.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
> v2:
> - Use overflow helpers like amdgpu.
> - Drop the stale zero pitch/size change from the original submission.
> - Fix the changelog wording around reachability.
>
>  drivers/gpu/drm/radeon/radeon_gem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 2cd179fef347..8ce180e22d1d 100644
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
> @@ -826,14 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, =
int width, int cpp, bool tile
>                 break;
>         }
>
> -       aligned +=3D pitch_mask;
> +       if (check_add_overflow(aligned, pitch_mask, &aligned))
> +               return 0;
>         aligned &=3D ~pitch_mask;
> -
> -       /* Guard against integer overflow in aligned * cpp. */
> -       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +       if (check_mul_overflow(aligned, cpp, &pitch))
>                 return 0;
> -
> -       return aligned * cpp;
> +       return pitch;
>  }
>
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
> --
> 2.43.0

