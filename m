Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1EC78B57A
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjH1Qlc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjH1QlP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 12:41:15 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10311D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 09:41:12 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5711f6dff8cso2090938eaf.3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693240871; x=1693845671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YxFxiHk+V4WPvxmce4sVK68Zw1aZ82QkNmJDshmYps=;
        b=ABFGf+UCJrERZ8Rir5RFXLgrlhU6YGPPPNs/LtQKppVzEbwXKMi0JAY05X9oAWQY+T
         O5CXvHrlicbhWI6ensHMDap3S8cYH91eWCOkaRCloyf7iDUTEWprj0HHUmBlEHO2ePao
         OE6170fgVEmXv38ohxGU9vCGL7XRS9B69aCUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240871; x=1693845671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YxFxiHk+V4WPvxmce4sVK68Zw1aZ82QkNmJDshmYps=;
        b=ePZbEA+PDZPIbF21oOgKXwmaFzFA+PxSgAhZef1KG0NPEVphQGrAshdGBEDV6tdyPR
         FITu/BZAGBzQdNSCcq+nZ6jf/eOFe3lelH+XQCpVA3wD58Fa9Dawp7twSaId5LJ4LTMC
         kvhv8z/Dlp98gDs71OJHBJSEEw4bKSwkoQizu1W9KOLFTnhEfZvOPkGoJPNN5twgcG/R
         031YRh8CKKs05A/jtzuysQBiAK+x3xtjahCialpPrT6kYZJcWo3AZAPWhKMGynRcwLS4
         sIgkKaHef/A+rfpM5AuP1sytVWCyaFp2x94iB7jocndGcpu4zTP6NoWmWH/VGOy409p9
         1GgQ==
X-Gm-Message-State: AOJu0Yxu6nVQx3KbYc/cLk34MgXBvilf3mMy0PIa8GPr8T8EIuu8Qwjf
        27mx2oPE60jGJ6hyUOfwjt6UBnXrS2WM/OZyZWa0OJ7P
X-Google-Smtp-Source: AGHT+IEjYCpyQaKSkqsuwF3CM021iTI/a22UZD1yTLU1DB+P2mSTJnOXxTfjx4GvnBPSA6DMVg/njw==
X-Received: by 2002:a4a:6211:0:b0:56e:a1d3:747e with SMTP id x17-20020a4a6211000000b0056ea1d3747emr11575028ooc.6.1693240871184;
        Mon, 28 Aug 2023 09:41:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id ay3-20020a056820150300b0055ab0abaf31sm3812150oob.19.2023.08.28.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:41:10 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 28 Aug 2023 11:41:08 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <ZOzOJEfDcR4pS3Do@fedora64.linuxtx.org>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
