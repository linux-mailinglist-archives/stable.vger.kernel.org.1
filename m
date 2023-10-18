Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0385D7CE730
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJRSt6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRSt6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:49:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A22C119
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:49:55 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79f82b26abfso259380639f.1
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki.org; s=google; t=1697654994; x=1698259794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/XxvuFdO2ZdwNK/XNDg8OlspT0DUauJ6LGtfa4Ho6I=;
        b=Cb19xTcCcayNTx35VLJzoEvdrhzmcv92YMeoZ1VdOwKVcQBWclqKDbjzBsfXJxzDSk
         9yMipQL9wCVgXVDwYanrj1vZxGbDOiYbnJHkw9FcSo28Ws+7+YodrEbgRnjWM84BtZpU
         lcHGbVaxpcJJo0c808D+Zl11nuUw5l49cze8eSm102dxiSAYaAtN5LdXgcZzXAYLPxzl
         xLlvifl/oEO1alDVsRfw8Ja/e3VXkzi+VookbWIGgh31PhtkSfclJP1eMuUxBWKvArLm
         9z4sy+TVu1bW43OFUrYpqjQiYk6oNtX7T3AZprNK/AwDLkRrjlF7pIoux0GZYlwd4QrW
         vF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654994; x=1698259794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/XxvuFdO2ZdwNK/XNDg8OlspT0DUauJ6LGtfa4Ho6I=;
        b=S5qx5fF9fO/UMHsphZbNB+N00RzWOxOSOPk0Omx6MjIR1QcIiKcYdh/t3JonkuDCWk
         easjlgWVd/1brDeOmEzBQ7GapONLGuMMZN4x6zogWjz07suCeu/xp5LEK1VhE8+MgmQS
         Av9dWJtEjvyqtW90iRrxi48wAXdIklcfxk2d7P8UbUzZTendegOmZtf+1UoWE6mQAon2
         WP2Rnra03KO5ZZ9XyUY07gXAjZ7zw/oy8W6zJamT0nufERsJ1O62f37EdSpqdCHjEbhq
         AeDQpmcK9HGZrBX5yrbMRWyMTx5mF2lMK/rCUTYU7ZuZXE0Qh5geV/UJGPN5AbEpeVuY
         7hTQ==
X-Gm-Message-State: AOJu0YxB4YUNMGooLeZbMP4ii8iBSTccZXtzWxV/d0/3MYeRBRKmO2zQ
        nVB70gDzGOneSHSebwxQ2rUeq3X/o+XGLUXk49c6Lg==
X-Google-Smtp-Source: AGHT+IGzFwJjge2BOF6o2vMxFLEbgbFf3Xisus20yfGBAsejgI5s1KB++SUapF6eHqICDhunmvZ9ZzdwzHYALJRn/mY=
X-Received: by 2002:a05:6e02:b4b:b0:357:4535:c93 with SMTP id
 f11-20020a056e020b4b00b0035745350c93mr362020ilu.0.1697654994722; Wed, 18 Oct
 2023 11:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
In-Reply-To: <2023101819-satisfied-drool-49bb@gregkh>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Wed, 18 Oct 2023 13:49:44 -0500
Message-ID: <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
Subject: Re: [PATCH] attr: block mode changes of symlinks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 1:40=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> > Unfortunately, this has not held up in LTSes without causing
> > regressions, specifically in crun:
> >
> > Crun issue and patch
> >  1. https://github.com/containers/crun/issues/1308
> >  2. https://github.com/containers/crun/pull/1309
>
> So thre's a fix already for this, they agree that symlinks shouldn't
> have modes, so what's the issue?

The problem is that it breaks crun in Debian stable. They have fixed the
issue in crun, but that patch may not be backported to Debian's stable
version. In other words the patch seems to break existing software in
the wild.

> It needs to reverted in Linus's tree first, otherwise you will hit the
> same problem when moving to a new kernel.

Okay, I'll raise the issue on the linux kernel mailing list.

> > P.S. apologies for not having the correct threading headers. I am not o=
n
> > the list.
>
> You can always grab the mail on lore.kernel.org and respond to it there,
> you are trying to dig up a months old email and we don't really have any
> context at all (I had to go to lore to figure it out...)

Thanks, I'll do that next time.
