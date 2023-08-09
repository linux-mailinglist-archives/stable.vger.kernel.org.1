Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4AD775295
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 08:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjHIGKj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 02:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHIGKi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 02:10:38 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF721BFB
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 23:10:37 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48726442294so1520005e0c.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691561436; x=1692166236;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mAP9otYoZYL8YVLuWJKzImaXjIZONyavkjX0Z16iqXY=;
        b=VoMQY5MEGvQW2Sn/BZ5I36Q43MTSQJxZ50OV0+ZTJm9o334hTJhreqhtyArCOvf+ql
         nsOIdVQiVYFZq6oZuyVgLs5SKJHVqmUAS47E4VBFaEMeiO3D61x0Gm/390dLmBFhr07W
         xegLe5kDktSNAfK3CiTE7aGO9BK0z7ChnIrd3anI6+zoQg6UWRqd+YP/MrWnvOUhbYFh
         BGYPLZjjH8Yf+2ms3SPvATW2rgviC7WB1mfKOQ+juamSNd/yv5zJoHdvorrcuzl9QKNZ
         cBLMKwShA9JfmNTNSEEi5DfwaACMtlK+YGRUSGib8rvz7KWck9ZarvpM6uCYmxbBP54P
         sVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561436; x=1692166236;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAP9otYoZYL8YVLuWJKzImaXjIZONyavkjX0Z16iqXY=;
        b=cgZk75gNu1QmcDNbUUWk5r+eu2yvLcpP8BDIXkmgK9+NgWCRUX1Ny00L9lT21kDX5D
         eSg4gFpAQNzb5gbiUgvErPW/9Cd80UrZaFi2HCZt4Ly+Shkcpg99RNFyA0JUFYl578Xd
         HhSqJRGVPKpCy50bnxZPNkq6eWBZTltwha4XOzSvqsPWwrHGHrZA3j6RaDyWAHFsRY/6
         NCWPaW3GVzcuRjrbQd8PytmNxpz7pNahUpzDjo4P4Cbcg/Ab/PvW6Td3CS3WeXXu+ZWt
         jKVbDT9DzbJxv2UdHWQQQm4ymvBwpUIkRNSwH90E43UkUehCyxvOm+GfYpl+LqKAKEZp
         g0jQ==
X-Gm-Message-State: AOJu0YxfU+SHIqNp8cTfh+d0QLskePXvVBU03flqTLBmcux59yLNybHA
        FvMwcESNkSBfYeabsflVzMlB1heh5+HAmKOzlWvRo5OWQrK94ZQGKWI=
X-Google-Smtp-Source: AGHT+IGUl+i/1/CdpjinWSQdAsLpUdl2TKLEZq9C9bwE+t8Y+Xo96mKeRxzjQKfhZ8oZrQH+wMoiiLtEhpP9+2JealY=
X-Received: by 2002:a67:ce0a:0:b0:445:2154:746b with SMTP id
 s10-20020a67ce0a000000b004452154746bmr2095474vsl.4.1691561436268; Tue, 08 Aug
 2023 23:10:36 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 11:40:25 +0530
Message-ID: <CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com>
Subject: ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side
 of the expression must be absolute
To:     linux-stable <stable@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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

While building Linux stable rc 6.1 x86_64 with clang-17 failed due to
following warnings / errors.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=x86_64 SRCARCH=x86
CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang' LLVM=1 LLVM_IAS=1

arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:
unexpected end of section
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
the expression must be absolute
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
the expression must be absolute
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
the expression must be absolute
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
the expression must be absolute
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
the expression must be absolute
ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
the expression must be absolute
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[2]: Target '__default' not remade because of errors.
make[1]: *** [Makefile:1255: vmlinux] Error 2


Build links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/history/

Steps to reproduce:
  tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/config
LLVM=1 LLVM_IAS=1
  https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/tuxmake_reproducer.sh


--
Linaro LKFT
https://lkft.linaro.org
