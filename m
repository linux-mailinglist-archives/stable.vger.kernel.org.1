Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F56FF3E0
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjEKOTc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjEKOTb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 10:19:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BF9170D
        for <stable@vger.kernel.org>; Thu, 11 May 2023 07:19:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so79823598a12.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683814768; x=1686406768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/W5GB4E38fHdQpL0SzJkoknJdNzqLnuSIkNSr13Ymk=;
        b=RSDHREpAcYSI/HiA9jG4HfyGuqu8emlmGKaiyNbYoEm/449/U+d5jLKr0N3HbDhrFu
         Eq7KapRhjPG9gz+JhbrNON5QWOHN3yZn3bHoLzL5qWlBBfz2D78ujJZOm+lsIYwhz+5Q
         ZKnwi+0oioOzmlbW/9Vvel2zp5TgJ4jM31y74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814768; x=1686406768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/W5GB4E38fHdQpL0SzJkoknJdNzqLnuSIkNSr13Ymk=;
        b=VtdtNpMzHEwPW30IGQsj6maVQbS6R2GioKZEisX7S4TAnpPEkphm8Es/JZHNOf7cOH
         TIqELnvrak/tKAkqvde+KkwZY0Q37Rx3VmKa+u7tbvkVzlBO0+hQLDZEHKwgqEw7i4D3
         1zHe/aiFJYT6WTdWcgIvfXG9hIMPbAJnNI9MSVIMXOKoER9gOVact+O2MDwna3xCLi/u
         6jgnLZH519SBaH4rCxHF74WybfHwmlSo9EWZjIikjd63yuiQ0BvLnfvFY6+JgHpFCZce
         1srgUTlHdqcC/r2ouBBUc5Fak8DzeMMH3+G+pl9BtszD69NylaMDGCaIs2o/H6UnAVlr
         0m8w==
X-Gm-Message-State: AC+VfDwTc5Qzq7i8upOnBuE89jYiISNRmUR39O7+UUERsR6xxWZ7mpnH
        JpCTJEcWuEsiVsj5G/wbaNKlhTt5OvC6sZxYnRyigQ==
X-Google-Smtp-Source: ACHHUZ6urPcdbf088mGr3uAcUb3cUORMUhJrpba4j63k04EYnjuhvRFo9FMg9mvdFjaMtwdR8goR9w==
X-Received: by 2002:a05:6402:42c6:b0:506:b94f:3d8f with SMTP id i6-20020a05640242c600b00506b94f3d8fmr20429678edc.5.1683814768489;
        Thu, 11 May 2023 07:19:28 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7d418000000b0050bfa1905f6sm3079098edq.30.2023.05.11.07.19.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:19:27 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so79823250a12.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 07:19:26 -0700 (PDT)
X-Received: by 2002:a17:907:3ea8:b0:953:37d9:282f with SMTP id
 hs40-20020a1709073ea800b0095337d9282fmr18146763ejc.38.1683814766379; Thu, 11
 May 2023 07:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030705.399628514@linuxfoundation.org> <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c> <2023050913-spearhead-angrily-fc58@gregkh>
 <20230509145806.GA8@df3c0d7ae0b0> <2023051025-plug-willow-e278@gregkh>
 <CAG9oJsnr55Atybm4nOQAFjXQ_TeqVG+Nz_8zqMT3ansdnEpGBQ@mail.gmail.com>
 <2023051048-plus-mountable-6280@gregkh> <CAG9oJskrJotpyqwi6AHVMmhnFmL+Ym=xAFmL51RiZFaU78wv-A@mail.gmail.com>
 <2023051132-dweller-upturned-b446@gregkh> <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
In-Reply-To: <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 May 2023 09:19:08 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjJNHjwfrT0X5DvSP3fZzUF0SAbErkc30qAWDW=U9uKtQ@mail.gmail.com>
Message-ID: <CAHk-=wjJNHjwfrT0X5DvSP3fZzUF0SAbErkc30qAWDW=U9uKtQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, ntfs3@lists.linux.dev,
        almaz.alexandrovich@paragon-software.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 11, 2023 at 3:30=E2=80=AFAM Rudi Heitbaum <rudi@heitbaum.com> w=
rote:
>
> I have run 6.1.28-rc2 today, and was able to trigger the error. So
> definitely bad in both 6.3 and 6.1.
>
> [13812.020209] BUG: kernel NULL pointer dereference, address: 00000000000=
00020
> [13812.021322] #PF: supervisor read access in kernel mode
> [13812.022346] #PF: error_code(0x0000) - not-present page
> [13812.023591] PGD 0 P4D 0
> [13812.024876] Oops: 0000 [#1] SMP NOPTI
> [13812.026088] CPU: 5 PID: 20386 Comm: .NET ThreadPool Not tainted 6.1.28=
-rc2 #1
> [13812.027336] Hardware name: Intel(R) Client Systems
> NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
> [13812.028593] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]

I suspect this is fixed in mainline by commit 6827d50b2c43 ("fs/ntfs3:
Refactoring of various minor issues") which changed the IS_ERR() check
into a IS_ERR_OR_NULL().

But dropping the original fix from stable might be the right thing to do.

                 Linus
