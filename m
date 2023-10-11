Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485567C4ABC
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjJKGgW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbjJKGgV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:36:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64081D3
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:36:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 779CA6732A; Wed, 11 Oct 2023 08:36:15 +0200 (CEST)
Date:   Wed, 11 Oct 2023 08:36:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshiiitr@gmail.com>, kbusch@kernel.org,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231011063615.GA2323@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <1296674576.21697005984297.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1296674576.21697005984297.JavaMail.epsvc@epcpadp4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11, 2023 at 10:56:44AM +0530, Kanchan Joshi wrote:
> > Fixing just a subset of these problems is pointless.  If people want
> > to use metadata on vendor specific commands they need to work with
> > NVMe to figure out a generic way to pass the length.
> 
> Do you suggest that vendor specific opcodes should be blocked here?

We have to block everything that we can't calculate the length for.
Otherwise you still leave the hole open.
