Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC13781306
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379480AbjHRSpw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379476AbjHRSp0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 14:45:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E903A98
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 11:45:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5259cf39154so1545588a12.2
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692384321; x=1692989121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OpUekKOL7rOGJBNxIgNqZBQH13Oof9rm7gx23Q+vF4=;
        b=vAtdehoo6I1lNDfKtGjfJ2iOzLF6DdcbLIcdAKZ8+RkfdVvn4HZ/Vhnpki/108TxY7
         kxwae7K/6Hytn1y8Ki91/O2GxRrCIObiWNevq3T9x2fSWGiYR7iv8R5lq/xA4yQ86AS8
         VCmNojROLDE5J10pueU5PZCnjQ5oy5OwpNBsGivqR+Ro0KhJSlJ+LD5GedL5YFpT1zTN
         jnT3JwNfCP3icLVhBX8SR6qZf9I0RKDgnLIYG3JjT0VQ+nK4gXzmNICcy/eWN8ztbdrC
         kV6tVyPbcC0V3zmm0JA8auObj+YUcDmJ3DgtL5LSB42WZT3fCIc2eXEA4XKxzNEvSHfJ
         zz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384321; x=1692989121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OpUekKOL7rOGJBNxIgNqZBQH13Oof9rm7gx23Q+vF4=;
        b=OMmbS28yGDXM8H/r4ynQ8y0EWGDeJqTlpn3jOjxdBsKPJtvI2zqRn+unJ5mdKh+r5j
         ew6eMNcTgCpniS8A7EbpFFXYK2AXI/syq48Y2U9bwJoQC4UyMdOOzIPL6u/9OxMJogSx
         7K6+AClZL9SCOACsRPr3g6fpW5K/qMxU2wi2/uMQj0jFBk37i7+CSg/AfIA14JZGfd5t
         aDZiJjQ+Ot1FLpDDh+wQaetp5CYPumOAKLEBrh0beV0P/Brra/af2YnsTub0MtGxwQo7
         xyo82+A5mSnWiyPJ50Q4qY6m44cA01vie0XRow05MbZ8Sqbn+QWfu7ahE/cPk4In1pEw
         l1Ig==
X-Gm-Message-State: AOJu0YyVy7C0nTe10qnZ3MSXhquv2GxWUjSELdurP/c5CV2lWtic1T+O
        ZLKcL1a9Zg1XN7DS9hVfqlMqbG4qnxDkIg6+I+uJiw==
X-Google-Smtp-Source: AGHT+IHaz+eU/4XGr2yCar2iH/zFlNy9/NYOsV48aXfqt/tGUveLEC/av4PLRa4fnixBg/BFFsPFYfrxUuk43eVAa3M=
X-Received: by 2002:a17:906:3018:b0:99e:6a0:5f64 with SMTP id
 24-20020a170906301800b0099e06a05f64mr32393ejz.36.1692384321374; Fri, 18 Aug
 2023 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230817164733.2475092-1-nphamcs@gmail.com> <20230817190126.3155299-1-nphamcs@gmail.com>
 <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org> <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org> <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org>
In-Reply-To: <20230818183538.GA142974@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 18 Aug 2023 11:44:45 -0700
Message-ID: <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yu Zhao <yuzhao@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
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

On Fri, Aug 18, 2023 at 11:35=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> > On Fri, Aug 18, 2023 at 10:35=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > > If this happens it seems possible for this to happen:
> > > >
> > > > cpu #1                                  cpu#2
> > > >                                              css_put()
> > > >                                              /* css_free_rwork_fn i=
s queued */
> > > > rcu_read_lock()
> > > > mem_cgroup_from_id()
> > > >                                              mem_cgroup_id_remove()
> > > > /* access memcg */
> > >
> > > I don't quite see how that'd possible. IDR uses rcu_assign_pointer()
> > > during deletion, which inserts the necessary barriering. My
> > > understanding is that this should always be safe:
> > >
> > >   rcu_read_lock()                 (writer serialization, in this case=
 ref count =3D=3D 0)
> > >   foo =3D idr_find(x)               idr_remove(x)
> > >   if (foo)                        kfree_rcu(foo)
> > >     LOAD(foo->bar)
> > >   rcu_read_unlock()
> >
> > How does a barrier inside IDR removal protect against the memcg being
> > freed here though?
> >
> > If css_put() is executed out-of-order before mem_cgroup_id_remove(),
> > the memcg can be freed even before mem_cgroup_id_remove() is called,
> > right?
>
> css_put() can start earlier, but it's not allowed to reorder the rcu
> callback that frees past the rcu_assign_pointer() in idr_remove().
>
> This is what RCU and its access primitives guarantees. It ensures that
> after "unpublishing" the pointer, all concurrent RCU-protected
> accesses to the object have finished, and the memory can be freed.

I am not sure I understand, this is the scenario I mean:

cpu#1                      cpu#2                             cpu#3
css_put()
/* schedule free */
                                rcu_read_lock()
idr_remove()
                               mem_cgroup_from_id()

/* free memcg */
                               /* use memcg */

If I understand correctly you are saying that the scheduled free
callback cannot run before idr_remove() due to the barrier in there,
but it can run after the rcu_read_lock() in cpu #2 because it was
scheduled before that RCU critical section started, right?
