Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8227B78B392
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjH1Os7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjH1Osn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 10:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971BC1A5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD9F64A5A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 14:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB70FC433C7;
        Mon, 28 Aug 2023 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693234108;
        bh=bEnsuBETn363kdOAj68YWRCqUeK+MuT2Lu1pkca8XRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUZ8/LByqntr2tsVN3+hzMy3MXE4ExGMkJf2S1gxNPOJBCWNIJLmlk93FGkHw5iJS
         3BStSz4CRnb47eTxGOQzCbvBNRVd3rCCuXm6VIurlFwiMlgcYACMCmB/GOOJA8Akk5
         37Cq9ky6/N3JuU+bTizb7zqicev6e4c/AHHtaFIhADf4wFF3KlO3d8v3Gqv9SrUtUr
         Ksl/rxUfrJOubX22WAVMMWMIxdwY80yNFLgNeh8gwlvKWjgk1KOkV8xSYNvBOlsk2S
         WkebQCcASNoN/LjJCyqkSIEq+agb3F8N1LVXUn59QlqOOR635Nc7hDySv6IO0dfyVM
         R786iZCVzYg8A==
Date:   Mon, 28 Aug 2023 07:48:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>
Subject: Re: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18
 [-Werror,-Wfortify-source]
Message-ID: <20230828144826.GA3359762@dev-arch.thelio-3990X>
References: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Naresh,

On Mon, Aug 28, 2023 at 05:57:38PM +0530, Naresh Kamboju wrote:
> [My two cents]
> 
> stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
> following warnings / errors.
> 
> Build errors:
> --------------
> drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
> will always be truncated; specified size is 16, but format string
> expands to at least 18 [-Werror,-Wfortify-source]
>  1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
>       |                 ^
> 1 error generated.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you as always for the report. This is a result of a change in
clang to implement the equivalent of GCC's -Wformat-truncation, which is
currently disabled for the whole kernel in mainline and enabled in W=1
in -next. I have filed an issue to figure out what to do about this:
https://github.com/ClangBuiltLinux/linux/issues/1923

For the record, if you see an issue with clang-nightly that you do not
see with older versions of clang, it is generally an indication that
something has changed on the toolchain side, so it is probably not worth
bothering the stable or subsystem folks with the initial report.
Consider just messaging Nick, myself, and llvm@lists.linux.dev in those
cases so we can pre-triage and bring other folks in as necessary.

That said, this seems like a legitimate warning. As I mentioned above,
GCC shows the same warning with W=1 in -next, so this should be fixed.

  drivers/net/ethernet/qlogic/qed/qed_main.c: In function 'qed_slowpath_start':
  drivers/net/ethernet/qlogic/qed/qed_main.c:1218:63: error: '%02x' directive output truncated writing 2 bytes into a region of size 1 [-Werror=format-truncation=]
   1218 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
        |                                                               ^~~~
  In function 'qed_slowpath_wq_start',
      inlined from 'qed_slowpath_start' at drivers/net/ethernet/qlogic/qed/qed_main.c:1250:6:
  drivers/net/ethernet/qlogic/qed/qed_main.c:1218:43: note: directive argument in the range [0, 255]
   1218 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/ethernet/qlogic/qed/qed_main.c:1218:17: note: 'snprintf' output 18 bytes into a destination of size 16
   1218 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1219 |                          cdev->pdev->bus->number,
        |                          ~~~~~~~~~~~~~~~~~~~~~~~~
   1220 |                          PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
        |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cheers,
Nathan
