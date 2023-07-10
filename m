Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB57574D0B4
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGJI6Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 04:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJI6X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 04:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE763C3
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688979454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4I42qqYNK+3f/TkWFLyU5fbfqVFxIhAvdnLjbRxGdNg=;
        b=SabUytrPd7SXKagxKVfbwj0tm6WidYaujsDhZW03A5ZDbRUpm0P6J+TJ0di3wl22SGYTIA
        QT2UfSX6tmpas4cse/2xcixTjjOQLBjuHRG976pbvgryHJjXEzs0wUY6bO9JVXk6SyfhTx
        Lk5BSNQw+d4r8Eet3ly3nP8Rfv2MAzk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-lyC8tM4LMfmnyd-QogaEKg-1; Mon, 10 Jul 2023 04:57:30 -0400
X-MC-Unique: lyC8tM4LMfmnyd-QogaEKg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 044B28028B2;
        Mon, 10 Jul 2023 08:57:30 +0000 (UTC)
Received: from ovpn-8-31.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACCEB4CD0CD;
        Mon, 10 Jul 2023 08:57:20 +0000 (UTC)
Date:   Mon, 10 Jul 2023 16:57:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 11:23:44AM +0300, Sagi Grimberg wrote:
> 
> > > > > namespace's request queue is frozen and quiesced during error recovering,
> > > > > writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <-
> > > > > del_gendisk()
> > > > > can't move on, and causes IO hang. Removal could be from sysfs, hard
> > > > > unplug or error handling.
> > > > > 
> > > > > Fix this kind of issue by marking controller as DEAD if removal breaks
> > > > > error recovery.
> > > > > 
> > > > > This ways is reasonable too, because controller can't be recovered any
> > > > > more after being removed.
> > > > 
> > > > This looks fine to me Ming,
> > > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > > 
> > > > 
> > > > I still want your patches for tcp/rdma that move the freeze.
> > > > If you are not planning to send them, I swear I will :)
> > > 
> > > Ming, can you please send the tcp/rdma patches that move the
> > > freeze? As I said before, it addresses an existing issue with
> > > requests unnecessarily blocked on a frozen queue instead of
> > > failing over.
> > 
> > Any chance to fix the current issue in one easy(backportable) way[1] first?
> 
> There is, you suggested one. And I'm requesting you to send a patch for
> it.

The patch is the one pointed by link [1], and it still can be applied on current
linus tree.

https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/

> 
> > 
> > All previous discussions on delay freeze[2] are generic, which apply on all
> > nvme drivers, not mention this error handling difference causes extra maintain
> > burden. I still suggest to convert all drivers in same way, and will work
> > along the approach[1] aiming for v6.6.
> 
> But we obviously hit a difference in expectations from different
> drivers. In tcp/rdma there is currently an _existing_ bug, where
> we freeze the queue on error recovery, and unfreeze only after we
> reconnect. In the meantime, requests can be blocked on the frozen
> request queue and not failover like they should.
> 
> In fabrics the delta between error recovery and reconnect can (and
> often will be) minutes or more. Hence I request that we solve _this_
> issue which is addressed by moving the freeze to the reconnect path.
> 
> I personally think that pci should do this as well, and at least
> dual-ported multipath pci devices would prefer instant failover
> than after a full reset cycle. But Keith disagrees and I am not going to
> push for it.
> 
> Regardless of anything we do in pci, the tcp/rdma transport
> freeze-blocking-failover _must_ be addressed.

It is one generic issue, freeze/unfreeze has to be paired strictly
for every driver.

For any nvme driver, the inbalance can happen when error handling
is involved, that is why I suggest to fix the issue in one generic
way.

> 
> So can you please submit a patch for each? Please phrase it as what
> it is, a bug fix, so stable kernels can pick it up. And try to keep
> it isolated to _only_ the freeze change so that it is easily
> backportable.

The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.

But as we discussed, we still want to call freeze/unfreeze in pair, and
I also suggest the following approach[2], which isn't good to backport:

	1) moving freeze into reset
	
	2) during resetting
	
	- freeze NS queues
	- unquiesce NS queues
	- nvme_wait_freeze()
	- update_nr_hw_queues
	- unfreeze NS queues
	
	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
	
	- if the request is FS IO with data, re-submit all bios of this request, and free the request
	
	- otherwise, fail the request


[2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc


thanks,
Ming

