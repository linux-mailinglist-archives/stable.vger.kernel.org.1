Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD29704D48
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 14:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjEPMEa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjEPMEa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 08:04:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D5527B
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:04:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ab611e57c2so4290494a34.1
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1684238667; x=1686830667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJosZkuHbiv9aC0zid4KAAbdE5AYoHy0os35a+6yEh4=;
        b=Hcjeuhev/jBUZbhhXSUbEKHdp1VBSFZN5JNVv5uUtxT099arEEawMJcrkMjcuzn6/5
         xjtNCsEK4UxMhhGHiO0vk04bpev1//ZxPGcPUTUvWVtMShJE2H7X4Y//7mGc+pCLmaYa
         WDiRJKeeXeGbNi2tR8PKFFd4nC7Y7p4FVwlUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238667; x=1686830667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJosZkuHbiv9aC0zid4KAAbdE5AYoHy0os35a+6yEh4=;
        b=KDZxLJQQcLmpE+3y39837Hjahr4fvy5p4jpKXONEAVk1ima5eUtLI43r//mlp4wi40
         Kdut3Oqu7n7hUKOiKBxaLIhr6OGTENZhFKvL7EmCIdYJHHgtjmW5Gekdsp3jV5SX2e0e
         Hp6tKMvwQou1gcs+Og72pWhbuHfT7zYGygUVyi2HQK4YbTPZnen/VNHlLT1nEOgqUmdR
         h4Cmaui2TFIwCoH3ZYuDOxUeacysS1tKDPe33IkLuBmLMNQVK47ArSXe8KDSyyTPnL3d
         +Dsv9htQHDUgx/gtQR1r8sCFmH86OZc4XrYpbYVSIwkHBCYfaTGvRPRarY6nSDAc7bKP
         TY/w==
X-Gm-Message-State: AC+VfDxgHq4L0IMmkt4c9DoG9NPBptdjkPHRBKhLt2HJoRkCbmDz77y6
        Fx4WYdgzJaAn5u0ZI1j5FDps1A==
X-Google-Smtp-Source: ACHHUZ7H25k9zBFLAifLfWin8oqXETP7UGnj9dxYlhdJA5TKaEpBbP9ob2KBM3FhI0weuJw9l8GF4Q==
X-Received: by 2002:aca:2301:0:b0:38d:ed4a:52eb with SMTP id e1-20020aca2301000000b0038ded4a52ebmr12456332oie.38.1684238665298;
        Tue, 16 May 2023 05:04:25 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id u14-20020a4ad0ce000000b0054f9f229bddsm8082829oor.15.2023.05.16.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:04:24 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 16 May 2023 07:04:23 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Message-ID: <ZGNxR9S9pNU2+BiP@fedora64.linuxtx.org>
References: <20230515161722.610123835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
