Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E67A97E3
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjIUR2V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIUR1z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:27:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A33585
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:03:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso20657391fa.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315715; x=1695920515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK21WYzVm30pkR03hEDVnx/qoe/Q1Eu8nWyTdq2Kd2M=;
        b=AtK9WFo9j6TXScvSqMuZzlK961dmvO5IByqc3CEdoSnvmpGARZL++KF/danrXxiVjj
         0JsouZzSWVMXvnusSHy2HgP+UFPVxMMOlXSVS18d3BSsk8yI7k6CPjjnbBp1iKs9vA4G
         xObgaytINSPBG1jGTnszAbRyygnWqP0/AqMTwIJmLSWL9wjw7B6KM2LTj2qalPjdB1Jm
         z+D1noypmil7Hf7z7pga7lBx60LOW40G9DcBtjtvcfXP7facYdyMOyXleNujcAQREF+c
         eQMnjPhed9g9fqldsb8OHpUHTlR1iA8owLezktX8e+ZuXdi4J6VqqsdKihslWxSK9/pw
         tizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315715; x=1695920515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK21WYzVm30pkR03hEDVnx/qoe/Q1Eu8nWyTdq2Kd2M=;
        b=igUXwtH8TnPadd97DjXoAdDf+aKViLp9D7LtWCuy5RfkgLabbDioM8ULujc60HYE9v
         +dFyaDYwTLYkQGa2aH2vi3cHbw4yEcY+t7NAPW4GoJQG6YzX00tqxlTbMeRmVHteKj0M
         TsI8ARXmWmimyXkZvaH49M9QJ4/vroBYSSV1PIgpwwWIlWY9tfz/YQIg19fCDaQcUKr1
         atEKYLBmmWi6FMWdUl0xVb66I1+40U8iPdvHMs26nWwlKHD1cgda/OQLV8MGuomPdgW4
         jucv+6qPajeXHdIHPzD14uXAHLokhThrMeyUKJ0RpmqSlDZbOCof2A67nAZSGLtaVyRI
         akGA==
X-Gm-Message-State: AOJu0YyAtAIZA1EkI84BVhrsWLalIvVy9/5uUDcmv5WtPtBFX227CBfi
        8HPhan8Yp02b8MrRvi+UGBZ7K3JOkq3f5bO+PYB52Q==
X-Google-Smtp-Source: AGHT+IHLbVQVPTbY4mDzyywro5wxLvNUrwqDk+GNRXLAejAiLRmP8JbYyOL8hu0K3iY3VhZahUwBpgI5KJvnt87aXJs=
X-Received: by 2002:a2e:8882:0:b0:2bf:e65d:e815 with SMTP id
 k2-20020a2e8882000000b002bfe65de815mr5662841lji.38.1695315715063; Thu, 21 Sep
 2023 10:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230919175323.144902-1-jrife@google.com> <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
 <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
 <CAF=yD-K3oLn++V_zJMjGRXdiPh2qi+Fit6uOh4z4HxuuyCOyog@mail.gmail.com> <b822f1246a35682ad6f2351d451191825416af58.camel@redhat.com>
In-Reply-To: <b822f1246a35682ad6f2351d451191825416af58.camel@redhat.com>
From:   Jordan Rife <jrife@google.com>
Date:   Thu, 21 Sep 2023 10:01:42 -0700
Message-ID: <CADKFtnTz-gDRKtDpw1p=AEkBSa3MispZDV8Rz5n+ZahdBr3vnA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, dborkman@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, axboe@kernel.dk,
        airlied@redhat.com, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org,
        bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com,
        teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com,
        lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
        horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
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

On Thu, Sep 21, 2023 at 8:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2023-09-21 at 09:30 -0400, Willem de Bruijn wrote:
> > On Thu, Sep 21, 2023 at 4:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> > > > Jordan Rife wrote:
> > > > > Similar to the change in commit 0bdf399342c5("net: Avoid address
> > > > > overwrite in kernel_connect"), BPF hooks run on bind may rewrite =
the
> > > > > address passed to kernel_bind(). This change
> > > > >
> > > > > 1) Makes a copy of the bind address in kernel_bind() to insulate
> > > > >    callers.
> > > > > 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> > > > >
> > > > > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jri=
fe@google.com/
> > > > > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > >
> > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >
> > > I fear this is going to cause a few conflicts with other trees. We ca=
n
> > > still take it, but at very least we will need some acks from the
> > > relevant maintainers.
> > >
> > > I *think* it would be easier split this and patch 1/3 in individual
> > > patches targeting the different trees, hopefully not many additional
> > > patches will be required. What do you think?
> >
> > Roughly how many patches would result from this one patch. From the
> > stat line I count { block/drbd, char/agp, infiniband, isdn, fs/dlm,
> > fs/ocfs2, fs/smb, netfilter, rds }. That's worst case nine callers
> > plus the core patch to net/socket.c?
>
> I think there should not be problems taking directly changes for rds
> and nf/ipvs.
>
> Additionally, I think the non network changes could consolidate the
> bind and connect changes in a single patch.
>
> It should be 7 not-network patches overall.
>
> > If logistically simpler and you prefer the approach, we can also
> > revisit Jordan's original approach, which embedded the memcpy inside
> > the BPF branches.
> >
> > That has the slight benefit to in-kernel callers that it limits the
> > cost of the memcpy to cgroup_bpf_enabled. But adds a superfluous
> > second copy to the more common userspace callers, again at least only
> > if cgroup_bpf_enabled.
> >
> > If so, it should at least move the whole logic around those BPF hooks
> > into helper functions.
>
> IMHO the approach implemented here is preferable, I suggest going
> forward with it.
>
> Thanks,
>
> Paolo
>

> Additionally, I think the non network changes could consolidate the
> bind and connect changes in a single patch.
>
> It should be 7 not-network patches overall.

I'm fine with this. If there are no objections, I can drop the non-net
changes in this patch series and send out several
kernel_connect/kernel_bind patches to the appropriate trees as a
follow up. Shall we wait to hear back from the maintainers or just go
ahead with this plan?

-Jordan
