Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E97E06F9
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjKCQsG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjKCQsF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 12:48:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF761B2
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 09:47:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CE8C433C8;
        Fri,  3 Nov 2023 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699030079;
        bh=0fvoRhrmuAohOZBGlEZRHStmY7V4tMJYVpWYa5XHFd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7qlJqPX1Lbdc13li69Su0wF/iw2Tw3evUahHCVzhSxzGs2qwp4zFSctoHZxgOsuQ
         GIoenP6A6aLM+aBW5ogbx4KYjOix0I6Yve/Z8Cu94Ht9Sr3ulWKcL+N4T+cSuIc5QH
         FpYY/33/L+G5d/lPI/XhkgKhpHrv2FhRqlIoNpmY=
Date:   Fri, 3 Nov 2023 17:47:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: stable-rc: 4.14 and 4.19: arch/x86/kernel/head_32.S:126: Error:
 invalid character '(' in mnemonic
Message-ID: <2023110309-rewrite-stuck-d6d0@gregkh>
References: <CA+G9fYtS81+Tze6Zs0f908xXZ7zeMMEdpq65=betjDnyAkLn_g@mail.gmail.com>
 <2023110339-voyage-subtype-e34e@gregkh>
 <2023110344-endeared-wrongful-44b3@gregkh>
 <20231103160932.GA3773786@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103160932.GA3773786@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 03, 2023 at 09:09:32AM -0700, Nathan Chancellor wrote:
> On Fri, Nov 03, 2023 at 04:59:59PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 03, 2023 at 04:57:40PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 03, 2023 at 09:07:32PM +0530, Naresh Kamboju wrote:
> > > > Following warnings and errors have been noticed while building i386 build
> > > > on stable-rc linux.4.19.y and linux.4.14.y.
> > > > 
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > 
> > > > Build log:
> > > > ==========
> > > > kernel/profile.c: In function 'profile_dead_cpu':
> > > > kernel/profile.c:346:27: warning: the comparison will always evaluate
> > > > as 'true' for the address of 'prof_cpu_mask' will never be NULL
> > > > [-Waddress]
> > > >   346 |         if (prof_cpu_mask != NULL)
> > > >       |                           ^~
> > > > kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
> > > >    49 | static cpumask_var_t prof_cpu_mask;
> > > >       |                      ^~~~~~~~~~~~~
> > > > kernel/profile.c: In function 'profile_online_cpu':
> > > > kernel/profile.c:383:27: warning: the comparison will always evaluate
> > > > as 'true' for the address of 'prof_cpu_mask' will never be NULL
> > > > [-Waddress]
> > > >   383 |         if (prof_cpu_mask != NULL)
> > > >       |                           ^~
> > > > kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
> > > >    49 | static cpumask_var_t prof_cpu_mask;
> > > >       |                      ^~~~~~~~~~~~~
> > > > kernel/profile.c: In function 'profile_tick':
> > > > kernel/profile.c:413:47: warning: the comparison will always evaluate
> > > > as 'true' for the address of 'prof_cpu_mask' will never be NULL
> > > > [-Waddress]
> > > >   413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
> > > >       |                                               ^~
> > > > kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
> > > >    49 | static cpumask_var_t prof_cpu_mask;
> > > >       |                      ^~~~~~~~~~~~~
> > > 
> > > Those are not due to this set of patches, right?
> > > 
> > > > arch/x86/kernel/head_32.S: Assembler messages:
> > > > arch/x86/kernel/head_32.S:126: Error: invalid character '(' in mnemonic
> > > > arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
> > > > arch/x86/kernel/head_32.S:128: Error: invalid character '(' in mnemonic
> > > > arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
> > > 
> > > This is odd, nothing touches this file either.
> > > 
> > > 7e09ac27f43b ("x86: Fix .brk attribute in linker script") is backported
> > > here, perhaps that is the issue?  If you revert that, does the error go
> > > away?
> > 
> > Nope, that's not the issue.
> > 
> > > Let me see if I can build a 32 bit kernel anymore...
> > 
> > I can do this now, let me figure it out...
> 
> Sorry, I think this is my bad. 4.14 and 4.19 do not have
> SYM_DATA_START() or SYM_DATA_END() but I did not do a 32-bit x86 build
> to see the error. I think this should be the fix, it builds for me at
> least. Would you prefer a new set of patches for 4.14 and 4.19 or could
> this just be squashed in to my existing backport of a1e2c031ec39
> ("x86/mm: Simplify RESERVE_BRK()")? Sorry for not catching 7e09ac27f43b
> as a fix for that either.
> 
> Cheers,
> Nathan
> 
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index e0e6aad9cd51..c5ed79159975 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -123,9 +123,9 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
>  
>  .macro __RESERVE_BRK name, size
>  	.pushsection .bss..brk, "aw"
> -SYM_DATA_START(__brk_\name)
> +GLOBAL(__brk_\name)
>  	.skip \size
> -SYM_DATA_END(__brk_\name)
> +END(__brk_\name)
>  	.popsection
>  .endm
>  

Yes, Guenter also just bisected to this one:
	https://lore.kernel.org/r/7e8bb270-871f-4324-9c73-d4abfd177b35@roeck-us.net

Let me squash this into the existing commits, thanks.

greg k-h
