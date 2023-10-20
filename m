Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAD7D0D8A
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376963AbjJTKmu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 06:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbjJTKmu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 06:42:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C9F106;
        Fri, 20 Oct 2023 03:42:48 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2705320B74C0;
        Fri, 20 Oct 2023 03:42:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2705320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697798568;
        bh=hnnVsUjyZV+dpb5bf774eE1FJR1gw5g94Ljn0qCzUP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roXaDV5LOfYsc+JAum0I5rZHl38D78cVf4X+FcnrWAXr25XR75w+NNtQDGBsGtp85
         zznht0rHMR8+y+kMppbuYQvOjF5aMY/AQVIz57GYAo8aqtoR/xC/wzwtKs5yzAsS8j
         hfPuahMC6jRfskUvssxIc8XGTQJSdxMeawdkh1f8=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Fri, 20 Oct 2023 13:42:44 +0300
Message-ID: <5720486.DvuYhMxLoT@pwmachine>
In-Reply-To: <20231020000708.e33ec727fcd322b7cde292cd@kernel.org>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com> <20231019095104.006a7252@gandalf.local.home> <20231020000708.e33ec727fcd322b7cde292cd@kernel.org>
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

Le jeudi 19 octobre 2023, 18:07:08 EEST Masami Hiramatsu a =E9crit :
> On Thu, 19 Oct 2023 09:51:04 -0400
>=20
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 19 Oct 2023 21:18:43 +0900
> >=20
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > So why is this adding stable? (and as Greg's form letter states,
> > > > that's not
> > > > how you do that)
> > > >=20
> > > > I don't see this as a fix but a new feature.
> > >=20
> > > I asked him to make this a fix since the current kprobe event' behavi=
or
> > > is
> > > somewhat strange. It puts the probe on only the "first symbol" if user
> > > specifies a symbol name which has multiple instances. In this case, t=
he
> > > actual probe address can not be solved by name. User must specify the
> > > probe address by unique name + offset. Unless, it can put a probe on
> > > unexpected address, especially if it specifies non-unique symbol +
> > > offset,
> > > the address may NOT be the instruction boundary.
> > > To avoid this issue, it should check the given symbol is unique.
> >=20
> > OK, so what is broken is that when you add a probe to a function that h=
as
> > multiple names, it will attach to the first one and not necessarily the
> > one
> > you want.
> >=20
> > The change log needs to be more explicit in what the "bug" is. It does
> > state this in a round about way, but it is written in a way that it
> > doesn't
> > stand out.
> >=20
> >     Previously to this commit, if func matches several symbols, a kprob=
e,
> >     being either sysfs or PMU, would only be installed for the first
> >     matching address. This could lead to some misunderstanding when some
> >     BPF code was never called because it was attached to a function whi=
ch
> >     was indeed not called, because the effectively called one has no
> >     kprobes attached.
> >    =20
> >     So, this commit returns EADDRNOTAVAIL when func matches several
> >     symbols. This way, user needs to use address to remove the ambiguit=
y.
> >=20
> > What it should say is:
> >     When a kprobe is attached to a function that's name is not unique (=
is
> >     static and shares the name with other functions in the kernel), the
> >     kprobe is attached to the first function it finds. This is a bug as
> >     the
> >     function that it is attaching to is not necessarily the one that the
> >     user wants to attach to.
> >    =20
> >     Instead of blindly picking a function to attach to what is ambiguou=
s,
> >     error with EADDRNOTAVAIL to let the user know that this function is
> >     not
> >     unique, and that the user must use another unique function with an
> >     address offset to get to the function they want to attach to.
>=20
> Great!, yes this looks good to me too.
>=20
> > And yes, it should have:
> >=20
> > Cc: stable@vger.kernel.org
> >=20
> > which is how to mark something for stable, and
> >=20
> > Fixes: ...
> >=20
> > To the commit that caused the bug.
>=20
> Yes, this should be the first one.
>=20
> Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")

Thank you! I should have thought about it nonetheless but I will take more=
=20
care in the future!

> Thank you,
>=20
> > -- Steve

Best regards.


