Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E624754557
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 01:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGNXWt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 19:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGNXWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 19:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7782D9
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689376921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+X09fj27AK4/3pww3xE1DH8gg7k6xAyYOWy2jHq9KU=;
        b=h1CEk2wyMH04MQylHYNSX0GyQ64lPJTAIKyA4EBQ1+h9wFGKy995ZqSbPxG562vh1826YI
        sJ2vUEd0v5CaM1oSjk27IrmiYAu8MAGiI90HwQx3tXKTLMy9w4pgL3ezGVmbuRqx7MN681
        GuvcY9j49dRwaLzIJXxEJoW4rBJ6aXI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-2AtEFr48PfKq59cesbz8XA-1; Fri, 14 Jul 2023 19:21:59 -0400
X-MC-Unique: 2AtEFr48PfKq59cesbz8XA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5704991ea05so18857407b3.1
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 16:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689376919; x=1691968919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+X09fj27AK4/3pww3xE1DH8gg7k6xAyYOWy2jHq9KU=;
        b=DcgvQl+nmlcz+IRVKtZlFRs9nheHuOBTTxTGpYwd++kv98QdNR47AL8TzCK/zk+Ov7
         zsdJxGvlUY1IOFwnyhhgR5WkfrM7JMzRNeeDeKk/r3SuaW0W7MQux6YAHuvqrVCB7dTv
         +kr95IHhR1ByL1INFUNRRBEimg0bh/2yDzD+WRyXhs250gwZrFil9YyREhbfUO9VXBs7
         CvqLtrP06mHBhiStw9w8tiSkswrwWs4Em1smUxogEi2yR3HJYfvR7uiBlHAtx5ATWz3O
         dREFaOwf7YYgXFpf4Hi+xwLu6RBHV9OvVha+Rvu721QoxYDKGhWqJZXgXzvIvvmFRiZ0
         hpGw==
X-Gm-Message-State: ABy/qLYfkMXyWKqsF2JwiYl3PMrQ77HHTB/976M1BS59TQHy9WmRISvf
        +X3SnAQwksqbgz+FYqsVi8QuJa4nVGlv1L8xugJskXAz40oMTIh6o8Hr0mJYVEomZJ6//t1r6tF
        w6p+lhS/kcxPfTVtDFKYM1L7ryXYQCfJe
X-Received: by 2002:a81:6642:0:b0:577:51cd:1b4a with SMTP id a63-20020a816642000000b0057751cd1b4amr5632734ywc.41.1689376919168;
        Fri, 14 Jul 2023 16:21:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH87tii74fYhQOB2UmnURixuj47NPlikm9zKn4Uxb8LU4kBw2+Og04U9kZAJbGCRPAHQSZ5GLvhopXLprX908I=
X-Received: by 2002:a81:6642:0:b0:577:51cd:1b4a with SMTP id
 a63-20020a816642000000b0057751cd1b4amr5632726ywc.41.1689376918933; Fri, 14
 Jul 2023 16:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230713144029.3342637-1-aahringo@redhat.com> <CAHc6FU542V6T8F8W-npN24zVJih5iRckGHqHLPrVHLhLqWBOgA@mail.gmail.com>
In-Reply-To: <CAHc6FU542V6T8F8W-npN24zVJih5iRckGHqHLPrVHLhLqWBOgA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 14 Jul 2023 19:21:47 -0400
Message-ID: <CAK-6q+gZU5ukDW584PRf=L_08Jx-G6OHgJG1804a6LxjDtoORA@mail.gmail.com>
Subject: Re: [PATCH v6.5-rc1 1/2] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Fri, Jul 14, 2023 at 9:54=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
> On Thu, Jul 13, 2023 at 4:40=E2=80=AFPM Alexander Aring <aahringo@redhat.=
com> wrote:
> > This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
> > plock operation should not send a reply back. Currently this is kind of
> > being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
> > meanings that it will remove all waiters for a specific nodeid/owner
> > values in by doing a unlock operation. In case of an error in dlm user
> > space software e.g. dlm_controld we get an reply with an error back.
> > This cannot be matched because there is no op to match in recv_list. We
> > filter now on DLM_PLOCK_FL_NO_REPLY in case we had an error back as
> > reply. In newer dlm_controld version it will never send a result back
> > when DLM_PLOCK_FL_NO_REPLY is set. This filter is a workaround to handl=
e
> > older dlm_controld versions.
>
> I don't think this makes sense. If dlm_controld understands a
> particular request, it already knows whether or not that request
> should receive a reply. On the other hand, if dlm_controld doesn't
> understand a particular request, it should communicate that fact back
> to the kernel so that the kernel will know. The kernel knows which
> kinds of requests should and shouldn't receive replies, so when it is
> sent a reply it doesn't expect, it knows that dlm_controld didn't
> understand the request and is either outdated or plain broken. The
> kernel doesn't need to pipe a flag through dlm_controld for figuring
> that out.
>

It's already part of UAPI that a flag signals that a reply is not
expected [0]. If this flag is set and current user space software did
not understand the request (or any possible future user space error
handling) it will send a reply back which cannot be matched and with
the current match logic it will match the wrong one.
I would say it is broken and probably we don't care because we never
assume that an error will happen, we just need to be careful to not
add any other possible reply for errors in future.

The bigger problem is to introduce new ops [1] (not flags) on the
kernel side which does not send a reply back. Older user space
software will not understand the optype and will send a reply, newer
software will not send a reply (because it understands the optype).

Therefore I think we should never introduce a new optype which does
not send a reply back. The new DLM_PLOCK_OP_CANCEL was trying to do
that, that's why I tried to fix this behaviour which is another ugly
workaround passing flags around.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/plock.c#n395
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/dlm_plock.h?h=3Dv6.5-rc1#n21

