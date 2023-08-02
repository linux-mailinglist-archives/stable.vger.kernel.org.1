Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6806076C6D1
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjHBH23 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 03:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjHBH22 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 03:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BED1BF
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 00:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D5E617A5
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 07:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539D0C433C8;
        Wed,  2 Aug 2023 07:28:25 +0000 (UTC)
Date:   Wed, 2 Aug 2023 09:28:23 +0200
From:   Greg KH <greg@kroah.com>
To:     Pu Lehui <pulehui@huawei.com>
Cc:     Pu Lehui <pulehui@huaweicloud.com>, stable@vger.kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 5.10 0/6] Backporting for test_verifier failed
Message-ID: <2023080230-absence-angriness-141b@gregkh>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
 <fe95523c-1adb-c1b8-4259-1e939eff931c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe95523c-1adb-c1b8-4259-1e939eff931c@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 02, 2023 at 03:23:14PM +0800, Pu Lehui wrote:
> Add CC gregkh@linuxfoundation.org

Why?

> I am not sure if the email address of <greg@kroah.com> is valid

It is.

> On 2023/8/1 22:36, Pu Lehui wrote:
> > Luiz Capitulino reported the test_verifier test failed:
> > "precise: ST insn causing spi > allocated_stack".
> > And it was introduced by the following upstream commit:
> > ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> > 
> > Eduard's investigation [4] shows that test failure is not a bug, but a
> > difference in BPF verifier behavior between upstream, where commits
> > [1,2,3] by Andrii are present, and 5.10, where these commits are absent.
> > 
> > Backporting strategy is consistent with Eduard in kernel version 6.1 [5],
> > but with some conflicts in patch #1, #4 and #6 due to the bpf of 5.10
> > doesn't support more features. Both test_verifier and test_maps have
> > passed, while test_progs and test_progs-no_alu32 with no new failure
> > ceses.
> > 
> > Commits of Andrii:
> > [1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> > [2] f63181b6ae79 ("bpf: stop setting precise in current state")
> > [3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
> > 
> > Links:
> > [4] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/
> > [5] https://lore.kernel.org/all/20230724124223.1176479-2-eddyz87@gmail.com/
> > 
> > Andrii Nakryiko (4):
> >    bpf: allow precision tracking for programs with subprogs
> >    bpf: stop setting precise in current state
> >    bpf: aggressively forget precise markings during state checkpointing
> >    selftests/bpf: make test_align selftest more robust
> > 
> > Ilya Leoshkevich (1):
> >    selftests/bpf: Fix sk_assign on s390x
> > 
> > Yonghong Song (1):
> >    selftests/bpf: Workaround verification failure for
> >      fexit_bpf2bpf/func_replace_return_code
> > 
> >   kernel/bpf/verifier.c                         | 175 ++++++++++++++++--
> >   .../testing/selftests/bpf/prog_tests/align.c  |  36 ++--
> >   .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
> >   .../selftests/bpf/progs/connect4_prog.c       |   2 +-
> >   .../selftests/bpf/progs/test_sk_assign.c      |  11 ++
> >   .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
> >   6 files changed, 219 insertions(+), 33 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
> > 

What is the question here for me?

confused,

greg k-h
