Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56407757BD8
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 14:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGRMbb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGRMba (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 08:31:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A9710EB
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 05:31:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so52037445e9.0
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689683488; x=1692275488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qA5mDnh5prJf9FI2+oYh1AdrbFvpWbEyrduG/7YL7k8=;
        b=UJYi69m5++MtH5Ho2YqJK3M1x+IY45LOGF4ZfpTx9Ft/RNv0FHdd2Mq9j+tYG3oSSs
         lXE6X0DLp8zF7MflZBKfZ78LWxkGJ8jKNjx/7rtn8JehpQMfSTDrgjOqp+9WhNYBLONd
         TbR+xa6U5ee5MdW+aMiGHTr+jODA15OPrIsYLAIMdn/A7cdsspb1/YdqjCawA4Z5dadI
         nasahdP9+nXHPiPwHl24JIy0PsNQFs1oxYbAyFzyplyigKiAzAD5HyQ4P5jTxivRzJma
         s1T981q79PeFli5ZB0N7dVnZncDOXVLpiN/2SjQhAYkwfB7LDlxJjIXVECirHeb7foC5
         monw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689683488; x=1692275488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qA5mDnh5prJf9FI2+oYh1AdrbFvpWbEyrduG/7YL7k8=;
        b=NM1N9vlE9mJcz8xZf68vbdU556VAqxOyOUr3s2F/acb1bKAFWu2C5Z6dKJSW5hBfRx
         BxPhN0I0WnnEBza5xFQAM14s3SnPsulHfi4LnpKT81VMb/i7dPExF1YNjSbCPgb+usZr
         64dponO8n3h9k3Q/3nGmsLKkD5RbKezYQagmkMeXgzp+3IsffhPKS6HDCA9scGwo3f3O
         U8aqKao/G/jtuKmyANaXJA2xcvAJfg/jBdzL8i4rTRGeYHObZbklZpzChKgd5+/aJ/6+
         kEHXsGjwFYsTPQD4V9id4JXl+p2uV1PVBIhaYfrNmv4gUJSs89H6d/q+EKhDFu2M3dLz
         owbA==
X-Gm-Message-State: ABy/qLadlwT2uzr0HS8QvSl0Yt1GPdX4v4/nqOAhqKQzLopWT/GNDhvs
        cmGBvEN68uecHkKeTyuecuI=
X-Google-Smtp-Source: APBJJlGUnG4ZoEbmeEoVavaUuej3QYJE0cfOGUdbCEbqb+1i/5EsI0Lmk8FtcvgRFzec05R2mtD0cA==
X-Received: by 2002:a7b:c456:0:b0:3fb:a6ee:4cec with SMTP id l22-20020a7bc456000000b003fba6ee4cecmr1882089wmi.33.1689683487726;
        Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z26-20020a7bc7da000000b003fa999cefc0sm2003096wmk.36.2023.07.18.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
Message-ID: <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Luiz Capitulino <luizcap@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Date:   Tue, 18 Jul 2023 15:31:25 +0300
In-Reply-To: <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
         <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
         <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
         <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
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

On Tue, 2023-07-18 at 01:57 +0300, Eduard Zingerman wrote:
> [...]
> Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` is f=
ailing.
> I'll investigate this failure but don't think I'll finish today.
>=20
> ---
>=20
> Alternatively, if the goal is to minimize amount of changes, we can
> disable or modify the 'precise: ST insn causing spi > allocated_stack'.
>=20
> ---
>=20
> Commits (in chronological order):
> [0] be2ef8161572 ("bpf: allow precision tracking for programs with subpro=
gs")
> [1] f63181b6ae79 ("bpf: stop setting precise in current state")
> [2] 7a830b53c17b ("bpf: aggressively forget precise markings during state=
 checkpointing")
> [3] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
> [4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking improvem=
ents'")
> [5] ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST=
 instruction")

I made a mistake, while resolving merge conflict for [0] yesterday.
After correction the `./test_progs -a setget_sockopt` passes.
I also noted that the following tests fail on v6.1.36:

  ./test_progs -a sk_assign,fexit_bpf2bpf

These tests are fixed by back-porting the following upstream commits:
- 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
- 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_b=
pf2bpf/func_replace_return_code")

I pushed modified version of v6.1.36 to my github account, it has
test_verifier, test_progs, test_progs-no_alu32 and test_maps passing
(on my x86 setup):

  https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes

Do you need any additional actions from my side?
