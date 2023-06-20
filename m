Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1D737353
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjFTRzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFTRzp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 13:55:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64332173F
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 10:55:41 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5703cb4bcb4so45539197b3.3
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687283740; x=1689875740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNKXcZ39Z10NVBkiTIhQmIoTjYz8PY/jDnJTeB9TmWc=;
        b=UFHcVNRgkeY635daGhoi/fIQLSvF6t6kSDruzQUr6UZvI1enwmwkKlT4X+XSSqYI13
         JYV+8g2dudsKX/RZ0x+TweL08U4d1TiqHhVJbY4N4t996nceoVzkw3MBfKL7JvmuXdVc
         jV02HfWoztqcCu7rAv1mOym4MgDqC6tnlrsQEqWAUcvevZOyP/8STcyUn/nA4Cz377Qg
         tF3v8LCK+ihuPIFFJJxJTEjxK57FfZPl6vqsi2wGeG+FzRGy8zvx87yYr2B0jYlqeUL4
         PiuA4UBhyBVBx6564O3T3tfiWATuPqvVeoFXJ/NSAy4IyAX45q2aWw2kMxPooKB7Wrvs
         oOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283740; x=1689875740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNKXcZ39Z10NVBkiTIhQmIoTjYz8PY/jDnJTeB9TmWc=;
        b=GOw7D445udXcoMxEWlV8RbA3ZJHbB3BWn2YMzEw1LjcyspDKj8Atqwbiu62pdbt9nH
         uTHpavK6g0Qef/S8OUrvYHd/+X4rrHO3zPK/EA9a+9Kmdf8C9pMLktlbixTVRAAzKGlf
         +kKt/iCJlUcW1SRfDGt8Yhd8zr/olNOunzG5/yModhrGvgXzGVlC2CVnYWaBgdI5lAlo
         mjxvgdu9OxLVK7Jc3AM3QwQBUf1ex7urfeY0XBkxx0qVjCRzu7ZmWyx2xYUZi6KQ4jkB
         sN3seDsuQRYcHqfoKqHQLWEzJj/eLuSyZMK2Txt7YUTBM7JRiDjgrxYS9STiwe2sUzzb
         SOFw==
X-Gm-Message-State: AC+VfDwBvxsG1UIGSM4qCrxh+QJ3SXqS5C6VecmygBwm1FmJOqK6NP4f
        2+RWWIgV51k7erBKXQraaO2ompaq3XgYpPypPrVBfw==
X-Google-Smtp-Source: ACHHUZ4kFhYGq1McBHCrKGBedUf2xwnSf+RXgEGL3EzRFdNA+PwrVJgxb55iiZYNwNR7iwv3SzyxB835GCQeBrcfSkg=
X-Received: by 2002:a25:2e0c:0:b0:bc3:843a:953a with SMTP id
 u12-20020a252e0c000000b00bc3843a953amr8727613ybu.18.1687283740311; Tue, 20
 Jun 2023 10:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230614013548.1382385-1-surenb@google.com> <20230614013548.1382385-3-surenb@google.com>
 <2023061925-overact-flakily-9830@gregkh>
In-Reply-To: <2023061925-overact-flakily-9830@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 20 Jun 2023 10:55:29 -0700
Message-ID: <CAJuCfpHWpmLGjBTRAAtSiPSo=q273j7qRGXCt+bZ2qyHOP9x8A@mail.gmail.com>
Subject: Re: [RESEND 1/1] linux-6.1/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jun 18, 2023 at 11:21=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Jun 13, 2023 at 06:35:47PM -0700, Suren Baghdasaryan wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>
> That's not the author of this commit, where did it come from?

True, that's the author of the backport. The commit author is Ziwei
Dai <ziwei.dai@unisoc.com>

>
> confused,
>
> greg k-h
