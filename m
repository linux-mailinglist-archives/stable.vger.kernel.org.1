Return-Path: <stable+bounces-3846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0C802FC4
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9AF1F2125F
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9711EB5E;
	Mon,  4 Dec 2023 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdijNWDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7626B6
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 02:12:04 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d74186170fso15240137b3.3
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 02:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684724; x=1702289524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkXCJmkJqeWYd/zTDegc9H+KdUDHav8RTJQmS9NsaoM=;
        b=pdijNWDg+EvF4M+E/eR+fO8vHSzs56sKPbroIQ82r2KrpnRIpbr585JuRmMdGOlYic
         dSQVHPVOqlMG/8GGhZACEqT+rTeXhGH/Sc4oVQaNAtON9D04Fj2QiAMnCUubvqnrDeC8
         m1XaMPqk94xIdU1FxH2e1Pj5Ly9+LCAxdW5TqxMSQEJY1P66QgdjYruTwb/hZHXGGw7i
         xkP9iljc2R0D/8sSIE2tKRXzvj0OI/oTyQignNjo936QEHVqc97OquC86TSv6fZ1yHyW
         /r0fKd2UcciqWqjQihe/WYuAgHg7492tirpLgEOOr5HJdUdy4Q7PEx4agp2tTnIzpe6F
         PmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684724; x=1702289524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkXCJmkJqeWYd/zTDegc9H+KdUDHav8RTJQmS9NsaoM=;
        b=k1VBpCG7Nxu/fdSbYAVhdzxTsBkoOB9cP6EK0DhJ16+YES+Z7MejGEY5i8TO//yLTN
         cea3nDCSkbY7n8PbAPZEZJvTmU51iXLn61dwQg6v0oN/spuyTS7XWyhk7dDN8lUCZQXY
         6qXI6aCzUFwHhUy0wB816i3i/k5QOWqG0IjAduHRovUbETvd2eQvivEnGbc7Lox6BUx8
         ++akM1cAMP153NqV2U0z37bgIvIYbGPmrtMtmYurHbGr/qhuHfszH81t4jB4z7z7+b8F
         6wj8SrDYn8AWNa9nEje3ADuXw48CVYc/O03hPGEyLc3vxa9KxLlQOFIOe0YdK12pyhxa
         fXZQ==
X-Gm-Message-State: AOJu0YwgPyW3/WhWEDyHDbd3P8Ng6UpIQ9ATb7uY+jPhfJVFHHL3mUzv
	+VOpEv/YUJz+l8OtbY589MYZGWvo3yJ/azK87oM9tg==
X-Google-Smtp-Source: AGHT+IGRANTbZfpazl9zXKPI4jec0JQ5yJYaczShvgjPYYPvjqQ4flRZIPO2W6QsypTCTLuCTwb1KxCPPFCYFMYJSOE=
X-Received: by 2002:a05:690c:e0d:b0:5d8:10a1:f504 with SMTP id
 cp13-20020a05690c0e0d00b005d810a1f504mr1121233ywb.82.1701684724084; Mon, 04
 Dec 2023 02:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
In-Reply-To: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Dec 2023 11:11:53 +0100
Message-ID: <CACRpkdaSeE84VNhYmgnhEOJAqiDfVjFbhZSXCMeUVeGiNFz+BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: starfive: jh7110: ignore disabled device
 tree nodes
To: Nam Cao <namcao@linutronix.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Huan Feng <huan.feng@starfivetech.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Drew Fustini <drew@beagleboard.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:23=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:

> The driver always registers pin configurations in device tree. This can
> cause some inconvenience to users, as pin configurations in the base
> device tree cannot be disabled in the device tree overlay, even when the
> relevant devices are not used.
>
> Ignore disabled pin configuration nodes in device tree.
>
> Fixes: 447976ab62c5 ("pinctrl: starfive: Add StarFive JH7110 sys controll=
er driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>

This patch (1/2) applied for fixes.

Yours,
Linus Walleij

