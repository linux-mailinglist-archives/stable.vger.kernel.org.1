Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6A17CEEE3
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 07:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJSFER (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 01:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJSFEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 01:04:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B910F
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 22:04:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8758C67373; Thu, 19 Oct 2023 07:04:11 +0200 (CEST)
Date:   Thu, 19 Oct 2023 07:04:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <20231019050411.GA14044@lst.de>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com> <20231016060519.231880-1-joshi.k@samsung.com> <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com> <ZTBNfDzxD3D8loMm@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTBNfDzxD3D8loMm@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 03:26:20PM -0600, Keith Busch wrote:
> On further consideration and some offline chats, I believe this large
> change is a bit too late for 6.6. I think this should wait for 6.7 (and
> stable), hopefully preserving non-root access in some sane capacity.
> It's backed out now, and current nvme-6.6 PR does not include this
> patch.

Umm, what are the offlist discussions?  We leave an exploitable hole
in, so I don't think waiting any longer is an option.
