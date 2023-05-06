Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEF6F8EC2
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEFFvr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjEFFvr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15097EE4
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F697608D3
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D3DC433D2;
        Sat,  6 May 2023 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352292;
        bh=Rk8NCPME9XF2pz/U0ElsAeB7PwFCQM4oV/d+9gKgK50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlXqFmGvkuhMTaePBFpOVDGzRGX97j0CcjsYaPU59lGW3B5hoc5DJszahlgW0s3Yx
         9cMPJ02Dt45YZjRZDkkFIJWs1cPy7bfYrqPnBRvbIFp4NT8+OFZTl3Gw7PASGGa/qv
         sah5KtIzj1EcTKFDmPIjIEBPczMfF/okBQUuE+90=
Date:   Sat, 6 May 2023 09:56:30 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, stable@vger.kernel.org,
        linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH linux-5.15.y] RISC-V: Fix up a cherry-pick warning in
 setup_vm_final()
Message-ID: <2023050606-emote-motion-38b3@gregkh>
References: <20230429224330.18699-1-palmer@rivosinc.com>
 <dc9c1ba9-a6b5-67f0-4499-f044fbca92f1@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc9c1ba9-a6b5-67f0-4499-f044fbca92f1@ghiti.fr>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 01, 2023 at 09:33:25AM +0200, Alexandre Ghiti wrote:
> Hi Palmer,
> 
> On 4/30/23 00:43, Palmer Dabbelt wrote:
> > This triggers a -Wdeclaration-after-statement as the code has changed a
> > bit since upstream.  It might be better to hoist the whole block up, but
> > this is a smaller change so I went with it.
> > 
> > arch/riscv/mm/init.c:755:16: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
> >              unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
> >                            ^
> >      1 warning generated.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202304300429.SXZOA5up-lkp@intel.com/
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> > I haven't even build tested this one, but it looks simple enough that I figured
> > I'd just send it.  Be warned, though: I broke glibc and missed a merged
> > conflict yesterday...
> > ---
> >   arch/riscv/mm/init.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index e800d7981e99..8d67f43f1865 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -717,6 +717,7 @@ static void __init setup_vm_final(void)
> >   	uintptr_t va, map_size;
> >   	phys_addr_t pa, start, end;
> >   	u64 i;
> > +	unsigned long idx;
> >   	/**
> >   	 * MMU is enabled at this point. But page table setup is not complete yet.
> > @@ -735,7 +736,7 @@ static void __init setup_vm_final(void)
> >   	 * directly in swapper_pg_dir in addition to the pgd entry that points
> >   	 * to fixmap_pte.
> >   	 */
> > -	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
> > +	idx = pgd_index(__fix_to_virt(FIX_FDT));
> >   	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
> >   #endif
> 
> The above results to in rv64:
> 
> ../arch/riscv/mm/init.c: In function ‘setup_vm_final’:
> ../arch/riscv/mm/init.c:720:16: warning: unused variable ‘idx’
> [-Wunused-variable]
>   720 |  unsigned long idx;
> 
> 
> The following fixes this warning:
> 
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8d67f43f1865..e69d82d573f1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -717,7 +717,7 @@ static void __init setup_vm_final(void)
>         uintptr_t va, map_size;
>         phys_addr_t pa, start, end;
>         u64 i;
> -       unsigned long idx;
> +       unsigned long idx __maybe_unused;
> 
>         /**
>          * MMU is enabled at this point. But page table setup is not
> complete yet.
> 
> 
> Let me know if you want me to send a proper patch as I'm the one to blame
> here.

As the original fix here will not work, a "correct" one might be best to
have :)

thanks,

greg k-h
