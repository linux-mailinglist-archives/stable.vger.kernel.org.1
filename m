Return-Path: <stable+bounces-98970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8BC9E6B1C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07FA282F8E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E241F541A;
	Fri,  6 Dec 2024 09:53:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53813DDDF
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478809; cv=none; b=X++qzqccWqcgJfF9QmDsf8/AH9XD35d0TWJqj+ZJ77qHp4SRlyxSYxkMpjihuOaov8plSyH2Ms8TGdy80E4b67BPT7WFCKQFMdKfQ0lkLQ8I5wBmoW0x+7Jyd8OXs1e2/zzjgY2HI/W++FopjQcQRiqjudEVwX2/TnehUtbuE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478809; c=relaxed/simple;
	bh=K2z/fR51kTT3/BrkdO+ie7/VFTaJhBMcYuMX13OIKVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRKViohPpzn2bl+gpq45/Bg/mUuSqyKkWaPYZuvAAHYY+c2qZWcZgjsqpOPldYV5ALEBlaNztSHLRl1c00Qr+K91gv77gDXTh5UrkZ70TI5tOP91RvHZKQgY27ESxQerwNcypbHuZFsgWy+XcMYJ4pj+nliG1DOU2Pr+cJ8CCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afc911bce9so288172137.2
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 01:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478806; x=1734083606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTQrYSm8c54m53DHwKmHTrgTLFD9jbSf30Kj2Pa8fT0=;
        b=t+XzFY6J59Xbh/FgAkZK3R4BWNdRjcmAh9JFhFZT7wZHmw3Vc+Cg9LD6Ri3tOF7D66
         NdjXBmcs/7FpFDNmHX2WzFqbpsBl67mLrWQiiZ5WUkO5XBYPzFUYRONeoCVRQGXJzHzc
         oEcPy8NQKH2jSrTbgIxXC+H9qDoqovKdz3DCCyZmI1mPbYYk2L4Zbg+k3PjDWQEJHO3H
         3ZHbM7IZw+AOwFi8RociyVljyCO3OFVAsQWYxAinnZos4N1QK74jRR3fKG9P1U5CU87D
         bOaQ3+fpIqFV9rD4e+cDU++AQ5BWPfmuZJp2Djvma+TlMoGDrnzFGssxSTGrla1MIT4C
         Nt2g==
X-Gm-Message-State: AOJu0Yxm7vD4PWm7EWjlavrq30hryIoYSaJN9EkxWxIgABn3SfXtLJ+f
	lc1ScAKcmvVp6ZlGAlElOO7GhsjG1U24mpGjQlA5Qh67WINbyYvy2x7z7lFo
X-Gm-Gg: ASbGncvrG7nVAk0oCa/1CpY3SGT60CuUmonGGSXl9ZWeFmTbCGIu4HVDPayedENctz2
	rgrCExFORKtgsMHMTz2GgisEzT7tyITHj8E31bNNOO77wo7b4k25C772EyMyI8XvxaBmQhAFRGf
	aDup4ececNsdFeDK4emgov/fSd4CP5EWHMI0jN9mYgNsjn41btZp4foQbFib4TDtcr2qx9qqiaG
	g/dqmKaS0JvPtsxAslf92Jg1iDf/IYeUUytbOhRvhzaYn0VRihfSUjc30iqNV36e325XvCFMmBl
	SCYIVfI+QIzjIY5Q
X-Google-Smtp-Source: AGHT+IGSb3mrItLhnn+dZOgCfBocQ3vylrxjiAu9JKKoIzS2CK0y2gKoaNKfUFPcIfOdd400xjI0Mw==
X-Received: by 2002:a05:6102:2ac7:b0:4af:2eb9:46f8 with SMTP id ada2fe7eead31-4afcaac5a7amr2748170137.22.1733478806294;
        Fri, 06 Dec 2024 01:53:26 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2bdafa18sm397143241.35.2024.12.06.01.53.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:53:26 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5152a869d10so560693e0c.1
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 01:53:26 -0800 (PST)
X-Received: by 2002:a05:6122:3d41:b0:515:3bfb:c7b7 with SMTP id
 71dfb90a1353d-515fc9cb09dmr2515903e0c.3.1733478805840; Fri, 06 Dec 2024
 01:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuMnDvMK-4PRmyOk+KKFONrPPwRtFpnAVtUPrmQhcbOfw@mail.gmail.com>
In-Reply-To: <CA+G9fYuMnDvMK-4PRmyOk+KKFONrPPwRtFpnAVtUPrmQhcbOfw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Dec 2024 10:53:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7RwVCbubxw_-=4-zHvGjip0oZED_DLmY=C9BNAmoyRg@mail.gmail.com>
Message-ID: <CAMuHMdW7RwVCbubxw_-=4-zHvGjip0oZED_DLmY=C9BNAmoyRg@mail.gmail.com>
Subject: Re: stable-rc-queue-6.6: Error: arch/arm/boot/dts/renesas/r7s72100-genmai.dts:114.1-5
 Label or path bsc not found
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Mon, Dec 2, 2024 at 2:04=E2=80=AFPM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
> The arm build failed with gcc-13 on the Linux stable-rc queue 6.6 due to
> following build warning / errors.
>
> arm
> * arm, build
>   - build/gcc-13-defconfig-lkftconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build errors:
> ------
> Error: arch/arm/boot/dts/renesas/r7s72100-genmai.dts:114.1-5 Label or
> path bsc not found
> FATAL ERROR: Syntax error parsing input tree

I guess this is due to

    commit a670e8540da2de723c0eae14ef8234b0ada6b542
    Author: Geert Uytterhoeven <geert+renesas@glider.be>
    Date:   Thu Aug 31 13:52:32 2023 +0200

        ARM: dts: renesas: genmai: Add FLASH nodes

        [ Upstream commit 30e0a8cf886cb459dc8a895ba9a4fb5132b41499 ]

which depends on commit 175f1971164a6f8f ("ARM: dts: renesas:
r7s72100: Add BSC node") in v6.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

