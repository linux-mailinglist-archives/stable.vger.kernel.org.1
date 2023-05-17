Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695C70732A
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEQUh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjEQUhz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 16:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F2C0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684355831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qw24q3koBCTGhsyK/A9UxnFtqmKPlaJqCG9HtlLgPFU=;
        b=IVOiLRQaRNb7Pq6JUuLR4hrmtaCm/hnihRAMsAw+J4VG2z0u/ZdL6G8LRBWfz/NLEMrENQ
        y01YgBJkNBM98ly3KeaBBqHxwDakKQpBgkYV4ly0h4bHY+Vf74nX5SGea352Egmstd7Wah
        HZFJjRQhz3ly3OHaci6m8dJLbZQyPvo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-lmm5lwbBNoizjrelUOVg6Q-1; Wed, 17 May 2023 16:37:10 -0400
X-MC-Unique: lmm5lwbBNoizjrelUOVg6Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61b5f341341so1581636d6.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 13:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355830; x=1686947830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw24q3koBCTGhsyK/A9UxnFtqmKPlaJqCG9HtlLgPFU=;
        b=YqppN4v41gQ8qUs46UZQvedSA66HAymdpaXKfTNXBcG5CjPHc4Ad5/2l43E78NnmNf
         +z2FFAxd8GqmSlYtHG5zp4RcCwn6mE8c3AGsHCY5Pd0HZDSod0IkkzsU1opzcgtFpRcP
         xwPGsZ+kI0m9az0Jawvsb1hyphAbhM/SrWpO4k1tQQ2jKbAwZ022qhll78+HjZ2rdQmR
         IuuztDRbjph1p5WxfqUgXogL67UiKU7NnnB+C3o2RZoiIYsVPZ9qv2FThJWk5Az0BGhY
         xEjxX3emxlnk+DX/oyKH+1R4R7h2COxxwQ4qlUMQeozzCiwYWtQA1rkyvezwlO1Eib4C
         6q3A==
X-Gm-Message-State: AC+VfDxQoKSfKcMSKfqnZrHCd4uGx9aubISmh/x9BMWBp8Tegn9Ih4jk
        W3JCzLbP6hE4AS9ASOz8Tz1mZdgSgF4DnS6hngyzOz6KppoVIA4SxVMG2o11Px+YUYfp/684SyZ
        Cqxg0+xwCyTZjddgt
X-Received: by 2002:a05:6214:cc8:b0:61b:6b8e:16e0 with SMTP id 8-20020a0562140cc800b0061b6b8e16e0mr7457825qvx.1.1684355830160;
        Wed, 17 May 2023 13:37:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SyFUd8Lqs6mmufSEkv8XLzqqsya5htZAu67CjkT4Q/8mI3cV6V51PsNc5ery1Y55b0PO2IA==
X-Received: by 2002:a05:6214:cc8:b0:61b:6b8e:16e0 with SMTP id 8-20020a0562140cc800b0061b6b8e16e0mr7457800qvx.1.1684355829864;
        Wed, 17 May 2023 13:37:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id p19-20020a0cf553000000b00621430707f7sm1585qvm.83.2023.05.17.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:37:09 -0700 (PDT)
Date:   Wed, 17 May 2023 16:37:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <ZGU69JbI9J5LV272@x1n>
References: <20230517190916.3429499-1-peterx@redhat.com>
 <20230517190916.3429499-2-peterx@redhat.com>
 <20230517132321.2466ef1ccde9e8d05436e3f2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517132321.2466ef1ccde9e8d05436e3f2@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 17, 2023 at 01:23:21PM -0700, Andrew Morton wrote:
> On Wed, 17 May 2023 15:09:15 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > It seems vma merging with uffd paths is broken with either
> > register/unregister, where right now we can feed wrong parameters to
> > vma_merge() and it's found by recent patch which moved asserts upwards in
> > vma_merge() by Lorenzo Stoakes:
> > 
> > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > 
> > It's possible that "start" is contained within vma but not clamped to its
> > start.  We need to convert this into either "cannot merge" case or "can
> > merge" case 4 which permits subdivision of prev by assigning vma to
> > prev. As we loop, each subsequent VMA will be clamped to the start.
> > 
> > This patch will eliminate the report and make sure vma_merge() calls will
> > become legal again.
> > 
> > One thing to mention is that the "Fixes: 29417d292bd0" below is there only
> > to help explain where the warning can start to trigger, the real commit to
> > fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
> > issue, but unfortunately we may want to keep it in Fixes too just to ease
> > kernel backporters for easier tracking.
> > 
> > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> > Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
> 
> I don't know how -stable maintainers are to handle more than a single
> Fixes: target, given that Fixes: means "kernels which have that patch
> need this one".  Can we narrow this down to a single commit for this
> purpose?

Please just keep:

Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")

I just noticed 29417d292bd0 is only in rc1 so no backport needed anyway.
We definitely need 69dbe6daf104 marked Fixes for backport till 6.1+.

Thanks,

-- 
Peter Xu

