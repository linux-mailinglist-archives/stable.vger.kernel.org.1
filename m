Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD575FF06
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjGXS15 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjGXS1v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 14:27:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8410D9
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:27:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fdea55743eso3685421e87.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690223268; x=1690828068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hFsFnyl7tT3CvQE6TFTWwPvkx99KpTgqJ+hpUJ1OTjY=;
        b=YDEMgSzb9abFx8/eHJUihXwF+FMZV7mcJSJm7wlzZOsZttCR363cG7hHA1YW106/UT
         Nr07LqVy7KcKImwr0uzsIL4rc9w5x+54dxUbq+IXNMhX4k42OhH80oeBijTdKrJmzIeC
         oFZcQ2QwVWRH5DNvkho3nigJurAOXGE021em4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223268; x=1690828068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFsFnyl7tT3CvQE6TFTWwPvkx99KpTgqJ+hpUJ1OTjY=;
        b=j/7fWFsiSPVb23ZZiF0LcfKyoXiTX8j+lJ+OpgFnxw1SASeVS8RQcDVnT9yMEJ9Ro/
         qPV+V9LeoOCkbx9cQha5cO7kBguzh1rSAwt4VUeMj9O/FhE8q+VVIL6FK9naR5uClQNp
         3FNuW1M04NsVywDMruG+giDeCcXWcsDHDmSesZAM3mxuXnzrmI39JVGiQAeiUAu24aW+
         3fNowZh3HrisK8K75/AzW4vjaHejNSpl7TyGoetq+cuVRVwGOkyq6fHychNeUHM2WAgo
         p6IzHITTqRLf0rZzBOxuXPNWfV0ioeYZp5qQ4laHHL/3lxiiknUsoHOqyIpx32tsYtDS
         pIEA==
X-Gm-Message-State: ABy/qLakpoSic27m/4/ClKnDETJT1nGQ9DjVj4zG22soQQoYgmXzWviZ
        IXVb0pgn+rud4Cqd1T2nv0/cQ1iTM1S5nZuEQwfVAtnD
X-Google-Smtp-Source: APBJJlECmtxzmwAN7Es6FRQPihfD9erEszHQPsVmvjv0dNDHd9dCl7ZSrfr4d7vGJf+xqFqSZpVLvg==
X-Received: by 2002:a2e:9047:0:b0:2b5:974f:385 with SMTP id n7-20020a2e9047000000b002b5974f0385mr6908465ljg.9.1690223268404;
        Mon, 24 Jul 2023 11:27:48 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b00965a4350411sm7029058ejt.9.2023.07.24.11.27.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:27:47 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so6968050a12.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:27:46 -0700 (PDT)
X-Received: by 2002:a50:ef0b:0:b0:51d:d4c0:eea5 with SMTP id
 m11-20020a50ef0b000000b0051dd4c0eea5mr7690205eds.40.1690223266649; Mon, 24
 Jul 2023 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner> <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner> <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
In-Reply-To: <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 11:27:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
Message-ID: <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
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

On Mon, 24 Jul 2023 at 11:05, Jens Axboe <axboe@kernel.dk> wrote:
>
> io_uring never does that isn't the original user space creator task, or
> from the io-wq workers that it may create. Those are _always_ normal
> threads. There's no workqueue/kthread usage for IO or file
> getting/putting/installing/removing etc.

That's what I thought. But Christian's comments about the io_uring
getdents work made me worry.

If io_uring does everything right, then the old "file_count(file) > 1"
test in __fdget_pos() - now sadly removed - should work just fine for
any io_uring directory handling.

It may not be obvious when you look at just that test in a vacuum, but
it happens after __fdget_pos() has done the

        unsigned long v = __fdget(fd);
        struct file *file = (struct file *)(v & ~3);

and if it's a threaded app - where io_uring threads count the same -
then the __fdget() in that sequence will have incremented the file
count.

So when it then used to do that

                if (file_count(file) > 1) {

that "> 1" included not just all the references from dup() etc,  but
for any threaded use where we have multiple references to the file
table it also that reference we get from __fdget() -> __fget() ->
__fget_files() -> __fget_files_rcu() -> get_file_rcu() ->
atomic_long_inc_not_zero(&(x)->f_count)).

And yes, that's a fairly long chain, through some subtle code. Doing
"fdget()" (and variations) is not trivial.

Of course, with directory handling, one of the things people have
wanted is to have a "pread()" like model, where you have a position
that is given externally and not tied to the 'struct file'.

We don't have such a thing, and I don't think we can have one, because
I think filesystems also end up having possibly other private data in
the 'struct file' (trivially: the directory cursor for
dcache_dir_open()).

And other filesystems have it per-inode, which is why we have that
"iterate_shared" vs "iterate" horror.

So any dentry thing that wants to do things in parallel needs to open
their own private 'file' just for *that* reason. And even then they
will fail if the filesystem doesn't have that shared directory entry
iterator.

           Linus
