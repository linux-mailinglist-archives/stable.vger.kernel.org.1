Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED768748EE6
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjGEU0T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjGEU0R (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 16:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE71988
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688588727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASCe+ZaB9FC1F5583V60PJYWRONCOSusHLyER7UBBI0=;
        b=c3s4UeVyFT0dO3kvYpThVCkzi4zho3QPMH+ojDWDFzqkAnknP0NfGgQHDtPkZTdDk24tBY
        wgYYVcMKlvKFZct+P0+dbhy4uxaMPXUgrvH/u9KF5C1a5X0SKWfX32j3A92d8aHhz1LZ5f
        asF0mTG7WfSpedQpnbKilKtruCVjE6s=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-fgFvliIhPoSz1y1wk4NbkQ-1; Wed, 05 Jul 2023 16:25:26 -0400
X-MC-Unique: fgFvliIhPoSz1y1wk4NbkQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a36f2461c9so17642b6e.1
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 13:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688588724; x=1689193524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASCe+ZaB9FC1F5583V60PJYWRONCOSusHLyER7UBBI0=;
        b=IC+zTPup6OraQcsKsdGmxd34DCLpf2M3AzwZqLvY8+ylM9qTnA9xVFP+ZNK4X5fJzN
         0GvCQaGw8srkgtUu76jVa89CvjSh6B2oXS7cWDyuQRJLkQyfKJq2prhIdkRjf85UbL9R
         82yEfXaMlG+/LxG0dEpb8Hw2WF6a+MZH/kFSTUEHS9UmvKtxHwRvV8jFf/zUWMoa0DxG
         cSxf2zMW08/bq3rFKO/vSo7ni0D1oBgQrPn642gUEHL0dTc+zXc//UbNRgmunJJaB9qu
         jUZLu8crffYFQLbb8uC3/dWfsUp50eO7KosZJAD++tasfsGl+uzVUnuP7luKmLIo4AOw
         EQUQ==
X-Gm-Message-State: AC+VfDxGOcvrn/2FDS4moP9C0/T6Yc3jmt80ax9FJsFLs4f2/q3bmGYk
        WG+FUkdi10BbL//kDCNLrm46lTJ/z8ImAquukJNc18CfhUdGfVj7kjPKDcNhJ3nOfWS8UxVg+n2
        krVidNAwO6qnEMILx
X-Received: by 2002:aca:f255:0:b0:3a0:50bb:79cd with SMTP id q82-20020acaf255000000b003a050bb79cdmr10091343oih.0.1688588724348;
        Wed, 05 Jul 2023 13:25:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TeQjUMpes7R98hs70EQVxuwQH2R5xfd6xizcjOqRXdqx/KtKHmiXxiORnx30bvNz+aFCQjg==
X-Received: by 2002:aca:f255:0:b0:3a0:50bb:79cd with SMTP id q82-20020acaf255000000b003a050bb79cdmr10091318oih.0.1688588724031;
        Wed, 05 Jul 2023 13:25:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b00632266b569esm14014585qvh.87.2023.07.05.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:25:23 -0700 (PDT)
Date:   Wed, 5 Jul 2023 16:25:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
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
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
Message-ID: <ZKXRsQC8ufiebDGu@x1n>
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
 <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 05, 2023 at 10:22:27AM -0700, Suren Baghdasaryan wrote:
> On Wed, Jul 5, 2023 at 10:16 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > > A memory corruption was reported in [1] with bisection pointing to the
> > > patch [2] enabling per-VMA locks for x86.
> > > Disable per-VMA locks config to prevent this issue while the problem is
> > > being investigated. This is expected to be a temporary measure.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
> > > [2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com
> > >
> > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
> > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >   mm/Kconfig | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 09130434e30d..0abc6c71dd89 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
> > >          def_bool n
> > >
> > >   config PER_VMA_LOCK
> > > -     def_bool y
> > > +     bool "Enable per-vma locking during page fault handling."
> > >       depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> > > +     depends on BROKEN
> > >       help
> > >         Allow per-vma locking during page fault handling.
> > >
> > Do we have any testing results (that don't reveal other issues :) ) for
> > patch #1? Not sure if we really want to mark it broken if patch #1 fixes
> > the issue.
> 
> I tested the fix using the only reproducer provided in the reports
> plus kernel compilation and my fork stress test. All looked good and
> stable but I don't know if other reports had the same issue or
> something different.

The commit log seems slightly confusing.  It mostly says the bug was still
not solved, but I assume patch 1 is the current "fix", it's just not clear
whether there's any other potential issues?

According to the stable tree rules:

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.

I think it means vma lock will never be fixed in 6.4, and it can't (because
after this patch it'll be BROKEN, and this patch copies stable, and we
can't fix BROKEN things in stables).

Totally no problem I see, just to make sure this is what you wanted..

There'll still try to be a final fix, am I right?  As IIRC allowing page
faults during fork() is one of the major goals of vma lock.

Thanks,

-- 
Peter Xu

