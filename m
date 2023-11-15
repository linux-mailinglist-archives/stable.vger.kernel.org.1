Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED307EC0EA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 11:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjKOKqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 05:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjKOKqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 05:46:51 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFCD122
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 02:46:48 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7b91faf40so77275557b3.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700045207; x=1700650007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROkFb04XM1IxjJN8kBBQDGZACqrnfUK4tYFptKzTTH4=;
        b=Qq+AUoDYOc0a0eZiNSOetS2+1E0nngzjuMOsneF5hIfylZiWdT9ZoP4aLDorF0DzHB
         t871xYM4WDv7BcCnOl/YDghEm9Jeo0nu8QB5bwwfjBvdL2uEQrs8E/WOTw1BYnUNm9dB
         2OpunecgX1tOn6KQ2KZ4POn2jk3yVP9+94Krp2CwjNEXwHHDKovgn3hWTstjuURXYmB0
         vu71QXY6q5RA1BGG0FfLUl3VIHV+DUKl4qii+Iyc0NLNpDDm8XXTebl8ejvdU/rgnZZF
         Y4bl7E22unXcwE68G2wRItJEa97GHfASywOCn1Px/AIXifq22TIC9FwSadMNhNb3Qwhw
         Eajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700045207; x=1700650007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROkFb04XM1IxjJN8kBBQDGZACqrnfUK4tYFptKzTTH4=;
        b=UyKnwHls3BFH4pICsyapj3QRTMFdXvtmtEmKvcPUo91czRyO2YZljsjc3V/+8lPcfC
         t7i4cHhjaLz9X5blL1yZUWksBD8bUW1QInVEj+ea3ph9DeeoStJAAemhII3YEvQLw+1M
         Dzj3ApW9Q81raAtn/2hXzphoER4iB315Qkp2ZCTH4KrAnum+b6UvuRdX5IziEKrBUiLi
         HyoH75UsMLzQp4upZrEtiX6l5dserQdNT7V4lMVRYHLfGguEq4hN/aH/7Dt7jgJt7hb4
         HTlt3D2/JUWc9e/EawshUOD6f2OB8U7oq3KtVbMm2c6ZgDauW1vb6TeM3lndEs6kKsMK
         K0sw==
X-Gm-Message-State: AOJu0YwVKCN4NgNfh+e2Di1ZS19743/soDRoHDtwFF3pmJ6iY14C2OZ9
        erdnXLWN6esWYBtT0vz/8c9ipmHZnR9dYiCA858JGA==
X-Google-Smtp-Source: AGHT+IEUbLlYafyuhZ0akVgaeOWZ9mraYETNvmBptaD8z/GiGg5l+TzCCQqzVTTRxBQyaw8F28Rsr3OoebuVLy7sAEI=
X-Received: by 2002:a25:6951:0:b0:da3:ab41:2fc8 with SMTP id
 e78-20020a256951000000b00da3ab412fc8mr11210436ybc.16.1700045207354; Wed, 15
 Nov 2023 02:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20231115102824.23727-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231115102824.23727-1-quic_aiquny@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 11:46:36 +0100
Message-ID: <CACRpkdaBWZyoshaOk-PPZ+gwnNj0o05RLyGNmpmhFez_s=A6Lw@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: avoid reload of p state in list iteration
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 15, 2023 at 11:28=E2=80=AFAM Maria Yu <quic_aiquny@quicinc.com>=
 wrote:

> When in the list_for_each_entry iteration, reload of p->state->settings
> with a local setting from old_state will makes the list iteration in a
> infinite loop.
> The typical issue happened, it will frequently have printk message like:
>   "not freeing pin xx (xxx) as part of deactivating group xxx - it is
> already used for some other setting".
> This is a compiler-dependent problem, one instance was got using Clang
> version 10.0 plus arm64 architecture with linux version 4.19.
>
> Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states per=
 device")
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> Cc: stable@vger.kernel.org

Patch applied, I edited the commit message a bit.

Thanks a lot for finding this tricky bug!

Yours,
Linus Walleij
