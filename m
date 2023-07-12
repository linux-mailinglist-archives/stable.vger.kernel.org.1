Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B28750E73
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjGLQZ2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjGLQZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 12:25:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867361BE2
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 09:25:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6f943383eso116561341fa.2
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689179101; x=1691771101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+n3/sUni28MSCLgxWztdZs9B20evtoadadoik5Bznhs=;
        b=Nb4xw70i0SgD0nIrV9vs6Tef3wwSgf0PmFAFyVsQijGuUciUxJK0BDkfonxrK0MtwI
         qHl6iALG1m4N85H5dCc8T+wWdnQ09KkM2bvUWUi6d3I0OEqG/jr4h2M3e8AkpBUsRr0l
         7u/ik5ur9tcNd2Owk8pE9pn6DJJQ/4cDG3VHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179101; x=1691771101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+n3/sUni28MSCLgxWztdZs9B20evtoadadoik5Bznhs=;
        b=RB5QrxhghCLmmtcL+0dMHBClZZZOvvGPC3K19QjDZxklaN6mdU+xgGEmKrK8MfEiv5
         3DLVQYmTwEjCFu1QPzTfjJZ5hQsXcRWYdWxOj3ULyUFgYUk/FWbFHGjvEJRtu6NRLzVo
         b8OjwfsOE2LiXuSv66/6dBeE5LBgCqSwvGsJ84k1zDVHpVWEYt0EW/AGiHsTaLnzbgDg
         0fXVb/zndWgjYUoOPp/MkHlSVRohfgJTJnLjpmUnsy6hnJy6NV7u+fV6pPi+jQdqrK8L
         qmdaBjNG785K/H2DLkkwVFUmjpLVPSewu9Le+TdXYpjSsKYdcwbyjGOxwk2lj7lkSynb
         IFCQ==
X-Gm-Message-State: ABy/qLZ5HwijE5Z3GGn9YPcnWA6Ek7dyvvEeTV7uXJTst5Fik1JoYPzY
        oE8MQpJVGQyQ0e055m4EGpPCBhsy6cHswf1GFD82tAye
X-Google-Smtp-Source: APBJJlFP47YOP9XdI/+ZGP6okKdeasgQbrJC0HdKEE4g9r8/0iKtZgHq88ea7VSU5SMKt3tAroLXNQ==
X-Received: by 2002:a2e:a383:0:b0:2b6:e3d5:76a7 with SMTP id r3-20020a2ea383000000b002b6e3d576a7mr15660299lje.24.1689179101504;
        Wed, 12 Jul 2023 09:25:01 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906850400b0099293cdbc98sm2791854ejx.145.2023.07.12.09.25.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:25:01 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso9106620a12.1
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 09:25:00 -0700 (PDT)
X-Received: by 2002:aa7:c986:0:b0:51d:8a53:d1f with SMTP id
 c6-20020aa7c986000000b0051d8a530d1fmr19862433edt.8.1689179100685; Wed, 12 Jul
 2023 09:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
In-Reply-To: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 09:24:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whypK=-91QfDpd3PWwazx35iWT=ooKLxhbeTAwJL_WXVg@mail.gmail.com>
Message-ID: <CAHk-=whypK=-91QfDpd3PWwazx35iWT=ooKLxhbeTAwJL_WXVg@mail.gmail.com>
Subject: Re: [PATCH] attr: block mode changes of symlinks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 12 Jul 2023 at 02:56, Christian Brauner <brauner@kernel.org> wrote:
>
> Changing the mode of symlinks is meaningless as the vfs doesn't take the
> mode of a symlink into account during path lookup permission checking.

Hmm. I have this dim memory that we actually used to do that as an
extension at one point for the symlinks in /proc. Long long ago.

Or maybe it was just a potential plan.

Because at least in /proc, the symlinks *do* have protection semantics
(ie you can't do readlink() on them or follow them without the right
permissions.

That said, blocking the mode setting sounds fine, because the proc
permissions are basically done separately.

However:

>         if ((ia_valid & ATTR_MODE)) {
> +               if (S_ISLNK(inode->i_mode))
> +                       return -EOPNOTSUPP;
> +
>                 umode_t amode = attr->ia_mode;

The above is not ok. It might compile these days because we have to
allow statements before declarations for other reasons, but that
doesn't make it ok.

             Linus
