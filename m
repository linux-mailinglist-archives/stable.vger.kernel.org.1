Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3761474D27A
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGJKAV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 06:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGJKAA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 06:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17FB10CB
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688983047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlLWxX08b8LJ3Dkp7XTnOw8mVjNbPIPcBglZ+TM5Sow=;
        b=E9Vz2afst2PkAR70iTo+CNZUGxQ78s9879SbgbIkbzPDO610lu236Yhquob70uRCVLYKe1
        /bulfFyMGVKjR7qazVxDekBEzHbsdocv2xuhYx+LsL4PIwXuP7egIGwR6SofRSkh7jJ91k
        9uRnX/yBu6/iBcuXKN6zQW2EiR1XkmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-CbfClYVXO3OjJhTZmS0Hiw-1; Mon, 10 Jul 2023 05:51:08 -0400
X-MC-Unique: CbfClYVXO3OjJhTZmS0Hiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 811FA1044589;
        Mon, 10 Jul 2023 09:51:07 +0000 (UTC)
Received: from ovpn-8-33.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 578C1111E3E4;
        Mon, 10 Jul 2023 09:51:01 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:50:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
 <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 12:27:31PM +0300, Sagi Grimberg wrote:
> 
> > > > > > I still want your patches for tcp/rdma that move the freeze.
> > > > > > If you are not planning to send them, I swear I will :)
> > > > > 
> > > > > Ming, can you please send the tcp/rdma patches that move the
> > > > > freeze? As I said before, it addresses an existing issue with
> > > > > requests unnecessarily blocked on a frozen queue instead of
> > > > > failing over.
> > > > 
> > > > Any chance to fix the current issue in one easy(backportable) way[1] first?
> > > 
> > > There is, you suggested one. And I'm requesting you to send a patch for
> > > it.
> > 
> > The patch is the one pointed by link [1], and it still can be applied on current
> > linus tree.
> > 
> > https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/
> 
> This is separate from what I am talking about.
> 
> > > > All previous discussions on delay freeze[2] are generic, which apply on all
> > > > nvme drivers, not mention this error handling difference causes extra maintain
> > > > burden. I still suggest to convert all drivers in same way, and will work
> > > > along the approach[1] aiming for v6.6.
> > > 
> > > But we obviously hit a difference in expectations from different
> > > drivers. In tcp/rdma there is currently an _existing_ bug, where
> > > we freeze the queue on error recovery, and unfreeze only after we
> > > reconnect. In the meantime, requests can be blocked on the frozen
> > > request queue and not failover like they should.
> > > 
> > > In fabrics the delta between error recovery and reconnect can (and
> > > often will be) minutes or more. Hence I request that we solve _this_
> > > issue which is addressed by moving the freeze to the reconnect path.
> > > 
> > > I personally think that pci should do this as well, and at least
> > > dual-ported multipath pci devices would prefer instant failover
> > > than after a full reset cycle. But Keith disagrees and I am not going to
> > > push for it.
> > > 
> > > Regardless of anything we do in pci, the tcp/rdma transport
> > > freeze-blocking-failover _must_ be addressed.
> > 
> > It is one generic issue, freeze/unfreeze has to be paired strictly
> > for every driver.
> > 
> > For any nvme driver, the inbalance can happen when error handling
> > is involved, that is why I suggest to fix the issue in one generic
> > way.
> 
> Ming, you are ignoring what I'm saying. I don't care if the
> freeze/unfreeze is 100% balanced or not (for the sake of this
> discussion).
> 
> I'm talking about a _separate_ issue where a queue
> is frozen for potentially many minutes blocking requests that
> could otherwise failover.
> 
> > > So can you please submit a patch for each? Please phrase it as what
> > > it is, a bug fix, so stable kernels can pick it up. And try to keep
> > > it isolated to _only_ the freeze change so that it is easily
> > > backportable.
> > 
> > The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
> > recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.
> 
> Ming, this is completely separate from what I'm talking about. This one
> is addressing when the controller is removed, while I'm talking about
> the error-recovery and failover, which is ages before the controller is
> removed.
> 
> > But as we discussed, we still want to call freeze/unfreeze in pair, and
> > I also suggest the following approach[2], which isn't good to backport:
> > 
> > 	1) moving freeze into reset
> > 	
> > 	2) during resetting
> > 	
> > 	- freeze NS queues
> > 	- unquiesce NS queues
> > 	- nvme_wait_freeze()
> > 	- update_nr_hw_queues
> > 	- unfreeze NS queues
> > 	
> > 	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
> > 	
> > 	- if the request is FS IO with data, re-submit all bios of this request, and free the request
> > 	
> > 	- otherwise, fail the request
> > 
> > 
> > [2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc
> 
> Ming, please read again what my concern is. I'm talking about error recovery
> freezing a queue, and unfreezing only after we reconnect,
> blocking requests that should failover.

From my understanding, nothing is special for tcp/rdma compared with
nvme-pci.

All take two stage error recovery: teardown & [reset(nvme-pci) | reconnect(tcp/rdma)]

Queues are frozen during teardown, and unfreeze in reset or reconnect.

If the 2nd stage is failed or bypassed, queues could be left as frozen
& unquisced, and requests can't be handled, and io hang.

When tcp reconnect failed, nvme_delete_ctrl() is called for failing
requests & removing controller.

Then the patch of "nvme: mark ctrl as DEAD if removing from error recovery"
can avoid this issue by calling blk_mark_disk_dead() which can fail any
request pending in bio_queue_enter().

If that isn't tcp/rdma's issue, can you explain it in details?

At least, from what you mentioned in the following link, seems it is
same with what I am trying to address.

https://lore.kernel.org/linux-nvme/b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me/T/#m5f07ee01cdc99b0b38305d8171e9085921df2bc2

Thanks, 
Ming

