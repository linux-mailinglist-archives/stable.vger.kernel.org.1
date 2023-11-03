Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB27E05AB
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 16:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjKCPhv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjKCPhv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 11:37:51 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561DF112
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 08:37:45 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49e15724283so884644e0c.1
        for <stable@vger.kernel.org>; Fri, 03 Nov 2023 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699025864; x=1699630664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ojkIbumDocsRveIUw6ChK/gXbzpoJDLhwwstkh5qEaE=;
        b=PXNMIINwYi8T7nOk9rwBN6GotKz5WY8XPIRRKFUl3BKeGpNcIOwl+qbocmcEtxfkiP
         1KAp3MIaE0OUPzW/8jNW5TCcxYU9lWzKzagAfNFyWkI5/vwzqJteF5YXpQkElgRnofr8
         +PlGWVVIaitHRZr+A0nwVXfk/hQr2VTWqVVHtToOY/MQiYzn6RkfS7cYnubUGIV6QlUp
         AW+i1ftY5c4t6Udbs3S822BbFiuFug+9OWYgd0l40OBQQcXlx9i6edgFdNsIhfOLsJLo
         SBbqqgmKT6w4yloTuiYDBuwTj3Zb54U9bzB8MzxMMLP8X80bwjph5E679TyUPGyC2PRe
         QuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699025864; x=1699630664;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojkIbumDocsRveIUw6ChK/gXbzpoJDLhwwstkh5qEaE=;
        b=n4D5vPP+kIdrxWtI6YwyMUQ0gv6MmB7wI3H49MalEYR/dPDW5f3pQjfwN6LBZd6qkV
         I2BGVafO41rzisjjNpCjpv3RLcPd3H5cjJX0/7PrJa3RotrF/ozqQuYLmnwF1LYbfJAN
         BSrqYhozF2J5sS6TysqaAYNTSZue0gvFGHRpwUEg77UZ6ds+88z46IyNYL5mSBHbA5zs
         b6Kc8sRDckxSvaqKvNflu7VS2rwAcLoTcVDh89VynbRXCtDUPDTYkuHD1rgKlMcaC4TG
         U7TSiL2zjT4a/PnM6rjU79peHWnbhUadzZjDH/JDwR0IR/yu8gBgGsV0xj/KoVrCoLrn
         H8uA==
X-Gm-Message-State: AOJu0Yx+4a4jCH05vL4VvKy/oz8Zb8w+TZ9iQ4yOYc/uXfodcTigekkl
        Pkpblc8EtXuGlHcTBt6ytdjOw/U4FO5RfUVPnYSrlRTCfG+Xr9TxWqk=
X-Google-Smtp-Source: AGHT+IEs648hOtRJsUo0b8xkFdndm6iBdj+mH3nZAkPw07D4NoaKxGT4nGaAKYQEDX7ehPy6bEiDoJ0EnB+TrOk7meM=
X-Received: by 2002:a1f:1fc8:0:b0:4a8:4218:80b3 with SMTP id
 f191-20020a1f1fc8000000b004a8421880b3mr20585590vkf.7.1699025863965; Fri, 03
 Nov 2023 08:37:43 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Nov 2023 21:07:32 +0530
Message-ID: <CA+G9fYtS81+Tze6Zs0f908xXZ7zeMMEdpq65=betjDnyAkLn_g@mail.gmail.com>
Subject: stable-rc: 4.14 and 4.19: arch/x86/kernel/head_32.S:126: Error:
 invalid character '(' in mnemonic
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Following warnings and errors have been noticed while building i386 build
on stable-rc linux.4.19.y and linux.4.14.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
==========
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
arch/x86/kernel/head_32.S: Assembler messages:
arch/x86/kernel/head_32.S:126: Error: invalid character '(' in mnemonic
arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
arch/x86/kernel/head_32.S:128: Error: invalid character '(' in mnemonic
arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
make[3]: *** [scripts/Makefile.build:403: arch/x86/kernel/head_32.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:544: arch/x86/kernel] Error 2

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.297-41-g46e03d3c6192/testrun/20909218/suite/build/test/gcc-12-lkftconfig-debug-kmemleak/log

--
Linaro LKFT
https://lkft.linaro.org
