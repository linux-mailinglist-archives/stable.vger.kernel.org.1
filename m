Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D473797D6F
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjIGUfw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjIGUfw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 16:35:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797AB1703
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 13:35:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401da71b7faso16023675e9.2
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694118947; x=1694723747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atXeRfE0mDVD+y4O/MdfuuYUpZQSWnCC9q6t9PO21FY=;
        b=V43jzmQ6EFAP66g3isfeZNKw+Xp3IWamcFyEHR4ZyHBBlL+oHxEt2I/aeFVx9agjgb
         xodTMIVWEetq2CgIfxJj3adRFRLly5M2XV/IDM1puIneuTLVNPXPo1YlextOhZRCdkwA
         9qQ7EVp+k5XU0XZvGtRafnUWmfV78nTS1Y5iXUaWjOtXc0dI9HicHn5tRNTkEL7+qhQQ
         9WdieHPhLLbMrpVxLkB6RGx8XAhiWH3Valg5zUKw1jqR4FwFIgdfYbIZ5J2YAbEUCexU
         n3JZKzAYh9RwE7HpAe2QM5jDajdf/VcrWNlCR1emMFWLiGoBOEqA9JGsvqLKLr2FzmbW
         fmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694118947; x=1694723747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atXeRfE0mDVD+y4O/MdfuuYUpZQSWnCC9q6t9PO21FY=;
        b=Xlqb8DrFq+Yfpc5Un9COxRCA/NddBSVXSal/W3MR7/QT+ASuMa9BNiReeGlIIPJ9kO
         owfqiOwpVVZBRfaX75YQEsT6HBev2TqA7zJMXALUrB3ouSkjtANbWthaDBn2GbcKdjGU
         jDW/Ny/WHWapu+E17bg358/4NDSrcRgO0IQUFcTI2kQCprUL90E+zL9e1RJ/o7R0pLGN
         u26WGGoowzfZkIHmmUUbB6t6xRuhyevZ6vtx18EV3FyIEVz+c0fP6ir2ZQrJe42evE9O
         YMyy2oDBN3qR4aMPA1Jf3adef7d5b5XFuRM2jlItSEoYqGUyYxw0GTJ4Z2qPrqqKqKH0
         BCEw==
X-Gm-Message-State: AOJu0YxVyrl+LBFFOtGKdT0iApSpQhT+D6QYD3MwZ8U4zqVAEQ1Mv6OE
        a4S+r50dtgWvXSQrMqF6wOvz8PY44r6y5Y+v4vZvCvX60Mw=
X-Google-Smtp-Source: AGHT+IHQgKl78meaetXXT4xDY6BAAubYGNNjBqHcpuJus5so0qj1XzRqjTQ54486HMH4q7jsDqsjZ/s2AkNIq4meyWU=
X-Received: by 2002:a1c:7914:0:b0:401:daf2:2737 with SMTP id
 l20-20020a1c7914000000b00401daf22737mr500707wme.30.1694118946632; Thu, 07 Sep
 2023 13:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814070213.161033-1-joshi.k@samsung.com> <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com> <ZPH5Hjsqntn7tBCh@kbusch-mbp>
 <20230905051825.GA4073@green245> <ZPduqCASmcNxUUep@kbusch-mbp>
 <20230906154815.GA23984@green245> <ZPnvM3kNSHVA8x6Y@kbusch-mbp>
In-Reply-To: <ZPnvM3kNSHVA8x6Y@kbusch-mbp>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 8 Sep 2023 02:05:20 +0530
Message-ID: <CA+1E3rLrj+hWr-c2n-9dX=fQj_-Ch2tgZQfwrc1BNL5orMbyYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough metadata
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 7, 2023 at 9:11=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Wed, Sep 06, 2023 at 09:18:15PM +0530, Kanchan Joshi wrote:
> > Would you really prefer to have nvme_add_user_metadata() changed to do
> > away with allocation and use userspace meta-buffer directly?
>
> I mean, sure, if it's possible. We can avoid a costly copy if the user
> metabuffer is aligned and physically contiguous.

Seems possible, but that does not really solve the actual problem
(which is not performance) this patch is for.
It will require replicating big code of blk_rq_map_user_iov() for
integrity metadata and map the pages into bip.
But since the user-space meta buffer can be unaligned (and bunch of
other conditions present there), it has to make the meta copy in
kernel-space.
And we will be back to where we started - how to avoid corruption into
kernel memory.

Same situation for the case when we are dealing with
extended-lba-format and interleaved user-buffer is unaligned. .

Handling both these anyway requires adding the kind of code/checks
mentioned in the previous patch.
Do you see another way?

While I agree there is value in avoiding the meta copy in general and
I can look into it, but that should be a separate effort (with focus
on performance).

> > Even with that route, extended-lba-with-short-unaligned-buffer remains
> > unhandled. That will still require similar checks that I would like
> > to avoid but cannnot.
> >
> > So how about this -
>
> There's lots of bad things you can do with this interface. Example,
> provide an unaligned single byte user buffer and send an Identify
> command.

Not sure I follow. Do you mean the patch does not handle these cases?

> We never provided opcode decoding sanity checks before because it's a
> bad maintenance burden, adds performance killing overhead, couldn't
> catch all the cases anyway due to vendor specific and future opcodes,
> and harms the flexibility of the interface.

Given the way things are (integrity schemes, cdw12 etc.), I do not see
a way to avoid opcode checks.
Flexibility is not getting reduced in the previous patch. All the
other commands (beyond read/write/compare/append) remain untouched.
And metadata-io is not the fast path at the moment (given memory
allocation, bunch of extra things by blk-integrity, bunch of extra
things done by device etc.).

>The burden is usually on the
> user for these kinds of priviledged interfaces: if you abuse it, "you
> get to keep both pieces" territory.

Not sure I got that. Have you seen the crash mentioned in this cover
letter: https://lore.kernel.org/linux-nvme/20230811155906.15883-1-joshi.k@s=
amsung.com/
A simple unprivileged read by a rogue application can wreck other
applications/system at the moment.
Is it fine to keep the status quo?
