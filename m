Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25A79EC47
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbjIMPPL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjIMPPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 11:15:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C73CBD
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 08:15:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681ACC433C7;
        Wed, 13 Sep 2023 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694618105;
        bh=ozjc71/Y1N+yFoWByjrcbpH275Xjc3mq64DGj2vHBtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjmarMDE6NkAUGHDQlivnvtwhPnI4eQwDpAm+wO/Ik3q33AiEEL/eGo4phQGdHVUd
         7BrHofcmPBAk0VlIHrMCHvLZ4mSgFTt3mY66TqjoarTcpqp/pRKjAmMSLb467yjJcD
         jpnW/DvSYNiy1bZCeYo7JKXHrF27OWK5zLOIXo3wmY2MMZEAx3iM7l/xqlWD94UpKG
         +q1ccVZlNJRe+e02jytYZIxEXoc+PEkgtKM2a7/hPVmU8dS67gaqUNkxhXLmeKdJUE
         Pmf3wY1cXj5LPf++uWkk61STTP2i1Twix02m2HPYQdbG5hG8J9xWZodsz/m3l2jLZ1
         d+1l0fP52OzEA==
Date:   Wed, 13 Sep 2023 08:15:01 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me,
        =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQHR9eRDzzyRoV-z@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <20230913105015.GA30644@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913105015.GA30644@lst.de>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 12:50:15PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 12, 2023 at 02:47:33PM -0700, Keith Busch wrote:
> >  1 file changed, 29 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> 
> > +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
> 
> I don't think the NVME_CAP_CRMS_CRWMS check here makes sense, this
> should only need the NVME_CAP_CRMS_CRIMS one.

I think you're right, but we currently only enable CRIME if both are
set, so that would be a functional change snuck into this sanity check.
 
> > +	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> > +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> > +		u32 crto;
> > +
> > +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
> > +		if (ret) {
> > +			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +
> > +		/*
> > +		 * CRTO should always be greater or equal to CAP.TO, but some
> > +		 * devices are known to get this wrong. Use the larger of the
> > +		 * two values.
> > +		 */
> > +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> > +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> > +		else
> > +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
> 
> Should we at least log a harmless one-liner warning if the new timeouts
> are too small?

Felix had something like that in an earlier patch, but it would print on
every reset. That could get a bit spammy on the kernel logs, but I can
add a dev_warn_once() instead.
