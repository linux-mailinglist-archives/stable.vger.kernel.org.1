Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41D67752C9
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 08:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHIGSL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 02:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHIGSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 02:18:11 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D81FDE
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 23:17:58 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48711283853so2384624e0c.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691561877; x=1692166677;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQSMeOhPWID+hAYQ5u28lD5uNhRG3h0zn8a0Dxu0mRo=;
        b=MaDKhfDY6OioaH3ul/ZIVKWvg5SQK0/v5Es1zG2n6j9O6yxbQj4mOKbRnsWSsGe6ge
         mYGk5UqqLR7yOH0yBE0LoZEW59tXUdojvyTqPbVdINHa3HmNcC4ifK4CEqBdY2+JggK1
         v+Je2a7hmbx2V3BBR9OVtBJWmVTgPVh2H8p2+r782/cSSW/j0pC3lNMu6p3BgYdOZpgN
         WR0OgGqa+4K6ZLhsZqVzq0V8XoACdGJ6ChVJ/H6xDr3EqDW4mgzJHIJ2txI319rLFMZI
         vKbgieP5gmw2rUfkd4cRSKmCFu9ybvCx220PVsgNGvyznJZBO/QDFRmhz5hqmnJVZdtm
         jsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561877; x=1692166677;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQSMeOhPWID+hAYQ5u28lD5uNhRG3h0zn8a0Dxu0mRo=;
        b=VGU1mxIiyI18YdoRxkOTwkk7YT+rtef4nwPz2YWQESwkS+jNW8kpuMZz8XIk+ssNdR
         1BTE42tCt1QrYs2Z/XtTLr9touWP6L4T0E3j8NeAj+74eIaCI/rG77PeNkdLxTUvblXy
         Jdt3edRmXPzS7c4KfUQbbrfejkwcrD2PSQ/j/kPQGGakN0jsJjANrAGyMhkmymdMevIR
         Wh90GfpupyYz6ltZS7FMYSUIJot78opZOymf13dgNOXvkB1RVD5OQLf/xSGXQ72Znrwc
         5bRcJQKBDkDT+3jQMzxS1xIZZdI5mAuuI+HX+8kNoL68rOWJk5+rxVxbMl4370E6PfUP
         igkA==
X-Gm-Message-State: AOJu0YzD5Y4FueNg7XE0EIJp81qOClSXPzzmTVDS26wXha3WUQ2i32Ht
        mt+/zvJnVg9dz+Phv59K/KbH1q6bFNU7t+L8SYKmf/rJP6vRIhcYobg=
X-Google-Smtp-Source: AGHT+IEabjtt82gQh59G1A1/8q98yJW+Kb7rYhcJjLWFesn12qeA67Xgqg3sUSzp8xCNt+JOrtHchYdBbKuJSKHwNzw=
X-Received: by 2002:a67:f64a:0:b0:445:13e:d8ec with SMTP id
 u10-20020a67f64a000000b00445013ed8ecmr1925892vso.3.1691561876811; Tue, 08 Aug
 2023 23:17:56 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 11:47:45 +0530
Message-ID: <CA+G9fYvTjm2oa6mXR=HUe6gYuVaS2nFb_otuvPfmPeKHDoC+Tw@mail.gmail.com>
Subject: stable-rc: 5.15: arm: fsl_dcu_drm_plane.c:176:20: error:
 'drm_plane_helper_destroy' undeclared here
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

While building Linux stable rc 5.15 arm with gcc-13 failed due to
following warnings / errors.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c:176:20: error:
'drm_plane_helper_destroy' undeclared here (not in a function); did
you mean 'drm_primary_helper_destroy'?
  176 |         .destroy = drm_plane_helper_destroy,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~
      |                    drm_primary_helper_destroy
make[5]: *** [scripts/Makefile.build:289:
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.o] Error 1
make[5]: Target '__build' not remade because of errors.
make[4]: *** [scripts/Makefile.build:552: drivers/gpu/drm/fsl-dcu] Error 2
drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate member 'irq'
   39 |         int irq;
      |             ^~~
drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq' undeclared (first
use in this function); did you mean 'rq'?
  118 |                 scmi_info->irq = irq;
      |                                  ^~~
      |                                  rq
drivers/firmware/arm_scmi/smc.c:118:34: note: each undeclared
identifier is reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:289:
drivers/firmware/arm_scmi/smc.o] Error 1


Build links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.125-87-g976c140e8e74/testrun/18920843/suite/build/test/gcc-13-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.125-87-g976c140e8e74/testrun/18920843/suite/build/tests/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTIjkQ8vGDk4J7tsucFMFaqk9/

Steps to reproduce:
  tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTIjkQ8vGDk4J7tsucFMFaqk9/config
  https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTIjkQ8vGDk4J7tsucFMFaqk9/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
