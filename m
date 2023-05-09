Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570BE6FCBB7
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjEIQw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjEIQw0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 12:52:26 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD81BD3
        for <stable@vger.kernel.org>; Tue,  9 May 2023 09:51:41 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7577ef2fa31so782367985a.0
        for <stable@vger.kernel.org>; Tue, 09 May 2023 09:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651100; x=1686243100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AiXugarlhHToBN2ueOGwWaX5E4llz8s13EASoB3wVI=;
        b=dRw4U7P9c/V4kzIp7lMKdp4H6FrSFNDgd/Q82X3QdNBJVFd8YpkVHrj1+XpySzgfOX
         9lCiQq71T0ycnlKNDvr2xRE0ao2u6EvndiAGKHXIKavw2hXKSN2vjIl4Z9Sb/M4VW+lf
         JQS6/Ze+m4t9GnmTb4y3aREgbmmzvpZgIzI6jNdklH0JTZH0Hl/ghgTtA20OrG4iZUwP
         0r4aiUEIh5fQXWbKB2FqKrSFPvF6aQuN4CcgnXmgsA0eVJENxUKQpfLJ1bzIwVPXCWcT
         JAVf8zHvEWQMaSwcj1/nN0eAAoIJVAR3S5odNbmvKZLYcAce8/hmTdlMCHJtuvLshmEi
         8v2g==
X-Gm-Message-State: AC+VfDy37SfRBC+r9muIyGY2d5CveZoKWaaqX36dkH55BUoKzzlQY2BM
        S009+IwG76tNfmOQgr/OVX6M
X-Google-Smtp-Source: ACHHUZ4xRyujKImbkSQcW8Z759B/taKjk2/BBWT+4ePbKXa9irKnpFPNPIQc/SyDOhMLc66FmfxRwA==
X-Received: by 2002:a05:6214:29c7:b0:56e:c066:3cd2 with SMTP id gh7-20020a05621429c700b0056ec0663cd2mr19939922qvb.2.1683651100740;
        Tue, 09 May 2023 09:51:40 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id m4-20020a0cf184000000b0061b3338d6d9sm890247qvl.50.2023.05.09.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:51:40 -0700 (PDT)
Date:   Tue, 9 May 2023 12:51:38 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <ZFp6GphV3H0eyrH+@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-2-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
> Cc: stable@vger.kernel.org
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
