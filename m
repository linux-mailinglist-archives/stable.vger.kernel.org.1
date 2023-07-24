Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5775FB3C
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjGXPyA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGXPx6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 11:53:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56EE70
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:53:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991ef0b464cso1189024466b.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690214031; x=1690818831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gGgctA2utHA8Ao8JF1uO8HVoivYG2O9nLkJv2/8DmH8=;
        b=JVWXqJAxDgZpjEpGxa0aAZkvDjjTaKiQ8mFdp2sPgRJuID6aRIV/E9Nx/RLoFJTHqR
         J3VrH+xas43LBUcTnD3U/e95vtIar72kzk3MlX1JgCxpKajLiX8aucCK8LrsLU8haeGb
         gqTwAskoMH+gObYWgDQe89Jjb5bdNQ8JNtabw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214031; x=1690818831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGgctA2utHA8Ao8JF1uO8HVoivYG2O9nLkJv2/8DmH8=;
        b=ISQp5+c241pbNVZII7fxLUqf3m6LtJaIIbTuMQamUJbh58gffb09QRskseNlABuIBv
         7DclBneIjt4ZiOKNcj/NTnQhzx7zO6nhxjFm6Vq2/QyoM++7ZedPFX2L2iXZ2azhI5um
         Al16upgBBGRyiH5uytpM7qWtcqHa07Z2/yXY0jr4/PQ2nY2WUNEunvK4ms/ZZhVLJNdk
         xQjOw749D+tWMp2SUWWQK8H/GnIFPKhlTh9jZKfcVSYqKtQDj/hjLv6nBW39iLMVowTu
         WUNBtUNvKHLB/KpiZoW7j0AKb2+fRS6h9ePOMI2ZW7Tabc+WzBvrS1sHrL2B4+XULGyy
         GzvQ==
X-Gm-Message-State: ABy/qLbr5SOOUXV1POltvs5k4qrC2P+Zu3zyDuM5FlgZ8GPZBvp0q3e8
        BWKFi0dh2+hxC7sa4X7oT2ANItwmaSbqaIG/VsyPgQ==
X-Google-Smtp-Source: APBJJlFFzmcDfOeldwxPK3Jx6HUsrlzcznQnudyR6uZ9JQaW+2qUQCkVZ0foV8mB/Zcz21NUTR8ofg==
X-Received: by 2002:a17:907:2da9:b0:98e:48cc:4cbf with SMTP id gt41-20020a1709072da900b0098e48cc4cbfmr15885407ejc.26.1690214031223;
        Mon, 24 Jul 2023 08:53:51 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906868400b009920e9a3a73sm6889457ejx.115.2023.07.24.08.53.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:53:50 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11552725a12.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:53:50 -0700 (PDT)
X-Received: by 2002:a05:6402:1212:b0:521:ad49:8493 with SMTP id
 c18-20020a056402121200b00521ad498493mr10321795edw.6.1690214029969; Mon, 24
 Jul 2023 08:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
In-Reply-To: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 08:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
Message-ID: <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

So this was a case of "too much explanations make the explanation much
harder to follow".

I tend to enjoy your pull request explanations, but this one was just
*way* too much.

Please try to make the point you are making a bit more salient, so
that it's a lot easier to follow.

On Mon, 24 Jul 2023 at 08:01, Christian Brauner <brauner@kernel.org> wrote:
>
>     [..] the
> file_count(file) greater than one optimization was already broken and
> that concurrent read/write/getdents/seek calls are possible in the
> regular system call api.
>
> The pidfd_getfd() system call allows a caller with ptrace_may_access()
> abilities on another process to steal a file descriptor from this
> process.

I think the above is all you need to actually explain the problem and
boil down the cause of the bug, and it means that the reader doesn't
have to wade through a lot of other verbiage to figure it out.

>         if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> -               if (file_count(file) > 1) {
> -                       v |= FDPUT_POS_UNLOCK;
> -                       mutex_lock(&file->f_pos_lock);
> -               }
> +               v |= FDPUT_POS_UNLOCK;
> +               mutex_lock(&file->f_pos_lock);
>         }

Ho humm. The patch is obviously correct.

At the same time this is actually very annoying, because I played this
very issue with the plain /proc/<pid>/fd/<xyz> interface long long
ago, where it would just re-use the 'struct file' directly, and it was
such a sh*t-show that I know it's much better to actually open a new
file descriptor.

I'm not sure that "share actual 'struct file' ever was part of a
mainline kernel". I remember having it, but it was a "last century"
kind of thing.

The /proc interface hack was actually somewhat useful exactly because
you'd see the file position change, but it really caused problems.

The fact that pidfd_getfd() re-introduced that garbage and I never
realized this just annoys me no end.

And sadly, the man-page makes it very explicit that it's this broken
kind of "share the whole file, file offset and all". Damn damn damn.

Is it too late to just fix pidfd_getfd() to duplicate the 'struct
file', and act like a new open, and act like /proc/<pid>/fd/<xyz>?

Because honestly, having been there before, I'm pretty convinced that
the real bug here is pidfd_getfd.

I wonder if we could make pidfd_getfd() at least duplicate the struct
file for directories. Those are the things that absolutely *require*
atomic file positions.

Argh.

I wonder if this also screws up our garbage collection logic. It too
ends up having some requirements for a reliable file_count().

                Linus
