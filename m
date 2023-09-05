Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139F4792498
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjIEP7P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354933AbjIEP5D (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 11:57:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2C12A
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 08:56:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bdcbde9676so2182650a34.3
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693929418; x=1694534218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThqjLVnbKtocXxKP/wk16gVb0uDcHwyfytUbqO9ZePQ=;
        b=5wuk35+Jnsmfdfk8pT0uMAGpahZOfRo0q7Tlf9UcFAX+5U1UtY2iZYPFeAdnHPrKpS
         1Fimpi/xHbzTFXzUEuxYKPFNaDckzkdRjDk95ohoNTBG2+Fljxd3izUlgA60x8ri9qZo
         BgD992XtaGoxFmkQwFYygrgqA2oBVN97Rz0jNgRCMleuequLJTsmT5LLbZTQQdNFJVEl
         4dQ4i/wIkIwSZ7wxe72d27UbR0JJgZss0vBmqTJX1jSr43sdGuI4kYIPK5ADxjmOoXzV
         FgzpU78XEWN9X6DR9zG0bS/wzZgVmPNwgvuRcOvAlCpzL8LllKRwW4LvyGs2RxfZkTjg
         tSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693929418; x=1694534218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThqjLVnbKtocXxKP/wk16gVb0uDcHwyfytUbqO9ZePQ=;
        b=D1/gYswo5tmwG4DzKvsGhTn68cxUnJnJzeDv/Si61GY/DmNWLJmFWdzfgT8S4s31oZ
         MzbO6Fx4gF6BpazSnCTh2cDWU98XfZ/I/DYV+y3F2mryE78mduvzMCxQZ9mgfPevSpOh
         PtbAtcbOCyPSYaUMc/TFJmFWVju0tfOGMYgQU90boOsS9XVf+wYStQrppBU5TreI2IH/
         4FT6g+OHk3jCNOHAkk8D2lDidYhEqyAthMqwbU2sS38a2g3ERAA21KI1YyA27gL6kymk
         vvIm6cJmnrRlr2gGkqfzFZm9BXnAsnwMHsfGPLQNEn1dWRsRB4O18nx9rADY4ulnyWoJ
         JKpw==
X-Gm-Message-State: AOJu0YyhecdTViHLJ9fFl06teWvF7Ju26f+Gn69dcVstfKEpocffbwEW
        umOu5bnLDSLd3Jgh++Owk6d7mXOcNMo/LMV6r3iVYg==
X-Google-Smtp-Source: AGHT+IEykypgti740Y9Zguj1KwhddZ/MtrTqVC7bHeDUfNC7kmbpd/QpzCpX/NjATKNPnssd70RGnfMB2COzAW39eKc=
X-Received: by 2002:a9d:66c7:0:b0:6bc:bc3e:f40b with SMTP id
 t7-20020a9d66c7000000b006bcbc3ef40bmr14551486otm.19.1693929418610; Tue, 05
 Sep 2023 08:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMzR4830pmUfWnwVjGk94inpQ0iz_uXiOnrE2kyV7SUPpg@mail.gmail.com>
 <2023090548-flattery-wrath-8ace@gregkh>
In-Reply-To: <2023090548-flattery-wrath-8ace@gregkh>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Sep 2023 08:56:47 -0700
Message-ID: <CAKwvOdnUdfG9=P0gaUxou-xYB24sOzF+HhPrm75EWLETOViuNw@mail.gmail.com>
Subject: Re: Include bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute
 checks") into linux-4.14.y
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, llvm@lists.linux.dev,
        linux- stable <stable@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        eb-gft-team@globallogic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 5, 2023 at 3:21=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 05, 2023 at 12:12:11PM +0200, Lukas Bulwahn wrote:
> > Greg, once checked and confirmed by Andrey or Nick, could you please in=
clude
> > commit bac7a1fff792 ("lib/ubsan: remove returns-nonnull-attribute check=
s") into
> > the linux-4.14.y branch?

Seems fine to me (OK2BACKPORT); I didn't see any follow up fixes to
bac7a1fff792.

>
> Now queued up, thanks.
>
> greg k-h



--=20
Thanks,
~Nick Desaulniers
