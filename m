Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF917A9B83
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjIUTCS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIUTCA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 15:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F558849A
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4LkfvOaFX0jDHQRrBLlD2T3QtAGmFBCWTbED0ozV98=;
        b=arOL2Hy9B8B/jEeZJG12iToH1svxIab39Zcdee0Bd40fe34HGjToLXUjNuSunBx/u1tX+5
        ENYV6y8lFzkRCPXlpiFBy8Tie7H5SuVSMVfmyaa2bq05dh7M1fZKLWjdmrGxB7dtEX32Ug
        K+nC+eu546lGlGMkFHqMSg8t+kk2BJU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Z1jwC4jpNBC5bArlMTV4Xg-1; Thu, 21 Sep 2023 11:26:01 -0400
X-MC-Unique: Z1jwC4jpNBC5bArlMTV4Xg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae6afce33fso4959566b.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 08:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695309960; x=1695914760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4LkfvOaFX0jDHQRrBLlD2T3QtAGmFBCWTbED0ozV98=;
        b=jPpUgS4o2oJWNbu1DUlq754XexCmmVLDKHA0VJHAjlIAsY6AiJFmJe8Q8eAiVj49u/
         7LpgSf+zorff7712/6UAYaNMa6dUrVBP/s7xtk6AmO2CCHbttwYo2I0CFbyK0+fC7y/6
         lXREzlGmE7/jrVtXuEJrR752qEMX8png3EjgS0znsQCKqEERzxYV9Bb0UJRjOoJ7LDpe
         RFSmfFoHP9f3C8UB2UVLm/C8y6onDseAHhmKEK4rKU4Hk8jP/1BWBzdsa5e/6kYKtg3j
         xhWIJWalXHJGar6ob25sFVxwUO5CHVDKsaAlhWhoExoWnfclbzTLvdqYZZ5zYXIx4VL8
         1AUg==
X-Gm-Message-State: AOJu0YyfFspwKClwn+V1cCUZTH+nV5pi7qBJfB8DV4O+xY/pqSRZ9ihf
        4KVq1pWl25gQO15Ac4l+2eVAY0tx5FBksLC3DSzwbQmFRqR+2YO3PCvdyvBEBm+CcNvA/b2s7dC
        p5sNnxnzjVINhV5F3
X-Received: by 2002:a17:906:158:b0:9ae:3f76:1091 with SMTP id 24-20020a170906015800b009ae3f761091mr4516082ejh.0.1695309959950;
        Thu, 21 Sep 2023 08:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVNVYISywJGBkNcfjktTQEUUpfIPxwl2Pqron5LDWBUkT2rNrcbN2Az2H5n6R0qrcK5eUGdA==
X-Received: by 2002:a17:906:158:b0:9ae:3f76:1091 with SMTP id 24-20020a170906015800b009ae3f761091mr4516050ejh.0.1695309959569;
        Thu, 21 Sep 2023 08:25:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b0099cc36c4681sm1203041ejr.157.2023.09.21.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:25:59 -0700 (PDT)
Message-ID: <b822f1246a35682ad6f2351d451191825416af58.camel@redhat.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        dborkman@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, airlied@redhat.com, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org,
        bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com,
        teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com,
        lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
        horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        stable@vger.kernel.org
Date:   Thu, 21 Sep 2023 17:25:56 +0200
In-Reply-To: <CAF=yD-K3oLn++V_zJMjGRXdiPh2qi+Fit6uOh4z4HxuuyCOyog@mail.gmail.com>
References: <20230919175323.144902-1-jrife@google.com>
         <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
         <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
         <CAF=yD-K3oLn++V_zJMjGRXdiPh2qi+Fit6uOh4z4HxuuyCOyog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 2023-09-21 at 09:30 -0400, Willem de Bruijn wrote:
> On Thu, Sep 21, 2023 at 4:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> > > Jordan Rife wrote:
> > > > Similar to the change in commit 0bdf399342c5("net: Avoid address
> > > > overwrite in kernel_connect"), BPF hooks run on bind may rewrite th=
e
> > > > address passed to kernel_bind(). This change
> > > >=20
> > > > 1) Makes a copy of the bind address in kernel_bind() to insulate
> > > >    callers.
> > > > 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> > > >=20
> > > > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife=
@google.com/
> > > > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jordan Rife <jrife@google.com>
> > >=20
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >=20
> > I fear this is going to cause a few conflicts with other trees. We can
> > still take it, but at very least we will need some acks from the
> > relevant maintainers.
> >=20
> > I *think* it would be easier split this and patch 1/3 in individual
> > patches targeting the different trees, hopefully not many additional
> > patches will be required. What do you think?
>=20
> Roughly how many patches would result from this one patch. From the
> stat line I count { block/drbd, char/agp, infiniband, isdn, fs/dlm,
> fs/ocfs2, fs/smb, netfilter, rds }. That's worst case nine callers
> plus the core patch to net/socket.c?

I think there should not be problems taking directly changes for rds
and nf/ipvs.

Additionally, I think the non network changes could consolidate the
bind and connect changes in a single patch.

It should be 7 not-network patches overall.

> If logistically simpler and you prefer the approach, we can also
> revisit Jordan's original approach, which embedded the memcpy inside
> the BPF branches.
>=20
> That has the slight benefit to in-kernel callers that it limits the
> cost of the memcpy to cgroup_bpf_enabled. But adds a superfluous
> second copy to the more common userspace callers, again at least only
> if cgroup_bpf_enabled.
>=20
> If so, it should at least move the whole logic around those BPF hooks
> into helper functions.

IMHO the approach implemented here is preferable, I suggest going
forward with it.

Thanks,

Paolo

