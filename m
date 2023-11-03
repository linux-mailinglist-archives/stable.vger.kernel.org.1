Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3487E0630
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 17:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjKCQJi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjKCQJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 12:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB35FCA
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 09:09:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB34C433C7;
        Fri,  3 Nov 2023 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699027774;
        bh=rD/G6fU2OweHdy2JyZJRNcFkt8TnAy5FwhEaLHIXf4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNx5vUUytrwsq2duh3LiCvXMGLK3v3jKc3OzSLjf0hUlUpteLyM7VHOV26GxsV5F3
         2OB1DVOaUVDbMBgilGupmOeUJPuAMyvBEiXEMbpGbizEQQ77KW57hz4z4Yg1HaW+Z0
         0JoR1TEoxnRYS89iu+OtgqgKyJnSkEUjpsahp61fzgzIBTaqXZz+PJfq3nRvixGr/g
         OT2CV+S77quFfxMCRW7CSB1p1eVRtm8F3Ng2JknC/LlJ2i/mnrIv8RWd3thqbbriyz
         VgJUnR5l+8tUAqvJMxJbaCdo+7LlyE1grvA59N/7q04cs33Q3GzL43KfTZoHj4uiRz
         M4IOu2r9foViA==
Date:   Fri, 3 Nov 2023 09:09:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: stable-rc: 4.14 and 4.19: arch/x86/kernel/head_32.S:126: Error:
 invalid character '(' in mnemonic
Message-ID: <20231103160932.GA3773786@dev-arch.thelio-3990X>
References: <CA+G9fYtS81+Tze6Zs0f908xXZ7zeMMEdpq65=betjDnyAkLn_g@mail.gmail.com>
 <2023110339-voyage-subtype-e34e@gregkh>
 <2023110344-endeared-wrongful-44b3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110344-endeared-wrongful-44b3@gregkh>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 03, 2023 at 04:59:59PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 03, 2023 at 04:57:40PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 03, 2023 at 09:07:32PM +0530, Naresh Kamboju wrote:
> > > Following warnings and errors have been noticed while building i386 build
> > > on stable-rc linux.4.19.y and linux.4.14.y.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > Build log:
> > > ==========
> > > kernel/profile.c: In function 'profile_dead_cpu':
> > > kernel/profile.c:346:27: warning: the comparison will always evaluate
> > > as 'true' for the address of 'prof_cpu_mask' will never be NULL
> > > [-Waddress]
> > >   346 |         if (prof_cpu_mask != NULL)
> > >       |                           ^~
> > > kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
> > >    49 | static cpumask_var_t prof_cpu_mask;
> > >       |                      ^~~~~~~~~~~~~
> > > kernel/profile.c: In function 'profile_online_cpu':
> > > kernel/profile.c:383:27: warning: the comparison will always evaluate
> > > as 'true' for the address of 'prof_cpu_mask' will never be NULL
> > > [-Waddress]
> > >   383 |         if (prof_cpu_mask != NULL)
> > >       |                           ^~
> > > kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
> > >    49 | static cpumask_var_t prof_cpu_mask;
> > >       |                      ^~~~~~~~~~~~~
> > > kernel/profile.c: In function 'profile_tick':
> > > kernel/profile.c:413:47: warning: the comparison will always evaluate
> > > as 'true' for the address of 'prof_cpu_mask' will never be NULL
> > > [-Waddress]
> > >   413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
> > >       |                                               ^~
> > > kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
> > >    49 | static cpumask_var_t prof_cpu_mask;
> > >       |                      ^~~~~~~~~~~~~
> > 
> > Those are not due to this set of patches, right?
> > 
> > > arch/x86/kernel/head_32.S: Assembler messages:
> > > arch/x86/kernel/head_32.S:126: Error: invalid character '(' in mnemonic
> > > arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
> > > arch/x86/kernel/head_32.S:128: Error: invalid character '(' in mnemonic
> > > arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
> > 
> > This is odd, nothing touches this file either.
> > 
> > 7e09ac27f43b ("x86: Fix .brk attribute in linker script") is backported
> > here, perhaps that is the issue?  If you revert that, does the error go
> > away?
> 
> Nope, that's not the issue.
> 
> > Let me see if I can build a 32 bit kernel anymore...
> 
> I can do this now, let me figure it out...

Sorry, I think this is my bad. 4.14 and 4.19 do not have
SYM_DATA_START() or SYM_DATA_END() but I did not do a 32-bit x86 build
to see the error. I think this should be the fix, it builds for me at
least. Would you prefer a new set of patches for 4.14 and 4.19 or could
this just be squashed in to my existing backport of a1e2c031ec39
("x86/mm: Simplify RESERVE_BRK()")? Sorry for not catching 7e09ac27f43b
as a fix for that either.

Cheers,
Nathan

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e0e6aad9cd51..c5ed79159975 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -123,9 +123,9 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
 .macro __RESERVE_BRK name, size
 	.pushsection .bss..brk, "aw"
-SYM_DATA_START(__brk_\name)
+GLOBAL(__brk_\name)
 	.skip \size
-SYM_DATA_END(__brk_\name)
+END(__brk_\name)
 	.popsection
 .endm
 
