Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA7757FAF
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGROfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjGROfW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 10:35:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54607173F
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 07:35:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so37048895e9.1
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689690908; x=1692282908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kM4rKs2O2D2FKtxI79Px9JsVvtow3vr81NJUN932aok=;
        b=B9AviAeUUzHk7npn++Yjr0w9oLbGcbT3XGuqxm7ukjwTTVwKsH6dhsx4FmWWAw93Ca
         KfYeoe90K/4FORDtYE8JhBea760Tz+6gpY8HjYtM1MN1qccIYJXPXhoz3zI9S7WSAiEF
         UIxarfHAQab6Cz1nSev9elx92YT93uUwY+Ak6nyfax+8TS6J8GrwT3Ug1KSrDrb/o4zx
         yVI2Rmvobtz5NGvmjO+t0djbtsorCSdz/SOO0Q7BYLy7pTzQQq0NyBTiPp/6Gsd+eyKQ
         iGE/AQTYaYGhf98lncSj9r3n4Nh4y+KSGuletAFYc2hkVkGbKRVbxmAX1Af8ikz1KbS/
         rtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690908; x=1692282908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM4rKs2O2D2FKtxI79Px9JsVvtow3vr81NJUN932aok=;
        b=izxPw7/gUFHVXPzsyezqpe68ycO1xKGX+g0kfUs6t9tEZx5+DBt7Mh6nL8NwVKupNH
         +V4rT0CNoYGK60ddwY5v/Hu2Xa60c6+7b9Nn9LA6hXFYxvwzgFVslx6Iu26+r7ou9s1U
         N3iY13iulkhiB9fBSOfVxmbrfanAd/fGoMsAQu2nNvMRyE4tJVumTOp5TwEh3tkUoDro
         OQV9UhJ2cTLKqfyA6HqkAjBmOuz0u4XJ4TI2ne1ld9pc3IymPcVamINS6R/kHZUhk7EU
         WB0B/FQTgPG5QMeGrK+OMc07JgGhXkVPEKyDKySD9Kj1o+AfpXX9BE+g8fH6R4RH54Ai
         X5Cw==
X-Gm-Message-State: ABy/qLZfwhmWrhskcXeEIZpAmTMZ4m/NUP8SSHwOgWCDDE/jO7QpPT+9
        HKMt+lpVpLK5cz0o5qibVK8=
X-Google-Smtp-Source: APBJJlH6m9sK9mjx89Uecj4qm6C1age+m1fGCXkCijQgaie+Dd/vPNHCC5Dk8lLiSNmHc7P0FIhejA==
X-Received: by 2002:a1c:4b0e:0:b0:3fa:9741:5b73 with SMTP id y14-20020a1c4b0e000000b003fa97415b73mr2170669wma.10.1689690907437;
        Tue, 18 Jul 2023 07:35:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n21-20020a1c7215000000b003fbd0c50ba2sm10617406wmc.32.2023.07.18.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:35:07 -0700 (PDT)
Message-ID: <ea1c9d1b9e120bdb8c42b2daefa6d11167208dd9.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Luiz Capitulino <luizcap@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Date:   Tue, 18 Jul 2023 17:35:05 +0300
In-Reply-To: <dd3ecb62-94ca-a08a-01f9-453fe0545ce8@amazon.com>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
         <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
         <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
         <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
         <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
         <dd3ecb62-94ca-a08a-01f9-453fe0545ce8@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 2023-07-18 at 10:06 -0400, Luiz Capitulino wrote:
>=20
> On 2023-07-18 08:31, Eduard Zingerman wrote:
>=20
> >=20
> >=20
> >=20
> > On Tue, 2023-07-18 at 01:57 +0300, Eduard Zingerman wrote:
> > > [...]
> > > Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` =
is failing.
> > > I'll investigate this failure but don't think I'll finish today.
> > >=20
> > > ---
> > >=20
> > > Alternatively, if the goal is to minimize amount of changes, we can
> > > disable or modify the 'precise: ST insn causing spi > allocated_stack=
'.
> > >=20
> > > ---
> > >=20
> > > Commits (in chronological order):
> > > [0] be2ef8161572 ("bpf: allow precision tracking for programs with su=
bprogs")
> > > [1] f63181b6ae79 ("bpf: stop setting precise in current state")
> > > [2] 7a830b53c17b ("bpf: aggressively forget precise markings during s=
tate checkpointing")
> > > [3] 4f999b767769 ("selftests/bpf: make test_align selftest more robus=
t")
> > > [4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking impr=
ovements'")
> > > [5] ecdf985d7615 ("bpf: track immediate values written to stack by BP=
F_ST instruction")
> >=20
> > I made a mistake, while resolving merge conflict for [0] yesterday.
> > After correction the `./test_progs -a setget_sockopt` passes.
> > I also noted that the following tests fail on v6.1.36:
> >=20
> >    ./test_progs -a sk_assign,fexit_bpf2bpf
> >=20
> > These tests are fixed by back-porting the following upstream commits:
> > - 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
> > - 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fex=
it_bpf2bpf/func_replace_return_code")
> >=20
> > I pushed modified version of v6.1.36 to my github account, it has
> > test_verifier, test_progs, test_progs-no_alu32 and test_maps passing
> > (on my x86 setup):
> >=20
> >    https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes
> >=20
> > Do you need any additional actions from my side?
>=20
> First, thank you very much for your work on this and getting the tests
> passing on 6.1.

Thank you.

> In terms of action items, have you checked this situation in 5.10 and
> 5.15? For 5.10, we also need 4237e9f4a96228ccc8a7abe5e4b30834323cd353
> otherwise the bpf tests don't even build there.

Haven't checked 5.15/5.10, will take a look.
Are there any time-frame limitations?
(I'd like to work on this on Wednesday or Thursday)

>=20
> Also, would you know if something important is broken for users or is
> this just a small behavior difference between kernels?

I think it's more like small behavior difference:
- be2ef8161572, f63181b6ae79, 7a830b53c17b are verification
  scalability optimizations, with these patches it is possible
  to load a bit more complex programs (larger programs, or more
  complex branching patterns).
- 4f999b767769, 7ce878ca81bc, 63d78b7e8ca2 - fixes for selftests,
  no new functionality.

Thanks,
Eduard
