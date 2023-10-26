Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767F7D8599
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjJZPIu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 11:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjJZPIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 11:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF5129
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 08:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC82C433C7;
        Thu, 26 Oct 2023 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698332926;
        bh=9r0/t3eIMrZRQMzSDwyyyhTnAf1WbhVZ8oxn7HT2fco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jse7FHi+s//TJEwFbZgyg+OhkCQ7ou307Uq0i3da3qKSTYCduYnFtSJbGUNBcA8Za
         GOGCeOSaJ0GQkGSjMd3HoJfAAE4CebEs9m8owlqqWoqcMmoYfRMHrVPvkbOtKkHa5f
         w2H/eoX0Ju+HLucns/uN+8sSi+HlgkQvqP5zheUo/lnG6hao9BcERdkeJ/jTqGiYve
         R+P/IQjBm3Aj9x/oinLp/U+FFMyoL1Xw/AqdXhtvDL3uB9Memu2tuH+DBa2C3URROL
         gKZWdZuG6hQjH87Zc1rAfJmWR3RdZhETui34OjuqLbxzAu2BqQTzH3R1wcn8ty9ihS
         YLlAU06wjF5eA==
Date:   Thu, 26 Oct 2023 09:08:43 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <ZTqA--6dDYJ76Gyk@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com>
 <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
 <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
 <20231013154708.GA17455@lst.de>
 <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
 <20231016054647.GA26170@lst.de>
 <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 26, 2023 at 08:03:30PM +0530, Kanchan Joshi wrote:
> On Mon, Oct 16, 2023 at 11:16 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> > > OTOH, this patch implemented a software-only way out. There are some
> > > checks, but someone (either SW or HW) has to do those to keep things
> > > right.
> >
> > It only verifies it to the read/write family of commands by
> > interpreting these commands.  It still leaves a wide hole for any
> > other command.
> 
> Can you please explain for what command do you see the hole? I am
> trying to see if it is really impossible to fix this hole for good.
> 
> We only need to check for specific io commands of the NVM/ZNS command
> set that can do extra DMA.

The spec defines a few commands that may use MPTR, but most of the
possible opcodes that could use it are not defined in spec. You'd have
to break forward compatibility through this interface for non-root users
by limiting its use to only the known opcodes and reject everything
else.
