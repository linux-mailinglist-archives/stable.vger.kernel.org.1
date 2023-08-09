Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8B776349
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHIPF4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjHIPF4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 11:05:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A187B3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 08:05:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5236c9ff275so614735a12.1
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691593554; x=1692198354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNfy891wWQJn9GGaD6lb4vpiDtiobMWaR2UsMEivbwk=;
        b=F0JapzA4Vi9mJy4NRwWsAHDugEqxju565TgTe91RCVzWfxEK4zaUiw+PeaO+Cf+MGb
         2MYvnDPz86UyKxutV25GqOcjXrYiHTASwOdBAOcj1c+kpppwC/zhdHkoEqYJmKybkMbp
         DoUc9NyMYujogrq9if20PNFIPdX5d8q7MR+Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593554; x=1692198354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNfy891wWQJn9GGaD6lb4vpiDtiobMWaR2UsMEivbwk=;
        b=b6UcKkHJFF+gccTZxv0gTtX7WtXXtuQ/DJnpMYjKl8WmeoWU+yN/VW+1AzuMf3cXQb
         OJwXafBGx/Kk1pmeoGluxRHFdsPXdJpFOGFHLUQCnyqW9Hn8xQvoVwmWQNJsrndMf5ny
         Z76KkLSWQuh5j+wioADkwTk3ah/+aPPqR0HQg7X8p5AusCQXt6kgjQ8oBX8yMw80Ywrw
         T1RsZFatzxtr3p3Y+PYU3FFwQAb+BeHpLdkSHbV8qzb2BXOxa/uAAc43tY22ZrFxtjC3
         UK7yQBmGzdY/g1fpMeuAfCEKife7QsnWpyTjQTKR9GNJjaVVwFuzkiEoxlnwPshJvSdb
         NeZg==
X-Gm-Message-State: AOJu0YwWtFkT9JaOh6H9cMLKMMKmFpROjJcUS9lxnnHbru9rJMSM4o8e
        XEYLZFRU/syK/bp7gxvRh+lokuDlZ0r/Np/w3HXgp3L2
X-Google-Smtp-Source: AGHT+IEqbCZkKMyElfFCNQx8MGh8gb6+hfXddX0CNuzjonuDqd2HMaU1uwFHzbheq9rEwd3N4EOTyA==
X-Received: by 2002:aa7:c743:0:b0:522:bbc1:a343 with SMTP id c3-20020aa7c743000000b00522bbc1a343mr2257270eds.6.1691593553964;
        Wed, 09 Aug 2023 08:05:53 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id u26-20020a05640207da00b005233fb98170sm3119984edy.47.2023.08.09.08.05.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:05:53 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99bcc0adab4so997709666b.2
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 08:05:53 -0700 (PDT)
X-Received: by 2002:a17:906:5382:b0:993:eef2:5d61 with SMTP id
 g2-20020a170906538200b00993eef25d61mr2523827ejo.27.1691593552995; Wed, 09 Aug
 2023 08:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 08:05:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com>
Message-ID: <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix access_remote_vm() regression on tagged addresses
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christina Schimpe <christina.schimpe@intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 9 Aug 2023 at 07:46, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> mem_rw() of procfs uses access_remote_vm() to get data from the target
> process. It worked fine until recent changes in __access_remote_vm()
> that now checks if there's VMA at target address using raw address.
>
> Untag the address before looking up the VMA.

Interesting that it took this long to notice.

Not surprising considering that LAM isn't actually available, but I'd
have expected the arm people to notice more. Yes, I have (and test) my
arm64 laptop, but I obviously don't do user space debugging on it.
Apparently others don't either.

Or maybe TBI is used a lot less than I thought.

Anyway, obviously applied,

            Linus
