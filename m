Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA9761088
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGYKWO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGYKWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:22:13 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB510CB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:22:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 370A85C01A1;
        Tue, 25 Jul 2023 06:22:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 25 Jul 2023 06:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690280531; x=1690366931; bh=jS
        zxzArlF6x3rKYTtxwPn25xjlyx9Dzwn6mxUm9BgQw=; b=sWJ/X+RQ4Kix2uko8M
        +qkuWNW9vFjJlshj03qu+25P0SIbjdLcf7EfGjLOyKg1sCNP78qw7IFDGCbOFEQo
        sfQrAL2M2+L/fL7IuYrD8AidXJ6RGju945gznFGXSw6IxfNgXArRJrVPtm/lFAur
        Wc6xZtApid+m1WCQt6Bao2wlxi7xst2ZmOYXyQN/n8ftl/8mmb3llDFPj6oBh7e0
        2ZddjuFpigN/r+xuRE/ft79k1vMYjCwR3IgbwM8yY6TZQxhmfMPMyMXGCVVpewHA
        qU/RZZhJk6z+qOClvWIbfyLK8Yvvm/ntsM5FSDhh5LMaKg8COoNuQ9Sem70xhzot
        Z64A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690280531; x=1690366931; bh=jSzxzArlF6x3r
        KYTtxwPn25xjlyx9Dzwn6mxUm9BgQw=; b=Wu5OL/21BILvffKerjTMOYA7HGD84
        mGABt2AZglc410vevoNJoJ9HqVr736H7VNgrPB9e9L+SEAS+t37SPTJ6rT0Yucor
        JbiFTLFHeVp7gEku7qUofljpwjEHj8XN1VR+Xd/3zrr1EkiG+VmHh5HOhTda90OM
        jmNmJlL3Fpq2GmhHYYpWUNNk5ZTjMamAWlxL1z8mIGCrSFjg2NGKZcKn7jnPPdQj
        rS6X0v/RoYLRzlPWQGSh6AHa8JPatSrVdsfZew0nVUOzrFEtqT+V8N0GP4Qu5GGK
        bAmTm36oUWspZQVQnliHIioLWFLJxYL0EiOy73LHsnosLG0iO31lXBuDw==
X-ME-Sender: <xms:UqK_ZGitwj1-8u1fM9jjHSVVYbBYNzE2eVYVYcom0pDKFc86TSrE2w>
    <xme:UqK_ZHBhhYdXDw1sMsyPYOb9OUG-F1ldZ1vmKeDRWlCbddguPGrkeoLqB17PafK3c
    Kc9P7ICQQRW9g>
X-ME-Received: <xmr:UqK_ZOF09XNsvIRyReCeEzaawAO9LD4AQTJgsrZN1mamq8lIpG6bamnqLlaRdtECET31-el3IU-pVC8wdf44ipjr0op7p0vVnmZqxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiff
    dvudeffeelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:UqK_ZPRV1Ajm38jGcd4qM4OEHKaTAtO90d2-v-zK_36rTqbMPU-k6g>
    <xmx:UqK_ZDyV1ZiYzXy0CXXMsY_3xRsv4g2Qu_SEn3Vux2jhvD2DRek5dg>
    <xmx:UqK_ZN4OOxP44BQxKdB9uSKFHdXywLDQ-VnL9RSY_3xK9TI2quKAGA>
    <xmx:U6K_ZAiuT-EtP2voXlaKesTPLvyV-K4u3ZGtG5qphDJ9M5BTbARjRQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 06:22:10 -0400 (EDT)
Date:   Tue, 25 Jul 2023 12:22:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     stable@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com,
        mykolal@fb.com, luizcap@amazon.com
Subject: Re: [PATCH 6.1.y v2 0/6] BPF selftests fixes for 6.1 branch
Message-ID: <2023072502-gaffe-legwarmer-85e2@gregkh>
References: <20230724124223.1176479-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724124223.1176479-1-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 03:42:17PM +0300, Eduard Zingerman wrote:
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
> Changelog:
>   V1 -> V2: added missing signed-off-by tags
>   V1: https://lore.kernel.org/stable/20230722004514.767618-1-eddyz87@gmail.com/
> 
> Reported-by: Luiz Capitulino <luizcap@amazon.com>
> 
> Andrii Nakryiko (4):
>   bpf: allow precision tracking for programs with subprogs
>   bpf: stop setting precise in current state
>   bpf: aggressively forget precise markings during state checkpointing
>   selftests/bpf: make test_align selftest more robust
> 
> Ilya Leoshkevich (1):
>   selftests/bpf: Fix sk_assign on s390x
> 
> Yonghong Song (1):
>   selftests/bpf: Workaround verification failure for
>     fexit_bpf2bpf/func_replace_return_code
> 
>  kernel/bpf/verifier.c                         | 202 ++++++++++++++++--
>  .../testing/selftests/bpf/prog_tests/align.c  |  38 ++--
>  .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
>  .../selftests/bpf/progs/connect4_prog.c       |   2 +-
>  .../selftests/bpf/progs/test_sk_assign.c      |  11 +
>  .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
>  6 files changed, 247 insertions(+), 34 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
> 
> -- 
> 2.41.0
> 

All now queued up, thanks.

greg k-h
