Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084077B8706
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjJDR4B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjJDR4A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 13:56:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC16A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 10:55:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a645e54806so22552166b.0
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696442156; x=1697046956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zs4g3LcLzjgUDtcN3GWc6JFHkWe/x90WnM3GWt6rfY=;
        b=EZXycDo3N/xXkfznYsdYRjfOLut2AWReaWMscmiV7w8W0vxe99Lr9bpP4KLW3HdbCQ
         Bl2sulkTKCfaqnMMxVXr9qXKJtmLUXm0BTbU+xnGAr1oLObaFXH1UoCbmtI06Nk/7Ofo
         QzBgeWaUZOh/EhuL4nK6cly2gJSTy6FLBeXD9I5gp2uzH0W0tqnY4WqzuGpVIy33YAEl
         RG0DwhlF2gFqLKqPhYKITN0BEdE0uWJ6W0Y6d31MMihOupjbpqSGwxiMez9P46erwNeP
         8zrXbHpFYJWp/0StQK+zKC3c78o2CRr5U8Sm26j23/EdYTwQbAPDsFrA4cH+duwWd4S4
         +WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696442156; x=1697046956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zs4g3LcLzjgUDtcN3GWc6JFHkWe/x90WnM3GWt6rfY=;
        b=rbkNsr3rVbiLyvlqOI+FoLAr70Wjt71M7h3zlhsgTvZ8l6ne7rROye9l7lMcmaokQP
         qUxE/TFkWgdrWYJNzEMw2jjkqtS6z1BEijkZqW9GHgJS9pHP84aPZtG3SqYE4qBdXNZZ
         5sIkbjy9spCTW08ul6ESUONMvzQNqmX6z7er2N4bK/MWEi6AShCnmsKoBfpPOYeVeBWJ
         s/8cwT0mzBB3a/zeUJJN3oAtPVn7t1893doi06cVEjDW3ZkQbgOmQU8LqMpQw3KkizTj
         qvThSSQqksHc2s49yX2QWoDwhrr8mGVpfOmq4/lJ8x+wg61l7ejq5wQERZFjpQGWsZw0
         0dFw==
X-Gm-Message-State: AOJu0YxTD8KbBqJnp8yS3xCY2lX3swvpkKuoBa39yF3lfx1BlmHCxZrn
        orkkBPR3SpqHfiFgZZ/vd45PLNIHihRQd4zNcy8pHQ==
X-Google-Smtp-Source: AGHT+IF0JwiRPO6sTqYL5cGDqjMHzZXwTKtSYsY71XQfbVUMY+lLAnBGm/7Kr3Gr3yV14QSRQuqh1038KZhTsii0hHM=
X-Received: by 2002:a17:907:763b:b0:9ad:c132:b93b with SMTP id
 jy27-20020a170907763b00b009adc132b93bmr2599077ejc.5.1696442155975; Wed, 04
 Oct 2023 10:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231004011303.979995-1-jrife@google.com> <9062eefc4114f9c9162a19f98a1b820c.pc@manguebit.com>
 <CAH2r5mt4UGni0Wa2sqBA+OGuvnYjmy1ut0pzKa-1C1vUE=fEaw@mail.gmail.com>
In-Reply-To: <CAH2r5mt4UGni0Wa2sqBA+OGuvnYjmy1ut0pzKa-1C1vUE=fEaw@mail.gmail.com>
From:   Jordan Rife <jrife@google.com>
Date:   Wed, 4 Oct 2023 10:55:43 -0700
Message-ID: <CADKFtnStzQgJ4d3fxbwPMPHHSGtCbqTK8h318M=fcFs5xNKH+g@mail.gmail.com>
Subject: Re: [PATCH] smb: use kernel_connect() and kernel_bind()
To:     Steve French <smfrench@gmail.com>
Cc:     Paulo Alcantara <pc@manguebit.com>, sfrench@samba.org,
        lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
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

On Wed, Oct 4, 2023 at 10:15=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> tentatively merged into cifs-2.6.git for-next pending testing and
> additional review
>
> On Wed, Oct 4, 2023 at 10:44=E2=80=AFAM Paulo Alcantara <pc@manguebit.com=
> wrote:
> >
> > Jordan Rife <jrife@google.com> writes:
> >
> > > Recent changes to kernel_connect() and kernel_bind() ensure that
> > > callers are insulated from changes to the address parameter made by B=
PF
> > > SOCK_ADDR hooks. This patch wraps direct calls to ops->connect() and
> > > ops->bind() with kernel_connect() and kernel_bind() to ensure that SM=
B
> > > mounts do not see their mount address overwritten in such cases.
> > >
> > > Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de66393=
4d933ba9.camel@redhat.com/
> > > Cc: <stable@vger.kernel.org> # 6.x.y
> > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > ---
> > >  fs/smb/client/connect.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
>
>
>
> --
> Thanks,
>
> Steve

> Do you want this to go through the cifs tree?

Yes. This was originally a part of a larger patch set destined for the
net tree (https://lore.kernel.org/netdev/20230919175159.144073-1-jrife@goog=
le.com/T/#u).
It was ultimately decided
(https://lore.kernel.org/netdev/20230919175323.144902-1-jrife@google.com/T/=
#m905ead9bdce794112a6cdc440f6887b787532023)
over there to try sending patches to the appropriate trees to avoid
merge conflicts.

> How urgent do you think it is (or should it wait for 6.7)?

Not super urgent, but ultimately it should be backported to stable
kernels 4.19+ (all versions where it's possible to overwrite the
address parameter with BPF hooks). The risk here is in environments
where BPF hooks are used to rewrite the connect/bind addresses (common
in systems like Kubernetes w/ Cilium). Doing so can break your mounts,
since the original mount address is "forgotten" when a call to
ops->connect() overwrites it (have confirmed this scenario myself).
IME, this scenario is more common to see with NFS mounts, but still
possible with SMB.

- Jordan
