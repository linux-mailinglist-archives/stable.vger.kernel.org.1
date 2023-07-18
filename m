Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA6758324
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjGRQ7Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjGRQ7G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 12:59:06 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC23C1BC0
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 09:57:55 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so9526948e87.3
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689699343; x=1692291343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JIndIIsHZdBsI82FGjgzN3aCzq+aMlyvKWLxj8Qz9aY=;
        b=VpfD2xPGeXFrsUMOAFJrtVhv3f8Z4MZm+RaTMwv/z5vZScyldkBj2GVf/WaYsoW2pE
         /bgiT+HYhcwyL9cXsqG+mLf3HK6QDpBzj0fTR42+nQYKuOOknGenF2kMWY+pBJ9FtWOR
         ABc7beAtrkMBlykXcwniKtnS34psSo9tgz/Ed2EC4maPoF7Jl1XUJQVxRyBfbi4KqTWm
         i040rAkjbcN6gFgsY8q76yYw0ykmGxPMwmmXLojHyhyxQxODbEng/S2D4F1bI0zQyC+w
         cfqgbRLbFZu43RFERcW6WEI6hTByCarCIqk8zw/K5xOWVcUAmTPRlb5jx801Cq9L/89G
         KB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699343; x=1692291343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIndIIsHZdBsI82FGjgzN3aCzq+aMlyvKWLxj8Qz9aY=;
        b=OGBTmJLSPl7JBljnBlL4zsGdrALbgQX2Zn5Lcb/8F40N3i+SpXHW0a18tUYvZobBZg
         A1JDeShx4pKfCR75MIA8ND9SUzKO5JRpxFS+66ApjvYkjEhP2XrFF+AcbJ+JJkgdS7iM
         HIRSWyp9gZbPzJ1TP/FIRUW9AqgcufMoJ/qh7LhgibowNrStgwyMHITl/4SDKJ8ljnMl
         zunaVQ/56EK12VTWISjNa76nlesV7c0LcZatZIPi2WNerhfBTbapDzOHR/3uJ//NyRP3
         sgCyBXzNGThRdnjtyjjQRORWFnTV6q9ZeOKhFzlWU19+FS4xCRb6Bop2Yjn2s7H+65Xf
         lP9A==
X-Gm-Message-State: ABy/qLYqd0+6stQ/yUJoiSUxELHUxctmmSxBIcnSJ+A9vqgwi6Em2awq
        pvOtU85ZT/9w1ZhMx+K23rwI1SmGZU1TqhT/fsh4SA==
X-Google-Smtp-Source: APBJJlE2uBeZwHdgwglSOep4/2Gj6tnEJTFOcNjZ6zIc3XLIKjD4I3fOhnp1lMuSNDsRNLskn1riZiAySK+ngZ9ZOTM=
X-Received: by 2002:ac2:5450:0:b0:4fb:8afa:4dc9 with SMTP id
 d16-20020ac25450000000b004fb8afa4dc9mr10304140lfn.49.1689699343057; Tue, 18
 Jul 2023 09:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201547.359923764@linuxfoundation.org> <CA+G9fYujXH8J99m8ZKoijGhWJAS+r1SPqd8y+gB-B9DVjsgAzA@mail.gmail.com>
In-Reply-To: <CA+G9fYujXH8J99m8ZKoijGhWJAS+r1SPqd8y+gB-B9DVjsgAzA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jul 2023 22:25:30 +0530
Message-ID: <CA+G9fYuxBPbDbgyr+oo_5OJwwYO7c53zEXfJKA9doT7XJAFA-w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Michal Luczaj <mhal@rbox.co>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 18 Jul 2023 at 20:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 18 Jul 2023 at 02:04, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.39 release.
> > There are 589 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> As you know LKFT runs latest kselftests from stable 6.4 on
> stable rc 6.1 branches and found two test failures on this
> round of stable rc review 6.1.39-rc3 compared with 6.1.37.
>
> Test regressions:
>
> * bcm2711-rpi-4-b, kselftest-kvm
>   - kvm_get-reg-list
>
> * x86, kselftest-kvm
>   - kvm_vmx_pmu_caps_test

These two test failures are not kernel regressions.
However, these are due to latest kselftests on older kernels.

- Naresh
