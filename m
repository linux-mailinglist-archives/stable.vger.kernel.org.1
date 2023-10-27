Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A67D99AF
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjJ0N0H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 09:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjJ0N0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 09:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E75CA
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698413118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1cvxdxPvtUX/vR/ZZ/ap3IrH5drcPkX5BNNFPbDVUM=;
        b=YcjXAuK8bmkZtbdmF1DkeKCGMWP5GVaZjjbCdT2uJ4lPonNsVqhKa9qFt8Li0KWWEqquk9
        +/VAqvNAKNrXgFU3HAdLcpo9gN+LGmWnMBLT/rnMsiCVFRrArWfU9P3JgbGEBABXBqW7fK
        8t1m6mqVMaiior/hqyOXyAeSUKp/YyI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-i1Upqig8NWWdH6JSAbwQnQ-1; Fri, 27 Oct 2023 09:25:11 -0400
X-MC-Unique: i1Upqig8NWWdH6JSAbwQnQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27d2a478b8fso1822434a91.3
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 06:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698413111; x=1699017911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1cvxdxPvtUX/vR/ZZ/ap3IrH5drcPkX5BNNFPbDVUM=;
        b=V+ZCkRN6atkFeCYSKI8+vdbOOIqA6FQxTEYts+WafBM1r84+mW7BH2M8UsaDAY5DdH
         iAcabtJPvtoYXm02SOGQQynJ8JICEU2Md4gxbNgtOELv/S5uJ/wxlchaB+S7qkd9fgxj
         IIXRnqdbVhiO3swSQZp+p8X+/BlcUci8NNDG8eAH/15Fr+rFnc0iAtRlE5GGG7TNV1tP
         MCTAMj6M2PQVVRe7h/bDerghW0q0Vx9k4JH+mX1p0BfFNWzmT/3fUOT0gkPO0Z0HhxFb
         Y1waS5gBalSjav+rO0RYsRGAl616u2VQSM15eacrnbJjvgGIpMeVuE2oIs9W3Cav/YAL
         xSyA==
X-Gm-Message-State: AOJu0YzJUF9zLj6I5XQJ9e+5vT1ekGcIe/8ykwz2EbCj+t+Rog0L4tdT
        0Arc9NdnZO62b7/EgNb1PF7K/XdWzPobFDzN2tIl8/CYDyW6SwlVeKQJnyd9DiCLfvuIB6byF2l
        +KhwcTN6WknAENFb9oCV8YZARsrw7gC1n
X-Received: by 2002:a17:90a:fd8e:b0:27f:f61c:327d with SMTP id cx14-20020a17090afd8e00b0027ff61c327dmr2409980pjb.0.1698413110815;
        Fri, 27 Oct 2023 06:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDTqUCN6moDjH/gfXnYBxMVSGumEFqX6K29llxBiu7RZwEpOowr388vuT/hj3g6JDGgaCJ9PcOQnv43Tmqtfs=
X-Received: by 2002:a17:90a:fd8e:b0:27f:f61c:327d with SMTP id
 cx14-20020a17090afd8e00b0027ff61c327dmr2409971pjb.0.1698413110598; Fri, 27
 Oct 2023 06:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com> <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
In-Reply-To: <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 15:24:59 +0200
Message-ID: <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
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
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 3:14=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> The patch in question has broken all users that use the higher flags
> and that don't use your version of libfuse, not just Android. You're
> filtering them out now when you didn't at the time that those
> ('official) high flags were added. There are a couple more high flags
> than just the one that Android added.

Okay.  Where are all those users?  Why haven't they reported this?

Thanks,
Miklos

