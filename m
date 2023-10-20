Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4A7D118A
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377571AbjJTOZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377573AbjJTOZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 10:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AED66
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 07:25:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9B5C433C7;
        Fri, 20 Oct 2023 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697811952;
        bh=6PoCuKIk4FcuMpZ90SnR0HDzueQQozxpyNhjmXc4gV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR0+wMwB9MgVqh1xf9P1DTnb4Kqg0R9i0FiyhIHY+UTt/x9lqjAlmAnB3moEEQ/gJ
         bRafePEBbcDkRDiEfI9I5VjPvZ4DCioHHoJE/rYL+VR81vo7+GY5nnrWFM7fafx6ZU
         Fufmh44bwknQy7Dyi9NCbMp3TYriYSyq7zNyggx2jT9emGI+y+AJnzEAiHGjerlOxZ
         OrDE7MCUdkkE7BQwXJxHe3qUQH2tALhcRZRZmJzYDYPQ4z7Y9YYsW0bjP4ESibkLHP
         Bh4atMZPi3Yc9eAP0Khrwc8potG9d3fngpWd3bFGDMkPjYcr/xX+GPWT1Nr1kJEnqb
         aXgqgfrjvreQg==
Date:   Fri, 20 Oct 2023 08:25:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTKN7f7kzydfiwb2@kbusch-mbp>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
 <ZTBNfDzxD3D8loMm@kbusch-mbp>
 <20231019050411.GA14044@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019050411.GA14044@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 19, 2023 at 07:04:11AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 18, 2023 at 03:26:20PM -0600, Keith Busch wrote:
> > On further consideration and some offline chats, I believe this large
> > change is a bit too late for 6.6. I think this should wait for 6.7 (and
> > stable), hopefully preserving non-root access in some sane capacity.
> > It's backed out now, and current nvme-6.6 PR does not include this
> > patch.
> 
> Umm, what are the offlist discussions?  We leave an exploitable hole
> in, so I don't think waiting any longer is an option.

Jens repeated what he told me offline on this thread here, and dropped
the pull request that contained this patch:

  https://lists.infradead.org/pipermail/linux-nvme/2023-October/042684.html

BTW, don't you still need someone with root access to change the
permissions on the device handle in order for an unpriveledged user to
reach this hole? It's not open access by default, you still have to
opt-in.
