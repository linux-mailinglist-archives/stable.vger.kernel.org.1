Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99B7E05DC
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbjKCP5u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjKCP5t (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 11:57:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272401BF
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 08:57:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A47C433C8;
        Fri,  3 Nov 2023 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699027063;
        bh=bRtoHkjCNRzFtQa/1kUVigxLrxZQ2fwNp7NK0QPtDsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZWYWZKhD9UbGOQR6WYAyKeQ5QSc/NmwlrVBjlRZgqdR7UD8PNrChT6HEdSZz0eBk
         HwmKY9ElDmeSngRAoS5cw6AiVlkyRbneVeVFqkt+DZm/YxGK/JGCdXqIT2bJh+ZorG
         2Tro/N/2r/tRVxinuDgAhxV87OAZ9PsiRv0YRhe4=
Date:   Fri, 3 Nov 2023 16:57:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: stable-rc: 4.14 and 4.19: arch/x86/kernel/head_32.S:126: Error:
 invalid character '(' in mnemonic
Message-ID: <2023110339-voyage-subtype-e34e@gregkh>
References: <CA+G9fYtS81+Tze6Zs0f908xXZ7zeMMEdpq65=betjDnyAkLn_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtS81+Tze6Zs0f908xXZ7zeMMEdpq65=betjDnyAkLn_g@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 03, 2023 at 09:07:32PM +0530, Naresh Kamboju wrote:
> Following warnings and errors have been noticed while building i386 build
> on stable-rc linux.4.19.y and linux.4.14.y.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ==========
> kernel/profile.c: In function 'profile_dead_cpu':
> kernel/profile.c:346:27: warning: the comparison will always evaluate
> as 'true' for the address of 'prof_cpu_mask' will never be NULL
> [-Waddress]
>   346 |         if (prof_cpu_mask != NULL)
>       |                           ^~
> kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
>    49 | static cpumask_var_t prof_cpu_mask;
>       |                      ^~~~~~~~~~~~~
> kernel/profile.c: In function 'profile_online_cpu':
> kernel/profile.c:383:27: warning: the comparison will always evaluate
> as 'true' for the address of 'prof_cpu_mask' will never be NULL
> [-Waddress]
>   383 |         if (prof_cpu_mask != NULL)
>       |                           ^~
> kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
>    49 | static cpumask_var_t prof_cpu_mask;
>       |                      ^~~~~~~~~~~~~
> kernel/profile.c: In function 'profile_tick':
> kernel/profile.c:413:47: warning: the comparison will always evaluate
> as 'true' for the address of 'prof_cpu_mask' will never be NULL
> [-Waddress]
>   413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
>       |                                               ^~
> kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
>    49 | static cpumask_var_t prof_cpu_mask;
>       |                      ^~~~~~~~~~~~~

Those are not due to this set of patches, right?

> arch/x86/kernel/head_32.S: Assembler messages:
> arch/x86/kernel/head_32.S:126: Error: invalid character '(' in mnemonic
> arch/x86/kernel/head_32.S:57:  Info: macro invoked from here
> arch/x86/kernel/head_32.S:128: Error: invalid character '(' in mnemonic
> arch/x86/kernel/head_32.S:57:  Info: macro invoked from here

This is odd, nothing touches this file either.

7e09ac27f43b ("x86: Fix .brk attribute in linker script") is backported
here, perhaps that is the issue?  If you revert that, does the error go
away?

Let me see if I can build a 32 bit kernel anymore...

thanks,

greg k-h
