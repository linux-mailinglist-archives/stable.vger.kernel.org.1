Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918EC7B7F02
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjJDM0F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjJDM0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 08:26:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923993
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 05:25:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02474C433C8;
        Wed,  4 Oct 2023 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696422358;
        bh=/+k15foB42xwn1SO0nA4WG6oVVxx5pbkztYvznyKKcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRDJcgP8MEYq3+aYyQHEC9YzNXyC1qwgn9X6YC7HCyni1XmC4gkZ75hXi2KiDX8ub
         hH0nClqCrTq6Pj2EKA0G6fIGmZFIHb3Ing9oFANX3sQ/O9xhK46EbMVZ7Z30BMGDUF
         VZJrB9hx+loATVabEstZnHPGOKMiwnUd6Alq92Qc=
Date:   Wed, 4 Oct 2023 14:25:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     sj@kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        zahavi.alon@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Message-ID: <2023100445-twisted-everyone-be72@gregkh>
References: <20231003164638.2526-1-sj@kernel.org>
 <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 12:41:30PM +0300, Sagi Grimberg wrote:
> 
> > Hello,
> > 
> > On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> > 
> > >  From Alon:
> > > "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
> > > a malicious user can cause a UAF and a double free, which may lead to
> > > RCE (may also lead to an LPE in case the attacker already has local
> > > privileges)."
> > > 
> > > Hence, when a queue initialization fails after the ahash requests are
> > > allocated, it is guaranteed that the queue removal async work will be
> > > called, hence leave the deallocation to the queue removal.
> > > 
> > > Also, be extra careful not to continue processing the socket, so set
> > > queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
> > > 
> > > Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> > > Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> > Would it be better to add Fixes: and Cc: stable lines?
> 
> This issue existed since the introduction of the driver, I am not sure
> it applies cleanly that far back...
> 
> I figured that the description and Reported-by tag will trigger stable
> kernel pick up...

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
