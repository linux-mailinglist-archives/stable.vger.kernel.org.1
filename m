Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3674D4A3
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGJLci (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJLch (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 07:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C89E1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688988714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AC1Nthpxyn38cOzn5s0EY7ybaU8oF8V2WbuaRcz/moE=;
        b=ViXEBnwyxWJC+lErucTsiL88UoWvCswA6RfrpBkHtvUizyV0E1H5BvGwmCQz8KqUaJKuqa
        GI+8NCA1dcW5NeRR5ZWyoALTwW779nC0IiLkVlHIgjIotaIvCO7u4RlNUTL+Y0BxyI3fzp
        Xd3zhEA7Y1BMnegHiAoGnL7Rq7rcIHQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-1oTdjtPXMFqHby5DlV5uqg-1; Mon, 10 Jul 2023 07:31:49 -0400
X-MC-Unique: 1oTdjtPXMFqHby5DlV5uqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 954F93C10144;
        Mon, 10 Jul 2023 11:31:48 +0000 (UTC)
Received: from ovpn-8-33.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 800E6145414F;
        Mon, 10 Jul 2023 11:31:43 +0000 (UTC)
Date:   Mon, 10 Jul 2023 19:31:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <ZKvsGuYrf+tJTy41@ovpn-8-33.pek2.redhat.com>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
 <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
 <ZKvH6cO+XnGgQQyc@ovpn-8-31.pek2.redhat.com>
 <8dba03f7-2421-e86b-bc94-ff031c153110@grimberg.me>
 <ZKvUgDbdCdScx0e7@ovpn-8-33.pek2.redhat.com>
 <61fcbded-dbed-bd04-4b96-b3326265eb43@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61fcbded-dbed-bd04-4b96-b3326265eb43@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 02:01:18PM +0300, Sagi Grimberg wrote:
> 
> 
> On 7/10/23 12:50, Ming Lei wrote:
> > On Mon, Jul 10, 2023 at 12:27:31PM +0300, Sagi Grimberg wrote:
> > > 
> > > > > > > > I still want your patches for tcp/rdma that move the freeze.
> > > > > > > > If you are not planning to send them, I swear I will :)
> > > > > > > 
> > > > > > > Ming, can you please send the tcp/rdma patches that move the
> > > > > > > freeze? As I said before, it addresses an existing issue with
> > > > > > > requests unnecessarily blocked on a frozen queue instead of
> > > > > > > failing over.
> > > > > > 
> > > > > > Any chance to fix the current issue in one easy(backportable) way[1] first?
> > > > > 
> > > > > There is, you suggested one. And I'm requesting you to send a patch for
> > > > > it.
> > > > 
> > > > The patch is the one pointed by link [1], and it still can be applied on current
> > > > linus tree.
> > > > 
> > > > https://lore.kernel.org/linux-nvme/20230629064818.2070586-1-ming.lei@redhat.com/
> > > 
> > > This is separate from what I am talking about.
> > > 
> > > > > > All previous discussions on delay freeze[2] are generic, which apply on all
> > > > > > nvme drivers, not mention this error handling difference causes extra maintain
> > > > > > burden. I still suggest to convert all drivers in same way, and will work
> > > > > > along the approach[1] aiming for v6.6.
> > > > > 
> > > > > But we obviously hit a difference in expectations from different
> > > > > drivers. In tcp/rdma there is currently an _existing_ bug, where
> > > > > we freeze the queue on error recovery, and unfreeze only after we
> > > > > reconnect. In the meantime, requests can be blocked on the frozen
> > > > > request queue and not failover like they should.
> > > > > 
> > > > > In fabrics the delta between error recovery and reconnect can (and
> > > > > often will be) minutes or more. Hence I request that we solve _this_
> > > > > issue which is addressed by moving the freeze to the reconnect path.
> > > > > 
> > > > > I personally think that pci should do this as well, and at least
> > > > > dual-ported multipath pci devices would prefer instant failover
> > > > > than after a full reset cycle. But Keith disagrees and I am not going to
> > > > > push for it.
> > > > > 
> > > > > Regardless of anything we do in pci, the tcp/rdma transport
> > > > > freeze-blocking-failover _must_ be addressed.
> > > > 
> > > > It is one generic issue, freeze/unfreeze has to be paired strictly
> > > > for every driver.
> > > > 
> > > > For any nvme driver, the inbalance can happen when error handling
> > > > is involved, that is why I suggest to fix the issue in one generic
> > > > way.
> > > 
> > > Ming, you are ignoring what I'm saying. I don't care if the
> > > freeze/unfreeze is 100% balanced or not (for the sake of this
> > > discussion).
> > > 
> > > I'm talking about a _separate_ issue where a queue
> > > is frozen for potentially many minutes blocking requests that
> > > could otherwise failover.
> > > 
> > > > > So can you please submit a patch for each? Please phrase it as what
> > > > > it is, a bug fix, so stable kernels can pick it up. And try to keep
> > > > > it isolated to _only_ the freeze change so that it is easily
> > > > > backportable.
> > > > 
> > > > The patch of "[PATCH V2] nvme: mark ctrl as DEAD if removing from error
> > > > recovery" can fix them all(include nvme tcp/fc's issue), and can be backported.
> > > 
> > > Ming, this is completely separate from what I'm talking about. This one
> > > is addressing when the controller is removed, while I'm talking about
> > > the error-recovery and failover, which is ages before the controller is
> > > removed.
> > > 
> > > > But as we discussed, we still want to call freeze/unfreeze in pair, and
> > > > I also suggest the following approach[2], which isn't good to backport:
> > > > 
> > > > 	1) moving freeze into reset
> > > > 	
> > > > 	2) during resetting
> > > > 	
> > > > 	- freeze NS queues
> > > > 	- unquiesce NS queues
> > > > 	- nvme_wait_freeze()
> > > > 	- update_nr_hw_queues
> > > > 	- unfreeze NS queues
> > > > 	
> > > > 	3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
> > > > 	
> > > > 	- if the request is FS IO with data, re-submit all bios of this request, and free the request
> > > > 	
> > > > 	- otherwise, fail the request
> > > > 
> > > > 
> > > > [2] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc
> > > 
> > > Ming, please read again what my concern is. I'm talking about error recovery
> > > freezing a queue, and unfreezing only after we reconnect,
> > > blocking requests that should failover.
> > 
> >  From my understanding, nothing is special for tcp/rdma compared with
> > nvme-pci.
> 
> But there is... The expectations are different.
> 
> > All take two stage error recovery: teardown & [reset(nvme-pci) | reconnect(tcp/rdma)]
> > 
> > Queues are frozen during teardown, and unfreeze in reset or reconnect.
> > 
> > If the 2nd stage is failed or bypassed, queues could be left as frozen
> > & unquisced, and requests can't be handled, and io hang.
> > 
> > When tcp reconnect failed, nvme_delete_ctrl() is called for failing
> > requests & removing controller.
> > 
> > Then the patch of "nvme: mark ctrl as DEAD if removing from error recovery"
> > can avoid this issue by calling blk_mark_disk_dead() which can fail any
> > request pending in bio_queue_enter().
> > 
> > If that isn't tcp/rdma's issue, can you explain it in details?
> 
> Yes I can. The expectation in pci is that a reset lifetime will be a few
> seconds. By lifetime I mean it starts and either succeeds or fails.
> 
> in fabrics the lifetime is many minutes. i.e. it starts when error
> recovery kicks in, and either succeeds (reconnected) or fails (deleted
> due to ctrl_loss_tmo). This can take a long period of time (if for
> example the controller is down for maintenance/reboot).
> 
> Hence, while it may be acceptable that requests are blocked on
> a frozen queue for the duration of a reset in pci, it is _not_
> acceptable in fabrics. I/O should failover far sooner than that
> and must _not_ be dependent on the success/failure or the reset.
> 
> Hence I requested that this is addressed specifically for fabrics
> (tcp/rdma).

OK, I got your idea now, but which is basically not doable from current
nvme error recovery approach.

Even though starting freeze is moved to reconnect stage, queue is still
quiesced, then request is kept in block layer's internal queue, and can't
enter nvme fabric .queue_rq().

The patch you are pushing can't work for this requirement, also I don't
think you need that, because FS IO is actually queued to nvme mpath queue,
which won't be frozen at all.

However, you can improve nvme_ns_head_submit_bio() by selecting new path
if the underlying queue is in error recovery. Not dig into the current
code yet, I think it should have been done in this way already.

Thanks, 
Ming

