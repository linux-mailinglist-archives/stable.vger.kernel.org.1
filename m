Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63EC757D54
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGRNXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGRNXS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 09:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290FF0
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 06:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8B56157F
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 13:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA88C433C8;
        Tue, 18 Jul 2023 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689686596;
        bh=x7jndEaaqg4RspeRPT2dUTtuLGi4y5qwjafQmaJDVmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4dhwcPVjpChE08PA65RPGf7qHH9y/K1ehAapzBGhhTYwhXi9F70f0KRSq8uHr6sQ
         AedWfMTNPkpUfxzPmBDd6CxnnFQjzlt96uBfST6RnSYrTIsGZEMISKptSD2kpo5tLP
         Qz/nu3RPw5kWrpylhiozBO/9i7VkW7RQouN7zRdQ=
Date:   Tue, 18 Jul 2023 15:23:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Luiz Capitulino <luizcap@amazon.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
Message-ID: <2023071846-manlike-drool-d4e2@gregkh>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
 <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
 <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
 <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
 <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 18, 2023 at 03:31:25PM +0300, Eduard Zingerman wrote:
> On Tue, 2023-07-18 at 01:57 +0300, Eduard Zingerman wrote:
> > [...]
> > Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` is failing.
> > I'll investigate this failure but don't think I'll finish today.
> > 
> > ---
> > 
> > Alternatively, if the goal is to minimize amount of changes, we can
> > disable or modify the 'precise: ST insn causing spi > allocated_stack'.
> > 
> > ---
> > 
> > Commits (in chronological order):
> > [0] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> > [1] f63181b6ae79 ("bpf: stop setting precise in current state")
> > [2] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
> > [3] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
> > [4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking improvements'")
> > [5] ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> I made a mistake, while resolving merge conflict for [0] yesterday.
> After correction the `./test_progs -a setget_sockopt` passes.
> I also noted that the following tests fail on v6.1.36:
> 
>   ./test_progs -a sk_assign,fexit_bpf2bpf
> 
> These tests are fixed by back-porting the following upstream commits:
> - 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
> - 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code")
> 
> I pushed modified version of v6.1.36 to my github account, it has
> test_verifier, test_progs, test_progs-no_alu32 and test_maps passing
> (on my x86 setup):
> 
>   https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes
> 
> Do you need any additional actions from my side?

I don't understand, what can I do with a github link?  Can you send us
the patches backported so we can apply them to the stable tree?

thanks,

greg k-h
