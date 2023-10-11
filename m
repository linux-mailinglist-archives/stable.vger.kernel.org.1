Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440D37C48F5
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 07:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjJKFDA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 01:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjJKFC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 01:02:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FCB9D
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 22:02:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 559456732A; Wed, 11 Oct 2023 07:02:54 +0200 (CEST)
Date:   Wed, 11 Oct 2023 07:02:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231011050254.GA32444@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 07:09:54PM +0530, Kanchan Joshi wrote:
> The case is for the single interleaved buffer with both data and
> metadata. When the driver sends this buffer to blk_rq_map_user_iov(),
> it may make a copy of it.
> This kernel buffer will be used for DMA rather than user buffer. If
> the user-buffer is short, the kernel buffer is also short.

Yes.  Note that we'll corrupt memory either way, so user vs kernel
does not matter.

> Does this explanation help?
> I can move the part to a separate patch.

Definitively separate function please, not sure if a separate
patch is required.

> Yes, not io_uring specific.
> Just that I was not sure on (i) whether to go back that far in
> history, and (ii) what patch to tag.

I think the one that adds the original problem is:

63263d60e0f9f37bfd5e6a1e83a62f0e62fc459f
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Aug 29 17:46:04 2017 -0400

    nvme: Use metadata for passthrough commands


> > > +     /* Exclude commands that do not have nlb in cdw12 */
> > > +     if (!nvme_nlb_in_cdw12(c->common.opcode))
> > > +             return true;
> >
> > So we can still get exactly the same corruption for all commands that
> > are not known?  That's not a very safe way to deal with the issue..
> 
> Given the way things are in NVMe, I do not find a better way.
> Maybe another day for commands that do (or can do) things very
> differently for nlb and PI representation.

Fixing just a subset of these problems is pointless.  If people want
to use metadata on vendor specific commands they need to work with
NVMe to figure out a generic way to pass the length.
