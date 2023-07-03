Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687874546A
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 06:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGCEMU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 00:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjGCEMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 00:12:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81918D
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 21:12:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so58162861fa.0
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688357536; x=1690949536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBnUTmfwj8DTmLsYwNeO+K9GBJ5hWqy0KG0bHBi8Ysg=;
        b=dToiNu9WnqVUFSEu+LzU2rP/TiOyYMSmK/wjwCHvNmem+5NgVo1IeDpoP1R8o86FwJ
         1KeQ9W4TAqJf1i1VtdLGcgXdJzjfXypPyp8W0OOPJQiCkH+pOCHBQbAsOxHiSLziqjks
         qsBFSNdcGDuLJbLwQqV949pzC6kLcb0pAEW9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688357536; x=1690949536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBnUTmfwj8DTmLsYwNeO+K9GBJ5hWqy0KG0bHBi8Ysg=;
        b=XXD/k8D+h+v+8ob+SYgmnurV0Eo0wsmLyq5pjBNrbACQrwFb1rVfArr72zSDh5bxUO
         cVSfg01/czVmfzVdo7T1jivZlV6lpEam263SfZ6FJspf2f6C7Hak9tYh7FlgMgazvmzD
         U5AfHAb2wB5D3OFfF4N/zwfKCEjwVbPvYx/8WBo7eKZqr18uJLr8FeKEWRlZQhjhWrxu
         UCKlY/ruYx55yCOPIOEfwsjraXfqAWvgixfb6jAyEbMeSWhAkRPgNFQnPbkjGvMrj+1A
         5gFt3RH7zP3SL3IOpkf+G8fA6qihW4Lwmd4lvrfMHiHo09bPhghMhzR/Und3mij5x+10
         HXVQ==
X-Gm-Message-State: ABy/qLY9F7iCvHJS3PXpU5YneygoE+GuAB9EUBCxU83lHN652MDu9uNz
        aoUegO+eIt3XXMkcO/EdPckdeyUW/dk5HfFTMM/UuXWc
X-Google-Smtp-Source: APBJJlGoBzNXY0r4yZhppnXAbnEPcFws3fLb519pJVwn1V43Doy/ok5Am9Cq4OLUD1qWHS5ua6gGlA==
X-Received: by 2002:a05:6512:360a:b0:4f7:55e4:4665 with SMTP id f10-20020a056512360a00b004f755e44665mr4974420lfs.56.1688357535989;
        Sun, 02 Jul 2023 21:12:15 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004fbab4b7d45sm1318898lfn.67.2023.07.02.21.12.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 21:12:15 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b6e7d7952eso8026041fa.3
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 21:12:15 -0700 (PDT)
X-Received: by 2002:a2e:95cc:0:b0:2b6:be6a:7e1b with SMTP id
 y12-20020a2e95cc000000b002b6be6a7e1bmr5153385ljh.49.1688357534559; Sun, 02
 Jul 2023 21:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230703012723.800199-1-Jason@zx2c4.com> <20230703012723.800199-2-Jason@zx2c4.com>
In-Reply-To: <20230703012723.800199-2-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jul 2023 21:11:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgStQOQ+rG1EQ_GczUbPQ3Tv39Eve=_39agf-jvyfZV6Q@mail.gmail.com>
Message-ID: <CAHk-=wgStQOQ+rG1EQ_GczUbPQ3Tv39Eve=_39agf-jvyfZV6Q@mail.gmail.com>
Subject: Re: [PATCH net 1/3] wireguard: queueing: use saner cpu selection wrapping
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Manuel Leiner <manuel.leiner@gmx.de>
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

On Sun, 2 Jul 2023 at 18:27, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Using `% nr_cpumask_bits` is slow and complicated, and not totally
> robust toward dynamic changes to CPU topologies. Rather than storing the
> next CPU in the round-robin, just store the last one, and also return
> that value. This simplifies the loop drastically into a much more common
> pattern.
>
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Cc: stable@vger.kernel.org
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>

Heh, thank you. Your memory is better than mine. That "Reported-by"
mystified me, so I had to go search for it.

March is clearly too long ago for me to remember anything.

I'm like a goldfish.

              Linus
