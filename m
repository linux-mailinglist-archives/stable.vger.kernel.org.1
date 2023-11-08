Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295747E561A
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 13:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjKHMTq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 07:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHMTp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 07:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333D1BE4
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 04:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699445940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvMbksH7c6ZcEvPYTegmnIug2dODLV7SHYglfVWxD9g=;
        b=N9N86adr3BRZpnHTJ4LJEdzuCGtEF8iRX+Zl5RYfOmsbiLRS9kf9WhfuoTh6lpKV5KBlg4
        94dF7f3uU6UakhR5LZDxb6+14zllHVYZtfwm969EJAk26EvHmYBQUBi4r0xacMXkFKUkzf
        GgJoiNXnJRsQiv1ogva0+Q4qzfQoQGs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-mTEXcjOrOOGvMAgNNYGq0Q-1; Wed, 08 Nov 2023 07:18:58 -0500
X-MC-Unique: mTEXcjOrOOGvMAgNNYGq0Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bd11c1e8daso4081496a12.1
        for <stable@vger.kernel.org>; Wed, 08 Nov 2023 04:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699445937; x=1700050737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvMbksH7c6ZcEvPYTegmnIug2dODLV7SHYglfVWxD9g=;
        b=D2r5wbw7Qo7XZ4lD33fP1FRbsQTg6LiQNrkdXrcvlPMTymB5NpTiNoUQ8pRhuXQhDc
         LCNIxJZMwL6i5biXdr6UTRNxfQa/FAozGcW+KAAiBs93VvpOvdc9n4VtgyVHCKnDLmPj
         y7xtRDbeLHjBbPhXIAAHqVIl59fhVDfacw7OZ6b1K9fE6whT0SiyTH91LcoVEAkeKzgP
         p++PRIZnBGyiRxGALPDafIxIjikQjoCyxgRzFqtaldhKXa+vlQL/cxtK99ZqO3G6B1cN
         mJzclojAq3ZgAajmbInVnB0MLlD5weqMHUFefpr2BwGUYVt3wH4ne382Cg5PJnxHWNNz
         rY0w==
X-Gm-Message-State: AOJu0Yzf393cy4Hu7HRNy0H8cNJcHUTJn8zPvg8gom2zkmxkE8B0gFpR
        PgthQ3J8yI4x5TqqQu1TY+hS9R/4vXgXXiiG09XLmjxgz9skgOUFpFmsp5DHzqV4CFJMxoH4p7G
        rloastCEFAUYwfNJfudiHLwRf8ufLNjQO
X-Received: by 2002:a05:6a20:938a:b0:181:90eb:6b24 with SMTP id x10-20020a056a20938a00b0018190eb6b24mr2095539pzh.22.1699445937510;
        Wed, 08 Nov 2023 04:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMbLzr20JSxrzK1NYa1Vhm0XM23Nhag0peMzgZJ1k+N4/hUlCW39pruQ7YMOM5nxoc/XiYAkMlMh4BRGJ1gqM=
X-Received: by 2002:a05:6a20:938a:b0:181:90eb:6b24 with SMTP id
 x10-20020a056a20938a00b0018190eb6b24mr2095525pzh.22.1699445937280; Wed, 08
 Nov 2023 04:18:57 -0800 (PST)
MIME-Version: 1.0
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
 <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
 <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
 <CAOssrKeJB7BZ7fA6Uqo6rHohybmgovc6rVwDeHbegvweSyZeeA@mail.gmail.com>
 <7df24b0e-ea98-4dc7-9e1b-dfc29d0fa1b1@leemhuis.info> <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
In-Reply-To: <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 8 Nov 2023 13:18:46 +0100
Message-ID: <CAOssrKeUbmEUWnT_JoRRAb0asttB3FfMva121D+sXFYEuFTV8w@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 8, 2023 at 11:31=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> We are using the Android kernel in all cases and Android applies
> patches on top of Linus' tree, yes (as does everybody else). The
> previous Android kernel worked, the current Android kernel doesn't
> because of the patch in question.

Why don't you revert the patch in question in the Android kernel?

Thanks,
Miklos

