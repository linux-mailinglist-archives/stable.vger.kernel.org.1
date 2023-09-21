Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985EF7A9655
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjIURJS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIURJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B359E1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8EMyNUFfNfNe78ZGe1xzNCvjh6qpWodfMx5WvJ2gfk=;
        b=JeLB++R/abbVVq0Ssjf6Eo1gg7xiQ4r7EWLtD3C87b8XT7Hqjon5FF4DRSFgHKiQQfFyCI
        87csUTwi2hGoWVSg8AkKbRm7dQ8dC8bUIajhO3mrsxgeef0nRjU8rUDJluKI9LA+P1D290
        Lrr2ESfcGMMEZXW2MUPVcbslTdwZyZ4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-pXTFyDO4OkqcdJs2TnbyyA-1; Thu, 21 Sep 2023 04:35:30 -0400
X-MC-Unique: pXTFyDO4OkqcdJs2TnbyyA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso121827a12.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695285329; x=1695890129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8EMyNUFfNfNe78ZGe1xzNCvjh6qpWodfMx5WvJ2gfk=;
        b=a095G/iWTWp6XZUL3+QklfHKR2YJZ8GQbrcjgpzE8NhoSqz2Xz6zVk7TOiVQixTX5C
         GT2l5fF6vEipfuQWzE/qEHP06sr41heMEVZ/m7yYsj0S2fDm7KK6jRObDCv+ICUbFW6v
         1FWHw4zFiZbyjUEV1j70G78Hz4W2u3PLdWGisB9sQZk8uLC+tSej2J5+aeP2XXV1gmRn
         oK65GRlHBh1N1EBxuuLoUb0WzfBnRw2Xjd7Ip3DgBwxx7FCJjF7stYwvanXKUtObZzVc
         JzHn1KPQg4qInkzAs4hmuSSTdeZLonJEiqdb4ZPeKE7ptOBv1iMWKV3a2sJQTcwro+4U
         KSXg==
X-Gm-Message-State: AOJu0Yw+f82PnhHV9FJRqnxj8VozqG99WCy9gbmK9K7XC4jkvQCCarrY
        UtZtfujqj5BjNRqlpIJs5HfAKkCOcLeLuu2hSxYvGRY/VLS6XGvxcQSO1v3nKuISX51T0FvsrX4
        fjCzyZtNOeX/s+oJ0
X-Received: by 2002:a05:6402:5113:b0:52f:bedf:8f00 with SMTP id m19-20020a056402511300b0052fbedf8f00mr4413034edd.1.1695285329474;
        Thu, 21 Sep 2023 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAW/UvKuvnLugNpN1Z3inmDdgS9n+W9mAOBmbW1+7FkQFU5ebaF6MaR5bLnb/khZRARbaRIg==
X-Received: by 2002:a05:6402:5113:b0:52f:bedf:8f00 with SMTP id m19-20020a056402511300b0052fbedf8f00mr4412998edd.1.1695285329164;
        Thu, 21 Sep 2023 01:35:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b0052576969ef8sm502682edr.14.2023.09.21.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:35:28 -0700 (PDT)
Message-ID: <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Cc:     dborkman@kernel.org, philipp.reisner@linbit.com,
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
Date:   Thu, 21 Sep 2023 10:35:25 +0200
In-Reply-To: <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
References: <20230919175323.144902-1-jrife@google.com>
         <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> Jordan Rife wrote:
> > Similar to the change in commit 0bdf399342c5("net: Avoid address
> > overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> > address passed to kernel_bind(). This change
> >=20
> > 1) Makes a copy of the bind address in kernel_bind() to insulate
> >    callers.
> > 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> >=20
> > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@goo=
gle.com/
> > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jordan Rife <jrife@google.com>
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>

I fear this is going to cause a few conflicts with other trees. We can
still take it, but at very least we will need some acks from the
relevant maintainers.

I *think* it would be easier split this and patch 1/3 in individual
patches targeting the different trees, hopefully not many additional
patches will be required. What do you think?

Cheers,

Paolo

