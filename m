Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0A757014
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGQW5Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQW5P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 18:57:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF5133
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 15:57:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so46800975e9.3
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689634632; x=1692226632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIUvWxUS5DOMkEZpWJrUZC73gIFBTAM2YXBYO8lXBwg=;
        b=k8ZGXp66NTHZen85OGKkvrZBLpJSXJm/lrk3jO9EGiMMnBH3oApuFs7Y/XQshPAtuP
         pzKE1JyGEG66Z6ki0Bv9IvHwwsC/UwwU84aW4HkB/39byavoReoigrBbcZbvcwbwP5Lx
         bJXV2lgkW1yihYztA8PnVPnCGGfnEM0hp3nDRoL9Ogcqq7y7UWgNkX8h7Y4ckp1mp0Pn
         wsIpUUPop/dxo0vXv/10D0fAlIhpgj6vRK5Z88Pi+eNbNWK5nkG86ufWZuApf5Qb1WAA
         N8V82uZSwXPxKR7P4FRz+Py8KoWGkYsxJBU/Ex2v+V7bi2eHplQVbRPNg35VPlsVmAVo
         +ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689634632; x=1692226632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIUvWxUS5DOMkEZpWJrUZC73gIFBTAM2YXBYO8lXBwg=;
        b=HuM1QBejMIl3+wE1MAnN5OFEfPg/2awefD4jM2jlUeIx/AszEFFbKxJi2dSrFuluUi
         4iatTEh0yIg05tQRtYHLbFDA+lpOd0bhwoiZSDqXDlervlX704EwN2ShDz9micqnnGzy
         A5VF7GZumt5WQV9oLIWTcDGvf+TW5LW4X7Jie5i80//fWHGy/U3Zj3VOHLRGkeEC29M1
         oK0sGFkXAhBjvnkQ/+2NnvlXyAG53JuXh5Ig6g0cuO7HGU8SO1bxl6lu+wTeoi0iaeOb
         mLNjx9ZlAexWxAdfHR26bfMtrnoqMsCTJPn/LoL4qZ6MT5pAfFYtNOh5pUPejTP/mqGT
         oUKA==
X-Gm-Message-State: ABy/qLaDIxVREVX1ICSH8MqkE5u0LBycE1BYnsL9KSaFYbbLOyTB55ss
        pUyrQKib7CsjVQObI8MEZUk=
X-Google-Smtp-Source: APBJJlGEB08RKOzS9g0HWpS/s7DFxTSw6w+AOU+NUqliQjqaknC5LjN0E+r3yD9VtNAqJXL5CmUkRA==
X-Received: by 2002:a7b:cd96:0:b0:3fb:b3aa:1c8f with SMTP id y22-20020a7bcd96000000b003fbb3aa1c8fmr472655wmj.28.1689634632005;
        Mon, 17 Jul 2023 15:57:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d4387000000b00315af025098sm610838wrq.46.2023.07.17.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:57:11 -0700 (PDT)
Message-ID: <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Luiz Capitulino <luizcap@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Date:   Tue, 18 Jul 2023 01:57:10 +0300
In-Reply-To: <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
         <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
         <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
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

On Mon, 2023-07-17 at 10:59 -0400, Luiz Capitulino wrote:
>=20
> On 2023-07-17 10:55, Eduard Zingerman wrote:
>=20
> >=20
> >=20
> >=20
> > On Mon, 2023-07-17 at 09:04 -0400, Luiz Capitulino wrote:
> > > Hi,
> > >=20
> > > The upstream commit below is backported to 5.10.186, 5.15.120 and 6.1=
.36:
> > >=20
> > > """
> > > commit ecdf985d7615356b78241fdb159c091830ed0380
> > > Author: Eduard Zingerman <eddyz87@gmail.com>
> > > Date:   Wed Feb 15 01:20:27 2023 +0200
> > >=20
> > >       bpf: track immediate values written to stack by BPF_ST instruct=
ion
> > > """
> > >=20
> > > This commit is causing the following bpf:test_verifier kselftest to f=
ail:
> > >=20
> > > """
> > > # #760/p precise: ST insn causing spi > allocated_stack FAIL
> > > """
> > >=20
> >=20
> > I can reproduce the error on 6.1.36 but don't understand what's causing=
 it yet.
> > The log is suspiciously different from master, will comment later today=
.
>=20
> Thank you very much for the prompt reply, Eduard.
>=20
> I'm available for further testing if needed.

The test case in question looks as follows:

                           ; old log                 new log
