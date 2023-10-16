Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8937CB100
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjJPRGP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjJPRFj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 13:05:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFCE3245
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 10:03:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C0C433C8;
        Mon, 16 Oct 2023 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697475788;
        bh=c0eHrb6crqy42yUx6a/Ikws4QNYgC0BkPqi+pVK4sNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJPGXs243U/HoNMe26JuSdmLRAwbpbisODmV/3gSVGw7DDmLCHF1OBvlJ7X3FPaST
         IjuyCZkwWPhDWfjSnCMLr94StBx3+fjC3G3Gh6CdPva0376k4iFfXb6K9jQCgXT+dX
         6swpygw3FJQhdNKjGFUYYJ9Alg6GlsM8M3BHdObg=
Date:   Mon, 16 Oct 2023 19:03:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     fei.yang@intel.com
Cc:     intel-xe@lists.freedesktop.org, lucas.demarchi@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/alternatives: Disable KASAN in
 apply_alternatives()
Message-ID: <2023101650-monogamy-bobbing-33f9@gregkh>
References: <20231016154025.3358622-1-fei.yang@intel.com>
 <20231016154025.3358622-2-fei.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016154025.3358622-2-fei.yang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 08:40:24AM -0700, fei.yang@intel.com wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Fei has reported that KASAN triggers during apply_alternatives() on
> a 5-level paging machine:
> 
> 	BUG: KASAN: out-of-bounds in rcu_is_watching()
> 	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
> 	...
> 	__asan_load4()
> 	rcu_is_watching()
> 	trace_hardirqs_on()
> 	text_poke_early()
> 	apply_alternatives()
> 	...
> 
> On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
> gets patched. It includes KASAN code, where KASAN_SHADOW_START depends on
> __VIRTUAL_MASK_SHIFT, which is defined with cpu_feature_enabled().
> 
> KASAN gets confused when apply_alternatives() patches the
> KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
> static, by replacing __VIRTUAL_MASK_SHIFT with 56, works around the issue.
> 
> Fix it for real by disabling KASAN while the kernel is patching alternatives.
> 
> [ mingo: updated the changelog ]
> 
> Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
> Reported-by: Fei Yang <fei.yang@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20231012100424.1456-1-kirill.shutemov@linux.intel.com
> (cherry picked from commit d35652a5fc9944784f6f50a5c979518ff8dacf61)
> ---
>  arch/x86/kernel/alternative.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

What stable tree(s) is this for?

thanks,

greg k-h
