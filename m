Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8F6FE1C5
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjEJPqb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjEJPqa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 11:46:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164AA10D1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 08:46:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6434e263962so5564885b3a.2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683733585; x=1686325585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60FTt8+2LY+CnNwBz+xa3hAAp3IK5SiedfIPHAxt3HQ=;
        b=VhvNowEZakRKX6Xi+zRemXKqD4GK5rlbiABmxigOFqoLdYKdTronYnTkK9UUeQBA36
         BvPo1xiqnhT7eS15YQGAihiDiZz7ez3kIYlR0xSFjPYSXVY27cFm3XGdoGDLpVQ+YLRq
         nO9bpNOvZ6n6roCMD2yMVwe89oMszASteKsNaermxYuLyjQK2ni+BxJ+dOEI+K2P1mQF
         9LhYlklRm9FzFhn2W0WYOYL0/EBzurAXBnixpVOEpNynmks9djcfwSjxqly9VC+1tITY
         Z32cr+oFSueI5vHo2XI9jYh470gyhT7VZKjG/234O6Wb4rXD/3dNXXimpCg0heb3pqDg
         YZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683733585; x=1686325585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60FTt8+2LY+CnNwBz+xa3hAAp3IK5SiedfIPHAxt3HQ=;
        b=JZSLlAcroGpqw3+ccO3rJ26Rs+np4gHb7v7+D1PO8v0++o7G/aLGZ65HBTe52rKQq5
         BiXrXltPfRB7NEV9z3y9wyfetFA7GLJ2tzlpGLOJKXlKg2BFbdRkwcBedn2o8A47Ldl2
         xltNP0iplKvo5flbhza8GWpZiglTRegyU9DiBLz3LEKAJ6fuHr/vbBxkLYjaz1YeX9dQ
         QdQ+/7NpRwDIja0UlYxPFYG5CBxa2wvDgrPw42w4E20cICKfuIF/gyaw0ydQ7nH/HQSH
         kPyuZpD+2pi4i+lNNKrrRwaI2VGC4HI36+oCF2IwTQ4J6gCYHWQFYdmeMSPOiA6kUXIj
         8hYA==
X-Gm-Message-State: AC+VfDwMrlcGoJbB2j0jdT3kUbRO/n1pPQiyKEqF6I4keOuGUX2I8QuW
        Gm0CNTbHWJ95S8lSKPNFOXPKVKOuQsSjhLYFgKGPSA==
X-Google-Smtp-Source: ACHHUZ4vSroKUQ0I9R7My9Co8APqQAVgO725Inqch9oYd3Lasoxp8c6AfcYXhCLDsxpj3bnj55fYCCDHaapYxCKK0VA=
X-Received: by 2002:a05:6a20:841c:b0:100:52f4:986b with SMTP id
 c28-20020a056a20841c00b0010052f4986bmr13823648pzd.58.1683733585491; Wed, 10
 May 2023 08:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030611.521807993@linuxfoundation.org> <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh>
In-Reply-To: <2023051035-monitor-sandy-2a5b@gregkh>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 10 May 2023 09:46:14 -0600
Message-ID: <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On Wed, 10 May 2023 at 01:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, May 09, 2023 at 09:12:33AM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > On 08/05/23 21:26, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.111 release=
.
> > > There are 370 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.111-rc2.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > New warnings are introduced for Arm, PowerPC, RISC-V:
> >
> >   /builds/linux/kernel/sched/debug.c: In function 'print_cfs_group_stat=
s':
> >   /builds/linux/kernel/sched/debug.c:465:41: warning: unused variable '=
stats' [-Wunused-variable]
> >                   struct sched_statistics *stats =3D  __schedstats_from=
_se(se);
> >                                            ^~~~~
>
> Odd, and this isn't on other kernels too?

Only on 5.15, not on the 6.x RC's. I'll share more info after my
bisection is done.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
