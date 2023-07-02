Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C477452FF
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGBWp5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 2 Jul 2023 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGBWp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 2 Jul 2023 18:45:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0D1B9
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 15:45:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so57595681fa.3
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688337953; x=1690929953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rbSGoMaDXuLTUnz0WGxSI7CF/z5suPv717y+50H5ixI=;
        b=StspcepUYcEgcCUtJ4IwnwdxoNsUWnZMTNCThy93R7sGFKyZ/R58wVWcf73ERAPggm
         z9tW8saRzj3UyHj45uq+vqksU4sOENZyv4JHdHWP8FVL/Cfxl769B+p1DdnRQnXR0KNU
         WuwbUyv5Xofh8zkMERcfkj94nWUrYCsQkYsFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688337953; x=1690929953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbSGoMaDXuLTUnz0WGxSI7CF/z5suPv717y+50H5ixI=;
        b=Rk3qxT6UvX3rbQOzMe9XgPxSzTiUCPnyM7C+jZ9i6ldflBYrc8r9SGochHfv/HufmK
         VREUuP7QdeL/VcpMU7YWa/ubNCf2j0IElUg7458UBFGDKH9XM+BEheFx32/f4gSX+5Dq
         pl7Fl38EDVmN394oxcGBcn+8C2vmDlyg65rnWQginrInDYocY8AV1y2dZdzyhKkWoKFR
         dB8v4hOqBZi/aGqjanJ80eGbiKQjC0qEqsP7AbiQ8MtrtihcR20bp0Hiw6KSJxuz05GY
         b+dGZlebjEHDZzef2RKHXZ8+VEYRtwRvtissyefJAl8zZrV6zS4EaAhGpPfCZCS/oyUU
         7t3g==
X-Gm-Message-State: ABy/qLZWctNeyuaFebRCJwfcjOfzm2lg6H/30hItIcwMKn8bYcNMMXQH
        +bo2itQerO9idEfmCA6gvwWErXS+hKjoj39iRunFwp49
X-Google-Smtp-Source: APBJJlFdIk8/UKtMRXvJodrbooQZtt0DLf538Oa7uE8NdmpFxzMp5VcEiVH7QlDJSZtrpqM7o6egzg==
X-Received: by 2002:a2e:9059:0:b0:2b6:b611:64e9 with SMTP id n25-20020a2e9059000000b002b6b61164e9mr5270615ljg.52.1688337953329;
        Sun, 02 Jul 2023 15:45:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f18-20020a2e6a12000000b002b6a163b244sm4112270ljc.3.2023.07.02.15.45.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 15:45:52 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b69a48368fso57600731fa.0
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 15:45:51 -0700 (PDT)
X-Received: by 2002:a2e:7d15:0:b0:2b6:9f59:7b3c with SMTP id
 y21-20020a2e7d15000000b002b69f597b3cmr5360404ljc.14.1688337951675; Sun, 02
 Jul 2023 15:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh> <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
In-Reply-To: <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jul 2023 15:45:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
Message-ID: <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, 2 Jul 2023 at 14:33, Helge Deller <deller@gmx.de> wrote:
>
> Actually, your changes seems to trigger...:
>
> root@debian:~# /usr/bin/ls /usr/bin/*
> -bash: /usr/bin/ls: Argument list too long

So this only happens with _fairly_ long argument lists, right? Maybe
your config has a 64kB page size, and normal programs never expand
beyond a single page?

I bet it is because of f313c51d26aa ("execve: expand new process stack
manually ahead of time"), but I don't see exactly why.

But pa-risc is the only architecture with CONFIG_STACK_GROWSUP, and
while I really thought that commit should do the exact same thing as
the old

  #ifdef CONFIG_STACK_GROWSUP

special case, I must clearly have been wrong.

Would you mind just verifying that yes, that commit on mainline is
broken for you, and the previous one works?

               Linus
