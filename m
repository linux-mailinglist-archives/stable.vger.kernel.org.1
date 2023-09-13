Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1766579EC7D
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjIMPUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbjIMPUR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 11:20:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A6CE
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 08:20:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D906C433C8;
        Wed, 13 Sep 2023 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694618413;
        bh=OnjCgKC9sRBkyqkiWh4wZF7cKjcLN+SZjyqwvX/4gew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyD0pSGOtb6wNEQnS38laXi2vacZU3Ib9LL48ivvmkzb3VBVvhIetfeaIOPxv5D5T
         xrU5BdElUQhSglXcuHeJnlfxLQopt9LUC3I6sFHMZynDiAG+4Mgfc9MyHNsGHQsfUA
         /xr6ll/kYwbS3LlGw98J0I95FuoLqkUZFxPCL0R0cFvrx283AbOxhL3GEmVGHkvuRI
         hnKGSCIgOdIOwltE1RYNRGMibfJglNbP+Pv3pizLz2K76TRS0Y3gpt3ejAbJBfXHwq
         nZgaVeKlomZvbJLvYErplpwKnjNYQ673IO/gpnM4Wqe/hnknPWczLWo6ytgZzTxAej
         HQz8XB6/D7U5A==
Date:   Wed, 13 Sep 2023 08:20:09 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@meta.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQGqNZD9QweQQRmF@x1-carbon>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 12:25:29PM +0000, Niklas Cassel wrote:
> > +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> > +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> > +		else
> > +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
> 
> I saw the original bug report.
> But wasn't the problem that these were compared before NVME_CC_CRIME had
> been written?
>
> i.e. is this max() check still needed for the bug reporter's NVMe drive,
> after NVME_CC_CRIME was been written and CAP has been re-read?
> (If so, would a quirk be better?)

The values reported in CRTO don't change with the CC writes. It's only
CAP.TO that can change, so we still can't rely on CRTO at any point in
the sequence for these devices.
 
