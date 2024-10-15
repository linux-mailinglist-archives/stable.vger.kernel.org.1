Return-Path: <stable+bounces-85099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE499DF17
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258DB1C219E2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6942618B486;
	Tue, 15 Oct 2024 07:06:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A0137930;
	Tue, 15 Oct 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975995; cv=none; b=CfeyhLrufWDuT6YTKsAM3/7xQq7QDkaxcWjb64AUHMaNFPtGkOar5yZdL2HBwLuKVej3R/8UTRaKoQd+sBRGa6Xq9qFpLhU6t/a4/BJtXO+AKd20SJPBWo/kzfGtG1iW7ByKXP3RCfsH6l8hgSGJIQUHmIkeYiE+Pt/N4cYTMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975995; c=relaxed/simple;
	bh=LYPJDKAOIaphEy92xgvTYRFt9LgukmQ/k1PhfTyENkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2X+IzQ4vyYsqrlrr/QpjPgQozHTcyiuVTXFFqRTtDpn7E5evY7KJJqEsMk4HzZFqXTjBQ9bkErDy0hIyFYDhpn5qkiudb2ArVwdppgqMY3OhVQ+/n2Ml3NPHuTaepz9sSL1tCA+7jab5vJPp8Wq/Sh2eattYECvQRYG/HmeukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dbb24ee2ebso51651277b3.1;
        Tue, 15 Oct 2024 00:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975992; x=1729580792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjXNxhe4YkjVhl5J3HDsDQslVdlFO3kMOqAyUlL8DnU=;
        b=dnCmbDtdiSGf8/2uHGHcQ2AddAjHNWXHHNm+wnnFqDXWPwgirRoo8ekOIHa+LRSMDO
         z/IFKX6kusVs7fFu0/IRkcY6VtPncQOmBRC07KiF16oe4bUhQj88iTI3WrtG9MNiGNsZ
         cs3TnzVZ/TrzVgB+EnfkLzPtatQvRZ2/ZdnqFjNpDxB6/VtA3/aYjxVhHzuSxvQz/zMh
         Nnb0nxtzK5bUF0IkiKSDLyV594K3v9C6mD4+LMXqP2w+Chu+Ai1JOPPIqHKI6ZrAsxra
         VwLM/zIzrPQz6ss0jy8g7fe4x7stKP46TrfS2RtAEcUi07lcWcBBWnZ3J3lWOB9RorXS
         hC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRksgolTY6CHYAgBw/RcYfQE+9pVPsyj8gTGmm0GHAufaoNS405A8rOOP8gkmkiknaoSdtLZKbq+qgxUQ=@vger.kernel.org, AJvYcCWxBmX4DjXXQwuV8xqbjY1yB39QG/RAGCTUMQB39a6FBVn6lXYuHkn02n0HMV67HdUCt7DZOh+H@vger.kernel.org, AJvYcCXfGli8f91XhaKdZSkiGqGPJSraCiBcRfcPkKIZ20/ijp4m7QmI5AuPFrYSw5glUUi7EhpEhxNYCTuFbHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HpVfpS9HWNiNeHspjgMmJ5Zkxap94A3BrLP0dL8bCfRwmWlZ
	Ugc04DSUaunG/bWutwSSLO9erCwUY/J9wxGGGa5//HYQWwtjQxp3gPHnVQ3r
X-Google-Smtp-Source: AGHT+IGEDFEpWB0ZRU1LJRaweqLNuMHaVtzhGTM+46dG+NlSZhgCJhAZP7xp/QVL510NsacM97WPqg==
X-Received: by 2002:a05:690c:d92:b0:6e3:1f02:4069 with SMTP id 00721157ae682-6e3477c030bmr106232847b3.7.1728975991752;
        Tue, 15 Oct 2024 00:06:31 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d25cd2sm1581397b3.118.2024.10.15.00.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 00:06:31 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dbb24ee2ebso51650877b3.1;
        Tue, 15 Oct 2024 00:06:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOdnARffxW2nTUe/I8GTRyNHj3Qe62yq24n+e0vBnHUllndmav0eOFsUd7/CXGmUtmeBefHM9gtVV1J/4=@vger.kernel.org, AJvYcCX1RmmnVN1vMiOYxq8GGdAX06PrDFTQ+kxWSgaRpFnn6WkOVcRw8dOmy0o3j6pYK+JdX8ERSlMj@vger.kernel.org, AJvYcCXY2WZWLcwhZjXWWQRogmoXuMv0WTySP65PuSrmIi5pkwrL89Hnv7i4vpTZ0FjHVFaLkNAG0Iwk9O46TGo=@vger.kernel.org
