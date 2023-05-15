Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C203A702CF5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbjEOMnO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbjEOMm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108101FF3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5B6362369
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BE3C433D2;
        Mon, 15 May 2023 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684154543;
        bh=HOkG+UVxnBCmc4MhhrAuq/JG3uHv3PD08Turi8wP1Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1TpBLTZlVz+o5/EGyHOtWwLiw3gSKejB/CXgueY/eDaw25dN6nHnKZiozoBPb8b7J
         pUNgNTPq0dBIFwi42gyrkky3+w67S+xfVH5HGCu8qS1KZ0baLwXUXiLMRsYryFC5wk
         +cpl1thfyJGRprH97BZcVMtLquUB9OQZkodeJh6A=
Date:   Mon, 15 May 2023 14:42:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH 5.15.110 v2] RISC-V: Fix up a cherry-pick warning in
 setup_vm_final()
Message-ID: <2023051505-accent-unsmooth-27f4@gregkh>
References: <20230509125141.95587-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509125141.95587-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 02:51:41PM +0200, Alexandre Ghiti wrote:
> This triggers a -Wdeclaration-after-statement as the code has changed a
> bit since upstream.  It might be better to hoist the whole block up, but
> this is a smaller change so I went with it.
> 
> arch/riscv/mm/init.c:755:16: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
>              unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
>                            ^
>      1 warning generated.
> 
> Fixes: bbf94b042155 ("riscv: Move early dtb mapping into the fixmap region")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304300429.SXZOA5up-lkp@intel.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> v2:
> - Fix rv64 warning introduced by the v1
> - Add Fixes tag

Now queued up, thanks.

greg k-h
