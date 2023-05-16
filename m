Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C13704DED
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjEPMjH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjEPMjG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 08:39:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF860173D
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:39:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaec6f189cso95772625ad.3
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684240744; x=1686832744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oW/IIcwZUlvaFPTsVVZ4y7Z+vHDWRm/FW0iybV2A1U=;
        b=kI/q/toQd2vzR0miiBwBSiBUX38TKZiDljoH8PXAjj9WWTWW5gTEobj3i9DvbCWrL/
         vn/lSYhY1zNBFhP585sXquHN4np9ms4ncRrwqR0U/gQ8PnrZyxex53dn8UUjjmMz0aqY
         FzbyM25RIUwc+PPoyMA3f8/CYCwOMmpZfeLwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240744; x=1686832744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oW/IIcwZUlvaFPTsVVZ4y7Z+vHDWRm/FW0iybV2A1U=;
        b=CT5V9i+I413RkWMyI2uFMSfZkyWJvU8FKxMDU9kDXmObe1O2hYwwi6jEpNWGiuyv14
         tAWSnYyxwZR7zQkPLj3+W5nzA6i3eYG187dw+HIUy6cuDlqTcaYfol3oVA6Qd1MUM6dA
         TgFIk6+z+AvwdWHrmXH+FitJyEA3Qfl0uaUlqpoZy3SezznK7NLzkEDeawHbhXex4lwK
         Dn/naL7n6bf15r3iT7+2h6Yb0ZriLeP2K4Asxr9PsossBw7IxVJdu4Jij9sxW8GMiNh2
         gjwGwI2+PCSfiQntwbsNLFPP8QT0GoDAdG/zelfqtEbA9gkTda/TrxutBxYpDL7xhucx
         8Wmw==
X-Gm-Message-State: AC+VfDxd40X487oRkJPZzB6M77nD0CZFh7oN/1G3GelXFv4umSvcSZfX
        EX9rxokmmftd1o5zlFJUzkVHTg==
X-Google-Smtp-Source: ACHHUZ7QfEB8SeXqY4hgGFdGx/qpz6aDthFOR7yJN98PQIgCWf7EgdDzcbzN6Y9d9MSl6JEIFS5i8Q==
X-Received: by 2002:a17:902:6a8a:b0:1ae:3bfb:f58b with SMTP id n10-20020a1709026a8a00b001ae3bfbf58bmr1278285plk.64.1684240743993;
        Tue, 16 May 2023 05:39:03 -0700 (PDT)
Received: from 1989cf8cd4e7 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b001adf6b21c77sm7264426plg.107.2023.05.16.05.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:39:03 -0700 (PDT)
Date:   Tue, 16 May 2023 12:38:56 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Message-ID: <20230516123856.GA184274@1989cf8cd4e7>
References: <20230515161722.610123835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 06:23:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.3.3-rc1 tested.

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
