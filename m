Return-Path: <stable+bounces-85100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08999DF1A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D2C1C218B5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DD18B486;
	Tue, 15 Oct 2024 07:07:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF5137930;
	Tue, 15 Oct 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976051; cv=none; b=f3Jx3L8gMKFmqICC8Anqm4Ol+xHZbUPlTlHuJ00OLizmi/yh0GC+6oZz+DDXb4hCIqqRVSTIam11JgVY1GxxTcYRyGknDypnDDn0Oa9wyO+GVcngpn+K8GSC0BVyYbN8Bytv0C8ABc9JVc9sjt8gJvD+EahatQb9yFZX++xmDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976051; c=relaxed/simple;
	bh=6dfEGaajQa2pJMeZNL7rrar7W6Le7Lr83zfKbQPXDzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec9P5eShIhiGfbel9vDHll0pFw7uwGL4ZHTPQ28JsqJVxp22/yUMMFtYab7PNyWCcMQy91QfAwHXiIat2vpYKSujru+SuoZszJWGSqq+mLqBjqreEBQQNpGTlbVya99zEtDUWlsI409U7KXAZahi/z9Et7rg71sqpN4TzCiJLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso4335351276.3;
        Tue, 15 Oct 2024 00:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976048; x=1729580848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNBLoVY7KmTb//gQvb+nY+loZrEE+K14uHe+vpf2a3w=;
        b=UJrDfBXUm2tZr+zpRQWsqs4DL7agTcQ/Rzh8WLelSWfZ/YudBNHPDR5RayjwqLEAp6
         Duf+YM6Ul0lN8Xw9shj9uEI0u3nd/S6GZmFHg7KfCquGQTKTb/AQh5x7RcuVUuHUV3Yb
         Gcb8eWeaO/PbdsSdhEps+gJAQ8EGvWoEm1MI0vtwUjMYAf0fKD+oRiA34XSRMXi+iWaj
         wv06OlUq9D8xX/M7cwRZ76kZIqxSmWXyFQvQ1jMNjBXo7W3H7Ek/qfnr7kRuW66QizkK
         T1TyjyOJOnX/cUrQrX7zSaKwN9NQwDbjIr0sbMg0fsQBFj+a/XrEtmSxdg8aeM/R/Si4
         L7lg==
X-Forwarded-Encrypted: i=1; AJvYcCUoCYooD2hwBJpWSGP5pc/rt6P0fZpwL7k0NzDzrhlSTU3LN3u3CPgdjcQ3JAP9TayYRS/+LbbRTk9MG24=@vger.kernel.org, AJvYcCVFhg0nNSN3PlX2tue9xkhO8HVA8fYp+36xtGhwy/+XIiwH2S5qKJ69+UqizF2jzbiTUb3g8Utx@vger.kernel.org, AJvYcCWtzVuGSchwuKX99GgRO+7oWGANMxQO/n0weaLuPtEQ/wnhBRrDDWoLBubMq/vEM1rkJT1OEhQ8YspepZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iVeAAnSdDRzsPI2omYLn2QIl8OWBqLXsLfK+a+n4gSXI72Qv
	jhuW1qLnPISWzyDlPRX++WAY5BmiGv5uWsIJ/oKlvZn1z5iNCQ67Bz6G8MDv
X-Google-Smtp-Source: AGHT+IFlsjLpHOA4c9FtIckf+ML7mh8UBb0rQSqgW67SKPQs0scHNttzEK9zFwDzjEWM8DnxwdQB2w==
X-Received: by 2002:a05:6902:2809:b0:e28:f402:cc6f with SMTP id 3f1490d57ef6-e2919febfbfmr8260965276.46.1728976047796;
        Tue, 15 Oct 2024 00:07:27 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfb8c5sm142600276.3.2024.10.15.00.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 00:07:26 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dde476d3dfso41729887b3.3;
        Tue, 15 Oct 2024 00:07:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxWv7Jp/qcjIVaRSOwcvmtt7kOzl5VdbDbN26nWv4Ko3RfZoqpPS/ehXJow7ueKmptdUVNMXiECgE0XGc=@vger.kernel.org, AJvYcCXKshhEKuMVp4/bOjQLjWGPt3idcP1UIOwsNXWi9FzgGaPC2yR9miRHdm7bNuXlVif07Mrjp2jf94OU3hg=@vger.kernel.org, AJvYcCXT/UaKiFxPIRdd5QzNuajmOxNg+mQfeb9MbNEhuq1Vw/GzTAMyyNmcDqNoKUYXH24nKzGPzV0+@vger.kernel.org
