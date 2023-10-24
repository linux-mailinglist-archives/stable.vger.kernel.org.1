Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2237D47F2
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjJXHIG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJXHIF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 03:08:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57A1110
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 00:08:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 312F767373; Tue, 24 Oct 2023 09:08:00 +0200 (CEST)
Date:   Tue, 24 Oct 2023 09:07:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <20231024070759.GE9847@lst.de>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com> <20231016060519.231880-1-joshi.k@samsung.com> <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com> <ZTBNfDzxD3D8loMm@kbusch-mbp> <20231019050411.GA14044@lst.de> <ZTKN7f7kzydfiwb2@kbusch-mbp> <20231023054456.GB11272@lst.de> <ZTaOzORdmFwxCW1c@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTaOzORdmFwxCW1c@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 09:18:36AM -0600, Keith Busch wrote:
> On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
> > Yes, you need someone with root access to change the device node
> > persmissions.  But we allowed that under the assumption it is safe
> > to do so, which it turns out it is not.
> 
> Okay, iiuc, while we have to opt-in to allow this hole, we need another
> option for users to set to allow this usage because it's not safe.
> 
> Here are two options I have considered for unpriveledged access, please
> let me know if you have others or thoughts.
> 
>   Restrict access for processes with CAP_SYS_RAWIO, which can be granted
>   to non-root users. This cap is already used in scsi subsystem, too.

Well, that's sensible in general.

>   A per nvme-generic namespace sysfs attribute that only root can toggle
>   that would override any caps and just rely on access permissions.

And that I'm not confident about as long as we can only use the broken
PRP scheme on NVMe.
