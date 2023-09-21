Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B87AA1A8
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 23:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjIUVFt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjIUVEm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 17:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B4B0A05
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695319741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGxZnsNiHt/giK6qzG9BTVYPrTI5jtrYUuPjM2C4/y0=;
        b=PUMi79T7aoKZIy+86/Lv8Y22qgOaAegyBRLwG9OXDZWNk9TxoPD1AOUxoBIqx24hO0zgIu
        qzN1tTUiWyReOphCzoNpDwv5isNmttJ9lf+3sf54cvr47zOlunLvjD2qHW/k0aH7e3w23D
        6Ec+KPIu8OHT9AcCi+D30z1fgO+41pI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303--SIwOuIbPJuve_dSVRQ_MQ-1; Thu, 21 Sep 2023 14:09:00 -0400
X-MC-Unique: -SIwOuIbPJuve_dSVRQ_MQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso25472066b.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319739; x=1695924539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGxZnsNiHt/giK6qzG9BTVYPrTI5jtrYUuPjM2C4/y0=;
        b=v4LnYrnzg1DnzdphvvS9vZEHlee6epnPnLGsdfFNCHy4ED22H7952FK6EWeOVNDJjO
         jmU9uBNgsT0lyTbfjRKBsscLyZFa2xk94326T2xm72my4QCYmsdCVz4OqY0fdZJwTVCC
         Dlz6s/gGaUj8/TQWnnTTNE0fRykg37Kbzq6dZ8wi3RerjFuHvq7eFJ4Fyxj3fA7FNAzn
         wVHpXgy1Z0EEnzkNZuG5NqGs7G/quQ5787AdQY9dwEJo98VK1BCMasvajjSvOXTmouqO
         NGv3M8iev8VpUxTxaytc/RbKuTA1/9VAIcVHoZ+ugUHIBEorljTHQFEFTF9PzbMvDERu
         SCyA==
X-Gm-Message-State: AOJu0YyGnFctX7jYGxH00O4sQNN00FtYVQVMx74f1RX5ch+ZzAxl5R0B
        J/5EufwBOCg6biuzs1DBf/ddU+KfVh9ZGrsuDaeahTPX7kFUO5VmRjXhfx6Pr9C+yqDAU2A15bW
        BZocAOFgp5W0PfaSW
X-Received: by 2002:a17:906:74d5:b0:9a6:5340:c337 with SMTP id z21-20020a17090674d500b009a65340c337mr4707837ejl.2.1695319739413;
        Thu, 21 Sep 2023 11:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLaoTSytYH1pXp57psAu+VYfFfn2yexrzGAJGcSC8u/J2RZ+YiZfWXtLdDSja//QnIeUbzPg==
X-Received: by 2002:a17:906:74d5:b0:9a6:5340:c337 with SMTP id z21-20020a17090674d500b009a65340c337mr4707821ejl.2.1695319739057;
        Thu, 21 Sep 2023 11:08:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id va1-20020a17090711c100b00992ea405a79sm1387076ejb.166.2023.09.21.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:08:58 -0700 (PDT)
Message-ID: <9944248dba1bce861375fcce9de663934d933ba9.camel@redhat.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jordan Rife <jrife@google.com>
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
Date:   Thu, 21 Sep 2023 20:08:56 +0200
In-Reply-To: <CADKFtnTz-gDRKtDpw1p=AEkBSa3MispZDV8Rz5n+ZahdBr3vnA@mail.gmail.com>
References: <20230919175323.144902-1-jrife@google.com>
         <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
         <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
         <CAF=yD-K3oLn++V_zJMjGRXdiPh2qi+Fit6uOh4z4HxuuyCOyog@mail.gmail.com>
         <b822f1246a35682ad6f2351d451191825416af58.camel@redhat.com>
         <CADKFtnTz-gDRKtDpw1p=AEkBSa3MispZDV8Rz5n+ZahdBr3vnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 2023-09-21 at 10:01 -0700, Jordan Rife wrote:
> On Thu, Sep 21, 2023 at 8:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Thu, 2023-09-21 at 09:30 -0400, Willem de Bruijn wrote:
> > > On Thu, Sep 21, 2023 at 4:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >=20
> > > > On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> > > > > Jordan Rife wrote:
> > > > > > Similar to the change in commit 0bdf399342c5("net: Avoid addres=
s
> > > > > > overwrite in kernel_connect"), BPF hooks run on bind may rewrit=
e the
> > > > > > address passed to kernel_bind(). This change
> > > > > >=20
> > > > > > 1) Makes a copy of the bind address in kernel_bind() to insulat=
e
> > > > > >    callers.
> > > > > > 2) Replaces direct calls to sock->ops->bind() with kernel_bind(=
)
> > > > > >=20
> > > > > > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-j=
rife@google.com/
> > > > > > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > > >=20
> > > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > >=20
> > > > I fear this is going to cause a few conflicts with other trees. We =
can
> > > > still take it, but at very least we will need some acks from the
> > > > relevant maintainers.
> > > >=20
> > > > I *think* it would be easier split this and patch 1/3 in individual
> > > > patches targeting the different trees, hopefully not many additiona=
l
> > > > patches will be required. What do you think?
> > >=20
> > > Roughly how many patches would result from this one patch. From the
> > > stat line I count { block/drbd, char/agp, infiniband, isdn, fs/dlm,
> > > fs/ocfs2, fs/smb, netfilter, rds }. That's worst case nine callers
> > > plus the core patch to net/socket.c?
> >=20
> > I think there should not be problems taking directly changes for rds
> > and nf/ipvs.
> >=20
> > Additionally, I think the non network changes could consolidate the
> > bind and connect changes in a single patch.
> >=20
> > It should be 7 not-network patches overall.
> >=20
> > > If logistically simpler and you prefer the approach, we can also
> > > revisit Jordan's original approach, which embedded the memcpy inside
> > > the BPF branches.
> > >=20
> > > That has the slight benefit to in-kernel callers that it limits the
> > > cost of the memcpy to cgroup_bpf_enabled. But adds a superfluous
> > > second copy to the more common userspace callers, again at least only
> > > if cgroup_bpf_enabled.
> > >=20
> > > If so, it should at least move the whole logic around those BPF hooks
> > > into helper functions.
> >=20
> > IMHO the approach implemented here is preferable, I suggest going
> > forward with it.
> >=20
> > Thanks,
> >=20
> > Paolo
> >=20
>=20
> > Additionally, I think the non network changes could consolidate the
> > bind and connect changes in a single patch.
> >=20
> > It should be 7 not-network patches overall.
>=20
> I'm fine with this. If there are no objections, I can drop the non-net
> changes in this patch series and send out several
> kernel_connect/kernel_bind patches to the appropriate trees as a
> follow up. Shall we wait to hear back from the maintainers or just go
> ahead with this plan?

I'm guessing you can go ahead with that: it should better fit anybody.

Thanks

Paolo

p.s. also using this reply to check if finally vger accepts my message
again...

