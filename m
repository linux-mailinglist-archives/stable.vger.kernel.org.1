Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467597421D0
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF2ILR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjF2IKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 04:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157953583
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688025692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/6Z9IyTZ3gYwMwh6hWnQa+ZR/r0uRjbWfb8R9LOY2k=;
        b=d5Bnw3uROnX1JwSDnh/vvPI3Z+AxOAC/yC9Khh7mYEvu2xeb22PUCnihuiXsFEVGmjIINe
        CqzmdQ15JaT+Lkl9mskjJQOybYEEzhj8AYgQTHQPXSoajpeEjPzkUh0D+JpRPAfNtzSNlb
        aN/p2Uty1za5c7SKrv3WukdTUq9p3So=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-1gM1cA_FPXSC1Yr4jRqLJg-1; Thu, 29 Jun 2023 04:01:28 -0400
X-MC-Unique: 1gM1cA_FPXSC1Yr4jRqLJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FDF93C10152;
        Thu, 29 Jun 2023 08:01:28 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 027472166B25;
        Thu, 29 Jun 2023 08:01:22 +0000 (UTC)
Date:   Thu, 29 Jun 2023 16:01:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH V2] nvme: mark ctrl as DEAD if removing from error
 recovery
Message-ID: <ZJ06TLaXjyFPpU65@ovpn-8-18.pek2.redhat.com>
References: <20230629064818.2070586-1-ming.lei@redhat.com>
 <20230629073305.GA19464@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629073305.GA19464@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 29, 2023 at 09:33:05AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 29, 2023 at 02:48:18PM +0800, Ming Lei wrote:
> > @@ -4054,8 +4055,14 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >  	 * disconnected. In that case, we won't be able to flush any data while
> >  	 * removing the namespaces' disks; fail all the queues now to avoid
> >  	 * potentially having to clean up the failed sync later.
> > +	 *
> > +	 * If this removal happens during error recovering, resetting part
> > +	 * may not be started, or controller isn't be recovered completely,
> > +	 * so we have to treat controller as DEAD for avoiding IO hang since
> > +	 * queues can be left as frozen and quiesced.
> >  	 */
> > -	if (ctrl->state == NVME_CTRL_DEAD) {
> > +	if (ctrl->state == NVME_CTRL_DEAD ||
> > +	    ctrl->old_state != NVME_CTRL_LIVE) {
> >  		nvme_mark_namespaces_dead(ctrl);
> >  		nvme_unquiesce_io_queues(ctrl);
> 
> Thanks for the comment and style, but I really still think doing
> the state check was wrong to start with, and adding a check on the
> old state makes things significantly worse.  Can we try to brainstorm
> on how do this properly?

Removal comes during error recovery, and the old state is just for figuring
out this situation, and I think it is documented clearly, and same with
the change itself.

We need to fix it in one simple way for -stable and downstream, so I'd
suggest to apply the simple fix first.

> 
> I think we need to first figure out how to balance the quiesce/unquiesce
> calls, the placement of the nvme_mark_namespaces_dead call should
> be the simple part.

The root cause is that nvme driver takes 2 stage error recovery(teardown and
reset), both two are run from different contexts. The teardown part freezes
and quiesces queues, and reset stage does the unfreeze and unquiesce part.
Device removal can come any time, maybe before starting the reset, and maybe
during resetting, so it is hard to balance the two pair APIs if not calling
them in same context. And it has been one long-term issue.

I am working to move freeze to reset handler[1], which can balance
freeze API.

For quiesce API, I think it still need to be done unconditionally
when removing NSs.

But this kind of work can't be fix candidate for -stable or downstream cause
the change is bigger & more complicated.

[1] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc


Thanks, 
Ming

