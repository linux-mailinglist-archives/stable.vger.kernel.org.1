Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54E87752D6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHIGZP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 02:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHIGZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 02:25:14 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41602133
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 23:25:12 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4475fc33c8dso2498899137.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691562311; x=1692167111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CH4TGJEPAdBC6NjBXoK01yC3B5N+WMqmtilRzRbkims=;
        b=f41qEX0W5lLISZ0Nfjc46G7zq/I6E34u/BND0DyKao8ZtoIeCJNHB9tivdYif2qObT
         egfnFaMP3JtWgLS3I0zr7+PPi9NIXZBqvDmRw/k28hztr4io0Agt8lMoxOJ07jAJ/bc5
         tff/XVcVWmkAzVr6cZwX1GVE4Pjt7zo4smTb5ZVbBmLIOVPHO970rQJaQaTOODytR+Od
         ohyo95yl5/+HRm7dIilW7DjUfhaao/zPZzPAIQXsyLaFHe/z5zelyb4alx0d9sPEonkB
         +/+pvYsu3XOIBMSHiM4z958wB3dfpCLqoljlYMf5G92rC5Qagx9/+8S28M7n8IaSuLe+
         bWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691562311; x=1692167111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CH4TGJEPAdBC6NjBXoK01yC3B5N+WMqmtilRzRbkims=;
        b=SfrKSr/8C9pRUp21fo75oHTkKOU79Vm8/lh8P4/XO6G6BPuOcZgvntj03XsnI7YnMH
         zWrc24sqI4hbY1i7zWy/l7Dq5sfh7n7mQslcy2V3r6SATRLMHg2sEI02nLEQ7m3jJ4Lh
         uuzR1V6QwuM5/lX/y12mltQmHG0Bv3ufJ4HtUAJR8ZNBIcCLAQyqXd9EXyDbu4SZVUMv
         sp4EmxQ2IusQqzdfiYhFhTByyOPfVVdVyqeQZsOywIjWstOM1pZr6kl6OwkFthpdHrTz
         0tTB0bLQLU5gjk9qRjOt9vMsKg7OPOW7yrI5nz2QsA3xCNCftvaahHfvRHjqYIwhHVqj
         iyxg==
X-Gm-Message-State: AOJu0Yyk6Lipvow7ohiovpfAMeJpzorkBOBF4QE4Z+Q7e60o7enUgSa4
        YFPv1Vvs12yqfRZE449SIq+LOJ3V4royTmO/kq2DwKpA7zzswYEu
X-Google-Smtp-Source: AGHT+IEollPvCnxSCgZPUkQFllEv9ntre1aTV2g6cdDF/eJM4k4KOdW/tK4KVfKouozYky01aD7Wp2qDzz/Xi+cjCLc=
X-Received: by 2002:a05:6102:3168:b0:443:8a7b:f76d with SMTP id
 l8-20020a056102316800b004438a7bf76dmr2057531vsm.28.1691562310886; Tue, 08 Aug
 2023 23:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com>
In-Reply-To: <CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 11:54:59 +0530
Message-ID: <CA+G9fYvDa-u22+gXt7VRWcQkCJFHvt2FPnjFmbwLX0bY__QrLg@mail.gmail.com>
Subject: Re: ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one
 side of the expression must be absolute
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

also noticed on stable-rc 5.15 and 5.10.

On Wed, 9 Aug 2023 at 11:40, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> While building Linux stable rc 6.1 x86_64 with clang-17 failed due to
> following warnings / errors.
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=x86_64 SRCARCH=x86
> CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> clang' LLVM=1 LLVM_IAS=1
>
> arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:
> unexpected end of section
> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> the expression must be absolute
> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> the expression must be absolute
> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> the expression must be absolute
> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> the expression must be absolute
> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> the expression must be absolute
> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> the expression must be absolute
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> make[2]: Target '__default' not remade because of errors.
> make[1]: *** [Makefile:1255: vmlinux] Error 2
>
>
> Build links,
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/details/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/history/
>
> Steps to reproduce:
>   tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/config
> LLVM=1 LLVM_IAS=1
>   https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/tuxmake_reproducer.sh
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
