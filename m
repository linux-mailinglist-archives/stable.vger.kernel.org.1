Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163A17D29BA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 07:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjJWFpC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWFpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 01:45:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BAEB3
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 22:44:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5205168AA6; Mon, 23 Oct 2023 07:44:56 +0200 (CEST)
Date:   Mon, 23 Oct 2023 07:44:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <20231023054456.GB11272@lst.de>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com> <20231016060519.231880-1-joshi.k@samsung.com> <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com> <ZTBNfDzxD3D8loMm@kbusch-mbp> <20231019050411.GA14044@lst.de> <ZTKN7f7kzydfiwb2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKN7f7kzydfiwb2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 08:25:49AM -0600, Keith Busch wrote:
> Jens repeated what he told me offline on this thread here, and dropped
> the pull request that contained this patch:
> 
>   https://lists.infradead.org/pipermail/linux-nvme/2023-October/042684.html
> 
> BTW, don't you still need someone with root access to change the
> permissions on the device handle in order for an unpriveledged user to
> reach this hole? It's not open access by default, you still have to
> opt-in.

Yes, you need someone with root access to change the device node
persmissions.  But we allowed that under the assumption it is safe
to do so, which it turns out it is not.
