Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98897D0D88
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376913AbjJTKl5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbjJTKl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 06:41:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E627FA4;
        Fri, 20 Oct 2023 03:41:54 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 437DD20B74C0;
        Fri, 20 Oct 2023 03:41:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 437DD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697798514;
        bh=HsF2Ki6Nwx3c8s9m5eNCRQd8T18ufyIajZ7RhPU4MgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JebNamf1bkiAA+Zdaxjc1yx3YjUvG0U4erKEjO374viWJLkUgWpeu7zO4F5KPcU1N
         nWbH5DFe5Yu2/TxyDSzbI6IFaVnj0kdgWDYlk20vz4JxyI9W8tWP1TNNXeZkHKLO1L
         SOS6/ACkP3A2jLAxBIUyjr0+2pkmHZRVoGP6nCv0=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Fri, 20 Oct 2023 13:41:50 +0300
Message-ID: <2703195.mvXUDI8C0e@pwmachine>
In-Reply-To: <20231019095104.006a7252@gandalf.local.home>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com> <20231019211843.56f292be3eee75cdd377e5a2@kernel.org> <20231019095104.006a7252@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi!

Le jeudi 19 octobre 2023, 16:51:04 EEST Steven Rostedt a =E9crit :
> On Thu, 19 Oct 2023 21:18:43 +0900
>=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > So why is this adding stable? (and as Greg's form letter states, that=
's
> > > not
> > > how you do that)
> > >=20
> > > I don't see this as a fix but a new feature.
> >=20
> > I asked him to make this a fix since the current kprobe event' behavior=
 is
> > somewhat strange. It puts the probe on only the "first symbol" if user
> > specifies a symbol name which has multiple instances. In this case, the
> > actual probe address can not be solved by name. User must specify the
> > probe address by unique name + offset. Unless, it can put a probe on
> > unexpected address, especially if it specifies non-unique symbol + offs=
et,
> > the address may NOT be the instruction boundary.
> > To avoid this issue, it should check the given symbol is unique.
>=20
> OK, so what is broken is that when you add a probe to a function that has
> multiple names, it will attach to the first one and not necessarily the o=
ne
> you want.
>=20
> The change log needs to be more explicit in what the "bug" is. It does
> state this in a round about way, but it is written in a way that it doesn=
't
> stand out.
>=20
>     Previously to this commit, if func matches several symbols, a kprobe,
>     being either sysfs or PMU, would only be installed for the first
>     matching address. This could lead to some misunderstanding when some
>     BPF code was never called because it was attached to a function which
>     was indeed not called, because the effectively called one has no
>     kprobes attached.
>=20
>     So, this commit returns EADDRNOTAVAIL when func matches several
>     symbols. This way, user needs to use address to remove the ambiguity.
>=20
>=20
> What it should say is:
>=20
>     When a kprobe is attached to a function that's name is not unique (is
>     static and shares the name with other functions in the kernel), the
>     kprobe is attached to the first function it finds. This is a bug as t=
he
>     function that it is attaching to is not necessarily the one that the
>     user wants to attach to.
>=20
>     Instead of blindly picking a function to attach to what is ambiguous,
>     error with EADDRNOTAVAIL to let the user know that this function is n=
ot
>     unique, and that the user must use another unique function with an
>     address offset to get to the function they want to attach to.

Thank you for the suggestion!
I updated the commit message and I am about to send v6!

> And yes, it should have:
>=20
> Cc: stable@vger.kernel.org
>=20
> which is how to mark something for stable, and

I will for sure remember about it for future contributions! Thank you!

> Fixes: ...
>=20
> To the commit that caused the bug.
>=20
> -- Steve

Best regards.


