Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5D78FE80
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbjIANnU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbjIANnS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 09:43:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417841717
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 06:42:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a751d2e6ecso1302726b6e.0
        for <stable@vger.kernel.org>; Fri, 01 Sep 2023 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693575771; x=1694180571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QiJjiczVQzfiFfrC5WsnaxKkl4rh7lmVtRGz1s0SGU=;
        b=UFRCZ4TXqldh4qYAeSoOfCjw6LQnBvhYoCJiY/YXG18zbcOjeOXQ23qcfaxVpDZKpg
         e/inxL28vyRMIXT+hvjKe161BeTI2b8jC1mbQOuP0LeBjwOMc5tUEDD4p3cQ1dw4sC88
         it0XCIlAcL9WybdfhcpacqF6WHgf0qT6orlBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575771; x=1694180571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QiJjiczVQzfiFfrC5WsnaxKkl4rh7lmVtRGz1s0SGU=;
        b=K0EjYdTuohw6NCgCp6FBCoag15qMGk8Uhkz7Ji5rPz6GTMEI9PxbMNtNeEyPj2jlTm
         27gDY3eZx2EO7YooSQj1aoFcHAgHPUfYG+QCMQyEqD446gMsUHq7AbijDBOVC3D4H2f+
         eH5dWzAjdV8LCEAh7Et2eNrWKGVxGG2IVEli1C2AffyLWTsR8pHpfxw8uOjMg6fZPk90
         i0Awp3FLW+J0axjmFa9XRhIjDrG9kMmNu57TIrpgVzAhsLVSEfk/BZOYbRu3b5yUmVes
         vecKs4dTDMRN6VjHdoumbbnHtZk8E/bIt+GmrgBpgu8iMATOct6nqLJGhJr+dsLGzqej
         F8hg==
X-Gm-Message-State: AOJu0YwEY39NkRGpyOgxUu2pTgn+6ysQ6hiFfUmHQy+SXy9CbG2r7ToB
        rMTFjJSQbX+7IZGBxM//GBH+bA==
X-Google-Smtp-Source: AGHT+IHgLCqgzrPR0nVjpRfCz1D4Ao0Lpg7/VPmkRQkLqdf0hOcYBYEQBbZY2SmnCx+nsTqLWJwQbg==
X-Received: by 2002:a54:4d92:0:b0:3a8:43d5:878b with SMTP id y18-20020a544d92000000b003a843d5878bmr2481376oix.2.1693575771588;
        Fri, 01 Sep 2023 06:42:51 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id be32-20020a05680821a000b003a371c611f6sm1955815oib.18.2023.09.01.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:42:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 1 Sep 2023 08:42:49 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 0/8] 6.5.1-rc1 review
Message-ID: <ZPHqWUBKX8LNJ6DC@fedora64.linuxtx.org>
References: <20230831110830.817738361@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 31, 2023 at 01:10:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.1-rc1.gz
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
