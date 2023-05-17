Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4707070EE
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjEQSiy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEQSic (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 14:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC55BAD
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684348666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLPdxGUTBg20W3CGR0dZEIDMHjZdIhg7vk/F4BU7czc=;
        b=bMS59LAzuzlucSrA0moUiopmjPtMcG/ZY4maHVzhsHojOLuuWbbPPgtLvxZDPfXYiJ+KS+
        cybRMXMhUkzdatxgS2yOpz0gPZsQQY9AzBzIZ5Os3SpHM/kQTprJtAbpQX5ARmub+fCtqu
        pwnWa3y640ywBpPaigTpCb9jor24m0A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-q1EIH9Q8NBycHFFzZ3EkLw-1; Wed, 17 May 2023 14:37:45 -0400
X-MC-Unique: q1EIH9Q8NBycHFFzZ3EkLw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f384644b08so2203721cf.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348663; x=1686940663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLPdxGUTBg20W3CGR0dZEIDMHjZdIhg7vk/F4BU7czc=;
        b=EzrBSWk3e/AvFSFatPSEmMFm2/gi1/nFAg4FfjDUbTTqhvWSys5l5teP+/qi4udZBH
         xi97Fj8tZtBXlwUttgQG9eftoDKKhpyx9FP2fgNTRU51jte2WHmnWcQFXpaRVGN4rss3
         qlBjIjjOaFUyqu8Cx41vv1tG/E3ZWJUzNnXJopY1kyw9OGnMecFd0sBHupQoK405GsY/
         myEsnQ9Oyga6Eaoxno4mFz0CwCoYM3uepl8KLitmt4yEIyQInuBGrQj/W8+ivNFhmjCI
         yFreYlOJN22Rn/hMc432ohDjxKEHVuEPLP+A+r1P0kF8VW0+6emV0SidjzVTzLsRzhWx
         DavA==
X-Gm-Message-State: AC+VfDzUuTIg2iaxH3N9iRWobss3o5QH8B8g8t4wxBf6x6mrjQVJcAoZ
        UKGzqmnOs8OHVdRsURXH5uujgWaLsLCoQj0pBmy0yH1dpGbU9LxAshuGuwgraxLD5RVsr8oXxzo
        FcJMkPmp82cibO8If
X-Received: by 2002:ac8:7f84:0:b0:3ef:59e8:511f with SMTP id z4-20020ac87f84000000b003ef59e8511fmr6977124qtj.0.1684348663610;
        Wed, 17 May 2023 11:37:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ax7reh1jO1s+mjgPfu0bUCpza/vvE+YPfmf6+fzSZu2+Qnp8AR1sn7TrrVkE7eL+VAWoRPg==
X-Received: by 2002:ac8:7f84:0:b0:3ef:59e8:511f with SMTP id z4-20020ac87f84000000b003ef59e8511fmr6977107qtj.0.1684348663308;
        Wed, 17 May 2023 11:37:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id l30-20020ac8459e000000b003e97fe68511sm7346475qtn.3.2023.05.17.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:37:42 -0700 (PDT)
Date:   Wed, 17 May 2023 14:37:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <ZGUe9f/niO03t7lC@x1n>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
 <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 17, 2023 at 06:20:55PM +0100, Lorenzo Stoakes wrote:
> On Wed, May 17, 2023 at 11:04:07AM -0400, Peter Xu wrote:
> > It seems vma merging with uffd paths is broken with either
> > register/unregister, where right now we can feed wrong parameters to
> > vma_merge() and it's found by recent patch which moved asserts upwards in
> > vma_merge() by Lorenzo Stoakes:
> >
> > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> >
> > The problem is in the current code base we didn't fixup "prev" for the case
> > where "start" address can be within the "prev" vma section.  In that case
> > we should have "prev" points to the current vma rather than the previous
> > one when feeding to vma_merge().
> 
> This doesn't seem quite correct, perhaps - "where start is contained within vma
> but not clamped to its start. We need to convert this into case 4 which permits
> subdivision of prev by assigning vma to prev. As we loop, each subsequent VMA
> will be clamped to the start."

I think it covers more than case 4 - it can also be case 0 where no merge
will happen?

> 
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
> > Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> > Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
> > Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > Cc: linux-stable <stable@vger.kernel.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/userfaultfd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 0fd96d6e39ce..17c8c345dac4 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >
> >  	vma_iter_set(&vmi, start);
> >  	prev = vma_prev(&vmi);
> > +	if (vma->vm_start < start)
> > +		prev = vma;
> >
> >  	ret = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> > @@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >
> >  	vma_iter_set(&vmi, start);
> >  	prev = vma_prev(&vmi);
> > +	if (vma->vm_start < start)
> > +		prev = vma;
> > +
> >  	ret = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> >  		cond_resched();
> > --
> > 2.39.1
> >
> 
> Other than that looks good:-
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks to both on the quick reviews!

-- 
Peter Xu

