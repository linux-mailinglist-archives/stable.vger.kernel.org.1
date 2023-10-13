Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AF7C8BDE
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjJMQ64 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjJMQ6z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 12:58:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C694FA9
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 09:58:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4195fe5cf73so5211cf.1
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697216333; x=1697821133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/RJ3K2u2/0kEbjKg5ncvwK22eF90W+UiIC6POGZyhw=;
        b=Pn0bTeOaW7xBlrAlaqf6JSZcPwOO0McEBB6qG2VRP215t5WknzorgIbskh2sZIToed
         4/VVrUQ08XLhooufRvG+VPoHHWeNoUTMwukP+Lclye0r9jJv6n9WE+vz/Lp7aV639dJf
         qcCNgX4Crr4TeV2E41ocurLsXV11AkiSkQ1pEMVY17SHqKirsXejCoVPHz4bnYLYZNF+
         w+p3/JdArUCAEy14aVbObn4rj0vgRJ2COGKm4aI8xgY2wkhs/3zm5SXdh2A0kST43XpX
         QWayt3nkAM3B2Pmyhh+8zGZPog5VZ8edjiNWdEakBdH5Xz4j9oSa0dfGevF2MuTZugq/
         vIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697216333; x=1697821133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/RJ3K2u2/0kEbjKg5ncvwK22eF90W+UiIC6POGZyhw=;
        b=Y+QYfM+QKpzmp0kYQu/NbtRmphnpsLtjj4woopKBASBNJmCNm2w+NjFInox4VnMf+3
         wmG37I2Jj/GO+1eQ7I8jflkMdFb+Iu834cXvYkfo0AIB6+0DOm0hmK+dtSk0bJkr1kQB
         zpTSqGEeX9dup34XK8UHJ+5Nk0qo0ZGLwfdvNY9bI7x13vy947BYWBSMPxy3kda75/bq
         QDdIikQKeERYL/+U9s3lqfGuUCzXgfebfxiE0oIBnSHc7TJkBT0ldRWtEMyROjrMeP8H
         1r2NJtOzFmsgeoTqKbkW3Ouu4nBQ6DV3uZnfDiad+6bYtpfRhSirYxb3ItVDvQ12yx5c
         TOtQ==
X-Gm-Message-State: AOJu0YyRZBs1WCXV060d4quhdnBCpi71cnpTR5P6iTtK34kZFsuf3kEJ
        yVjfHUtWRsWwqXfglr2v0FZpVByXl0mdpz4HfRVBU5N3kAZrs4UOPvM=
X-Google-Smtp-Source: AGHT+IFAW7Bczz5NDXvkJQcCZ4+FX6sRtvEd1YQB7iwOw42rTvoGYUoJYhMIfbq6RZe+s+zoMym4uQ/SJA2ukWLhrQU=
X-Received: by 2002:ac8:5bd6:0:b0:418:fb5:83d9 with SMTP id
 b22-20020ac85bd6000000b004180fb583d9mr224253qtb.19.1697216332767; Fri, 13 Oct
 2023 09:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231012235524.2741092-1-prohr@google.com> <20231012235524.2741092-3-prohr@google.com>
 <42778c9a-d487-f1a1-ae70-70a9f69c3b82@kernel.org>
In-Reply-To: <42778c9a-d487-f1a1-ae70-70a9f69c3b82@kernel.org>
From:   Patrick Rohr <prohr@google.com>
Date:   Fri, 13 Oct 2023 09:58:36 -0700
Message-ID: <CANLD9C2Xfvdzh+UOkOW09TvHeQiQMnrtaN9jVGQg_VG4a=R0hA@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
To:     David Ahern <dsahern@kernel.org>
Cc:     stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 9:21=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 10/12/23 5:55 PM, Patrick Rohr wrote:
> > commit 5027d54a9c30bc7ec808360378e2b4753f053f25 upstream.
> >
> > (Backported without unnecessary UAPI portion.)
> >
>
> no such thing as "unnecessary UAPI". If the original patch has a uapi,
> the backport to stable should have it too.
>

Thanks for the guidance, David. I will follow up with a v2.
