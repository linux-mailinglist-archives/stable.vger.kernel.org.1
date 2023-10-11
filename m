Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7547C5EE6
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjJKVJK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJKVJJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 17:09:09 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF993
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 14:08:23 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7b3d33663so4095387b3.3
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 14:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058503; x=1697663303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vFhMHCh6uUl8avUdhvw8MzdlyCHTFfcctmbku9CIHU=;
        b=s2o4eQ/Iw4JdyeDJuDIT8cUhVB9dSGO7bYI3Pyv+b9pImJGEAJZz8KPc2PrkBMMyBG
         rtZDYDjAoZjF2e6btmW/uYtTzSHPpbKv930Bzd0bRyfUNr+ZoZek2tjOfvokXQl+oZZf
         BdyIGTxprX0f5iPBRy7pv8hvIFKI8UoW8CegirvkXc44mM3eVJDprkLfiNIwF2ySe5DJ
         Aq+3AEE9K8HRDemSNM3KEOW9PHpPLeBCYqp6wNIVPGC6LKlRVrWLtFs2XtPVCcQ4Se9G
         cfevP4jEel5lOZCJloidlWIVZo6QhAtfoWcst5apwMLwoAxG4GUDNW2/09k5f/crINFd
         UYeQ==
X-Gm-Message-State: AOJu0YxrAdRsVK1uRsDJj7Nsd/87pxCe9Lcn0qHVLAXLRT0+lfrivEoc
        JRtaO0QqKjlBNFBx0GPxQA91
X-Google-Smtp-Source: AGHT+IFqA6QGfUWZi1RXIloHbmN4XvJcpqvKaIcnLySXfbMdpQuScK+rDzGXX5QOE6SPYfejs9SWUg==
X-Received: by 2002:a25:aaad:0:b0:d9a:526a:2514 with SMTP id t42-20020a25aaad000000b00d9a526a2514mr6479268ybi.62.1697058502868;
        Wed, 11 Oct 2023 14:08:22 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d7-20020a0cb2c7000000b0064f5d70d072sm6049114qvf.37.2023.10.11.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:08:22 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:08:21 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Message-ID: <ZScOxR5p0Bhzy2Uk@redhat.com>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
 <ZScKlejOlxIXYmWI@redhat.com>
 <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11 2023 at  4:53P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/11/23 2:50 PM, Mike Snitzer wrote:
> > On Wed, Oct 11 2023 at  4:20P -0400,
> > Jens Axboe <axboe@kernel.dk> wrote:
> > 
> >> On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
> >>> Only call truncate_bdev_range() if the fallocate mode is
> >>> supported. This fixes a bug where data in the pagecache
> >>> could be invalidated if the fallocate() was called on the
> >>> block device with an invalid mode.
> >>
> >> Fix looks fine, but would be nicer if we didn't have to duplicate the
> >> truncate_bdev_range() in each switch clause. Can we check this upfront
> >> instead?
> > 
> > No, if you look at the function (rather than just the patch in
> > isolation) we need to make the call for each case rather than collapse
> > to a single call at the front (that's the reason for this fix, because
> > otherwise the default: error case will invalidate the page cache too).
> 
> Yes that part is clear, but it might look cleaner to check a valid mask
> first rather than have 3 duplicate calls.

OK.
 
> > Just so you're aware, I also had this feedback that shaped the patch a
> > bit back in April:
> > https://listman.redhat.com/archives/dm-devel/2023-April/053986.html
> > 
> >> Also, please wrap commit messages at 72-74 chars.
> > 
> > Not seeing where the header should be wrapped.  You referring to the
> > Fixes: line?  I've never seen those wrapped.
> 
> I'm referring to the commit message itself.

Ah, you'd like lines extended because they are too short.
