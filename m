Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750CF75FC8D
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGXQv1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGXQv0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 12:51:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26166E54
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 09:51:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99364ae9596so801544066b.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690217483; x=1690822283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1PcgD4KNACPIHRzby9gkRic2d4smXVPIn37UpHTR9A=;
        b=WRlPdejRXuqwClLsrc073yiX/16IWeF7XMgJS0/Wo4b+CwQgUlRMEjnNRecDn8J7AL
         0nG8VjYkNh7qfzJrBdMsuNTnHkCcGUk6djL5vfTv5a76/dCjeHHSZz+J46T96cR3GbBz
         eDVift+Ljn6opZHIYkkbTiWqVeK/5uKDlfRuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217483; x=1690822283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1PcgD4KNACPIHRzby9gkRic2d4smXVPIn37UpHTR9A=;
        b=km4D/ByVWhZBUT4vvPZ6zyteyA7ectwbaRZWGQRi8eXhlieGiXuDXynV2xXhw1gBba
         46xtu+2IisU52xutPNF9xRNPpTf/rGQHibbA8NS6Xvry+A3Efkns5ODlRkEIoLlneliN
         riLNMhZhApmN8Uqm8BJiuRoDbijhFglaNgfjIDEDshl6pZYjcx/Q6RU0BXQCK56pSXtG
         osvGylcOUXO8yFUx+mmlN5FD0DraMLvPgJWnE4lQN1ET830SBGAnUsXtXy33CBHnJgEu
         XDVwjjNN9LhyqvMWFZobVrRDv07Ax4Ia++0IvHXB5d4tUBHU2POgjq2+Serm46kGGj0f
         smZQ==
X-Gm-Message-State: ABy/qLYEIqAl8FAKUb/ZncyfOq3T/xkGm/+9D33RlMwdNQJECRgYm0oJ
        pRyfg+sD5GBCW02TtbFXsRa8wkm3DxeRoWyjk+3fEg==
X-Google-Smtp-Source: APBJJlFR1QVzfDvzF9TeIL4Dd6df4RO6KkGISeILYUVEvHK589IlycLpGCbfpF+I3II5PuYkUY9OpQ==
X-Received: by 2002:a17:907:b19:b0:994:4f10:fb39 with SMTP id h25-20020a1709070b1900b009944f10fb39mr10337647ejl.16.1690217483417;
        Mon, 24 Jul 2023 09:51:23 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906388b00b00988dbbd1f7esm6842598ejd.213.2023.07.24.09.51.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:51:22 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso800451766b.3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 09:51:22 -0700 (PDT)
X-Received: by 2002:a17:906:292:b0:999:37ff:be94 with SMTP id
 18-20020a170906029200b0099937ffbe94mr10526397ejf.71.1690217482084; Mon, 24
 Jul 2023 09:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
In-Reply-To: <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 09:51:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtPzpL1D-VMHU9M6jbwSqFuXsc5u_6ePanVkBCNAYjMQ@mail.gmail.com>
Message-ID: <CAHk-=whtPzpL1D-VMHU9M6jbwSqFuXsc5u_6ePanVkBCNAYjMQ@mail.gmail.com>
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

On Mon, 24 Jul 2023 at 09:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are magic rules with "total_refs == inflight_refs", and that
> total_refs thing is very much the file count, ie
>
>                 total_refs = file_count(u->sk.sk_socket->file);
>
> where we had some nasty bugs with files coming back to life.

Ok, I don't think this is an issue here. It really is that "only
in-flight refs remaining" that is a special case, and even
pidfd_getfd() shouldn't be able to change that.

But the magic code is all in fget_task(), and those need to be checked.

You can see how proc does things properly: it does do "fget_task()",
but then it only uses it to copy the path part, and just does fput()
afterwards.

The bpf code does something like that too, and seems ok (ie it gets
the file in order to copy data from it, not to install it).

kcmp_epoll_target() -> get_epoll_tfile_raw_ptr() looks a bit scary,
but seems to use the thing only for polling, so I guess any f_pos is
irrelevant.

               Linus
