Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42975DBF8
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGVLmn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 22 Jul 2023 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjGVLmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 22 Jul 2023 07:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B33269F
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 04:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC206069A
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 11:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C67C433C8;
        Sat, 22 Jul 2023 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690026151;
        bh=Pfv5jJFFH/Y4A8CviCIOzyXsinoHikxguKckksiHoXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUHaZVrnf2GaW1K27t6IXTdglKFH9mMVWdV0KAHr2V/GMpbrv+1cPVFpUU6mHb6bh
         O2U1R4jUrDHk+qoMhR9lVQh5Gq+T/vSjckq8bEFul9ATF5ZE7VRRow9I3W+nSn9DU1
         fWvF7DYhG0IRzkV/hV9DVDXlZdHfi7eo4ExvObow=
Date:   Sat, 22 Jul 2023 13:42:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.4 067/292] x86/fineibt: Poison ENDBR at +0
Message-ID: <2023072217-headfirst-pliable-19f3@gregkh>
References: <20230721160528.800311148@linuxfoundation.org>
 <20230721160531.667102163@linuxfoundation.org>
 <20230721185135.GQ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721185135.GQ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 08:51:35PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 21, 2023 at 06:02:56PM +0200, Greg Kroah-Hartman wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > [ Upstream commit 04505bbbbb15da950ea0239e328a76a3ad2376e0 ]
> > 
> > Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
> > booting on IBT enabled hardware to obtain FineIBT, the indirect
> > functions look like:
> > 
> >   __cfi_foo:
> > 	endbr64
> > 	subl	$hash, %r10d
> > 	jz	1f
> > 	ud2
> > 	nop
> >   1:
> >   foo:
> > 	endbr64
> > 
> > This is because the compiler generates code for kCFI+IBT. In that case
> > the caller does the hash check and will jump to +0, so there must be
> > an ENDBR there. The compiler doesn't know about FineIBT at all; also
> > it is possible to actually use kCFI+IBT when booting with 'cfi=kcfi'
> > on IBT enabled hardware.
> > 
> > Having this second ENDBR however makes it possible to elide the CFI
> > check. Therefore, we should poison this second ENDBR when switching to
> > FineIBT mode.
> > 
> > Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
> > Reported-by: "Milburn, Alyssa" <alyssa.milburn@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> > Link: https://lore.kernel.org/r/20230615193722.194131053@infradead.org
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> If you take this patch you should also take the patches from Brian that
> moves ret_from_fork() into C, otherwise you end up with a non-bootable
> kernel.

Thanks for letting me know, I've just dropped this patch instead for
now.

greg k-h
