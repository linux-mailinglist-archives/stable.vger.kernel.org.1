Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACDF7C8910
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJMPrQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjJMPrP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 11:47:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B732BE
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 08:47:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEF3B6732A; Fri, 13 Oct 2023 17:47:08 +0200 (CEST)
Date:   Fri, 13 Oct 2023 17:47:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231013154708.GA17455@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de> <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp> <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 08:41:54PM +0530, Kanchan Joshi wrote:
> It seems we will have two limitations with this approach - (i) sgl for 
> the external metadata buffer, and (ii) using sgl for data-transfer will 
> reduce the speed of passthrough io, perhaps more than what can happen 
> using the checks. And if we make the sgl opt-in, that means leaving the 
> hole for the case when this was not chosen.

The main limitation is that the device needs to support SGLs, and
we need to as well (we currently don't for metadata).  But for any
non-stupid workload SGLs should be at least as fast if not faster
with modern hardware.  But I see no way out.

Now can we please get a patch to disable the unprivileged passthrough
ASAP to fix this probably exploitable hole?  Or should I write one?
