Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E57A9654
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIURGV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjIURFf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513652D54
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EitPswhhZZ2vx5zn9ypbN1vdKA00UIWNGb498GcEXDI=;
        b=ZgYZu6x32b1jNBnRdNLy44aaYDJ9JoJaJ5en/Qh2JKaFUNPeDBUXPG66P6Ue74Pb5XAjXr
        yZV2XMSu6OM3JEsAZ8dFMSjLdZnUmhQKGRv91cm82CkBgWrUfTjZBdA5F42A5Tq4CuxZCx
        v2R3jRQdy+oNPRYQx1C/PNWVFjrWrF0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-GflwPtdMNzmCqgvuruWmvQ-1; Thu, 21 Sep 2023 04:32:19 -0400
X-MC-Unique: GflwPtdMNzmCqgvuruWmvQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ade76f4a44so9759166b.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695285138; x=1695889938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EitPswhhZZ2vx5zn9ypbN1vdKA00UIWNGb498GcEXDI=;
        b=Cj8S4jF7shL6HFZNPC47dlH6SJW4RueHOKTr11c1Dx18geq/d7Su6BxzupnYLaqZjA
         couVjVKIVg9zIoscwJ5CsN3WcfOQjIVm/STyyqA4yLdlEQ/j4bSeyi0mEpSq1t13p8D1
         YqMxhb+7vrS7jFvuZmCdayyc7SRathJttdU5ECuArseU2NvNK3WjeEuEBHyfV2nu8vXG
         UDucZccFhOp+LOLmZr7rjvR/ZNBdHVFlpArYJRMm667o5m2Dq9ScUtUguwX/d0FhF7ej
         lCtOB57cVnMFAmeL808V4oh6q/AVeB/L3j6vav5a5DDabgTojDkDBCjbPoQo8wOkRr++
         1vGg==
X-Gm-Message-State: AOJu0YzdyywEyP72N0BOPBx1U73Hnn1ykkzUs9wF29l7N/B+Q42AOdAZ
        dwgXDi/b1Z1VDazGQ475V2bUogCbczsufDg2xKtNJEuRXVMkUYclmo1Vz/l24GSiPmkQO8GdCFZ
        e9fnTdD/yqRrEs7Zj
X-Received: by 2002:a17:906:158:b0:9ae:3f76:1091 with SMTP id 24-20020a170906015800b009ae3f761091mr3696016ejh.0.1695285138615;
        Thu, 21 Sep 2023 01:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDObwM7yL6iv2CUR7KT5fbFcUYmOWkJpB25aa9zsWbCbH2YF1Bu0jxcmAU5QiukkmwCvYfQ==
X-Received: by 2002:a17:906:158:b0:9ae:3f76:1091 with SMTP id 24-20020a170906015800b009ae3f761091mr3695987ejh.0.1695285138233;
        Thu, 21 Sep 2023 01:32:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090616c200b0099d45ed589csm673419ejd.125.2023.09.21.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:32:17 -0700 (PDT)
Message-ID: <139933c6013e444047dc685ade53fa3dc1ad68d3.camel@redhat.com>
Subject: Re: [PATCH net v4 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Cc:     dborkman@kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Thu, 21 Sep 2023 10:32:16 +0200
In-Reply-To: <650af39492a56_37ac7329469@willemb.c.googlers.com.notmuch>
References: <20230919175254.144417-1-jrife@google.com>
         <650af39492a56_37ac7329469@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-09-20 at 09:28 -0400, Willem de Bruijn wrote:
> Jordan Rife wrote:
> > Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> > space may observe their value of msg_name change in cases where BPF
> > sendmsg hooks rewrite the send address. This has been confirmed to brea=
k
> > NFS mounts running in UDP mode and has the potential to break other
> > systems.
> >=20
> > This patch:
> >=20
> > 1) Creates a new function called __sock_sendmsg() with same logic as th=
e
> >    old sock_sendmsg() function.
> > 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
> >    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
> >    as these system calls are already protected.
> > 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
> >    present before passing it down the stack to insulate callers from
> >    changes to the send address.
> >=20
> > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@goo=
gle.com/
> > Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jordan Rife <jrife@google.com>
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>

CC Jens and Pavel, as I guess io_uring likely want to use
__sock_sendmsg(), in a follow-up patch.

Cheers,

Paolo

