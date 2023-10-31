Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB117DD76C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjJaU7y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJaU7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 16:59:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E77BE4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 13:59:51 -0700 (PDT)
Received: from pwmachine.localnet (unknown [86.120.35.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id E18ED20B74C0;
        Tue, 31 Oct 2023 13:59:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E18ED20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698785990;
        bh=wg/nR7Bbk7s/YPYrTk7f70aIFoHvNyyPq6UMEeTVE0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP3x7L4iIxE98K6MRlNnAJt8C8OR2qhuZ+bEQ+ryQOeOzVy/nz+8YjQOxKqWIxtgX
         Nb085pUwXqUslYkfPZQxBAA1ImCVfjel76ZO8i3kRMiT8eyYVIW6gvjuAnes9A8q3N
         xh/JpKKencqH+Q9U4UXy8RpCj3T/vFceOgbatEBk=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5.4.y 0/1] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Tue, 31 Oct 2023 22:59:47 +0200
Message-ID: <2704754.mvXUDI8C0e@pwmachine>
In-Reply-To: <2023103148-bride-railing-ece8@gregkh>
References: <2023102137-mobster-sheath-bfb3@gregkh> <20231023113623.36423-1-flaniel@linux.microsoft.com> <2023103148-bride-railing-ece8@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi!

Le mardi 31 octobre 2023, 16:16:07 EET Greg KH a =E9crit :
> On Mon, Oct 23, 2023 at 02:36:22PM +0300, Francis Laniel wrote:
> > Hi.
> >=20
> >=20
> > There was problem to apply upstream patch on kernel 5.4.
> >=20
> > I adapted the patch and came up with the attached one, it was tested and
> > validated:
> > root@vm-amd64:~# uname -a
> > Linux vm-amd64 5.4.258+ #121 SMP Mon Oct 23 14:22:43 EEST 2023 x86_64
> > GNU/Linux root@vm-amd64:~# echo 'p:probe/name_show name_show' >
> > /sys/kernel/tracing/kprobe_events bash: echo: write error: Cannot assign
> > requested address
> >=20
> > As I had to modify the patch, I would like to get reviews before getting
> > it
> > merged in stable.
> >=20
> > Francis Laniel (1):
> >   tracing/kprobes: Return EADDRNOTAVAIL when func matches several
> >  =20
> >     symbols
> > =20
> >  kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.h  |  1 +
> >  2 files changed, 75 insertions(+)
>=20
> I don't see a 5.10.y version of this, did I miss it somewhere?

No, this is "normal".
As I modified the master patch, I would have liked to get other reviews bef=
ore=20
sending all the batches of patches.
Once everything is validated, I will send patches for the missing version f=
or=20
sure!

> thanks,
>=20
> greg k-h

Best regards.


