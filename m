Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F47911F2
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjIDHUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjIDHUQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 03:20:16 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B843E99
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 00:20:12 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fba83feb0so10194677b3.3
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693812012; x=1694416812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVOEVpMaoekM7L0xljCDotcOxhGyaUbiG4e0eDC6Xnc=;
        b=Ve4VCO7Tajl4s7MX+VDO5myOhh/qfLP5yGsWXF4vlTxIzl0ypBt4ukE8tjTXqWvdpQ
         rm7bhEcAj9Dr7wL7Krw6qHnA3QTOKmYhd1CwULxECFJPe6GzfGE2aSvzAK6akrVIqG+u
         x/dpV568pvdlpCfvjrXWTI1wJ9edqWzGXui1i88sdik7bRalNo5Kqa7S2vTIDAE7LjxZ
         CLyAi/yVNPimot4MpzR2AP0lWXy+EYYnCvrBd3CPmh4uzAbcUDASFpsj8HMp4Apy/SNb
         8KtOQ//rPP+yydSiulHjtYlXIqspBQFLPzu4WUjq9ullsluCm49+3k+7Ii9MOvWinjiM
         XMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812012; x=1694416812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVOEVpMaoekM7L0xljCDotcOxhGyaUbiG4e0eDC6Xnc=;
        b=H921n9GrUKxBZydaSAT/apSrE3xDAYD7refQB5TUSKGYfcl76j7eJUVlWwiz+pBP1s
         buijijf9cN6Ml3w/fxsdAI87VY98fFAwOHkafVZC0wl2M5j/Z5i9OGApyKSN0RikxtYE
         W8yBbf1HR0WeayWpWk6on+PEVOJAG7GFBIimYUZGL2PYrKkcRV49OEB8LHIf/afhqJrr
         mf9oTdJ15h5/uKWMS8X+fHRFKpgHvVo/GZ5NxHHQIVELh2Y7DEsK/hrBu0+1WYdXBAw/
         +XOqhLhZVhjcora4HQCUQhw0gVRSUyBrPoL7nNuSwNYVUSodIoRJ/+jzuuza7B8aCnN4
         rWOg==
X-Gm-Message-State: AOJu0Yz5qZjuh0ZZhzcWm9QGpf1UkJbhiPs1Z1Y5u0drU1aOw7BbKgO9
        ILFhCCcZZzAcilSpC4S4Otd+6mtuFOYZorR0YzqxIg==
X-Google-Smtp-Source: AGHT+IEbGJK+h7cq5GXslgX7oM0SreiM3Vehdc7qyQL9KvWApDvloCmpQgvCxXWmHw5pUPn3nbXFQb6wAZoVCO4+AUY=
X-Received: by 2002:a25:db8c:0:b0:d07:5b87:ec56 with SMTP id
 g134-20020a25db8c000000b00d075b87ec56mr9071474ybf.14.1693812011998; Mon, 04
 Sep 2023 00:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
 <20230903171056.41-1-bavishimithil@gmail.com>
In-Reply-To: <20230903171056.41-1-bavishimithil@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Sep 2023 09:20:00 +0200
Message-ID: <CACRpkdaxNBeAVV9514ixJANvNVarja9GC3Xxm5nFNZUdmze5eg@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 3, 2023 at 7:11=E2=80=AFPM Mighty <bavishimithil@gmail.com> wro=
te:
> On Thu, Aug 24, 2023 at 1:54=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
>
> > Seems reasonable to me!
>
> I'd say I send a patch to the mailing list and see the response, I'm not =
very
> experienced with this device. The inputs of other people who worked on
> this driver would guide me in the right way then i guess.

I sent a patch, it's at v2 already, sorry for not notifying:
https://lore.kernel.org/linux-iio/20230902-iio-rescale-only-offset-v2-1-988=
b807754c8@linaro.org/T/#u

Yours,
Linus Walleij
