Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7B758CCF
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 06:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGSE67 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 00:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGSE67 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 00:58:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5101BF3
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 21:58:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34574eb05f4so29605765ab.0
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 21:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1689742736; x=1692334736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx/nlFjtu4ARcPKwXdYmnkb99UM/dQKiVgI7KMRPIGM=;
        b=VQaYGcC5+WLtUiJAamvCvUXI9h0WDtf6H6gPpm7L4TXt2YDHaPeg7SDQCxXAQbapnG
         5OWlkvmOlZISqLIn2WmroOJdMHvOPMrIQhrfqqySiwNhqzeHV9t6UE1DcUx6Afyx4uLw
         nsDXqp5hLQXwosWTWmykXon17uRtDXf5Mt0UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689742736; x=1692334736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx/nlFjtu4ARcPKwXdYmnkb99UM/dQKiVgI7KMRPIGM=;
        b=d20/tr4HPA6nDzb9jIHGD7Jl4EATngUdTQIgLzaHNPxob5ibLXTQrj4dBeFDVsqhyK
         vVpaiZneRRYZpgkZj0goRkOYbOJfHd1IDaMg2Cq/97NMYyn+e8yjxvUnixUnUSmN32ux
         xo1HdFSzSSHNqAz2arYDESDmtUBy1mEcDq1wnC6tXvu3RRh0H4/6YizvzD1+Lwcp4/Nx
         gsBzve090aiRH6hb1PAA3FeJQVUng0sz0Y9ujwl7MgAlf/fYXqPNq+ig+FETskq4KFo0
         gfd/POjHjYK9qEj6ApGqVc8nQwMBhOGaS2sKJQQJ7iwwvSGS6ip3TbDZfR8axjZtx6rJ
         XT8A==
X-Gm-Message-State: ABy/qLYDid+k3MPBBXnI0x8AVfcVZuSB0Mr8EcEN+tOhx/18oc/92T8Z
        BllwZkdoEwpjBUtTzp0wZy2vbQ==
X-Google-Smtp-Source: APBJJlH2mIKMnmpMa5BwTtRfkel54/muJVaPz4sXZLak232jtyoBEh3mzEjcxLrSHDpjK6NTMIfmJw==
X-Received: by 2002:a05:6e02:219b:b0:346:7741:3ea9 with SMTP id j27-20020a056e02219b00b0034677413ea9mr5170367ila.3.1689742736583;
        Tue, 18 Jul 2023 21:58:56 -0700 (PDT)
Received: from a443afd6f3a9 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b9dfa8d884sm2759468pld.226.2023.07.18.21.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 21:58:55 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:58:48 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Message-ID: <ZLdtiMeTL7ZSD7nW@a443afd6f3a9>
References: <20230717201608.814406187@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 17, 2023 at 10:34:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.4.4-rc3 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
