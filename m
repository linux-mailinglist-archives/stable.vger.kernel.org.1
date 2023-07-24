Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F1760239
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGXWZm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXWZm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:25:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CA10CB
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:25:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9922d6f003cso839823866b.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690237539; x=1690842339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uoZezQAkLFsNU54aBnaEm6y72dPCCTyjEbKAFD+pMJ8=;
        b=HcAO6f71lYIO8QU4q3hWrbWSZi31dNWpVvuLZmPxpaOfufLmeRGraMVbSjF9PsHMnT
         ZANI7EchAdwJdkBjhDc7tNSTMmrBjDuqbB24zWdO/IcYCCl4+60Jtzz2LsHUiGtOoq2g
         uqKxKC0dWr1mTjHLFL15ZUHhP4wJTKgrpOZSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690237539; x=1690842339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoZezQAkLFsNU54aBnaEm6y72dPCCTyjEbKAFD+pMJ8=;
        b=T71LneMwOL8Z0mDaujqK20xJsvyI9yZld97/3y51v109HF7wR9ZJNSGxeg334bxRjk
         CPJCls040TQPVt2J7qrHOs6UJJWpsVQrbMtZkFDBn8pB/1wpqGQyUz4W7NHikrSexHzM
         79ar25WsBVe8237/sDUAXyfxMmzID+/AxS9ynFJ8u3lOaoIyk1Zp87AJ5sB0YyJmSNwC
         /pzNZKOy6kvN0mRbemMB2Yk7dZTyYb7u8qHdcf8En5nLTQ4SsFv1KDh2DwxedBg54zKb
         +A3fHoJTnEvxvlMXDi+M39s4mV2QncCOF+57pQVMAbDYLIyBiEYK1Jx0ehUxk0vzHatQ
         EjuQ==
X-Gm-Message-State: ABy/qLYU1S69sMSM5auBK5sQIJ7mm0sNXvKVjNKpjJ8hN/moWKfALC4Z
        Sf49on4NUIXuiVLBAZ/j4ezDBYUY09RxwYB1spO2WwVM
X-Google-Smtp-Source: APBJJlE3KExRYgOGFeuuiiagmJYjmPkD0Iht/Lhtqk5vUAUZFesWv8kkRlO6Mpj7eBig/E51xikgtA==
X-Received: by 2002:a17:907:2cd0:b0:992:8092:c109 with SMTP id hg16-20020a1709072cd000b009928092c109mr11181967ejc.51.1690237539345;
        Mon, 24 Jul 2023 15:25:39 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090686ce00b00982a92a849asm7332868ejy.91.2023.07.24.15.25.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 15:25:38 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so711714a12.3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:25:38 -0700 (PDT)
X-Received: by 2002:aa7:c2c4:0:b0:51d:9dd1:29d0 with SMTP id
 m4-20020aa7c2c4000000b0051d9dd129d0mr10619733edp.23.1690237538308; Mon, 24
 Jul 2023 15:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <20230724-gebessert-wortwahl-195daecce8f0@brauner> <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner> <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk> <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
In-Reply-To: <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 15:25:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
Message-ID: <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
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

On Mon, 24 Jul 2023 at 11:48, Christian Brauner <brauner@kernel.org> wrote:
>
> It's really just keeping in mind that refcount rules change depending on
> whether fds or fixed files are used.

This sentence still worries me.

Those fixed files had better have their own refcounts from being
fixed. So the rules really shouldn't change in any way what-so-ever.
So what exactly are you alluding to?

                     Linus
