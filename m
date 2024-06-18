Return-Path: <stable+bounces-52634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3EE90C2DD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7CD1F226A6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D186C35894;
	Tue, 18 Jun 2024 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK+x7iMg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE891C01;
	Tue, 18 Jun 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685246; cv=none; b=oF88d0YwI8cmVaYcvG+YF8g3PW3QFTukmv2m7sLfGZlF3hI0P5nbsfDsEavoVQfUtv11xrARkQ0ezMeu/jq5KcLqFcsChlgrWGVmTQfT+Ccy6OfeUWkVv6uBpQ4Ovvy8nJRhg2oVJUkaiA9UMBULLQ8Vw8iqJnSv6ED4t/62BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685246; c=relaxed/simple;
	bh=JG5ilIHKoW/BF0yg9UG/0JJKxeLZlEF3zEaC7zcQSDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8kQFy158KpqBkt5FDL3COCGciFIodpvWN0oTyN6kG+dzmcF/AVhSwe0sYmhramWffIV7h9Ie7fMkadJcxRAzbo1jC/Z1Y5XJnGg60gu1i+JFQSABlWwOr1Mp7ZC7MSGu6EsZgosnE7SzjwoijQV9Lo3yyhI2G7XrkNA/mQagxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK+x7iMg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f09b457fdso460155066b.2;
        Mon, 17 Jun 2024 21:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718685243; x=1719290043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIwHA+mxDZIARtoB5DwfNg0Gfwpm3V2PRBL0EbC93+0=;
        b=CK+x7iMgTd3G2rVWVKMjeuyrifbBQDWduUmkrM41oevWeKR00ZviJ0FxXW4uv8LnHD
         5nq0w8z1eD411ylOs//oh8yf2vLKQsbCk4attPoO1jyiggAkblQmi8BlpMqA978puWeG
         qtE9gm7Zgjw/sNJBTOJLTXjHHBz1uptXx7Kodidz847W4CrkZvtJ81d2STG1G0k9G35w
         8vP5VKtkjeVzSpLVLUC036F9bFAYxLhBLHNFrP7nfmOreC1ZY5JI2EwXCfFr5cZfsi/B
         bcgzlQFdoSy2vIM/2PfT0cXiAw0hS2qxft0KiyRGWdKzdtfCTovqoOxenj601ZOXLdpK
         n/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718685243; x=1719290043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIwHA+mxDZIARtoB5DwfNg0Gfwpm3V2PRBL0EbC93+0=;
        b=nnOEqDZ72Ohr5b4gc5SsrKVWfcetS2/k2MzVPR0ydFeNH4pjarok4WKEvbq86Y4eIQ
         xBXrSlmcr5TOA+7ML4u18LLwQqikPKlExlPdYezAHSt8RXoGntNcMsHpJ7y352tplO+w
         TTHcrhN8rOy6XIhcbIEBH+EoN9m9GMKJYuzkdjfRG+Ywf3wtyjLB4/8S0vIvBTYpFQA6
         IBwABe6jnrIOi14pfNJmRoqqRHfpLa5joJ6cqTEWlv7IS6ZqoyV51ZUOtZy/Gjo2G4Sd
         hGwSe+bf8lSvl9LiSTc/MHt9/eoiB8bFzDVNpK+lXxKCl0xhcam/aMRzVPCSg4VNM30j
         +MiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdw4Mqy6iQGfbsVo6z373NrbdRPW4X1Sqox5iZLNyFRBc4I5NgV+f5vUEzoIxPCau4M5vYw5K5B+pibrNjJFj/EvWuSNpbrLg30kND4GdjUQGhn+NI8INSSqMGiSgA8yyUTNiN
X-Gm-Message-State: AOJu0Yw2PojsMwXcRS99R4a2z6VEaeUGCOtpicyz5MQqdu7EIIf7aAZO
	pKVt+yiTlnoJ7UhyouxGZwkD6mvt6gPZ/ur9FXBdIduwJJ1clbJ4HytAltaahPWpOVxS1vIrC+r
	qvlbAGCPAHD+ZcyuL4B0Zi9pAShU=
X-Google-Smtp-Source: AGHT+IEvIyNa10vntkg70/P22cvrLRrQaET/PryqCiwiAaxtddZK8JGlqlKFD8nYwOFg282VPsumofyXlGoruVft9M0=
X-Received: by 2002:a17:906:4ac4:b0:a6f:493d:5b9f with SMTP id
 a640c23a62f3a-a6f60d3f4aamr803279566b.35.1718685242877; Mon, 17 Jun 2024
 21:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
In-Reply-To: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 18 Jun 2024 12:33:50 +0800
Message-ID: <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
To: Dragan Simic <dsimic@manjaro.org>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org, 
	Philip Muller <philm@manjaro.org>, Oliver Smith <ollieparanoid@postmarketos.org>, 
	Daniel Smith <danct12@disroot.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see the problem that initramfs need to build a module dependency chain,
but lima does not call any symbol from simpleondemand governor module.

softdep module seems to be optional while our dependency is hard one,
can we just add MODULE_INFO(depends, _depends), or create a new
macro called MODULE_DEPENDS()?

On Tue, Jun 18, 2024 at 4:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Lima DRM driver uses devfreq to perform DVFS, while using simple_ondemand
> devfreq governor by default.  This causes driver initialization to fail o=
n
> boot when simple_ondemand governor isn't built into the kernel statically=
,
> as a result of the missing module dependency and, consequently, the requi=
red
> governor module not being included in the initial ramdisk.  Thus, let's m=
ark
> simple_ondemand governor as a softdep for Lima, to have its kernel module
> included in the initial ramdisk.
>
> This is a rather longstanding issue that has forced distributions to buil=
d
> devfreq governors statically into their kernels, [1][2] or may have force=
d
> some users to introduce unnecessary workarounds.
>
> Having simple_ondemand marked as a softdep for Lima may not resolve this
> issue for all Linux distributions.  In particular, it will remain unresol=
ved
> for the distributions whose utilities for the initial ramdisk generation =
do
> not handle the available softdep information [3] properly yet.  However, =
some
> Linux distributions already handle softdeps properly while generating the=
ir
> initial ramdisks, [4] and this is a prerequisite step in the right direct=
ion
> for the distributions that don't handle them properly yet.
>
> [1] https://gitlab.manjaro.org/manjaro-arm/packages/core/linux-pinephone/=
-/blob/6.7-megi/config?ref_type=3Dheads#L5749
> [2] https://gitlab.com/postmarketOS/pmaports/-/blob/7f64e287e7732c9eaa029=
653e73ca3d4ba1c8598/main/linux-postmarketos-allwinner/config-postmarketos-a=
llwinner.aarch64#L4654
> [3] https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=
=3D49d8e0b59052999de577ab732b719cfbeb89504d
> [4] https://github.com/archlinux/mkinitcpio/commit/97ac4d37aae084a050be51=
2f6d8f4489054668ad
>
> Cc: Philip Muller <philm@manjaro.org>
> Cc: Oliver Smith <ollieparanoid@postmarketos.org>
> Cc: Daniel Smith <danct12@disroot.org>
> Cc: stable@vger.kernel.org
> Fixes: 1996970773a3 ("drm/lima: Add optional devfreq and cooling device s=
upport")
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/gpu/drm/lima/lima_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_=
drv.c
> index 739c865b556f..10bce18b7c31 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -501,3 +501,4 @@ module_platform_driver(lima_platform_driver);
>  MODULE_AUTHOR("Lima Project Developers");
>  MODULE_DESCRIPTION("Lima DRM Driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_SOFTDEP("pre: governor_simpleondemand");

