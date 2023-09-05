Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8081792D23
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 20:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjIESLK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbjIESLC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 14:11:02 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2E2CF22
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 10:33:01 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4141d8a4959so17227411cf.0
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693934755; x=1694539555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7h1pOWAWn2f3/0pIwmJa14UCgmY4tfc3A2xWVFCKn/A=;
        b=XQuE7DjXgAUV80wvKkCiJKB/kLjkUUFV99pNMAo9IrXwXB+jXOmfMCB6s/QLXV41Zg
         T+PAGSYS+x6cnOL1onGTjhO//lkBJwALRwdvt4KpEPnnZjP9d9t2xqc1IYx46cFNIJvQ
         TRd1EzhFvKhY0BqAY1w+hZZIbEpTtIaV1UI5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693934755; x=1694539555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h1pOWAWn2f3/0pIwmJa14UCgmY4tfc3A2xWVFCKn/A=;
        b=kQQAcHJDbLp+XEBQtlsnjsBMopDN0+mnqW7vPxWiHTBBicnrqgASYJwnbFpfCjEB/C
         OMo4N3MSsKLdFS1+eqnh41qe3YkRQpwVU3mHmhsu255UI3QFFH77Q58WALwtnwE/jeaf
         rP7ArTlZfgiye4Ml6Nol31MyTdDH2GLvNCYaJEmZpfa4gXEsCcy66XG8CR+Pdl1d1kAH
         joCYPRfeleThi3LzzPPsm2ONOwQgATvttR27AGKp8hmR3NhNvigXeCJsk00Y2B5nNf96
         7QIRuR5eoFPPockTxXZq3LenoVfS8euomW0jP42CcctpAoIRXdOPDGgbNXH/4D+3VSMx
         7vsg==
X-Gm-Message-State: AOJu0YwKLiTo0zOyJ7kXwVQ4XupX7T5pLBSJFpE9NhCiEGw8i6yB9wDH
        BaPkRqoE21a7I8E1mWWElT07j/IV53d3J3jx1Nv0P7ES
X-Google-Smtp-Source: AGHT+IHyoieeDB0PNwVvLRlAczgv2xHwUxOdj1W5kcWlyPok77Aa/jXmKT28xB8W4J/4Y/qekumOfQ==
X-Received: by 2002:a9d:4b05:0:b0:6b2:9bdb:a84a with SMTP id q5-20020a9d4b05000000b006b29bdba84amr15026049otf.32.1693933771878;
        Tue, 05 Sep 2023 10:09:31 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id t25-20020a9d66d9000000b006b89596bc61sm5666307otm.61.2023.09.05.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 10:09:31 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 5 Sep 2023 12:09:29 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
Message-ID: <ZPdgyWKSJkXf7Q/z@fedora64.linuxtx.org>
References: <20230904182947.899158313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 04, 2023 at 07:29:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.15-rc1.gz
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
