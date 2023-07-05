Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34767481D2
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGEKQ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 06:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGEKQR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 06:16:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7F10E2
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 03:16:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a1ebb79579so4685521b6e.3
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1688552173; x=1691144173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzhvK8EnyXoNyk7icoiRJkisO9UvyAqZpT57/R0erjo=;
        b=K6OJeNqfhO6IRs9I3aXem2n2bgVrKW+SWowkSVr/eEtXZv1Pat+tjoIl5fWv/7b163
         0iDdwfeh0D2nVCpemy3kx5z+2yFApRsAa6Tyz2x3eRXS5PT3KQF/9NF9F2GgHhI1VOsP
         SzVy7aVttT+XtKNFS07U/Ry0ow3ZhjmAAVBFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552173; x=1691144173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzhvK8EnyXoNyk7icoiRJkisO9UvyAqZpT57/R0erjo=;
        b=GOMA1b14d3SY7KEdEJyzPxiGx4RWd9PfOiE7utfEAfSfxPul4cgLeoJZnexc6SpUXF
         bPd4awHPXZlyzzVpOEHxYc3IaN8jqzNvVBI6szEHdlFQv8AdV9zo7NyRMtiYwlO4kHrd
         6Sd0JJxFGgUzoS8CGRaqDp8OT8AwTEkn/FxzgI8JQRUiHwsgqVYWuapYlHKca6nyCGKd
         b6Jd5EGHL33afUk7rKM6d/d9Kt3SmXJJ9hUvyAt1n50FuHnoO+LsjOroz+/LuOo+KqxD
         ztv/nuGdIvFcp4yGlgQ1k1OPphGREAYtEJt7TCzOjTnT47A04yQK9DBv6i/ssciNCGOU
         maYA==
X-Gm-Message-State: AC+VfDwiVtwszvlpl7OgAvIxwDiZxWckAHFqIqzjfW5tf0BjEsAnT0dG
        GmjRXkagZSGb42hAhOopi92adw==
X-Google-Smtp-Source: ACHHUZ6fT5xRwDL5gF8pDtJcEsLSySgE1A8aMrIHeqhzNAHOr6m2+0zLz2H0+Ssc8xYUk3QeE0j8vA==
X-Received: by 2002:a54:4713:0:b0:3a3:6743:a9c with SMTP id k19-20020a544713000000b003a367430a9cmr15390485oik.6.1688552173480;
        Wed, 05 Jul 2023 03:16:13 -0700 (PDT)
Received: from 5f8976b95e14 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id 204-20020a6300d5000000b0053051d50a48sm17500765pga.79.2023.07.05.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:16:12 -0700 (PDT)
Date:   Wed, 5 Jul 2023 10:16:04 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 00/15] 6.4.2-rc2 review
Message-ID: <ZKVC5OwGFbCoqDdm@5f8976b95e14>
References: <20230704084611.900603362@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084611.900603362@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 04, 2023 at 09:48:24AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.2 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.4.2-rc2 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
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
