Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553CB75FDD5
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGXRey (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGXRex (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 13:34:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE76F10D1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:34:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so65637501fa.3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690220090; x=1690824890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSeNUZn0VMlhUmialM4MIBW/h43PVFZlS7oEOOQOqx4=;
        b=E1iZNZgHqy5j84LnJL8C5nGb7AYsOkLu4MLNb6FypA4nNUJ9zZFjNSUnmiu54hfNq6
         fJlddLLO1vFogLhej844F0tNYGf5y3bu/KHmt6cqPkwL+spyPISjZh9Cg1fmAdfMO3yC
         RhlleFLP0+pgPY3E1RUPwTdMD+UbjOeHgTJBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220090; x=1690824890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSeNUZn0VMlhUmialM4MIBW/h43PVFZlS7oEOOQOqx4=;
        b=I6l3yBwwUp222EiXQ684sLXMgh8RpI+BsNUu/MrZlgucVrSUNW49TIQLUpeawF+k4G
         QXbaIpbBYmbY5GcfoGOc+C6aT6iRTsTCR0IfPKAkXXQAvQT67iHmqaI6EF+Y4GhrcMbB
         o6nGgm3e0rgugMeph1//T7o5znQFIFs1LgJfQlyqsMftfj607LtyBngSOkayd1hL97UH
         Hl5/3eTYKjLwqZAH2bPuDb1LBO0dhdohcwkLxsLvEBX4a2xXLrQFQYUSGHaD3FPB0NbY
         rF7FAxqt7KwKJTXS5sS+qUK6ROk60dehuplS5o0xkYljcR/RReOvgIaCUuVdTdayA5cD
         p4DA==
X-Gm-Message-State: ABy/qLZYkXD8KqoN75rIfumY3oq18qDrdu1hvy6I1xPmR6lbX+UbL9rj
        U804f9/hahAu3G08v5O4Drn59BE0Afs9v8K+eOi9kuGF
X-Google-Smtp-Source: APBJJlEPGqUHztt21PVtqRvaOYchJDOITzQtOPGxXlQt1LTkEDAkSUn06zZQXSL9VWrdFosB2t+B4A==
X-Received: by 2002:a2e:97da:0:b0:2b6:ec2b:7d77 with SMTP id m26-20020a2e97da000000b002b6ec2b7d77mr6800027ljj.6.1690220089815;
        Mon, 24 Jul 2023 10:34:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n25-20020a2e86d9000000b002b69f44646bsm3022768ljj.17.2023.07.24.10.34.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:34:48 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso7071071e87.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:34:48 -0700 (PDT)
X-Received: by 2002:a05:6512:b96:b0:4fd:c23b:959d with SMTP id
 b22-20020a0565120b9600b004fdc23b959dmr8461441lfv.34.1690220088417; Mon, 24
 Jul 2023 10:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner>
In-Reply-To: <20230724-gebessert-wortwahl-195daecce8f0@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 10:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
Message-ID: <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
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

On Mon, 24 Jul 2023 at 10:23, Christian Brauner <brauner@kernel.org> wrote:
>
> This means pidfd_getfd() needs the same treatment as MSG_PEEK for sockets.

So the reason I think pidfd_getfd() is ok is that it has serialized
with the source of the file descriptor and uses fget_task() ->
__fget_files.

And that code is nasty and complicated, but it does get_file_rcu() to
increment the file count, and then *after* that it still checks that
yes, the file pointer is still there.

And that means that anybody who uses fget_task() will only ever get a
ref to a file if that file still existed in the source, and you can
never have a situation where a file comes back to life.

The reason MSG_PEEK is special is exactly because it can "resurrect" a
file that was closed, and added to the unix SCM garbage collection
list as "only has a ref in the SCM thing", so when we then make it
live again, it needs that very very subtle thing.

So pidfd_getfd() is ok in this regard.

But it *is* an example of how subtle it is to just get a new ref to an
existing file.

That whole

         if (atomic_read_acquire(&files->count) == 1) {

in __fget_light() is also worth being aware of. It isn't about the
file count, but it is about "I have exclusive access to the file
table". So you can *not* close a file, or open a file, for another
process from outside. The only thread that is allowed to access or
change the file table (including resizing it), is the thread itself.

I really hope we don't have cases of that.

             Linus
