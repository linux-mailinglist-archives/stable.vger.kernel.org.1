Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F077734F87
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjFSJVT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFSJVS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 05:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29171116
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 02:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687166432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETkyIDemFEzkSZEul3XB9TVaq+ms1A0aY6LCIPMpUcw=;
        b=XEm6VgUYtP37Ldne7EtoxLLA5Gr3GVFv/MFuCo+94IoYMeKqkvqs7jFkyN3JrQcL8P/IHf
        1b5nKmQlcpRHDAToiJlCCK6nk3ayFWHD5qgnNIDLysFUglgtOqV8fSO76dpXwLzPd1eKE6
        GZhlVG/Ki72dvTA7aYQ479IIFdzPqxU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-1qmgSqcSOiaGRKdZ_BHD3w-1; Mon, 19 Jun 2023 05:20:30 -0400
X-MC-Unique: 1qmgSqcSOiaGRKdZ_BHD3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D102D3806712;
        Mon, 19 Jun 2023 09:20:29 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C43E62166B26;
        Mon, 19 Jun 2023 09:20:24 +0000 (UTC)
Date:   Mon, 19 Jun 2023 17:20:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        mkoutny@suse.com, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH 6.3.y] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZJAd0xNvx99haE6y@ovpn-8-18.pek2.redhat.com>
References: <20230619083009.743135-1-ming.lei@redhat.com>
 <2023061901-fleshed-patrol-afc4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061901-fleshed-patrol-afc4@gregkh>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 10:51:16AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 19, 2023 at 04:30:09PM +0800, Ming Lei wrote:
> > As noted by Michal, the blkg_iostat_set's in the lockless list hold
> > reference to blkg's to protect against their removal. Those blkg's
> > hold reference to blkcg. When a cgroup is being destroyed,
> > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > is called when the blkcg reference count reaches 0. This circular
> > dependency will prevent blkcg and some blkgs from being freed after
> > they are made offline.
> > 
> > It is less a problem if the cgroup to be destroyed also has other
> > controllers like memory that will call cgroup_rstat_flush() which will
> > clean up the reference count. If block is the only controller that uses
> > rstat, these offline blkcg and blkgs may never be freed leaking more
> > and more memory over time.
> > 
> > To prevent this potential memory leak:
> > 
> > - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> > can be added
> > 
> > - add global blkg_stat_lock for covering concurrent parent blkg stat
> > update
> > 
> > - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> > per-cpu stat list since all stats are guaranteed to be consumed before
> > releasing blkg instance, and grabbing blkg reference for stats was the
> > most fragile part of original patch
> > 
> > Based on Waiman's patch:
> > 
> > https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> > 
> > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Jay Shin <jaeshin@redhat.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: mkoutny@suse.com
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Link: https://lore.kernel.org/r/20230609234249.1412858-1-ming.lei@redhat.com
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > ---
> > Context difference with linus tree: 2c275afeb61d ("block: make blkcg_punt_bio_submit
> > optional") adds '#ifdef CONFIG_BLK_CGROUP_PUNT_BIO' in __blkg_release().
> > 
> > 
> 
> What is the git commit id of this change in Linus's tree?

20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")


Thanks,
Ming

