Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B47D069F
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 04:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjJTCqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 22:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTCqu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 22:46:50 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9BD12D
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 19:46:49 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457c2d81f7fso137225137.3
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697770008; x=1698374808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H21+j0v93nfQK+3bR6L+ILZ02+G5DyoaZXykxHZCVw8=;
        b=RPH6D4MI5ZDzsaC0HgNe4c3OuaHsNXOzI8fHfruTPmMRpoIbb3T3OY4sqNXFicmvhX
         G5MBJjuUtVdzG4AuMSLsF9I60xjhBdTftl9IFV8WxZs1xO91N+0AJTp0RDLNmJlKbybt
         O/Qg9iudWr6j3rt2DQsEOQBGCyt/heumR4M8VEQQvwyToK+EsE0GxRUXeHBLNY5iSkmb
         oyHJT9PG+RmfYZGG/f0sfFCCoieuifXo3oBLyba4fcc2trnhqRnD9AHEjxyF/CHvbEjr
         onGs6jFZ5/yNBLbsRh3Esg5ZYRAfKGfG/InD2UkJ8+hiQkFfJ9AW5juPZUEqydq870mi
         /bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697770008; x=1698374808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H21+j0v93nfQK+3bR6L+ILZ02+G5DyoaZXykxHZCVw8=;
        b=XaMDb5zeK5TX6NrCrcXrXx8guyt1q3YLAy+N1CAWGRsAInl7wWm/W2aHoNaoNrWDxj
         +JUmKyta0uYlaJIs2LMVapXmaJ92YN3rIH5K16taTEViOO6jxXQgZoN5Xpzv9PyqEogB
         AeBEU1LEfsgX4NE9wMxsVIemdR4nKtgkGVUPXyDSpM+7RCefZNl9itA9ryy9NsB0bMrJ
         yjt0m4HoWHL05Fw/Vg+diA8h8fScWLJbBH62QCuk3PhVe9PCNsEehPia9hKm3okgCeIq
         RmOzs98LwATVBnoWkN3igiL3CsWFogiMWa+FfUYGmtyU6ax74Z6Uko2SDDDRabdMygbJ
         KymQ==
X-Gm-Message-State: AOJu0YwfU1iBJHOiCC/nySh11TOaAqvSNsM1W1o5iriOdGiIS8OwAmC9
        Uf7pnD1gc6ZYwzbRmjBpB8FZ/3W5jjHjpmsGdfY=
X-Google-Smtp-Source: AGHT+IGDGPf+HHiC0TLTIvzkEctcC0ld1WiO5y6ncGryVs1GUknHRaTDBX2V+8dbw3oynvLWdfnzZ63nG1/3yJ2bmIw=
X-Received: by 2002:a05:6102:108a:b0:458:3715:9144 with SMTP id
 s10-20020a056102108a00b0045837159144mr793260vsr.19.1697770007985; Thu, 19 Oct
 2023 19:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <97397e8d-f447-4cf7-84a1-070989d0a7fd@amazon.com>
In-Reply-To: <97397e8d-f447-4cf7-84a1-070989d0a7fd@amazon.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Fri, 20 Oct 2023 11:46:36 +0900
Message-ID: <CAB=+i9SvjjUBUvPmQm_cEGo4OKXtkj72HnUXLhsGd4FTk4QzSw@mail.gmail.com>
Subject: Re: [6.1] Please apply cc6003916ed46d7a67d91ee32de0f9138047d55f
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 10:27=E2=80=AFAM Luiz Capitulino <luizcap@amazon.co=
m> wrote:
>
> Hi,
>
> As reported before[1], we found another regression in 6.1 when doing
> performance comparisons with 5.10. This one is caused by CONFIG_DEBUG_PRE=
EMPT
> being enabled by default by the following upstream commit if you have the
> right config dependencies enabled (commit is introduced in v5.16-rc1):
>
> """
> commit c597bfddc9e9e8a63817252b67c3ca0e544ace26
> Author: Frederic Weisbecker <frederic@kernel.org>
> Date: Tue Sep 14 12:31:34 2021 +0200
>
> sched: Provide Kconfig support for default dynamic preempt mode
> """
>
> We found up to 8% performance improvement with CONFIG_DEBUG_PREEMPT
> disabled in different perf benchmarks (including UnixBench process
> creation and redis). The root cause is explained in the commit log
> below which is merged in 6.3 and applies (almost) clealy on 6.1.59.

Oh, I should've sent it to the stable. Thanks for sending it!

Yes, DEBUG_PREEMPT was unintentionally enabled after the introduction
of PREEMPT_DYNAMIC. It was already enabled by default for PREEMPTION=3Dy ke=
rnels
but PREEMPT_DYNAMIC always enables PREEMPT_BUILD (and hence PREEMPTION)
so distros that were using PREEMPT_VOLUNTARY are silently affected by that.

It looks appropriate to be backported to the stable tree (to me).
Hmm but I think it should be backported to 5.15 too?

> """
> commit cc6003916ed46d7a67d91ee32de0f9138047d55f
> Author: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Date:   Sat Jan 21 12:39:42 2023 +0900
>
>      lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default
>
>      In workloads where this_cpu operations are frequently performed,
>      enabling DEBUG_PREEMPT may result in significant increase in
>      runtime overhead due to frequent invocation of
>      __this_cpu_preempt_check() function.
>
>      This can be demonstrated through benchmarks such as hackbench where =
this
>      configuration results in a 10% reduction in performance, primarily d=
ue to
>      the added overhead within memcg charging path.
> """
>
> [1] https://lore.kernel.org/stable/010edf5a-453d-4c98-9c07-12e75d3f983c@a=
mazon.com/
