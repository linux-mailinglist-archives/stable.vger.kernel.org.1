Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C58757E36
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjGRNw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjGRNwY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 09:52:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0540135
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 06:52:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3143798f542so5974004f8f.2
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689688339; x=1692280339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wZZBdQIbQNGxXJYIZfudeA0ZI6jAwYoy336jV6gmZHg=;
        b=eGnedSQvHfpqoi5UAxND1e/Pi9Mhhe1FPNZ8rrpy9AXGn1gnR+ZrTqzgi0RLTQPuGt
         sYBtA0q0Ijqbdi0t7FxKGKL/YvmkF7lrNGG21r2A4Kc59nWQRBMqkclyW4GZ++QGe0ZG
         y/V5omjNT1UsJG0nP/rvEVsUrq1cOiKZ7hc3QvjWOFdvhCcl1Cu2D1WyiXVyPfbYseBK
         zbyZmUWf2+BjhXpkGkHXRkycLpRu/DoE/l13d6rmY7Xw9NA3kRWjfIEcv5ZbzYCPB11A
         3P/xJIy5QDAALYwZbLXoMnM688oUj4aPyHZaf/NmYLy04/RQwvy2PxJkWz20WgcQCqMl
         XcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689688339; x=1692280339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZZBdQIbQNGxXJYIZfudeA0ZI6jAwYoy336jV6gmZHg=;
        b=AVfp2VydESIbqpQr0yyJCRXDGFphLmOQ+f1jj776C/Dtj2cb8FFKFnGrnKO+I5MNcK
         ic+D++vpdHTOs8JB8vgM1jcrj97m06mEzU5eZlEu0Oyyzk0wiIiwH/P8/LY1GbVulY0u
         CTEz4myl3ZSfJxke1b8v1V5rzrxEj1fPtMfiFkK0vRZ36PxFC1k+/6mZRa8lLbxdF0dn
         sFPjPAuzfA3MG2Vly4Puvdwf8l33vRJO/9T9a79gTsITjltorNrBCqjj1AX7klj/GewP
         VTWFfvDxVHSjrNRLQauXuFiaGJFHnnzDzh2yC1x2XNs3L/6Ggx6aGgi85nQGjTjKci8X
         MLgw==
X-Gm-Message-State: ABy/qLaIIJRB4U4PQZ8I5Ej6KpAeEhbAHM10Jq5qiU48l2uayXDnmtEN
        Zc78xfE+UKWNA/d8sKWoRWU=
X-Google-Smtp-Source: APBJJlFohvl5w9MdOMjhqocywVIpSzTPUCtTTrTAd32ECl9ckps/D0bWMqz2uKBZIBcQgM5nYp7mEg==
X-Received: by 2002:adf:ef51:0:b0:314:a3f:9c08 with SMTP id c17-20020adfef51000000b003140a3f9c08mr12559551wrp.39.1689688339023;
        Tue, 18 Jul 2023 06:52:19 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s18-20020adfecd2000000b0031128382ed0sm2471361wro.83.2023.07.18.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:52:18 -0700 (PDT)
Message-ID: <595804fa4937179d83e2317e406f7175ca8c3ec9.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luiz Capitulino <luizcap@amazon.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Date:   Tue, 18 Jul 2023 16:52:17 +0300
In-Reply-To: <2023071846-manlike-drool-d4e2@gregkh>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
         <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
         <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
         <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
         <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
         <2023071846-manlike-drool-d4e2@gregkh>
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

On Tue, 2023-07-18 at 15:23 +0200, Greg KH wrote:
> On Tue, Jul 18, 2023 at 03:31:25PM +0300, Eduard Zingerman wrote:
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
> >   ./test_progs -a sk_assign,fexit_bpf2bpf
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
> >   https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes
> >=20
> > Do you need any additional actions from my side?
>=20
> I don't understand, what can I do with a github link?  Can you send us
> the patches backported so we can apply them to the stable tree?

Sorry, I'm not familiar with procedure for stable tree patches or
who decides what's being picked.
Looks like this situation is "Option 3" from [1], rigth?
After reading that page I'm not sure:
- can I bundle all the necessary commits as a patch-set?
- a few commits need merging, others could be cherry-picked,
  is it possible to submit all of them with [ Upstream commit ... ] marks?

Also, as I wrote above, there are two possible solutions:
- backport above mentioned patches
- adjust the test log

[1] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

>=20
> thanks,
>=20
> greg k-h

