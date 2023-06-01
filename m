Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13FF719BB4
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjFAMOl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjFAMOb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 08:14:31 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4EE5B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 05:14:07 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso128919241.3
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685621584; x=1688213584;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJQeJe1afZ0bpeNqxbOb/wLGrUTrTFJChILTbafy4Cw=;
        b=JY7M6bj1xVx+VjB+bOPA2xHbDjAwv4R63zJBAeijruU5y4nPK3ZeAh8f6vOLuwoih0
         3nk64VZMheWuY/5CWaj1GloesVruHJdKo1laVMqMookffmLWyMCQjWq/sy75dkG+Br72
         cLTvIzvu5k44NeVK9hHOP4ufq0Wr/zakULK7DkWGlgd1vbKdCwaCiF1G8JgbQY8HxZcY
         kNdWw0BKWy02LBeZUZthbGUxAHoj+sGkWmlTbvIKD9dloQYogoKojrms8Ne1Bckn69eS
         N6oiGICckvNaVkdNS35r3lw6FbyTzqbpNgmzSg7HNcPsVCNo35EehLuYTKLrhWsisysU
         nyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685621584; x=1688213584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJQeJe1afZ0bpeNqxbOb/wLGrUTrTFJChILTbafy4Cw=;
        b=c3kdoIqPuO2d4ahveDxMiVLP9454OBVm8yItaOE3mU4SS73NEeXQN3TmrFw8z9UeHj
         INfmBqiwnekNDvBhH5gmLbAD2r6ywwS8SyOktebF+EEtzDpmcwbsf0sZ/1JAumKxyXuz
         VViD/WY+9rV9wmLxSYxCMaFU0xRuJtDghIOqNA/NVKzsOrf2pVvtbQHb84N5Rzj3ePQT
         aMeHcQ1bbJGZlqA4zZ18wU2sTkDAPptIaeK2cKvFx+xCzD11n1M4l+1YtmHsPr+gpF2s
         8onkdV0NTw42kC2tmgcTY4QIIjDqfmw93eR1tzMjG4pnAYzhhqNFMGIy1Zbz+j22vorT
         HsUQ==
X-Gm-Message-State: AC+VfDxjifhf8Dxq6RKcQKx3lKJYx5Do9wzyr/RqV4MElyGit9lN8N3x
        yGcP1g+/xJb7koOBL24hZKTXAWmV4ZduMgfrqOx7znqIu3mOaDBkk+M=
X-Google-Smtp-Source: ACHHUZ5u9bu+6HgUMkZisnjhOfZ3tFHjVu0x1sepLFA9ay4j8yAcFu1HQDlrCIbpoaRc0Fn2IsHmx627lbRf1m34yy8=
X-Received: by 2002:a67:fe97:0:b0:430:ce0:ae90 with SMTP id
 b23-20020a67fe97000000b004300ce0ae90mr2476381vsr.14.1685621584107; Thu, 01
 Jun 2023 05:13:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Jun 2023 17:42:53 +0530
Message-ID: <CA+G9fYswtPyrYJbwcGFhc5o7mkRmWZEWCCeSjmR64M+N-odQhQ@mail.gmail.com>
Subject: stable-rc: 6.1: drivers/dma/at_xdmac.c:2049:9: error: implicit
 declaration of function 'pm_runtime_get_noresume'
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Linux stable-rc 6.1 arm builds failed.

Regressions found on arm:

- build/gcc-10-lkftconfig-debug
- build/gcc-8-sama5_defconfig
- build/clang-nightly-sama5_defconfig
- build/clang-nightly-lkftconfig
- build/gcc-12-at91_dt_defconfig
- build/gcc-10-lkftconfig-perf
- build/clang-lkftconfig
- build/gcc-10-lkftconfig-debug-kmemleak
- build/gcc-10-lkftconfig-libgpiod
- build/gcc-10-lkftconfig-rcutorture
- build/gcc-10-lkftconfig-kunit
- build/gcc-12-sama5_defconfig
- build/gcc-10-lkftconfig-kselftest-kernel
- build/gcc-8-at91_dt_defconfig
- build/gcc-10-lkftconfig



Build error:
============
drivers/dma/at_xdmac.c: In function 'atmel_xdmac_resume':
drivers/dma/at_xdmac.c:2049:9: error: implicit declaration of function
'pm_runtime_get_noresume' [-Werror=implicit-function-declaration]
 2049 |         pm_runtime_get_noresume(atxdmac->dev);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
drivers/dma/at_xdmac.c:2049:40: error: 'struct at_xdmac' has no member
named 'dev'
 2049 |         pm_runtime_get_noresume(atxdmac->dev);
      |                                        ^~
cc1: some warnings being treated as errors


Build error caused by patch sets,
============
  dmaengine: at_xdmac: disable/enable clock directly on suspend/resume
     [ Upstream commit 2de5ddb5e68c94b781b3789bca1ce52000d7d0e0 ]
  dmaengine: at_xdmac: do not resume channels paused by consumers
     [ Upstream commit 44fe8440bda545b5d167329df88c47609a645168 ]
  dmaengine: at_xdmac: restore the content of grws register
     [ Upstream commit 7c5eb63d16b01c202aaa95f374ae15a807745a73 ]


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.31-42-gb3d23a09e886/testrun/17274479/suite/build/tests/
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.31-42-gb3d23a09e886/testrun/17274479/suite/build/test/gcc-12-sama5_defconfig/log
--
Linaro LKFT
https://lkft.linaro.org
