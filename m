Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32A27AA662
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIVBK0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBKY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 21:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98690F5
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 18:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695344970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R22aP8cvuvHgsRSlkpYF9RgXwgDt5sXPX6aie3Yt8vI=;
        b=E6f2G/h/fv05YhJrJf31PBOqJfgdodvGCFUxkWePBaWPH2qz7D/W+KVkBafUVzmMOfJ6k3
        igOe74rSaP7harRDt7Kas11t/RWcoQSnx9RcDzE6StRLxxL+g90YwB7pyLnWMhE+y/W41S
        ft7jbvgT7lROQH2FqLfr+CrKVXYxfs8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-NdYook5eMLa2EVpSr1Nipg-1; Thu, 21 Sep 2023 21:09:27 -0400
X-MC-Unique: NdYook5eMLa2EVpSr1Nipg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88C97811E7B;
        Fri, 22 Sep 2023 01:09:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6A14492C37;
        Fri, 22 Sep 2023 01:09:19 +0000 (UTC)
Date:   Fri, 22 Sep 2023 09:09:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] block: fix use-after-free of q->q_usage_counter
Message-ID: <ZQzpOhe6Rk3pOtBc@fedora>
References: <20230921182012.3965572-1-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921182012.3965572-1-saranyamohan@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 11:20:12AM -0700, Saranya Muruganandam wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.
> 
> For blk-mq, queue release handler is usually called after
> blk_mq_freeze_queue_wait() returns. However, the
> q_usage_counter->release() handler may not be run yet at that time, so
> this can cause a use-after-free.
> 
> Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
> Since ->release() is called with rcu read lock held, it is agreed that
> the race should be covered in caller per discussion from the two links.
> 
> Backport-notes: Not a clean cherry-pick since a lot has changed,
> however essentially the same fix.
> 
> Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
> Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
> Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
> Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  block/blk-core.c  | 2 --
>  block/blk-sysfs.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0d0dd8151f7..e5eeec801f56 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -414,8 +414,6 @@ void blk_cleanup_queue(struct request_queue *q)
>  		blk_mq_sched_free_requests(q);
>  	mutex_unlock(&q->sysfs_lock);
>  
> -	percpu_ref_exit(&q->q_usage_counter);
> -
>  	/* @q is and will stay empty, shutdown and put */
>  	blk_put_queue(q);
>  }
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 8c5816364dd1..9174137a913c 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -726,6 +726,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
>  {
>  	struct request_queue *q = container_of(rcu_head, struct request_queue,
>  					       rcu_head);
> +
> +	percpu_ref_exit(&q->q_usage_counter);
>  	kmem_cache_free(blk_requestq_cachep, q);
>  }

Looks fine.

BTW, you should have provided target stable tree release info, otherwise how
you expect people to review?

Thanks,
Ming

