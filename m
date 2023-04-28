Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B56F1268
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjD1Hde (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjD1Hdd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 03:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3E26B9
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 00:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AED476410E
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD24C433D2;
        Fri, 28 Apr 2023 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682667211;
        bh=0YqcHC7xL7We4+nBgn4QI6rUjwEABJNw+OM2TwZdgLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPki3H3el+YnQ7lg882jIYegPoPf7Om21V06n68KblQmkbEPgxtupMdbLraKe1nTR
         cArdwDYj8dvWN3DSH6LhdoUcPFPVpiz9YEhfD4xI91jZjPqPI7fQGDo3OdhXeG4xVq
         Sld1DZGIyezK8gR+NroY7ZK5MWps5XJG0VYiXu/Y=
Date:   Fri, 28 Apr 2023 09:33:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Can Sun <cansun@arista.com>
Cc:     stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [BACKPORT PATCH 5.10.y] x86/fpu: Prevent FPU state corruption
Message-ID: <2023042821-irritable-persecute-969c@gregkh>
References: <20230427172134.75628-1-cansun@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427172134.75628-1-cansun@arista.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Apr 27, 2023 at 12:21:34PM -0500, Can Sun wrote:
> [ Upstream commit 59f5ede3bc0f00eb856425f636dab0c10feb06d8 ]
> 
> The FPU usage related to task FPU management is either protected by
> disabling interrupts (switch_to, return to user) or via fpregs_lock() which
> is a wrapper around local_bh_disable(). When kernel code wants to use the
> FPU then it has to check whether it is possible by calling irq_fpu_usable().
> 
> But the condition in irq_fpu_usable() is wrong. It allows FPU to be used
> when:
> 
>    !in_interrupt() || interrupted_user_mode() || interrupted_kernel_fpu_idle()
> 
> The latter is checking whether some other context already uses FPU in the
> kernel, but if that's not the case then it allows FPU to be used
> unconditionally even if the calling context interrupted a fpregs_lock()
> critical region. If that happens then the FPU state of the interrupted
> context becomes corrupted.
> 
> Allow in kernel FPU usage only when no other context has in kernel FPU
> usage and either the calling context is not hard interrupt context or the
> hard interrupt did not interrupt a local bottomhalf disabled region.
> 
> It's hard to find a proper Fixes tag as the condition was broken in one way
> or the other for a very long time and the eager/lazy FPU changes caused a
> lot of churn. Picked something remotely connected from the history.
> 
> This survived undetected for quite some time as FPU usage in interrupt
> context is rare, but the recent changes to the random code unearthed it at
> least on a kernel which had FPU debugging enabled. There is probably a
> higher rate of silent corruption as not all issues can be detected by the
> FPU debugging code. This will be addressed in a subsequent change.
> 
> Fixes: 5d2bd7009f30 ("x86, fpu: decouple non-lazy/eager fpu restore from xsave")
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Sun <cansun@arista.com>
> Link: https://lore.kernel.org/r/20220501193102.588689270@linutronix.de

Now queued up, thanks.

greg k-h
