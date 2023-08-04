Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936277008C
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjHDMwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Fri, 4 Aug 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHDMwr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAFDE7
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:51:59 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-7RLRvohsNVyLNfV36UrxOQ-1; Fri, 04 Aug 2023 08:51:56 -0400
X-MC-Unique: 7RLRvohsNVyLNfV36UrxOQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b04d5ed394so3184511fa.1
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 05:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153514; x=1691758314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRlXGWY/CFWI5iW4ld/1S29gsGd4s6U2sDlhS/FmuSE=;
        b=EOlxUBMICacLLkN6ETV0o1HuZWcelW6pI6dAEAet1eUlPRzFWzYk+JDflKDHb17t2o
         mQp3J9LIcuxztgRq/qoA6ENGJkRV17UeT0v0OjxxU2pOFQP3OfVV9RtFyWLU4NgQxZXf
         zeCfoFZ5/3j+WDnPOewsmFTkn66AMUt04DJhEY26xarQZdbVOHxEZbZt1aZNJRDRpdcA
         uXFUhZxV37gS/kWlrmT3OdkgyBQYPdEpRjC+OhzlEfay2Sioe4nUJ8/CcOtXaEDopMn8
         Knp4/yVArVA5hWqjRQGVnmWq0cfDnpHr6n+TG+RGN3b+dw5+QO1LpqcCaK5jSubx/9Bm
         LXVA==
X-Gm-Message-State: ABy/qLaZLBMbgzY7ZMxUxz3P8cYk87pfunUN04zstJ3aBGID4vXkEDmW
        a8k1HFrBXRk2AwYGdPKwNxePsV4RtPI5otBIRWE0kFg00gsMjJNwAVEQM15zTiwJwL0shR7EFfV
        uAUnQzECtwdIFzAED66Un8UJLYfiYRw3D
X-Received: by 2002:a2e:a7cf:0:b0:2b6:9969:d0ab with SMTP id x15-20020a2ea7cf000000b002b69969d0abmr14626218ljp.4.1691153514605;
        Fri, 04 Aug 2023 05:51:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFrcSjZXh6YM3wQYlauuWGfFGZv19JjISaVV8WqI5Be/z9XCLqb6j13RdZZx7ibxrrJTgr6pbJPMHFHOKn9vpw=
X-Received: by 2002:a2e:a7cf:0:b0:2b6:9969:d0ab with SMTP id
 x15-20020a2ea7cf000000b002b69969d0abmr14626204ljp.4.1691153514326; Fri, 04
 Aug 2023 05:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20be6650-5db3-b72a-a7a8-5e817113cff5@kravcenko.com>
 <c27fb4dd-b2dc-22de-4425-6c7db5f543ba@leemhuis.info> <CACO55ttcUEUjdVgx4y7pv26VAGeHS5q1wVKWrMw5=o9QLaJLZw@mail.gmail.com>
 <0a5084b7-732b-6658-653e-7ece4c0768c9@kravcenko.com>
In-Reply-To: <0a5084b7-732b-6658-653e-7ece4c0768c9@kravcenko.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 4 Aug 2023 14:51:43 +0200
Message-ID: <CACO55tvu4X3u8K-FGUeN2CBw1BnumRPBNEEqjn+EPzNCCCQYyg@mail.gmail.com>
Subject: Re: nouveau bug in linux/6.1.38-2
To:     Olaf Skibbe <news@kravcenko.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        1042753@bugs.debian.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 4, 2023 at 2:48 PM Olaf Skibbe <news@kravcenko.com> wrote:
>
> On Fri, 4 Aug 2023 at 14:15, Karol Herbst wrote:
>
> > mind retrying with only fb725beca62d and 62aecf23f3d1 reverted?
>
> I will do this later this day (takes some time, it is a slow machine).
>
> > Would be weird if the other two commits are causing it. If that's the
> > case, it's a bit worrying that reverting either of the those causes
> > issues, but maybe there is a good reason for it. Anyway, mind figuring
> > out which of the two you need reverted to fix your issue? Thanks!
>
> I can do this. But if I build two kernels anyway, isn't it faster to
> build each with only one of the patches applied? Or do you expect the
> patches to interact (so that the bug would only be present when both are
> applied)?
>

How are you building the kernel? Because normally from git reverting
one of those shouldn't take long, because it doesn't recompile the
entire kernel. But yeah, you can potentially just revert one of one
for now and it should be fine.

> Cheers,
> Olaf
>