X-Received: by 2002:a05:690c:5302:b0:6e2:43ea:55f with SMTP id
 00721157ae682-6e347c68ffbmr75778377b3.38.1728976046499; Tue, 15 Oct 2024
 00:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141217.941104064@linuxfoundation.org> <3ab1938a-6f6a-4664-9991-d196e684974d@nvidia.com>
 <CAMuHMdVHLiB7PWji9uRLZNWqFa1r7NiTv9MWCCAg=3-924M7tA@mail.gmail.com>
In-Reply-To: <CAMuHMdVHLiB7PWji9uRLZNWqFa1r7NiTv9MWCCAg=3-924M7tA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Oct 2024 09:07:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcE1Wvi+g5P5CEe5RFEuBfSCmR+7HFVfiC1rG6bHdesA@mail.gmail.com>
Message-ID: <CAMuHMdVcE1Wvi+g5P5CEe5RFEuBfSCmR+7HFVfiC1rG6bHdesA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Oleksij

On Tue, Oct 15, 2024 at 9:06=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Oct 15, 2024 at 7:32=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> > On 14/10/2024 15:09, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.113 release.
> > > There are 798 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.1.113-rc1.gz
> > > or in the git tree and branch at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > > -------------
> > > Pseudo-Shortlog of commits:
> >
> > ...
> >
> > > Oleksij Rempel <linux@rempel-privat.de>
> > >      clk: imx6ul: add ethernet refclock mux support
> >
> >
> > I am seeing the following build issue for ARM multi_v7_defconfig and
> > bisect is point to the commit ...
> >
> > drivers/clk/imx/clk-imx6ul.c: In function =E2=80=98imx6ul_clocks_init=
=E2=80=99:
> > drivers/clk/imx/clk-imx6ul.c:487:34: error: implicit declaration of fun=
ction =E2=80=98imx_obtain_fixed_of_clock=E2=80=99; did you mean =E2=80=98im=
x_obtain_fixed_clock=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >    hws[IMX6UL_CLK_ENET1_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node=
, "enet1_ref_pad", 0);
> >                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> >                                    imx_obtain_fixed_clock
> > drivers/clk/imx/clk-imx6ul.c:487:32: warning: assignment makes pointer =
from integer without a cast [-Wint-conversion]
> >    hws[IMX6UL_CLK_ENET1_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node=
, "enet1_ref_pad", 0);
> >                                  ^
> > drivers/clk/imx/clk-imx6ul.c:489:34: error: implicit declaration of fun=
ction =E2=80=98imx_clk_gpr_mux=E2=80=99; did you mean =E2=80=98imx_clk_hw_m=
ux=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >    hws[IMX6UL_CLK_ENET1_REF_SEL] =3D imx_clk_gpr_mux("enet1_ref_sel", "=
fsl,imx6ul-iomuxc-gpr",
> >                                    ^~~~~~~~~~~~~~~
> >                                    imx_clk_hw_mux
> > drivers/clk/imx/clk-imx6ul.c:489:32: warning: assignment makes pointer =
from integer without a cast [-Wint-conversion]
> >    hws[IMX6UL_CLK_ENET1_REF_SEL] =3D imx_clk_gpr_mux("enet1_ref_sel", "=
fsl,imx6ul-iomuxc-gpr",
> >                                  ^
> > drivers/clk/imx/clk-imx6ul.c:492:32: warning: assignment makes pointer =
from integer without a cast [-Wint-conversion]
> >    hws[IMX6UL_CLK_ENET2_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node=
, "enet2_ref_pad", 0);
> >                                  ^
> > drivers/clk/imx/clk-imx6ul.c:494:32: warning: assignment makes pointer =
from integer without a cast [-Wint-conversion]
> >    hws[IMX6UL_CLK_ENET2_REF_SEL] =3D imx_clk_gpr_mux("enet2_ref_sel", "=
fsl,imx6ul-iomuxc-gpr",
>
> Missing backports of the other clock-related patches in the original
> series[1]?
> imx_obtain_fixed_clock() was introduced in commit 7757731053406dd0
> ("clk: imx: add imx_obtain_fixed_of_clock()"), but some of the other
> patches from that series may be needed, too?
>
> [1] https://lore.kernel.org/all/20230131084642.709385-1-o.rempel@pengutro=
nix.de/

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

