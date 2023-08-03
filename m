Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6376F161
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjHCSEP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHCSDe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 14:03:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7049D3
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 11:02:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so2191866e87.0
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691085728; x=1691690528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DvzNefb/LLJHkcM92Xy5CmVgSgsFXUiX9UPGxAI7fs=;
        b=BbCUOyD9207CdZ4NVHPzWxLtH+xHiEGG/J61pIlnagBnZOe4djYIGS8Ke58bKdZorh
         W6sCkrjJvfNCQmWXjCiv75uIP5ug0E6ZZj3z8JhdbLS/tlI6eYwyxte3Z87HmThKixtj
         vEKjfATD2hNIP5SjUpLqNexrrZltg6OJLRwbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085728; x=1691690528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DvzNefb/LLJHkcM92Xy5CmVgSgsFXUiX9UPGxAI7fs=;
        b=QqA8hMxLF1s0EoVKawdm6jawhLTXL4ICF6XGauZ4ld54SgmmsVnvcvTwcOVzRd0Lu/
         1c8EYpPvRJvc7ld9VmV/OkYKilY9nQblk1PCVM/XseNv5cwY8F4miVghzLyVqyjCqSEU
         h/Ck4pJu0LsWiwUeRc/+pJnw839oTwLpOgAWbPBpyzhp4OeBB85xlmbXsCHzg8niiJn9
         DdTm3bjeb4dR/Im7sk1s0Kz/bRl1xWHvAh7mxCJr0gYVbMe5c4Sr6+GmmuK8p8AG/6ZA
         SsOTFB4xbleIhtoNyefyItEbvior2CjZugWMHec/c+Ex27boNDWGh3xXHQBZyL9hHgta
         M1mQ==
X-Gm-Message-State: ABy/qLZvrcu39pDFhXytdKbdtWus6QUfV8xSmxTl9ZDfwtVZpXnYwigj
        r/bcL+MqXQBo/8XIPLbdorDxZc7pMZU9+I3lHIlNEEuB
X-Google-Smtp-Source: APBJJlEUmidhTip+8TJN2v4QR32zlf3S0ykS7XZtN/ggoBcuw3B58g4d31f9DU+s4FsfLT2Rc68jDg==
X-Received: by 2002:a05:6512:5cd:b0:4fb:9a1e:125c with SMTP id o13-20020a05651205cd00b004fb9a1e125cmr6747273lfo.45.1691085728603;
        Thu, 03 Aug 2023 11:02:08 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z19-20020a19f713000000b004fddaddeb63sm48332lfe.137.2023.08.03.11.02.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 11:02:08 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso2172811e87.1
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 11:02:08 -0700 (PDT)
X-Received: by 2002:a19:384d:0:b0:4fe:d0f:b4f7 with SMTP id
 d13-20020a19384d000000b004fe0d0fb4f7mr7004017lfj.65.1691085727752; Thu, 03
 Aug 2023 11:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com> <20230803172652.2849981-6-surenb@google.com>
In-Reply-To: <20230803172652.2849981-6-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Aug 2023 11:01:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
Message-ID: <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm: always lock new vma before inserting into vma tree
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 3 Aug 2023 at 10:27, Suren Baghdasaryan <surenb@google.com> wrote:
>
> While it's not strictly necessary to lock a newly created vma before
> adding it into the vma tree (as long as no further changes are performed
> to it), it seems like a good policy to lock it and prevent accidental
> changes after it becomes visible to the page faults. Lock the vma before
> adding it into the vma tree.

So my main reaction here is that I started to wonder about the vma allocation.

Why doesn't vma_init() do something like

        mmap_assert_write_locked(mm);
        vma->vm_lock_seq = mm->mm_lock_seq;

and instead we seem to expect vma_lock_alloc() to do this (and do it
very badly indeed).

Strange.

Anyway, this observation was just a reaction to that "not strictly
necessary to lock a newly created vma" part of the commentary. I feel
like we could/should just make sure that all newly created vma's are
always simply created write-locked.

                Linus
