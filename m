Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10CC7762C0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjHIOnw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHIOnw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 10:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F11FCC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 07:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4438263C84
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 14:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF1AC433C7;
        Wed,  9 Aug 2023 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592230;
        bh=SPWJfTnbAyDY9DXjwsNoO3N5YSghdMJD2KAlo08kyuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8HUqP58IW1+TxwGGSuVD0eKX0BcuC021V9vGaxKCq62YYnplPFJJFJT4GkCm+1R3
         tHiq5Xe4V6uQ+AQMBhOUHJwyJHZLSZu8aMY1/YXWmlPGPhea27sO9+UeF6FTnZ1ZjE
         aXj+Z8VowJtHdyaFuqYQ8Z5L054I3F+ApjUA9NCOurM2hV6ffTM2DZwBKjyLbyCF0l
         gLAg3wEXRVwKaABDaWtQtewA3P/HPl/dEG17ATWWTGnNMlxyEknFhFox69ECZm0jR2
         ZjHVvBqGfPwhQUoZW+fT0dfZhE3LtWpr1nf1PQgJAfDdlqueOvS+/Zw37UKCbuzAfj
         OVC97Cde4FGBw==
Date:   Wed, 9 Aug 2023 10:43:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, bp@alien8.de
Cc:     linux-stable <stable@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one
 side of the expression must be absolute
Message-ID: <ZNOmJc5WYk9vUE85@sashalap>
References: <CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com>
 <CA+G9fYvDa-u22+gXt7VRWcQkCJFHvt2FPnjFmbwLX0bY__QrLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYvDa-u22+gXt7VRWcQkCJFHvt2FPnjFmbwLX0bY__QrLg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 09, 2023 at 11:54:59AM +0530, Naresh Kamboju wrote:
>also noticed on stable-rc 5.15 and 5.10.
>
>On Wed, 9 Aug 2023 at 11:40, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> While building Linux stable rc 6.1 x86_64 with clang-17 failed due to
>> following warnings / errors.
>>
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=x86_64 SRCARCH=x86
>> CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
>> clang' LLVM=1 LLVM_IAS=1
>>
>> arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:
>> unexpected end of section
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
>> the expression must be absolute
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
>> the expression must be absolute
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
>> the expression must be absolute
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
>> the expression must be absolute
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
>> the expression must be absolute
>> ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
>> the expression must be absolute
>> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
>> make[2]: Target '__default' not remade because of errors.
>> make[1]: *** [Makefile:1255: vmlinux] Error 2
>>
>>
>> Build links,
>>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/
>>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/details/
>>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/history/
>>
>> Steps to reproduce:
>>   tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
>> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/config
>> LLVM=1 LLVM_IAS=1
>>   https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/tuxmake_reproducer.sh

Same here... Bisected to ac41e90d8daa ("x86/srso: Add a Speculative RAS
Overflow mitigation"), so adding in Borislav.

-- 
Thanks,
Sasha
