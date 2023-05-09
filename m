Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB226FCE8E
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjEITao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 15:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjEITao (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 15:30:44 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79BBE52
        for <stable@vger.kernel.org>; Tue,  9 May 2023 12:30:42 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-77d0419750eso1652461241.2
        for <stable@vger.kernel.org>; Tue, 09 May 2023 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683660642; x=1686252642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDoEr8WUcosWAB75TDES0XOSAOF70d3PYdw53BsU/vk=;
        b=ZsEvVKJUooBL3kBWnwS/yGvHSKL06QhfHH8U9mp8k1NQa6oiAay5POTOjtD2MEkkVs
         CnY0SjzBIiU/I4j4tZ3I0LBw6QO1tMsqnHUOAcyZ4UpLVVocmb7dNXei4KLphxWOZfyN
         0/+wPgLft0o3PZ6+7cNysdw4C1gsZe+uOtpauquOYh8F3ZOkJ5pynm6mmpahCAi5Flx8
         AUFhcDQVyFpT2keS7OPJmXQT1OMFd9KjWj8c3gxRRx5vf44Yu8/a+uQ70AL106SKBDF7
         2b2yluloOXQtUrtfdj/c9MFYTmaD/jfG+r749/E/ik5Ic5bWMCpGxX1znI02jwSPTz/g
         RXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660642; x=1686252642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDoEr8WUcosWAB75TDES0XOSAOF70d3PYdw53BsU/vk=;
        b=OZPNvUJWzOx5DuV+v1sC53swOxfXQ8+xAjNZZOMR4MJeqeR4puxIa6DbXaoi2HFbI6
         ALDPLyBqD+L84vQAF9B+Mtj3q0tU1fnO9BrqESq77NcF37bOv//EAdeYyhmI5rJit4xx
         J9n4qBusek6dwBjJrw37WQX2WoI7ADQ5DjqBFnRhG59/DKT4uVcGoRgYK/b6LLTTTBr/
         H5omOSjtB5Le3awxe2lpL+mkB5WZcZy7IPQOH3lxXx7OoKMmlXXkCFQPJadL9M+g4SH/
         igGBMj2itLd1Dt/1S0D2Gq5DYREpf0tyH69GG3g5A6R5x1FgIXnTQ0273ERBQ8d25QcR
         3LQQ==
X-Gm-Message-State: AC+VfDzbdk3tYilXBN9lEWQuJ+CN/D/Z+NUBnwrzk3LvhbU78FYB4khT
        VlMPgbSwmrY9QdZVbybTnnFLs1W04pJ00frqx4vihA==
X-Google-Smtp-Source: ACHHUZ5fYrN1bZ1MeR0WEVPl0NR6Kbq8GyLkmS3HqomWcgnKMgebrUFYqSL+BI/lDoWX3+QFhnJCEqwg1ULmh/7Lxls=
X-Received: by 2002:a67:fd98:0:b0:430:e0:ac2e with SMTP id k24-20020a67fd98000000b0043000e0ac2emr4792589vsq.15.1683660641705;
 Tue, 09 May 2023 12:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030705.399628514@linuxfoundation.org> <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c> <2023050913-spearhead-angrily-fc58@gregkh> <20230509145806.GA8@df3c0d7ae0b0>
In-Reply-To: <20230509145806.GA8@df3c0d7ae0b0>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 May 2023 01:00:30 +0530
Message-ID: <CA+G9fYuCLSuPchYoSfqnu6y+CUV+Km3TVFr1NhGj0dik-ScEdQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 9 May 2023 at 20:28, Rudi Heitbaum <rudi@heitbaum.com> wrote:
>
> On Tue, May 09, 2023 at 03:56:42PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, May 09, 2023 at 01:10:32PM +0000, Rudi Heitbaum wrote:
> > > On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> > > > On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.3.2 release.
> > > > > There are 694 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > > Anything received after that time might be too late.
> > > >
> > > > Hi Greg,
> > > >
> > > > 6.3.2-rc2 tested.
> > >
> > > Hi Greg,
> > >
> > > Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors
> > > with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.
> >
> > Can you reproduce this without the extern, gpl-violation module loaded?

Please share the steps to reproduce
 test case / Kconfigs / device under test environment / firmware / boot loaders.

- Naresh
