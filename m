Return-Path: <stable+bounces-3847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB387802FE8
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EAE1F21363
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89AB208C0;
	Mon,  4 Dec 2023 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb0AFZ2L"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05BD85
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 02:14:23 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so2161437276.0
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684863; x=1702289663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6T1DQnSXHpRdTd/LbBCSLbNlM8eSq6nAzUcVYf1VEk=;
        b=Pb0AFZ2LmsJ7dhpXT5xnsH5/wNR4NZL7It5bY7zdIhPvjzwTxUctt23r2ApzHk3XG+
         qXUKWHtpUBj6d8lhh2axjGxozUAJqwDtcVNuJYd9/eSGLrnWX/bKRQOjzT/aTOjceabB
         pTIKfb33Sq98Mok/ZTO3/ELKjS/0xHs6ET5q4sApNqOi9mXNkxV0pkhZhVIptZ5SOO/i
         um/wAtfPqYXuQW+/i2HwFPLkrwC0TL/OMjoR2guMhdVIXs8sEzPt9tnTAyZy51eNGVEZ
         OC6ceHSLyqF8FdtWtkkK4zuJtakngf3Q7Ii+fdMa99GL4fNFjM/I3yG3rxbCCPUJcCyS
         Y/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684863; x=1702289663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6T1DQnSXHpRdTd/LbBCSLbNlM8eSq6nAzUcVYf1VEk=;
        b=RsERw+geegRwfZvCdjSOMVRbYw3T3wAGGVEOCmVxt7bgFi7H2AEldt4HNV9DZ2fzCJ
         dlqq1YJu74/tttA91Bfl1xfeehpKvT1MEPIQvje6CcGYHRsesQJNpDUqsDIBU0fHoA5c
         KEcB7dDg18ooAB9eJ6URFBSNyX5nFH278i1SpTAOdORmDRRHcp61dxQ96SJa1m+E6X8I
         vYs5uGMCsJh7QdA98H608lzWByvf+ksU1gGATuxDKBpQkaHNL1r3SfCoB7EnYiJwYor/
         aqjFTfkp0S8TOXgxjwcgWO6IV69AeOkSCYZGp31NGAyWt/QXtcWQwLb/rHU71iqjXDf/
         EV4w==
X-Gm-Message-State: AOJu0Yze1Gbeyft0dw7DjdhwuRzgRc80rIJBtY4V993M2l0a8/JPF8u+
	AIhV2++9Nn9YFOm2xGH9ADVpgaaY0jO5k2qNEdzrSQ==
X-Google-Smtp-Source: AGHT+IHhuDurJ8RdbjXooRiGJLv52npQVT6/Px+lFRxxtrp8WQLTQQplQz795ifTJ1edDRCXEJYqWVyVZzD1Wpcw/tw=
X-Received: by 2002:a25:6f8b:0:b0:daf:6330:cc1d with SMTP id
 k133-20020a256f8b000000b00daf6330cc1dmr2323965ybc.24.1701684863177; Mon, 04
 Dec 2023 02:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
 <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
In-Reply-To: <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Dec 2023 11:14:12 +0100
Message-ID: <CACRpkda0wdVgwTjX4bF411TEeZ96H+sqZVXaVgh4d5S2Ek_eZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device
 tree nodes
To: Nam Cao <namcao@linutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
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
> Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive =
SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Patch applied for fixes.

If there is some doubts about the saneness of this patch, seek input
from the devicetree maintainers.

Yours,
Linus Walleij

