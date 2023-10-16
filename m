Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E877CB2A8
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPSlm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjJPSll (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 14:41:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D85EB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 11:41:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833DAC433C7;
        Mon, 16 Oct 2023 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697481700;
        bh=4lLBztM/xqv8MyrTOgkSgKcP2BzPDhrLJvms1pcmm50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8ovcYnalVcdKBkp84orNs+pZE+ZWUzik3f9rQoZqsY+CeBfcdO3Gvcpm9bELelxd
         JzhNxOQ9djLJZZFhqBYP4xDxiQhTaZe9zR12Gap5QiK9ew/Jh/UTJXtE0UcQgB3adp
         EXVQ5Bes8tScK2YuGeUXEYiwfXTsFWAAvjIeWvv90/gqZNE+p+1Z7gBCxIA1igriEu
         zDTQj7ZlKdeGl2yPnwR7JxVfmE6eFgN0p25nQUaFRjrd++Q0D94DRPLugUTZ971oS4
         OekCDSgosnjbnO+Dv1XPdWseEClHst9u9VB08Jfo1CLeIJQKFUpszeuc1hoNhG7Ltr
         WNSefOdr+6k9A==
Date:   Mon, 16 Oct 2023 12:41:37 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, gost.dev@samsung.com,
        vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016060519.231880-1-joshi.k@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 11:35:19AM +0530, Kanchan Joshi wrote:
> Passthrough has got a hole that can be exploited to cause kernel memory
> corruption. This is about making the device do larger DMA into
> short meta/data buffer owned by kernel [1].
> 
> As a stopgap measure, disable the support of unprivileged passthrough.
> 
> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
> following patches:
> 
> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/
> 
> CC: stable@vger.kernel.org # 6.2
> Fixes: 855b7717f44b1 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Applied for nvme-6.6.
