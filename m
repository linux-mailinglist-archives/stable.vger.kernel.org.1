Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407BA754576
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 01:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjGNXlw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 19:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGNXlv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 19:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0655B3A92
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689378061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xA2SFKFW47h/K7YYUZodON0lmABcyisGtc9hpSnJfHA=;
        b=ff23wAwHi1K/OQnODZvnMtEtvRQwzKUlyPKBixzXCr7JA+W8437erEI11w01d/tfuy+PkL
        dI0MHJztxhXgHNO5w7f7WRPW8EiZXG5ESzoMSBq9fIuHwQYTqPjDY6GQTglMmmcbicBao7
        8R/ldsGar7GVh55lABf16RQAAx/hYds=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-3vhMOyTvPYSfwlGf-Qd_QA-1; Fri, 14 Jul 2023 19:40:59 -0400
X-MC-Unique: 3vhMOyTvPYSfwlGf-Qd_QA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5704995f964so20362867b3.2
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 16:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689378059; x=1691970059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA2SFKFW47h/K7YYUZodON0lmABcyisGtc9hpSnJfHA=;
        b=h7QgO3JoBw9KqMDetBUog8iD6WFM2UFYMsPT2nHvX6/uDiMZjHvFMWvCLQhvGCVlpF
         M3vBP5gw9DMWxTGSqRNb8hGhLZ3ncghH4i2nbXdMF0v1gVIZVbvbDmVfl5FyHphTtWAj
         pY5/J3MDGe4xxuQuZ3ZJLh7eAbY6gjJcbQPYIG+VsDHd81AmbDZ0PO71x01R9ILxQawL
         sBp3LlYZAqK624vCcxKmqMD3epMeDgwNaj7WN6k9nIvveA26Rr7hpfIiBG6Weq6mJraE
         LwiwqWZeXeeIQKJM3nku/evpHydxWYFQedvspy5cWQTeNAKn5PxW9Dl4ASakoQqZ9ud6
         NnjA==
X-Gm-Message-State: ABy/qLZrJfBdi0qCjocYoOFpgQFXewWEoYrjh4n3ObuqxfSbxQCg79yi
        gB8kIRzR1+cav3Rdy16rLmF86PthgG7t2PYlO+vUt2w+ncYUvdg4lEVWGmWCWr8BKjJYWkEjec7
        J9QPgfj7JjHeVvqKpiD1OACbPtMBn3Jr/
X-Received: by 2002:a0d:e5c6:0:b0:576:bfd7:1dac with SMTP id o189-20020a0de5c6000000b00576bfd71dacmr5841398ywe.24.1689378059311;
        Fri, 14 Jul 2023 16:40:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFR1U1r+iOWq9LG5xJ+j5zphVL8W6yGkoGpCz8p7aKlhTSlLIhprGVAG72NYrRMw4GJ+h8npxiLqmTp60Ag+w=
X-Received: by 2002:a0d:e5c6:0:b0:576:bfd7:1dac with SMTP id
 o189-20020a0de5c6000000b00576bfd71dacmr5841390ywe.24.1689378059101; Fri, 14
 Jul 2023 16:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230713164838.3583052-1-aahringo@redhat.com> <20230713164838.3583052-4-aahringo@redhat.com>
In-Reply-To: <20230713164838.3583052-4-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 14 Jul 2023 19:40:47 -0400
Message-ID: <CAK-6q+gNoZw9HSWvKKb2jS1m4W-NxbrsrPE4x_DudmpHiAhw0w@mail.gmail.com>
Subject: Re: [PATCHv2 v6.5-rc1 3/3] fs: dlm: allow to F_SETLKW getting interrupted
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, stable@vger.kernel.org,
        agruenba@redhat.com
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

On Thu, Jul 13, 2023 at 12:49=E2=80=AFPM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> This patch implements dlm plock F_SETLKW interruption feature. If the
> pending plock operation is not sent to user space yet it can simple be
> dropped out of the send_list. In case it's already being sent we need to
> try to remove the waiters in dlm user space tool. If it was successful a
> reply with DLM_PLOCK_OP_CANCEL optype instead of DLM_PLOCK_OP_LOCK comes
> back (flag DLM_PLOCK_FL_NO_REPLY was then being cleared in user space)
> to signal the cancellation was successful. If a result with optype
> DLM_PLOCK_OP_LOCK came back then the cancellation was not successful.

There is another use-case for this op that's only used kernel
internally by nfs. It's F_CANCELLK [0]. I will try to implement this
feature as I think the current behaviour is broken [1].
An unlock is not a revert and if the lock request is in waiting state,
unlocking will do exactly nothing.

I am still questioning how the API of [0] is supposed to work as [0]
does not evaluate any return value if it was successfully canceled or
not. Maybe they meant cancel and if it was not successful unlock it,
but an unlock is not a revert and posix locks support up/downgrade
locking e.g. read/write locks. However I think unlocking if
cancellation wasn't successful is meant here.

Besides that, I will change that DLM_PLOCK_OP_CANCEL will always
expect a reply back.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/lockd/svclock.c#n705
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/gfs2/file.c?h=3Dv6.5-rc1#n1439

