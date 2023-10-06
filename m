Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF17BB1E8
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJFHGf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJFHGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 03:06:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AFCCA
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 00:06:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so9265a12.0
        for <stable@vger.kernel.org>; Fri, 06 Oct 2023 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696575990; x=1697180790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUbfQnkOBDpG97cDqngBEy4QYGmqMANcSRsVDOBTtIg=;
        b=BTatOchSTrbJWyKG+NE4NyH3AVQF4RzwhZCs42izltSbAAjpDre60jYTYrVT/ebKGa
         YyJiVvixIW6vBIlp0zTejreBEzbT41wS8Didvpf71BWldmMfbXNmSjbDO55axbNt9/Bl
         otO4qFUasRHP9ddNUksbCKJhPyhMAEWsojISz2xyNyR9xI/zR+7gL3ZKZNQp0XzoTILK
         Tz8L7AZmaGPTCNz1IbP6USjFxa69YaU6NdVtNdYmPmRSxvMyvYIU3Lt2SLeQhVUKuiPk
         EbC7LG6NG4llDL8mNtylzh/fvaMRtFYCXQ3ft2lodfs1s0B2E+NAyQNUeckzDOsMRJ4z
         o1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696575990; x=1697180790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUbfQnkOBDpG97cDqngBEy4QYGmqMANcSRsVDOBTtIg=;
        b=l0IenXSY6SXAqe2NuQXE7SfyrUCjGzDDbCB+eU0x4D1e6n3EsaDH3JqgP6ZATDkipn
         KFdN1TQg0YgCBZMsdo4tVH2/Rn1FJP8Z8V49WOreO0798GA84me7U33AvCAeAWHy6Qd+
         PUhb+BKSOhpxtv62hUM07gyIQEJS8XG1ZlRarcgu4kWCEL1M8jVtBFINgQhcohFyP0EQ
         aLUKq+AYUDdH9B+V2EXFUEV3nrhKgYCjOC1KFToD+xQQN0HqQd67wBgByEGcBYn7ec22
         Ccd0kTnoYG5NybWUIEWSbwxdjaZtYwO+Rr08LrIvumKkEsVRX7tH33rvKgG02rvekZy2
         q3Yw==
X-Gm-Message-State: AOJu0Yyux4lK6gFSG6Q9vkI1XZfgFoT8heey1CXAGrQuzg8EPgN1iMox
        5tnyh5wuQsUhOe0kC4uvjRtaks1wTejwCkz5mvfLSg==
X-Google-Smtp-Source: AGHT+IGCiYdSqALIlvyh9Mf0XBUXeEAfIO9V2bEkDymMVOJESd3ARxE9TDr7dByO8VHSPaJaa9dqJURdHCKbgjfrt70=
X-Received: by 2002:a50:cd5c:0:b0:538:47bb:3e88 with SMTP id
 d28-20020a50cd5c000000b0053847bb3e88mr167916edj.6.1696575989559; Fri, 06 Oct
 2023 00:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230925211034.905320-1-prohr@google.com> <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
 <2023100653-diffusion-brownnose-4671@gregkh> <2023100618-abdominal-unscathed-8d62@gregkh>
In-Reply-To: <2023100618-abdominal-unscathed-8d62@gregkh>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Fri, 6 Oct 2023 00:06:13 -0700
Message-ID: <CANP3RGdnYyEY8mYjcxcj2L-tWrVyN3TS1bb6u41QCR5WKQDf2A@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Patrick Rohr <prohr@google.com>, stable@vger.kernel.org,
        Lorenzo Colitti <lorenzo@google.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 5, 2023 at 11:21=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Oct 06, 2023 at 07:52:19AM +0200, Greg KH wrote:
> > On Thu, Oct 05, 2023 at 02:37:59PM -0700, Patrick Rohr wrote:
> > > On Mon, Sep 25, 2023 at 2:10=E2=80=AFPM Patrick Rohr <prohr@google.co=
m> wrote:
> > > >
> > > > This series adds a new sysctl accept_ra_min_lft which enforces a mi=
nimum
> > > > lifetime value for individual RA sections; in particular, router
> > > > lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> > > > lifetimes are lower than the configured value, the specific RA sect=
ion
> > > > is ignored.
> > > >
> > > > This fixes a potential denial of service attack vector where rogue =
WiFi
> > > > routers (or devices) can send RAs with low lifetimes to actively dr=
ain a
> > > > mobile device's battery (by preventing sleep).
> > > >
> > > > In addition to this change, Android uses hardware offloads to drop =
RAs
> > > > for a fraction of the minimum of all lifetimes present in the RA (s=
ome
> > > > networks have very frequent RAs (5s) with high lifetimes (2h)). Des=
pite
> > > > this, we have encountered networks that set the router lifetime to =
30s
> > > > which results in very frequent CPU wakeups. Instead of disabling IP=
v6
> > > > (and dropping IPv6 ethertype in the WiFi firmware) entirely on such
> > > > networks, misconfigured routers must be ignored while still process=
ing
> > > > RAs from other IPv6 routers on the same network (i.e. to support Io=
T
> > > > applications).
> > > >
> > > > Patches:
> > > > - 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> > > > - 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA=
 lifetimes")
> > > > - 5cb249686e67 ("net: release reference to inet6_dev pointer")
> > > >
> > > > Patrick Rohr (3):
> > > >   net: add sysctl accept_ra_min_rtr_lft
> > > >   net: change accept_ra_min_rtr_lft to affect all RA lifetimes
> > > >   net: release reference to inet6_dev pointer
> > > >
> > > >  Documentation/networking/ip-sysctl.rst |  8 ++++++++
> > > >  include/linux/ipv6.h                   |  1 +
> > > >  include/uapi/linux/ipv6.h              |  1 +
> > > >  net/ipv6/addrconf.c                    | 13 +++++++++++++
> > > >  net/ipv6/ndisc.c                       | 13 +++++++++++--
> > > >  5 files changed, 34 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > > > 2.42.0.515.g380fc7ccd1-goog
> > > >
> > >
> > > Was this rejected?
> > > Any resolution on this (ACK or NAK) would be useful. Thanks!
> >
> > They are in our "to get to" queue, which is very long still due to
> > multiple conferences and travel.
> >
> > But I will note, you didn't put the git id of the patches in the patche=
s
> > themselves, so it will take me extra work to add them there when
> > applying.
> >
> > Also, why just 6.1?  What about newer stable kernels?  You can't update
> > and have a regression, right?
>
> Note, because of this, we can not take these patches now at all anyway :(
>
> thanks,
>
> greg k-h

Because without any knowledge of whether these patches would even be
accepted into stable, or whether they would need to go in via ACK,
preparing them for more trees seemed like pointless busywork...

If you're willing to take them for all stable (perhaps 5.10+?) trees
I'm sure Patrick can prepare them and resend them.

Would that be OK?
