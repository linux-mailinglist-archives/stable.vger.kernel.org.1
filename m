Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440DF7C7187
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjJLPbp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbjJLPbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 11:31:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1BCCA
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 08:31:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B8C433C8;
        Thu, 12 Oct 2023 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697124702;
        bh=9thw6enVQJ3tZ6dwX/ATiKfEwS8rtg+O6wqv4FozA3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2u25QVUtwlHj14oZWySPHUTW9I/huSJ2RNbN5pkNHwrbKylGCalcER8GPLE0sQC8
         1jbM4c3hxdGI3DtyYn5udXTHWyXotVN0IZ1oX6NKMTap3vhxrYtDGlWEPQE4Eyx6V+
         qMyNa3HpyBnZUf87zNWHOgGLZ3kFT/T3lUZLc6IQlNH9F3zQ1/QF/4Cq4MH7umjQYO
         z0xpvl87Hm/j/JpzLkGX8m4hg3VljIFxdMw8JD4vyftTk2EkMfnJdiMRGqWy6dpJW4
         fWNAQxTnefV7b4Y8poV2g7msZiE1GgvIPK8ZpPzabVN3OEjXd9AKyoRDJ222YbdSTE
         xKaCUzD5aLxMA==
Date:   Thu, 12 Oct 2023 09:31:38 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
 <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de>
 <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
 <20231012043652.GA1368@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012043652.GA1368@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 06:36:52AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 11, 2023 at 11:04:58AM -0600, Keith Busch wrote:
> 
> > I don't think it's reasonable for the driver to decode every passthrough
> > command to validate the data lengths, or reject ones that we don't know
> > how to decode. SG_IO doesn't do that either.
> 
> I don't want that either, but what can we do against a (possibly
> unprivileged) user corrupting data?

The unpriviledged access is kind of recent. Maybe limit the scope of
decoding to that usage?

We've always known the interface can be misused to corrupt memory and/or
data, and it was always user responsibility to use this interface
reponsibly. We shouldn't disable something people have relied on for
over 10 years just because someone rediscovered ways to break it.

It's not like this is a "metadata" specific thing either; you can
provide short user space buffers and corrupt memory with regular admin
commands, and we have been able to that from day 1. But if you abuse
this interface, it was always your fault; the kernel never took
responsibility to sanity check your nvme input, and I think it's a bad
precedent to start doing it.
 
> SCSI has it much either because it has an explicit data transfer length
> (outside the CDB) instead of trying to build it from information that
> differs per opcode.  One of the many places where it shows that NVMe
> is a very sloppy and badly thought out protocol.

Yeah, implicit PRP length has often been reported as one of the early
protocol "regrets"...
