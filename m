Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393B74929D
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 02:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjGFAan (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 20:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGFAam (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 20:30:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513619AD
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 17:30:41 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bacf685150cso75772276.3
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688603441; x=1691195441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDNtb8VGNsWJMd94B1yvjb9baMo04ogysNrDvAUSWkk=;
        b=iPWV8L1jyHGFjgPG1e5DkKfQtY3x/CGt89+fMJ/bu3j/1cV87OyziFgyMwLBr32FHf
         eJAll/hxbFiau5yzj/0Xxv1XL4TrpqOek4oJPr+TWFqHfOyLAo4Ezfs6GXxb8GDL3nTT
         rraj5yM6rOwTWTUhoQ6EFOEPYXTzSqqYg6EqUuuh3uhasSCtxx6M7pB8nzeUxR9IEkai
         es1f/vIFQs89by4IxE+GjuqppQ5L53M6CJWf/ZaQdW0DW3FBm7fBzko1gzm6lkd3KqcN
         n0EHMop9F4f72B6zSYgFWgSG/QvKNC3uvRcsaZXjFndUnGrWi8n8AVKq5CKgDTEQR4px
         wpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603441; x=1691195441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDNtb8VGNsWJMd94B1yvjb9baMo04ogysNrDvAUSWkk=;
        b=D76ttW5ogVYzAfzVm/hD0E5Akf5ggQ/PwmQbYZRXqv3ft2KODt3kzOrvHSWeFNTz+A
         r+IzMBiPcm7TlXuXEe/t7RvL+gre38uSEh1/4Bl9GTAPaTzKA5+IqJGnCvuSCxpEgeqX
         +ESHLCV+43Zp0KSN41koumgx5hypPKegjtz14YXuTuFKGnd5YqUzr0f/yfT2lPsvtBeT
         IZx/RC8JcXrj+sj8N07qXZ+lCFG8ZaHiNQIFdjWqFxEF273Fpnhh4GNo/fbkAPgPhOy9
         saFfppF96t9R7jh1fayQE4Mt5mnqcYscba3qPw7J9MAqZYPmfeEucDSaO6bdRhnmTb2u
         AiFw==
X-Gm-Message-State: ABy/qLagWzAe63rFTrhTftJ4p2FFV0eN44ao7FcAeFVzvb2yADZBaV//
        BMZV7KBP4jHUfY12nFWILHp4gA92bGCtdJUnzY+AFg==
X-Google-Smtp-Source: APBJJlGTkJWTILVgZXDRlL1p0hLqObb6Qq5zIIPhh84UNi8OaQy1jTvMQiQf1KyO7Y1YLXWRj8pKQK81+RRrsDVVNdk=
X-Received: by 2002:a25:98c6:0:b0:c0b:7483:5cdb with SMTP id
 m6-20020a2598c6000000b00c0b74835cdbmr342231ybo.35.1688603440921; Wed, 05 Jul
 2023 17:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
 <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
In-Reply-To: <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 17:30:29 -0700
Message-ID: <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Wed, Jul 5, 2023 at 5:24=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 5 Jul 2023 13:33:26 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > I was hoping we could re-enable VMA locks in 6.4 once we get more
> > confirmations that the problem is gone. Is that not possible once the
> > BROKEN dependency is merged?
>
> I think "no".  By doing this we're effectively backporting a minor
> performance optimization, which isn't a thing we'd normally do.

In that case, maybe for 6.4 we send the fix and only disable it by
default without marking BROKEN? That way we still have a way to enable
it if desired?

>
