Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEE74BFD6
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGHWga (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 18:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHWg3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 18:36:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F771BB
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 15:36:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579de633419so38599037b3.3
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688855787; x=1691447787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM81ytcQAbvY1rpHjBMQS8O2py0eRXT0atPhQXgjA54=;
        b=Jg/dnV7WFpsjyNkLXFSJxvrYIbV5y67MbDJvmLrUOpsSl1LalBxzIJWHJrFfJSep+L
         kfZUq9UEYRlcCIgngXW54qsHIAzed494k22aoeQDCFY4ti+EvUlIb1BGsWldwxkxHI+Z
         T0O1rSIqZmQLXjw0ciOxBZnryw5KfH13QEmjeIwQpMHYqnDxWeFqRwsi0j+AkxhDt5Db
         PubOIUcLGyJx197rF2uJfbZ9Yjwt9Z7yJB0/yJIrVGW9K8Wcc2dwI+q9RUKuLpMhIfMV
         0O1pGeVudSwRXlE5gEeIlz84wqdwxg/t6UU9/nN9EWZGGgMME7nrCyrW+oIZPuLQydV4
         +a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688855787; x=1691447787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM81ytcQAbvY1rpHjBMQS8O2py0eRXT0atPhQXgjA54=;
        b=Skvk/pZ07aZg73q4r4p3JAdBC5H1mP8B1n3U9YQkIcJFzMaLpffXdxJ8kUmg+qPJKT
         0LZ6Ug5GCioXLfy1C1obw2u+bfpQlv/qda/AeFH8HpoWXD0et9x9grkK05ykaSmlR+Ej
         MmgB7J7XokXGg1+4iCG1GjWlZ6UIiQxK3AbhvHkytl3zT2oY4I1z84n85rxAcEl5IGoZ
         T/UIhvxMPqFNi/awCLuHO3KWfOCfk7YShN5eb0LGfZAZTmBruiMIeoIiW07Yl4H0Mutw
         wNEz1c3jxwVZEeTckiaAdErpbcrpVonMrmpE/5kELqrsDUjKI2oLUcrYTu32EuoUz1uE
         i9rw==
X-Gm-Message-State: ABy/qLY6vLpZmFdu2AbxG/jzymfRe/5H/28YTiCgxZFKVA3b3ZnAK8nA
        dTJV+6nXAqyd4LHO/YeqaIHTI53gJ4ohbZgQl4QbQg==
X-Google-Smtp-Source: APBJJlE9QX36fmJ1qqEKpR7UCT26mt3D5smIFQ/5C5ArBlb6gmqPuqIREas9VSsGWwWtUdtNurt1pOKbRKnjQvM5CU8=
X-Received: by 2002:a81:7741:0:b0:570:63d3:9685 with SMTP id
 s62-20020a817741000000b0057063d39685mr7997297ywc.25.1688855787129; Sat, 08
 Jul 2023 15:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com>
In-Reply-To: <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Jul 2023 15:36:15 -0700
Message-ID: <CAJuCfpHuFc1P=Wo6Oy0T0u-H1B_JsbRgqhVJxY7D64ZY1zh7Cg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 8, 2023 at 2:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 8 Jul 2023 at 12:12, Suren Baghdasaryan <surenb@google.com> wrote=
:
> >
> >  kernel/fork.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> I ended up editing your explanation a lot.
>
> I'm not convinced that the bug has much to do with the delayed tlb flushi=
ng.
>
> I think it's more fundamental than some tlb coherence issue: our VM
> copying simply expects to not have any unrelated concurrent page fault
> activity, and various random internal data structures simply rely on
> that.
>
> I made up an example that I'm not sure is relevant to any of the
> particular failures, but that I think is a non-TLB case: the parent
> 'vma->anon_vma' chain is copied by dup_mmap() in anon_vma_fork(), and
> it's possible that the parent vma didn't have any anon_vma associated
> with it at that point.
>
> But a concurrent page fault to the same vma - even *before* the page
> tables have been copied, and when the TLB is still entirely coherent -
> could then cause a anon_vma_prepare() on that parent vma, and
> associate one of the pages with that anon-vma.
>
> Then the page table copy happens, and that page gets marked read-only
> again, and is added to both the parent and the child vma's, but the
> child vma never got associated with the parents new anon_vma, because
> it didn't exist when anon_vma_fork() happened.
>
> Does this ever happen? I have no idea. But it would seem to be an
> example that really has nothing to do with any TLB state, and is just
> simply "we cannot handle concurrent page faults while we're busy
> copying the mm".
>
> Again - maybe I messed up, but it really feels like the missing
> vma_start_write() was more fundamental, and not some "TLB coherency"
> issue.

Sounds plausible. I'll try to use the reproducer to verify if that's
indeed happening here. It's likely there are multiple problematic
scenarios due to this missing lock though.
Thanks,
Suren.

>
>             Linus
