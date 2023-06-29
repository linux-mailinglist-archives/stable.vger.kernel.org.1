Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3851D742110
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 09:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjF2Hdw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjF2HdL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 03:33:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DC2972
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 00:33:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E1BA6732D; Thu, 29 Jun 2023 09:33:06 +0200 (CEST)
Date:   Thu, 29 Jun 2023 09:33:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] nvme: mark ctrl as DEAD if removing from error
 recovery
Message-ID: <20230629073305.GA19464@lst.de>
References: <20230629064818.2070586-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629064818.2070586-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 29, 2023 at 02:48:18PM +0800, Ming Lei wrote:
> @@ -4054,8 +4055,14 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	 * disconnected. In that case, we won't be able to flush any data while
>  	 * removing the namespaces' disks; fail all the queues now to avoid
>  	 * potentially having to clean up the failed sync later.
> +	 *
> +	 * If this removal happens during error recovering, resetting part
> +	 * may not be started, or controller isn't be recovered completely,
> +	 * so we have to treat controller as DEAD for avoiding IO hang since
> +	 * queues can be left as frozen and quiesced.
>  	 */
> -	if (ctrl->state == NVME_CTRL_DEAD) {
> +	if (ctrl->state == NVME_CTRL_DEAD ||
> +	    ctrl->old_state != NVME_CTRL_LIVE) {
>  		nvme_mark_namespaces_dead(ctrl);
>  		nvme_unquiesce_io_queues(ctrl);

Thanks for the comment and style, but I really still think doing
the state check was wrong to start with, and adding a check on the
old state makes things significantly worse.  Can we try to brainstorm
on how do this properly?

I think we need to first figure out how to balance the quiesce/unquiesce
calls, the placement of the nvme_mark_namespaces_dead call should
be the simple part.
