Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CF78B3B3
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjH1OwP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjH1OwJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 10:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38DCC
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DDA464A0C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 14:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81441C433C7;
        Mon, 28 Aug 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693234326;
        bh=689hsPQmFlOPXUwqRoJiKSQvQ9176u81ZfPPvaoMMcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9U1Hn5yk8TFPMEJJMyMYeiPyw2w4JMvqHpdK7jLvgd3NfJMWytTrM+W1LSGrYuF6
         IX9DFyHxlzR+djm8NuglJJZed9NHfBLfCl/nXNNSWl4FS/kE6wBLV4PbrTxLnWi1DL
         isxhW1rxyblUwX3nA3MBVwqo9mFWz+5rwr9QUnDM=
Date:   Mon, 28 Aug 2023 16:52:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18
 [-Werror,-Wfortify-source]
Message-ID: <2023082853-ladylike-clanking-3dbb@gregkh>
References: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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

Is this also an issue in 6.5?

thanks,

greg k-h
