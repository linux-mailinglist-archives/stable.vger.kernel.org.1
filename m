Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D516B75573C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjGPU74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjGPU7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:59:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414C10F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:59:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-cb7b6ecb3cdso3537052276.1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689541194; x=1692133194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnCUhuc6/jksrUiWuYIP+ADB5dignYd5LGSVOcuDu3s=;
        b=zpbkYyFC5UickzqgfC2zdQp2NFs2QaB+iB7duhaz4f2edqTmksEHEGsPgJqL8/rVQs
         VjqvLC7TBz8xAEH+MsfGAWfeSHx/N/1zJ5NXduQzxTaT9LF1U3kcF/nWKLbn7is6oghu
         v/lHcwIDWsN24g/9m7OipEVC76TcJMszLWBsBmmx77PTuwp2tZNAVai0ErXseepQK7j2
         G/acTtuJdP/nMs/ik/ZYTWHxRMKyHNIVqktsHIb3UoXNDX81LgNDjQ2J5ed77xwhvx+h
         DQboEe5SI41UU5kExdZ5HiSn2082tRnL/pMQtq8lIC/SF6Sfc+JIxzuwFFu/Hn1WeAoV
         2ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541194; x=1692133194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnCUhuc6/jksrUiWuYIP+ADB5dignYd5LGSVOcuDu3s=;
        b=MUAYbFOBPps1j4Ku6EBXBctd13KmcrxYQ986FsB5HIQRIg1V+9ar3IM2t5hIGRjWZK
         nGUnKVoT0TVjYoB2ztRbtz8G3ypCIs82NCD5wvtzkRpFuTJobM1/89ZZh2LHSu7I3TLs
         mBhO7PYoyXC/s1yuW+7xrtxU7R+kCY35FTmVGfc5xHGtVOhdiGoEiL9/F/x5T3O6fZi/
         1yiJScfpzVwkznd8GtynoLROw0zmAxXKmxCPPANFoQCMWE9hMuBrC3UpuaFVAtYzxQ0E
         0clR1KDigpjEnTSHa27uXcyNshlnC4on84o67W9OA89rHr1IWrsa+HOCaTuRPWsIzYUR
         H43g==
X-Gm-Message-State: ABy/qLaQtyQUNW85hpLMcja33DldOaJ1nAOBjpmPlvJwB7awaEsGY7sR
        vOM54nGkTPaELqpgPN0LQzfD5G3wxudooq9VdxVP+g==
X-Google-Smtp-Source: APBJJlHBKKnuT1m876CXFMUYhRj/PSYNHCSNh2P8HK+3zVoxjz+7U6x5WzLDq+3xDuKmtzKjGJPTc+BB3ptx8k/nwkE=
X-Received: by 2002:a0d:d647:0:b0:573:2e7a:1733 with SMTP id
 y68-20020a0dd647000000b005732e7a1733mr11881495ywd.45.1689541193986; Sun, 16
 Jul 2023 13:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230613213150.908462-1-linus.walleij@linaro.org>
In-Reply-To: <20230613213150.908462-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 22:59:42 +0200
Message-ID: <CACRpkdbp0STSKxBG6qgpqu=xg0+-zAdK2se11oKhjD9MGQZ1NA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: Set typing and props
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Stefan Hansson <newbyte@disroot.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sebastian,

could you apply this patch please?

It's a regression.

Yours,
Linus Walleij

On Tue, Jun 13, 2023 at 11:31=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> I had the following weird phenomena on a mobile phone: while
> the capacity in /sys/class/power_supply/ab8500_fg/capacity
> would reflect the actual charge and capacity of the battery,
> only 1/3 of the value was shown on the battery status
> indicator and warnings for low battery appeared.
>
> It turns out that utemp, the Freedesktop temperature daemon,
> will average all the power supplies of type "battery" in
> /sys/class/power_supply/* if there is more than one battery.
>
> For the AB8500, there was "battery" ab8500_fg, ab8500_btemp
> and ab8500_chargalg. The latter two don't know anything
> about the battery, and should not be considered. They were
> however averaged and with the capacity of 0.
>
> Flag ab8500_btemp and ab8500_chargalg with type "unknown"
> so they are not averaged as batteries.
>
> Remove the technology prop from ab8500_btemp as well, all
> it does is snoop in on knowledge from another supply.
>
> After this the battery indicator shows the right value.
>
> Cc: Stefan Hansson <newbyte@disroot.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
