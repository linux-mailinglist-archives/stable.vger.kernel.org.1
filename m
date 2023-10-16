Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67B7CA0F6
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPHrl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHrk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 03:47:40 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497DAD
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:47:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BC835C02DF;
        Mon, 16 Oct 2023 03:47:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 16 Oct 2023 03:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697442458; x=1697528858; bh=qo
        Z6mHsbpqmJJfj568qz+MSHjcCIscUuZ3p8+87ra4o=; b=oD8qJC08tT77g+Udtv
        vndQaZLTGr16lt6pu9KA08v80hZbhedJEx4F/hRPjQxnY4pm2TbZxfF2Zm54HsDO
        M08yovs8NvWTq/g59+BKVaQ4n1ZAhYRqDf2Tr7yKyYg/Lexdaur0icKQP5o2Our0
        2ud69yPSzZuxZHs1jUfK5PaWy2u47p+ABGgvY0jS86DVph0ah+0W24mVc7UsIVjo
        hsT/NeEDdd3qRvjr+i+HRKMtjsQcvjkh/JL2MBER1cRy4Jqat9ZvbjylhXDu7PDk
        TpfhYBJe1jD5tysgtK1Cfz4M32bcitt/p+2Vzw+DTF168mNvFCbBsjXdIaupf3pw
        p4ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697442458; x=1697528858; bh=qoZ6mHsbpqmJJ
        fj568qz+MSHjcCIscUuZ3p8+87ra4o=; b=PzpLmNry5FeoUjBDcvokZ1GgPFizy
        um9sYGMgjMuZZiqkyiOYWTg5K/ycbC7sDDJx16WLW8ZXTCEZjJdU3upPPBeIBpU3
        mmWX6mKZ4UwZwadm82Xp6l0tg+Z1UYzMYhbKhT8iIPxp7lg51UgSrr806M5sQHBH
        HEQ76ljpmdBgXPoyt7Fa3ajmIjSYEImCvOTqv98HQ39+Q9X4Z31Ex8nZVuDFtLLY
        AR+YnDmMQEX0VuoOhBAODyKujOPf9J8+qDCbdANURVWEDo91y+GGqaGj+2rpHPZ8
        SuPOwWQoHFj03J1NtEWYf9nAtVyYqXs/ibzev6C79P0vrmr5GbL6EW36g==
X-ME-Sender: <xms:meosZfskmti_ch3GmLW99GacFM5p3ZnbkiCIA81wjRiUPAejwmHBJA>
    <xme:meosZQddNcBGqcyDtlhFYQm4yplevlpP8_p2HLwR9zdLsSDrpbV5Vy9JH7kMBYMT3
    jNKMOKClFC33w>
X-ME-Received: <xmr:meosZSw-IZTPGwTSUMgBerAKBDWa00vd5Eb88bprkVCkArwPKpi8uVtISHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieelgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:meosZeNsdq2RnPrevWqJlDnnO4ziKWUTg71vI19pUxkCSApJIA7wxw>
    <xmx:meosZf8SyLihXt8FMCK9MrUoIqE8CQ2ZsjTMBDZBSYNjA8YEfSTm3A>
    <xmx:meosZeXMO5RzuJc7UpykNhlGCkudIRF2ulzhiOx8D97l0oYTZkQEvQ>
    <xmx:muosZQ1j5UaBkMeZvInWWnDJQTiyMulY3P4EHDaSJKh0p6bQhBq5Fg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 03:47:37 -0400 (EDT)
Date:   Mon, 16 Oct 2023 09:47:36 +0200
From:   Greg KH <greg@kroah.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     stable@vger.kernel.org, Fei Yang <fei.yang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] x86/alternatives: Disable KASAN in
 apply_alternatives()
Message-ID: <2023101627-yield-trickle-9105@gregkh>
References: <2023101547-captivate-regress-4cb0@gregkh>
 <20231015200908.3254-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015200908.3254-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 11:09:08PM +0300, Kirill A. Shutemov wrote:
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
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/alternative.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

All now queued up, thanks.

greg k-h
