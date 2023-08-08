Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56F7742E4
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHHRvp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 13:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHHRvH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 13:51:07 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0B9B4F3D
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 09:22:53 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48719854eb9so1917501e0c.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511752; x=1692116552;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ER6MazoTD3CQHlWxCQhM2lCF8cG+E0zaU5EAB/f7j+8=;
        b=sIy9ru7GTogzBOo8x5rT7CinbvcPeKDICZqg9iwdqwab4ZmE8cbP7NoORXwTqhJS/k
         EFLEGA8fCnCYEa3bJ+iWYUOpvXebqIGGD/KRWtyW02kH0v7YYaz+lTJr7vcesReOOWkq
         yWAhUpcGGiykzdaNs0fWAskUwnN3Y4DRsfq020IGbA/VsS5if59Tz7Wt8rlWYSq/kAQd
         ISwLCZ1orayLXX4bkNjKWsZNbtWzZRP8wK3jXCJVDipwVusEPa5cEI9ZRyYleeMA57Zr
         bf2ZaLRlgj6rGJG1Z82hu1YI36IxsjazRiDRckyMRp/a7xvQBpInmyk1g+ZZigIKs1G4
         C8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511752; x=1692116552;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ER6MazoTD3CQHlWxCQhM2lCF8cG+E0zaU5EAB/f7j+8=;
        b=e/AUSKkPX1NTHQjuMYO6eMeP1CqMDtj/Tq41EzzfVb0apwMt8t48qLSw3JeAaVrxOr
         3+EYUB3VnURngvwsgtp6T1PD5U6H6YZEbzUDTcbbMBtVs5+7Hxj38I9mnexqOXpwG12C
         RAlH4tG8kMO6Nbn9dnPwKy4Ty34Dof4DP1jkg/YF8Yr97sly1josb7o+1uxdivWFDR5b
         u4f0FD0kdyXAbbxKKUGfHQtYAzu/hcgaEWeP50P02LW7/OATzjdUbvqKQn+cVmUCctmR
         CKOB+1FNfYMc1nMtORxb7t0M16aV4K73zMTKFN36vPnJx9M6k2wmOP8EDZk0mxOVuN7u
         NNbw==
X-Gm-Message-State: AOJu0Ywz5jnv9nhPSxRfi0XpQeUm5suzPr7yz308VQRi4n4scI1VsxHW
        8Cpva9DSGHH2oKEzWwUmQoRtYGMW3kFL0HTiaaqZk+KuqKFVcKPKrPM=
X-Google-Smtp-Source: AGHT+IFgWA3xpDQsfZdUGLp22gsHgxbIZreQfEFGW+WmyGTcCFwovG8A0xJB4rFnhbytWJM2qTNiJQlwpo+SSOHoSyk=
X-Received: by 2002:a05:6102:2744:b0:443:64fb:8ec1 with SMTP id
 p4-20020a056102274400b0044364fb8ec1mr5244063vsu.21.1691476173590; Mon, 07 Aug
 2023 23:29:33 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Aug 2023 11:59:22 +0530
Message-ID: <CA+G9fYvPn4N6yPEQauHLXw22AWihQFxyA=twQMDCEwDjXZyYAg@mail.gmail.com>
Subject: stable-rc 5.15: clang-17: drivers/firmware/arm_scmi/smc.c:39:6:
 error: duplicate member 'irq'
To:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

LKFT build plans upgraded to clang-17 and found this failure,

While building stable-rc 5.15 arm with clang-17 failed with below
warnings and errors.

Build log:
----------

drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member 'irq'
   39 |         int irq;
      |             ^
drivers/firmware/arm_scmi/smc.c:34:6: note: previous declaration is here
   34 |         int irq;
      |             ^
drivers/firmware/arm_scmi/smc.c:118:20: error: use of undeclared
identifier 'irq'
  118 |                 scmi_info->irq = irq;
      |                                  ^
2 errors generated.

  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.124-80-g6a5dd0772845/testrun/18864721/suite/build/test/clang-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.124-80-g6a5dd0772845/testrun/18864721/suite/build/test/clang-lkftconfig/details/


Steps to reproduce:
 tuxmake --runtime podman --target-arch arm --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeTE3iE8aq4t1kv169LcMmd9jo/config
LLVM=1 LLVM_IAS=1

  Links:
    - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeTE3iE8aq4t1kv169LcMmd9jo/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
