Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88F27A9F29
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjIUUSo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjIUUSN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:18:13 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90757585D0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:19:19 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-351098a1e8cso3070865ab.2
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316759; x=1695921559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0A4cf8xaLph2RFxNW2e2zC/ozNHYMpBHiQTWSZDrd4=;
        b=UoFciicU49fMVGDs80LLbkyiUc8Yf0Ur6SJ8JBiePNUlSvzhqFcC6LXyqW2mF6Pmzw
         78CmvYzFbMabz+mjR/7uFq/XQJgFXkQdheNmnrbXvDoTJ8ESRwU2ZWC5icsryOtBBKop
         NgOya0komdG3ifSdAznHsiaCqNXy4zMCfOc96JAlVJkmuAxvfFXWItJXcNtyZAs0SamR
         nGQf0yTU9bSTPYSutCm9j8S3Lt36OjnJEa6UJjyf44J39B3fJH0a9OAYkodS9pgjW30F
         z8NQJxJihhHm8WCMQfjAMzfl3/oHfaMhpyXMwCNPY0Z0PQlxfAFvWGFYMKWxekkk8tZD
         QY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316759; x=1695921559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0A4cf8xaLph2RFxNW2e2zC/ozNHYMpBHiQTWSZDrd4=;
        b=K/encAWmZDRsC5X17MVeYxXN5Z2MZLyBOTuzOSQz5PBzmGjkgYahlh/c6NYGmz7lWR
         /+CUgWfYBmDe5MQEKjxeA6fU7vdWNlN1qek5mnSQzJ1yvXJDlVSo413F98mT4CzdYKpV
         Vxrm21GgVREY3R9VCebOaOWsmNsyi9Qt4O4xAVSApCYxV2difftMt+bsDgL/PwvruUGR
         F291fZ21U1oboSfkYQFU16gR7/eWzGzYjBeMaJ2sX65ayOKgOuxrO9GIBgVGURz6CDs6
         VRYEWipxrkOK+eSiNcMT6KkXQyBm+maH0Wjz1xeRvkdGIG0VXUavMaG4NAZpMvGSrJpw
         8w2g==
X-Gm-Message-State: AOJu0YznUDA5hee7kfZ7As4VByux+AXvuIdOpKhmgCnFSQIcU1OMFk2m
        Z+k7NRSopOUoy0onzYNNnkWStT3+6xU3JZVXlQQkQ/qz0m1buGrmUZ0rQA==
X-Google-Smtp-Source: AGHT+IF6qOrjEY9if7ZapsXGGL1X2pv/FF05y7VvQhm8TwsXueJgwhY8SQCZZx9F8vyaLZqpsJvBOnpMrRr0N4EDD4o=
X-Received: by 2002:a1f:c6c1:0:b0:495:ec90:997e with SMTP id
 w184-20020a1fc6c1000000b00495ec90997emr5200602vkf.7.1695298135191; Thu, 21
 Sep 2023 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112858.471730572@linuxfoundation.org>
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 14:08:44 +0200
Message-ID: <CA+G9fYsM0Lr8TNQJxsZFDZwcH-rEzkVV+y+x5FX18oH5wm5dRg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 20 Sept 2023 at 14:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build warnings noticed while building arm64 with allmodconfig
on stable-rc 5.4 with gcc-8 and gcc-12 toolchains.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

drivers/gpu/drm/mediatek/mtk_drm_gem.c: In function 'mtk_drm_gem_prime_vmap':
drivers/gpu/drm/mediatek/mtk_drm_gem.c:273:10: warning: returning
'int' from a function with return type 'void *' makes pointer from
integer without a cast [-Wint-conversion]
   return -ENOMEM;
          ^

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2VfG47LmPH9MUEuIcMVftu6NsFy/


Following commit is causing this build warning.

drm/mediatek: Fix potential memory leak if vmap() fail
[ Upstream commit 379091e0f6d179d1a084c65de90fa44583b14a70 ]

--
Linaro LKFT
https://lkft.linaro.org
