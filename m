Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086BF7DDAF8
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjKAC25 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344725AbjKAC2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 22:28:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C097DA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 19:28:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2e22f1937so3408497b6e.1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1698805728; x=1699410528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NOS13AWfl+zD92mnNkBlpojb9vC6m6JveBvE3ib1D0=;
        b=i0HBoO8FKw46GPzErrcz85zwLKI8QuFdVbmp0SaYnxgwKKHQ2Lk9dwF8hcMIIPMbVU
         CXBykjy60Hq9diMHtz7hiawfguk5XwcD+WZCdvKfOapTHyDtFxwmSJNgV23q5vaYNirJ
         TvxS/+10Bs/q4q1yGsZPKg7echGfJGFVlIjWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698805728; x=1699410528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NOS13AWfl+zD92mnNkBlpojb9vC6m6JveBvE3ib1D0=;
        b=D79ilg5jiPizk/kUVOMlF2MY02OXY6aZg9PXbVzY6S3ycDaORhIiMhy9PSMP/vPS7E
         iCVARtANfvqOBpOaRCI95TSKkEzTuYmd2GMSrdTT5IRTYHhSKHO4Gd4gMlfi5zOenpqC
         TCf4CAYHW2XrfObl/XuBKCX+H6fz2rf4lmq9hMJOVSSVSyq2dRDySoG5lKlLr/Qso3fB
         /EVdGEp+WHDIDNzDYpwWKua26OsYB0L2MqyXOCA8k0lGEqw6Qa/H3IdpJt5oRKJ++rxh
         qw2w9GV0Ejau0hfCDRUmMqQQ3wEBFsrAVMS9ae9Dd6FL4uPnB3jK3icpNRa1JfCN6Ztj
         /EHQ==
X-Gm-Message-State: AOJu0YyaNVyd4u4vkcQNHoyM30c3Lvj75hZCrh6iGjjhAcZAWEookbe+
        rdbJnSPgP0fchHCi1cE2F1+o6/a2yuv14soB/fy4JoQY
X-Google-Smtp-Source: AGHT+IHOvyiAUD7ZHPdpP44HLsndQ+RdyPrWrmwj5thEHMOLwAMgNq37HfZjGr3nOGtKfd7GtWMEuA==
X-Received: by 2002:a05:6808:3a85:b0:3a9:cfb5:4641 with SMTP id fb5-20020a0568083a8500b003a9cfb54641mr13949893oib.48.1698805728594;
        Tue, 31 Oct 2023 19:28:48 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id t2-20020a0568080b2200b003af6eeed9b6sm101348oij.27.2023.10.31.19.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 19:28:48 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 31 Oct 2023 21:28:44 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
Message-ID: <ZUG33Hft8a4XYnrD@fedora64.linuxtx.org>
References: <20231031165901.318222981@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 06:00:01PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:58:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
