Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812247747BB
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjHHTSm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHHTRf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 15:17:35 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6041558F
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 09:40:56 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40fd2f6bd7cso42561371cf.1
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512855; x=1692117655;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WtP3QmQ06KLYCn3fAjdrUm58sT7iL6sP3yIXJVoycmo=;
        b=QlotuWEDq3D8pbnhzrkGdPRBp3+AiEmRl94pZegcc5ukJuPCIbL03BcfGP6zwgNlGE
         YY7fn3Y7w+97RnH6UJ7mzlMWLMGUhQ4lc+5rlGS/FA4nPUx4zyktbCIXxde0XKjaavof
         R+PHIcz5bGjOf0lnJDLIDh2NsryC2jxKHj9SjnKUSQakuRw23byCsX/l0sCP0nanARnp
         qkvLQ2BlcIyqZAbjfxAsZYRqYGJ7B7O9lfgMBQ0iWdgAeAcl9ZbFARMDw37ZfIOxBJtI
         +TL7dSdz0BGoRq0CDIrfH9V3ZyN6EuzY+P7igtWs1dB5/NIRKkMh8fcZ9wv5530HLhmY
         QzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512855; x=1692117655;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtP3QmQ06KLYCn3fAjdrUm58sT7iL6sP3yIXJVoycmo=;
        b=hkkuoE9Cbr23zCtG/aDNoU8JIJ71LfcAPckxHAgY0I8U2Dhuua4ADkiOoBR0vFUlj0
         r0jjJCR6Rgf83Me4yoUEZ/xOb27RYKYMjWKKYejjWhnqoarziLGgMMSZ2IcRXsTtHY3L
         b9ZWGBpODjlcKQO7fKElu6TLrpWH7oP765efkUyZC6vfIR3okvVriRJwMOETHzqiKHaY
         q6n1AiFOjqP3Ld2LKNVRUahwlh+0ePdQDc0T0hi2e1GOpeVYkQH85rupx97A5hA9TN6w
         IbyoCq/t5Ezi4ywLUQmQNfxNpuO4BbzdNYIHqVZo4c6uBoKZeFbSHWQL34GeBD2VmoTY
         0peQ==
X-Gm-Message-State: AOJu0YxuwIofruwzdnx6c2xzkmgzeV3TDcTMI2kyEvu0s5fyC2UF6uis
        UZ9jcQNRRUauZNyNyaC0iacSp4VWGW59rRbtZtcZ9zT3EvuHHCHI/GQ=
X-Google-Smtp-Source: AGHT+IH/ORLoGie8DSR0aDG7zISc2zQiLB0y2ZgDzy1zX6u9DHOqSzd5mzl7lV+J6rvARjvfxypUn+SUccjUySihP8U=
X-Received: by 2002:a1f:c405:0:b0:471:2aa6:41f6 with SMTP id
 u5-20020a1fc405000000b004712aa641f6mr5042329vkf.2.1691475743677; Mon, 07 Aug
 2023 23:22:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Aug 2023 11:52:12 +0530
Message-ID: <CA+G9fYv-fRa2n+8WC3tE5a9Kdu7M0i8jpzU0=BEGV_krDuyctA@mail.gmail.com>
Subject: stable-rc 5.15: clang-17: davinci_all_defconfig failed -
 arch/arm/include/asm/tlbflush.h:420:85: error: use of logical '&&' with
 constant operand [-Werror,-Wconstant-logical-operand]
To:     clang-built-linux <llvm@lists.linux.dev>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

While building stable-rc 5.15 arm davinci_all_defconfig with clang-17 failed
with below warnings and errors.

Build log:
----------

arch/arm/include/asm/tlbflush.h:420:85: error: use of logical '&&'
with constant operand [-Werror,-Wconstant-logical-operand]
  420 |         if (possible_tlb_flags &
(TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^
arch/arm/include/asm/tlbflush.h:420:85: note: use '&' for a bitwise operation
  420 |         if (possible_tlb_flags &
(TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
      |
                            ^~
      |
                            &


  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.124-80-g6a5dd0772845/testrun/18863110/suite/build/test/clang-17-davinci_all_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.124-80-g6a5dd0772845/testrun/18863110/suite/build/test/clang-17-davinci_all_defconfig/details/


Steps to reproduce:
 tuxmake --runtime podman --target-arch arm --toolchain clang-17
--kconfig davinci_all_defconfig LLVM=1 LLVM_IAS=1

  Links:
    - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeUCTfH6lMKlORLREGhmvLic52/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
