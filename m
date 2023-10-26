Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E447D85C7
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjJZPPQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 11:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjJZPPQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 11:15:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41934D7
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 08:15:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55055C433C8;
        Thu, 26 Oct 2023 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698333313;
        bh=wI+wGv6Oo7wOqhSkOwz6XtxndnqCso0L8Xld/XtNpZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amwxCP1EUd9hOyHB2fTUdbstJoU4QaBz3ja8wJKREaT8TgTOT+2aNOGQtu6tRBLgL
         A5Sh2OrKJ6eddrJePv7BsPIHfhoKXuVCYwTXBZldV3I/ZeynYbRnI/qd+nz4VIogbs
         //k3yKr+7uKxzCOT0MlwlbGJoGQbysLiYbNroaGu3Du+/6AmF7BQoth7cZ2lREsJ3N
         k5hG39bjQhWk2pZbtuTweRH8NjpImMGLvVGj8CBjTfX2BMjDLeUQcatx8FX6+aJ0TI
         wzRgRRIqAP4P7lysP6EWjmOyILnFPTM7YpWrLjFopPLY/2vQbtdW4Auw36M68eQVxn
         NXZCE8KUVhqkA==
Date:   Thu, 26 Oct 2023 09:15:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, gost.dev@samsung.com,
        vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTqCf27cj5ahr5r7@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
 <ZTBNfDzxD3D8loMm@kbusch-mbp>
 <20231019050411.GA14044@lst.de>
 <ZTKN7f7kzydfiwb2@kbusch-mbp>
 <20231023054456.GB11272@lst.de>
 <ZTaOzORdmFwxCW1c@kbusch-mbp>
 <20231024070759.GE9847@lst.de>
 <d3a0c5ff-8d10-aa8f-cfce-a87a09f880c3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a0c5ff-8d10-aa8f-cfce-a87a09f880c3@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 26, 2023 at 08:01:36PM +0530, Kanchan Joshi wrote:
> On 10/24/2023 12:37 PM, Christoph Hellwig wrote:
> > On Mon, Oct 23, 2023 at 09:18:36AM -0600, Keith Busch wrote:
> >> On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
> >>> Yes, you need someone with root access to change the device node
> >>> persmissions.  But we allowed that under the assumption it is safe
> >>> to do so, which it turns out it is not.
> >>
> >> Okay, iiuc, while we have to opt-in to allow this hole, we need another
> >> option for users to set to allow this usage because it's not safe.
> >>
> >> Here are two options I have considered for unpriveledged access, please
> >> let me know if you have others or thoughts.
> >>
> >>    Restrict access for processes with CAP_SYS_RAWIO, which can be granted
> >>    to non-root users. This cap is already used in scsi subsystem, too.
> > 
> > Well, that's sensible in general.
> 
> With that someone needs to make each binary (that wants to use 
> passthrough) capability-aware by doing:
> 
> setcap "CAP_SYS_RAWIO=ep" <binary>
> 
> Seems extra work for admins (or distros if they need to ship the binary 
> that way).

The way I usually see it done is add the capability to the user so any
binary executed by that user already has the caps.
