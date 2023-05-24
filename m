Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7670F1D3
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 11:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjEXJKO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjEXJKN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 05:10:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2590
        for <stable@vger.kernel.org>; Wed, 24 May 2023 02:10:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2532c2c419dso9817a91.0
        for <stable@vger.kernel.org>; Wed, 24 May 2023 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684919411; x=1687511411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCr/OarpwieZOdmOIu/V9/SmcLUVBsGlmM/9L/c4/Sg=;
        b=UWrzm3fkA2t41R/7rcZtG59r4OaD3kflJfw8z5OXpXJYWUkbvvu0V+t4VOPaF4oSBG
         oFegg8MxngWUsRrdDdGMAW1QK4uME4dH/E51jFAr9E8pzujqP+bJLymvONVtzK8udaeG
         AJW18VFG18kaIQ5ouv7PQVQTlPPceajrBMW0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919411; x=1687511411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCr/OarpwieZOdmOIu/V9/SmcLUVBsGlmM/9L/c4/Sg=;
        b=mF09KXJy33BpqobIt6IFHGI9m1WqiAVb1Yg6LlvKyLzQO0l/YGlcY95b/aGepZxM4n
         WJibA/IT5g5RoPlRLp7Pwdjs4oWwI4KGnT/zsPeqRCMJYds9buaYK8mh6m70acrNnhhs
         3Ul5js7rAh503+l4hP1nzQFvmwRbF7vUAK8wnZT3mO5YEhZgWHp2whoL2IOArGk7eA9l
         wn8Zy0m9Xs8VFXHcNw4ADLZa5CjUY9bbKZs88n/wrqKQ8uVPvW9uzv5mq3/dW64gsddP
         pJi9i1+pcAW7rhUOk/SwkWTCv+1HzPVCHqoK2KRTBl2oUXsVwbP5iyV7dtPUpkc231TU
         3yMg==
X-Gm-Message-State: AC+VfDzF7PxBMNyG9Jn7ClOz1+57DjC/Oebb3/v9im7jyoZVry4iVClV
        1XrVDNG+Ai9/FHA4bQtqAdXVAw==
X-Google-Smtp-Source: ACHHUZ5C0WPRnTM0+P/MCsTe53CbWPUvCmfYCSa/0oJkwLPOsN+SR7MwcINaovSF6b5GlxJdy+iB2Q==
X-Received: by 2002:a17:90a:51c7:b0:255:4f3b:f3b6 with SMTP id u65-20020a17090a51c700b002554f3bf3b6mr10346649pjh.37.1684919410656;
        Wed, 24 May 2023 02:10:10 -0700 (PDT)
Received: from 330e1fe543a3 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id nb1-20020a17090b35c100b0024decfb1ec2sm890928pjb.30.2023.05.24.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:10:10 -0700 (PDT)
Date:   Wed, 24 May 2023 09:10:03 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/363] 6.3.4-rc2 review
Message-ID: <20230524091003.GA517720@330e1fe543a3>
References: <20230523164950.435226211@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523164950.435226211@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 06:01:23PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 May 2023 16:48:37 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.3.4-rc2 tested.

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
