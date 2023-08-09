Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB377541D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 09:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjHIH3r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 03:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHIH32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 03:29:28 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D330F7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 00:28:45 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4475af775c7so2331749137.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691566124; x=1692170924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2riTaNH77REtC6ISF+fVAqJEx7oqvwPWkrXn1kOuBK8=;
        b=PWvV301jbVil1DtF60FMURdXOddxmyoVSFZJgS3QNp4S8Srgpr/oCuzUHAlEXUbC58
         J4Q5+MjSELlQ21knjzKllEQfQH6y/1m2mCRnMmQxUbCUK7TiG7ycdCklSYJuIPQKw/yy
         HT5ya9s/6nKNwFuFE0XXq240lUB1aaTAI/26v2l4jUURDBEac1zN0QeiuYMQ+I+W1RtC
         dqPp7IX6DFfCzT/jIgWkjT+owGT04mn1Mhncahb/zlN6NBNjbQN2hTSJ1vvtIcr7TqIq
         a8VvCE+M42NW5jEr1RD/wCSZG7o0Yf4OjNsrjoUe5sTl+/xT5nMcrWjP0c2tv36a3jNR
         /1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566124; x=1692170924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2riTaNH77REtC6ISF+fVAqJEx7oqvwPWkrXn1kOuBK8=;
        b=VPGRrnm5/Hizn+Ujd/QylQyJ4QK2S8eHCKRGSOQBbWXrWOYB2QGSHlKf4VD12l5DzP
         rxDvXsNZQp6sW3LhViG3r54zR3ZDqt66jUMla2FNBNG7/iNlfU0rperkRu7ghiciSO0y
         RzZ10M3Xu6U471Vtcrbapgy4mVPbpKcL738QHYCjnF3GVjTkUKn07WoZVHtROg3X0rnv
         T1+J35gomE/bxAvAHsDJFAM90EW1gZGrzUMEcC2WoPvq2Oh7Zj3qYVHQQLS1RFvmx0ij
         8KNTls0ahenaWuZqNvx4EPDrIawB5xGLqEW5l4Ey5etosiV62viLNt32ZGNDmHaz5hZQ
         YFlA==
X-Gm-Message-State: AOJu0Yx1qCdloqhqBf5dSe4o31EiDT4SbUL/CrgeGyV04iY6qBEOxUu8
        IrGQi2mdgte15+9qHP0GMwJ81xHAB7hmgunkPBW/E2xV5iLiBFQTIKo=
X-Google-Smtp-Source: AGHT+IGi8QKuheDujgueBRGKYpW4EWIGdylquyRRi2A2MNYXskPK46jPAVdeF9LzAfEHYy60Mc7X+3DVojqxYpsduAM=
X-Received: by 2002:a67:e441:0:b0:443:6449:479e with SMTP id
 n1-20020a67e441000000b004436449479emr1609634vsm.8.1691566123735; Wed, 09 Aug
 2023 00:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvTjm2oa6mXR=HUe6gYuVaS2nFb_otuvPfmPeKHDoC+Tw@mail.gmail.com>
 <2023080946-wow-cross-1079@gregkh>
In-Reply-To: <2023080946-wow-cross-1079@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 12:58:32 +0530
Message-ID: <CA+G9fYtVRda6y+vGptPnG+G11TGa=F7+Qw72+xZF9qhddT=vgg@mail.gmail.com>
Subject: Re: stable-rc: 5.15: arm: fsl_dcu_drm_plane.c:176:20: error:
 'drm_plane_helper_destroy' undeclared here
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 9 Aug 2023 at 12:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 09, 2023 at 11:47:45AM +0530, Naresh Kamboju wrote:
> > While building Linux stable rc 5.15 arm with gcc-13 failed due to
> > following warnings / errors.
>
> I appreciate you attempting to build older LTS trees with newer
> compilers, but note that usually, as you are finding out, this doesn't
> work.

These reports make us aware that we have found new issues with
newer tool chains on older LTS trees  / branches.

>
> Right now I've finally gotten support for gcc-12 in all active stable
> kernel trees, gcc-13 takes more work as you are finding out so I'm only
> testing with newer trees (6.1 and newer).

We have seen great work (fixes) for gcc-12 when it got released.
I think I / We should not expect this with gcc-13 since it takes more work.

As I understand, stable-rc 6.1 testing with gcc-13 would be ok.
other than stable-rc 6.1 branches 5.x and 4.x should be built with gcc-12.

>
> So when you run into issues like this, that obviously work in newer
> kernel releases, a report doesn't do much, BUT a git commit id of what
> the commit that needs to be backported IS appreciated.

Thanks for explaining the details here.
If I come across any fixed patch / commit id then I will share that information.

>
> thanks,
>
> greg k-h

thanks,
Naresh Kamboju
