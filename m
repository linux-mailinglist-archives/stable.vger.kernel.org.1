Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F316577646D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjHIPxR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHIPxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 11:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E21729
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 08:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E58763F8A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 15:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF8DC433C7;
        Wed,  9 Aug 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691596395;
        bh=ALLjYqZbkmaGE+rNCuSF7+oeLIjD7AcQvqF7AIT3qqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVzbUwHl+K6Nn8L5+3YuHWczmQEg73MEzwODZHOixeOvmqhrNBpEk7hQAL7mm+YRI
         0mYMuBCQSjAr59mWtSokDYqA8lAdk0xGiAaUXXKlwrEmZ6isAQowzmi8sWW7N+ZlGd
         zOoarJtHXOtTCYsEO1TWaMxMSwUmuU/IDwajwgTKXRSgEHsjZxScc6u9a76t6bRvY3
         rpf0joPfv2kjB7ZZXb/x3L42kRgpJVQqBwUH6EVlTcqHiwJYANHRQ+Y/QkBpMvt+vF
         KEm6QMY7L0ZCziC0IB9PDWXod1HlexoJCE4uUI7s16ZkxQtmJLCrRTIoMdr+jmaBo+
         TbPqxk4rkhkLg==
Date:   Wed, 9 Aug 2023 08:53:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-stable <stable@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one
 side of the expression must be absolute
Message-ID: <20230809155313.GA835802@dev-arch.thelio-3990X>
References: <CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com>
 <CA+G9fYvDa-u22+gXt7VRWcQkCJFHvt2FPnjFmbwLX0bY__QrLg@mail.gmail.com>
 <CAKwvOdmjAZ9BacrNYHEgGcs=6PExfZkNYe4VWrCwkDCk_pOmyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmjAZ9BacrNYHEgGcs=6PExfZkNYe4VWrCwkDCk_pOmyg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 09, 2023 at 08:47:08AM -0700, Nick Desaulniers wrote:
> Thanks for the report. We're tracking this here
> https://github.com/ClangBuiltLinux/linux/issues/1907
> It was pointed out that PeterZ has a series reworking this code entirely:
> https://lore.kernel.org/lkml/20230809071218.000335006@infradead.org/

As I pointed out in that issue, I don't think that series helps us with
this issue but I will try to test shortly (the patches did not apply
cleanly but I have not looked into why yet).

> On Tue, Aug 8, 2023 at 11:25 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > also noticed on stable-rc 5.15 and 5.10.
> 
> That's troubling if stable is already picking up patches that are
> breaking the build!

Those patches are already released in stable, they were basically
released at the same time as they were merged into mainline:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=linux-6.4.y
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=linux-6.1.y
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=linux-5.15.y
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=linux-5.10.y

Cheers,
Nathan

> > On Wed, 9 Aug 2023 at 11:40, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > While building Linux stable rc 6.1 x86_64 with clang-17 failed due to
> > > following warnings / errors.
> > >
> > > make --silent --keep-going --jobs=8
> > > O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=x86_64 SRCARCH=x86
> > > CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> > > clang' LLVM=1 LLVM_IAS=1
> > >
> > > arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:
> > > unexpected end of section
> > > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> > > the expression must be absolute
> > > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> > > the expression must be absolute
> > > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> > > the expression must be absolute
> > > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> > > the expression must be absolute
> > > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> > > the expression must be absolute
> > > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> > > the expression must be absolute
> > > make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > > make[2]: Target '__default' not remade because of errors.
> > > make[1]: *** [Makefile:1255: vmlinux] Error 2
> > >
> > >
> > > Build links,
> > >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/details/
> > >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconfig/history/
> > >
> > > Steps to reproduce:
> > >   tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
> > > --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/config
> > > LLVM=1 LLVM_IAS=1
> > >   https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrTm9Lb4fakgeTfw/tuxmake_reproducer.sh
> > >
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
