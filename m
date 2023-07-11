Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9474F8F8
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGKUWl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKUWk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9C1705
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944AA615F6
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F40C433C9;
        Tue, 11 Jul 2023 20:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689106958;
        bh=m1MxvCbWRlfEf0wQe9HoM0otl426W69VPyX5edtRn/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uozFtfui3lm48tpP++AzVND+XcEHuRW+uoteX4/Phg/lu3KkJ/wG4NogA97yLmU74
         MKE/lI9u+rGvRRt/YQrUH9/c/E+PZWBlHPH4hMIn4r7vT4BdM79eurjHvkyfxkt0sb
         NMs+QVjh8Vz0vmRK0ZOABLKTsvpkHvk5HN1qXEMI=
Date:   Tue, 11 Jul 2023 22:22:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        vegard.nossum@oracle.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1 1/1] mm/mmap: Fix VM_LOCKED check in
 do_vmi_align_munmap()
Message-ID: <2023071129-charred-epilogue-7ab4@gregkh>
References: <20230711004632.579668-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711004632.579668-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 05:46:32PM -0700, Suren Baghdasaryan wrote:
> 6.1 backport of the patch [1] uses 'next' vma instead of 'split' vma.
> Fix the mistake.
> 
> [1] commit 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
> 
> Fixes: a149174ff8bb ("mm/mmap: Fix error path in do_vmi_align_munmap()")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b8af52db3bbe..1597a96b667f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2484,7 +2484,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  			error = mas_store_gfp(&mas_detach, split, GFP_KERNEL);
>  			if (error)
>  				goto munmap_gather_failed;
> -			if (next->vm_flags & VM_LOCKED)
> +			if (split->vm_flags & VM_LOCKED)
>  				locked_vm += vma_pages(split);
>  
>  			count++;
> -- 
> 2.41.0.390.g38632f3daf-goog
> 

Thanks, now queued up.

greg k-h
