Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFEB7A9B18
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 20:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjIUSxw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 14:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjIUSxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 14:53:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE988FB02;
        Thu, 21 Sep 2023 10:54:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77410032cedso39257585a.1;
        Thu, 21 Sep 2023 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318887; x=1695923687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7cHkJ3V+tDc4JCHmCJHLHbSISI10y+DT6XLi9kEwS4=;
        b=fL7cIJznkO+mFEABeCwVDCYoRmcoghK9hTEvs/y/IUAjwRWT1G46L++6D+eNVFjB9I
         fVL0L0YFAfICtyLuwfqF1K69eWaU8ii4/JoTerdRki25+OfUzM9DBNd4UAJFGIgXo9oK
         ePhy6U9Yr9/ZdUXCewi4gn27G7pLDf/TMGV3tSVvJ6wHvdZ/FMR8s3oHtIrsMAJe+uZf
         BsDvco6N/JaNXzBmzqYI0W0u1RmipWtDoPZbqp68duqC/Ku6i5T8yKJmc20BABYcMh8Y
         W3l0c+JeYYdIW0AwACPo2DJ3kmFtjHTioXgE7Zpb16VhZyfu0riHs5uit8NZckHkKVq2
         QQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318887; x=1695923687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7cHkJ3V+tDc4JCHmCJHLHbSISI10y+DT6XLi9kEwS4=;
        b=BGqyzh8kVHdRkoSI5ngj0ujhubNbiTtmvsCZOw0SQ/xsw2znvMYwKJJ45yuo86kmj4
         c3HfUwWRVD6GxPsJrs6i02BraMsviEBgATA2qjbo4xX4DIe9D3B2CvE5CKuXI1/qKn7c
         wDINyRmZplrivNn0N1LTMUUU1ZZLaKIUbcMo6IyFEXmVolpBnU5BTt1E3AeZHSWbJlXM
         Yj8Q8G90DPRb9z3IGCqXYorFbrROVEUW6MSVGj87O+lE7cOhmg3UUL4I1iIo2sa9xv1N
         vb61X/s7xACTOBlX7musR2JOvnFDhgvM7KvSecp14kpXLfVDdYIC4EbBbeFTo0+GYNyM
         WK5g==
X-Gm-Message-State: AOJu0YwSg6nRh/Vu9n6Aqs6hp6m/yt262Jk3Tz29kJVoFMDJNcozcSxQ
        OLP19vrPqusn71BsYM+6sFfShJxhLfm7/fvhR9vV5b+jQKMmKQ==
X-Google-Smtp-Source: AGHT+IFXwd14O3Klb7T/qnAv3+NSV90XXQEhHJaUfO8KyLSBpmpiky7lagddf4rT9Zx3gjhlQ7XJQYRzOAOWrUcmtvY=
X-Received: by 2002:a67:b913:0:b0:452:7715:ef96 with SMTP id
 q19-20020a67b913000000b004527715ef96mr6430010vsn.21.1695303041349; Thu, 21
 Sep 2023 06:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230919175323.144902-1-jrife@google.com> <650af4001eb7c_37ac7329443@willemb.c.googlers.com.notmuch>
 <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
In-Reply-To: <550df73160cd600f797823b86fde2c2b3526b133.camel@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 21 Sep 2023 09:30:05 -0400
Message-ID: <CAF=yD-K3oLn++V_zJMjGRXdiPh2qi+Fit6uOh4z4HxuuyCOyog@mail.gmail.com>
Subject: Re: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
To:     Paolo Abeni <pabeni@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 4:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2023-09-20 at 09:30 -0400, Willem de Bruijn wrote:
> > Jordan Rife wrote:
> > > Similar to the change in commit 0bdf399342c5("net: Avoid address
> > > overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> > > address passed to kernel_bind(). This change
> > >
> > > 1) Makes a copy of the bind address in kernel_bind() to insulate
> > >    callers.
> > > 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
> > >
> > > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@g=
oogle.com/
> > > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jordan Rife <jrife@google.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> I fear this is going to cause a few conflicts with other trees. We can
> still take it, but at very least we will need some acks from the
> relevant maintainers.
>
> I *think* it would be easier split this and patch 1/3 in individual
> patches targeting the different trees, hopefully not many additional
> patches will be required. What do you think?

Roughly how many patches would result from this one patch. From the
stat line I count { block/drbd, char/agp, infiniband, isdn, fs/dlm,
fs/ocfs2, fs/smb, netfilter, rds }. That's worst case nine callers
plus the core patch to net/socket.c?

If logistically simpler and you prefer the approach, we can also
revisit Jordan's original approach, which embedded the memcpy inside
the BPF branches.

That has the slight benefit to in-kernel callers that it limits the
cost of the memcpy to cgroup_bpf_enabled. But adds a superfluous
second copy to the more common userspace callers, again at least only
if cgroup_bpf_enabled.

If so, it should at least move the whole logic around those BPF hooks
into helper functions.
