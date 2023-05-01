Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A916F2F2A
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjEAHdd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjEAHdc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 03:33:32 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1210C6
        for <stable@vger.kernel.org>; Mon,  1 May 2023 00:33:28 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id A24406000B;
        Mon,  1 May 2023 07:33:25 +0000 (UTC)
Message-ID: <dc9c1ba9-a6b5-67f0-4499-f044fbca92f1@ghiti.fr>
Date:   Mon, 1 May 2023 09:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH linux-5.15.y] RISC-V: Fix up a cherry-pick warning in
 setup_vm_final()
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20230429224330.18699-1-palmer@rivosinc.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230429224330.18699-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Palmer,

On 4/30/23 00:43, Palmer Dabbelt wrote:
> This triggers a -Wdeclaration-after-statement as the code has changed a
> bit since upstream.  It might be better to hoist the whole block up, but
> this is a smaller change so I went with it.
>
> arch/riscv/mm/init.c:755:16: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
>              unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
>                            ^
>      1 warning generated.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304300429.SXZOA5up-lkp@intel.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I haven't even build tested this one, but it looks simple enough that I figured
> I'd just send it.  Be warned, though: I broke glibc and missed a merged
> conflict yesterday...
> ---
>   arch/riscv/mm/init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e800d7981e99..8d67f43f1865 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -717,6 +717,7 @@ static void __init setup_vm_final(void)
>   	uintptr_t va, map_size;
>   	phys_addr_t pa, start, end;
>   	u64 i;
> +	unsigned long idx;
>   
>   	/**
>   	 * MMU is enabled at this point. But page table setup is not complete yet.
> @@ -735,7 +736,7 @@ static void __init setup_vm_final(void)
>   	 * directly in swapper_pg_dir in addition to the pgd entry that points
>   	 * to fixmap_pte.
>   	 */
> -	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
> +	idx = pgd_index(__fix_to_virt(FIX_FDT));
>   
>   	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
>   #endif

The above results to in rv64:

../arch/riscv/mm/init.c: In function ‘setup_vm_final’:
../arch/riscv/mm/init.c:720:16: warning: unused variable ‘idx’ 
[-Wunused-variable]
   720 |  unsigned long idx;


The following fixes this warning:


diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8d67f43f1865..e69d82d573f1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -717,7 +717,7 @@ static void __init setup_vm_final(void)
         uintptr_t va, map_size;
         phys_addr_t pa, start, end;
         u64 i;
-       unsigned long idx;
+       unsigned long idx __maybe_unused;

         /**
          * MMU is enabled at this point. But page table setup is not 
complete yet.


Let me know if you want me to send a proper patch as I'm the one to 
blame here.

Thanks for your patch,

Alex

