Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1C75E4DD
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGWUdP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGWUdO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 16:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A465E4A
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE3A060E98
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 20:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C839BC433C7;
        Sun, 23 Jul 2023 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690144384;
        bh=bfl5IwI9FmPeFpP5Kll9jl74RxMRQ52DyN+BQ2nOPAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/Dodrs8ce0mr4B9uOTbCnLnUSBkr37eawbRhmHaP6MGmijajnGDOLneEl2lBKMZn
         KSSKQCF5ZZQ9QLGa7N/AYq5TG5l6xeGH6SEsLeX76XHet5Vw1sDFM0+7932lgQTXRo
         00bjowHzvArgfLT1mGNE8m8e9kGn4TgXvnJppxx0=
Date:   Sun, 23 Jul 2023 22:33:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     stable@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com,
        mykolal@fb.com, luizcap@amazon.com
Subject: Re: [PATCH 6.1.y 0/6] BPF selftests fixes for 6.1 branch
Message-ID: <2023072321-sabbath-drank-d58b@gregkh>
References: <20230722004514.767618-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722004514.767618-1-eddyz87@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 22, 2023 at 03:45:08AM +0300, Eduard Zingerman wrote:
> Recently Luiz Capitulino reported BPF test failure for kernel version
> 6.1.36 (see [7]). The following test_verifier test failed:
> "precise: ST insn causing spi > allocated_stack".
> After back-port of the following upstream commit:
> ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> Investigation in [8] shows that test failure is not a bug, but a
> difference in BPF verifier behavior between upstream, where commits
> [1,2,3] by Andrii Nakryiko are present, and 6.1.36, where these
> commits are absent. Both Luiz and Greg suggested back-porting [1,2,3]
> from upstream to avoid divergences.
> 
> Commits [1,2,3] break test_progs selftest "align/packet variable offset",
> commit [4] fixes this selftest.
> 
> I did some additional testing using the following compiler versions:
> - Kernel compilation
>   - gcc version 11.3.0
> - BPF tests compilation
>   - clang version 16.0.6
>   - clang version 17.0.0 (fa46feb31481)
> 
> And identified a few more failing BPF selftests:
> - Tests failing with LLVM 16:
>   - test_verifier:
>     - precise: ST insn causing spi > allocated_stack FAIL (fixed by [1,2,3])
>   - test_progs:
>     - sk_assign                                           (fixed by [6])
> - Tests failing with LLVM 17:
>   - test_verifier:
>     - precise: ST insn causing spi > allocated_stack FAIL (fixed by [1,2,3])
>   - test_progs:
>     - fexit_bpf2bpf/func_replace_verify                   (fixed by [5])
>     - fexit_bpf2bpf/func_replace_return_code              (fixed by [5])
>     - sk_assign                                           (fixed by [6])
> 
> Commits [4,5,6] only apply to BPF selftests and don't change verifier
> behavior.
> 
> After applying all of the listed commits I have test_verifier,
> test_progs, test_progs-no_alu32 and test_maps passing on my x86 setup,
> both for LLVM 16 and LLVM 17.
> 
> Upstream commits in chronological order:
> [1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> [2] f63181b6ae79 ("bpf: stop setting precise in current state")
> [3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
> [4] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
> [5] 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code")
> [6] 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
> 
> Links:
> [7] https://lore.kernel.org/stable/935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com/
> [8] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/
> 
> Reported-by: Luiz Capitulino <luizcap@amazon.com>

You sent a bunch of patches, but didn't sign off on them :(

Can you resend these with your signed-off-by last, as you did do the
work here.

thanks,

greg k-h
