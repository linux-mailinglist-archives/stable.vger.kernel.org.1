Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418E075FEB0
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGXSCM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGXSCL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 14:02:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5401E94
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:02:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99313a34b2dso682032766b.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690221727; x=1690826527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ww9R2x3oxi/S1G/NZ/cLGz6L0X+/XG/qIDLCV0WBdOA=;
        b=K7Qq68FAYgM/hMm5ZgyuTAqYhwWy2JS//vUqDtmSY3G8w5hSY2aewWXlJOYzhTjpHq
         2qsqGERb8jtaTtUn9fJ73FnBKNCaP6q2WdnQEPX3IGHW2coj5XBBlBxY4qYatrQy3C0b
         fOZkGrHmTsMqUtPEjCPesEnm/H5wTaO/Se8Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221727; x=1690826527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww9R2x3oxi/S1G/NZ/cLGz6L0X+/XG/qIDLCV0WBdOA=;
        b=KsyvXD0ctUe0GuvD5OvQ1bkjpIga6qI0CaPZmxVxSpEKT3jha12zrxB9+Wvo6SqDPw
         YkshAgcyXjEwEVhbYVn9LH+IA4AthNArv3DWtffSzeeig9mNyXZ1TLapDb0uHtqkMoQo
         z1sBod0881ZNSZGa4HpLzXUaqb99RnuuCeKGixz0l4EoflWTRdHUiUe8KCJezaUoXEXP
         7c2OMSuIyV9KpuPLxPBcrNf/rN6JmFaNZTQBIc0tLr/DyoN/YukFGlb9+b33mastBUUy
         Z5AhB4JJWjgl8hVSFS2ymb7bGImSdDqf2/oJQt0VvLCWbWgT86W1a6S/59Zj65tNRHxw
         6/hw==
X-Gm-Message-State: ABy/qLaAaT/kyDqJR6qhEpchzSuhFFgExnsBhiAqiSTV1akqQG4EC2Dy
        rVntP4F1xs8YNFXGyE7XyvyE+dU/vzPz7/QxVLf9N8Fn
X-Google-Smtp-Source: APBJJlEyou6Hcpmd5/uaVeiMnBBbn90+t6FcQoEzffnjVSg45DL2Nnw2S9Fh3tsdlfk9cpeFnreUGw==
X-Received: by 2002:a17:906:3147:b0:994:1844:c7d1 with SMTP id e7-20020a170906314700b009941844c7d1mr10795902eje.13.1690221727566;
        Mon, 24 Jul 2023 11:02:07 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id kk1-20020a170907766100b00997bd42d210sm6908463ejc.205.2023.07.24.11.02.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:02:06 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so6607149a12.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:02:06 -0700 (PDT)
X-Received: by 2002:aa7:d653:0:b0:521:7779:d918 with SMTP id
 v19-20020aa7d653000000b005217779d918mr9172868edr.19.1690221726410; Mon, 24
 Jul 2023 11:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner> <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
In-Reply-To: <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 11:01:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
Message-ID: <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
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

On Mon, 24 Jul 2023 at 10:46, Christian Brauner <brauner@kernel.org> wrote:
>
> I don't think we do but it's something to keep in mind with async io
> interfaces where the caller is free to create other threads after having
> registered a request. Depending on how file references are done things
> can get tricky easily.

Honestly, by now, the io_uring code had *better* understand that it
needs to act exactly like a user thread.

Anything else is simply not acceptable. io_uring has been a huge pain,
and the only thing that salvaged the horror was that the io_uring
async code should now *always* be done as a real thread.

If io_uring does something from truly async context (ie interrupts,
not io_uring threads), then io_uring had better be very *very*
careful.

And any kind of "from kthread context" is not acceptable. We've been
there, done that, and have the battle scars. Never again.

So the absolutely *only* acceptable context is "I'm a real
io_uringthread that looks exactly like a user thread in every which
way, except I never return to user space".

And if io_uring does absolutely _anything_ to file descriptors from
any other context, it needs to be fixed *NOW*.

No more games.

And absolutely *nothing* like that disgusting pidfd_getfd().

So the only reason io_uring can do open/close/etc is because from a
file descriptor standpoint it looks just like any other threaded
application would look, and all those optimizations like

        if (atomic_read_acquire(&files->count) == 1) {

JustWork(tm).

I think that's the case right now, and it's all good.

But if I'm unaware of some situation where io_uring does things like
this in some workqueue or other context, people had better holler -
and fix it.

                   Linus
