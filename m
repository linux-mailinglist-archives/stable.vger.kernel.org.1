Return-Path: <stable+bounces-3654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61193800D25
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0210B20E43
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6E3D98F;
	Fri,  1 Dec 2023 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AkkS/ol5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2617910FF
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 06:28:32 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B6FA3F65A
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701440909;
	bh=J3tX3M2zYj5xzUQ87L+5qVD8j/S83Al/tHxvfxTDyUw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AkkS/ol59EXGAb+QsIO/byDT45l8s7RHVDq5Qku8XiCzKUPH4+ZsfaE1m3h/Izi9g
	 XFPzW74jIedKNmcw5nWkS0aejur4a3V59DqFIVaOhZ/qLjvTtkIDzbGxxPd1GLyOEh
	 GSHX8obFb97QRLlrdaUyamDeLyievNzmu3v5VI1P49jpNeRX7gcYu9h+6fT7L3O1FB
	 32hzkslUhfC0DH6j+YsVXZnCuxpe9X/go57MOpztZD1eygWguSgfuxsf2yeN0yFFkt
	 KXwC4iydgKmF5cLQQAxj79UkgSBtZOjvVALVYbVa+iB/AojdBg6HSkHZ0fJ6k1V0UB
	 aWQ3DoenkOB9g==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423f0943b2cso24551631cf.3
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 06:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440908; x=1702045708;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3tX3M2zYj5xzUQ87L+5qVD8j/S83Al/tHxvfxTDyUw=;
        b=By7+umscbQQ3ofJ3n0QwOQoLz62Y773IBGVd1fC6PRB6jtggAhH/AvuPLjUrsmbR0l
         xFSvKU0mvK+vu9XFU3joEis8tKvc9pJN9Ztf1sy+kZTzC7k1xoZYP2oL3RgpkNI1bTXQ
         8HnnnI7JUrxGbVfeCNJ4HjeWaQTz6ce5HB/ID8K7d+NPZ7lS+T7OfLQzGEXCR4ircmLM
         o6cxpTEurb3AIQo0+sql6l//z06TOgKU9ZvFZhy4Kt952+GiecfBPFLHuNk7uesAaHtE
         oogXgRBP1G4PtTYO8CNEUhkh0gjVuqz8KyEdeKii6M6M5Q6aHLj2nEEQaQJnfws+OZjP
         gPjw==
X-Gm-Message-State: AOJu0Yy6vXagidZ5u7PmR0KZWRfM3GiK5J+d1XNsIbpCIBUrdEbhaRfO
	PG9BYunk/yCGM0Acii9dtwTzCtXDR0enOBgTV6n4u1h2BAHBg63lagP+R5XIZgM9uwNsZRj2W4P
	rO5Z0Rmjrp7SulggeBUrJPwV9+ysAAm3ED3G/qWlx3b+UkVP1Ag==
X-Received: by 2002:ac8:5882:0:b0:423:74a5:2847 with SMTP id t2-20020ac85882000000b0042374a52847mr27370898qta.49.1701440908463;
        Fri, 01 Dec 2023 06:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz6QSK9JfIdYSeG1hMKcfp6BJsk9FZlcDEDSfyu1q6fE+aNUWQuhYy7p5rzkdPobcTPVTqnTSPj2jiq9s9GYc=
X-Received: by 2002:ac8:5882:0:b0:423:74a5:2847 with SMTP id
 t2-20020ac85882000000b0042374a52847mr27370879qta.49.1701440908234; Fri, 01
 Dec 2023 06:28:28 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 15:28:27 +0100
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
 <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 1 Dec 2023 15:28:27 +0100
Message-ID: <CAJM55Z9CooaYqeTuZK0FARKupf_StTSfWBo7ziv4KtGq6pEVaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device
 tree nodes
To: Nam Cao <namcao@linutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, 
	Jianlong Huang <jianlong.huang@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Huan Feng <huan.feng@starfivetech.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Drew Fustini <drew@beagleboard.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Nam Cao wrote:
> The driver always registers pin configurations in device tree. This can
> cause some inconvenience to users, as pin configurations in the base
> device tree cannot be disabled in the device tree overlay, even when the
> relevant devices are not used.
>
> Ignore disabled pin configuration nodes in device tree.
>
> Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index 530fe340a9a1..561fd0c6b9b0 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -492,7 +492,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
>
>  	nmaps = 0;
>  	ngroups = 0;
> -	for_each_child_of_node(np, child) {
> +	for_each_available_child_of_node(np, child) {

Hi Nam,

Is this safe to do? I mean will the children considered "available" not change
as drivers are loaded during boot so this is racy?

Also arguably this is not a bugfix, but a new feature.

Same comments apply to the JH7110 patch.

/Emil

>  		int npinmux = of_property_count_u32_elems(child, "pinmux");
>  		int npins   = of_property_count_u32_elems(child, "pins");
>
> @@ -527,7 +527,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	nmaps = 0;
>  	ngroups = 0;
>  	mutex_lock(&sfp->mutex);
> -	for_each_child_of_node(np, child) {
> +	for_each_available_child_of_node(np, child) {
>  		int npins;
>  		int i;
>
> --
> 2.39.2
>

