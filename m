Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBE786710
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 07:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbjHXFTI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 01:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbjHXFS5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 01:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E71198
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692854292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HYF8b5+w5zwg0TshHiVGB9NwZH2Hu45P81L38Yjgpg=;
        b=fCoi7ctCIRj8wFVMk4UJd1w7O7egHYIgdMJFI/7OShUErtqnvHnGAMyNVTZwJL8EYLTAjL
        4lLAwXFBTb5ZLWHKomLKDSzZdUPbsZ0vr5Jye8PUAR1PhNLYFcxC1R95hjOjNlzJlB6ekb
        Jb9nXqNtyuS6cirqmcR2Kop51RZTFS4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-Ocnjmqy5Miq2IMF3Ej3bCQ-1; Thu, 24 Aug 2023 01:18:08 -0400
X-MC-Unique: Ocnjmqy5Miq2IMF3Ej3bCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 574621C05132;
        Thu, 24 Aug 2023 05:18:08 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D6C26B595;
        Thu, 24 Aug 2023 05:18:03 +0000 (UTC)
Date:   Thu, 24 Aug 2023 13:17:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     axboe@kernel.dk, chuhu@redhat.com, snitzer@kernel.org,
        tj@kernel.org, xifeng@redhat.com, yukuai3@huawei.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] blk-cgroup: hold queue_lock when removing
 blkg->q_node" failed to apply to 6.1-stable tree
Message-ID: <ZOboBivSI7gXCh5u@fedora>
References: <2023082019-brink-buddhist-4d1b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082019-brink-buddhist-4d1b@gregkh>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 20, 2023 at 07:54:19PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x c164c7bc9775be7bcc68754bb3431fce5823822e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082019-brink-buddhist-4d1b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> c164c7bc9775 ("blk-cgroup: hold queue_lock when removing blkg->q_node")
> a06377c5d01e ("Revert "blk-cgroup: pin the gendisk in struct blkcg_gq"")
> 9a9c261e6b55 ("Revert "blk-cgroup: pass a gendisk to blkg_lookup"")
> 1231039db31c ("Revert "blk-cgroup: move the cgroup information to struct gendisk"")
> dcb522014351 ("Revert "blk-cgroup: simplify blkg freeing from initialization failure paths"")
> 3f13ab7c80fd ("blk-cgroup: move the cgroup information to struct gendisk")
> 479664cee14d ("blk-cgroup: pass a gendisk to blkg_lookup")
> ba91c849fa50 ("blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos")
> 3963d84df797 ("blk-rq-qos: constify rq_qos_ops")
> ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more useful")
> b494f9c566ba ("blk-rq-qos: move rq_qos_add and rq_qos_del out of line")
> f05837ed73d0 ("blk-cgroup: store a gendisk to throttle in struct task_struct")
> 84d7d462b16d ("blk-cgroup: pin the gendisk in struct blkcg_gq")
> 180b04d450a7 ("blk-cgroup: remove the !bdi->dev check in blkg_dev_name")
> 27b642b07a4a ("blk-cgroup: simplify blkg freeing from initialization failure paths")
> 0b6f93bdf07e ("blk-cgroup: improve error unwinding in blkg_alloc")
> f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> dfd6200a0954 ("blk-cgroup: support to track if policy is online")
> c7241babf085 ("blk-cgroup: dropping parent refcount after pd_free_fn() is done")
> e3ff8887e7db ("blk-cgroup: fix missing pd_online_fn() while activating policy")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From c164c7bc9775be7bcc68754bb3431fce5823822e Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Thu, 17 Aug 2023 22:17:51 +0800
> Subject: [PATCH] blk-cgroup: hold queue_lock when removing blkg->q_node
> 
> When blkg is removed from q->blkg_list from blkg_free_workfn(), queue_lock
> has to be held, otherwise, all kinds of bugs(list corruption, hard lockup,
> ..) can be triggered from blkg_destroy_all().
> 
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")

The above commit is reverted on 6.1-stable only, so this patch needn't to
backport on 6.1-stable.

Thanks,
Ming

