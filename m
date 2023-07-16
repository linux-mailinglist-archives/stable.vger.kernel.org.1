Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3C754F2B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGPPCq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPPCp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BC1B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4495F60D14
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 15:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53800C433C7;
        Sun, 16 Jul 2023 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689519763;
        bh=551OXyr2rqcyU5MBzPSxaOa63D2qp1Y/FSwgipWiEEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZsFyY4y9NGTwGx5VWG8rmeeJaJVNsupEkOIabBVquVs/TBstbicDwcqXyX6iC7f1
         Ep1MIPMTL805N7EHToEkpnRkWm8QErm9TQSonuMIgwwq+wdQN6+qowNvmKCCrLwpfK
         JhPiumJPC+Ronsh4eDxX1fpkf4w2jiR8MPZN03OY=
Date:   Sun, 16 Jul 2023 17:02:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Apply clang '--target=' KBUILD_CPPFLAGS shuffle to linux-6.4.y
 and linux-6.3.y
Message-ID: <2023071606-relative-facsimile-f994@gregkh>
References: <20230703150339.GA1975402@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703150339.GA1975402@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 03, 2023 at 08:03:39AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please consider applying the following patches to 6.4 and 6.3, they
> should apply cleanly.
> 
> 08f6554ff90e ("mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation")
> a7e5eb53bf9b ("powerpc/vdso: Include CLANG_FLAGS explicitly in ldflags-y")
> cff6e7f50bd3 ("kbuild: Add CLANG_FLAGS to as-instr")
> 43fc0a99906e ("kbuild: Add KBUILD_CPPFLAGS to as-option invocation")
> feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
> 
> They resolve and help avoid build breakage with tip of tree clang, which
> has become a little stricter in the flags that it will accept for a
> particular target, which requires '--target=' to be passed along to all
> invocations of $(CC). Our continuous integration does not currently show
> any breakage with 6.1 and earlier; should these patches be needed there,
> I will send them at a later time.

6.3.y is now end-of-life, but I've queued these up for 6.4.y, thanks.

greg k-h