0: R1=3Dctx(off=3D0,imm=3D0)
0: r3 =3D r10                ; R3=3Dfp0 R10=3Dfp0          R3=3Dfp0 R10=3Df=
p0
1: if r3 !=3D 0x7b goto pc+0 ; R3=3Dfp0                  R3=3Dfp0
2: *(u64 *)(r3 -8) =3D 0     ; R3=3Dfp0 fp-8_w=3Dmmmmmmmm  R3=3Dfp0 fp-8_w=
=3D00000000
3: r4 =3D *(u64 *)(r10 -8)   ; R4_w=3Dscalar() R10=3Dfp0   R4_w=3DP0 R10=3D=
fp0 fp-8_w=3D00000000
4: r0 =3D -1                 ; R0=3D-1                   R0=3D-1
5: if r4 > r0 goto pc+0
6: exit

The test checks the log generated by __mark_chain_precision() at
instruction #5: registers `r4` and `r0` should be marked precise
(in that order).

The `r4` and `r0` are marked precise by check_cond_jmp_op() function
because jump #5 is predicted (because comparison is unsigned `r4` is
never greater than -1/`r0`).

Failure happens because only log for `r0` markings is present.

Patch [5] changes processing of instruction #2 ( *(u64 *)(r3 -8) =3D 0; ):
- before patch fp[-8] is marked as mmmmmmmm (any 64-bit scalar value);
- after patch fp[-8] is marked as 00000000.

Which in turn changes processing of instruction #3 ( r4 =3D *(u64 *)(r10 -8=
); ):
- before patch r4 is marked as unbound scalar
- after patch r4 is marked as precise zero
  (check_stack_read_fixed_off() has a special case for zero loads,
   DST registers of such loads are always marked precise).
  =20
If __mark_chain_precision() is called for a register that is already
marked as precise no log is generated. Thus the log looks different
when check_cond_jmp_op() calls __mark_chain_precision() for `r4` and
then for `r0`:
- before patch `r4` is not precise and log for it is generated;
- after patch `r4` is precise and log for it is not generated.

Now a question:
  why does current master has log for both `r4` and `r0`,
  given that commit [5] is present in master?

This happens because of commit [2] (not back-ported to 6.1.36).

Commit [2] adds function mark_all_scalars_imprecise() that removes
precision marks from scalar registers when new state is created in a
state chain (and for this test new states are created before #1 and #5
because of the BPF_F_TEST_STATE_FREQ flag).

Effectively, before #5 is processed by check_cond_jmp_op()
mark_all_scalars_imprecise() undoes `r4`'s precision mark assigned by
check_stack_read_fixed_off() =3D> log for both `r4` and `r0` is present.

I need some time to convince myself that such interaction between
check_stack_read_fixed_off() and mark_all_scalars_imprecise()
is safe, but that's what we have in master.

Commit [2] is a part of a series [4] by Andrii Nakryiko.
This series had been partially back-ported already.
Commits [0,1,2,3] are not yet back-ported and have to be picked
altogether, otherwise there are numerous test failures.

Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` is fai=
ling.
I'll investigate this failure but don't think I'll finish today.

---

Alternatively, if the goal is to minimize amount of changes, we can
disable or modify the 'precise: ST insn causing spi > allocated_stack'.

---

Commits (in chronological order):
[0] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs=
")
[1] f63181b6ae79 ("bpf: stop setting precise in current state")
[2] 7a830b53c17b ("bpf: aggressively forget precise markings during state c=
heckpointing")
[3] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
[4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking improvemen=
ts'")
[5] ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST i=
nstruction")


>=20
> - Luiz
>=20
> >=20
> > > Since this test didn't fail before ecdf985d76 backport, the question =
is
> > > if this is a test bug or if this commit introduced a regression.
> > >=20
> > > I haven't checked if this failure is present in latest Linus tree bec=
ause
> > > I was unable to build & run the bpf kselftests in an older distro.
> > >=20
> > > Also, there some important details about running the bpf kselftests
> > > in 5.10 and 5.15:
> > >=20
> > > * On 5.10, bpf kselftest build is broken. The following upstream
> > > commit needs to be cherry-picked for it to build & run:
> > >=20
> > > """
> > > commit 4237e9f4a96228ccc8a7abe5e4b30834323cd353
> > > Author: Gilad Reti <gilad.reti@gmail.com>
> > > Date:   Wed Jan 13 07:38:08 2021 +0200
> > >=20
> > >       selftests/bpf: Add verifier test for PTR_TO_MEM spill
> > > """
> > >=20
> > > * On 5.15.120 there's one additional test that's failing, but I didn'=
t
> > > debug this one:
> > >=20
> > > """
> > > #150/p calls: trigger reg2btf_ids[reg=E2=86=92type] for reg=E2=86=92t=
ype > __BPF_REG_TYPE_MAX FAIL
> > > FAIL
> > > """
> > >=20
> > > * On 5.11 onwards, building and running bpf tests is disabled by
> > > default by commit 7a6eb7c34a78498742b5f82543b7a68c1c443329, so I wond=
er
> > > if we want to backport this to 5.10 as well?
> > >=20
> > > Thanks!
> > >=20
> > > - Luiz
> > >=20
> >=20

