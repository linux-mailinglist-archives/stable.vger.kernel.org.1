Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42E7DA05F
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjJ0S1D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjJ0S0x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 14:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B2D6C
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698431029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1GFRFSXrJZnqwU7bWQb2Id5cyqADGdT0GyV9+GmOAk=;
        b=hmCpIiJmxOdLA6LPh8hkpLWRHEpLbQdEzACS93bAI/3TOOZCWiCJT+5fSU5W/SVcZyuubo
        6/kM5lzTdseJDpkuIs81yxKpiphyYy4X9vwRzVNT2hVDZbt5HNxdu2c6Ep5JmvvOgqTG53
        7OLWVTzXx2qD7l7s2aEg4tjrTHgg85Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-TUpXmhVuPKqmZda5593znw-1; Fri, 27 Oct 2023 14:23:47 -0400
X-MC-Unique: TUpXmhVuPKqmZda5593znw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27da957c9a3so2180747a91.2
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 11:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698431026; x=1699035826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1GFRFSXrJZnqwU7bWQb2Id5cyqADGdT0GyV9+GmOAk=;
        b=eMiLuSXaCOLGpyZAsug9kriRGJqR9vLFlOFpM5y/f0gOv89M3tuDu0fX4bJ2VC2uvQ
         3kVUTbboKNtLdsyimBlDHH14+nVEHm/3hoyyXCIB+gh4x8TUIDCAk+3ydmgpi7P/h1ey
         XgkNF1iAFH4FrfoKtWxhMJ8QT/w+Xs6g2zd4wIMx5BTHP8MCzOLTfPgiRX9LvMeHA3xs
         CTxp8CTsJtqGsUPtU3cL7vo5RROSv0bD9bQcQB8Moklo2Vsj7n2PMmdk0ui1Pgj5Ezj+
         TainTjYFBKR5ENdmxHASH5ChWQlG0zLFPha9rnX8rk74qkj1P3Si0MoOgVY/YPScDzCQ
         yyeA==
X-Gm-Message-State: AOJu0Yxty8DogBUQAyAwuRES5V8OqyKgogeRdn6DnJrMN8Y4YigkLHp+
        wgSvbFsVD8kCwrxXAdLKjxM8S2pj/xFWPQvb2iZts21uFnkYsZCg58zZMtT7VfRS/X9w8KMdb+6
        Q8x1CXp19tiEWrOh9Bt0B5tIpFVe4CXn0
X-Received: by 2002:a17:90b:3644:b0:280:1508:fbbb with SMTP id nh4-20020a17090b364400b002801508fbbbmr1868680pjb.23.1698431026287;
        Fri, 27 Oct 2023 11:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG50FlCwAd54tu9bXNQ2lOanyMl7ApDN5fYTheNDi/qcr0Q8FcDhYQnCfYRD6hGz6A5X4B1bh6MAyLWI8uU85M=
X-Received: by 2002:a17:90b:3644:b0:280:1508:fbbb with SMTP id
 nh4-20020a17090b364400b002801508fbbbmr1868659pjb.23.1698431026001; Fri, 27
 Oct 2023 11:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com> <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com> <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info> <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh> <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh> <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <2023102757-cornflake-pry-e788@gregkh>
In-Reply-To: <2023102757-cornflake-pry-e788@gregkh>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 27 Oct 2023 20:23:34 +0200
Message-ID: <CAOssrKc6zpsTox58CMvWHAU7EhM1REEk6J9SbV5DaBzurpmr5Q@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 3:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> So because Android userspace is sending a flag value that is not in the
> upstream table, this breakage is ok?  Or do you mean something else, I'm
> getting confused.

From my POV the regression in the Android kernel was due to the
Android patch that added those flags.

Not all flags are equal, some applications use a specific set of flags
and another set of applications use another set.  Non-Android apps
won't use the flag that Android added, for obvious reasons.

I still don't see why we'd need to revert this patch due to
regressions in Android.  Maybe I'm really dumb, but I just don't get
it.

Thanks,
Miklos

