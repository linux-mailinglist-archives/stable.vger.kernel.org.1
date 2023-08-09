Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F63775301
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHIGje (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 02:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjHIGjd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 02:39:33 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DD1BFF
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 23:39:33 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-447be69ae43so1869558137.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691563172; x=1692167972;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3qQgaWeBmt3DtdG2Hl7roraat6kslDvXggsFhAfCiGo=;
        b=pFoLUi4OmmbL1JXEZdtRe6FRQu+8pLO7HWCbWkroAFIFPGGQym60cWCOS6thU/AmyG
         rjfPQ64wUJrJmkHGoEI3mx39yAHbt/0+fmeM82hLZFtE6LtiusDmRrqwKZa9CEX7S5mJ
         r/H1CfhNMmGPBWqr7fwXodjk1ifzkhb2lx1BPxdouDjiK52NwTDsqMlgXzj4F+NKMAW7
         HWzmZpx+zAaOESiR0KrH5J3cOdts5m/I97nKbwsU5mRA8b261vPY3Ag8CjSf9ScYkjrl
         BgRL+AxRTXXyoa+jLlB3yKuluTX2Hsck2u3ZAgUs/+Vda+w3Bx9nggeE4Sky4vrsoFzU
         H/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563172; x=1692167972;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qQgaWeBmt3DtdG2Hl7roraat6kslDvXggsFhAfCiGo=;
        b=OeRLundOdxhVwwdmlTXUxTRpGfs6lnT3j7eO4VypC9lvKC6Uz2+WJeBz0efN/ht5z9
         vebC5hKis3COh+zu9VG5WkC30z0vFq1dr8p5uPJMKOwPOSPrWrt5TubM1R0JufJstagU
         bLwATbSXF7GA1arbffI7lD5AhqwC6ZCOuZknihjXlOTMxsXxHwtrUYlRqpvE/hhR6ROX
         hSmS+bUoif1VhzMvgMJaW8onGSwqHdN4X6OSxYJpV+slyYUE7KPzVc0IKxHEGSsX5/M8
         az/3+tDKoShFM5sghMD7i1lH1E815Jo7nRLsRb9LIYiXN7/9VXvoUga2lqL9y/vyJaP2
         F9gA==
X-Gm-Message-State: AOJu0YwfztYMC78Q5tWeZhA4IvBwLhdpEnq5vqcu8EuzU+wMzGm6OmOu
        DMAhklsnZhet4xXdJomM9qcG+1FARLWE5pQUyx6V4EfLmOWjwoSPcI4=
X-Google-Smtp-Source: AGHT+IEYZvpdTfPAn7yPFj5/Kl5d/bYEMLmh39UH9C9I3yPVT/nkMHLP33yIMIMiAZe35u2OD3RJoqSihYAqLLiVbO4=
X-Received: by 2002:a67:ea04:0:b0:443:7eba:e22c with SMTP id
 g4-20020a67ea04000000b004437ebae22cmr1115292vso.8.1691563171739; Tue, 08 Aug
 2023 23:39:31 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 12:09:20 +0530
Message-ID: <CA+G9fYs+rvyX59MDnZDOLTa-1DZVN1RqKo3K70bmw4iKHVT9TA@mail.gmail.com>
Subject: stable-rc: 5.4: drivers/ata/libahci.c: In function 'ahci_led_store':
 include/linux/compiler.h:419:45: error: call to '__compiletime_assert_123'
 declared with attribute error: BUILD_BUG_ON failed: sizeof(_s) > sizeof(long)
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
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

While building Linux stable rc 5.4 arm with gcc-13 failed due to
following warnings / errors.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/3/build ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
In file included from include/linux/kernel.h:11,
                 from drivers/ata/libahci.c:19:
drivers/ata/libahci.c: In function 'ahci_led_store':
include/linux/compiler.h:419:45: error: call to
'__compiletime_assert_123' declared with attribute error: BUILD_BUG_ON
failed: sizeof(_s) > sizeof(long)
  419 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
include/linux/compiler.h:400:25: note: in definition of macro
'__compiletime_assert'
  400 |                         prefix ## suffix();
         \
      |                         ^~~~~~
include/linux/compiler.h:419:9: note: in expansion of macro
'_compiletime_assert'
  419 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro
'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |         ^~~~~~~~~~~~~~~~
include/linux/nospec.h:60:9: note: in expansion of macro 'BUILD_BUG_ON'
   60 |         BUILD_BUG_ON(sizeof(_s) > sizeof(long));
         \
      |         ^~~~~~~~~~~~
drivers/ata/libahci.c:1142:23: note: in expansion of macro 'array_index_nospec'
 1142 |                 pmp = array_index_nospec(pmp, EM_MAX_SLOTS);
      |                       ^~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:262: drivers/ata/libahci.o] Error

Build links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.252-138-g6540c78c6405/testrun/18922674/suite/build/test/gcc-13-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.252-138-g6540c78c6405/testrun/18922674/suite/build/test/gcc-13-lkftconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiUQ2Oi0YnrXQyA0eCoDEOpw05/

Steps to reproduce:
  tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiUQ2Oi0YnrXQyA0eCoDEOpw05/config
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiUQ2Oi0YnrXQyA0eCoDEOpw05/tuxmake_reproducer.sh


--
Linaro LKFT
https://lkft.linaro.org
