Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6851D7C48F7
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 07:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJKFDe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 01:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjJKFDe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 01:03:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D1E92
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 22:03:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 23D1F6732A; Wed, 11 Oct 2023 07:03:30 +0200 (CEST)
Date:   Wed, 11 Oct 2023 07:03:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Clay Mayers <Clay.Mayers@kioxia.com>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "vincentfu@gmail.com" <vincentfu@gmail.com>,
        "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231011050329.GB32444@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <8a0e5f41559646d9b505b11386142b55@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0e5f41559646d9b505b11386142b55@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 03:31:23PM +0000, Clay Mayers wrote:
> > Sure, I can change it.
> > 
> 
> What if the ns used the KV CS?  Store and retrieve are the same
> op codes as nvme_cmd_write and nvme_cmd_read.

Yeah, we also need a CSI check here.
