Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F707C873B
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjJMNyJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJMNyI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 09:54:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C5AD
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 06:54:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA90C433CA;
        Fri, 13 Oct 2023 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697205246;
        bh=lCM1IEBB6Zo6eHfhvNjtIDG9oDrI/zQMavuap6OoMB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcrUECgrANyryGvjmWWjelTOGesYZ7oTxX3dZEBmoQWYna036SpxIX+sZ2UzL0ZfJ
         y8GYsCRy/7WqWR0ZX9N1HN8GDrBlzrI95Tctnp12UTFL3KpZe7jF7aIHY6Pc+v/eKj
         fZmAoFZvhHIclNtqFJmAraVC0qFC0Sta9ZPq3NnkPAnv8Yc7r5usdRCOfFP/uZMnU9
         6v5oPsjPclyKS0FWenHcN5KkWa9djrDjfFvK0b2V0Ks4jj8WOA7I2G3EGPyoy1/iXZ
         q1imhRoxC50x+ziAkKfAzSxD3npbM9xn6dWBZCUUohsZMH7NZQnA1+9FCnG34k/qyB
         lJZy48+/nhoNA==
Date:   Fri, 13 Oct 2023 07:54:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <ZSlL-6Oa5J9duahR@kbusch-mbp>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com>
 <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 03:44:38PM +0530, Kanchan Joshi wrote:
> On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
> > On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
> >> Changes since v3:
> >> - Block only unprivileged user
> > 
> > That's not really what at least I had in mind.  I'd much rather
> > completely disable unprivileged passthrough for now as an easy
> > backportable patch.  And then only re-enable it later in a way
> > where it does require using SGLs for all data transfers.
> > 
> 
> I did not get how forcing SGLs can solve the issue at hand.
> The problem happened because (i) user specified short buffer/len, and 
> (ii) kernel allocated buffer. Whether the buffer is fed to device using 
> PRP or SGL does not seem to solve the large DMA problem.

The problem is a disconnect between the buffer size provided and the
implied size of the command. The idea with SGL is that it requires an
explicit buffer size, so the device will know the buffer is short and
return an appropriate error.
