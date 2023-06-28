Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F7740A3A
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjF1IAo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:00:44 -0400
Received: from verein.lst.de ([213.95.11.211]:38700 "EHLO verein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232279AbjF1H6D (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Jun 2023 03:58:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00DDB68AA6; Wed, 28 Jun 2023 09:39:57 +0200 (CEST)
Date:   Wed, 28 Jun 2023 09:39:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <20230628073957.GB25314@lst.de>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628031234.1916897-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> @@ -4055,7 +4056,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	 * removing the namespaces' disks; fail all the queues now to avoid
>  	 * potentially having to clean up the failed sync later.
>  	 */
> -	if (ctrl->state == NVME_CTRL_DEAD) {
> +	if (ctrl->state == NVME_CTRL_DEAD ||
> +			ctrl->old_state != NVME_CTRL_LIVE) {

Style nitpick: this is really nasty to read, pleas align things
properly:

	if (ctrl->state == NVME_CTRL_DEAD ||
	    ctrl->old_state != NVME_CTRL_LIVE) {

But I'm really worried about this completely uncodumented and fragile
magic here.  The existing magic NVME_CTRL_DEAD is bad enough, but
backtracking to the previous state just makes this worse.

I think a big problem is that the call to nvme_mark_namespaces_dead
and nvme_unquiesce_io_queues is hidden inside of
nvme_remove_namespaces, and I think there's no good way around
us unwinding the currently unpair quiesce calls and fixing this
for real.
  T
