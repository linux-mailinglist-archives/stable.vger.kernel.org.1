Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1517EECD8
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 08:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjKQHlb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 02:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKQHla (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 02:41:30 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C76D53
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 23:41:26 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45db31f9156so667290137.1
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 23:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700206885; x=1700811685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCDUD/ayWCyYX+V5eg8ErxP1HhH1oV9OubP3STgdWNA=;
        b=rmyh5UxVTsrXdCrWkgVn4wvhuTQ50g/TCxmzM1HqPJz4Eo1jC9F3oaJPXP2Wmv9was
         cpaFUWmMzf5DLq0JmzYl9OM1AndOSJlDLR0ku9kC9IyhlB6i2AO45ND4CeKE6OaTxoCX
         62naYF01T90yZFf+4UMqyXLNLZduAtJfdfuaNmBgJItx2eTpbTrkmrbbDKtzkmP0fZkE
         ddT0xRc2xC6Vz1E9XEw56XCexLVkRhg6H9nQDKHA067GB/FIGlq22ASq28E1ZDxvu5qr
         MkRBbjciwy7Q2xsYKHI0i2W5U2EBjttkPzhVwz4JA0kaVHLuayJ01DxRgkA0r+8nz7aE
         vIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700206885; x=1700811685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCDUD/ayWCyYX+V5eg8ErxP1HhH1oV9OubP3STgdWNA=;
        b=M1qDh5NsXV3TUkJLemcRXGAjh3i6pm0Pjxs4TlIDc2FSl8M0H1APrA1QgTpfleiRhn
         KZF4Cv2t5GGaOyvQal8cmfhiWNeyG/YZO1GUbhyEp8HD2LZYUaA2tX1gieWcAiJ95Oev
         6S5UtFvfJ+qwDgBCJMic9KO5FmLb2gFkIvf9c8VJ0xNY7j2Kns7EeejA6TOnsRQ1VOK0
         BY7ltwY3/HilV0rzbMShqwck3oeGwaVkD4Zq+bekQVdSdXd2LS1cObrKh7ObMym6E8PJ
         MZF90pwv22ZAwrbEBWYjQ6YGG7PU4U/x5QTO3QoPeFpD66kJRxEK/AN5DXASUDMnHWR0
         f12A==
X-Gm-Message-State: AOJu0YzsEd0t6Ze+HP7DtZhYpckgaPV814XdGU2TOKlyyuk7Nx59q7PQ
        yezAu2Y6REw5aEYkXODObhPxdHB6FxpdZuQl94EanA==
X-Google-Smtp-Source: AGHT+IFy4OUn5tiw3ME+e8seX8aG0i3Hz+uDvT0kxb9K92hvelXNsjLz3NHqivsCcZchdAAm0jaDeHfmaroVHuF2uc8=
X-Received: by 2002:a67:b70b:0:b0:462:7c41:d00b with SMTP id
 h11-20020a67b70b000000b004627c41d00bmr2581850vsf.4.1700206885545; Thu, 16 Nov
 2023 23:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20231115204644.490636297@linuxfoundation.org> <b5367845-8d70-4fcf-861a-ff9b8849c9c9@roeck-us.net>
In-Reply-To: <b5367845-8d70-4fcf-861a-ff9b8849c9c9@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 17 Nov 2023 13:11:14 +0530
Message-ID: <CA+G9fYtOMKserwz7w_gpe4bZnEwrd_-zSyndSepFP_jO9X-o1w@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 17 Nov 2023 at 06:43, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/15/23 12:44, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.201 release.
> > There are 191 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
> > Anything received after that time might be too late.
> >
>
> Build results:
>         total: 159 pass: 155 fail: 4
> Failed builds:
>         arm:allmodconfig
>         arm64:allmodconfig
>         i386:tools/perf
>         x86_64:tools/perf
> Qemu test results:
>         total: 495 pass: 495 fail: 0
>
> with:
>
> Building arm64:allmodconfig ... failed
> --------------
> Error log:
> drivers/interconnect/qcom/osm-l3.c:6:10: fatal error: linux/args.h: No su=
ch file or directory
>
> There is no linux/args.h in v5.10.y.
>
> Caused by "interconnect: qcom: osm-l3: Replace custom implementation of C=
OUNT_ARGS()".
>
> Also:
>
> Building i386:tools/perf ... failed
>
> util/evlist.c: In function =E2=80=98evlist__add_aux_dummy=E2=80=99:
> util/evlist.c:269:24: error: implicit declaration of function =E2=80=98ev=
list__dummy_event=E2=80=99; did you mean =E2=80=98evsel__is_dummy_event=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
>     269 |  struct evsel *evsel =3D evlist__dummy_event(evlist);
>         |                        ^~~~~~~~~~~~~~~~~~~
>         |                        evsel__is_dummy_event
> util/evlist.c:269:24: error: initialization of =E2=80=98struct evsel *=E2=
=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
>
> There is indeed no 'evlist__dummy_event' function in v5.10.y.
>
> This is with v5.10.200-192-g550b7e1fee20. I am a bit puzzled why others
> don't seem to see those problems.

Thanks for reporting allmodconfig build failures.

My apologies.
The LKFT found allmodconfig failure lately due to infra issues / timeouts,
the builds have been re-triggered manually.

        arm:allmodconfig - FAILED
        arm64:allmodconfig - FAILED

LKFT have stopped building perf on 5.x and 4.x branches, because we
reported several perf build issues and were not solved in the past.

However, building perf tests from recent stable branches and testing
that on older
stable-rc branches.

- Naresh