X-Received: by 2002:a05:690c:5302:b0:6e2:43ea:55f with SMTP id
 00721157ae682-6e347c68ffbmr75764257b3.38.1728975990825; Tue, 15 Oct 2024
 00:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141217.941104064@linuxfoundation.org> <3ab1938a-6f6a-4664-9991-d196e684974d@nvidia.com>
In-Reply-To: <3ab1938a-6f6a-4664-9991-d196e684974d@nvidia.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Oct 2024 09:06:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHLiB7PWji9uRLZNWqFa1r7NiTv9MWCCAg=3-924M7tA@mail.gmail.com>
Message-ID: <CAMuHMdVHLiB7PWji9uRLZNWqFa1r7NiTv9MWCCAg=3-924M7tA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:32=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
> On 14/10/2024 15:09, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.113 release.
> > There are 798 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.113-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------
> > Pseudo-Shortlog of commits:
>
> ...
>
> > Oleksij Rempel <linux@rempel-privat.de>
> >      clk: imx6ul: add ethernet refclock mux support
>
>
> I am seeing the following build issue for ARM multi_v7_defconfig and
> bisect is point to the commit ...
>
> drivers/clk/imx/clk-imx6ul.c: In function =E2=80=98imx6ul_clocks_init=E2=
=80=99:
> drivers/clk/imx/clk-imx6ul.c:487:34: error: implicit declaration of funct=
ion =E2=80=98imx_obtain_fixed_of_clock=E2=80=99; did you mean =E2=80=98imx_=
obtain_fixed_clock=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    hws[IMX6UL_CLK_ENET1_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node, =
"enet1_ref_pad", 0);
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
>                                    imx_obtain_fixed_clock
> drivers/clk/imx/clk-imx6ul.c:487:32: warning: assignment makes pointer fr=
om integer without a cast [-Wint-conversion]
>    hws[IMX6UL_CLK_ENET1_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node, =
"enet1_ref_pad", 0);
>                                  ^
> drivers/clk/imx/clk-imx6ul.c:489:34: error: implicit declaration of funct=
ion =E2=80=98imx_clk_gpr_mux=E2=80=99; did you mean =E2=80=98imx_clk_hw_mux=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    hws[IMX6UL_CLK_ENET1_REF_SEL] =3D imx_clk_gpr_mux("enet1_ref_sel", "fs=
l,imx6ul-iomuxc-gpr",
>                                    ^~~~~~~~~~~~~~~
>                                    imx_clk_hw_mux
> drivers/clk/imx/clk-imx6ul.c:489:32: warning: assignment makes pointer fr=
om integer without a cast [-Wint-conversion]
>    hws[IMX6UL_CLK_ENET1_REF_SEL] =3D imx_clk_gpr_mux("enet1_ref_sel", "fs=
l,imx6ul-iomuxc-gpr",
>                                  ^
> drivers/clk/imx/clk-imx6ul.c:492:32: warning: assignment makes pointer fr=
om integer without a cast [-Wint-conversion]
>    hws[IMX6UL_CLK_ENET2_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node, =
"enet2_ref_pad", 0);
>                                  ^
> drivers/clk/imx/clk-imx6ul.c:494:32: warning: assignment makes pointer fr=
om integer without a cast [-Wint-conversion]
>    hws[IMX6UL_CLK_ENET2_REF_SEL] =3D imx_clk_gpr_mux("enet2_ref_sel", "fs=
l,imx6ul-iomuxc-gpr",

Missing backports of the other clock-related patches in the original
series[1]?
imx_obtain_fixed_clock() was introduced in commit 7757731053406dd0
("clk: imx: add imx_obtain_fixed_of_clock()"), but some of the other
patches from that series may be needed, too?

[1] https://lore.kernel.org/all/20230131084642.709385-1-o.rempel@pengutroni=
x.de/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

