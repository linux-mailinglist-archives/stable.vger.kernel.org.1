Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709B763674
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjGZMgu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 08:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjGZMgu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 08:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53F212F
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690374951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFkjH+MnCEAPrOl6H7wOiLENjcTBxMYcPSAq0VwYmM0=;
        b=Keb6UjcO9E7pd0fZfOhK9SKJ+fC3pVhcPj40w8MUxOSwlzUu1NWbzXybYs8o1Ret59XgrY
        UShAazthgzeNbu6XiN7f8PqMzNwkl5RQwlChutZ1Ju3LLNYbJVieUJqo0eyYbDeK1FBcnU
        VXTC1BXqGjGw+Vx/GfHNvwBWvg751Kg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-SqeawOGxOPa15C5W1bvrYw-1; Wed, 26 Jul 2023 08:35:50 -0400
X-MC-Unique: SqeawOGxOPa15C5W1bvrYw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-78335dcde31so433786239f.1
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 05:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374950; x=1690979750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFkjH+MnCEAPrOl6H7wOiLENjcTBxMYcPSAq0VwYmM0=;
        b=j/VhE0qbqc/LQ4rw3LZslWGdpyGZ244dmMK+NofN0YSMKNFSnKWkKQ29tnja4fmuo6
         DWAuGzGhiu/xkF3dQOzOOmWVICIE6AEURo89Ml9cYOoh8OAEIN1Ze+9SETJkV9SSV9aA
         kJ+t/0UkvN59qNxuQUbWgdfhb9m/bA3rkLUWz2ZFtIMTWe5GS1bLDrBfO++8L+jYkIfk
         rvXWI7dK/ItZeYa+xHlGC3eIKon5WzQVOUzxMBeOwQUOG69/MUrxJeOZdZVc6xw2fZVZ
         0D2cIjlGz5dtab/MGGhvMx5a2v84k0NGg65CxjPZNoyjARG1GdqA0R1B2ouLizmFCzq6
         BFbg==
X-Gm-Message-State: ABy/qLbW9YTKHl/wO8EfbbySBEz/tvbwzgj1QCVMvfwVEeG9u7aFWLkd
        CphmJLHzQejnRPa+03y5fgXxNXBnFjFJsTNFuG5ql55BBWgvCT0pmcV/wjoEZTNDL8v6NpKa8sY
        5QQIrcRJ9aOSKW3yNyxYt3YvTzaD6Vz6A
X-Received: by 2002:a05:6e02:dc2:b0:348:76eb:17d9 with SMTP id l2-20020a056e020dc200b0034876eb17d9mr1666580ilj.20.1690374949831;
        Wed, 26 Jul 2023 05:35:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHYBV7ZT2xj3MdNS+ezKAmDOTGtkB1dzFkR0/RCiYkLbFImT1PX7dJ2pP4jcB7MhfnBLztbMaBZFm6EhZAdX1o=
X-Received: by 2002:a05:6e02:dc2:b0:348:76eb:17d9 with SMTP id
 l2-20020a056e020dc200b0034876eb17d9mr1666568ilj.20.1690374949645; Wed, 26 Jul
 2023 05:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <2023071616-vastly-cognition-78ba@gregkh>
In-Reply-To: <2023071616-vastly-cognition-78ba@gregkh>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 26 Jul 2023 14:35:38 +0200
Message-ID: <CAOssrKdkLGRNn7z=7cOFpq5UtK2pXcZ37cOvn-zH8zrTAA5afA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ovl: fix null pointer dereference in
 ovl_permission()" failed to apply to 6.1-stable tree
To:     gregkh@linuxfoundation.org
Cc:     chengzhihao1@huawei.com, amir73il@gmail.com, brauner@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 6:30=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1a73f5b8f079fd42a544c1600beface50c63af7c

Applies and tests cleanly against v6.1.41.

Maybe the failure was due to dependency on commit b2dd05f107b1 ("ovl:
let helper ovl_i_path_real() return the realinode")?

Thanks,
Miklos

