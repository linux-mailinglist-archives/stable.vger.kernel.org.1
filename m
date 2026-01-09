Return-Path: <stable+bounces-207919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35135D0C6B5
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA63F307CD2D
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BDE342C93;
	Fri,  9 Jan 2026 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD87ctP4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353C3033C5
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996640; cv=none; b=l+rJeMXq2tEb9aXNFx7f87cac1LBwN/3c7YUq5xN9Qx2Y01NPWmx+A9wIyNrDWIfV6C0Kwe7hr551lVF0zbB3VE2ChVaQgstOls+WaKui1DV9cn3n4FMt6dWMX+yfyVzUAA8X9FlyV0CMTwn4DpLOSfZr4ma6boR/nvRT+/ppW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996640; c=relaxed/simple;
	bh=3QJ52a/bgPzuUKTzUBTOpjnpR6DZhhOjRgWi3SR/6pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePtRw2mcR7H6N1Y4GBIqcT/DtsRe5K9Sadrvm71uIHqZBwsP3myG76nAROQyZOPbyVbxF3/LJ+kavcr03F9GuK3Sa/5+lNwprcAMWxBgxcs1B2VflprTgOv/DRdLdEH9Zhn3/LslGV9XAPF60UA64X+F4h//+Jlt4/CoZM/mj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD87ctP4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc305914so3212528f8f.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 14:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767996636; x=1768601436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfQX3D2SQZ81h5MUWXgygzdao1nDh7Pskp4FXNApMag=;
        b=RD87ctP401Xb21HlFGLTLDPbhgmAqn4QYzEA+us3ggcTMNZml1qRymN1eqN7+aP/xS
         ihYCgGnt6vIo4U3lGZXWifUfcXk5we6r7B/bPWIDesg2DNM18ZyO+82dhDvSYJJKt2Jc
         NDyltjLkltKqdUvfR7jdj21xbbpq6RXE8cgcTwsr5VYDoKe9BCshZVHrm3VF/U4e3ouY
         RbRM+ZoUYZI6+LOFQyDu3LICXGS6gEHrV2obGSTnRLPt52VWNIXK+dMXlzraikOKUg3a
         V842ZNHo3WTV4uzGMxNnxL3tm/rPM3XrYesqwFfcYJEv+0pufdArjUyvNP+YW7/wwZ4d
         uWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767996636; x=1768601436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DfQX3D2SQZ81h5MUWXgygzdao1nDh7Pskp4FXNApMag=;
        b=Vwj8lUyr/B+9d9/wF1newT4RXl09eDIfQMJylkH927EA8oOr71RACpl9zdJ44pHsij
         BQudRjw3HNUMCEZ1EceIpqn18LlL2eH7eliHoIsS+ji76rzKMDWAczE/lFhuoqguqkDX
         gEqkAmpGQtp6fwftuzw33ANTXeyjKbbZXDU60A/6nf2QY2FcJLe53vyTXk2E+58iEmBS
         C6dyHOJjnRH+3bkhvjVM+4b8qbykB4Ydv/GKDkUkri1uIa9+MeCBOM6qv4BXXMrUGk9l
         GHDp60HhLToYUU18NwINlb6hxoKomxg2YqBznn189Z/oZ7EC0q5eS2BUll1hBbJjnfEv
         EAgw==
X-Forwarded-Encrypted: i=1; AJvYcCVfSwwCVp06p8iBgPznFN4SE362o4NmDybaFkLR/iotFM6y7xXk2Ddl2aXBhg9Upmzaeipbf60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ78D06JPRD2VyulnSIsUyNTN5z7bjoy584I6+lbnhud/q8v+S
	vBAtGPlebm9/KKix3URvtlXpUr2JlMwkBlkpDqY3rrLMKUKSz4+/JG4dKRbUOPHzG89RUngpOqF
	X40aRWzuh6zdmkr3p9Ca2cdHLXkOi06w=
X-Gm-Gg: AY/fxX5wfi2aDWvwfJxruIwEEjSy/lGeUEyRGSiz7eWkkI/kZQK4clKSol4xXGPW6Zs
	/iHP5R/QnnXfRHhQd13PhkXUkbRwXuUQn/5mdnYCiAUUuXjM1wJHsqv448EHmkdriajktedV7D4
	X6QwVKeRFubNZs0kDx6ZTLUSiIcd+xkjeRfG5bw0oh0E8tlMjtnjmJAGF++f1jIleRgTuGdtden
	x++zA9XBRTpwQbmFA6sop2obl5WMdPlv6ZokKpuTTNi8eunlVPUfJANNx+HA+LL9YgFxc5t1svo
	4R94AhsA0CZSkWO9TsUZ/YpbQA3QhOawiLM1tXO6MMuMksaQhPizwJ2JMA==
X-Google-Smtp-Source: AGHT+IHal3Q6HFx6YVC8+0mAQiKOoH3MXiFcxAmSjJQKYvO2x41v3zKHjCGVp4VEpxzUGTgRZFvHvhW4UYQw8D8sctM=
X-Received: by 2002:a05:6000:4387:b0:42c:b8fd:21b3 with SMTP id
 ffacd0b85a97d-432c37a756bmr14376383f8f.57.1767996636042; Fri, 09 Jan 2026
 14:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767114395.git.tommaso.merciai.xr@bp.renesas.com> <b9aeabb34829b8e97559610a3d00ef67399a300c.1767114395.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <b9aeabb34829b8e97559610a3d00ef67399a300c.1767114395.git.tommaso.merciai.xr@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 9 Jan 2026 22:10:08 +0000
X-Gm-Features: AZwV_QjTEWHsOF-enm5ILtjYfjq3ZPjFoDTCBeAIzDNXHIv7z0QOsdW1H2Ls98E
Message-ID: <CA+V-a8vqyO0w5qp-Zu1SuYOTjZiZaiRVL2VGwQSPcUGF0vuuHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: rzg2l-cru: Skip ICnMC configuration when
 ICnSVC is used
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Daniel Scally <dan.scally+renesas@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 5:16=E2=80=AFPM Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
>
> When the CRU is configured to use ICnSVC for virtual channel mapping,
> as on the RZ/{G3E, V2H/P} SoC, the ICnMC register must not be
> programmed.
>
> Return early after setting up ICnSVC to avoid overriding the ICnMC
> register, which is not applicable in this mode.
>
> This prevents unintended register programming when ICnSVC is enabled.
>
> Fixes: 3c5ca0a48bb0 ("media: rzg2l-cru: Drop function pointer to configur=
e CSI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/dri=
vers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> index 162e2ace6931..480e9b5dbcfe 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -268,6 +268,8 @@ static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev=
 *cru,
>                 rzg2l_cru_write(cru, ICnSVCNUM, csi_vc);
>                 rzg2l_cru_write(cru, ICnSVC, ICnSVC_SVC0(0) | ICnSVC_SVC1=
(1) |
>                                 ICnSVC_SVC2(2) | ICnSVC_SVC3(3));
> +
> +               return;
>         }
>
>         icnmc |=3D rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_INF_MAS=
K;
> --
> 2.43.0
>
>

