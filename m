Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71467C7CCE
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 06:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjJMEiN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 00:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMEiM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 00:38:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF25B8
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 21:38:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E048D67373; Fri, 13 Oct 2023 06:38:06 +0200 (CEST)
Date:   Fri, 13 Oct 2023 06:38:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231013043806.GA5797@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com> <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com> <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 07:49:19AM +0530, Kanchan Joshi wrote:
> > precedent to start doing it.
> In my mind, this was about dealing with the specific case when the
> kernel memory is being used for device DMA.
> We have just two cases: (i) separate meta buffer, and (ii) bounce
> buffer for data (+metadata).
> I had not planned sanity checks for user inputs for anything beyond that.
> As opposed to being preventive (in all cases), it was about failing
> only when we are certain that DMA will take place and it will corrupt
> kernel memory.
> 
> In the long-term, it may be possible for the path to do away with
> memory copies. The checks can disappear with that.

As soon as the user buffer is unaligned we need to bounce buffer,
including for the data buffer.
