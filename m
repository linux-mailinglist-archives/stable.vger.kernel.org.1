Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC917753E1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 09:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjHIHOU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjHIHON (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 03:14:13 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FF1FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 00:14:13 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so1742817241.1
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691565252; x=1692170052;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PmauzxqIg5eolb+4tF7uxip47SRohmhEiu7Z9r482s=;
        b=wmWkSuzt2J+Qf85Fg8OtMwoRu4JeGSN/n19EWhFQXzuimRPZzLsRYwgjwzcOHCCawG
         lKXAQJjtkxVxxyJjo7h5+wmO9EcfoelSZNKtREW223edtZ838XSJb6IdG6PleHNwB+Xd
         K9JqRusbmvlMLBR1vEKGmEf3pyhiLr/q//VwHTcFP6GuL00Il6426PEhOCHm4zAarFAz
         NDcVtdEwDhS++CKRAPhGg80Hfm4GS74Y+Y0q8rKUOKzlLEaix8WzrjQ8R5ADVI0qhzKe
         /QOm5t7wCNWOmnR2TzAl9rKtRd7VAjvq3W7y7hZFDj6v2lqkxQQhASgVs7l0UddMTLsc
         /WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691565252; x=1692170052;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PmauzxqIg5eolb+4tF7uxip47SRohmhEiu7Z9r482s=;
        b=gsbaaE+nr7sujUhBc+YWQLfE3OuYfP1/tbbpXYEKPUn1HXTlaola+pTGjWlvp27feu
         F7kVhl6t8c243vJR1dKBaMaR3Uq/Uxo/y9URXOv2np5a8Vxs8IdAVkq3jVJlNPVlsUs4
         Z4LNJsd9aCSI0YxNRXBJ/KmqIxolp72eeCg8RQXhX2qkBsUd+rf8isJWWOgIk67k8Mrs
         A7JIqYXIaTY/BEXNcebwBHo/0lLP1CVi/SSopE9SC68VulFklxBm2Frc/O9q16ZWtxl+
         ZaSvbhwwET5tgvYvjqwuva+BrgxcwoR1SK/Khkdvd5/sF/E8AegYZhY5lBWIc2SmZuAq
         evOg==
X-Gm-Message-State: AOJu0YwJ0cMNxwoP2WwJiBHqlbLNHGnInSm+vnUoxbJzLluhyG+Enc9h
        e7Q8Cb1Qb1WzGuX1NK5/QLo4XOjj3drXG7P4DY3oeiLOq+DHFxTdNPI=
X-Google-Smtp-Source: AGHT+IFPiK7KA1u2/Tn7dgJgRuRBVzBvg/WSUi6rjgREpJDg2iPxqT8udoWq7fMg9+5Dy3Wa8mDsCJ8zK8gXHuJQBNE=
X-Received: by 2002:a67:b60c:0:b0:447:68a0:a121 with SMTP id
 d12-20020a67b60c000000b0044768a0a121mr2147564vsm.2.1691565251774; Wed, 09 Aug
 2023 00:14:11 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 12:44:00 +0530
Message-ID: <CA+G9fYt86w3Z+XeZjbjcOq_hvpkx=uUZS3ecH_nQGfBn9KaX3A@mail.gmail.com>
Subject: stable-rc: 4.19: i386: build warnings / errors
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

LKFT build plans updated with toolchain gcc-13 and here is the report.

While building Linux stable rc 4.19 i386 with gcc-13 failed due to
following warnings / errors.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=i386 SRCARCH=x86
CROSS_COMPILE=i686-linux-gnu- 'CC=sccache i686-linux-gnu-gcc'
'HOSTCC=sccache gcc'
kernel/profile.c: In function 'profile_dead_cpu':
kernel/profile.c:346:27: warning: the comparison will always evaluate
as 'true' for the address of 'prof_cpu_mask' will never be NULL
[-Waddress]
  346 |         if (prof_cpu_mask != NULL)
      |                           ^~
kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
   49 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
kernel/profile.c: In function 'profile_online_cpu':
kernel/profile.c:383:27: warning: the comparison will always evaluate
as 'true' for the address of 'prof_cpu_mask' will never be NULL
[-Waddress]
  383 |         if (prof_cpu_mask != NULL)
      |                           ^~
kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
   49 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
kernel/profile.c: In function 'profile_tick':
kernel/profile.c:413:47: warning: the comparison will always evaluate
as 'true' for the address of 'prof_cpu_mask' will never be NULL
[-Waddress]
  413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
      |                                               ^~
kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
   49 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
In file included from include/linux/export.h:45,
                 from include/linux/linkage.h:7,
                 from include/linux/kernel.h:7,
                 from drivers/ata/libahci.c:35:
drivers/ata/libahci.c: In function 'ahci_led_store':
include/linux/compiler.h:418:45: error: call to
'__compiletime_assert_108' declared with attribute error: BUILD_BUG_ON
failed: sizeof(_s) > sizeof(long)
  418 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
include/linux/compiler.h:399:25: note: in definition of macro
'__compiletime_assert'
  399 |                         prefix ## suffix();
         \
      |                         ^~~~~~



Build links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.290-316-g5b47761cf1d6/testrun/18920441/suite/build/test/gcc-13-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.290-316-g5b47761cf1d6/testrun/18920441/suite/build/test/gcc-13-defconfig/log

Steps to reproduce:
   tuxmake --runtime podman --target-arch i386 --toolchain gcc-13
--kconfig defconfig
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiUIlGFjnjPBfuTT62nRnXiZ6i/tuxmake_reproducer.sh


--
Linaro LKFT
https://lkft.linaro.org
