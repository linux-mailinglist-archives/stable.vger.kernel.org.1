Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206C70715C
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjEQSze (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEQSzd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 14:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A583D8
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684349683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkG2ZLXHuugF8E/05ptWNFpBJazv1H3EjWyKDlq3jVU=;
        b=FvVHQ2E7OCDYppfvzL7/yNxiUBJakWX+RUnrX70bUf3XBiKEnBj5s3cmMOaa9ct3GnjcpZ
        3RTDwy1eYGhqkqvpuRURMv5XlPCP2/wiwxTMohU9ookjzhnG/YbujfP5e44qf91LKNhxVp
        RIk2Qkja0QLftYBqkclaBI7R9/5140Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--9duz45ZOo2Q9RDtp4CuPw-1; Wed, 17 May 2023 14:54:41 -0400
X-MC-Unique: -9duz45ZOo2Q9RDtp4CuPw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5ea572ef499so2090076d6.1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 11:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349681; x=1686941681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkG2ZLXHuugF8E/05ptWNFpBJazv1H3EjWyKDlq3jVU=;
        b=aH+/7u1LDC+ZjEIZpWG7F6GYV+L/vEINFq98Tj8LTKMj7iyQofW4c2Vgp59yGxNtRb
         Y9JMMThZMuZymzdI5qT7DJlcpY8XfovBnTqVf9wXnzalURWA9KVkA0CExMpiZa+jt8ph
         QACh58YIhVG8WYHhGiHhYDCu17vRK42RrLjCjqcv7WDTFr1uWeWzRHJpjc+5ElMpf3GO
         jEHa6IM1KmwLZStu2J+/L239bFpHTfzyqRLvXg6st72beW0XNh1pU6XdT7dxq595TEjh
         FZbRd1K55lzlZ5R5AMIgHnyqiMR8jK9UNyGJspXrfUcIEZgwEPr3kCsOHLcJ5rOTm9qw
         /SBg==
X-Gm-Message-State: AC+VfDzfL0MMpbbrnwXbBVU2bPtbkFgoagJHbeImZxfFYRRZxzxAWgxk
        BFvvLwRPBVuPFi0ayj8Bq0GvCrAKjg7L/PX4vOwPOm0tfIbrxlmrVs2j157OGP4e+VPfFqa/lkT
        7c/dLVxbrx7g86FCU
X-Received: by 2002:a05:6214:e6d:b0:5ac:325c:a28f with SMTP id jz13-20020a0562140e6d00b005ac325ca28fmr6964963qvb.0.1684349681332;
        Wed, 17 May 2023 11:54:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EypXB7UqbFiDuTkKMybkoiPJcibWVXF0N5XugzSsxuyTZrUjrBZtLZWsVQH9jV9pw+C/W2A==
X-Received: by 2002:a05:6214:e6d:b0:5ac:325c:a28f with SMTP id jz13-20020a0562140e6d00b005ac325ca28fmr6964932qvb.0.1684349681041;
        Wed, 17 May 2023 11:54:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id j7-20020a0cf507000000b006211c23abbasm6531041qvm.26.2023.05.17.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:54:40 -0700 (PDT)
Date:   Wed, 17 May 2023 14:54:39 -0400
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
Message-ID: <ZGUi79uCvmDLuh0i@x1n>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
 <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
 <ZGUe9f/niO03t7lC@x1n>
 <99566f92-9b97-4b2b-b75b-860532e851fd@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99566f92-9b97-4b2b-b75b-860532e851fd@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 17, 2023 at 07:40:59PM +0100, Lorenzo Stoakes wrote:
> On Wed, May 17, 2023 at 02:37:41PM -0400, Peter Xu wrote:
> > On Wed, May 17, 2023 at 06:20:55PM +0100, Lorenzo Stoakes wrote:
> > > On Wed, May 17, 2023 at 11:04:07AM -0400, Peter Xu wrote:
> > > > It seems vma merging with uffd paths is broken with either
> > > > register/unregister, where right now we can feed wrong parameters to
> > > > vma_merge() and it's found by recent patch which moved asserts upwards in
> > > > vma_merge() by Lorenzo Stoakes:
> > > >
> > > > https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> > > >
> > > > The problem is in the current code base we didn't fixup "prev" for the case
> > > > where "start" address can be within the "prev" vma section.  In that case
> > > > we should have "prev" points to the current vma rather than the previous
> > > > one when feeding to vma_merge().
> > >
> > > This doesn't seem quite correct, perhaps - "where start is contained within vma
> > > but not clamped to its start. We need to convert this into case 4 which permits
> > > subdivision of prev by assigning vma to prev. As we loop, each subsequent VMA
> > > will be clamped to the start."
> >
> > I think it covers more than case 4 - it can also be case 0 where no merge
> > will happen?
> 
> Ugh please let's not call a case that doesn't merge by a number :P but sure of
> course it might also not merge.

To me the original paragraph was still fine. But if you prefer your version
(which I'm perfectly fine either way if you'd like to spell out what cases
it'll trigger), it'll be:

  It's possible that "start" is contained within vma but not clamped to its
  start.  We need to convert this into either "cannot merge" case or "can
  merge" case 4 which permits subdivision of prev by assigning vma to
  prev. As we loop, each subsequent VMA will be clamped to the start.

Does that look good to you?

Thanks,

-- 
Peter Xu

