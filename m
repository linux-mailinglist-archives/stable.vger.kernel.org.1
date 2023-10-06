Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029E17BBFC6
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjJFTk7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTk6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 15:40:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869695
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 12:40:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2778a12.0
        for <stable@vger.kernel.org>; Fri, 06 Oct 2023 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696621255; x=1697226055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giwnefe0AiIi7rCZolwl6BOn/XsQceQpPQ5YuDO483U=;
        b=lZ4VcHHBR7gN+W3oam7F7WuQzkd709chTefppnpAu056nNoElyfSyRxsixKTGXduY5
         hrFi62gaPWhDivud1cX3DdRIsCQ40UdHHmMO+4urtZtjqy38xY/FRsreXgsdgJTUG4CO
         rkim+fKywNKgQs9tEwZRow2TzIXjAq0NkS1HY1tXhMQ+jUDcGPRKCz3YLIwnr9OsMaCn
         uJpQmOUkjzLyGiwF6Z4xoLO/FyDrl+xfskSqgoQ1JCGNrv146fFXQDNT9cK1nuvz6qQZ
         4CpPf1/WTp3ZMsgglMmvCe3oMX0K5PGKBQWBm2Ui/uLZJhRbrUaWM4sKqScDSk34LLGs
         nHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696621255; x=1697226055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giwnefe0AiIi7rCZolwl6BOn/XsQceQpPQ5YuDO483U=;
        b=WPaHITqYjxnzB6TmXujNYJPtu5nKvPxvGjl5wOO6v2vnao9+F4+XbcIfudZnhKiqGU
         wghl5CpwuxylxDTe6EY7kDsJVes22VTiENsCGn8CVOcSkj975PmA0df+3DuR9EXqn4Ci
         Edf5qig+0TCEIgZUFIj5aJnB4wMhCbgHpvBbizi65aWPm8mPIMBbBBMS7kuYHIjst83i
         PlpWDyR5CrUmiQ8hRz4GBw1DloE/eyeOotwUFTOcYu97Ah6fUPjB2U+Yzzi7aBki4ChB
         FsX26SWfsQvyCX2FAH0sHtx+lrm69JybQlh24Ln+Wj4Jb8JQE0GA7rpebO4NQP0dczar
         4ZnA==
X-Gm-Message-State: AOJu0YxniymfmeMTKqJti/6MfBqPEAhrM+E+gqN21zJ2JPDBWLtLEVxx
        NGCdyjwTlQd05LQdiGtss0CVCPGzMTUrwLq3a3fOKQ==
X-Google-Smtp-Source: AGHT+IF2KbJEQsEWkRh1woOaoRKI+1TJoJSwSWf1qgkwO8AvgP6Fc3D3fG6zN4DPjYg0I1OHf1JnAR5W9m6EPT4RUeg=
X-Received: by 2002:a50:9fa4:0:b0:538:5f9e:f0fc with SMTP id
 c33-20020a509fa4000000b005385f9ef0fcmr245886edf.0.1696621254966; Fri, 06 Oct
 2023 12:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230925211034.905320-1-prohr@google.com> <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
 <2023100653-diffusion-brownnose-4671@gregkh> <2023100618-abdominal-unscathed-8d62@gregkh>
 <CANP3RGdnYyEY8mYjcxcj2L-tWrVyN3TS1bb6u41QCR5WKQDf2A@mail.gmail.com> <ZR_69QZ6H4Tr_nUY@sashalap>
In-Reply-To: <ZR_69QZ6H4Tr_nUY@sashalap>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Fri, 6 Oct 2023 12:40:36 -0700
Message-ID: <CANP3RGevdZXoWS2UNfZpQJc34D2fA=ydAJuOSG3JCVgsTe=pJA@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Patrick Rohr <prohr@google.com>, stable@vger.kernel.org,
        Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> >> > > Was this rejected?
> >> > > Any resolution on this (ACK or NAK) would be useful. Thanks!
> >> >
> >> > They are in our "to get to" queue, which is very long still due to
> >> > multiple conferences and travel.
> >> >
> >> > But I will note, you didn't put the git id of the patches in the patches
> >> > themselves, so it will take me extra work to add them there when
> >> > applying.
> >> >
> >> > Also, why just 6.1?  What about newer stable kernels?  You can't update
> >> > and have a regression, right?
> >>
> >> Note, because of this, we can not take these patches now at all anyway :(
> >
> >Because without any knowledge of whether these patches would even be
> >accepted into stable, or whether they would need to go in via ACK,
> >preparing them for more trees seemed like pointless busywork...
>
> FWIW, the above just means that we get to do the busywork rather than
> the submitter...

We're certainly willing to do the work, but we're not entirely sure
what you want,
and whether you will indeed even accept these patches...
We're just trying to be mindful of everyone's time...

For example as a reviewer myself I know that in many cases it is
simply easier to do the
clean (!) cherrypick yourself (you presumably have scripts that
automate the entire thing),
rather than try to verify that someone else's cherrypick is actually
indeed clean.

These patches cleanly cherry pick, build, and pass our tests on
current 6.5 and 6.1 LTS.

git checkout remotes/linux-stable/v6.5.6 && git cherry-pick
1671bcfd76fdc0b9e65153cf759153083755fe4c && git cherry-pick
5027d54a9c30bc7ec808360378e2b4753f053f25 && git cherry-pick
5cb249686e67dbef3ffe53887fa725eefc5a7144  && run_uml_ack_net_test

(and same thing with 6.1.56)

Do you simply want the upstream sha1s?
Or do you want us to follow up with patches?

The situation gets more complex with 5.15 and older:

In this particular case, there are 3 patches, they could (and maybe
even should?)
be squashed into 1 patch for <=5.15 stable.  Greg didn't like that - I
get why - I don't have
an opinion here.  But it does result in complexities... for example:
one of the patches
adds to UAPI (and cannot be trivially cherrypicked to older kernels
because the enum
needs previous enums to be added first), and then the next patch renames it...

There's no clear obviously correct thing to do here, there's at least
a few possibilities:
(a) 4 patches: the first has no upstream equivalent and simply fast
forwards the enum
to the point where the next apply, 3 as clean as possible backports follow up
(b) 3 patches, the first one squashes in all the uapi enum fast forwarding
- including the patch that renames the UAPI constant
(c) just a single squashed patch
(d) we could also cherrypick without the UAPI portions... they're not
terribly important...
(e...) maybe other ways I've missed

Thanks,
- Maciej
