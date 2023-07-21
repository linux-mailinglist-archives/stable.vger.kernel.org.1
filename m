Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED375BDC7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 07:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGUFaK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 01:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGUFaJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 01:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB5E42
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 22:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC82610A0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FB7C433C8;
        Fri, 21 Jul 2023 05:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689917407;
        bh=rGJf/FE4xP06whSP4jkNWgRIWRLs+ZgEI6+3isujI8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APtqUuU0/RbcQTLPfBBR0tc4gfiaNJ/fXfEEokXH1B6MNhn0I9SvJpTJqMeJYMRrN
         4LSlbOzWzt8KDJ+m3S6FfWlgqYrgrQd/NUVPb4fIlPBJB/7JVfAmwXOsPbVTIViTEF
         NHZplmP24Q1LaSrTR3XLEBtl0ukN3UTOSSyx36a4=
Date:   Fri, 21 Jul 2023 07:30:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
Message-ID: <2023072139-shriek-ranging-bd9e@gregkh>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
 <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
 <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
 <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
 <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
 <2023071846-manlike-drool-d4e2@gregkh>
 <595804fa4937179d83e2317e406f7175ca8c3ec9.camel@gmail.com>
 <96204082-4cb8-038c-ac83-6b1a9f367f3b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96204082-4cb8-038c-ac83-6b1a9f367f3b@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 18, 2023 at 10:58:45AM -0400, Luiz Capitulino wrote:
> 
> 
> On 2023-07-18 09:52, Eduard Zingerman wrote:
> 
> > 
> > 
> > 
> > On Tue, 2023-07-18 at 15:23 +0200, Greg KH wrote:
> > > On Tue, Jul 18, 2023 at 03:31:25PM +0300, Eduard Zingerman wrote:
> > > > On Tue, 2023-07-18 at 01:57 +0300, Eduard Zingerman wrote:
> > > > > [...]
> > > > > Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` is failing.
> > > > > I'll investigate this failure but don't think I'll finish today.
> > > > > 
> > > > > ---
> > > > > 
> > > > > Alternatively, if the goal is to minimize amount of changes, we can
> > > > > disable or modify the 'precise: ST insn causing spi > allocated_stack'.
> > > > > 
> > > > > ---
> > > > > 
> > > > > Commits (in chronological order):
> > > > > [0] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> > > > > [1] f63181b6ae79 ("bpf: stop setting precise in current state")
> > > > > [2] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
> > > > > [3] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
> > > > > [4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking improvements'")
> > > > > [5] ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> > > > 
> > > > I made a mistake, while resolving merge conflict for [0] yesterday.
> > > > After correction the `./test_progs -a setget_sockopt` passes.
> > > > I also noted that the following tests fail on v6.1.36:
> > > > 
> > > >    ./test_progs -a sk_assign,fexit_bpf2bpf
> > > > 
> > > > These tests are fixed by back-porting the following upstream commits:
> > > > - 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
> > > > - 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code")
> > > > 
> > > > I pushed modified version of v6.1.36 to my github account, it has
> > > > test_verifier, test_progs, test_progs-no_alu32 and test_maps passing
> > > > (on my x86 setup):
> > > > 
> > > >    https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes
> > > > 
> > > > Do you need any additional actions from my side?
> > > 
> > > I don't understand, what can I do with a github link?  Can you send us
> > > the patches backported so we can apply them to the stable tree?
> > 
> > Sorry, I'm not familiar with procedure for stable tree patches or
> > who decides what's being picked.
> 
> I'm by no means an authority here, but I'll try to help with what I would
> do myself.
> 
> > Looks like this situation is "Option 3" from [1], rigth?
> 
> Right.
> 
> > After reading that page I'm not sure:
> > - can I bundle all the necessary commits as a patch-set?
> 
> Yes.
> 
> > - a few commits need merging, others could be cherry-picked,
> >    is it possible to submit all of them with [ Upstream commit ... ] marks?
> 
> Yes.
> 
> > Also, as I wrote above, there are two possible solutions:
> > - backport above mentioned patches
> > - adjust the test log
> 
> I think we want to avoid deviating from upstream (Linus tree), but I'm not
> sure if there are valid exceptions.

backporting the mentioned patches is best, can someone send them to us
in email so that we can apply them?

thanks,

greg k-h
