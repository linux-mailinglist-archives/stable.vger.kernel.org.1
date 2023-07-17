Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976A756CED
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjGQTOi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGQTOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 15:14:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012861B6
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 12:14:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3141c3a7547so4632412f8f.2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689621272; x=1692213272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ciDL4MGaxZD7VsSeUFRoNTVO/nerzUHqxYceD3kD6c=;
        b=YowEihPmDYL3f7vt6VyXR4eYvt96yk3TCQbLgJlJzcEPO9pXbVjBGUd2ozQrCzSUo7
         JJ7OOqb36NyoE+I3UhghOU26XspNtImFHiNXkGPvsq9yz/yNYrjrBqRi+W1+2fi7dxJy
         DAmbdi10maZG1xeOUQxsdRkjXHoz1HpsqFI+W8znO7stkWuFzokccrV3FUJoFpFquegm
         CsGCKu/aMthNzN3/nD5xq5oBQ9evoddeyzN/H+sL6hwQTFf2qq6iN1MtLgLeZpWsX6ih
         yPitzlyYBJAwfCRMOI0EV2YhhOVqKhA8Ja9TqhPxAcQa8AgFyMWSkyy9PwQzsojPgu7F
         tRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621272; x=1692213272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ciDL4MGaxZD7VsSeUFRoNTVO/nerzUHqxYceD3kD6c=;
        b=EDZWtoaFnEUnmufKyNe357DOtEVyDTeEz3atCLqao65YlTfi2aDK0WbUVsT3DXkyfB
         Dk7DZJsmwCKIflJUUd+RbfxCBJ3EINlEL612WrnMYavTU+PvgfxTIEzR5GefY4dozXO9
         rMEgYPLPioR662YKWePRULb4OIO34TWRM/ZbkKTq88loLIs9xd7YxxnvnWTrotjAk1hh
         on7Bp0fcFNgyXQDN/T2rX5ClI0MWCDbeaG3I0b9c1m0NqCSn2djWA2jpPFnGXfGfp2n9
         CupRNBCRzj54dZo3SQqOTlk/jf5mwpLjiXMiIZso6cP8NH9W0RaWeDQqpPFt52jGio0s
         qpzA==
X-Gm-Message-State: ABy/qLaNiNbGlvaROMVuz6e/Q8VONsEtTpMOhM0XBjfsiY9BDUGtrmbi
        YIxhFWfLRICQ1HKZZmX4Azk=
X-Google-Smtp-Source: APBJJlFoPfPt42qjVWC95DAjabTOVehTHEHRC4ZPNXW3Q6WSQ+OKmeMKGv1Uu2h4cGxOaVKgNhh4Uw==
X-Received: by 2002:a05:6000:128f:b0:30f:af19:81f3 with SMTP id f15-20020a056000128f00b0030faf1981f3mr10102798wrx.41.1689621272188;
        Mon, 17 Jul 2023 12:14:32 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fc00789d5bsm469310wmm.1.2023.07.17.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:14:31 -0700 (PDT)
Message-ID: <82a3eaee09acd603a4d816952eeee1268b459906.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Luiz Capitulino <luizcap@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com
Date:   Mon, 17 Jul 2023 22:14:30 +0300
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

A few observations:
- this is not a bug, precision tracking works a bit differently;
- the patches [1] and [2] (or just [1] but with a minor conflict)
  are sufficient to make behavior similar to master.

I will provided a more detailed explanation in 1-2hr, sorry.

[1] f63181b6ae79 ("bpf: stop setting precise in current state")
[2] 7a830b53c17b ("bpf: aggressively forget precise markings during state c=
heckpointing")

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

