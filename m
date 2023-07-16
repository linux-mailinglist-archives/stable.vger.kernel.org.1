Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAF7550F5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGPTZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGPTZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:25:55 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EABE4C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:25:54 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4814bea10e0so1252494e0c.1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689535553; x=1692127553;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSAuqt+s4WpqnMkPR0UJ8Xay9OvKHBk6xAfxVDPkGGQ=;
        b=GCfnrMXYxp6tDgtZAagG8EKzfgEUkVMqLXnYtg5sUR5EMzDvuVV7JWq8MfFipjIqwp
         rQWsJLvKS3lRUTIoET8y9ScSg8YJkueRQBIMPFKiK5Ht8RCUrUCsCLc30sRywisgwuYa
         nLb0CvZurNsuecbNXH5SJbeg2xgpy3fZtgWFcqmbw0/QSt6XTJrrtiNePq+1g15mwoq3
         WKeQ2nYtg8zriWqSdiThh58oCfl9O7kfNJ9WM0qNKbHZOhFWomvLC5fXwqNHmGT/3QDv
         wuUdHkzD/emtDWaae5ODNqd9uqDeVuBXwmdmZwhAIZK+jJ5OMfLVLDFs9WzLS02quVZp
         LSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689535553; x=1692127553;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSAuqt+s4WpqnMkPR0UJ8Xay9OvKHBk6xAfxVDPkGGQ=;
        b=L5E1hWjoeguaMqAgL8mZzsrHlHGMyH6sYlnRNFTi4NHH83BOsJ4WjlL4PdHaP0UQvZ
         VkDSFJ5VYS7P/AIpmYDypk0NFj4b0A53djZ8AoqCMeuF//YDpdb+zl/JUH4b2REP3HJ2
         CnWHJrsSRf+MmmKFU5cGMXwIOGOP3tFN31jCFo5yGi9psSOxYcxXOQIfbKMLFieOAf6f
         Q3xexCBoymucnEOpRzYGjKSg5cIMNOljutdlCfV3adfkhZXAjsMIPUwkXwj7DJxnMtif
         1uPGh632m1mYXBAL2fWstdT+niAfr9iGPn4aT8G2Gs7eN3F/wZlO0qgEL2hQ7U3FKXqq
         ddwQ==
X-Gm-Message-State: ABy/qLb1uZVtWfTyJ/aDNPLvuVhYIXul5R+XIj1fTPsPsXWidbXEU31r
        IbaYcynHZnkSpbAIMZGHWa1Ae5YsIPeAg4hNSdrTL4vu6Z6nmfSuIbs=
X-Google-Smtp-Source: APBJJlHvGNUdX+Ovjs7gI07fwd/iRKlv+A+q7ObU+aBtLpCouxGSumprEh+gumIKhAED0yGvDqX1C9BaAGBFEGGRinY=
X-Received: by 2002:a1f:db86:0:b0:481:90c6:d059 with SMTP id
 s128-20020a1fdb86000000b0048190c6d059mr855078vkg.2.1689535553336; Sun, 16 Jul
 2023 12:25:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 17 Jul 2023 00:55:42 +0530
Message-ID: <CA+G9fYs5n6aobE04YZy3Qy1ZMhAvH6-uQRqidgFmSoei91iW8g@mail.gmail.com>
Subject: stable-rc 6.1: x86: clang build failed - block/blk-cgroup.c:1237:6:
 error: variable 'ret' is used uninitialized whenever 'if' condition is true
To:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Linux stable-rc 6.1 build failed x86 and i386 with clang.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----------
block/blk-cgroup.c:1237:6: error: variable 'ret' is used uninitialized
whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (init_blkcg_llists(blkcg))
            ^~~~~~~~~~~~~~~~~~~~~~~~
block/blk-cgroup.c:1287:9: note: uninitialized use occurs here
        return ret;
               ^~~
block/blk-cgroup.c:1237:2: note: remove the 'if' if its condition is
always false
        if (init_blkcg_llists(blkcg))
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
block/blk-cgroup.c:1222:33: note: initialize the variable 'ret' to
silence this warning
        struct cgroup_subsys_state *ret;
                                       ^
                                        = NULL
1 error generated.

Links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.38-599-g5071846d06ef/testrun/18327562/suite/build/test/clang-lkftconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SfFoWj9NmKWHRijR0hcoXGjLhr/

 tuxmake \
 --runtime podman --target-arch x86_64 \
 --toolchain clang-16 \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2SfFoWj9NmKWHRijR0hcoXGjLhr/config
\
 LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org
