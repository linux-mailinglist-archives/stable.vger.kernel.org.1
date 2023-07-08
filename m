Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC774BF3F
	for <lists+stable@lfdr.de>; Sat,  8 Jul 2023 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGHVSw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHVSv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 17:18:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F9194
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 14:18:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so5021227e87.2
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688851127; x=1691443127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYkpMcCqLkVQ1Acc1vLb6z5Gk8ZLjHpR5RYSSOrvZGs=;
        b=YAZ3dlkCU3GzUmIGGNKk2biNpVrzxYfNhEwwjE+bOmS1sd5gMPaIuug3Ccj+d4mvYr
         xT04g5kyiIOLFqSn36I6zopXsEEUftopeaNUq/db2wt8dizzZU8ZY7298CiL80rtqBde
         +616QoPEosxnj0DGBJdrYAbfafgyzgP9XfXl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688851127; x=1691443127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYkpMcCqLkVQ1Acc1vLb6z5Gk8ZLjHpR5RYSSOrvZGs=;
        b=lHWsflKjfjgFp2T1+DldCiaRBIU4YltwkuRg4jXyq/O4wEAtU6psw0vBnVtqxmfk5D
         x4o2EaLk9xEySSma+DZIUcunuEOSiBMuepr83UhFaVcz+OAKjiPrqbh1MwuQ+5+LQqyd
         hZdAEtSfqYH94r5cqa/AksCNkTLuYOdyX9uUeTQkFH/1uGOI/+hMgm0YzKjuvBxR0dQZ
         PzANIaLmU3gClK3hkcv3SezPus4gAdEfRP2Ud2tL4NTJfOWRq7k17uI5ftv5JQ/9quyp
         pfJBM6cCd7XBBY50xysSlUqFvth3VSWtlpTk8US+QHbVOQrI0KqzE7DKjOl6HHrn3RWz
         sEAg==
X-Gm-Message-State: ABy/qLa1PAGYfvmoudNqOkYQgFsmAHKnufIxNDlYDS2hrXzwWo/2rOho
        2Rdy3L878DB2z+sNUYWODu2wOD8Q6b6Mjb4U/FE9fEs8
X-Google-Smtp-Source: APBJJlEtot4LefqXKqPJzQlTjWU06P/faH0y7CZLahVn+uwdF2oqrm09EWboKZrKiDJug3HKAjxmhA==
X-Received: by 2002:a05:6512:e9c:b0:4f8:7325:bcd4 with SMTP id bi28-20020a0565120e9c00b004f87325bcd4mr7629860lfb.0.1688851127668;
        Sat, 08 Jul 2023 14:18:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n5-20020ac24905000000b004fb9d7b9922sm1129433lfi.144.2023.07.08.14.18.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 14:18:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so5041857e87.0
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 14:18:46 -0700 (PDT)
X-Received: by 2002:a19:670b:0:b0:4f8:742f:3bed with SMTP id
 b11-20020a19670b000000b004f8742f3bedmr6097080lfc.37.1688851126226; Sat, 08
 Jul 2023 14:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
In-Reply-To: <20230708191212.4147700-3-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 14:18:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com>
Message-ID: <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Suren Baghdasaryan <surenb@google.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 8 Jul 2023 at 12:12, Suren Baghdasaryan <surenb@google.com> wrote:
>
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)

I ended up editing your explanation a lot.

I'm not convinced that the bug has much to do with the delayed tlb flushing.

I think it's more fundamental than some tlb coherence issue: our VM
copying simply expects to not have any unrelated concurrent page fault
activity, and various random internal data structures simply rely on
that.

I made up an example that I'm not sure is relevant to any of the
particular failures, but that I think is a non-TLB case: the parent
'vma->anon_vma' chain is copied by dup_mmap() in anon_vma_fork(), and
it's possible that the parent vma didn't have any anon_vma associated
with it at that point.

But a concurrent page fault to the same vma - even *before* the page
tables have been copied, and when the TLB is still entirely coherent -
could then cause a anon_vma_prepare() on that parent vma, and
associate one of the pages with that anon-vma.

Then the page table copy happens, and that page gets marked read-only
again, and is added to both the parent and the child vma's, but the
child vma never got associated with the parents new anon_vma, because
it didn't exist when anon_vma_fork() happened.

Does this ever happen? I have no idea. But it would seem to be an
example that really has nothing to do with any TLB state, and is just
simply "we cannot handle concurrent page faults while we're busy
copying the mm".

Again - maybe I messed up, but it really feels like the missing
vma_start_write() was more fundamental, and not some "TLB coherency"
issue.

            Linus
