Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5D7268CC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFGSdP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFGSdM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900BF1BD0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4ED063BEF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B2CC433D2;
        Wed,  7 Jun 2023 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686162781;
        bh=R3ANen+nYxN6y2OhJU+Wqoin5M/3/8ATRMK3ROqeqcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzNRu7ISd5l4UK3JJuIXR252/aenULzsrVwMXDBzfZFCivBgNQSd3bjhhzuabBrVJ
         sO2VDTaqp77COxkZ81fy9UxOiy6V00xDgngTb/PO7ZRp6JrFoce7cGKPFzLtUccBy6
         NdfAAaJnv/tbhPeR7IpAyOQ9bW7XHmtRzm2VeSJc=
Date:   Wed, 7 Jun 2023 20:32:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, sashal@kernel.org,
        palmer@dabbelt.com, conor@kernel.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, ndesaulniers@google.com, trix@redhat.com,
        stable@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 6.3] riscv: vmlinux.lds.S: Explicitly handle '.got'
 section
Message-ID: <2023060752-chaffing-unable-8b26@gregkh>
References: <20230605-6-3-riscv-got-orphan-warning-llvm-17-v1-1-72c4f11e020f@kernel.org>
 <20230606-exploit-refill-b9311f2378f3@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-exploit-refill-b9311f2378f3@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 11:40:35AM +0100, Conor Dooley wrote:
> On Mon, Jun 05, 2023 at 02:15:08PM -0700, Nathan Chancellor wrote:
> > This patch is for linux-6.3.y only, it has no direct mainline
> > equivalent.
> > 
> > LLVM 17 will now use the GOT for extern weak symbols when using the
> > medany model, which causes a linker orphan section warning on
> > linux-6.3.y:
> > 
> >   ld.lld: warning: <internal>:(.got) is being placed in '.got'
> > 
> > This is not an issue in mainline because handling of the .got section
> > was added by commit 39b33072941f ("riscv: Introduce CONFIG_RELOCATABLE")
> > and further extended by commit 26e7aacb83df ("riscv: Allow to downgrade
> > paging mode from the command line") in 6.4-rc1. Neither of these changes
> > are suitable for stable, so add explicit handling of the .got section in
> > a standalone change to align 6.3 and mainline, which addresses the
> > warning.
> > 
> > This is only an issue for 6.3 because commit f4b71bff8d85 ("riscv:
> > select ARCH_WANT_LD_ORPHAN_WARN for !XIP_KERNEL") landed in 6.3-rc1, so
> > earlier releases will not see this warning because it will not be
> > enabled.
> > 
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1865
> > Link: https://github.com/llvm/llvm-project/commit/a178ba9fbd0a27057dc2fa4cb53c76caa013caac
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Seems reasonable to me chief.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Now queued up,t hanks.

greg k-h
